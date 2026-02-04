Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC4BE9D3FF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 15:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnee9-0008S4-CM; Wed, 04 Feb 2026 10:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnee5-0008RV-Pf
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 10:18:23 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnee3-00006u-P8
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 10:18:21 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c5513f598c0so412227a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 07:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770218298; x=1770823098; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=31BOYmLeN1npOnZ6XRpXqnHnmcW8ZQa8G2U7aOV7wSE=;
 b=aiA2pzeHrzOaEc5EHg8vq+67agdQy5s8jP7lpzD3CGCk/ypQJnL6WmwZCgsAlJIFlL
 wQkPHiN9FoQFjwD6oaFzWneMN7rQuBKFtqzliyB8JwlkIrq5bEwi/E/egJIFhXpHRCzC
 WmOvqAdv20wavcuzv7U0nMeCIqOK0vHniRB6zdx2QAjQqNiso03pbs7oaPepyBMEP+FW
 SgTwpqKKhTtuzHGQaw8qNhY61NytSaxcUbVdxBKOtoATRrxdkkQgHzkjJ6t1/4veOxsP
 ia0JX+WcRDWYUzlNKo02f3JWaYzcpkUvRpnDgqhiMJEnY0K+zoSu93OLfQNhE/JoLKiR
 WIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770218298; x=1770823098;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31BOYmLeN1npOnZ6XRpXqnHnmcW8ZQa8G2U7aOV7wSE=;
 b=QkzkP7QeyYQ0QU9/l1Qa/r82N/QCVulgflosE5Amongz9G+hkt6ru6qJcdRwFt6XfI
 ehkK4wshai0OTHthhEjYca5Ex107vdBZzuFRnsR0mHqz4Jg1Z9NYg9CjVzM8D4Sy0T+X
 FZfROT/giS6u7W5u5glFZkyeYFBbP8diT4ZKwqOSPHUCfTdCqaD6wCtDLvfkGvyftQHY
 hWkJKdf1Op7BvaF94M/6OnQY8SQaHm3S5cEtAKarU5wAdmL5fih5uEC4dff2Nq2AGm8d
 RyIOfes3joxlao8/O7eva4Drn8cRo5eDIVjZqOHk81GFcHHeHg/DW32GwYqpmemykCAc
 xGFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgpJMLBERDp1pURJLcdGgcz+nvGZC2Htb4NsDxFkNKoz4PjErRDS3R7JqFvqFl9i9mNphUcjZkwnSn@nongnu.org
X-Gm-Message-State: AOJu0YzH0HiCmz4Jp6276f967rcD+KqK0n+bGE5wv+Lj27GyAEYewSnT
 At/H/hhWo2JESH8ypgoKQ/U3RbOc16fVWcMbON4WwClw7cHYcUTPBH7HEueXeNw4g0w=
X-Gm-Gg: AZuq6aIFzp1oYiGh8PenymXST2wI3QLmPU2bhEqrjvpHjSYLzoIEM5zqUaVB4ujuDYy
 I6eH+kG5pNChKdCyJSifxH15fF5mjWC1D+ICErplHUCNvNi2A9M3uQkrB88ynPwYijVetz18sZ3
 1anqpi9as8syTh/BsaYTk5hYmj5yE0It9v8uUBfpPrQ2olQdZHr4H8SQbECRd3vBlBkoc/A+/gt
 i3INMVEAVEToQa6er7PX2sJMJfFHeyswhWHAGUBj7A6CnHloQKuOfv+gy3jRAPbaC6oK0CGRsQG
 neQMy+QMI4d/qS+/79PlkLzxLlpop+kom+MEjjBcYkjeTn78Kw5WcTcGsI1VejEThvHmy53oBI9
 o086dIrbVcSM4u5DyWpbJm11FaMRWkdCCbajbnNY0l10+iGDqXbWOghGEUx9PwxLsiB7KKkDP0q
 JmCY3h6rrjn4tMEhVbPGqefkjfV/wxJh4AyXv65iVnetYMZ94SuqUO
