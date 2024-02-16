Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2408AC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 08:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ratud-00073F-N4; Fri, 16 Feb 2024 03:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ratuc-000735-FD
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 03:49:38 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ratua-0000VI-U7
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 03:49:38 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4124d5ab11aso1046045e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 00:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708073375; x=1708678175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TZkxSuTYrXl7wGkuiexBJl1zvE1x6GFi9aPqiuCa5GE=;
 b=cSg4efQgbRDQU7TRzl/rEvfJv4SCyxvnWq5EQRRutO3b505WfAcFwEb+gpC8+5LsD7
 2+EUsaFkytESIRra0Q/HUZyZfWD+X7NrKzKZQ7y+6bQV4L+jDnJctqFA5J+hYty73biN
 m9pqM8VaB4XjPWPFjXqVqk3gtVqvN94TkJkY2v+tiLjbvoT6gDBlifNnE9wLepQUvSfV
 y5q18ih4F88UduntqrXlcoWVEwCeRW5ooHwBEwv7kK3GzzBl/GGety5fc7BrQeEAP/4v
 gVdocwWWDezDkRINc4zuhHf6dUttAX86d8+DIXPhNXzoAP4WBk2W/Xax4aNxvtwzHQoH
 6Qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708073375; x=1708678175;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TZkxSuTYrXl7wGkuiexBJl1zvE1x6GFi9aPqiuCa5GE=;
 b=r6E32eMVVmBK1V/vj3AQNbnqEiVzjNfHfalxRDXmgrHvuzez4RIUUS3hYCmpaL7oGS
 5slx54Wt9kiiIx4iqhIJKa9mR5vkiAkiLoSFKlgnSOXn0BXW1uklxHdSdEjuyLv54bS7
 0KqlyxLUYFC6jhRZb5iJs1HmWVZH1j5mAnY40vr3r9BW9cfEDo/6UDiSC4eNGBeVpwjI
 4js33PzeuC4ofhgppTlilsByvOP1hulIe5zLOU8k6a56QNWyLHXk6E9kSzbdcs6eMGe2
 xZ8zv99T1V9HvUS9MDBRGdcs/Cq6wdtHPmZILTUm9iolZcWlYzzz68e+UCKEsB9MJJWS
 u4Tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv6bvVSdFudbCQSeezy7Kc/2yx5s5Th4AslWJyGzz+ddM/9cly5QcLPetze+XgP7upEMAYkPgrAReHXuaoUvfL0GFUB68=
X-Gm-Message-State: AOJu0YxAAveGKWOUpUQbAw8wy0I/jcELKMhlS2favo4zznsRw9KeP/rR
 7SdT9yOAzpv/M2uX45ddDYKDwmwPQC6iNumfHApjP49J8VNN8FTEPYIP5hzY94s=
X-Google-Smtp-Source: AGHT+IFr/Gk8+hpdkvWQ2HdbimoWu4upglze7TqlhkodUvgtcEGayMXjI/Ih3MdwiLHE5hN2SLT1mw==
X-Received: by 2002:a05:600c:4f43:b0:411:e86d:85a3 with SMTP id
 m3-20020a05600c4f4300b00411e86d85a3mr6321296wmq.16.1708073374732; 
 Fri, 16 Feb 2024 00:49:34 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a05600c19cc00b0041061f094a2sm1645204wmq.11.2024.02.16.00.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 00:49:34 -0800 (PST)
Message-ID: <a55d793c-3d61-4bda-8213-12a1de65c85f@linaro.org>
Date: Fri, 16 Feb 2024 09:49:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/vfio/common: Use RCU_READ macros
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Greg Kurz <groug@kaod.org>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C_=C3=A9_dric_Le_Goater?= <clg@redhat.com>
References: <20240124074201.8239-1-philmd@linaro.org>
 <20240124074201.8239-6-philmd@linaro.org> <7reip.7d0x82au0t9p@linaro.org>
 <887a8b74-423f-4c4c-8cdd-d29fcb4f14b8@linaro.org>
Content-Language: en-US
In-Reply-To: <887a8b74-423f-4c4c-8cdd-d29fcb4f14b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24/1/24 15:09, Philippe Mathieu-Daudé wrote:
> On 24/1/24 10:25, Manos Pitsidianakis wrote:
>> On Wed, 24 Jan 2024 09:42, Philippe Mathieu-Daudé <philmd@linaro.org> 
>> wrote:
>>> Replace the manual rcu_read_(un)lock calls by the
>>> *RCU_READ_LOCK_GUARD macros (See commit ef46ae67ba
>>> "docs/style: call out the use of GUARD macros").
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> hw/vfio/common.c | 34 ++++++++++++++++------------------
>>> 1 file changed, 16 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 4aa86f563c..09878a3603 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -308,13 +308,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier 
>>> *n, IOMMUTLBEntry *iotlb)
>>>         return;
>>>     }
>>>
>>> -    rcu_read_lock();
>>> +    RCU_READ_LOCK_GUARD();
>>>
>>>     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>>         bool read_only;
>>>
>>>         if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
>>> -            goto out;
>>> +            return;
>>
>> Since this is the only early return, we could alternatively do:
>>
>> -         if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
>> +         if (vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
>>
>> remove the goto/return, and wrap the rest of the codeflow in this if's 
>> brackets. And then we could use WITH_RCU_READ_LOCK_GUARD instead. 
>> That'd increase the code indentation however.
> 
> If the maintainer agrees with the style & code churn, I don't
> mind respining.

Alex, Cédric, any preference?

> 
>>
>>>         }
>>>         /*
>>>          * vaddr is only valid until rcu_read_unlock(). But after
>>> @@ -343,8 +343,6 @@ static void vfio_iommu_map_notify(IOMMUNotifier 
>>> *n, IOMMUTLBEntry *iotlb)
>>>             vfio_set_migration_error(ret);
>>>         }
>>>     }
>>> -out:
>>> -    rcu_read_unlock();
>>> }
> 
>> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> 
> Thanks!


