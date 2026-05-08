Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED0CCD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLOjc-00033u-PN; Fri, 08 May 2026 13:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLOjT-00033R-Dk
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:11:23 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLOjN-0007UE-JP
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:11:20 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-479d593a0c3so1881221b6e.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778260270; x=1778865070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bWM6Zrfkn94W/s0m7et+vXZ4rX3kd9JthNmGn5/AQZE=;
 b=uMpczagycPbklHngDxK/amx3C3778H39dSXsVP956etKIU2V4F4IiWUU2scz7fs7wr
 GCVVNJNKyHddZRTiN6ZxgM9oiePEadX0nfbzDu1MUgw/1AYQeUqexAjrSqN3IRFFGuUW
 9d0tuvRLfr58TKOpG0Rps0CREOWZC1mRIa+CM5O4nKbzYzA2VIVCgpFA/MvYtv1PFeT6
 h0hSfLHRjKHc8ihPYkgMMvyNsKZqjVuz4yNRqu2fpumkemlbJj/5t2XDe7D1iS1al34b
 bG5XguJt6F6Acwgn85EY6Njj/PeE09cTWQI5Y/Vz2LTCOghuCbn07L7zEG3YzaA5fFMY
 i/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778260270; x=1778865070;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bWM6Zrfkn94W/s0m7et+vXZ4rX3kd9JthNmGn5/AQZE=;
 b=WlhNzzTSCu+FwkaSsSmSLf8VNb21uub3y+cQiIw6qMON4Q7Mn+PNuwwM3BdbNtB+mL
 ihANweSVFWtGYR8Cl9QRucTKUyFS1RqxQ+HuCtF5256O5pm29YVUo3G67IQn81+bEnhr
 sLQTslijXvj4Gojw84ZjiExi//OaGZnFsCfVqj2qMKeZIFTGM091rdf5rq0G7J5UZTr6
 Dixkx8ch58XAfvmFtNodZAbifjfnPG9i9sheRuNudrG4huDOuhYO9tsqCrR/vybGThx7
 +Jq6gLz6xuk4nHKBh+xlbMubicE7jgUo/FDErAVqHsTyp/kDne6Bg22TLWtrUNWhWVKj
 DrMg==
X-Gm-Message-State: AOJu0Yxch14dWaEWaDwI4eynOSjZj4UpLtP66kWDX3YKPQ2CKuISHh5X
 0jOMbunlo5k9p2k4nPTcY31NMiRIfUVx/dePCeYFK9WQyzVwrL7ujjeYWePxDmy753X437Swcc6
 Jp1QH
X-Gm-Gg: AeBDietOOBMPEx7ZY+eErigqQ2YpFRshNiuX1AZPA07ohpp51qBgKUbMGnxDtGRbvj+
 QjPmiaUxEibGOIWCTdhrl4CpSWSN0db6ElKBLDeBRmzeVcbGGSkPU86jNU349hW35Mgo2o7DB3P
 2FEdVb42ivvhiV2wuM+qPz3OSITh3VruyOhipyetJZvoUMWTX6rbAukuuI9QFwffRQBU59MAnSd
 o8XjO6q1Ej9GSYn0QvcksAEbHz/ivHXe8maFGt/EPBHZdZTz4UHZFPMAwLI59BYHx3Fgai9aVk3
 3XYa4aBdlzbUNDkmxHJNMXSc+ONjCEvMeTqxlze++EO7bb5NPUY4E8e++RKw1tJjyQ8ToNqDfTD
 j8eVtfDHUGpi7+l/wPqpOFQWmtkY441FsHxYy1Gyv/L0DGLUDncBk4WYVMBUs7pHSVFPB6J0yJg
 kwRoI12oOZzxQDu/zrhFyYku0v1NEqaMlmvk8JKxUI2FyW5cJaPHletLX8u9yxicopIb2uGTfN/
 As/NLaohA==
X-Received: by 2002:a05:6808:f89:b0:47b:c703:421d with SMTP id
 5614622812f47-48061adc986mr3740100b6e.8.1778260270360; 
 Fri, 08 May 2026 10:11:10 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c7640069csm14905238b6e.8.2026.05.08.10.11.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 10:11:10 -0700 (PDT)
Message-ID: <594597f2-1a51-4d31-aea9-7f46fb520506@linaro.org>
Date: Fri, 8 May 2026 12:11:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/32] linux-user/mips: implement
 sysmips(MIPS_FLUSH_CACHE)
To: qemu-devel@nongnu.org
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
 <20260508-mips-octeon-missing-insns-v2-v3-1-bcbec96357d9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-1-bcbec96357d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 5/8/26 10:12, James Hilliard wrote:
> Add the target sysmips dispatcher and implement MIPS_FLUSH_CACHE as a
> successful no-op for linux-user.
> 
> Self-modifying code is handled by QEMU's normal user-mode translation
> invalidation machinery, so the target ABI only needs the syscall command
> to be accepted.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split MIPS_FLUSH_CACHE out of the combined sysmips/MIPS_FIXADE patch.
>      (suggested by Richard Henderson)
> ---
>   linux-user/mips/target_syscall.h   |  1 +
>   linux-user/mips64/target_syscall.h |  1 +
>   linux-user/syscall.c               | 17 +++++++++++++++++
>   3 files changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

