Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D8606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.a=rsa-sha256 header.s=google header.b=f6TfCMVE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZ6O-0006x2-VF; Mon, 23 Nov 2026 13:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philipp.tomsich@vrull.eu>)
 id 1xVZ6N-0006wk-IR
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:49:19 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philipp.tomsich@vrull.eu>)
 id 1xVZ6L-0004mN-Be
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:49:19 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c50692e6c0aso68095966b.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:49:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795459754; cv=none;
 d=google.com; s=arc-20260327;
 b=RWawe1HPfFOo6U/ow/eMqCAwELuwwFlVx3RD6nTq27wpzfY4S1UfU+Brx+1AcckrMy
 Si/N5uRjXZSioVHy9fW/W2xlHoRXW1djJkLTJW57CyBg98SrNyNpcnZ/FnFLwIowjK6Q
 J7hrbuG1zcWzWRkLS0YhRuTuo3KxNUF4Xw5mog+K62VUAxe6eaOprbSIP3GZ5E90P2Yn
 H6l0V1uCVHEHbalPy7ANk1+wPwAHUmjwETWJMkU2h0TvIGW44CyCmtjmFe29Xtpdekkw
 uAx7xV6RDLgPnfzyA91U3G+nYPxD6J/UpdX6PMImqFNuDIilcpOcgKtmc/2lgAlKp090
 8ieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H3vKXMAflPu8ciMnikCd2ZlI0IVNDNTpnFzIttGhauo=;
 fh=MvhRrqu2i8mxDRH1wr4tXkxOt0dA0cq3cs9EEHZHF+8=;
 b=qXNMaS8mdrMMhyMbXLliEgnaeYByqkPXpZwPWWnPMDRB7YA+SVmJRqeKYYZUtnFXkV
 mYXvkBUIW3AzBIIa0q8EDmsF+34V5iqJsmRxDyJKO+ebiQVU6kfu966SUmPn36dsGVAG
 MgoxPA5vunsSO6Gf4whkkWAZS6kdEfDQ3971fgL8pofuOkEQwHetilwNy20P6JeeVhDO
 A9ZMGTh0ZPEP/grSQXzx9TcYfMqV6FQLq/KoRZIChty/cI6zrBlrDEi35fS4RwvMhQ+f
 LJFoh9kvaBdblKj9hVp0EAb3DWTg27xjN6YGpwym0WKW+/wNBO2v12IDp3s5qhhF+9Z9
 wK8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1795459754; x=1796064554; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H3vKXMAflPu8ciMnikCd2ZlI0IVNDNTpnFzIttGhauo=;
 b=f6TfCMVEd70xHbhDQLkn0rOZaNEAmMaHCdQ9D26dRkpyouUAJahOEW5xx4F1tfpIHB
 RPQtLDYlbuW9mBkZuURQSsxYVUzC9krg+MNBGNfsktp9fK4AZ3fSgm5MwFhXk9XwglTn
 ckbNmCLkXsPb8kRdNybzWfdCxkTq9OtoxOFFxMcv0Rp2tr1NJk1NosTzsYSId/EdJM6A
 Gp2DC94ZCSz8aqh5i4jSkyTgWCeTBewcov4UhbbT0QxtqLUsiNzOL7QosCSsl0xRYZaj
 O0mKmby6Umuq4I+mpc82iSDPxvB8r2MzkBsnkAoWFbJrisLe2JXOfALG8CovyDN9c0UA
 sVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459754; x=1796064554;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H3vKXMAflPu8ciMnikCd2ZlI0IVNDNTpnFzIttGhauo=;
 b=lY0SFxYTB+LIe4tGb05pGSL3wPNByNEWsFU7ulemlz82dlaXnSH4g2lC4efka1uyDH
 /wDECcvVVJG0rt2/NBaHaulwHCMSWQ0CVU+bBOhw/+tDiFSUaTda/XuGIKuDrqwVxFMb
 8njMvFQQaw+bU2GsVCwtXOMB5a2RppAvThZj31TcIN3IyWhJoiLWJQqM5f7m+E8L9J0C
 Cg0FkH/aUg3cjM5RFp8RvzwyWXfwNNBwtWuldQhMAvrIQen/kkP/1lRnDSVJjtqabPDC
 3JowYbET19nLi6+58LtwVPoU7IpMKFpVm8vjbXliQaMJs/Sg5qEJcbu+HezvJvfXvnEi
 tF+g==
X-Gm-Message-State: APuU4Z+zbY8V3IcdJa3QMPvRMg3IAHFAHDsrBVBL0EgYQL+Cv5Gvyf7i
 KO2RkHexb+A8IPbsl/KoSQDMmQDOjTDf/DBzGTAFmR0div25BlBuTZWDuPHSjq4ATfY8Z9cfdIm
 AZOLl03ExXl5hgcO34n59BrpRzeeut7LSGeTLN8wmYA==
X-Gm-Gg: AZFdTZfdx2sxOmxkr3flRLiGPxHEMu8RQuexgGtNR4DtXL7q3+TQLQJwc+nfSzJBkb5
 y66VdAGBPrbtSmna0OIjyQct4cEZbQX0c9fRC/ofQ3zEabqEYWkO8PUv3zxZgTlWl5sc6SZ3YaL
 vbljs7/Uw4TzQNh2wnMGF3lDTfjfm+jb9OzHSjSzCoJxzhT1HYTwN7Aep4Jb+D7WAzAmA9Dxj9Q
 pK/48MMYhQo8Uh7zRCKdA64x8xt7cefjcr7P9S5nJZVbKUOqtvb7ps9/AndKmWUjE/KZyBjl/rN
 LyGp/n9uH4aKB76uoqWAFfmGj/M/EE35ufPe1Xlk3DNnAOwWOJBmOBoNBEymgadReeEzbWtYn8r
 5iF69RjDMgl++FBaY3D6/xY/ksBmCfaU5Guc0pkjbCVLDpEM4ynASyIFG/7eQIBKEtRFugFWD4l
 vbswV/ah4E3dz9+w==
