Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07C6C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 09:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9L3h-0007QV-5q; Mon, 28 Apr 2025 05:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9L3e-0007Po-6y
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 05:45:50 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9L3a-0005ye-PG
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 05:45:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so23541655e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745833545; x=1746438345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OoA8Dn2Wtac2FOPR6/hQFftJ/lbfSRDWIBIb8p6NPmE=;
 b=M5n+foSXbONpmshrF6YiRY1ltxwjpofJm4z58vTpoxgaGS69fn3tQ0BT3O6i/WaFD2
 y3KeZgg5un1osW56cDMUBii7EszZ8h6wSYVh7EBO3whbWK/uXwyCIf/ewaIZasaBFMdT
 BPAXaNlgUihmI9TpJp65KFM53GtMk6i/zMYYmbXXUBGp1Acs6SBcYX6SDC6XVkotr3Nn
 EsKnh1S9eM+LUz5fM5EwmbxF8Pc9jfPM4ZvOFRDhPQ+mokOICdixHnBqDf8anTidZ9sE
 WkY6UAJfV14JH8jwE5F2nAEQF6Jiu9xUn2EbhQsqRyo4iRiApxDjsSNsS7+51voW5RNT
 RdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745833545; x=1746438345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OoA8Dn2Wtac2FOPR6/hQFftJ/lbfSRDWIBIb8p6NPmE=;
 b=Dghhj8cJes0HwpD+10Z/zZWlcTo7YWwSPqVFy52FZpevwn/dtsqJgHNJ3utQ3HloqZ
 90eJWHzI6V5sep6MGXkXeAFJccEi4B/9UOHs8moTPahTB1DGwg8YW+iQV3fYlmL+ha5A
 xcvNsAISHK6bHVyFZtVl55v5QOwiRmwz7YIFpiw3viWuLSqeuTRn0F2WPyw9k1HBmufm
 5EF4rXHvN67+2NypH05reyrYU3sq4ywW9EpDvfk/TttSdOTRUrLVLLde48VAA6/Gkn8Z
 LLTPP0Gqd6tb4zYSk6GVkRQ8zyQjr2J1wTuS5ZTi+oPp1Pam1kGJKLAJU2Twm79jQcbo
 /t/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAUutRrYHYBNhiTF0lY9HWvkctFw9oS08V5YFNXE2mmP1K8av19aFHkUK2/Ze5VNtue1QxBWR+5ykv@nongnu.org
X-Gm-Message-State: AOJu0YxzUWw6YTF+ZWOWpsMcAFIwVdD6qOGSRffPJvnjawF8gD2qEJgD
 3i+WFbPx/NBLbLAGI5nU612D00NG75E8HSAyKeB2KCf1001zZSwzDPZfCfOjH2k=
X-Gm-Gg: ASbGncujAZ+Xl8gRR2AQvuaxcrG+67BVodIK7qjiTVE1XwWk2jkfN+ob3XGgOZjO2pg
 dftSv94Aj7GoJaGI2DET+yBTulJKjIgysqLRMpzRp9iehi2Ue4wUp0q5WSwRNxqtXL1dWz4aZCd
 jj7ftPy2s8Vn8uHhSQxkfXsUqR+tLb1oOXUM7MsPAksuxWExsI6nJ7hMXdiMTkYfL7SquRsGQU8
 AApngvtup8xC8LhVxtBcgk/koc+rdatCBNZswrlMtBNDxLXFBTxSJtha23in4nhnKdC4HbHAMbj
 KbK4EiJwb3J2t3bMemgXh3VDsMSu/ax/EbTki8k8va5y5gXWBYzygzIpDH5WxvXbFs+JGryPpp6
 kzBuzmfXqQb6QEA==
X-Google-Smtp-Source: AGHT+IEdzWhPjOwoXJ32qyPj7AtJQPsa62Oh51XphA9zB3DvDhkh3yWQECq1OdWrChPNRgnEC9f4qQ==
X-Received: by 2002:a05:600c:b8d:b0:440:66c5:26f4 with SMTP id
 5b1f17b1804b1-440a65cdb5dmr89255715e9.1.1745833544725; 
 Mon, 28 Apr 2025 02:45:44 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29b990sm155277435e9.4.2025.04.28.02.45.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 02:45:44 -0700 (PDT)
