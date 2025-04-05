Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888D9C369A1
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 09:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0zft-0002XB-4c; Sat, 05 Apr 2025 05:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zfk-0002SY-MX
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:18:41 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u0zfi-0008NR-FH
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 05:18:40 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af50f56b862so1946976a12.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743844717; x=1744449517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nTYGIC2V86GVEO1aygBOOi6AdwZ/tlG4VCLyBLagoZQ=;
 b=iCmfQa7CZXLu5GERrStnHBxhomEiTYrMT6dRYYzzZPm4J71etg9VJsAfS5vBfPYxM+
 KBSiadFHdtRU7IK2SFA2SYGgAq2uMzy+N/HsrsGm/GH4NxZUTTf4cdXRVcLUp3fo1Avb
 dg0dBbckDyHlVAcvdkhssCdLtiL930t3esvZWeJqrHcPn1tpdYebujIPPBox/tczHb7u
 wZ98hh5dSvnM5QdkdZUxq2h9m26CNxeIiEp9IHFn0aE6TPHM3twhx0SDglaNk/zSaprs
 PFozZYMcUjL1USXU5nNIxs6NhY/kAd2QJXIwASNPyhzH2x0+jctSYrS5mocJgOlJ+H66
 hLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743844717; x=1744449517;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nTYGIC2V86GVEO1aygBOOi6AdwZ/tlG4VCLyBLagoZQ=;
 b=YYvE8pt+zL+Rt4QvHd1gD6PAVTrJ81avz0iC+2Q2Eo+RlgToehA41FfzS0SmnVnchr
 5xXAfQA+GgaXytHq1OCi3Ul71373ZZe9+rs/mu3WTOmv8mGpcD2eN3x1Zj4mCwD0O6Ve
 yCnJuFmxMw8tyrETaldTk2fqPKebW7VSxq9I2JiBDIOpN8JIweLzXud6uudDRAEJ6Nhv
 XVjE0toPifaFGnCgySFwo/l78R33DvJN+vDVoNuQ04H22azqr71OoChGjvDWQIM6wxgK
 OXPoyL2iiZYS1vwx8L/jUUnLKJkIbwsI5WYo2wn1GAFOyisTWd775sxltShonCcwYqs1
 VFTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLh+tCAzjp6iNW0mYhgpT6chVaZ0gadeqFx8R3dWuTpWZ1Sf7BpZ/ViMHhOtHbpDNZnQEaRL9wMayU@nongnu.org
X-Gm-Message-State: AOJu0YzaljZ+8KO7m2B2FDJSXrsKKET73N5y0n/chJ1RjdWvkGQDLYOR
 +sD6Ms0thbru93K+pHsop2ExcpfgIENC03tcF3D9+ss5F/9gdktfCa2TxhiT1Zo=
X-Gm-Gg: ASbGncvbczL2li+3r0C7qSefxbHeyGpfYP9dAJrTxFvXLp0jowWP1ZXZHKdJlytjOCp
 8h8hC96xeDnyAIVh7l3Wmnr1PTTi1q0k28GznBChJkf7vORHxuBLyZcFj0tKRSn5YAJFEtVQreg
 Y7cv4waJ2SsLkI7GC47w9iZ3S7UG2nqtx7AbfWvs60mf6Qbzn0H9kpFsm7P2U6Za3N7Dr6y6RTq
 HRgGg7IG4oDC9parHsihQQEHedUs2Lgf5BMyA19FoI88aM13XtobwVDCzYrOOu8V3xSMP3LHSMu
 nrj55qcazczdIHK4e4PZPr8ig5gGCMa2dTHjG7tgs5MNYHX94wEzLThppI+x
X-Google-Smtp-Source: AGHT+IGxYxAM6IxII+DllVeVIx/8jCicZm+GCykj9N/3XNn85vhSzbY31PnEDeMsPyT/aEfYOJxgWQ==
X-Received: by 2002:a17:90a:d003:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-306a4865080mr9662924a91.9.1743844716725; 
 Sat, 05 Apr 2025 02:18:36 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785bfea5sm45871935ad.54.2025.04.05.02.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 02:18:36 -0700 (PDT)
Message-ID: <ebcccedf-a11c-4716-bdc2-d06233cad20f@ventanamicro.com>
Date: Sat, 5 Apr 2025 06:18:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] target/riscv: rvv: Apply vext_check_input_eew to
 vector integer extension instructions(OPMVV)
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 antonb@tenstorrent.com
References: <20250329144446.2619306-1-max.chou@sifive.com>
 <20250329144446.2619306-9-max.chou@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250329144446.2619306-9-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52f.google.com
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



On 3/29/25 11:44 AM, Max Chou wrote:
> Handle the overlap of source registers with different EEWs.
> 
> Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
> Co-authored-by: Max Chou <max.chou@sifive.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---


With your co-authored-by tag removed:

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index f397ae46446..728912fc1f2 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3660,7 +3660,9 @@ static bool int_ext_check(DisasContext *s, arg_rmr *a, uint8_t div)
>           require_align(a->rd, s->lmul) &&
>           require_align(a->rs2, s->lmul - div) &&
>           require_vm(a->vm, a->rd) &&
> -        require_noover(a->rd, s->lmul, a->rs2, s->lmul - div);
> +        require_noover(a->rd, s->lmul, a->rs2, s->lmul - div) &&
> +        vext_check_input_eew(s, -1, 0, a->rs2, s->sew, a->vm);
> +
>       return ret;
>   }
>   


