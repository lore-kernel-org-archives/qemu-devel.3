Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB33104891F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6c2-0001cU-7Q; Fri, 27 Feb 2026 17:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6by-0001c7-AO
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:47:06 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6bw-0003nm-QY
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:47:06 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4398f8403edso1980697f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772232423; x=1772837223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fEcDCU7eTJBeLj9PcATwG2zFXX1UsnBcTRZ8/NbeQDE=;
 b=VIEhhJDUPt2B/cZKSSfI8i2nBUI2yJG5fePbF5WSnfvd6eHnZrgza7+stDZKK0P9Hw
 Bi0usL77ByeK/x+fzADeeYII3RXUxFuVz5V1OTFSpmHVxNCPHpqEOa1pMUqgDaXxACaI
 ZyUGBAh7ePOwtvNq9oeyXvb7LPTfLJQb8lKgU3DSJEHjPW4WYVGkKx3ua5CjjvWiBcK7
 yvUPUWIufkGAMwk5c3cy3kgQz4+Qzpgzl0vVZ5xDgw5qO+855FW0V66OfG58ru09ORKs
 ugYOnaBxwI5PVDBfmf5V3X9x5cYGpnkkRrhLn8dGsSJnodobCybuAB1O2ow0o3v1I1/l
 Mccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772232423; x=1772837223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fEcDCU7eTJBeLj9PcATwG2zFXX1UsnBcTRZ8/NbeQDE=;
 b=Ky4FVmygTlv8E0s6PBMztbsyZdzxQBI6KcUQimbbM0/RiDsgAHmGEKbAT/jpdZhoBC
 92hgkaD5x04S6VaIR3G5TVKppbIWj1rcdvJxwEd0T9vrMHfTUDyT9kKAqKLlQTLpQivr
 XB1SJnrjI5S9aI2jC9CybboOZ0W9iWlkPhqNvG0klX/4mHpCRec0C6z6KOMFF/CYOS0N
 GSW7KROTkh1YgAMVFEQr8hxHdP7oDUhx80OBPTQH8Ey+uVo+BfzEctvy9kotkznWabaZ
 Ilkjy81FN6diQbWQycCvQT6KC0ytzXZ7KgIy5VpJhWOIcE+Dex7rw5o5qWr7T8x3Md3n
 uKCg==
X-Gm-Message-State: AOJu0Ywnw9RH51jFaFZpmw4u52I8hvZA8guYLdCCT6mv2rMhiPNSb9zQ
 2kGgiJ3PSjsTsU9TRAmxFQYGCeHhwgpeIZB3jcdxYWnqZVP9xzdn8GKIoA5Iqh4h+2U=
X-Gm-Gg: ATEYQzwxVKZL6J67k6d/O8SRNXuzmv3LBHi7rGllZ60me4VKebbQfm3Liw1+209KQIq
 azku5KY14JDZgS5qxd5oatpSnIBNwE2ORVg3UC8gT1zftr2VmS0mL/pfG4YGOCCf6HRj/hR7ESQ
 9m5o5W0cbaIRbqLqtDXzDdhSnOADv1gU+GHNUrpEb7kEue50KcWFzdhmVaXhKimcOI4cmNkboJn
 Dxmjb189Q1LDWbwUZYSBbJGM4gtw/51/YktUncl6zwyG6QAEXxdynejJYfyKURhzD5ft3/SPNqE
 rUxcG5I2cO7yhenBthuTFHdyLr/W8MoHKymeV6G+mXswWrM9YMaOKce2lP5GmeEA7SI+bmpwpYT
 uWtGMiMJOc2iJFG21h4LJcQpkoVuSbZJKlw0qzraAFZ3/mLKAZcL6CLN6kEMh4ijPyz2NyKpoPY
 AksYt7bfhcu38L9YlXKZCko3e26hDCHGCLDDo/ru4pRKh9H9OnUCzq/7DjX+2ahXVedQ==
X-Received: by 2002:a05:6000:230d:b0:437:7010:1d09 with SMTP id
 ffacd0b85a97d-4399de20bf6mr7104092f8f.27.1772232422835; 
 Fri, 27 Feb 2026 14:47:02 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c70ff6esm15475872f8f.12.2026.02.27.14.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:47:02 -0800 (PST)
Message-ID: <5e02aeb3-68d3-4120-8109-37b7b5f1da24@linaro.org>
Date: Fri, 27 Feb 2026 23:47:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] hw/riscv: Check endianness for fw_dynamic fields
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-8-djordje.todorovic@htecgroup.com>
 <CAKmqyKOr0mbz0xksnO-=n0Z3cGbY0FqPTnwfY-7WaesZKewHwg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAKmqyKOr0mbz0xksnO-=n0Z3cGbY0FqPTnwfY-7WaesZKewHwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/2/26 00:32, Alistair Francis wrote:
> On Wed, Feb 25, 2026 at 8:20 PM Djordje Todorovic
> <Djordje.Todorovic@htecgroup.com> wrote:
>>
>> For riscvbe target, the fields for OpenSBI's fw_payload
>> need to be in target endian.
>> ---
>>   hw/riscv/boot.c         | 14 ++++++++++++++
>>   include/hw/riscv/boot.h |  5 +++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
>> index 6dab521a6b..f13264a87f 100644
>> --- a/hw/riscv/boot.c
>> +++ b/hw/riscv/boot.c
>> @@ -396,19 +396,33 @@ void riscv_rom_copy_firmware_info(MachineState *machine,
>>       size_t dinfo_len;
>>
>>       if (riscv_is_32bit(harts)) {
>> +#if TARGET_BIG_ENDIAN
> 
> This will need to be done without adding any TARGET_BIG_ENDIAN macros.
> We don't want to have custom built binaries

Indeed. You should check the HART endianness.

An useful exercise is to consider a system with 2 HARTs running
in different endianness. QEMU should be able to run that setup.

> 
> Alistair

