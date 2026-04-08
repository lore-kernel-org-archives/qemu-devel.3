Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADAB10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXiL-000329-Nq; Wed, 08 Apr 2026 14:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wAXht-0002ib-6P
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:32:53 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wAJ0n-0003VA-Hg
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 22:51:26 -0400
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-89cc71f4311so73990026d6.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 19:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775616683; x=1776221483; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fHNe/TNtih06CWCEWQPow8KVmvHg+7utpP+3mT+EKAU=;
 b=IjQSpnichy6118OmX2kUIiBIv+W+MUamOQ0ch+b2nKcrw9Uutnrk+u+GyugtH4Hf5u
 5INVeKsEUlpcdWAlSamxp1IMgYPfDXHsfWpsqeAxVZnpZzF3lDyY+bkjIOO5xx01WZJR
 SuPezRDaASYApGaFZ3gmCWi3uQk6Sf8prIzBrx5TjBoB865NBdSt9p4jzFriyqRljyGg
 oODN8/NP+bsHJzYo1yBhajuT+i5ogM0gYj+/RXxTe0o7Z5RPxmb74pmC3LEQXnI19ZqV
 lZXJUBjuk/OkgGKEBHwCMurNvMwIqnfh/0JsZzULUeD/Xgjoc0unf6Xz2G1VJwRjVlrf
 i+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775616683; x=1776221483;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fHNe/TNtih06CWCEWQPow8KVmvHg+7utpP+3mT+EKAU=;
 b=AX/QQBuxWNnlAHtDF0kBKy3iYB43ntCwMq78XbfmLHjJhZKnJfip6PwEymk7qtxinA
 cfZr877qObghIXothnQ/tkXZensyYU823vbj8CKbx+vBwgomde6p5osKL4qNXKkFs0w0
 CxlUbeI28XTsEFJD2+YxpkfMGvZhgQ38d+A3reO48gXga7o/GMT/CbdnE9NXPbmsxT3d
 HrfQLh2X9SVw8wC7vvk6iW9uXVYAmvZ+o4+avC4eAL8+TVcBrl7ZxaUc2WmgOugcMz2G
 GMCmi8v9YnKMRpOwoqr8lbeDZMeJZU7EHOwXKqxm3if+y2g/kZ2oFiU3IdWts4oPfPxO
 YsgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6Du/gGH2YFbHbL8Gwp7kGvqya4PotlWeR5SrWfmXQlypGNsgHIOlkuHETrSHhQK8n2MA/KUSKTOG8@nongnu.org
X-Gm-Message-State: AOJu0YzHL4joaQ3N5+ykn0P8UDmW6kYnk/xUoa5kh/Sr5qp19KPWHwdj
 Hslwcm913Rkdbhfn1y+CCkvBx7VJg2Ki+ob4Se2elnDWsCeU9Da0u6Y6qIE0DTOFqSc=
X-Gm-Gg: AeBDiet09mReyP6BPIIfSW7Vfeqx/KpyLosfbbmDncjVsjzLFToQfkCYJzLVvtZILH/
 BECkQ7NXq8b1LiyiTszZD6m07Za0p5NElm7DunUl4Fu99GzVoIwe1YAVnEfGMuqjVv4oF+9DBxH
 wg5QSjdLx61g1hb1tldgiRgoAjHFamZ/SmFFs5iml04LWU3acq/cNfKNOXKCXjhI/pX2uByo1VO
 ZDmZSXaXluDPbZdSx9zB1/2AsXIZtf/ER0WIqG4bNoDrkmU1OPZU4jVeV+EHAegKwecH9kMxdrL
 FsjTx6cdXQJtf1Zs564w056WQ3WbrBf0fsp+JGzNqyH/W/5Wb3b6UuYq47ejeQBI8qGf3kdbzNb
 Pm6hhkh4rXyILGtWp4TtyKq1ehMypoLbxRMSpRE0itmUWiNNq4sb1mKGlBY45ujFp+wieWeWz3Q
 2eQVQU45XEAxUagvQphAJlW+NjmcQmuZW+hhsEIV2KiwkE5+Yyv5KeRYVg9uugTfBkiJ/HAuO5
X-Received: by 2002:a05:6214:4e1b:b0:899:f0b1:7332 with SMTP id
 6a1803df08f44-8a7041fd54emr293737336d6.32.1775616683227; 
 Tue, 07 Apr 2026 19:51:23 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03dc6sm187903536d6.34.2026.04.07.19.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 19:51:22 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:51:06 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 5/5] target/riscv: Use ELEN for Fractional LMUL check
Message-ID: <adXCiogvUgiaiU3u@ZEVORN-PC.localdomain>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-6-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407043614.372871-6-alistair.francis@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf43.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Apr 07, 2026 at 02:36:14PM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The RISC-V spec states that
> 
> """
> For a given supported fractional LMUL setting, implementations
> must support SEW settings between SEWMIN and LMUL * ELEN, inclusive.
> """
> 
> We were previously checking VLEN, instead of ELEN, so let's update to
> check ELEN instead of VLEN for fractional scaling.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3196
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  target/riscv/vector_helper.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 83dd26314d..b4fc791eb7 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -47,18 +47,17 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>      target_ulong reserved = s2 &
>                              MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
>                                              xlen - 1 - R_VTYPE_RESERVED_SHIFT);
> -    uint16_t vlen = cpu->cfg.vlenb << 3;
>      int8_t lmul;
>  
>      if (vlmul & 4) {
>          /*
>           * Fractional LMUL, check:
>           *
> -         * VLEN * LMUL >= SEW
> -         * VLEN >> (8 - lmul) >= sew
> -         * (vlenb << 3) >> (8 - lmul) >= sew
> +         * ELEN * LMUL >= SEW
> +         * ELEN >> (8 - vlmul) >= sew
>           */
> -        if (vlmul == 4 || (vlen >> (8 - vlmul)) < sew) {
> +        if (vlmul == 4 ||
> +            (cpu->cfg.elen >> (8 - vlmul)) < sew) {
>              vill = true;
>          }
>      }
> -- 
> 2.53.0
> 

