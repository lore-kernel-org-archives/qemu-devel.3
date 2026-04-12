Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0A4E93807
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 22:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC32v-0007Ra-Pe; Sun, 12 Apr 2026 18:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC32r-0007Qk-1b
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 18:12:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wC32l-0001wK-8a
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 18:12:43 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d72875729so429346f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776031949; x=1776636749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kQQubkV7yuAFWu7YUoDUcpW3i4GFqsIpGt7q6Okg334=;
 b=Ma/Y6EklbNgIZkoZhOwhS2+9AGrU+nE6NmcNX91di0gq3/It5wzRD2Kk/hbndn6LKY
 OV7o+jeZpd121PdSFswE+X2OWHDz0CiFuiYGL3a1z0TWFRPBBClPzsM3jW5Kp0IifAW5
 ZnEprL196jlaNGe2G5zooUZEdm34TwpyLlP61ce6KyVzj1YUkpxSAIDopYfpk/47EOT1
 Rd3UlTr0bRzF8Mv7vuL07OfXqJSYWF3auurL6n613H4jIt5ju381wiv8px/WJCOzm1k4
 0Dy4U6fnGd4y4qx0d55K6Gr4afaJQIuZPwkfXU9BCDm6NtBob/BaY0l8IsPG4LIEwefF
 k+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776031949; x=1776636749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQQubkV7yuAFWu7YUoDUcpW3i4GFqsIpGt7q6Okg334=;
 b=I6XFckio86yMn0oYBlDZaOVXKFaDOGcC1gTQ+mYrMT9TAuf6xOedouuUT7A6AAdjFp
 TW61jzZeSuRyIg2MDE8DtiYZZ6yUdkK8SXTomUB0youF/Z7pu0CYjyLuw7/NWsYiR2AH
 tmsdGTAcd2/vj/+WBtQ4BDfAwjhm8lymfZPDiWfSyaa9b5c5HXaffg95SvIInTX9AoPF
 KoQLyUEmkCFdSFWmeSkQhHxtJdX2wjOIsaTEwm5VKmO2aIHYrAoqFV4jkx0f8gxaH1OG
 QLia0QPCe6Ew+anzxMHW03lZHet7RKL+B7XgU/lyt1G/m2V/L+Hby/V9O61Zat5CSylO
 apSg==
X-Gm-Message-State: AOJu0Yz2/IhDx8iSN+KPH/FbFK88FVdrnCwLuWw5b/BgL1Jvs70gH4fP
 KYRw85glbZlkGIH/5rJsZ1cTuPCuG7v2Xi04UcM8apM3IyfUWXPe6Y9COCZRVnQc6XpWaTLMl68
 Iduj7Jtc=
X-Gm-Gg: AeBDieuO5HTRJ1aWDj8LfPVF4mUfx3EMNJMuqS0VEGQG4InlQ58/noteFaDRtzASbJ4
 bfbHL+Poghj3IRYiCrYI+g7p/SPpUWJ7QXlopkuOV7g77E3Dc+cSwc+PM9E8YqmkNrLHAZSsdlc
 +vqaSKgkEDnG6jDiU07XL65g4Tn+ERwbTzGdBReC45U2Wa9KrvFkXyJQq5tc3tMY84jreZQpm0r
 EWxCpPbQVDUUJiGyhC+h5e7b2aJHCunajdIplnCyIuqQhIYlb56dDy0M/cJberMKdlEzUZGLIrA
 6bRNa4uPEIylQc2CeQX6YIUlqJKnfEV89W9iehjQXGS52Xv3bcWMeIKEf1R5W3zC2FcSre3zYZs
 Ny43WZ4wZLbpDjuLyL8m8Q8D9f5boFyRnG46un5kLy8ufUDJUmHQsRkpp3B53unsy6Tq9bCt5dA
 uqb6a/TxWi7qz6IF3XVe+o5sSCh2IHx09QJgv5e/DqxxRif8yVfqMI6F6YHw2TTQI+cg==
X-Received: by 2002:a05:6000:220b:b0:43b:80a0:d92 with SMTP id
 ffacd0b85a97d-43d642bd578mr14539510f8f.45.1776031948669; 
 Sun, 12 Apr 2026 15:12:28 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7400708dsm8968950f8f.25.2026.04.12.15.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 15:12:27 -0700 (PDT)
Message-ID: <7def8c1c-ea21-44d8-beb4-545425868170@linaro.org>
Date: Mon, 13 Apr 2026 00:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 00/10] migration: Reduce uses of target-specific
 macros
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Xu <peterx@redhat.com>
References: <20260325211728.89204-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260325211728.89204-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 25/3/26 22:17, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (10):
>    target/avr: Avoid target-specific migration headers in machine.c
>    target/loongarch: Avoid target-specific migration headers in machine.c
>    migration: Revert "Add VMSTATE_UINTTL_2DARRAY()"
>    migration: Remove unused target-specific macros
>    target/sparc: Inline qemu_get/put_betl()
>    target/mips: Inline qemu_get/put_betls()
>    target/i386: Expand VMSTATE_UINTTL_SUB_ARRAY for APX registers
>    target/sparc: Replace VMSTATE_VARRAY_MULTIPLY -> VMSTATE_UINTTL_ARRAY

Patches 1-7 & 9 queued, thanks.

