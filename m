Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25010D1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdx2L-0007N3-1P; Thu, 08 Jan 2026 15:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx2J-0007HI-CA
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:55:15 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx2H-0002gT-VT
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:55:15 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a110548cdeso27749575ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767905712; x=1768510512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PpyvimwgS9JUBpZaELBLithuKECG74l0bZLGF0tkrVs=;
 b=E6Z5963A9VlQZAihJrZSMj7Lua0yqL34O/mIWLSRKC25tLoAOV/roaJojVlJGC4ivJ
 jjZQV9J+JGTpPltjVhU9Czw+VepxsD6nJV7eSy2SFkyIvCZ6JzavqqipKfNN4uCvjaNl
 EfwCldzvAqTFXiKXtQ65RJp43+So7wd3nAPJWx9Zb5Qpvx20T/3kewwhPzEuVUaTRouv
 sZKbO9rS3W3rWAp5rb8VxYQSgcTQHWdHPm7UnikPzPPlKlfBrHXTmIORMcGcqA3PT1OE
 QuZO8I1i2AKelLunXWvxU++8vUswuEc/hVm4wGaA6b5eVPXPIKpLvXOYEBgI9l3ILCmY
 Aqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767905712; x=1768510512;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PpyvimwgS9JUBpZaELBLithuKECG74l0bZLGF0tkrVs=;
 b=fCO6cv0XJUT7q/KPEQyj6bBC/M7wJIg891PaEoWs21xlKFsZfL1BKs/YRdkF1nmDzp
 b6tH24aSYhHGGWma9Zsp74e4xnqb+r3oQ5YrNC6i5EkvpfXUVXa/lwYrb2kUd9gAlnD5
 xPIWE1+zCtK9K6zVwbSqIsi4PuDo1WRKC7gT0t75clzXmmXy/1NuiE6To5Q+CTF4A5kP
 w8NSqcKpT+AoCTlrlF5YRFM0AW9QEIH+ODmYJhDJ8hPtyMJSk3Wh5mRwd9fO5YP2atSx
 1P8SGI0t7N0rFomCVfuFtfvXqzz4bui3GGPiQ+Sx6SQjH7X0c7WvdkRIysXCgDbuB5bk
 sT7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ2wn5kvbuEL76EjZPtEuVKsXs3dyWHWGYxvHy/1YyMjhityJyUOCIYjZUQOrU8gu6zNHQ6Qm+2uCW@nongnu.org
X-Gm-Message-State: AOJu0Yx+cowmODDqifVN3rTZjzkCO4vRaKSEEIT9FURmmffa31cAiux6
 0pW4gNBS4POgGecAKxHerfIe0nES4cQef8aHtk/+zgsTlr0nWt/wHT1fDwvEArj09mM=
X-Gm-Gg: AY/fxX4II4EPLvnfLMHLR/6YAAKREMLrZey8zAinmEEo9o/UUgL59KuBHmw+yD3CAql
 YguZShiUrpK08IQMxMu8QmkZ9YPgD0K8p+1RwBr0Caco3Hoc4OItURGE6TpgN5AQieMODTzDQRi
 20+yTQYt3q47h/GC/x5dL2fCCN9JhGWf1gFPiT5sHJQD8ryNyswfceBauinDwTQdTgq135zWFa/
 ejxMTy9fKKG9Z/S4BZ7uhqGXkNSjDKwjETaKE1iEwSwn5ldJ/5eAR3UejIcJZFdp3NzPoYYPNSo
 H4UvmOSXjnv9M8at1mS9rtIPbIclaBzWwSV8I+1CaLnYZzTl4BBbA4383vi47HDzMcATAPynH46
 6kHEFrMxh4Yg7NBjiE0cqqxzok72yY4Xm+09/Stmn103qc+9ZvLnzmso98apksYGNQ6PJs/Fmu3
 cHu9d9XWTAUEqsCBYhoSeQmhninVVzd5QsLnmU80r/Dudnnpe/70P5LfvCUYPPvOJExSU=
X-Google-Smtp-Source: AGHT+IEspLrB3qiozI9LT/XSOeieFh0+3BE2Qu/OT5T6oc3KGzJWEdhqNiUFThRBiW+6IUCIzzdPCQ==
X-Received: by 2002:a17:902:e806:b0:2a0:ba6d:d0ff with SMTP id
 d9443c01a7336-2a3ee452490mr74755065ad.16.1767905712178; 
 Thu, 08 Jan 2026 12:55:12 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2eabsm84877815ad.49.2026.01.08.12.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:55:11 -0800 (PST)
Message-ID: <5614358d-30a8-4ef9-afbe-d33a36ec61dd@linaro.org>
Date: Thu, 8 Jan 2026 12:55:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/50] tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-26-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 686 +++++++--------------------------------------------
>   1 file changed, 90 insertions(+), 596 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

