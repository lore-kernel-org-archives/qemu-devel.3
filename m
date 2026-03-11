Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABECF106286D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ILh-00072j-2o; Wed, 11 Mar 2026 08:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0IL7-0006vO-Kp
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:07:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0IKr-0006cV-J3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:06:47 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so49735125e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 05:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773230800; x=1773835600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CqG10todXxIv4CFC9T06Q6am0ykbPaDaDJOCxk0X/0I=;
 b=YFqWXYMIbRyFNK+6B3RU0siYL4QcbLxn4FIz8zCH2tBBmjDRxl1KKw7ukOMt/Wq444
 xXB+Mt4csRUy+GQPKc7uC+DHbkYiGdM8Je73k6CR84IOSuPCQc8abC/3V54QA0wWkraF
 BcR+HlZ7ckXfcTTc8UeRs5b+iclZvkcS5uSEfDj+qIWMmD+KtTokact5Fz1iGrthNYE7
 TsLJy5yaAFewOGwUgzMHZIEDk06gyMGHVpv5UMgxnVjeNXnG/BJFifxD8jxpJtUojDoC
 LnfOZpiTAtGqpEbRLbxdqUskDTN6EN7YHl9j8f3TjF/kjEu3Wakg0zGCJYB3Z89qxRLw
 +HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773230800; x=1773835600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CqG10todXxIv4CFC9T06Q6am0ykbPaDaDJOCxk0X/0I=;
 b=HRXBpUMfds36m2MUJywwU34R6oxHEudZ0dMBnBa6IlkMCMFt4TFiTWjjzSf+UbLCQb
 JjlVj7RHnMxFVidBM2Pw/UfSIT39D7uXsjN3ewtgifi/dDvKW12ZcHb/taMigSwuSpaI
 HYKqVXPRgyofFlRm/IQHAd4dYCTWxVqG+wtxD0ykXC7mzpbarl9gGgfu0yxgoSRCOs25
 nupdQSxweABjpkOPDrF2dM2rfArWQiKLukfCNLLboJh/RSBIoO1ocXuoHoB5F7s9Ou5Y
 HeL/i+DODwgxzoyf6mTB5i8M5kSAd2h/ULZkaNS/CRV+CoYHY7slSQXfqHoGUL997hpI
 n/7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDDFYpn+DgZEY4jcR5huucA+JugxcpVYTXn41egjkvLCPM3JwaFKZ+EXLSmEAKTEu6v+RsZY5ErFwL@nongnu.org
X-Gm-Message-State: AOJu0YyZeOSYxLAomKkWasXwGnPWO3Y71/ZEi/L5uVG26WPCIX/BuFPY
 5jnJqghQpiM4ukUD4JLbI1oIdA4ro5KRm9OwW/hBpDP+x/i9CfSqy6snioHZPnkkuNg=
X-Gm-Gg: ATEYQzwLt/68m0MNiJio+/Ti0MZ4acKzw0Dvsei94G3nlA5nA0gVcPJ/7rJ7ZvrF6/n
 rn5u2tCghwb4ZMU14tDumoEpCGy7IuQUURH0wwyO6gVMSkQKOAm6YBagidn1OdNcijoZEaRY8Aq
 ynrdaFltijM2pktsLtiZ8aEyQh3O/9qtHDdKgoza/5Z0pnz1qX+G+zBDdk7oGtNrSB/0dp7Wyw2
 lG8cvJPHISmSO4DIa5KQ8S1vCjuYrInKswWdIdCXVinNViLbRAmck9OlslEC2+fGgJzP1kDVHdi
 VA7Yh0p0gAYuyThcoROL6FvjtF8UKmbK02PMs5ymL0sBwEx6PG5XZa89wqsHaEwU30YSx4UiDLf
 fKY1/gunFo0ULzLJIVNKPSlx1XwbHx/M6u66lLB7ExeAIu8jEvaD7+4Y+m85/L4s+5DFIywbrOJ
 /Y+J4l1ESY2cbFcbQhYUr59KA9pVF7mSu+6uCPYmLoa9SqNvnc7rSMsmufiM6WmOOed3ldttctw
 Ofs
X-Received: by 2002:a05:600c:c163:b0:485:33ad:3c9f with SMTP id
 5b1f17b1804b1-4854b145656mr35230245e9.25.1773230800041; 
 Wed, 11 Mar 2026 05:06:40 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0b906esm24752125e9.4.2026.03.11.05.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 05:06:39 -0700 (PDT)
Message-ID: <3b45a285-a10f-4a85-8482-c7532c7c1814@linaro.org>
Date: Wed, 11 Mar 2026 13:06:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE
 bit masks
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
 <20260311115910.564481-2-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311115910.564481-2-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 11/3/26 12:59, Djordje Todorovic wrote:
> Add the RISC-V privileged ISA defined bit positions for the Supervisor
> Big-Endian (SBE, bit 36) and Machine Big-Endian (MBE, bit 37) fields
> in the mstatus register. These are used alongside the existing
> MSTATUS_UBE (bit 6) to control data endianness at each privilege level.
> 
> The MSTATUS_UBE definition was already present, but SBE and MBE were
> missing.
> ---
>   target/riscv/cpu_bits.h | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

