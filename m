Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF45CC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 06:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue6Bb-0001Ml-Lx; Tue, 22 Jul 2025 02:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ue6BY-0001Jl-33
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 02:09:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ue6BV-0006cf-WD
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 02:09:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4560d176f97so54417195e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 23:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753164544; x=1753769344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rHi5AoTZKxgE1b905lgbLvWxvaelygagiP7bhh1leBo=;
 b=GonkqLLtsiXASdgvpCKKfD9YDTxgfO+BqPJ5Ku565aVEztns5ySn/HKxocGBbDG6Rq
 UNInXxcyMxOfXonT3vA1AJLEBMJV+QQOMXTi3o0WyfSkAbiWPhJBcSeDkbHuO4Kv1GQK
 G2Cb3DpINKlKVQSEEclwsCeWrXq8JzMESti3cR+JUitrde0t9FPj7qsCgb+XX/ncKxsn
 s7s6SxGST7hq0r6EX038B2991uTqtseKK6O30sbXTqsIgfwadPXjxDiF1juBfekM7HYZ
 9iIVFUy1RtfMcxs3zo4brKjsCJnIhpQXm81Gk20UeH9MB/3cqXO6YiRrtY/oFUA6BnRU
 s/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753164544; x=1753769344;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rHi5AoTZKxgE1b905lgbLvWxvaelygagiP7bhh1leBo=;
 b=nkjPWT5NlK4Ut5MeT5pk13ktaHaUFgmmkybLGYX4YbFsu95dSmJVriMGiPSP/i5ZGy
 69ovw+fvTZGLGXcPCuxyoAr+Sq3fi4lBxEKGEIwW2Uq50ub94C9RMZ1oHGax/DKPSIbn
 YRgh9HQNsRORH/pEp/Ybomwzcf3+gutCBrmRu5ji/vz5Htsx/s2UioPJmUZ/rqAYc+k0
 Y85UfZiHtPsKNgVN0CmiLiEln0SlFzlGCNhjD22qaf+5hWrUUPQWyYuk75UKs5K8gadc
 Oufm4x+gb6sQzu596IIYxE8UQLANR/Kog81mNEKcYy28oXdvxsjEqUBgsMOn5nUmTSVo
 9cvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeBE0C3HNZEeK5i5WxqRTPmXXYAkNVTcHrXTgT0sCpY5HSmSk2imDBUga8mgZ/YlwueCJlvZCWBv8f@nongnu.org
X-Gm-Message-State: AOJu0Yw/mYJlblvCJcDx9imiZrtoyQ2bUWbSBhkGMa7xlwbkAvwsgEQR
 6ITzFOQ8k4iGNFp5ZLDDWGpMWooZUu7lk8XcaEzE6wjaszO569R62eB686YSC4LGIOY=
X-Gm-Gg: ASbGnctIRsmcnSRhxmxSlsgZNIgqFw47E+1mNMK8ZfuxAtMPTWtD1V0K5moM9OIza2b
 959ZW6VrS1j9wAgC5OTumdQMX/1qXYnsbCTpzicwdvdk1Rid0Bi7/XoFYLnsBKaPUPjrt5kTnut
 4P0sRDusg7fGXHNUbUn/UigwNuaLqqerncF57/QmR5BAIsnz99o8TIl+pwnG+P3dX/WihR7hCoe
 eIbE6wmAWdGLclGue3Np76PcOhsoGimIDgIRXG5C1x4EfDa4VVdDaoy2/LyeRFd91vPyaOMHp6O
 aej9ULiL9XEekWR7Prop11/97rjcLCsWkvNfWD7iKMyfUdPPvHJ0KogMH9266bA/RxH9tJua3bY
 wwmoWWzXkni72EEK/UQwehscddww5yDeVLFZikeS6hrinTztGbtQLMv3aKdzYbKtYqRbpjgo=
X-Google-Smtp-Source: AGHT+IGWfSkPQGSRXrP/753q1NjFbpWSvPS62sJhnMx8803vuTwAbqImOPH/SbPolgjITygjpH7PEQ==
X-Received: by 2002:a5d:59c5:0:b0:3a4:e502:81e1 with SMTP id
 ffacd0b85a97d-3b60e5181dbmr16014708f8f.52.1753164544026; 
 Mon, 21 Jul 2025 23:09:04 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76455e57asm1043751f8f.21.2025.07.21.23.09.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 23:09:03 -0700 (PDT)
Message-ID: <3aa0c603-7acd-4802-9a32-80e183ef01eb@linaro.org>
Date: Tue, 22 Jul 2025 08:09:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: Fix big-endian handling of SVE gdb remote
 debugging
To: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250721211952.2239714-1-vacha.bhavsar@oss.qualcomm.com>
 <20250721211952.2239714-3-vacha.bhavsar@oss.qualcomm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250721211952.2239714-3-vacha.bhavsar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 21/7/25 23:19, Vacha Bhavsar wrote:
> This patch adds big endian support for SVE GDB remote
> debugging. It replaces the use of pointer dereferencing with the use of
> ldq_p() as explained in the first part of this patch series. Additionally,
> the order in which the buffer content is loaded into the CPU struct is
> switched depending on target endianness to ensure the most significant bits
> are always in second element.
> 
> Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> ---
>   target/arm/gdbstub64.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 8b7f15b920..cd61d946bb 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -200,10 +200,18 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)

Alex,

Why is there a disconnection with gdb_register_coprocessor() and
"gdbstub/helpers.h" APIs? The former is older? Should we unify
using the latter API with GByteArray?

>       case 0 ... 31:
>       {
>           int vq, len = 0;
> -        uint64_t *p = (uint64_t *) buf;
>           for (vq = 0; vq < cpu->sve_max_vq; vq++) {
> -            env->vfp.zregs[reg].d[vq * 2 + 1] = *p++;
> -            env->vfp.zregs[reg].d[vq * 2] = *p++;
> +            if (target_big_endian()){
> +                env->vfp.zregs[reg].d[vq * 2 + 1] = ldq_p(buf);
> +                buf += 8;
> +                env->vfp.zregs[reg].d[vq * 2] = ldq_p(buf);
> +            }
> +            else{
> +                env->vfp.zregs[reg].d[vq * 2] = ldq_p(buf);
> +                buf += 8;
> +                env->vfp.zregs[reg].d[vq * 2 + 1] = ldq_p(buf);
> +            }
> +            buf += 8;
>               len += 16;
>           }
>           return len;
> @@ -218,9 +226,9 @@ int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
>       {
>           int preg = reg - 34;
>           int vq, len = 0;
> -        uint64_t *p = (uint64_t *) buf;
>           for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
> -            env->vfp.pregs[preg].p[vq / 4] = *p++;
> +            env->vfp.pregs[preg].p[vq/4] = ldq_p(buf);
> +            buf += 8;
>               len += 8;
>           }
>           return len;


