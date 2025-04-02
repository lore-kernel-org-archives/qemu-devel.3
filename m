Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9450C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzxvB-00034z-Te; Wed, 02 Apr 2025 09:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tzxv5-00034G-JM
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tzxux-0007it-Oe
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743599644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l8z8gq3A8Gc54zqI5CObgZ1nkvr4izNsvP0dzFBAVnc=;
 b=cGLxgCKBa4mQoRIdZ+5Aor6PLy/q9hm/pW5qfINyfoHE03D8CuJnA2BxYfQLuyt1dTjus5
 1TDYp2LJ6CHjV6wdtvTSk1dRAYtaIva7Av7Dzo8jZKz7Sav4w/qZw0M+6GBQHP/cVHcZj4
 dJ5QgxYvod4JELN8/vjzGtCmk2Ih36k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-Ula4QoLyNAC8B1Kt79LyOQ-1; Wed, 02 Apr 2025 09:14:03 -0400
X-MC-Unique: Ula4QoLyNAC8B1Kt79LyOQ-1
X-Mimecast-MFC-AGG-ID: Ula4QoLyNAC8B1Kt79LyOQ_1743599642
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so41202975e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 06:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743599642; x=1744204442;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8z8gq3A8Gc54zqI5CObgZ1nkvr4izNsvP0dzFBAVnc=;
 b=Sc3FcUDjTk8S39mPtlvIukRNQCIt3UJrlF8Hhf1I7Hbt+E+8aVAU5h+1hrKkJqUaIJ
 JKF3ztgPhGvsrQdSZkVUyCSYbGX3irnUuFd/dTQVATzkSOR1E+z5ht7i6RxZ8S8GSJjz
 EIvkxNljuD+Zh1k5bnTfRidHigFh5V8bpNAVE0nS2suExHk61FkP9q0Ld1uheeMHbCjA
 jge8Fp2p3UfrLaYi1vFSH3WF90QSD3wCXy46xLOeqUer+xhNy92HoiQFtSm41ISV6yCR
 PXOb2iXL/oeaf+yds/AOPrwXuxYHiDlkXMHWrs6m/ywr9UeiTrK4UPiEmGNaDdkM1yVh
 0gIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPJfZRvonuf40GbU7SVMtmEThTPal10H5mJv5ZoWZtywQ2dZ+5FMOaC0AN0q8UDpSsK6sclofsaSVz@nongnu.org
X-Gm-Message-State: AOJu0YyC04SKSEUN6730yQMqTIYalvf6QgkcqmT4VApiwCEsRzo5qg1B
 jY3IFWIAsH539+lhehhS0HW1greqRhp17y+EIoz+s/z51Fnb6Z0Nda0UmFVoZSB/6FxYJjvHN3a
 O/WULgAnC+WVRBT6WWAJaovYrDXkkSc9k2Q8WdbsxQqjEYCAEZ5GJ
X-Gm-Gg: ASbGncvMMgvlJQ4JCmlkzvHnZJsf6pQoyoAIGYd9h/QnRoiR69uJMM44SZNxyvP3ng3
 5Er4f1iT7wOh3OS21uFekQIDyDR8lzkx6pnO9NNYEzhhYUyDYpwhWajHRAz/dqspiQsBRnP/fwT
 gwG7EJs1rJTsSiUT4ZOk5QMV7H1scz4KF9lf+t4FI7PmPvDQAsUiFMIZpiax9Hr9qrKG5wswE6R
 osabTMV7/es2XyQ5ZJTQckl2kPWyyNluPoFiq1fs51ijLvTMhJASYOiL+1fDpbNNm71Br7Hq0Fg
 73JV9MoJCecRK428bl6lDRBGu24z0DECFBoka+Wss/s9r0UTEInURA==
X-Received: by 2002:a05:6000:18af:b0:39a:c9d9:877b with SMTP id
 ffacd0b85a97d-39c120e3539mr14491219f8f.27.1743599641852; 
 Wed, 02 Apr 2025 06:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDjLkY4m98unb6DwRt+GoewlahEbVjj3nSttgiPkpCLqK/+Mr/AKFW8AJDDwB4BJE3tu4npw==
