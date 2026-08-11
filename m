Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E56EC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsXu-0001BQ-L3; Tue, 11 Aug 2026 15:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsXs-0001B4-9W; Tue, 11 Aug 2026 15:53:56 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsXq-0007wr-FU; Tue, 11 Aug 2026 15:53:56 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7469D140013F;
 Tue, 11 Aug 2026 15:53:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 15:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478033; x=1786564433; bh=Mv7+Kl9I6GUepJaQwbQkgOGT2KTVSpIG
 pKD4+jm2NuU=; b=cuHjfsU+msabcedTOjVgaH3/bhaNhESHTwAvWWw+95Vuowoe
 ElqZmmqnyHV94n57+2AAsm0exkZbLiC1K2VVF1uF6GG1jHT+vupiSZZLdvKi75mt
 nuxfixzRognraoRY7VYGxpOc5NPk8vOs4FJwG//bDN01/ndLfz7QNv2XBDsIRNMC
 5otjdOPN6OkN7jr0cqN0/oJZgURUAGIfgz4KSu6z2z/MsWyrryfC8L9yTRbEX4gX
 V4Ke7eM4sPCW/yIV+K2FjKxnujkyoNGDQqhYv98ornpLld/oxMC/GinlUSO2YaLi
 nZHyQkyRzQ0lt0hBlJHaCxcfvrJgBz9pFFpBOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478033; x=
 1786564433; bh=Mv7+Kl9I6GUepJaQwbQkgOGT2KTVSpIGpKD4+jm2NuU=; b=l
 Xmaavgp+b1Y8eg6a3q+2/TFdtaxeSMhewcJ5qfmlxjRaGhgF70qdszWven5RjONe
 wV6cFpjST1QDjy4dhW0lrWCeXKJc/85208nUfYyIKcXyvihQMLBSsbnNr3aoVPhR
 ZORMzdHeTsEYKK7JuUz58+15tK2xOgzsj7iT/B+TV51rHGM6FCNyywoukPugE5FP
 WTyhUr+GZ4cCX1jB4UWO0hwMpsyRpmV4WSOPIAtf69nC+vUK4Ljy/qJ79o0IYr/P
 5HqmUICs8L++yIjp/W+cM6v8jgfYL7tiy+uxQZRNBiwPlAWJ9zb1ZM7xOCsg4wST
 ikHHLqN7B0LC/2SdLWd3A==
X-ME-Sender: <xms:0H17augmbvwm42dTikCianxrSGRwAzg1htUWkM3gTpqCYhugGjSdXA>
 <xme:0H17aj-2R41JSFtA07uOUun9jIftU1Nz_sBwZYL0YRdzFa5XO1d8Nx95pfliViZEO
 C6bJMr7th9sUy4tCVwGJz4utXxojPU7fgYhU9a4qSoYbeT10IndSw>
X-ME-Received: <xmr:0H17aqVi2bq59dz9hKVtdbkbQ2qJq-jPEHRbCPR79ZBYHpOmyl5oG4lXy303QG00WpLsMg>
X-ME-Proxy-Cause: dmFkZTGAYDcAf25Q41j7gzwaMMJWDFwwWyg3KDlmzy0OeoXDX3yMhQUAu4blpA001hXa7h
 ShxN4OnIaTznSwBMXlyciVWog7lOQPZdGHwkE+chgwSot02UMWo3y2jg45WRTujWWlsIh6
 wcL4BEAUW1vuS2KvrA8dRViST7uKlWYsbL9iKXldq7rB4TkQTrhPXm2mA9SZDUy02XsQ9m
 l7e22d0wYTbUYMAp/uuxDzZKMzhbbEu2GtxgoBgz5h/KGhZzt8WvebZikQJEi/JhfwQ/ze
 HfEPI+M2xTfOv65hxZzGJe57kcE06EQflYZIYCxRjvNob/f67irildoPf3dO65R6gxqDM+
 LfLRph4/bkIprZXg8L8QZo9LFMZjGEExSaT7UPrdboUILM5o4g3a8OMxHkodro+8/YJ4FG
 vPKz0TzycAfJc29SxFlgYEemZyhPWF20ev9uP3T/HXlL4tnYnyopdcPkOJsBt/sLuFTHOO
 vozxnB93VA/uybjtigNzlP+Vk/5qLk+qH8KQ4kuOoMjZrSTI4OiYwLpU/HPYc8fnR7VH7J
 I0X5BdgviPJ+Gj8LDpL+wQHXGUBFwwU55RpORWBXpWXinZml4RObjSJjAX6YIXXICwdxSd
 fTdrqXlGtMJW4fctZf00gd9ZQLcxsdQrSr2MwMXwc15lZkeBt43aKDLVSBuw
X-ME-Proxy: <xmx:0H17anD07PREowOs2WQiWl5XtYz9ZoHK-cnsDqQMecds_SRvVVkrSw>
 <xmx:0H17avGvx2zSIz5MS2D7hbr2ZhcR7j3DTB-hVHy0Ypa8KE-lP98ydA>
 <xmx:0H17ao5WEGFPgOdsT2GkZSWoakY3vzOcbPF26xA0kdidqoEleaGEgA>
 <xmx:0H17almnRmSjnZKkTCFVi4p-kWFRT-Fr5GHWBMXZcy9nIygp6Mzabg>
 <xmx:0X17amG5t6QYdwhIUNcJezIyTLzG_qlHN6EIXNiGlImZPaCL-589ZOGM>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:53:52 -0400 (EDT)
