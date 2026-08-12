Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FAFC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCuQ-0000cy-B3; Wed, 12 Aug 2026 13:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuCuP-0000ci-24; Wed, 12 Aug 2026 13:38:33 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuCuN-0006XU-Eh; Wed, 12 Aug 2026 13:38:32 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 996C7140008E;
 Wed, 12 Aug 2026 13:38:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 12 Aug 2026 13:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786556310; x=1786642710; bh=WCgtYfBD5RzWqrtCYloQc4gxMkBtntG8
 sQmZBuCvDpk=; b=wRqVL3JARccC+z2PvSZ4rY0gvtAWs+sUupss/fR1K0HkZFSB
 gWRAR95jy8+q0ibBdJ3d07wBpso+qFc4sKAu+9t9A13uy2taBBZPExJnQPPH1ZD8
 jRM3cNASRIbWwLbiXs8SOR3r7uTeBBKmX6ivXOAGnzNvltYgz962cxs+BEeWTico
 5ssXQEBgCvzaYB9I8TXNBKiOYkoI2N8swILWeu7Az0muzqHcxIg64uPucWAbiv1K
 e4+mJs3sCKtU7IF+rZRCkSvzX5H2YWyXhpLd4Y6AeUY2hiPvKfNEVz5iu7p/DRoL
 JSZH5JZ1PK7DeTIUZup7bZBFojKu/lVkkiEdig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786556310; x=
 1786642710; bh=WCgtYfBD5RzWqrtCYloQc4gxMkBtntG8sQmZBuCvDpk=; b=R
 +bv/NNTBeGJ+5MfppUjrz0ZNPinHRloQP4YqFqgFnJ8kGahukjA132UM/hF/810/
 2sGXkEL2wBnqLi/YLCOfKwnklUfPJ8Fb0vCVLmaNn+EBIaKLPM+LNllaj7kWgNUd
 V+Zz3piIrWJ54b7SWw1n1I3nXsfdf2nuXDYGLH26e8WExgldxCBw09QtrdE6/d18
 GY8mZi7xBX+RIxxuc7YrBgvDMxEaZJntdCUcAgKRWm7RItbk8K0Pmfpw81CwhJuc
 evgqoTYDjB3/V6YQ9Z0X5UIRlO6E/DeppkEgRIv3YmTBbDjNL0dCSEpjkurmZyxU
 Nt6197qfBmtrrjLO+hKug==
X-ME-Sender: <xms:la98amBrSXLS6H_uFfI0cJ2YuOSH1wSIaNad27UBFXNviwlyiqVKVw>
 <xme:la98aletx-ncCU6sZ004ub9_2b92bNslWtXka0SBcdLLMUCCFbi-R-i4iXfUMc58Z
 CznCPG73K_mo7D4hgjf5Bckm5tPKm82Q_eGwPWNuUZ22f7MsZQJkYR8>
X-ME-Received: <xmr:la98at0nda9w_cK-mi43GEOYfdriTaXOYWL6GvYeg2b82CKOUNuGm4rkI4Chxmgd6x5edg>
X-ME-Proxy-Cause: dmFkZTGCFwlo9Qn6AD8QFmga8XH9bW5D+AobHzzLVWpuCobwcotp873L7Leixjjh1mhcCb
 QtaGfCzIrK87dcFgByXRsbqjJxSN2hioJjgTeklvq/ia0v9Os76utH289xMvzGrTaeUT+B
 uZ1kGR0R47eG4mW7XyCnTgrT4iqWPcpdXEDxrwz6irX9/+dcB8ti7aOWjFm9v4KcHOW91b
 oWDCV2r6GTVC2h34vmd6H2Bz8MhHOcpJ9FfTWd9PHkS2GzASlbK1heJGlgYf6JxPa+V6BL
 CDJ7T1TFECO3pqYjLFytMe8ihhwspXbxLZnSPSsrkZ8TzJdgAYndhk7zVxWJ+ZOgy6tqUa
 Hnyg4E1KitOjPcKPQoE4Ry1E2UBvrFUuU0+rEZPttkBkplLWs4daPJ1LHOM49kzt389gPR
 1NZZ6gg6yYnAKEjuBzDroVQNSEbyRGx4vqVSuWmnsT7VW7OuyPEQqAHEcBKBQdszNxt15m
 RlikYIiSICi4dj9vJlJcEuAQgCwbizqjbdMDjGaJadymEr0cOKdwRfY1uevw1EbEYSV/iN
 t1LH+y2PWQy5G/QRXDZbirHlHRBWGFc79lUU8XzhCmYqhAB9GDUkZGyTwqAKHQijQNYz0R
 /lN+H6qTaWBGmCXnyIyB4baOBM+JuXcuhWRopgWA3DceFZigxHBeUBL/w2uw
