Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C075C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 17:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpsoS-0005eL-22; Wed, 05 Mar 2025 12:45:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpso9-0005ce-Ld
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 12:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpso8-0000Gl-6k
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 12:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741196723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jbF/2D3x7fFzoU+Jr0qZvkfnmMKBdQi1+8U0uhbXJyE=;
 b=YpMsicbewE2R8Ync3HHWUaGBPpOcPDZK8Jvvr2fgrGBIV0sEXniuHnJiaLXMD4u6ObcnCk
 qSQwegoZ6/hMM+svATD9rIp54ZOqRWfzhQfoe7NA6RV8Qi0X3JP+ajh7NaPgnBzAmKueHv
 Qz3VHYCmyWUpQIgRndtYPWUjbYAetpg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-42UhdTowMA2rK7n8ATa1vw-1; Wed, 05 Mar 2025 12:45:22 -0500
X-MC-Unique: 42UhdTowMA2rK7n8ATa1vw-1
X-Mimecast-MFC-AGG-ID: 42UhdTowMA2rK7n8ATa1vw_1741196721
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390f6aa50c5so3352850f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 09:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741196721; x=1741801521;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jbF/2D3x7fFzoU+Jr0qZvkfnmMKBdQi1+8U0uhbXJyE=;
 b=VbmrgxHV2CflK3GvDbKjF93k7wKHwgkplUAiAK3c1/Mn8msUfVE1LYJPa/anhLVx9w
 TZsOzL4Ca6KqFfPvUvjTdDFblds9Ajq8yqZAv3EgvWtZoJSHiFGgLlya2EAV71K3yXmK
 OvZS1g2nvST+5yVDoxOmE1xwqgpWznQn5XvrwYekBf4EXKNVDXhYTPka8XwX1hgCmalM
 zrfwVuTWHDYJfmRmXqvsFpqj44iPr2ztrhh1+ZViVaHzC+4El8Bc655vKuHoV9ryd9iY
 eFlOq0cAnkPVJ+iCaqkyBVIAdMUWMpzYj/YI6R9fbNmhW1zcd+FvlkvUw/Jo7SI/YXYl
 e7MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrMEu/yUub2Mifc+tnDzJmuCA+P0wVYBXWIdhvd50A4NxupYB9heA5bgy4fZRH9wTY/hlAcuaaz4gc@nongnu.org
X-Gm-Message-State: AOJu0Yze623jrWAt6GExZjj6ztyrZzvrR0xSnmo6JDQt/O4XoVHcaOUU
 HoXS24gCnbVpILeFmsUHEdp5jte42e206LwBzZ68YJi3Zq4b/Y9dl7Ex+DZD0nP2RECBrfqDsDk
 sLWVCmdAMbVMSHgCg0ELFRBOfCJdO2fD0StDcf4Y6bNukgwv8EXJa
X-Gm-Gg: ASbGncuMpivFGlkPh2N0JIxEXcgCkbevtyT3kIwJhUHGH8KI62w2PchwsWIp/DmEjbe
 Q/VvfuKSNx1P9KvL1xq9rqFspo5oSzjKBe4TUre0lWGnLBWsJaIZjOVmJRormqQnCg8lviFlhry
 URU6akv4fYXR2auy40kcDS3ry06rZ37PBYSYn5/0OJQgIHjdc5wChO6BPvvEOe9d2sruMVjcgG0
 /ddTCtzdfScGXMIDYBR4pQ/mcVFf+8vuQwkLMU1fwe24EYXX/IFGAivz9J+EIA1p+tTMsSgJfNA
 Vtws57M+6syQ0YPFRnvueVp1m8kMNVWv9t0aj/D1R57j1uJibvFtDA==
X-Received: by 2002:a5d:6c6f:0:b0:391:13ef:1af5 with SMTP id
 ffacd0b85a97d-3911f7bd5ffmr4405098f8f.48.1741196720740; 
 Wed, 05 Mar 2025 09:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2T0AiFvN4HO3H+kykNMSX5B0LZBnkucL4GEmBXbiIVkUZqstqzCb4zox2Y+BO/IscfEx6WQ==
X-Received: by 2002:a5d:6c6f:0:b0:391:13ef:1af5 with SMTP id
 ffacd0b85a97d-3911f7bd5ffmr4405061f8f.48.1741196720398; 
 Wed, 05 Mar 2025 09:45:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484489esm22131455f8f.68.2025.03.05.09.45.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 09:45:19 -0800 (PST)
Message-ID: <ec8bd66a-ae3a-49c0-aed5-06a83e892491@redhat.com>
Date: Wed, 5 Mar 2025 18:45:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v6_00/36=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <4ea12608-ec9d-4eed-a20c-75f3ac6a5d0d@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <4ea12608-ec9d-4eed-a20c-75f3ac6a5d0d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/5/25 10:29, Cédric Le Goater wrote:
> Hello,
> 
> On 3/4/25 23:03, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> This is an updated v6 patch series of the v5 series located here:
>> https://lore.kernel.org/qemu-devel/cover.1739994627.git.maciej.szmigiero@oracle.com/
>>
>> What this patch set is about?
>> Current live migration device state transfer is done via the main (single)
>> migration channel, which reduces performance and severally impacts the
>> migration downtime for VMs having large device state that needs to be
>> transferred during the switchover phase.
>>
>> Example devices that have such large switchover phase device state are some
>> types of VFIO SmartNICs and GPUs.
>>
>> This patch set allows parallelizing this transfer by using multifd channels
>> for it.
>> It also introduces new load and save threads per VFIO device for decoupling
>> these operations from the main migration thread.
>> These threads run on newly introduced generic (non-AIO) thread pools,
>> instantiated by the core migration core.
> 
> I think we are ready to apply 1-33. Avihai, please take a look !

Applied to vfio-next with changes for documentation.

Avihai, I will wait for your input before sending a PR.

Thanks,

C.



