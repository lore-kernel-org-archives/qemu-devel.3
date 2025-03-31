Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A075C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 18:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzKE5-0004m1-0n; Mon, 31 Mar 2025 14:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzKE2-0004lT-Jt
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:51:10 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzKE0-00026M-OT
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 14:51:10 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39143200ddaso3099785f8f.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743447067; x=1744051867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=naE33U8HSZMhWwdQT39B6qgLc9o1VbOmE2DUUvbAx8I=;
 b=DsuonvOayz5X+Ucvh8hmZ22Jl0od+E2FKAviJvms7f7Kyia6mcrvMg7L59xePDfx+O
 akz/wTBYlsBpo6RGeKkwlZbbNqmIVS48HUsWHbOkfY67x5kHs3eroXlUkFp3TkMNWEd7
 zhcT29mYZYHuMm5Uir2SliPhaWZNHzLzifSUufHPXXwlyvgPjRF0ahKPnAwrKA6SlAc/
 C4gojZKKx93vtY7le4BCTbzkvSaIIpJrLD6zOOc6JEhHciTgDJ43Nf7xc1qwz+kgGVuC
 HA4l42B7A4WvhY/924vjPLid2lXlSzvaL1UijIXTzZDrSrC6xWBVC9Czk9gkOAccSHCa
 j9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743447067; x=1744051867;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=naE33U8HSZMhWwdQT39B6qgLc9o1VbOmE2DUUvbAx8I=;
 b=elkOsuWw5DP8wdayQ4n6rdyIm6nSsjNECOjW5zyFj+BecfN2L1GZZ1Wr2jmTv/pW0Q
 XPK1jlLQAmeyPgBZubVv1CswgFaULASZiFjZXiFzOgoV7PCZSLlCtq9cRwBDN2T11Vug
 ompSUiDXSqtxDHs9jIVsFl98gsHHAJhpXMl68pcJjwLzMH7E0fpX0OUJIewbD9UlL385
 MhrDr1qCH5QYKgYKN1f8qwjwp3KouOlSB0ZvJGB69KwJUX4CxOyOSKJu+6ET2xyEJqSN
 ervz9l62sgX8RTVej15o5MD+giAJPRiwTTFRQf9QGSbO/fhFj/UASyVwICFO4Rqr1WHu
 8PUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4B/pgKK3X6v6MsJZP5quetKTpq9MjfhAuOOd5BPLc2lNNrQlHCjyqSTleLgcfMAejU0SE4u/2KAtA@nongnu.org
X-Gm-Message-State: AOJu0YwSHpUUO5K4sW82gqcwe5KsoP+qFxIMTYogQIEvByMRGbPqZTTP
 63mnDP4BYiYmRxcZTEj5ZaMVtIsvcYiv68Z6+xfOMrBHwOic/rQFv5mTZ6ljTTc=
X-Gm-Gg: ASbGncvqNjmMItyyZoL2Z8HP+EU/7fDg9TfoPUiDtfGRppd6nXIdDsShlmb8911I55T
 zmLY6ZhEj4nXlHvbsdNASlZkygAJlpBGulnZTuWzyzoWntdML8ZJAVcb4ZXdj3/YcrSOT+QNcdE
 0b24LZ3p4qxFMWBWdroW/ZobzU0PvCJP+euoDh/+FnIiIxgzAlKcgxFYplkf1KYOIX0Oe6qv4h6
 5RXHlGiH9cHph8rKSdyAU0qp+xlXk+xNmrnOCQWUbhO80z7OqGfOPX+jkrcrKsP6uYZNroT3cFp
 jV1zgmomB6tpOnXQEb1ekku3vK+WUAutj00nVN3g03CO93DEOyPrbBjDZiZODi+rARs0gKJePVO
 nwkoiCH2GQvTY
X-Google-Smtp-Source: AGHT+IGNwaqhqujwCCGJ1Pm0MXvrKCySXu8m0NAAz+h+5IOFCKLVmsTj9OZXk9ppXIRDP4eaAPaYjw==
X-Received: by 2002:a05:6000:2910:b0:390:ea34:7d83 with SMTP id
 ffacd0b85a97d-39c23650080mr113841f8f.31.1743447066708; 
 Mon, 31 Mar 2025 11:51:06 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663860sm12129546f8f.39.2025.03.31.11.51.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 11:51:05 -0700 (PDT)
Message-ID: <f8cad6b4-def8-484e-9ef8-dd850027f004@linaro.org>
Date: Mon, 31 Mar 2025 20:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] target/avr: Increase page size
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <a4823d77-9182-4b92-8ef4-a894e25b0b9b@linaro.org>
Content-Language: en-US
In-Reply-To: <a4823d77-9182-4b92-8ef4-a894e25b0b9b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 31/3/25 20:48, Philippe Mathieu-Daudé wrote:
> On 25/3/25 23:43, Richard Henderson wrote:
> 
>> Richard Henderson (11):
>>    target/avr: Fix buffer read in avr_print_insn

 >>    hw/core/cpu: Use size_t for memory_rw_debug len argument

> Patch 1 queued for 10.1, thanks!

Also patch 3 ;)

