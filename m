Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09063606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.a=rsa-sha256 header.s=google header.b=RnSNt7y2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZ7G-0007u9-KX; Mon, 23 Nov 2026 13:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philipp.tomsich@vrull.eu>)
 id 1xVZ7D-0007ka-OE
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:50:11 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philipp.tomsich@vrull.eu>)
 id 1xVZ7C-0006z7-1v
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:50:11 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c5062bcb857so55325566b.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:50:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795459808; cv=none;
 d=google.com; s=arc-20260327;
 b=r/XIIODx5bNW14nEcd3Fe3nB4eTkA0oDwce60nq+FR9UCduz9hbwgzvK8KwZ94oycz
 Psi2dOfx4k9X5H6prjZHslmYEilw2MuxBqBOuja6+U6rt0vHaTXSBTM9ECkYReV1ce8X
 fQqGk2up0amplBhY1GUwLM5ehhF44Q1ZjtwTiyBOOcyyDx81TF+ENB9olDobPT9mrBzb
 xd0b+GbmphXeb4gJO4az74jRYh4S5dq6vIiVULMD9xv0HcNjD7bzwIhcUt4yU9CDKFtV
 EfQyD/RkLBoaMpV4WGcA1VO/RVci+RILqM+aAFUZmbrYZgAFujG8EbSiIeFoUQ636nhs
 VRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CFqHfnP5vbrnPd25wEc603NPjv9J8dV3iJqzuC8Npqk=;
 fh=MvhRrqu2i8mxDRH1wr4tXkxOt0dA0cq3cs9EEHZHF+8=;
 b=CiHDCtNSX+DlnUNaM1Fp1X0pH3DYgLku9TmuUn6ZaI5M09uXFY/R4FLsAxSH6tBB35
 lBDWMtkk8YKhu/+s2lVhXIavO7UMeM/XjQyadlZIoDEWQlIAXHcjqy3kzQve/1SZEI07
 4xHHQ4bYaSQYW7NBcPavm9PRMQBfiajePud1qiN5G0DLA7KFwupxLc7b1TEyeeUZfHCL
 sgMyi0m+kW4AeYucTuciWb97kzys5N+DyHmV4Fgu4mNxTgsOnlHXBEEFoTTaFq/1EPzX
 rMmogguitSK7zVPSDVjL/kISagxt0BfrqOx/4stZyHpjL+nzq4LDTDjIZsgtIEHDiOl1
 LrXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1795459808; x=1796064608; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CFqHfnP5vbrnPd25wEc603NPjv9J8dV3iJqzuC8Npqk=;
 b=RnSNt7y2/Jqa6UTwlePKLXhiAI7ygcak6qgNk/01LKFZwWo5N4lMT9m58P1sgjeXbD
 5HGeVQciohfx4ydEW/MlOnbqrjUg9FVuyPlxH/XOP+wzPFPBQrlbHb0Uk+oLuml33Oe6
 AGAr3fi7dSj/uWWMO+pEIcs1e1bgwrk4Pz9cxw15vvxl/Dma0oSPlT/7g/LtHZRdjK+Z
 5bbi0YGYXnQQOLSwlm30670l8xzEppxK/4er38EN1oTOSeitTDzrnJVoFH8G0Q5D+4w4
 xDhKq48idJmqY86opTzrxnZySjfazjqPl4r6ceMIAXtOmGaO71dQb40zVqFKdxTNHGNr
 wsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459808; x=1796064608;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CFqHfnP5vbrnPd25wEc603NPjv9J8dV3iJqzuC8Npqk=;
 b=oWD8zMSfxFYS1lOt1/kaUOUBT6pwQ5RbUsQwehqbLRMDhwD3sb2xnKSdvKvwBKzqsd
 77qFE5FRzI04DDLrTLO+QmhIa1fFp4LK4cyR7b+N0LsTciVSmf/sBozluAHLKkAyVDhx
 dyamoh2LGo0AguN/o+LjrGRMETlh0TcKELcIxceaVsi0ra2s+VBqeTPs+YShFdLvYGYE
 oHsq7hsRf5YytJIp6CUWAlAFiVQ9/Zpg677EW1N0lqWR5ZcnsJNMkObWgF0m+97NZss6
 Jgpr+i5QT8Yi7CR1LMkc9hkZxh+IW35Lrmkx8dMa6NoiYELN2YehD13P4NL1BDabYawc
 nZNg==
