Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279F3C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 11:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIQEl-0000yx-Ab; Fri, 23 May 2025 07:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIQEd-0000x9-HS
 for qemu-devel@nongnu.org; Fri, 23 May 2025 07:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIQEZ-00083T-1o
 for qemu-devel@nongnu.org; Fri, 23 May 2025 07:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747998394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MSR7vn5/eSOUS08HELYnhgS/9GIHeCDgwbu8MEeBg+U=;
 b=H2tonRMeSO8/p0fu91gTI9FK2n0hxYKMZ8hSSbic1G9NuLqU6LuKTtPCxZ17yI8FtdwQIg
 CwAc14elHWaeptp7xJH60/ulx3aK6xvduvW2xYheGrDFDSnNU8gJEe8oNgp3ZhIecz9+U3
 T9vRE1cV+yu3mKweBJX+ekZgtntqMjo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-2bc895pzNsuzfWJ680rsWg-1; Fri, 23 May 2025 07:06:33 -0400
X-MC-Unique: 2bc895pzNsuzfWJ680rsWg-1
X-Mimecast-MFC-AGG-ID: 2bc895pzNsuzfWJ680rsWg_1747998392
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441d438a9b7so4267265e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 04:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747998392; x=1748603192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MSR7vn5/eSOUS08HELYnhgS/9GIHeCDgwbu8MEeBg+U=;
 b=kxagKX7wTdRCXCQgyUBp+dul2mFYHu6ejcEFWtsX/GzU1keEVzhYDl04zcw156vU5z
 5v1cpuH2oA3o3jcpeDWXlGk8S6TE6t26bcxlQ+odOCrUQhneV41uGI0ZhryBoTKRDIws
 T7FNMShst4COCslEPgAS7YXIDmGZAVPqPXrBbmFks62eiN9nU0shzhrdAEyvdwQBSRe7
 DgKLOANlwvr5z6nwXgXLNipQePTYDJNZKdlUHM/+uM5xVweJ7HoB7shEz0GIUNXdWYpS
 RC3FuZ0sPaVdiETKOsxGW3zmfA4Y/kIY0bnyw0gxujuxQptNUZm5fuJbbCO/qUf6NHzl
 Zvpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfy+wLEYL3fDHFzKS9TwgFZxUpH23liKoKoHqO5YSZdKAdt/h4jB2V+WNuSa72VbuQDhMrNiOrVoJb@nongnu.org
X-Gm-Message-State: AOJu0YzstykFVFqcsrWNryMUTVLARznOUZ/4ypgx8M0FsnCNYu1309ZK
 ESo67rjDmOKTnM5QFmf1Gn8x6RnEz8Tu1E5y4h3JLJy6LYNt5i/d74cx4SNPcCRs0LlbFQmfSLc
 wOSeF6ELlm/pQYZ9hNU3wO4TPhX4uAOOPQQzAnKm3XarC5nCJBLj+HAkU
X-Gm-Gg: ASbGncs7qeErsT7SpAAQ2n0ChhCGorB1qHib6RKppuxtM6LCTJmGGl+Gj92IYwAP//f
 4ngmDosAGl6HW5uXTSapnyBiUpajHQFSOdGDuQqoZIIHVL5UtccoqRVF8kugncOvN4tpvEnBZM8
 gCS0RyOk4IYCe9S6n7UsxYO6sDrr5VVdevoMYfH8OXYSQDzrj7vBIjMZdDpKORe2+qmOsYMydQE
 ebL2WO+IoWnXkaHreRqsuc3+dD94osr+rOg30VyohnjY8NQOwppw/wm5M5ypw0SajDE7yr/Jksc
 r5snDYtoeAY8EsFtY80=
X-Received: by 2002:adf:a1ca:0:b0:3a3:728b:b8f0 with SMTP id
 ffacd0b85a97d-3a4c14f78d6mr2264878f8f.8.1747998391825; 
 Fri, 23 May 2025 04:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8Xn/lCP/waTsdMlJ34Ax+CzEoPkcoGqOLQYJ+SUTUZ1DiMusV0VZ8XUGRq19XSDd+74Pgdw==