X-ME-Proxy: <xmx:la98akg9EG6AIRelxy3ygeHIGCsnb1GLiZ3WXI--D30-VcvTYLq_Iw>
 <xmx:la98aunDXyu_H-oG7h_trA2XV1q6Oj2ZnuhGg08s1iZHto5lqCeewA>
 <xmx:la98aianYaLDLO1FH7qRh8jE8Ad9nwRewrCoOhxFyYmuf-OYD3UnXQ>
 <xmx:la98ahGIbl74eTnKvyl30ocO9ICBYd9gXJakzN5L5eMLaDDHrHKThg>
 <xmx:lq98apFTAnx-9Skk9wlk30Av9ccnaD1eIU4AdM9EL4AnntJ-WX4cD8WG>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 13:38:29 -0400 (EDT)
Message-ID: <6f7d6a5d74482bd8ec472151e6c75ff24b23137a.camel@alistair23.me>
Subject: Re: [PATCH 2/2] tests/tcg/riscv64: add misa write test
From: Alistair <alistair@alistair23.me>
To: Vladimir Isaev <vvisaev@gmail.com>, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, qemu-riscv@nongnu.org
Date: Thu, 13 Aug 2026 03:38:28 +1000
In-Reply-To: <20260806133755.45924-2-vvisaev@gmail.com>
References: <20260806133755.45924-1-vvisaev@gmail.com>
 <20260806133755.45924-2-vvisaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.153;
 envelope-from=alistair@alistair23.me; helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Thu, 2026-08-06 at 16:37 +0300, Vladimir Isaev wrote:
> Add test to check that writing misa before compact instruction
> doesn't
> drop any bits.
>=20
> Signed-off-by: Vladimir Isaev <vvisaev@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0tests/tcg/riscv64/Makefile.softmmu-target |=C2=A0 4 ++
> =C2=A0tests/tcg/riscv64/test-misa-w.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 46
> +++++++++++++++++++++++
> =C2=A02 files changed, 50 insertions(+)
> =C2=A0create mode 100644 tests/tcg/riscv64/test-misa-w.S
>=20
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target
> b/tests/tcg/riscv64/Makefile.softmmu-target
> index 82be8a2c91..e7d052909f 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -41,5 +41,9 @@ comma:=3D ,
> =C2=A0run-test-crc32: test-crc32
> =C2=A0	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=3Dtrue
> $(QEMU_OPTS)$<)
> =C2=A0
> +EXTRA_RUNS +=3D run-test-misa-w
> +run-test-misa-w: test-misa-w
> +	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-misa-
> w=3Dtrue$(comma)c=3Dtrue $(QEMU_OPTS)$<)
> +
> =C2=A0# We don't currently support the multiarch system tests
> =C2=A0undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/test-misa-w.S
> b/tests/tcg/riscv64/test-misa-w.S
> new file mode 100644
> index 0000000000..22cba98b8c
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-misa-w.S
> @@ -0,0 +1,46 @@
> +#define MISA_C (1<<2)
> +
> +	.text
> +	.globl _start
> +	.balign 4
> +_start:
> +	.option norvc
> +	lla t0, trap
> +	csrw mtvec, t0
> +
> +	# Fail if misa after write is not the same as before
> +	csrr t0, misa
> +	.option rvc
> +	c.nop
> +	csrw misa, t0
> +	c.nop
> +	csrr t1, misa
> +	bne t0, t1, fail
> +
> +	li a0, 0
> +	j=C2=A0 _exit
> +
> +
> +	.balign 4
> +	.option norvc
> +trap:
> +fail:
> +	li	a0, 1
> +_exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
> +
> +	# Semihosting call sequence
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	16