Message-ID: <55dd4885-9f2e-4a52-bced-b70058f54101@linaro.org>
Date: Mon, 28 Apr 2025 11:45:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20250417031209.2647703-1-jamin_lin@aspeedtech.com>
 <20250417031209.2647703-7-jamin_lin@aspeedtech.com>
 <85a2947e-6909-4311-8b58-f9eb8045e76c@kaod.org>
 <SI2PR06MB5041D4AD25381C7D1D6A5C1CFCBB2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <a4c178b6-7048-42d1-9e90-58ed87baf9b5@kaod.org>
 <SI2PR06MB5041756942DE834177DFF573FCBA2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <53e66299-ba7f-404e-87c8-2952fb4d857b@kaod.org>
 <SI2PR06MB504102422034DBB6EA8CFFE4FC812@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <SI2PR06MB504102422034DBB6EA8CFFE4FC812@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/4/25 09:54, Jamin Lin wrote:
> Hi Cedric,
> 
>> Subject: Re: [PATCH v4 06/10] hw/arm/aspeed: Add support for loading
>> vbootrom image via "-bios"
>>
>> Hello Jamin,
>>
>> + Phil.
>>
>> On 4/23/25 09:02, Jamin Lin wrote:
>>> Hi Cedric,
>>>
>>>> Cc: Troy Lee <troy_lee@aspeedtech.com>; nabihestefan@google.com
>>>> Subject: Re: [PATCH v4 06/10] hw/arm/aspeed: Add support for loading
>>>> vbootrom image via "-bios"
>>>>
>>>> Hello Jamin,
>>>>
>>>>> Based on the design of aspeed_install_boot_rom, users can place
>>>>> their ROM code at the top of the image-bmc, and this function will
>>>>> install image-bmc which included the user's ROM IMAGE at the
>>>>> ASPEED_DEV_SPI_BOOT address.  For AST2600, users typically set the
>>>>> boot address to 0x0 and boot directly from there.
>>>>>
>>>>> For AST2700, we introduced a vbootrom to simulate the ROM code and
>>>>> the BOOTMCU SPL (RISC-V).
>>>>
>>>> Side question, is anyone working on the BOOTMCU SPL (RISC-V) models ?
>>>> heterogeneous machines should be supported one day.
>>>>
>>>
>>> Troy developed an initial implementation, but testing has not yet been
>>> performed due to uncertainty around "how to share DRAM memory and
>> controllers registers" between the RISC-V and the Cortex-A35 cores.
>>> Furthermore, RISC-V interrupt support is currently not implemented.
>> Could you explain a bit more the issues you are facing ? Single QEMU binary is
>> expected to become a reality in the near future and the
>> ast2700 models could benefit from it.
>>
> There is a BootMCU which is a 32-bit RISC-V CPU, and its DRAM start address is 0x80000000 (32-bit address space).
> The primary CPU is a Cortex-A35, and its DRAM start address is 0x400000000 (64-bit address space).
> 
> If the BootMCU writes 0x12345678 to address 0x80000000, the Cortex-A35 should be able to read 0x12345678 from address 0x400000000.
> Similarly, if the Cortex-A35 writes 0x00ABCDEF to address 0x400000000, the BootMCU should be able to read 0x00ABCDEF from address 0x80000000.

This shouldn't be a problem, the raspi machines have something similar.

I remember having an issue when displaying the address spaces on the
monitor, using your example, if you start mapping the dram on the rv
core, then the AS has some internal offset, and when you map it on the
arm cluster, the offset persists and you'd see it mapped at
0x3_8000_0000 while being at 0x4_0000_0000 (it is a bug). However the
accesses from the arm cores really hit 0x4_0000_0000 base: it is just
a display problem IIRC.

Maybe the thread around this issue was this one:
https://lore.kernel.org/qemu-devel/20210421144846.GI4440@xz-x1/