X-Received: by 2002:adf:a1ca:0:b0:3a3:728b:b8f0 with SMTP id
 ffacd0b85a97d-3a4c14f78d6mr2264856f8f.8.1747998391416; 
 Fri, 23 May 2025 04:06:31 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a367205338sm22767541f8f.98.2025.05.23.04.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 04:06:30 -0700 (PDT)
Message-ID: <cf5640a1-bbf4-4324-a4fa-09e33f9435d4@redhat.com>
Date: Fri, 23 May 2025 13:06:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/16] net: implement tnl feature offloading
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <3ee26dacd91d6c12ae4fc64bc42890553739a2fe.1747825544.git.pabeni@redhat.com>
 <0aba4f0d-f6e8-4c46-a183-eebb401c13a2@daynix.com>
 <3277a9a5-10a7-49a9-901d-cdeef503b1d1@redhat.com>
 <0ddd6a2f-55b4-4356-8881-6744580fafd7@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0ddd6a2f-55b4-4356-8881-6744580fafd7@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/23/25 12:54 PM, Akihiko Odaki wrote:
> On 2025/05/23 19:40, Paolo Abeni wrote:
>> On 5/23/25 10:16 AM, Akihiko Odaki wrote:
>>> On 2025/05/21 20:34, Paolo Abeni wrote:
>>>> @@ -890,6 +915,12 @@ static void virtio_net_apply_guest_offloads(VirtIONet *n)
>>>>           .ufo  = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_UFO)),
>>>>           .uso4 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO4)),
>>>>           .uso6 = !!(n->curr_guest_offloads & (1ULL << VIRTIO_NET_F_GUEST_USO6)),
>>>> +#ifdef CONFIG_INT128
>>>> +       .tnl  = !!(n->curr_guest_offloads &
>>>> +                  (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO)),
>>>> +       .tnl_csum = !!(n->curr_guest_offloads &
>>>> +                      (1ULL << VIRTIO_NET_O_GUEST_UDP_TUNNEL_GSO_CSUM)),
>>>
>>> "[PATCH RFC 14/16] net: bundle all offloads in a single struct" added a
>>> struct for offloading, but how about passing n->curr_guest_offloads as
>>> is instead?
>>>
>>> It loses some type safety and makes it prone to have unknown bits, but
>>> omitting duplicate these bit operations may outweigh the downside.
>>
>> I *think* that one of the relevant point about the current interface is
>> that qemu_set_offload() abstracts from the virtio specifics, as it's
>> also used by other drivers. Forcing them to covert the to-be-configured
>> offloads to a virtio specific bitmask sound incorrect to me. Possibly I
>> misread your suggestion?
>>
>> [...]
>>>> diff --git a/net/tap-linux.c b/net/tap-linux.c
>>>> index aa5f3a6e22..b7662ece63 100644
>>>> --- a/net/tap-linux.c
>>>> +++ b/net/tap-linux.c
>>>> @@ -287,6 +287,12 @@ void tap_fd_set_offload(int fd, const NetOffloads *ol)
>>>>            if (ol->uso6) {
>>>>                offload |= TUN_F_USO6;
>>>>            }
>>>> +        if ((ol->tso4 || ol->tso6 || ol->uso4 || ol->uso6) && ol->tnl) {
>>>
>>> Is it possible to have ol->tnl without TSO or USO? If so, is ignoring
>>> ol->tnl really what you want?
>>
>> The virtio specifications actually prevent setting UDP-tunnel offload
>> without any other "inner" offload (TSO or USO), as it makes little to no
>> sense (the stack can't GSO/GRO the outer header without doing the same
>> for the inner).
>>
>> Does the above makes sense/answer your questions?
> 
> The code implies the following:
> 1a. ol->tnl may be true while TSO and USO are disabled.
> 2a. It is defined as no-op in such a case.
> 
> But the reality is as follows:
> 1b. ol->tnl being true while TSO and USO are disabled is an error.
> 2b. The consequence is undefined in such a case.
> 
> In that case, virtio_net_get_features() should report the error for 1b, 
> which will prevent the error condition from reaching to 
> tap_fd_set_offload().
> 
> Making the error condition no-op in tap_fd_set_offload() does not make 
> it (more) correct as the consequence is undefined anyway (2b). It may 
> simply ignore the condition under the assumption that it will never 
> happen or assert that assumption.

I see. I'll add the sanity check in virtio_net_get_features() and will
add an assert in the tap code.

Thanks!

/P