X-Received: by 2002:a17:90b:57e8:b0:34a:e9b:26b1 with SMTP id
 98e67ed59e1d1-354871e1a4dmr2853759a91.26.1770218297853; 
 Wed, 04 Feb 2026 07:18:17 -0800 (PST)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354894c2c0dsm944601a91.12.2026.02.04.07.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 07:18:17 -0800 (PST)
Date: Wed, 4 Feb 2026 23:18:13 +0800
From: Max Chou <max.chou@sifive.com>
To: Sebastien Michelland <sebastien.michelland@inria.fr>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Jean-Michel Gorius <jean-michel.gorius@irisa.fr>
Subject: Re: [PATCH] target/riscv: fix vs*r.v missing SIGILL check
Message-ID: <aYNhZQC7_JRrBNlU@sifive.com>
References: <20260126172246.2521444-1-sebastien.michelland@inria.fr>
 <81d962d8-52fb-4203-a3fc-f3980b8a93bb@ventanamicro.com>
 <2132391437.15681684.1769606774227.JavaMail.zimbra@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2132391437.15681684.1769606774227.JavaMail.zimbra@inria.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x533.google.com
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

On 2026-01-28 14:26, Sebastien Michelland wrote:
> 
> >> GEN_LDST_WHOLE_TRANS checks for require_rvv but it's always true, even with
> >> e.g. -cpu=rv32,v=false.
> >> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> >> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> >> @@ -1235,6 +1235,7 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1,
> >> uint32_t nf,
> >>   static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                   \
> >>   {                                                                           \
> >>       if (require_rvv(s) &&                                                   \
> >> +        vext_check_isa_ill(s) &&                                            \
> >>           QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                   \
> >>           return ldst_whole_trans(a->rd, a->rs1, ARG_NF, ctzl(sizeof(ETYPE)), \
> > >                                   gen_helper_##NAME, s, IS_LOAD);             \
>
Hi Sebastien,

Thank you for this patch and for identifying this bug.

But I think that the proposed fix of adding vext_check_isa_ill to whole
register load/store instructions will violate the RISC-V vector specification.

There is an existing comment in trans_rvv.c.inc:

    /*
     * load and store whole register instructions ignore vtype and vl setting.
     * Thus, we don't need to check vill bit. (Section 7.9)
     */

The RISC-V unpriviledge specification (31.3.4.4. Vector Type Illegal (vill))
states that whole register load/store instructions do not depend on vtype:

    "If the vill bit is set, then any attempt to execute a vector instruction
    that depends upon vtype will raise an illegal-instruction exception.
    NOTE: vset{i}vl{i} and whole register loads and stores do not depend
    upon vtype."

- https://github.com/riscv/riscv-isa-manual

This means whole register instructions (vl*r.v, vs*r.v) should not check
the vill bit.

The Spike reference implementation confirms this interpretation. Whole
register instructions use require_vector_novtype which does not check vill,
while regular vector instructions use require_vector which does:

    // riscv/v_ext_macros.h - used by vl*r.v, vs*r.v
    #define VI_ST_WHOLE \
      require_vector_novtype(true); \
      ...

    // riscv/decode_macros.h
    #define require_vector_novtype(is_log) \
      do { \
        require_vector_vs;    // Only checks VS status
        ...
      } while (0);            // NO vill check!

    #define require_vector(alu) \
      do { \
        require_vector_vs;
        require(!P.VU.vill);  // Checks vill
        ...
      } while (0);

- https://github.com/riscv-software-src/riscv-isa-sim

With this patch, whole register load/store instructions would incorrectly
raise illegal instruction exceptions when vill=1, even though the V extension
is enabled.

I would recommend that we should fix this bug at riscv_get_tb_cpu_state by
checking the CPU configuration in CONFIG_USER_ONLY block (user mode) to
ensures require_rvv returns false when the vector is disabled.

Thanks,
rnax