X-Received: by 2002:a17:906:3513:b0:c51:3808:8026 with SMTP id
 a640c23a62f3a-c513a53d964mr927634466b.3.1795459754529; Mon, 23 Nov 2026
 10:49:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
In-Reply-To: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
From: Philipp Tomsich <philipp.tomsich@vrull.eu>
Date: Mon, 23 Nov 2026 19:49:03 +0100
X-Gm-Features: Aa3M54peIETSo0bMXfkCi6XNmUlOo53xehP8su23dIJ5r_mdLYEY8fi00bWZBwc
Message-ID: <CAAeLtUAfoRHoesNXTaVCtXxqhdhcwgi8KmT=x32e=eC9uonTjA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] RISC-V: Experimental fetch support for 48-bit and
 64-bit instructions
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philipp.tomsich@vrull.eu; helo=mail-ej1-x634.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 at 10:04, TANG Tiancheng <lyndra@linux.alibaba.com> wrote:
>
> QEMU's RISC-V TCG implementation currently supports only 16-bit
> compressed instructions and 32-bit instructions. This series adds
> experimental support for fetching 48-bit and 64-bit instructions and
> for halfword alignment, following Zl draft 65c377a [1].
>
> This work is motivated in part by an AME proposal that encodes operand
> datatypes in instructions and is still under evaluation [3]. Larger
> immediates and longer-range direct calls are other uses under discussion
> [1,2]. This series provides instruction-fetch, alignment and trap-reporting
> support for long instructions, without implementing individual instruction
> semantics.
>
> The x-zl CPU property is disabled by default and supported only under
> TCG. When enabled, the translator and built-in disassembler share the
> length rules, and halfword alignment does not require C/Zca. Compressed
> decoding remains disabled if C/Zca are disabled. Complete 48/64-bit
> encodings still raise illegal-instruction exceptions, and the
> disassembler prints "unknown".
>
> For an undefined length, fetching stops after the third 16-bit parcel
> and no instruction bits are reported. This avoids additional fetches
> solely for trap reporting. Feedback on this choice would be useful.

QEMU advertises Sstvala/Shvstvala on every CPU at priv >= 1.12 (they
show up in riscv,isa), and Sstvala requires stval to hold the faulting
instruction for illegal-instruction exceptions.  For an encoding
longer than ILEN that is the first ILEN (64) bits, so parcel D must be
fetched. Details on 6/8.

> Patch 1 fixes incomplete instruction reads in the disassembler and can
> be taken independently of Zl support.

Given that 1/8 is a standalone fix, it could go in now.  Just submit
it as a separate fix.

> The code was built for RV32/RV64 user and system emulation. RV32/RV64
> bare-metal tests check RAM-boundary fetches and trap values, halfword
> jumps and returns, and rejection of compressed instructions with C/Zca
> disabled. The Zl tests and existing MEPC regression passed with Capstone
> enabled and disabled.
>
> [1] https://github.com/riscv/riscv-long-instruction/blob/65c377a665feb29a4848384ad566a9873c5fd423/src/unpriv/zl.adoc
> [2] https://github.com/riscv/riscv-isa-manual/pull/3269#issuecomment-5328426143
> [3] https://riscv.atlassian.net/wiki/spaces/AMEX/pages/2445836308/2026-11-09+AME+Meeting+Notes

This link is not publicly accessible; please drop it or point to a
public document.



>
> ---
> TANG Tiancheng (8):
>       disas/riscv: Reject incomplete instruction reads
>       target/riscv: Share instruction length helper
>       target/riscv: Prepare Zl instruction alignment
>       disas/riscv: Decode Zl instruction lengths
>       target/riscv: Limit instruction bits to the trap CSR width
>       target/riscv: Fetch 48-bit and 64-bit instructions
>       target/riscv: Enable experimental Zl fetch support
>       tests/tcg/riscv: Check Zl fetching and halfword alignment
>
>  disas/riscv.c                               |  49 ++++++---
>  disas/riscv.h                               |   4 +-
>  target/riscv/cpu.c                          |   6 +
>  target/riscv/cpu.h                          |  10 +-
>  target/riscv/cpu_cfg_fields.h.inc           |   1 +
>  target/riscv/insn_length.h                  |  29 +++++
>  target/riscv/internals.h                    |  17 +--
>  target/riscv/tcg/cpu_helper.c               |   7 +-
>  target/riscv/tcg/csr.c                      |   7 +-
>  target/riscv/tcg/insn_trans/trans_rvi.c.inc |   8 +-
>  target/riscv/tcg/op_helper.c                |  10 +-
>  target/riscv/tcg/translate.c                | 101 ++++++++++++-----
>  tests/tcg/riscv/zl/zl.S                     | 165 ++++++++++++++++++++++++++++
>  tests/tcg/riscv32/system/meson.build        |   9 ++
>  tests/tcg/riscv64/system/meson.build        |   9 ++
>  15 files changed, 359 insertions(+), 73 deletions(-)
> ---
> base-commit: f29ccc287a6cfdd51d3a4fd17fbe9af3310a0ac5
> change-id: 20261117-zl-master-8ebcaae0953f
>
> Best regards,
> --
> TANG Tiancheng <lyndra@linux.alibaba.com>
>
>