X-Gm-Message-State: APuU4Z/Hl0AAMPswU41Y8bh6wMmObsj1SfyV330Em4/sMKRDI2ve3DrO
 xvF22tk/DJFfypyi1ZuoGDKhi3Niy5aaPvH62t0u7rUw7iS1kpz5fancxTu4faKUde9798LVd8w
 end9jle8eW0eGPTZzqQam632fJ3LBafqfKxY+DiM7dw==
X-Gm-Gg: AZFdTZfoa9iE+BHbAJTnF5LY4xJ0onWYS1Cjq37M/VNX/pNpoM9fXJOcZHyZVBDNS7C
 TUhwykLIJPcBuHMPviqxGlEivoXbPeSll5t8JIIC/kG6QuLP5iHkkz3GHuCGQZ3ruQX9u+KP8wr
 va6xxKpvWcCrmS4JcR2vu0bDLy7wmtZJJEofrcOTRBDPnQiCqi9K1if+dtBXZDvH4eDPtMs51Mj
 ztPl1SGhiXP7iUajsvT3SNU24RFNAzhbjqrWJNEfiOPLv1eQDm1Yc3ZnQVA4R8QMSOLq0+3oU71
 zqG5TVf/Js+wIOmHFGcdmJp8dzU48MYYXcLPu8avpBXmjjOGTqQcgtomu2hCDaI7jpw7bCdhPnF
 yFeX1S6e+mtKY/B69bSvTXzZXQM9LEHBlHKsaW9PXnIZIAS+J5VQvFaBmA+S+xg5Pmc+1C9ZnG0
 9fcz4fnhbP4cN7aA==
X-Received: by 2002:a17:906:811:b0:c51:356c:2657 with SMTP id
 a640c23a62f3a-c513a567c14mr999594966b.3.1795459808403; Mon, 23 Nov 2026
 10:50:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
 <20261118-zl-master-v1-5-129f85e0f887@linux.alibaba.com>
In-Reply-To: <20261118-zl-master-v1-5-129f85e0f887@linux.alibaba.com>
From: Philipp Tomsich <philipp.tomsich@vrull.eu>
Date: Mon, 23 Nov 2026 19:49:57 +0100
X-Gm-Features: Aa3M54o6RqdWWvujxRHu3szrAZq_SoNDq4pXL35kWDyCrYpnmGA1dyhhe6UQAuo
Message-ID: <CAAeLtUAH9QvOG50rJE2Nfi1sFLyn2NrEQLFv_dt8h+_UkeQxSw@mail.gmail.com>
Subject: Re: [PATCH RFC 5/8] target/riscv: Limit instruction bits to the trap
 CSR width
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philipp.tomsich@vrull.eu; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 at 10:03, TANG Tiancheng <lyndra@linux.alibaba.com> wrote:
>
> The instruction bits in env->bins can be wider than the destination trap
> CSR. Keep env->bins intact and limit the reported value to MXLEN for
> mtval or SXLEN for stval.
>
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>


> ---
>  target/riscv/tcg/cpu_helper.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> index 58e98e975c29106f39074283a79038dbad255fae..568af11d24ccdfaf953a4d27d1a172847a547508 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -2260,7 +2260,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              break;
>          case RISCV_EXCP_ILLEGAL_INST:
>          case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
> -            tval = env->bins;
> +            tval = mxlen == 32 ? (uint32_t)env->bins : env->bins;
>              break;
>          case RISCV_EXCP_BREAKPOINT:
>              tval = env->badaddr;
> @@ -2377,6 +2377,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          sxlen = 16 << riscv_cpu_sxl(env);
>          env->scause = cause | ((target_ulong)async << (sxlen - 1));
>          env->sepc = env->pc;
> +        if (!async && sxlen == 32 &&
> +            (cause == RISCV_EXCP_ILLEGAL_INST ||
> +             cause == RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) {
> +            tval = (uint32_t)tval;
> +        }
>          env->stval = tval;
>          env->htval = htval;
>          env->htinst = tinst;
>
> --
> 2.43.0
>
>

