Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BB310F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYHD-0005E1-EQ; Wed, 08 Apr 2026 15:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAYFq-0003MB-R4
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:07:59 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAXX5-0001tX-Tx
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:21:45 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82d561b3689so27620b3a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 11:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775672502; x=1776277302; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+wErbE7w6vGiSEfoxDTZh742wVqJw06vN4F1JoRgt8U=;
 b=umKyF5zqNFzzNWunvKfJRsgjGOj5vn9d3G9HTD+muqXlBzr7FmcG82m7ZX679iaSaQ
 8chzIV7vRQU6TPwnabXb4+fH0mbQCwX5LZLBJu+0AUlG0eOaWoMdnrhTwDpXEHD2Or9Z
 pZlVIl9O96AzmyttVlcUxEy4Bhcak5WZ2XuhhfAdqCb2OuLmjiIiX6PVStna/IRZuchd
 z6r2EI8TDsRuqk6/n9RcAhmTxKlq/Nc2D/1BN+yX2li7400uvUsc2mngkXa1dyrkrUSU
 L8SN7rXt/GWZbhSbwNScsr+LpL86bawIR3yW5EoHYpzjuS9RqqlImQ/wrbEp98FtKbsX
 8Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775672502; x=1776277302;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+wErbE7w6vGiSEfoxDTZh742wVqJw06vN4F1JoRgt8U=;
 b=lnR2IySRPvxUq9JCByGQA9OmhkuOL7YxUY/4c0u80+RRBm8bQ2TuahF5lrCLucA6NB
 bOp5c8p30UpM9eOrpuhKHAab20F2UPVc38ryM73dVX4x/AXD3x/LjZNk82PsmEGlLs3r
 LVw8OS3R6alKC40cBNFdq384JnMYGq+jQxhkt6bKC55EYa1/kuavEFRojKW5UTm3yw8c
 CexVrn1RfrjnzaY4cPA6x6XapHblznpz+Wf5ur0wXfV7BLteNFloQRlhasn5GxTmKcrF
 MKnyv2X/GfB8SyYCeNeDZ2BtHn8/wUrtMBDLwVrMKgG5mdC+Gd57bISAKf392vtfsDqK
 k/Iw==
X-Gm-Message-State: AOJu0Yxfp/Eu3XQJkMRO1MJDOZdFURHEAeB7SJZ0lKhAov9oy1zKBPp+
 VM+GJG3YnOEI1QN4EUeZ/b7rx3SXgKk9VFcB+3oqDjLvOk//IsIQriiyvw70gUAYtXk=
X-Gm-Gg: AeBDiev8aOwivHoyXlkDiCijfJgPet7VMeYb7BLWkKg2IgRf8bJmvDr15b7HjhY1CH1
 Z3ZIK3fNv0LiISivVJfoU0tvXivFrloQfAP9qqJ7OOaa/tGNbVczGNaeOCzvLPwfg1+PAwMJkud
 UMaLa0xnKfWj+BuHz5bOVIBxsPFT096KWOp+UVeOO87scX2ORpsKm5nTHkU8hS2clfnomPLlGua
 orynwsCgapDCnJQJvoRt5P+RUM6m03LAjHwK5WzGpbs0Y9kDnJQuaUwVwZLYkzXOuNue1BYbLzU
 /QfVWYOR61pFcXLYm5UFb4TU1VQjxw6Xvg0r3br7TbXv1KUHM9idT8wgLcsKn5qEiSQMTSrtQFD
 jeCw3xEFUqzJMdZI0bHNvIFy6078ZcU/vhDCcVbZ3CBr75ImZEaBVPJJxj0gaIlNOc9M9NpKEHS
 TwnZ9j+6nfQhfKcHFxYnCNBR9GNVNRaakw6JoCELdjfN7+r4RHuFudfGcMA8vODvLCs9+6vQ==
X-Received: by 2002:a05:6a00:180f:b0:82c:6b23:6d10 with SMTP id
 d2e1a72fcca58-82d0da456f1mr22583297b3a.3.1775672502306; 
 Wed, 08 Apr 2026 11:21:42 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3c930sm21980552b3a.17.2026.04.08.11.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 11:21:41 -0700 (PDT)
Message-ID: <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
Date: Wed, 8 Apr 2026 11:21:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
Content-Language: en-US
To: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>, laurent@vivier.eu
Cc: qemu-devel@nongnu.org
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/8/26 11:17 AM, Gyorgy Tamasi wrote:
> In a 64bit LoongArch64 env (both TARGET_LOONGARCH and
> TARGET_LOONGARCH64 are defined!) we can not use the struct
> target_stat64 for data-transfer, since this struct target_stat64 is
> defined for 32bit environments with its int-sized (4byte) st_*time
> sec/nsec components.
> The user side compiler headers of the LoongArch64 env uses long-sized
> (8byte) st_*time sec/nsec components.
> 
> (This is similar to the case of 32bit vs. 64bit RISCV: the original
> code does not use struct target_stat64 in 64bit RISCV env, when both
> TARGET_RISCV and TARGET_RISCV64 are defined.)
> 
> This fix is important for LoongArch64 ABI1.0, where stat() is using an
> fstatat syscall with this struct target_stat64, if its usage is
> enabled.
> (In case of LoongArch64 ABI2.0 stat() uses statx syscall, where this
> problematic struct target_stat64 is not used, struct statx is correct
> in the LoongArch64 env.)
> See also: https://gitlab.com/qemu-project/qemu/-/work_items/3371
> 
> Signed-off-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
> ---
>   linux-user/syscall_defs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

