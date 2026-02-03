Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E622DE8783F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIMy-0005hI-Qj; Tue, 03 Feb 2026 10:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnIMs-0005aA-BN
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:31:07 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnIMp-0004Wv-HU
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:31:05 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48069a48629so59824095e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770132661; x=1770737461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UoAUZJCvAXycDBEpNczYWF0acw53/rRhJ/jTuTiw+WQ=;
 b=v2KiioJ3/FMyQXJE0My1j+mSZ8k5o/VcyvpD6N21fyufC26NP6iLTSSzIlESfzG2J1
 gp/FWTyDqODJ2Fn9CH7eDJyvbGEJnlakZugfV0SUWP6/TgRQAjaYEZrJM7JlfNMzAIJn
 p/0VIgSRjv5XXUcOi66M/AOgEfQcmOUL+0NstMW/HTqd4pMtXyt/p+OKwT3PJTjWFqMG
 1XyRWCnfrMHvCfBAaAaSckgA/pIcWE0s8H2PUCYMdipd4yEgmqlSg9GMDEbAt14Io1T3
 MCpyCXe61UxcLsn5FIpqbESTKN1ik6TogmSrPiqfME5V6xs/zr/iBLFtMIkTQg8aiaTR
 OcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770132661; x=1770737461;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UoAUZJCvAXycDBEpNczYWF0acw53/rRhJ/jTuTiw+WQ=;
 b=s3F/j7mXGuaCEOFHlivCC8LbAH9LNJbRKTdlwpY0XYdXgD26619O+u4h/kdLUTEGT+
 1sjuMSmWUqH+J1PsiWflsDHdzVeM7yETvFnm+mLCiIQqEXPSvHm0gvQe5zltIEF59c1b
 NdjmOJTzZPwYpwgwmTKTowtKUhw5Cz/0c3/vgk+9G4Ankoo40OcLuOwyA9tCMM2SQJ2w
 GCoTEb/e37y7RuY+H+Jpm+QeEIe3ds9zripU5+q4fsnYKC6G1RJ2AA3c8N2e8qNORMNt
 D27Sg+CcetrlnveaaHaSKMqusiwcI8mbSxu3sM/u8PT8jSwad9zyQFE5I1F1lJz+/L1l
 HybA==
X-Gm-Message-State: AOJu0Yzo0fZ4HSYkZI02fF7HwFEl0wli7H68Yr0Awfoc5J0G2lj48f7d
 uQEWVO08T3V6PE2MzY4K9qI+pAYCBAlxyR3hAixw7Kf66zWIJv5qtiFEf/cTuVL3SIOqfoJlpeu
 +Lr0Uz3U=
X-Gm-Gg: AZuq6aIiDrm6kkKXLtfSmEcHr9RPUX0srAyA8qS+XEEh6RTOBV7BOHiX9InT8viXjQx
 RKLui+xeTHggdAHbqXhOLpxATqQA/SyvFrxxhl+3mvwj8o/iqdObWfD/V45Fb249Ix7QPo6jmQK
 g9K8x80pPRNOZ9EZ/OSyoRR0WlOFjrad7XbgfMzdKk90Wqd1BsIuivpuSzSIfSf6Jh5b4DeHMEi
 ejejeIIFtLrZM16pMS552fJinWetlgr793334FKwyk05sb0xc/92isNbSIMJFUPoEGQa8AYZDtN
 xwkkqqe3U/giDZIjAGGDcaAkOml9ro1Unpv/mUspQ+yswlAbgOofprAUhh13YIroqMkivkMCuUr
 bwX18Du197GEecOt3vgIjc5yfdS0sOrN3VLXJ6fjCtknNAYSNhs48agAYQUxvreUXvd5aEfQg/s
 ji+zCfMBZ/2zhsc4lvcZNeANGA5jd9GtU7UcTa29rJoxfz9KzSVf6/Gg==
X-Received: by 2002:a05:600c:3549:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-4830e9351f5mr608565e9.1.1770132661015; 
 Tue, 03 Feb 2026 07:31:01 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce58sm51584959f8f.20.2026.02.03.07.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 07:31:00 -0800 (PST)
Message-ID: <74ca484e-d1be-4e2f-92c8-a3208493e2c5@linaro.org>
Date: Tue, 3 Feb 2026 16:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Inline translator_ld[uw,l,q]() calls
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20260202213348.96754-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260202213348.96754-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 2/2/26 22:33, Philippe Mathieu-Daudé wrote:
> In preparation of removing the translator_ld[uw,l,q]() methods,
> inline them for the x86 targets, expanding MO_TE -> MO_LE since
> the architecture uses little endian order.
> 
> Mechanical change using the following Coccinelle 'spatch' script:
> 
>      @@
>      expression env, db, pc, do_swap;
>      @@
>      (
>      - translator_lduw(env, db, pc)
>      + translator_lduw_end(env, db, pc, MO_LE)
>      |
>      - translator_ldl(env, db, pc)
>      + translator_ldl_end(env, db, pc, MO_LE)
>      |
>      - translator_ldq(env, db, pc)
>      + translator_ldq_end(env, db, pc, MO_LE)
>      )
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/tcg/decode-new.c.inc | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
Patch queued, thanks.

