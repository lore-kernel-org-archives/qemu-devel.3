Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F72C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 00:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhdbK-0005KJ-3j; Sun, 18 Jan 2026 19:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdbG-0005Hw-HD
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:58:35 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdbD-0000LE-O7
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:58:33 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-29f2676bb21so37967535ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 16:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768784310; x=1769389110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p+uY5IrjD3cq9hX48LlwZ4AEHYnfAul3/7Ttfd6f4aU=;
 b=OhrtX34gL3Q2kHz/Ke2JKAiigCGwxt8e74bv6AGX+5KJWPc74ALF+s+OhiEaYDUSLH
 RgJHr2E1ktOtNfE6qbqrOTE3ivFmWRNaSaV8uiErupuf5vYG6cjf+QWWOvr3MMkybdww
 mLHahlSPWRn3lzmGCU5frHT5Rrlx0W+P0wWP+FKZwrOLxev2SDfbZmpMdYaRp03D04NO
 Kd9FZklQ1tRbF4mZ2vMoEA2PEpyX5Ajvk7gMODn5jZ1uUSesJ9jmhbE2np8CF1pCqrwy
 +zuRJ+1nhIflQSOlO41jjEJ9gymvalQ3tM1wMt/OZjXsTTistlnuvCaXDYaVJBl3iG29
 jTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768784310; x=1769389110;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p+uY5IrjD3cq9hX48LlwZ4AEHYnfAul3/7Ttfd6f4aU=;
 b=VAeJLO1u/nfVnl5zWC4mLloIaykJ70mBQnFOdPgYzz2hByfrQkQ0ZfML9rCCz8LAzC
 9BgRq+dq0GfsNhil91QV6IKq/xBNkFFgbENMi12QTahKD0yC9tTA7x13bEM+FHWwPU7c
 /CjX0pkYslBeNF9TKjaYydJoTBtqlLgf5a3wwjxeuaHe9s04BJQXsFimrkNYbZyOkLhg
 slC/uWFrfALz8m5uc0cCnNbdaDuoM651m8rsx6ogsVgk+bkG6LHsJU18XkHa5GQqKkU6
 Z38hsqx08YgwBsi1Tox9k6vFdAnhhjtNUuW554EFdbcUy+m/M4gsZRCpJAOAQN8hP29Q
 Jf6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Vq5JXlG7YEpL6z9dD6XV/xM5JGxK1oh3ykV7Vexb0AIR0jleHOjGL1PJkSdOeOAfYzPpLWKMr0XV@nongnu.org
X-Gm-Message-State: AOJu0YxcFd5Gr7WCIp7p5nMPm68qEJNReBaTpsAtzNIVK6i2yG+XjKTQ
 vhzT4DLtuaUajAjb0RQNq478vvmXXZE+1SQ3Peta/XJqJ9uCZcR29MKwkmE0iM2FzAY=
X-Gm-Gg: AY/fxX7XQC79LQyUwx6JNSXmg3+j9PWmr4BdsLeusc2Y6w1VkrpMzkYQFEq0B4K+7iM
 ini25uvHt/sZM064EZ485TMbGg8NbdCAhoeuERkb3Xvx46oEzi9v2qS90NoFqTV/qpdZOYsAVSk
 qC+Yp9iUh3tby1eonH25xlrk6bJa3xgwnN+rM+15h/a7Pt1SCa4yvwI9uEJfXCFdDzIzGCRe8Pz
 C9q5Sm4iN4VArVMsRi05OiJl7Kpll21L/j3PeuXxviCCcfPDbVOC0Nh7n32BFdOZwGEUrbVQFEw
 U9yMMGnNlCsozARoY7vdu4QCQiuxZ3EyETqr5Ml3yq8jH2ziXrBTyOymbsjQpWssk7ujYezJAOE
 gGlsUL1YIiwrCTqJw1inB4qF5DjNQqKysBIVEPPjhSp+vig4XBmgyNIJn4NuqvA9P1/dh1ATCVM
 kbXWSaJrYRIuLEWA6IeN/tjCSU3r7jSQ==
X-Received: by 2002:a17:902:ecce:b0:2a2:d2e8:9f1f with SMTP id
 d9443c01a7336-2a7188f91cdmr88596165ad.31.1768784310304; 
 Sun, 18 Jan 2026 16:58:30 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca058sm72464005ad.33.2026.01.18.16.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 16:58:29 -0800 (PST)
Message-ID: <e6aa8508-c475-4502-9058-42466e3d61d4@linaro.org>
Date: Mon, 19 Jan 2026 11:58:26 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/i386/tcg: replace havesib variable with the
 SIB byte itself
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260115113306.126905-1-pbonzini@redhat.com>
 <20260115113306.126905-6-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115113306.126905-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/15/26 22:33, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

