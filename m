Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E07C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoTp-000771-9k; Wed, 21 Feb 2024 10:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcoMz-0001hh-9X
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:18:50 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcn0I-0003sQ-Qs
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:51:20 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-512d8950e3dso98316e87.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 05:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708523476; x=1709128276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HEdcTKEHO7Z7HcRMsNBjBNfl1WQ6V2HgRZLHF7lFnyY=;
 b=o4bMPC1v5vWknJ8bdRST+YpTUsPgIkzJS2Yhy4PiSgTvwCNsUmOh9rw4U5Cx/14T5S
 7rHE3md577a0YmuSJebFIklwTI8Td9WniGaZIanQU6yhAx2pqL/EbS0AbQ9mOONcmhTN
 YCD8dRzvpy95hCXaO1hNzfCV9QENgkDaRMbpW+pzwcnodSsJIVEo5wixZZbUyFzuEs3d
 1m2U6JDYapbD69T2RrrBZml0mG8PpbokM92bLFaGKOvXs7tCciVueJKeCRF0+MaNvMpI
 gRmXlnUvz9zZteTYS25/cNZJx9Tn6tM2b5Zk3IeEkur1+9HoNCqx+YnKfxMuR35dmQvf
 twIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708523476; x=1709128276;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HEdcTKEHO7Z7HcRMsNBjBNfl1WQ6V2HgRZLHF7lFnyY=;
 b=NtU0gf6xizmTgKBSXyb1pUlR78yY3ltJ/GQCF931U3wIPvnNTC7xZJyKmuQpKBhMU0
 BgvhzBUyUZ7B9DlKLKOO+bYR/SB0tINzyLbVyIAzAnCdeDqtfhOmN6PR5PlVFOvsJNJf
 NpRvkR6IzYKaqeS7BwpxOpLdOCxJi+QyJ9+g2gcHC2jC8ofKaoG19jX0rJSAZ1i+P/vB
 GeZhjJ4HT5tQj/2Sr7JAQ/apo76pkXjxA+D7h5V1dfuMPIVt2lWKawcsX7pLXa37jLX5
 /TYEdQ2puX9xBLS+Az3bU98IIUagu9KjOpLmyPb3MzuQAAl9FddK1OrP9a9RISj+HTZM
 oK5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS5HWkCidrYbCcPLMitGKw6AuZjW4uSWOBZNflT4GCuNwiMfxlyxxEVoDAbz6l4FceJWO7teKZXsx2IpaXrbyVr0MY890=
X-Gm-Message-State: AOJu0Ywmc3wrjNRtDLcSqlnhacPoU6jm72VStkv7DfMWG5JZVV0J4UHn
 X5E2HACcWJ2QJ9pbQqBZoey28XkBshEa0RHZ6EDS1qFwUqyXce+x/1lBF4UrGE14CPMIKTTiwtH
 83bg=
X-Google-Smtp-Source: AGHT+IF0fw4ktxfvx3ZIa2JiQg0IAYj1gwp+ukjYArxKGC7RQ37DpOa36hgJxeEGDHUjUGvEnn1u6w==
X-Received: by 2002:a05:6512:3a92:b0:512:caa2:18db with SMTP id
 q18-20020a0565123a9200b00512caa218dbmr3418758lfu.35.1708523475747; 
 Wed, 21 Feb 2024 05:51:15 -0800 (PST)
Received: from [192.168.245.175] (99.red-88-29-190.dynamicip.rima-tde.net.
 [88.29.190.99]) by smtp.gmail.com with ESMTPSA id
 w9-20020a05600c474900b00412684fbcf3sm8984487wmo.28.2024.02.21.05.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 05:51:15 -0800 (PST)
Message-ID: <4f94626c-7de3-43ef-99b3-cabada12307b@linaro.org>
Date: Wed, 21 Feb 2024 14:51:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] hw/i386: Store pointers to IDE buses in
 PCMachineState
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-2-peter.maydell@linaro.org>
 <65a89550-7932-4ee4-a693-3456322cdca1@linaro.org>
In-Reply-To: <65a89550-7932-4ee4-a693-3456322cdca1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 21/2/24 14:07, Philippe Mathieu-Daudé wrote:
> Hi Peter,
> 
> On 20/2/24 17:06, Peter Maydell wrote:
>> Add the two IDE bus BusState pointers to the set we keep in 
>> PCMachineState.
>> This allows us to avoid passing them to pc_cmos_init(), and also will
>> allow a refactoring of how we call pc_cmos_init_late().
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   include/hw/i386/pc.h |  4 +++-
>>   hw/i386/pc.c         |  5 ++---
>>   hw/i386/pc_piix.c    | 16 +++++++---------
>>   hw/i386/pc_q35.c     |  9 ++++-----
>>   4 files changed, 16 insertions(+), 18 deletions(-)
> 
> 
>> @@ -300,13 +299,13 @@ static void pc_q35_init(MachineState *machine)
>>                                                            
>> ICH9_SATA1_FUNC),
>>                                                  "ich9-ahci");
>>           ich9 = ICH9_AHCI(pdev);
>> -        idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
>> -        idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
>> +        pcms->idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
>> +        pcms->idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
>>           g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
>>           ide_drive_get(hd, ich9->ahci.ports);
>>           ahci_ide_create_devs(&ich9->ahci, hd);
>>       } else {
>> -        idebus[0] = idebus[1] = NULL;
>> +        pcms->idebus[0] = pcms->idebus[1] = NULL;
> 
> Since PCMachineState is zero-initialized, this part is now
> pointless.
> 
> Since my ICH9 series clashes with your patch, I'm inclined to
> queue it in my hw-misc tree, with the following squashed:
> 
> -- >8 --
> 
> -    } else {
> -        pcms->idebus[0] = pcms->idebus[1] = NULL;
> 
> ---

Sorry sent too fast. Squashing

-- >8 --
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8df88a6ccd..77d1b03fdf 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -311,6 +311,4 @@ static void pc_init1(MachineState *machine,
          i8257_dma_init(OBJECT(machine), isa_bus, 0);
          pcms->hpet_enabled = false;
-        pcms->idebus[0] = NULL;
-        pcms->idebus[1] = NULL;
      }

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 71402c36eb..0e9bd27a6e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -305,6 +305,4 @@ static void pc_q35_init(MachineState *machine)
          ide_drive_get(hd, ich9->ahci.ports);
          ahci_ide_create_devs(&ich9->ahci, hd);
-    } else {
-        pcms->idebus[0] = pcms->idebus[1] = NULL;
      }

---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


