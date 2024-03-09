Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59271C54E5D
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 20:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj35e-0007nb-Ts; Sat, 09 Mar 2024 15:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rj35c-0007mp-5U
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:14:40 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rj35Z-0002Fh-84
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:14:39 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e66e8fcc2dso1586714b3a.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 12:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710015271; x=1710620071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z5RPgNiMp469x1/xWhgYlM6vC/pxJoZgZErvDkkZA/Q=;
 b=eZD5juPmQTAIEXXC4c4s75cwgZ8DVGreIwCN6tIE/uUyl+j6/zrvDNFaaP4OOIswMy
 HYFJThYVIC9Wa6a1TMeomce0UePl/gSG3iFjaXd75KQNxgklEHElMJ2Y8DKHF9MV14CE
 AJ+jSj/V+GvUf9mWc710CvAVtinKNFrxn7CqmKgqs+ZPefW8K6DezHSqmpRFmlhqneeS
 lM/bhk7trbZyM0Nufux1IiMefdLQZPlw4DsC82g+UNuB9HAsTc52pekyjs1rjiBGuOOw
 JSePc764G9b/r+7RbyCV+cwBNdCHplUkaDMLewPy26lr7JuNdi3DF8ql7CAwBk4qnO7E
 dJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710015271; x=1710620071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z5RPgNiMp469x1/xWhgYlM6vC/pxJoZgZErvDkkZA/Q=;
 b=bSxh28djw3wrz31B8yLSV/Wn+yZU0wbN8IxKTvFZiWOVlGbzyUypoRASTdpihbJPtW
 gGKmXtzsa7haO7KxxgwbI/LQ1e4t6WOVan8WVTtqvZuTl1bDdR+mJ3Dn+lZTMiMniX45
 +k89jLtdi/W3+4awI1Q0GgSV5H8If0K0pVK7UI2mxN7H96xWtYDamcl61C5JSjptvstJ
 XpzNGrDEzPqtfpTKj4Khml7iSPq2GZ/WbjeQHIzDh4I/CqlatPcTpUf9QkTN8ZNLNv/7
 P7ve+WfeNYuz6S2feVnPCCY44hZ4x3l/r+qXt44ka1+gh+tm4EwZYWxthM/7RN+tnWCo
 0dSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgNjze93GXJBy7NK4e/ikic/ZJ+glnCI+FTGigS6ngJIlHMuxx29ScBo93o8+MyGuQL7HzLlCdcDt5N6pZtG4kUmklJUg=
X-Gm-Message-State: AOJu0Yz8bgsFJrvbMjxYskd7+/exZmwF4A40LHIUg/7L02S1T4rIZg66
 G7Z65cDbYWBOCTo6IuWSggNmJ0A4s4e6cPD7p/4IgQTJTqNAHc3Pjga6F6/GTTI=
X-Google-Smtp-Source: AGHT+IGX7pE26y0EUG62iVQVq/P/M8vr2AFnqJzV69iuFmk9+2o2rphiCt9Wm2iu61e3KRp0cVxiwQ==
X-Received: by 2002:a05:6a00:14c4:b0:6e6:28ae:197b with SMTP id
 w4-20020a056a0014c400b006e628ae197bmr2654871pfu.12.1710015271114; 
 Sat, 09 Mar 2024 12:14:31 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 bn22-20020a056a00325600b006e6795932a4sm1447510pfb.80.2024.03.09.12.14.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 12:14:30 -0800 (PST)
Message-ID: <fe056cad-e711-445a-be26-9a0625ae0665@linaro.org>
Date: Sat, 9 Mar 2024 10:14:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] riscv: set vstart_eq_zero on mark_vs_dirty
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org
References: <20240308215402.117405-1-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240308215402.117405-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/8/24 11:53, Daniel Henrique Barboza wrote:
> - patch 7 (patch 3 from v7): do not remove brconds from scalar move
>    insns
> 
>    trans_vmv_s_x() and trans_vfmv_s_f() does not have a helper that will
>    handle vstart >= vl for them, so they need their brcond.
> 
> - patches 4 and 5 from v7: dropped. We're not removing all brconds, so
>    we can't get rid of cpu_vstart and cpu_vl.

Not important for the bug fix, but for future cleanup:

(1) Use movcond to for these moves instead of brcond.

(2) Use explicit load/store in these two places where cpu_vstart and cpu_vl are still in use.

(3) Now there are no tcg globals that are modified by the vector helpers, which means that 
they can all be marked TCG_CALL_NO_WG, and any that never exit via exception may be marked 
TCG_CALL_NO_RWG.  This may reduce register allocator spill/fill across the affected helpers.


r~

