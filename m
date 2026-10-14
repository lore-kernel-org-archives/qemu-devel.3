Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7040CC6B24
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGqdk-0001md-OS; Wed, 14 Oct 2026 00:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGqdj-0001mM-Og
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:30:55 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGqdh-0006Kj-R0
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:30:55 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 58B1F1400174
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:30:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 14 Oct 2026 00:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791952253; x=1792038653; bh=lM/CT7B5lqbOJqRBdRu0ItaKIHBhcrD1
 1c+h6Uw9F+o=; b=O0PJHNZpPZKKwxsmuobWFx/W2wLNTTeLjjqSh/fFjBST9X0B
 miJcuhfNOrYoiEUEADdBAPgqIlg0is5OAbnBmpTXFe8VxWANuc+/JTjMg+KqGPtn
 cW5r60YwqsRft5pkL6qHe6v3Paiio6VecMYFxBPrhcFH5kvYpVqwF2G3Av4+1KRY
 lOVT28uV8yMdZWWcZvMAOVQCN7H45CshXwtjyziKwWtmy015NQQrkdvlqFshX95M
 7obNdTuDy0vZKIPoyNq0R4BHvX1Ll/B/OZzwai27rOa2b0gcWwzONkIoBQBEopBZ
 Nxl9Y6EnXJce+s54jZ/wpgsgiadw5yQFkaCgBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791952253; x=
 1792038653; bh=lM/CT7B5lqbOJqRBdRu0ItaKIHBhcrD11c+h6Uw9F+o=; b=b
 ccKp8gMFV7odpuYp0gguxHy00NCO0xNP3Z/Q5OI7gYqBnAcvfOCMTf3Denax3I3b
 an97KYGobOLqNW+oPxt7j+nmhEzWnAQXvynWTu45D6QpvraUWw4FXvBqGA88YzHR
 7wmfXWG9kLhmoNvcPlxuxhh7AHsXAeQqDBFXfnVcjKxCX5qY8rtn+lDqh68IiH2p
 Xu3N+nlT3QtOQIJceUSeVfzXQ1QNsKN4ylDIVoWIKUwi/6d6gg8VH3EWiLtFWC47
 EMzXvTeR90K/ZvwfkWvlamS+1vAevdyAD0gkNHuONgisO2jtFFWs7vkMKhCDhBdp
 yw0WlsTlA7tbb7WgOczQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791952253; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:my4UYXStLIMZOhzVHCnmqIlP6wNea/wByf2f1HYYobtGaPC
 VCvlFsUzU1g59XMDp6rA7GmWcVTAv/XsuJKYAEYzCIuDBvSZcrX6c+823lgTvrD8
 UNlFjnB1F9vUCJhMLuhxq8UwRJZ/WoSvs10VXxZcj7O9H3WXQGGkeZZLogwsPGCw
 9Ia5ZFHWWquvKX+j6KzePifwRJl9ICcUc9PcnanjPmqUjZKSZwAcdyTKx6tvlhaV
 AtvRSZXCqtStViVpP3tlvobcYPiIowDaANyTgmxi0uEuFvCjFJ0eN8avZan42oIl
 AmMyBakjseWV0IIGjEpvODJWyf8fUXtzlY2nCZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:FfGxxgZyeFBSs/SUFsE0o23L+BGX+i51yzP6+DcV8dY=:J6wXCQHgOhCqleME2xsLiF62Vavg6Uo3GZPHFuuIzRQ=;
X-ME-Sender: <xms:fAXPajU8HbPHotdXduiHuAlSUlsl6U2045gkfqojxGR2HlP_h4jfhg>
 <xme:fAXPaikBlWEyJvtlRjQQ1CsyfScP8qecn-9fCMHwLtEXUMMCT2C3VSx1b00loUVef
 ZntwNPPx8xwYgC5TnF74X5HoGVWAMwvwzo19poYRZ54dCZjTl0r1x0j>
