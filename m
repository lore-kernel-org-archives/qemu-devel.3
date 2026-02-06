Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDC5ECD9B0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 01:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voAM2-0004vY-2V; Thu, 05 Feb 2026 20:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voALy-0004vP-Sx
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 20:09:46 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voALw-0006MV-4e
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 20:09:45 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3530e7b3dc2so1287553a91.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 17:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770340182; x=1770944982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I+yDbtKy85w0+sd3PzqEIedMcAM9PBjhd5NU/UanDpE=;
 b=ujdR/a60uoVFemAe7bBjH5qFu+S5usdi2RD5pprOgjSHcNy3UXUARQUfDlzOIPhPZ9
 ITJkqpWPHkFOgC00osPbtbQ/BQZFnMlwiN5dZ2qHbLtKRtpqs+ufPMM1b+7Uw5Zjxe1W
 J+EM1JcPLwzSZeAOcSAv6gutpnpP8WYMdKOLZ35WrMszA/oce4hLs9wFBfGeRC4edFJN
 UCAfDNV0Zbzc7NT49DcR9eAR4+2mAT2Il5aCo397VZgkDww72wu9wSlz3LOhyHpSaDig
 e3T5Mo31IoYaNwsvji8ddiJAd+qsOzWLNemex1qYi4lVi45dt1l1ri6tXAxvo8ToM/V7
 ni6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770340182; x=1770944982;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I+yDbtKy85w0+sd3PzqEIedMcAM9PBjhd5NU/UanDpE=;
 b=oDcbr7bxnsM0Qj7H2Wz4OjmR+oM9jpbauk3PkFypAXJMZx599pfXIE4cMkzwZOnCDt
 AANYtXKk3ffyn96+CpfJMhr/WjGu6m4Ao+k59oG/PfOnLe8nQQV3xHB9q/Cb4VWhIFQt
 YGx0YrLSQNkcfpWX65Lzd/CGZQ38Gegjs2Pt9YV7Nd4zbLtvf5nA1zToVpE+h1xShHrx
 uIprXCXa3x7htPXorktKUdomIB2SkDD3Nloh2aCrH14EL88hL7yUuq+sp+p/k1zKxivF
 /A7ScgZ2uTCV3GjsgocvCBvFRuP8hzHOesvo2qR7nVZLaDNMauJn8PgoqSCiVQ3tkMLp
 LUMw==
X-Gm-Message-State: AOJu0Yw+ZGM4AMQ4XrkUxkNzF7ndbyoaUOzMCNUUDEgdtdfoVYhf7pG0
 zh9mhd2JBGqlzaUqXfYlNtNcc2EVNLG369ovNteGtZEjvDLqKNmmaLp6t1Q6MwFxMVZOqJXIFe5
 wh1NtJKyQfg==
X-Gm-Gg: AZuq6aKCIT18e1HuoJzhx7jjeWeBWjfUVQQStVwQ+t1E9Np3GM1EA4AKuGDcBH2B+KU
 5sgFukJQdmYin3D3Uf3IYDNtX51HL7Xosa4siJzWLHDnnBPQe0HXSwHNB7fBiezCf/lTBt9hqGU
 jTzbsVCV+AhSy0dG7a9NfNnoEt3MlbaTZM2e0NDhr6T69AyJif1i1H2CHqvyIT9THXSIgEWIx/R
 JEUO9CNo1P4ZHgddtpFQTZl1JEnyO5duxntH7jXr0ETTIsppo0BMzQmynhTEn6Zv6mElU8A13sD
 coKE4ZpyCcTbjvmcXPcoC3NChlIIYiOCYkdSP4LCWU/MAG4jltwEM/rYWFzkqtlmQGWx2e3Vqls
 Ktjd3Hvgw7Da92b7/WOTo1hZ816pgMNgIXpp7fEQ0AbwAMDgkovAGoJ7W28aXimuCAqKypi5dwX
 3A+EBTLltYJkFARA6jmfEA0sFBHNCTWwpy/WyacIAl7iGaxEXdkkhTQPK5g8yIg/V0pMQWAqgPX
 3dn/5ocQrM2onkCD8H+5T0UlFvr5rfsILF6SxyFoXCY5iSz1ttPMQ==
X-Received: by 2002:a17:90b:4e88:b0:34c:2db6:57d5 with SMTP id
 98e67ed59e1d1-354b3ac0385mr787202a91.0.1770340182367; 
 Thu, 05 Feb 2026 17:09:42 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b465df46sm226451a91.7.2026.02.05.17.09.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 17:09:41 -0800 (PST)
Message-ID: <1c5dc895-f2cf-44f1-adf9-c843a39de681@linaro.org>
Date: Fri, 6 Feb 2026 11:09:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] tcg/optimize: possibly expand deposit into zero
 with shifts
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-7-richard.henderson@linaro.org>
 <4bfd463a-f7ba-4bea-9fd5-27c1a05045f4@redhat.com>
 <4f299aca-b1f5-473e-9cd8-dc1fe997d19d@linaro.org>
 <CABgObfb3zP3TYCz04Rmg+2HZbXZjKFvuACqznJm56ET9NhBhzw@mail.gmail.com>
 <5c46d3a3-e046-46a1-ac5c-5588a2179441@linaro.org>
 <CABgObfZArFHKHjwbWBmWP09OegtfiCpAQuQLtSrWax0tzc_hSA@mail.gmail.com>
 <c2cb0273-de90-439b-9058-c4b57df86fce@linaro.org>
 <CABgObfbBGw77LDuirj1xWVaecEv6oSOZVY7gY1R8FURiK8+_Wg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CABgObfbBGw77LDuirj1xWVaecEv6oSOZVY7gY1R8FURiK8+_Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 2/6/26 09:22, Paolo Bonzini wrote:
> 
> 
> Il gio 5 feb 2026, 23:29 Richard Henderson <richard.henderson@linaro.org 
> <mailto:richard.henderson@linaro.org>> ha scritto:
> 
>      >      > I think it would be better to pick a canonical form for AND with 2^n-1 and
>     handle
>      >      > conversion to extract (like PPC rotates or movz) in the backend.
>      >      >
>      >      > Picking AND as the canonical form also avoids makes the macros for extract
>     validity
>      >      > simpler too; adding an extra constraint for immediate 2^n-1 is easier and it
>      >     generalizes
>      >      > to other PPC rotate and mask cases.
>      >
>      >     Picking AND means we have to use "r,0,ri" for x86, losing register allocation
>     flexibility.
>      >
>      >
>      > Then could you wrap the target specific extract_valid with one that allows ofs == 0
>     if AND
>      > allows the immediate 2^len-1? That would also simplify this series.
> 
>     I don't understand your suggestion here.
> 
> 
> I am not sure about it either... I am just not sure why extract is guaranteed to be 
> cheaper or have better constraints than AND.
> 
> It does happen to be true for x86, though only for len == 8 or 16; but is it true of all 
> targets that have a more expansive extract instruction?

x86 includes len == 32 via 'movl', fwiw.

Similarly, riscv64 has quite a number of filter conditions for extract, mostly because of 
a 12-bit signed argument for AND, and a collection of other zero-extend insns.

AArch64, loongarch64, and ppc64 all emit ANDI if possible during tgen_extract.

So it really is all about using extract if valid, and allowing the backend to use the more 
favorable set of constraints.


r~

