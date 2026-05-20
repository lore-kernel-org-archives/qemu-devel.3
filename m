Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F216DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgdu-0003pk-LQ; Wed, 20 May 2026 09:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgds-0003p4-6Z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:07:20 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPgdq-0000oJ-3J
 for qemu-devel@nongnu.org; Wed, 20 May 2026 09:07:19 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-44985f4ab0fso2573052f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779282436; x=1779887236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vMXvsEpJhrCT/ANJtmzVMDimbG2B8JsYBvXP42kiKYM=;
 b=TT7zT7QKlqLGUZaMR9iZJ+Bkbyp86Db0exhZme3oCjVHZxcMi1IcX0IGwoxJSihMTa
 lohASZQqGkFwrbnQWty7N6jYaZZ/5Sw9C3JfeqE5Hn1AfKbvs6Zc2/17jVAdN1Qfo4vA
 TxJpZH23iQSabzsHHfwbkwjy7ssJXxP+5L3kFVHgrfoyCIhNVGvpjmAqG5hymxzka0lj
 7HJj9/xCUXJFSmPgojDyvkOVcy0Lr/TV2Ak7H9Xbym4MF5PoDXbvbW2eKhQJaDKqzi/B
 lcRv8hLIhf458SGlND0bZ2TwABtjDovF09IG4GujvCpvSGuA0SGy/Fi8b1uTl/kecCLr
 VFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779282436; x=1779887236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vMXvsEpJhrCT/ANJtmzVMDimbG2B8JsYBvXP42kiKYM=;
 b=nTyAC9Lyp/4sS1ctQad26gg7q6nWvgfUilDRfXiMEF2oBN9XqTjeAjc3xZnTa5ZYV9
 A7ETqwwxbe3z+hgLt9+DCMczjOfPLuw7CP6P83gL/eeOrPmjJGeIkhBzNYgpcGIf8h/R
 nPq2q/6dkYfm/+hs+LskCQr23VReiAL3fa4qPCdzKmT9ewi3prgtveBu59FSuxaO4Ufa
 LuoC8Vn8dHlnsCrbPGegBAndRCiqMw6mDVTb8n3SuaZu04OIV+08Mj9AbLMAYVmXW8Aa
 oQa6zzalhAt8uL0haett7r4Q6SpVMVQNFOlgJz+5B4fyFRsg8hGsGTRqW9xUQrJadkHL
 b03w==
X-Gm-Message-State: AOJu0YxiL71UFV/vlUXp8c9wEY8YdK5bO+2/KsB1ptccHaQsjCo/riRb
 Lji6paodEvFlEJt3hS7acyKHfTKzLVqWk8Tfm+D3lElGoufGIMz71m+mWzpIC67SNUOB3lW8GyE
 tOhe04+Y=
X-Gm-Gg: Acq92OHFp3sqoJrHVPVs3kOP4Zyp92SALlfiS4kFrwxsC/LY/dxMOl8pJjYi2BpdClb
 2FlrwfNoHXUr37JIdxmZhCA60NYCgHGTkUA7jwQDt0BCIgjFX7tsgrwUSrFC6AGSST5HMzcKKof
 izolPHohLAjuT7oGkkUjXVKnjNayuKqyKlpTbmsRJQyjV01Lk7ahjWwXwvMC6hbj8efVZaySPgv
 R59Gs40RqWx624kjFbqLOpjoo507IatfMP97Tz/wu1VIwylIs7K3EKyBLvedVgyRkqWl1Lls0h0
 YEFMYw8jiMXOjpJoU5cbX0gG4xpRzThNzI4RoBRZJmjlyTyA9VPVpNJd0KmOu6N6WeIFLNJDNXF
 PuZXxOAiYrkpQfudVAK4mSZXm4iGTPCQoWKFDV7d4MX+HsUQnXcZhqaSm3dK2ChdcMYrL3xeYmX
 X1WFyrAM6jBEoAVJ2jKiSm23rzWW5bB/hxABhXE2DZ7HLW/5pTsD2h26Otojrb6wmVEHeRpwV1s
 vfq
X-Received: by 2002:a5d:5d10:0:b0:45a:dd7a:e33c with SMTP id
 ffacd0b85a97d-45e5c596c14mr35993524f8f.33.1779282435829; 
 Wed, 20 May 2026 06:07:15 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768bcesm56308446f8f.4.2026.05.20.06.07.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 06:07:15 -0700 (PDT)
Message-ID: <0f8dfec3-d995-4668-817f-a60209310cf6@linaro.org>
Date: Wed, 20 May 2026 15:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 21/24] target/mips: add Octeon VMM0 instruction
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-22-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260520101807.9971-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 20/5/26 12:18, Philippe Mathieu-Daudé wrote:
> From: James Hilliard <james.hilliard1@gmail.com>
> 
> VMM0 multiplies MPL[0] by rs, adds rt and the queued P[0] partial
> product, returns the low result, and feeds that result back into MPL[0].
> It sets MPL[1] to zero and clears partial products.
> 
> Include hardware-backed regression coverage for VMM0 MPL1 zeroing.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/tcg/octeon.decode                 |  1 +
>   target/mips/tcg/octeon_translate.c            | 16 ++++++
>   tests/tcg/mips/user/isa/octeon/octeon-insns.c | 55 +++++++++++++++++++
>   3 files changed, 72 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