X-ME-Received: <xmr:fAXPakZiMnm-KXKLUsKSuwbzAPG5AeKvW2pfK_6a84AzeNuP1sxaRlM3CgSSo_FJM-xFnFF7PMTr2m59o9dSmy7aHOE>
X-ME-Proxy-Cause: dmFkZTGPS0Z/NKQnuxEzMQacG2rHnkt2QMJOrkL3S65LcYHb6WbKx+TJCtep9sT7Glhfxk
 lZ2oQW/v0vQsZ3sURildClZV1VcfZKLuz+1jpIYtIUkeA6esdPdPM+vCWVj4BL7LI+iR89
 5aJOiMrXsYWLybXtP/MiTdIC2NKW4JrCpYE36LWNkK8n1kpe2o9VjfGT9zuO5FdwD/0h8l
 2sxGY0Y/MnJzj9hqq69h0MOOKfrsE+NNBYu938MP0C5qE7lducrKOi56GNfd3OYLYZZQjw
 FadO9bfzL66AfnlA2OyudPbrmAPBbJsWfNQsrCHLStxUxucTHdS1H+tq1+AbGtV1ohKwId
 t7XR5m5VOOrQjv/Zyd9jJRyB480RpKSS+6JJPR12XHJmJtLyShl54z71L2pJW8XYcgOtB0
 d2+OWFTOkusoPmP8VcK4IbqydDuvuwtJcHVymIGuCYzj+Z1xiflTTZC9U44ql5dChAmBXU
 Du5JFrI97rFjA1cmUcEWIB/2NtCkGIfEJfTRCx5D5YQkr5gth1BJ9yfI0qrz1sm4y6f6Af
 56gPeofA78O0zcwZvR1HFiq05GH4/ayQsY1ShtmWdDuyxJJqXzs/EgkvqVBWyyrn4075sS
 SIvTxteZwj1rgCeKNObA3e0p6f97cysrDEr2aCZY9b40FONVpweL/viSVkYg
X-ME-Proxy: <xmx:fAXPatPJZgRky5FrD7dp8F3G6MVgcuqOXN6VX125r10f8tEMDrcmGQ>
 <xmx:fAXPapa23O71yXHQ_Lq-e6LxApYNidQsPedes4fH6aX8S68ajZWm-Q>
 <xmx:fAXPar3P4rRdqPkYlg94KHwE-zwYhlZTKjGMh93h0YfL2UKI5zcbVA>
 <xmx:fAXPavdUXbtPJvI95HVFSJocMOc5BUUK4rPWyTbhJckp9x9gAvR1cg>
 <xmx:fQXPavuuEYed4d4omi1JzdY6TVosX0S_TdaVnK3q1AUldaa8Qfo9MLXz>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 00:30:50 -0400 (EDT)
Message-ID: <7ac693b6d4f38fe8b23ca487759de0362df31d07.camel@alistair23.me>
Subject: Re: [PATCH v2 22/23] tests/tcg/riscv64: Vector load test
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Joel Stanley <joel@jms.id.au>
Date: Wed, 14 Oct 2026 14:30:49 +1000
In-Reply-To: <20260821040404.268123-23-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
 <20260821040404.268123-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=alistair@alistair23.me; helo=fhigh-a6-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Thu, 2026-08-20 at 21:04 -0700, Richard Henderson wrote:
> From: Joel Stanley <joel@jms.id.au>
>=20
> A userspace program to perform vector loads and stores that cross
> page
> boundaries, and check the result.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20260820130223.2762-2-joel@jms.id.au>

I don't think we need this commit, the next one does the same thing,
but in C instead of assembly

Alistair

