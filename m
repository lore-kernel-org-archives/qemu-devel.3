Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A117FCC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGqfN-0002Wz-83; Wed, 14 Oct 2026 00:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGqfK-0002W4-J5
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:32:34 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGqfI-0006Nu-R7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:32:34 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 61FB314000E8
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:32:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 14 Oct 2026 00:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791952352; x=1792038752; bh=6DkRl7kRZZVdIWogHkPkQva3vrk95NIK
 rlSnCRW6YSY=; b=VxW1aVJFLcSu7i2V7GWZG6bkiLGnSKGCssKsMP4TD1b8QFXP
 I1upP5+2Eq/WsmyGatGJkPBoBlDKcSdYx8uMmX8hDIc1ld7Vx4wjkcQJlZpNjcD3
 g3//+9v5YphV1rifh0oHw5736bXZ6TtfYqemJddpCrAxtteBbu0gIHzO0Wfr3ry7
 Ms6fdSCcFoB89SnLORMNq5ENs1y6pD3H7VZzZ64Aurl5RUW7mU7mQBouuXjJxBQR
 c4LeEgTgtqbruUAcAuYklgTX5nTE+xxcDShkR1mbSPsl865Dzspyxp0K6tsqCPCx
 cjCGO1SD8QwPojCm8ZqdQNdJpfleUhGBTL9cnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791952352; x=
 1792038752; bh=6DkRl7kRZZVdIWogHkPkQva3vrk95NIKrlSnCRW6YSY=; b=y
 VucKSRDcQiyOP42oUJupGBg1vmQwg1A+mhLj9leaGsDkg+emrWz4Vwnp1yAttp+b
 daVqRHoQMGQuREsID0/JNQ6WCteGd8acaMkiTSS/kZbOx7g1QofnXCUNw3Q0NcBF
 IE40CekfSMPxw6mEbgUJXbS+XfZeA6oD3mc0lWj4Id+7wqBqSlU0CJjLb3sNe4AV
 a62sDQiJPW6F/kxxWpvY5rFdLj0x41uxD2xWYnaim9yynQYD+LXuGm4zXqHVsWJU
 tgaroa8nN0oTJzf50ZpxyBmoxh0qiZvz0uBXPg7S8TuHlaWruzabXD4SULs1cnWx
 aWnhvGduDs30SI2xKlBQQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791952352; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:GH0KierDyHzyTx8/ePM7ybsMEHs7mUSMMUmRjF96D3LFKqm
 Gp2mxRzsCzV/T5AueW8oIWNwg2eabms7PE+7XUQeD3RiF9q2KMH2AFlz/Tz4PPq8
 W1YtzZ5nl0/KDPXCJRE8BPuXk51DOtT8WY4BxNksSYglErn7ssu6gaJWV61hgI6m
 1vwtotUt/V/u22iKZjKn5X0e9gOGl7+Fq4Q/h0WPCTyS6u9JuPC+CgsFrhgqAtMl
 fdrOlgjvI1CZUxYeUStQ9MDMV4xNGkZHGmWCfTmMWM+uPcJENyuzIPsXKMll48sJ
 RI9YjYiVIfGu7WUimO19LrP8JVyqQBrrWnpxLtg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:qoks9OKYd7Vvs4Mue3mY7ZYBg17gYWK66JVy875B39E=:0islH7p5OTzPcl5Ja5UMYVET0jL8TwOCujqWK02nv8E=;
X-ME-Sender: <xms:4AXPaugS5eMXOTGPwzNpg8Z4IeBjFAJp5FdepwjUNTgM7nfXmtxjcA>
 <xme:4AXPamA9lNjGqDZiyPJstcxkC9JsRpLEgC_UwlPDcl18AtrCXf1fIszJ88PeEl6Eq
 VzczFEL_zUzMRKHaQSyx263gQMZUIu9dCsCOTSyMeY8Aij4BCMwJEs>