Message-ID: <98e154971281c51dbad65df221a8201a7bfc0d38.camel@alistair23.me>
Subject: Re: [PATCH v8 0/7] target/riscv: Support the true Zicclsm extension
From: Alistair <alistair@alistair23.me>
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>, Palmer Dabbelt	
 <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza	 <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
 "open list:SiFive Machines" <qemu-riscv@nongnu.org>
Date: Wed, 12 Aug 2026 05:53:51 +1000
In-Reply-To: <20260810055618.1175500-1-frank.chang@sifive.com>
References: <20260810055618.1175500-1-frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=alistair@alistair23.me; helo=fhigh-a6-smtp.messagingengine.com
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

On Mon, 2026-08-10 at 13:56 +0800, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
>=20
> Support the true Zicclsm extension so that we can trap misaligned
> accesses
> when Zicclsm is disabled.
>=20
> To enable/disable Zicclsm, simply set zicclsm=3D[true|false], e.g.:
> =C2=A0 -cpu rv64,zicclsm=3D[true|false]
>=20
> QEMU will raise a misaligned load/store exception when executing
> misaligned
> load/store instructions if Zicclsm is disabled.
>=20
> Changelog:
> =C2=A0 v8:
> =C2=A0=C2=A0=C2=A0 * Squash patch#1 into patch#2.
> =C2=A0 v7:
> =C2=A0=C2=A0=C2=A0 * Raise the misaligned exceptions for floating-point i=
nstructions
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (RVF, RVD, Zfh) when Zicclsm is disabled.
> =C2=A0=C2=A0=C2=A0 * Add Zicclsm unit tests.
> =C2=A0 v6:
> =C2=A0=C2=A0=C2=A0 * Reorder and squash Zicclsm CPU property and RVA22U64=
 profile
> patches to
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 make every single commit to pass `make che=
ck`.
> =C2=A0 v5:
> =C2=A0=C2=A0=C2=A0 * Add Zicclsm to RVA22U64 profile explicitly.
> =C2=A0=C2=A0=C2=A0 * Rebase to the latest riscv-to-apply.next.
> =C2=A0 v4:
> =C2=A0=C2=A0=C2=A0 * Align ROM reset vector data at 8-byte aligned offset=
s.
> =C2=A0 v3:
> =C2=A0=C2=A0=C2=A0 * Enable Zicclsm for the compatible CPUs.
> =C2=A0=C2=A0=C2=A0 * Rebase to the latest riscv-to-apply.next.
> =C2=A0 v2:
> =C2=A0=C2=A0=C2=A0 * Use (size_memop(size) | mo_endian_env(env)) to calcu=
late MemOp.
> =C2=A0=C2=A0=C2=A0 * Use (log2_esz << MO_ASHIFT) to calculate aligment Me=
mOp for
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vector load/store whole register instructi=
ons.
>=20
> Frank Chang (7):
> =C2=A0 target/riscv: Add Zicclsm CPU option and enable it for the eligibl=
e
> =C2=A0=C2=A0=C2=A0 CPUs
> =C2=A0 hw/riscv: sifive_u: Align ROM reset vector data
> =C2=A0 target/riscv: Support raising misaligned exceptions for scalar
> =C2=A0=C2=A0=C2=A0 loads/stores
> =C2=A0 target/riscv: Support raising misaligned exceptions for floating-
> point
> =C2=A0=C2=A0=C2=A0 loads/stores
> =C2=A0 target/riscv: Support raising misaligned exceptions for vector
> =C2=A0=C2=A0=C2=A0 loads/stores
> =C2=A0 target/riscv: Expose Zicclsm as a CPU property and update RVA22U64
> =C2=A0=C2=A0=C2=A0 profile
> =C2=A0 tests/tcg/riscv64: Add test for Zicclsm

Thanks!

Applied to riscv-to-apply.next

Alistair

>=20
> =C2=A0hw/riscv/sifive_u.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +-
> =C2=A0target/riscv/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +-
> =C2=A0target/riscv/cpu_cfg_fields.h.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0target/riscv/tcg/insn_trans/trans_rvd.c.inc=C2=A0=C2=A0 |=C2=A0=C2=
=A0 6 +
> =C2=A0target/riscv/tcg/insn_trans/trans_rvf.c.inc=C2=A0=C2=A0 |=C2=A0=C2=
=A0 6 +
> =C2=A0target/riscv/tcg/insn_trans/trans_rvi.c.inc=C2=A0=C2=A0 |=C2=A0=C2=
=A0 6 +
> =C2=A0target/riscv/tcg/insn_trans/trans_rvv.c.inc=C2=A0=C2=A0 |=C2=A0 18 =
+-
> =C2=A0target/riscv/tcg/insn_trans/trans_rvzfh.c.inc |=C2=A0=C2=A0 6 +
> =C2=A0target/riscv/tcg/vector_helper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 65 +++-
> =C2=A0tests/tcg/riscv64/Makefile.softmmu-target=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 22 ++
> =C2=A0tests/tcg/riscv64/test-zicclsm.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 368
> ++++++++++++++++++
> =C2=A011 files changed, 496 insertions(+), 24 deletions(-)
> =C2=A0create mode 100644 tests/tcg/riscv64/test-zicclsm.S
>=20
> --
> 2.43.0
>=20