X-Received: by 2002:a05:6000:18af:b0:39a:c9d9:877b with SMTP id
 ffacd0b85a97d-39c120e3539mr14491194f8f.27.1743599641461; 
 Wed, 02 Apr 2025 06:14:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66d29csm17184876f8f.60.2025.04.02.06.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 06:14:00 -0700 (PDT)
Message-ID: <7ecd061d-e015-40a3-90ee-085cc6b2d34f@redhat.com>
Date: Wed, 2 Apr 2025 15:13:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio/migration: Add also max in-flight VFIO device
 state buffers size limit
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <2b2469939198c2f31dba33b284576d2df22697b7.1741344976.git.maciej.szmigiero@oracle.com>
 <abc049f2-3497-4557-89c8-74bcfaea221c@redhat.com>
 <3826d47f-d79b-4db2-9719-35f48f582bf0@maciej.szmigiero.name>
 <fc547687-b313-404c-a6a6-dd599b0a9dbc@redhat.com>
 <f18c4158-b2e8-4be0-80e2-0808f22f027c@maciej.szmigiero.name>
 <e37d9c4a-cb22-4b36-b74f-23246c6a995f@redhat.com>
 <5e6ed402-760c-4cae-a506-5a355927ced1@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <5e6ed402-760c-4cae-a506-5a355927ced1@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On 4/2/25 14:40, Maciej S. Szmigiero wrote:
> On 2.04.2025 11:51, Cédric Le Goater wrote:
>> Hello Maciej,
>>
>> On 4/1/25 14:26, Maciej S. Szmigiero wrote:
>>> On 11.03.2025 14:04, Cédric Le Goater wrote:
>>>> On 3/7/25 14:45, Maciej S. Szmigiero wrote:
>>>>> On 7.03.2025 13:03, Cédric Le Goater wrote:
>>>>>> On 3/7/25 11:57, Maciej S. Szmigiero wrote:
>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>
>>>>>>> There's already a max in-flight VFIO device state buffers *count* limit,
>>>>>>
>>>>>> no. there isn't. Do we need both ?
>>>>>
>>>>> This is on a top of the remaining patches (x-migration-load-config-after-iter
>>>>> and x-migration-max-queued-buffers) - I thought we were supposed to work
>>>>> on these after the main series was merged as they are relatively non-critical.
>>>>
>>>> yes. we don't need both count and size limits though, a size limit is enough.
>>>>
>>>>> I would also give x-migration-load-config-after-iter priority over
>>>>> x-migration-max-queued-buffers{,-size} as the former is correctness fix
>>>>> while the later are just additional functionalities.
>>>>
>>>> ok. I have kept both patches in my tree with the doc updates.
>>>>
>>>
>>> I don't see the x-migration-load-config-after-iter patch in upstream QEMU
>>> anywhere.
>>> That's a bit concerning since it's a correctness fix - without it the
>>> multifd VFIO migration on ARM64 can fail.
>>>
>>> The existing patch still applies, but requires changing
>>> "#if defined(TARGET_ARM)" to "strcmp(target_name(), "aarch64") == 0" due to
>>> recent commit 5731baee6c3c ("hw/vfio: Compile some common objects once").
>>>
>>> I can submit an updated patch if you like.
>>
>> It is a bit early.
>>
>> Let's wait for the spring cleanup to be applied first. I am waiting for
>> more feedback from Avihai and Joao. It should not be long.
> 
> I guess by "spring cleanup" you mean this patch set:
> https://lore.kernel.org/qemu-devel/20250326075122.1299361-1-clg@redhat.com/
> 
> It is marked "for-10.1" while I think we should not have this ARM64
> regression in 10.0, which is due to be released in 2-3 weeks.

A regression would be mean the feature worked before which is not case,
it didn't exist.


As said before, I'd rather expose the initial "multifd support for VFIO
migration" feature first without workarounds in QEMU 10.0.

Support on ARM is broken not because we are missing support in VFIO
but because there is an issue in the ordering of device states on ARM.
IMO, this needs to be addressed with a larger crowd. Please include
migration maintainers, the virt ARM maintainers, GIC maintainers and
let's see what can be done to avoid a workaround during the QEMU 10.1
cycle.

VFIO migration is a recent feature. VFIO migration support on ARM
(for MLX5 VFs) is even newer (there were recently fixes in the
upstream kernel for it). If a distro needs support for it, your
patch is there and ready to be backported. So there is a plan B.
Let's not rush things please.

Thanks,

C.