> ---
> =C2=A0tests/tcg/riscv64/Makefile.target |=C2=A0 13 +++
> =C2=A0tests/tcg/riscv64/test-rvv-ldst.S | 131
> ++++++++++++++++++++++++++++++
> =C2=A02 files changed, 144 insertions(+)
> =C2=A0create mode 100644 tests/tcg/riscv64/test-rvv-ldst.S
>=20
> diff --git a/tests/tcg/riscv64/Makefile.target
> b/tests/tcg/riscv64/Makefile.target
> index 4da5b9a3b3..68a5ec5255 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -13,6 +13,19 @@ run-test-noc: QEMU_OPTS +=3D -cpu rv64,c=3Dfalse
> =C2=A0TESTS +=3D test-aes
> =C2=A0run-test-aes: QEMU_OPTS +=3D -cpu rv64,zk=3Don
> =C2=A0
> +# Vector load test
> +TESTS +=3D test-rvv-ldst
> +test-rvv-ldst: CFLAGS +=3D -march=3Drv64gcv
> +test-rvv-ldst: LDFLAGS =3D -nostdlib -static
> +run-test-rvv-ldst: QEMU_OPTS +=3D -cpu max
> +
> +# Re-run the vector tests at each supported VLEN
> +TEST_RVV_VLENS =3D 128 256 512 1024
> +EXTRA_RUNS +=3D $(patsubst %,run-test-rvv-ldst-
> vlen%,$(TEST_RVV_VLENS))
> +run-test-rvv-ldst-vlen%: test-rvv-ldst
> +	$(call run-test, $@, env QEMU=3D$(QEMU) $(QEMU) $(QEMU_OPTS) -
> cpu max$(COMMA)vlen=3D$* $<, \
> +		test-rvv-ldst with vlen=3D$*)
> +
> =C2=A0# Test for fcvtmod
> =C2=A0TESTS +=3D test-fcvtmod
> =C2=A0test-fcvtmod: CFLAGS +=3D -march=3Drv64imafdc
> diff --git a/tests/tcg/riscv64/test-rvv-ldst.S
> b/tests/tcg/riscv64/test-rvv-ldst.S
> new file mode 100644
> index 0000000000..939b3f038b
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-rvv-ldst.S
> @@ -0,0 +1,131 @@
> +/*
> + * RISC-V vector load/store page crossing test
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +=C2=A0=C2=A0=C2=A0 .section .rodata
> +=C2=A0=C2=A0=C2=A0 // Page aligned so the within-page cases never cross =
a boundary
> +=C2=A0=C2=A0=C2=A0 .set MAX_PAGE_SIZE, 65536
> +=C2=A0=C2=A0=C2=A0 .balign MAX_PAGE_SIZE
> +src_data:
> +=C2=A0=C2=A0=C2=A0 .byte 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17
> +=C2=A0=C2=A0=C2=A0 .byte 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F
> +=C2=A0=C2=A0=C2=A0 .set NUM_BYTES, . - src_data
> +
> +=C2=A0=C2=A0=C2=A0 .balign MAX_PAGE_SIZE
> +pageA_start:
> +=C2=A0=C2=A0=C2=A0 // Fill the page, stopping 8 bytes short of the bound=
ary
> +=C2=A0=C2=A0=C2=A0 .fill MAX_PAGE_SIZE - 8, 1, 0xfa
> +src_cross_data:
> +=C2=A0=C2=A0=C2=A0 .byte 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27
> +pageB_start:
> +=C2=A0=C2=A0=C2=A0 .byte 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F
> +=C2=A0=C2=A0=C2=A0 .set NUM_CROSS_BYTES, . - src_cross_data
> +
> +=C2=A0=C2=A0=C2=A0 .section .bss
> +=C2=A0=C2=A0=C2=A0 .balign MAX_PAGE_SIZE
> +dst_data:
> +=C2=A0=C2=A0=C2=A0 .space 16
> +
> +=C2=A0=C2=A0=C2=A0 .balign MAX_PAGE_SIZE
> +=C2=A0=C2=A0=C2=A0 .space (MAX_PAGE_SIZE - 8)
> +dst_cross_data:
> +=C2=A0=C2=A0=C2=A0 .space 16
> +
> +.option norelax
> +.option norvc
> +
> +=C2=A0=C2=A0=C2=A0 .text
> +=C2=A0=C2=A0=C2=A0 .globl _start
> +_start:
> +=C2=A0=C2=A0=C2=A0 // Case 1: Load/store within a page. t3 is the exit c=
ode on
> failure
> +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t3, 1
> +=C2=A0=C2=A0=C2=A0 la=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a0, src_data
> +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a1, NUM_BYTES
> +
> +=C2=A0=C2=A0=C2=A0 // SEW=3D8, LMUL=3D1
> +=C2=A0=C2=A0=C2=A0 vsetvli t0, a1, e8, m1, ta, ma
> +
> +=C2=A0=C2=A0=C2=A0 // Check the load will cover 16 bytes
> +=C2=A0=C2=A0=C2=A0 bne=C2=A0=C2=A0=C2=A0=C2=A0 t0, a1, fail
> +
> +=C2=A0=C2=A0=C2=A0 // perform load
> +=C2=A0=C2=A0=C2=A0 vle8.v=C2=A0 v1, (a0)
> +
> +=C2=A0=C2=A0=C2=A0 // Store vector content in memory
> +=C2=A0=C2=A0=C2=A0 la=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a2, dst_data
> +=C2=A0=C2=A0=C2=A0 vse8.v=C2=A0 v1, (a2)
> +
> +=C2=A0=C2=A0=C2=A0 // Compare first half
> +=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t1, 0(a0)
> +=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t2, 0(a2)
> +=C2=A0=C2=A0=C2=A0 bne=C2=A0=C2=A0=C2=A0=C2=A0 t1, t2, fail
> +
> +=C2=A0=C2=A0=C2=A0 // Compare second half
> +=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t1, 8(a0)
> +=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t2, 8(a2)
> +=C2=A0=C2=A0=C2=A0 bne=C2=A0=C2=A0=C2=A0=C2=A0 t1, t2, fail
> +
> +=C2=A0=C2=A0=C2=A0 // Case 2: Load straddles a page boundary
> +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t3, 2
> +=C2=A0=C2=A0=C2=A0 la=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a0, src_cross_data
> +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a1, NUM_CROSS_BYTES
> +
> +=C2=A0=C2=A0=C2=A0 // SEW=3D8, LMUL=3D1
> +=C2=A0=C2=A0=C2=A0 vsetvli t0, a1, e8, m1, ta, ma
> +=C2=A0=C2=A0=C2=A0 bne=C2=A0=C2=A0=C2=A0=C2=A0 t0, a1, fail
> +
> +=C2=A0=C2=A0=C2=A0 // perform load
> +=C2=A0=C2=A0=C2=A0 vle8.v=C2=A0 v1, (a0)
> +
> +=C2=A0=C2=A0=C2=A0 // Store vector content in memory
> +=C2=A0=C2=A0=C2=A0 la=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a2, dst_data
> +=C2=A0=C2=A0=C2=A0 vse8.v=C2=A0 v1, (a2)
> +
> +=C2=A0=C2=A0=C2=A0 // Compare first half
> +=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t1, 0(a0)
> +=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t2, 0(a2)
> +=C2=A0=C2=A0=C2=A0 bne=C2=A0=C2=A0=C2=A0=C2=A0 t1, t2, fail
> +
> +=C2=A0=C2=A0=C2=A0 // Compare second half
> +=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t1, 8(a0)
> +=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t2, 8(a2)
> +=C2=A0=C2=A0=C2=A0 bne=C2=A0=C2=A0=C2=A0=C2=A0 t1, t2, fail
> +
> +=C2=A0=C2=A0=C2=A0 // Case 3: Store straddles a page boundary
> +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t3, 3
> +=C2=A0=C2=A0=C2=A0 la=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a0, src_data
> +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a1, NUM_BYTES
> +
> +=C2=A0=C2=A0=C2=A0 // SEW=3D8, LMUL=3D1
> +=C2=A0=C2=A0=C2=A0 vsetvli t0, a1, e8, m1, ta, ma
> +=C2=A0=C2=A0=C2=A0 bne=C2=A0=C2=A0=C2=A0=C2=A0 t0, a1, fail
> +
> +=C2=A0=C2=A0=C2=A0 // perform load
> +=C2=A0=C2=A0=C2=A0 vle8.v=C2=A0 v1, (a0)
> +
> +=C2=A0=C2=A0=C2=A0 // Store vector content in memory
> +=C2=A0=C2=A0=C2=A0 la=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a2, dst_cross_data
> +=C2=A0=C2=A0=C2=A0 vse8.v=C2=A0 v1, (a2)
> +
> +=C2=A0=C2=A0=C2=A0 // Compare first half
> +=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t1, 0(a0)
> +=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t2, 0(a2)
> +=C2=A0=C2=A0=C2=A0 bne=C2=A0=C2=A0=C2=A0=C2=A0 t1, t2, fail
> +
> +=C2=A0=C2=A0=C2=A0 // Compare second half
> +=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t1, 8(a0)
> +=C2=A0=C2=A0=C2=A0 ld=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t2, 8(a2)
> +=C2=A0=C2=A0=C2=A0 bne=C2=A0=C2=A0=C2=A0=C2=A0 t1, t2, fail
> +
> +pass:
> +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a0, 0
> +=C2=A0=C2=A0=C2=A0 j=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit
> +
> +fail:
> +=C2=A0=C2=A0=C2=A0 mv=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a0, t3
> +
> +exit:
> +=C2=A0=C2=A0=C2=A0 li=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a7, 93=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // sys_exit
> +=C2=A0=C2=A0=C2=A0 ecall

