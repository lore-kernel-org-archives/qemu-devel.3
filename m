Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3CEC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwj9c-00084K-VU; Tue, 16 Apr 2024 09:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwj9Z-00083k-PB
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:47:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwj9Y-0000ei-1X
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:47:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-418a5ebe335so1432275e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713275234; x=1713880034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OVn8qVlJsVHOMvdnKle/8wx/gr1e+AsIF3Uk1/9in5I=;
 b=uUibAnOkP5UVNzj+mMM5Blr+K0PNgLXSer5fPQhK5xs5o1uTJJGRNhH8N2c/Byujf2
 bmBAGJhkw4m+6oO2Rbe80fXJr93owTwRnekHZVzneYIz9BroeXORlaExJV+QdvcjzV6W
 zAAVmlPmKqbPIrM2rirWytPXZmY9xx8jAcr1sGie2vLBfffrMm8et04L7cYIPuSKX8dt
 1jW09lx333Jww1KFCmf+Kd09083TxSXSxyiNlfQuUhQA+ocRQPTLssAXXCegkbm5NaFx
 5sDfYHJwaWSsolROkn/V82waNMvTHXy8WRHS/H8R+9hF0YziA6IghfJR76J4WgIPdtYT
 dRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275234; x=1713880034;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OVn8qVlJsVHOMvdnKle/8wx/gr1e+AsIF3Uk1/9in5I=;
 b=k97bjD3+1PaKOdvaVXYP6IV3zg6r68Mescj8KUpijXQZLi4sI8ZXkopcHuCKorUOe/
 9JahuQgz8MosCbT/ir/LVT+1MLx04xmkc0t2JpnmPRvAXQSYjaRDN1KTaZp0AmpbXbxZ
 yxpZvzcI2fvl2HwwttT97LseFkRCTKgAbZpZ2Jyvx+Bjfmxu9mpzsxSoKEQvXM5s3UzQ
 oflsv57RsyMpyI3KRVsi4x9P+E/oVb4c2s9NeKw/Rns60uliqcDrQ9n2xssLyR8NIpCt
 b1nEdYrw/4hDPREO06SXqQm8NUHupy1Ghm+1atHhF9pBmxXpP1dLpVlqI9VLozUZgoEb
 GUKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC36FN9camjZKrWMmJSHD0QuPlxMARkD0dlzF2yiXSH2r0tIAnv+LpUD4/x+sKPm1oRb4tC5M4zkjV+nL2pGnPJptE6AA=
X-Gm-Message-State: AOJu0YzWlgCABWXDCw5tXKtk98Ivjc6PqXHqI1DWMCRNW42UPzJcL5sW
 f+d9OZo7hhV9sE0En5NG/C4Frf01J0uy1w86ALGyWgk/ru78WIxN2IDRE63M70M=
X-Google-Smtp-Source: AGHT+IEa9Z7dp5dd89To97gfgQrhS3GkQxuimz3KjPcjwuG2xAvjmjZLbAIRFpIBvACGZcYlIzrHAg==
X-Received: by 2002:a05:600c:3549:b0:418:23d7:816f with SMTP id
 i9-20020a05600c354900b0041823d7816fmr5696604wmq.17.1713275234199; 
 Tue, 16 Apr 2024 06:47:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a056000110600b003499f9b4b6dsm195296wrw.101.2024.04.16.06.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 06:47:13 -0700 (PDT)
Message-ID: <fb3e291a-a1ff-4e45-89fd-139f11275c88@linaro.org>
Date: Tue, 16 Apr 2024 15:47:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 21/21] hw/i386/pc: Replace
 PCMachineClass::acpi_data_size by PC_ACPI_DATA_SIZE
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 devel@lists.libvirt.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-22-philmd@linaro.org> <ZgTtvwXMNwm/3I7j@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZgTtvwXMNwm/3I7j@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28/3/24 05:10, Zhao Liu wrote:
> Hi Philippe,
> 
> On Wed, Mar 27, 2024 at 10:51:23AM +0100, Philippe Mathieu-Daudé wrote:
>> Date: Wed, 27 Mar 2024 10:51:23 +0100
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: [PATCH-for-9.1 v2 21/21] hw/i386/pc: Replace
>>   PCMachineClass::acpi_data_size by PC_ACPI_DATA_SIZE
>> X-Mailer: git-send-email 2.41.0
> 
> [snip]
> 
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 27e04c52f6..f01a30d3d9 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -256,6 +256,16 @@ GlobalProperty pc_compat_2_4[] = {
>>   };
>>   const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
>>   
>> +/*
>> + * @PC_ACPI_DATA_SIZE:
>> + * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
>> + * and other BIOS datastructures.
>> + *
>> + * BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K
>> + * reported to be used at the moment, 32K should be enough for a while.
>> + */
>> +#define PC_ACPI_DATA_SIZE (0x20000 + 0x8000)
>> +
> 
> What about putting this in pc.h? Because it is a general definition for
> PC.

Since nothing out of hw/i386/pc.c uses this definition,
I rather avoid exposing it.

> 
> Others are good for me,
> 
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Thanks!