X-ME-Received: <xmr:4AXParFvrKjuTkZoSQlNwSOCcZzGNqcHxAJqPo_3QDSd5Z71VnIGgt9wCZrIhkLZtlxhW_IALz0RsweAZs_9k3LWt8k>
X-ME-Proxy-Cause: dmFkZTFZtuybhqVnendDnJHpr4pboO8OE3AIPybSmcUCH0Xi1Yu79soWKsx72W8llljxcW
 srFJO/ujMDFWdau10lekZ/X+oFTePpalbRDWxhin7KDtbCWHlQunjGtJSQEs/GaVlPhQRz
 NN0XbQ0Ha4xaTVfTB7rHf+IpI7BKxoRox8xj7EwEUHLa/w9ytlxiz1q1UxWSR10lP6m1GY
 kSD1w/R+WkR3/jeQctVN2AFbpnSTvuqrtp7kwkXM4C7sPRUKb3m8CM+wHD10pzGvzHau9U
 Su/C/V3mvcfWw+EMy4VyBVZrw7ZkhNXJRYubDvInuR+LXrSxElc0nhgYPGuoaTUSgO1Gku
 boHLqgdJ0C1DnIyCrpzn39TGdLvwHB0wwUO+LRrnzSMEQf+uYvohe9BZdh+KeIwru2F2kp
 zpFg5TpMrp53Fm5nNoNMDwwZvKwxU/p9YkDp9ICucxgsfwgaCANm00Fw2uPGSbsMuFGP3+
 +mwdlsBXMg3NU8bMk/Aj4dq+iVKSLvWqY6G2mRLxBuWZRaNTVfaMVahcirQxKwiyKIz8uV
 /ZBBywVnOfpAqKZKOVdEA1YqgOslLfwRHXHhZ4IJKZE3YsTJ87RXaGv6GVZ+HR0sHbfzCS
 97oSEXv7FymeONi/Asyv6Zip5X11kvKoQNxnGbwJsGlo8L21tiFyFG542bcw
X-ME-Proxy: <xmx:4AXPamKiEAwtIQ1IlRZ6ea7WrYKx5KPMviZ83XK9O5aesAcP6y8ewg>
 <xmx:4AXPanllknDrn5ykCam5oOP-p5wqS0QsR6dLGR6GjUt7YNYUaEDCQg>
 <xmx:4AXPamQ4oj1AUaEMeNENaVq-uCjDN_n_ff7jl-xpM4RNR3r7o1HcLw>
 <xmx:4AXPahLu1jgDApJXVT8SDtbuqciaYOGNO0e5xYh1V7l_SirXOGfdBQ>
 <xmx:4AXPajLyDnYFpsCKxM7Yo_ZBl1qWCAHpnsBtbLSQF-sWwIsqJAW1Atoy>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 00:32:30 -0400 (EDT)
