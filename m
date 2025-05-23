Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EA4C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 09:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIOwf-0002DH-Ph; Fri, 23 May 2025 05:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIOwc-0002Cz-MG
 for qemu-devel@nongnu.org; Fri, 23 May 2025 05:44:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIOwa-0006xZ-7f
 for qemu-devel@nongnu.org; Fri, 23 May 2025 05:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747993438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R53LZBFtn+7+Rz0HkLHtZEowsT4NHzpNRAlM3ReRoP0=;
 b=LDxmUt6Al9N+e3hJ1K++MjR5WPQkb1qo9MRkIuJNmoc4X3pzqwrtvNZPipaOzUkIwpF1I+
 iyfSPbFzBei7kbu41H0muVmhPoks5T8W7bEJAg9x1sPevkYTH7MeXNXtmufFbMNG8r9THz
 sCxUm1EoAcZaSsbS33ExL1K4PuEGgRc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-oxq_7bdfPTayMj2UfTFaLg-1; Fri, 23 May 2025 05:43:56 -0400
X-MC-Unique: oxq_7bdfPTayMj2UfTFaLg-1
X-Mimecast-MFC-AGG-ID: oxq_7bdfPTayMj2UfTFaLg_1747993435
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so46756895e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 02:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747993435; x=1748598235;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R53LZBFtn+7+Rz0HkLHtZEowsT4NHzpNRAlM3ReRoP0=;
 b=aOWcuCIqoWRdm97aFtGKmwzYpe/Kn+E5v4uiJdZ5Vm79t/tq65xLg4EWElRyLW7dcF
 ZIAA+6KQAU2xMolPgjqhg5R+5qPNz9swWlhOPQruwbVWZCkessiRURsYPJ8O6KU8ZN7g
 q5DHujKR/vkbGKFFMJe/s7GKbc5j+t7NMtK5zc4HqOVk+ytcZO3Jwsdw0jC+04i6aqUH
 0NkSoSVvWCrGhE65hsEcciPKH375C+8lT3yg8zVNgj9s44HFWzgCSFOznlq0UHwlBoOm
 tu3Y3L3QErkW9Bmz36oLCf2s5umwYc+GUTx6TAVxM5f85uYAWallrlHQdkPfzNK12KP6
 1ppA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfZjg25gFfrje9u8hbe2vWM+UIlGxgWJ1cfsdj3JbaUPlOzmqKrVh57B09gNB6kwuHoJRzprR86OsO@nongnu.org
X-Gm-Message-State: AOJu0YxhPlcLA+Lgsv2xbWwhBg/lKO/+MkgcR//5xA/DL6G56jiFlTd0
 craFJqysoJeVyPc6j3ztPJr2HV5TcyDbiFc+KFtvmsOIY8SV0B67eGl7XQCC1ehV8uThTqEaQ0b
 6iskiSMH09qINpPpxB63Y5LIE+lB8+tXk2hSbHtH2dL0EcEH55d8SQFZm
X-Gm-Gg: ASbGncua8d0j4d7xSAGsXxEXsAL1wqYHEmIRT4gr2EpoacZ58BWdOJXIBfwZZzgP8i0
 Aui8wrZv70+KA0Uhjrok0h1TDt+48FT/buB9wTiSx0sAuI1Pq0NTB9TEcZAGtOYv6oehUTfo49u
 M+bileSFYarVV83Qh2MzM2PIhe2QHP4GZhjKdpRThtBFBxDRFSrVPrcIkB/4pfN+DBNR/h/Bvtr
 eUo96+P4bsJ1IlLuQdw+zfnlps821cDbG7m9OJpgrB51txwxFJz/YYkd4/CIF3pNuWgrXlfeeFA
 gvbwfJ+yjM50CCetCS8=
X-Received: by 2002:a05:600c:6806:b0:442:f44f:66f with SMTP id
 5b1f17b1804b1-44b6ed452e0mr23482355e9.31.1747993434929; 
 Fri, 23 May 2025 02:43:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXrtkVg5OnAvf6x+IcokMwkQGLkuWnbob9HTy2TI6g4xsimqqO/9yBI/p0pqMZ+tWwZy4Nyw==
X-Received: by 2002:a05:600c:6806:b0:442:f44f:66f with SMTP id
 5b1f17b1804b1-44b6ed452e0mr23481965e9.31.1747993434476; 
 Fri, 23 May 2025 02:43:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1825457sm139828215e9.1.2025.05.23.02.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 02:43:53 -0700 (PDT)
Message-ID: <5a4579c4-2569-4642-99a2-23ae29aa80c6@redhat.com>
Date: Fri, 23 May 2025 11:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/16] virtio: introduce support for GSO over UDP
 tunnel
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
 <29808015-f8b3-4e18-8d1d-5280bda4ee3d@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <29808015-f8b3-4e18-8d1d-5280bda4ee3d@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
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

On 5/23/25 9:19 AM, Akihiko Odaki wrote:
> On 2025/05/21 20:33, Paolo Abeni wrote:
>> Some virtualized deployments use UDP tunnel pervasively and are impacted
>> negatively by the lack of GSO support for such kind of traffic in the
>> virtual NIC driver.
>>
>> The virtio_net specification recently introduced support for GSO over
>> UDP tunnel, this series updates the virtio implementation to support
>> such a feature.
>>
>> One of the reasons for the RFC tag is that the kernel-side
>> implementation has just been shared upstream and is not merged yet, but
>> there are also other relevant reasons, see below.
>>
>> Currently, the kernel virtio support limits the feature space to 64 bits,
>> while the virtio specification allows for a larger number of features.
>> Specifically, the GSO-over-UDP-tunnel-related virtio features use bits
>> 65-69; the larger part of this series (patches 2-11) actually deals with
>> the extended feature space.
>>
>> I tried to minimize the otherwise very large code churn by limiting the
>> extended features support to arches with native 128 integer support and
>> introducing the extended features space support only in virtio/vhost
>> core and in the relevant device driver.
> 
> What about adding another 64-bit integer to hold the high bits? It makes 
> adding the 128-bit integer type to VMState and properties and 
> CONFIG_INT128 checks unnecessary.

I did a few others implementation attempts before the current one. The
closes to the above proposal I tried was to implement virtio_features_t
as fixed size array of u64.

A problem a found with that approach is that it requires a very large
code churn, as ~ every line touching a feature related variable should
be modified.

Let me think a little bit on this other option (I hope to avoid
discarding a lot of work here).

>> The actual offload implementation is in patches 12-16 and boils down to
>> propagating the new offload to the tun devices and the vhost backend.
>>
>> Tested with basic stream transfer with all the possible permutations of
>> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support
>> and vs snapshots creation and restore.
>>
>> Notably this does not include (yet) any additional tests. Some guidance
>> on such matter would be really appreciated, and any feedback about the
>> features extension strategy would be more than welcome!
> 
> My proposal to add a feature to tap devices[1] simply omitted tests and 
> I wrote simple testing scripts for my personal usage. As you can see, 
> there is no testing code that covers tap devices, unfortunately, and I 
> think adding one takes significant effort.
> 
> [1] https://patchew.org/QEMU/20250313-hash-v4-0-c75c494b495e@daynix.com/

Thanks for the pointer

Paolo


