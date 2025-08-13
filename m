Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA06CC87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 07:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um5Sc-0004fp-K8; Wed, 13 Aug 2025 02:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1um5Sa-0004fE-3v
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 02:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1um5SS-0002VC-MS
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 02:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755068372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZoS6Vxq8KvhnpsEItfw39OYdBycSE/u8l+Dm4BKNtRo=;
 b=QNik6OtB0Y94FrBVYy0vNV9RO6BGOsLhjhkN2BY5cytUDZwIpj/CqBy5n+FeppexAgOCeQ
 SKgEsJSkMDYTCNnMB+XtXxwqNCc50sQ1RkI5oMehR5m/crBTbQp2WlYSybpoKMiJKqrbd3
 ZNSdx2ZrkvaVj4R4oyPtWXhnWtq3T8s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-tl3_al9GOtaDtwLz_kvZlA-1; Wed, 13 Aug 2025 02:59:30 -0400
X-MC-Unique: tl3_al9GOtaDtwLz_kvZlA-1
X-Mimecast-MFC-AGG-ID: tl3_al9GOtaDtwLz_kvZlA_1755068370
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7e69dbe33faso1461933485a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 23:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755068370; x=1755673170;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoS6Vxq8KvhnpsEItfw39OYdBycSE/u8l+Dm4BKNtRo=;
 b=E4M49YK6gamrgjypuomQrFhzeB507H6RTob4MU5jflBsoDowCu3AQiOtPKQLnKuz61
 uaL2p2yB4PMwBjDB1GVuZb0CclB13eOSgZm57/1/kYGPc7zj9fdMMA9JOfnIynj5EN5d
 C6bfEHlbPPuaQIYIsgX3VeH1YySqNnlzwqsqRtTT+YMoeUksoXdhFYFVuV08IZRehD26
 J3fup92vHjm7OxqGfzHvlLHYRdXFfzFRr/Fi14QGQAdxnuiqGQxy4As1TaVrAezzrLWn
 13gg8eiArekHous1EIapBogd5GC7abhU+LLov0TchgCJHul9OQ+SpoUPF/vUNVe5sCzI
 GuaQ==
X-Gm-Message-State: AOJu0YzURG7n3Rlw1eQH12e+MS5dgfXzuCWPi0OfX/vjzKx5F8qb3lI7
 Zrn2poIh2m+Gb2E0v/7qNihF1nNbCotritdKcsrHg3iBvBi/atBN3ITLh8zFrGCDLh+/M3Qno4b
 i+FWIfTPbvzrCItfqrOcbGr/Rp/mcXCMg6KH7BrckNPgWbFn+m1tNB/ZG
X-Gm-Gg: ASbGncvf9RBQ5cRZaM9t9tv6TXojfrTA28KeDeJPrib7RMzCtHKtry7AOLNpdyQ1dzo
 NlCK2vXy7TXnFSW0tvZsdszahwEAbtzMoE7gidd9urBg59v1cBbtppBQA3Ova9ieX2pFdcY/6Dr
 +8fWu1YQjZwT51cF59E5xoCqFi1PsqH5/DTHQN5gGutlE9Ug0LAOGe3BwhYFI2SEI4PuC6WaDGj
 00rexzC0DBpF35sfi/YhP3wce+jsEha+GvPS9J9JEs6oYSl1VcZN2JYicIjz/dGkE21NFwlnEuL
 PwxTGGZ8Vr75oJMg7eoGkXroRTqc9zav8SOL8CF3TA==
X-Received: by 2002:ae9:ee05:0:b0:7e8:589e:1724 with SMTP id
 af79cd13be357-7e865280dc3mr221343485a.27.1755068370264; 
 Tue, 12 Aug 2025 23:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl8mwoGye/jGrX8pgcm0RcEWoY/bugiYBrdC8QKJFsT53ttR0PhrR9D8T1hsJ9q+ists+MGQ==
X-Received: by 2002:ae9:ee05:0:b0:7e8:589e:1724 with SMTP id
 af79cd13be357-7e865280dc3mr221342285a.27.1755068369867; 
 Tue, 12 Aug 2025 23:59:29 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.133])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e80c0e6ff2sm1327949685a.30.2025.08.12.23.59.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 23:59:29 -0700 (PDT)
Message-ID: <d80b29c3-b6c9-4c92-826e-00720acfc204@redhat.com>
Date: Wed, 13 Aug 2025 08:59:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/14] virtio-pci: implement support for extended
 features