Message-ID: <bb575bfb20e83057f36c83b9635c73e06e9abc25.camel@alistair23.me>
Subject: Re: [PATCH v2 23/23] tests/tcg/riscv64: Add intrinsics version of
 test-rvv-ldst
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Joel Stanley <joel@jms.id.au>
Date: Wed, 14 Oct 2026 14:32:28 +1000
In-Reply-To: <20260821040404.268123-24-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
 <20260821040404.268123-24-richard.henderson@linaro.org>
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
> A C userspace program to perform vector loads and stores that cross
> page
> boundaries, and check the result.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20260820130223.2762-3-joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0tests/tcg/riscv64/test-rvv-ldst-intrinsics.c | 66
> ++++++++++++++++++++
> =C2=A0tests/tcg/riscv64/Makefile.target=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +++-
> =C2=A02 files changed, 75 insertions(+), 3 deletions(-)
> =C2=A0create mode 100644 tests/tcg/riscv64/test-rvv-ldst-intrinsics.c
>=20
> diff --git a/tests/tcg/riscv64/test-rvv-ldst-intrinsics.c
> b/tests/tcg/riscv64/test-rvv-ldst-intrinsics.c
> new file mode 100644
> index 0000000000..3dbc862470
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-rvv-ldst-intrinsics.c
> @@ -0,0 +1,66 @@
> +/*
> + * RISC-V vector load/store test, including accesses that cross a
> page
> + * boundary. Intrinsics version of test-rvv-ldst.S.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <riscv_vector.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#define MAX_PAGE_SIZE 65536
> +#define NUM_BYTES 16
> +
> +struct cross_page {
> +=C2=A0=C2=A0=C2=A0 uint8_t pad[MAX_PAGE_SIZE - NUM_BYTES / 2];
> +=C2=A0=C2=A0=C2=A0 uint8_t data[NUM_BYTES];
> +};
> +
> +/* Page aligned so the within-page cases never cross a boundary */
> +static const uint8_t src_data[NUM_BYTES]
> +=C2=A0=C2=A0=C2=A0 __attribute__((aligned(MAX_PAGE_SIZE))) =3D {
> +=C2=A0=C2=A0=C2=A0 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
> +=C2=A0=C2=A0=C2=A0 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
> +};
> +
> +static const struct cross_page src_cross
> +=C2=A0=C2=A0=C2=A0 __attribute__((aligned(MAX_PAGE_SIZE))) =3D {
> +=C2=A0=C2=A0=C2=A0 .data =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x20, 0x21, 0x22, 0x23, 0x24,=
 0x25, 0x26, 0x27,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x28, 0x29, 0x2A, 0x2B, 0x2C,=
 0x2D, 0x2E, 0x2F,
> +=C2=A0=C2=A0=C2=A0 },
> +};
> +
> +static uint8_t dst_data[NUM_BYTES]
> __attribute__((aligned(MAX_PAGE_SIZE)));
> +static struct cross_page dst_cross
> __attribute__((aligned(MAX_PAGE_SIZE)));
> +
> +static void vec_copy(uint8_t *dst, const uint8_t *src, int code)
> +{
> +=C2=A0=C2=A0=C2=A0 size_t vl =3D __riscv_vsetvl_e8m1(NUM_BYTES);
> +=C2=A0=C2=A0=C2=A0 if (vl !=3D NUM_BYTES) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(code);
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 vuint8m1_t v =3D __riscv_vle8_v_u8m1(src, vl);
> +=C2=A0=C2=A0=C2=A0 __riscv_vse8_v_u8m1(dst, v, vl);
> +
> +=C2=A0=C2=A0=C2=A0 if (memcmp(dst, src, NUM_BYTES)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(code);
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> +int main(void)
> +{
> +=C2=A0=C2=A0=C2=A0 /* Case 1: load/store within a page */
> +=C2=A0=C2=A0=C2=A0 vec_copy(dst_data, src_data, 1);
> +
> +=C2=A0=C2=A0=C2=A0 /* Case 2: the load straddles a page boundary */
> +=C2=A0=C2=A0=C2=A0 vec_copy(dst_data, src_cross.data, 2);
> +
> +=C2=A0=C2=A0=C2=A0 /* Case 3: the store straddles a page boundary */
> +=C2=A0=C2=A0=C2=A0 vec_copy(dst_cross.data, src_data, 3);
> +
> +=C2=A0=C2=A0=C2=A0 return 0;
> +}
> diff --git a/tests/tcg/riscv64/Makefile.target
> b/tests/tcg/riscv64/Makefile.target
> index 68a5ec5255..3c6cd4937c 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -14,10 +14,11 @@ TESTS +=3D test-aes
> =C2=A0run-test-aes: QEMU_OPTS +=3D -cpu rv64,zk=3Don
> =C2=A0
> =C2=A0# Vector load test
> -TESTS +=3D test-rvv-ldst
> -test-rvv-ldst: CFLAGS +=3D -march=3Drv64gcv
> +TESTS +=3D test-rvv-ldst test-rvv-ldst-intrinsics
> +test-rvv-ldst-intrinsics test-rvv-ldst: CFLAGS +=3D -march=3Drv64gcv
> =C2=A0test-rvv-ldst: LDFLAGS =3D -nostdlib -static
> -run-test-rvv-ldst: QEMU_OPTS +=3D -cpu max
> +test-rvv-ldst-intrinsics: LDFLAGS =3D -static
> +run-test-rvv-ldst-intrinsics run-test-rvv-ldst: QEMU_OPTS +=3D -cpu
> max
> =C2=A0
> =C2=A0# Re-run the vector tests at each supported VLEN
> =C2=A0TEST_RVV_VLENS =3D 128 256 512 1024
> @@ -26,6 +27,11 @@ run-test-rvv-ldst-vlen%: test-rvv-ldst
> =C2=A0	$(call run-test, $@, env QEMU=3D$(QEMU) $(QEMU) $(QEMU_OPTS) -
> cpu max$(COMMA)vlen=3D$* $<, \
> =C2=A0		test-rvv-ldst with vlen=3D$*)
> =C2=A0
> +EXTRA_RUNS +=3D $(patsubst %,run-test-rvv-ldst-intrinsics-
> vlen%,$(TEST_RVV_VLENS))
> +run-test-rvv-ldst-intrinsics-vlen%: test-rvv-ldst-intrinsics
> +	$(call run-test, $@, env QEMU=3D$(QEMU) $(QEMU) $(QEMU_OPTS) -
> cpu max$(COMMA)vlen=3D$* $<, \
> +		test-rvv-ldst-intrinsics with vlen=3D$*)
> +
> =C2=A0# Test for fcvtmod
> =C2=A0TESTS +=3D test-fcvtmod
> =C2=A0test-fcvtmod: CFLAGS +=3D -march=3Drv64imafdc

