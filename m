Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2698D3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8S1S-0004Kx-VZ; Tue, 05 Nov 2024 17:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8S1Q-0004KY-Kr
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:27:36 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8S1O-0000Xl-Ri
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:27:36 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315c1c7392so53014485e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730845653; x=1731450453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dS7DqOk42IR7Q3ggcn47HYVbUQ2mkCMr5O7xqKxOcNA=;
 b=B0rzV86oRh4ml9SUzOnn9AXd7Uh8dEUeskBuXtUabxlQVS3iFvRWXoOTUNWUENQpjz
 45E6t/i0LSuM/UUjj30YyaNypw11YQLy7uVCfewyRKXOHerLbxqhS9GEWD2l1+BeNzjc
 AIek8YUANtMutjiCddNj1i6bRl75vJLvrF5Ez7Mrj0SIXqODxoWIqJRf303gf1ncuHW8
 63+X3acax5it2ecdhyhWHhthAC/Xbyl5l7oV92oO8+4IEtIBbguRpIGKxOwI3KhXyiIv
 HQYOC8OJebVen9XqJ4/fHzE9iUmQ/XTsJjXXG2Q0ALXiJjARwa7Hc0FV5X170j8PQ8JT
 JZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730845653; x=1731450453;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dS7DqOk42IR7Q3ggcn47HYVbUQ2mkCMr5O7xqKxOcNA=;
 b=uvQuAS74U3zsT3ahgj+bPTUHHYQotvGPQdawzQNHhudHSbB55Y/hwrqXkUZKRYZvSG
 gQ/MLzg64pc1pLgFEsaQSac2dxRTiURa195jH0ROr49l1xXLFTlOwoiNC/XqwKhpsaSr
 DFG3aufYDzHqpmbV6Y+GNsleztj6vkcm3QzKaSNbDAWJA5le+NpZxYElyFdBz5wGEFpl
 o0Rnu6uZlYqQfWBP8MeCrV0hJEhx/aFeLiZJe9L5tskw8hYLHAawnZaYf6ooiGu5Y8WP
 81X1Rx3TjRucZGYd9zXfpalS3sX/n5xOIdJTCPqovYSCguuCKMnPuaqOwbWEzgks7XG+
 Y3fg==
X-Gm-Message-State: AOJu0Yx7CEgXmrGvy2Z8v//6xGHIuRCoIB57ADpvWLg0cQVtRzmRVw80
 N93MQ8MFUlpA3QWwKCiSe5JtX1B6PxG2xVcslGSASqpLXlm3D3Xx8UqMglamaFxBzG2hkIYQAy0
 WvxRz7Q==
X-Google-Smtp-Source: AGHT+IF/YctqBqSU/6ys2RiadKR+V6bGyiriPh2dCQ0FIgIsS/6XY2cjtr4nGcWUVeMb0FxyHEci3Q==
X-Received: by 2002:a05:600c:3b8d:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-43283255a89mr138982045e9.19.1730845653118; 
 Tue, 05 Nov 2024 14:27:33 -0800 (PST)
Received: from [172.20.143.32] ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5e56sm680635e9.2.2024.11.05.14.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 14:27:32 -0800 (PST)
Message-ID: <b15d094f-8d69-4d2f-a79d-11502e8baebf@linaro.org>
Date: Tue, 5 Nov 2024 22:27:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] hw/microblaze: Restrict MemoryRegionOps are
 implemented as 32-bit
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-8-philmd@linaro.org>
 <21b166ef-258c-4497-abf2-135022eb4f0e@linaro.org>
Content-Language: en-US
In-Reply-To: <21b166ef-258c-4497-abf2-135022eb4f0e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 5/11/24 23:24, Philippe Mathieu-Daudé wrote:
> On 5/11/24 14:04, Philippe Mathieu-Daudé wrote:
>> All these MemoryRegionOps read() and write() handlers are
>> implemented expecting 32-bit accesses. Clarify that setting
>> .impl.min/max_access_size fields.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/char/xilinx_uartlite.c | 4 ++++
>>   hw/intc/xilinx_intc.c     | 4 ++++
>>   hw/net/xilinx_ethlite.c   | 4 ++++
>>   hw/timer/xilinx_timer.c   | 4 ++++
>>   4 files changed, 16 insertions(+)
>>
>> diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
>> index a69ad769cc4..892efe81fee 100644
>> --- a/hw/char/xilinx_uartlite.c
>> +++ b/hw/char/xilinx_uartlite.c
>> @@ -170,6 +170,10 @@ static const MemoryRegionOps uart_ops = {
>>       .read = uart_read,
>>       .write = uart_write,
>>       .endianness = DEVICE_NATIVE_ENDIAN,
>> +    .impl = {
>> +        .min_access_size = 4,

Odd. The change makes the qtests pass, but here I'm modifying .impl,
not .valid... Since .valid.min_access_size = 1, SBI is a valid
opcode, no need to use SWI.

>> +        .max_access_size = 4,
>> +    },
>>       .valid = {
>>           .min_access_size = 1,
>>           .max_access_size = 4,
> 
> To have qtests working I need to squash:
> 
> -- >8 --
> diff --git a/tests/qtest/boot-serial-test.c 
> b/tests/qtest/boot-serial-test.c
> index 3b92fa5d506..6d9291c8ae2 100644
> --- a/tests/qtest/boot-serial-test.c
> +++ b/tests/qtest/boot-serial-test.c
> @@ -57,7 +57,7 @@ static const uint8_t kernel_pls3adsp1800[] = {
>       0xb0, 0x00, 0x84, 0x00,                 /* imm   0x8400 */
>       0x30, 0x60, 0x00, 0x04,                 /* addik r3,r0,4 */
>       0x30, 0x80, 0x00, 0x54,                 /* addik r4,r0,'T' */
> -    0xf0, 0x83, 0x00, 0x00,                 /* sbi   r4,r3,0 */
> +    0xf8, 0x83, 0x00, 0x00,                 /* swi   r4,r3,0 */
>       0xb8, 0x00, 0xff, 0xfc                  /* bri   -4  loop */
>   };
> 
> @@ -65,7 +65,7 @@ static const uint8_t kernel_plml605[] = {
>       0xe0, 0x83, 0x00, 0xb0,                 /* imm   0x83e0 */
>       0x00, 0x10, 0x60, 0x30,                 /* addik r3,r0,0x1000 */
>       0x54, 0x00, 0x80, 0x30,                 /* addik r4,r0,'T' */
> -    0x00, 0x00, 0x83, 0xf0,                 /* sbi   r4,r3,0 */
> +    0x00, 0x00, 0x83, 0xf8,                 /* swi   r4,r3,0 */
>       0xfc, 0xff, 0x00, 0xb8                  /* bri   -4  loop */
>   };
> ---
> 
> to access the uart by 32-bit instead of 8-bit.