To: Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1753297661.git.pabeni@redhat.com>
 <8e8a91adcbf4e37c7a5e086780e1000d3b3298d3.1753297661.git.pabeni@redhat.com>
 <de3c69a8-d874-44a3-bd47-91b6b298e184@rsg.ci.i.u-tokyo.ac.jp>
 <7c7c3f2c-e643-46ad-810c-aefdd486ad78@redhat.com>
 <8e3c5aa3-3180-4df2-b378-18e3e91d3f80@rsg.ci.i.u-tokyo.ac.jp>
 <CACGkMEse8cM8=8y4JwBdVQi23buz1OCzhQmVxvsRJGdQ9tgaWA@mail.gmail.com>
 <73f8b2dc-d5ad-43b7-834f-6322bfe617af@rsg.ci.i.u-tokyo.ac.jp>
 <CACGkMEuP10o6dBGpyrNuLamKmd+OLiadp2TQKSkdG-Zr-2kk0A@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEuP10o6dBGpyrNuLamKmd+OLiadp2TQKSkdG-Zr-2kk0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/13/25 7:55 AM, Jason Wang wrote:
> On Tue, Aug 12, 2025 at 4:03 PM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2025/08/12 13:01, Jason Wang wrote:
>>> On Fri, Aug 8, 2025 at 12:55 PM Akihiko Odaki
>>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>>
>>>> On 2025/08/08 5:18, Paolo Abeni wrote:
>>>>> On 7/26/25 1:52 PM, Akihiko Odaki wrote:
>>>>>> On 2025/07/24 4:31, Paolo Abeni wrote:
>>>>>>> @@ -1477,6 +1509,13 @@ int virtio_pci_add_shm_cap(VirtIOPCIProxy *proxy,
>>>>>>>         return virtio_pci_add_mem_cap(proxy, &cap.cap);
>>>>>>>     }
>>>>>>>
>>>>>>> +static int virtio_pci_select_max(const VirtIODevice *vdev)
>>>>>>> +{
>>>>>>> +    return virtio_features_use_ex(vdev->host_features_ex) ?
>>>>>>> +           VIRTIO_FEATURES_NU32S :
>>>>>>> +           2;
>>>>>>
>>>>>> This function could be simplified by replacing VIRTIO_FEATURES_NU32S
>>>>>> without any functional difference:
>>>
>>> Did you mean using VIRTIO_FEATURES_NU32S instead?
>>>
>>>>>>
>>>>>> 1. For writes: virtio_set_features_ex() already ignores extended
>>>>>> features when !virtio_features_use_ex(vdev->host_features_ex)
>>>>>> 2. For reads: When !virtio_features_use_ex(vdev->host_features_ex), the
>>>>>> upper bits of host_features_ex are zero, and guest_features upper bits
>>>>>> remain zero (since they can't be set per point 1)
>>>
>>> I think it depends on the compatibility work which hasn't been done in
>>> this series.
>>>
>>>>>>
>>>>>> So the conditional logic is redundant here.
>>>
>>> See below
>>>
>>>>>
>>>>> This is to satisfy a request from Jason:
>>>>>
>>>>> https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05291.html
>>>>> https://lists.gnu.org/archive/html/qemu-devel/2025-07/msg05423.html
>>>>>
>>>>> I agree there will not be functional differences always accessing the
>>>>> full space, but the guest could still be able to notice, i.e. the
>>>>> extended space will be zeroed on read with that patched qemu and
>>>>> untouched by the current code and this patch. To be on the safe side I
>>>>> think it would be better to avoid such difference, as suggested by Jason.
>>>>>
>>>>> Does the above make sense to you?
>>>>
>>>> By functional, I meant the functionality of QEMU, visible to the guest,
>>>> rather than the whole system including the guest, visible to the end
>>>> user. The guest cannot notice the difference because the extended space
>>>> is zero on read even without the conditional, which is described as
>>>> point 2 in the previous email.
>>>
>>> I'm not sure I understand this correctly. But it doesn't harm here consider:
>>>
>>> 1) it's the entry point from the guest, checking and failing early is
>>> better than depending on the low layer functions
>>> 2) we have checks in several layers (both virtio-pci and virtio core).
>>>
>>> And it looks like a must for at least GF:
>>>
>>>      case VIRTIO_PCI_COMMON_GF:
>>>          if (proxy->gfselect < virtio_pci_select_max(vdev)) {
>>>              uint64_t features[VIRTIO_FEATURES_NU64S];
>>>              int i;
>>>
>>>              proxy->guest_features[proxy->gfselect] = val;
>>
>> I missed proxy->guest_features. Indeed it makes a difference.
>>
>> Now I have another concern with virtio_pci_select_max(). If the feature
>> set grows again, virtio_pci_select_max() will return the grown size for
>> the devices that have [127:64] bits, which will be a breaking change. In
>> this sense, VIRTIO_FEATURES_NU32S, which will grow along with the
>> feature set, is not appropriate here.
> 
> Things will be fine if we do the compatibility work correctly, so host
> "host_features_ex_ex" won't contain anything for the legacy machine
> types.
> 
> But I'm not sure it's worth worrying about it now considering we take
> years to reach 64.

FTR, I gave a shot to the last option mentioned by Akihiko - make
virtio_pci_select_max() future proof - and the implementation complexity
is almost the same of the current one, so I guess I'll opt for such a thing.

Cheers,

Paolo


