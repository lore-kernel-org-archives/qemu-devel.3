Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B336C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 20:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpvMm-0005oT-Qn; Wed, 05 Mar 2025 15:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tpvMk-0005ma-HZ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 15:29:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tpvMh-00078t-0E
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 15:29:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741206551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+nn330fqElfp03cO80gRuIB8WqCj8lLFoAbxdN4NgOw=;
 b=bQ4GmeTeFeohtRByigKVnhZpGOgzMs9WSjUE/m9zG/AfaBoPasRWqxSC84nWOqwMyb4sFx
 M7Amzm5Co+pZs/v74ULhbGyydw6jo/dI0x82Kyflc8RD0RzWx2ZLqzdAagv0qN5qCf8p6a
 73rPtDa+QfGMzO4CH094skFB+T+31vY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-vJzXcY_6PNOznt59IFzE3Q-1; Wed, 05 Mar 2025 15:28:58 -0500
X-MC-Unique: vJzXcY_6PNOznt59IFzE3Q-1
X-Mimecast-MFC-AGG-ID: vJzXcY_6PNOznt59IFzE3Q_1741206537
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c3cca5d865so225766685a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 12:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741206537; x=1741811337;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+nn330fqElfp03cO80gRuIB8WqCj8lLFoAbxdN4NgOw=;
 b=Tn3ZW7InhSMDThKdPLuwDM7xUSKN0ccI+VuN9Nt6+01Sz5MR2aOlmZLTZi6OCcvhtd
 gDT7mF6kABW/cD7hA5txhOg6pb6KziGSYElfy3UzJ/4Jt/4PdWJRET75gn1vrFqUl+ot
 BWE42DQR0Fhi6QPQiESPBAcc6iNSaqBrOz/OucTPIdPkbvX8SDHoVhUFFoLBpg7NA/QP
 VBvrClu33zEEB13TmKWhWOMBEEESXB0DE3A7X/XFrCJfYv1XRFHJbTo6k1hoI/uO4UKx
 f7mRlHEv1YCe4ZZrjL7pVU79VyeTAmVndXEOAedpXaQPqXNwR3l3KShKZ6gFWPC5UdZU
 sobw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxEsX4nuw0MBA8JUZ7pdWr1RlyDa5/Sx35JUXI1qexDd9gZsVfkWnPHI29wVGdQiklq1oHmZWrQIAo@nongnu.org
X-Gm-Message-State: AOJu0YxsKtIQjsIey24qVOZbm1OBagT/8zTBL8Sxs1P/EkDh5Z2ljMjn
 N0DZ3S3kbiJAhqsL7//EwpCqQT6BIF54LwjL0aa6jwCbZIoI05ZiVCN5Vl3/OrPRsz8FEuR/NsF
 seDMKSU1JXbvbWWKZCLmJRYlPZZaIfkADYfPAiIaOH2oM20pUU6Tm
X-Gm-Gg: ASbGncugnV5SLUGONlxAVyr5w5jWeEjMRgHThaB0GEc3hsPEAXn1RJ78mE5Jgk1PcgJ
 qoIQvYKFaZCf+2+RvWJvhoIXxtvnLVlvOQB3yi07zZMiI0rF7kiClfMWfTPQPvbrC+5juVJKwJQ
 ABESC2vKo3CyFKp5g7GUJAaRQ/PgV93TFL7joiiVkw0r0ZwWV3zqM1k/exWmkbDP9U3gChq97CP
 l970dA2sDRwXXAqvVmQFYTeq/0pVV0gQcVyhVUhUuWifd1c8Y/vUW1C/No/CEyuvSI8TFIjYFQR
 teelMOZ4j+OhKSNv
X-Received: by 2002:a05:620a:6285:b0:7c0:b350:820 with SMTP id
 af79cd13be357-7c3e39b1392mr108098985a.5.1741206537620; 
 Wed, 05 Mar 2025 12:28:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaFpm3XdjhvzKIqBrzYyHIuRA6tJwcHnsz3Q84K2EFrriPFMhlE9uTUegj0PW3iC9KcadP5A==
X-Received: by 2002:a05:620a:6285:b0:7c0:b350:820 with SMTP id
 af79cd13be357-7c3e39b1392mr108096885a.5.1741206537326; 
 Wed, 05 Mar 2025 12:28:57 -0800 (PST)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c378d9e3f9sm924417585a.76.2025.03.05.12.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 12:28:56 -0800 (PST)
Message-ID: <24e0aff1-f95d-4da5-abc9-a16e71d0a4ac@redhat.com>
Date: Wed, 5 Mar 2025 15:28:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Content-Language: en-US
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, Wei.Huang2@amd.com, kraxel@redhat.com, bsd@redhat.com,
 berrange@redhat.com
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <c8adb591-c4e5-4658-9b87-cb11d75c143f@redhat.com>
 <61205b17-3556-45d5-87b2-347a9b2c2b69@amd.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <61205b17-3556-45d5-87b2-347a9b2c2b69@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
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



On 3/4/25 9:56 PM, Suthikulpanit, Suravee wrote:
> 
> 
> On 3/5/2025 6:02 AM, Donald Dutile wrote:
>> Hi Suravee!
>>
>> Not your issue, but wondering if others know:
>>
>> Why isn't this an issue for Intel-vtd-iommu & ARM-SMMUV3 ?
>> Are they instantiated as non-PCI-id (platform) devices, but AMD puts their IOMMU in PCI space?
>>
>> Adv. thanks for the info.
> 
> Unlike AMD IOMMU, Intel VT-d IOMMU and ARM SMMUV3 are not enumerated as a PCI device in the system.
> 
> Thanks,
> Suravee
> 
ok. thanks for confirmation.
--dd


