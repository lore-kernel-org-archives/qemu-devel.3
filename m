Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B26AF99C99
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 21:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEDd9-00057b-Oq; Sat, 18 Apr 2026 17:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDd9-00056x-1p
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 17:55:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDd7-0002g9-E3
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 17:55:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so1188789f8f.0
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2026 14:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776549307; x=1777154107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CitAt6Yd6ncYPjilQcCdwPizq12scG28s+eo8cocTvY=;
 b=S5yWzYwhTyfk+YhaeZ0ZPcxplGSVkfm1+X0dog4wGQQUqfEw0KC3KKqYVFbl2q3rnO
 rliVMcL1bJnPkDzDTbonUJRBUP/z7KN+FUoFqiUmRZ+9DNEyZj7gTrHg1MYvuGnDPHS9
 YlU0cee7svmovz7W5PeeQDepcpa4EeT5VgZVYczJcbH+OKFQyzWF7RCIba29G3Ji/ngC
 mpH97t9m1UL1yq7yrYHxrDTyEYuPbKARrQ16XLvImIEpOG6ygF9P+vHJT3X5fyE0LHuo
 FA3T7xxXFG9trEscTb/GqHYA88GiZNIKJAFFijNtNN+TduY3BCM6eKM0Bu6q2W4PJOgw
 c7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776549307; x=1777154107;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CitAt6Yd6ncYPjilQcCdwPizq12scG28s+eo8cocTvY=;
 b=IciAxC8sQ0e8uDr3W4yyDiSlZrS3YJoVSlfsNOfiW+qUIUxc7QNG0opcqN8WmCZC0V
 0JO9pmV7H9ScUHpwgjbyInO4RGnDKe8bxon9HZHbYWvEDzaKpPayHxgFB5R1X9lFmeye
 SvocBw6u2dUHrX54NMmk9z4OfDz3+MNpHs7sp74k9Ybb34pr80C1zxMrhfavoSbzMmrw
 Ph5L6ZAKLyesMrrwzqOGM1BFXB+ybDQLBJlbJGg3XycvYWQfYOSSqLOisfAY73thxIZh
 hath5KiVtvInjNGVelOMe5rXbf2q1VrXBAate1rCuul+U8GpqTkP7kM2vW99bOcbwHWq
 Ufsg==
X-Gm-Message-State: AOJu0YyQp9gq4pXvR64yhSaCKRnSevH7H1QCbr2Ok228iaOovUDI3XoD
 B9EqifdtCp+hv9zrYI6+BKovqANn+XvjCNmM3YUSXaUZLo1uFn83CRD70UpMccWbIXxBOi9xbNg
 Dknk+db0=
X-Gm-Gg: AeBDieutiL8f7eV9/saIwzC0LWIw7/u1sxcboWuP01JYGgAweB40YsupQogxEO+Vtkq
 o3ophW87A/0wcURexECOHgYJkny2F92bwDdYt+r8j7uZ2+CwPUlsM5AnjrObFx+zEfwxok2R7yN
 Q7Bel8qULTDV0Y4HzLjpE496ubcEdE/V2dDdR3Jl+1MS/sTDPXfvRu2MjdGRhcoB6snjT7C0n+n
 LdIMW3zKCHx/hsFDxBDI8RzaiT4aKOKkRlAGDLY8mlPdgctc3fdNUrZhSl9LC0Ffhv2JpKAZOta
 bQObTn24IX3NFv54BdDFxoBSBfyHmtkOFcUV6+Og3ZHvWIc0WCMJxC/jD815fde2OPqklX0eKM6
 vxx36i28MIfX4EKyShytP/Zq0AL6l4w0fHjNDU0xlSeeaCwGK6q0xyy8BJXbWNqPpklBVifV8/U
 rRW1sgCAR7D3WP8yIOZMei6dKBN8CfvGYLn0QDdIJhvDGjWf18sDTbb2CBIf4nn+yHWk8zqW1bl
 jnJ
X-Received: by 2002:a05:6000:290c:b0:43d:772d:2b61 with SMTP id
 ffacd0b85a97d-43fe4073831mr11559954f8f.15.1776549306775; 
 Sat, 18 Apr 2026 14:55:06 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a341sm17748309f8f.24.2026.04.18.14.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2026 14:55:06 -0700 (PDT)
Message-ID: <15fb97ae-51c7-49ae-97ef-35a387d02c44@linaro.org>
Date: Sat, 18 Apr 2026 23:55:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] target/mips: Replace cpu_ld/st_mmuidx_ra() calls
 in LD/ST Multiple
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260417035734.32334-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260417035734.32334-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 17/4/26 05:57, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (4):
>    target/mips: Pass MemOpIdx argument to Load/Store Multiple helpers
>    target/mips: Remove unnecessary target_ulong uses in LD/ST Multiple
>    target/mips: Inline cpu_ld/st_mmuidx_ra() calls in LD/ST Multiple
>    target/mips: Check alignment for microMIPS pre-R6 LD/ST multiple

Series queued, thanks.

