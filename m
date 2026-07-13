Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2856EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 00:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj4mk-0001rA-T6; Sun, 12 Jul 2026 20:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wj4mi-0001qT-Ij; Sun, 12 Jul 2026 20:44:36 -0400
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wj4mg-0004pX-SM; Sun, 12 Jul 2026 20:44:36 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6A98E7A006D;
 Sun, 12 Jul 2026 20:44:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 12 Jul 2026 20:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1783903473; x=1783989873; bh=7ljbM1Tq11CuMRhFo9yPphc6IGE1YEp4
 7Oyg45UL9aE=; b=c5Tz/bn6GTYHSypAMCuy5d7wTKYNgNZvBJjQfND9MlSPy1Mf
 poTT07tQCUsgZeNY02gSrk18Wc5tR7kakiOdiTVcsSeMoXQXF7myRPuR4mTXwzV+
 npamw1omrCaEDnHDYkHq+NYJNIMTmSXeLHXHcT0oiL79Sr1Qqn4eM/eQhHYDCr1d
 bGPZQ8F7y2NoUSZowuC5En4pcpof4T5pyKPc3SXlL1bfj97uGikQqRP4KzCkWbpg
 hJ3LjGPU92BIVn/+X+6QfpmhTh09PWcZHyRLyRj5jF8euvEbTc7wbt80Bx+6l8hP
 81M38LrvVNZ+/FNjqEIs5fszXCiQUhDsPMSjZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783903473; x=
 1783989873; bh=7ljbM1Tq11CuMRhFo9yPphc6IGE1YEp47Oyg45UL9aE=; b=L
 p6l8dGby5ym/1fQLj/G2FLrHyjEeOdV3CWE6xszQoaS9tnkkDJ9lgOKsnu/BnlbC
 LAg5+gdCBdPp9OUUdyFo8CjfAejldaYYJHvwbxf8dztFalav4zTHYp8a+kE7o5zU
 wphBUbTi9l6QhYvHC1j/UfiCB+RVBmVq+7j9jbmUSTySve97qCdUzchHiz/0NYT9
 OquQvhNUSFm2OZM0xU2putpXh429Gb7SFvgFpSeTaSempcYxtCPn66LOUGoZIJVE
 dW5VBvQ5Rrtjp38PqVoCKA/eXDWIipRq0iaBE9OKEG5i/veGytZC394qLrW2vBay
 fLYllqT1NrdrFLLmH7IKQ==
X-ME-Sender: <xms:8DRUaqNdSyeihQikh7Ud1Dkp6KDVynotMoJ2aeSzNnTlpy6reqMeig>
 <xme:8DRUasqR7BSD0F4s9jGO9bLsu3FwE2G3dKMuy21YBiXIri0msoTvu7fIKCgJIR_K6
 HvXZuwCQsgD620MvSY3PQsGvT1ciZiCvFiy3idNkWzVdBhzpGN86_Y>
X-ME-Received: <xmr:8DRUarHpsE7VUpycw3sOV0DdLfev_hiRWZ2Pv8yCxZDjz-cIp8ntuZU8TDj4-WM9_rKb7LR8c0iEHcKCe2kzJ-jP_6o>
X-ME-Proxy-Cause: dmFkZTGY6qCnpNnF6r1vy2X7vhAtoK3BUOlBzzxMzKrBfhSPLZeZQWStPXnvoGm5AMXVcA
 NHtdGoktbqWtiLuUP/NNziVDty+J9YUoeatGWJqzPKSjEadKGCtDq4V8K6YxS6dizflpjC
 /F76Y3ScBU3AWZ1NHvxVQwcKZ1Dk5MUWDKeouyi5QQH4453/gmz+hEmFGqhRv+5zKDxX1a
 vEGS8b0/o424W8cGimYMaQs75YUqO2ZMRDgExZvHfs2mYFGNINdFkG5q25IezavukwgpA8
 dXADL5JOo0ASufJkaBqRe/ZBvATLZaahdygu0EnXH6TunkVhTp0BLOWV5l1XZ9fyPldkuM
 FsAu84bN5f/q1uselsvux5oribVP9DGFGPeBxr2jB/lQnNdIn+pYeH3McjwFxqKRcERhHe
 Wpy/l49Q1fsEYmrANWgW4lHIYuZa6dbY5MyCRVGtGusDEUleJYIvhf/lb+mKnYS1i5pT5T
 DOPWfTUt9EcDVZgGlU2M1m3tR9GPrUPPPmJoK6TYcHwjHI4yBrE0btvnF1orZ9DSSnucoF
 qHhsN/AZ0bwKbJiXCTafOYbm4xR2ALsF/GJ4mWksCp5owAJd3Nc3dr516XlnM0P1NijkOs
 ZynbitkpDdi+ATmkOiOaTJA9QgYNNjVb/A9xQ6ZXQCqTBc1niKsPQZlknHjw
X-ME-Proxy: <xmx:8DRUahr2YURLwUvnWjIDUyyGedbIp2lwtyCHRwQGvtY36zcAlyu2YA>
 <xmx:8DRUakb0PvMJF6WNxe0tggPw6dbLWY_jfBfstmVQldecJM9OFgNoMw>
 <xmx:8DRUaqUE_ZQvu346uT1wssUJ0qvwywXIXyPf4BiwTrRA8OGPc5JeVA>
 <xmx:8DRUat-uCy7JfU1PP0QjFr_cY72Ll5-7skI8MYxVNWSKtoXRQwMl4w>
 <xmx:8TRUaowZTQ_HFpgoeeh3ra7A59TWfG7XxHowzOrxcYdhpSj4bx8r9GVP>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 20:44:30 -0400 (EDT)
Message-ID: <0b6bc61eb4ac1f9ae0189ce172b053f83cd214ff.camel@alistair23.me>
Subject: Re: [PATCH v1] uftrace: riscv privilege level
From: Alistair <alistair@alistair23.me>
To: Yanfeng Liu <yfliu2008@qq.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, erdnaxe@crans.org, 
 pierrick.bouvier@oss.qualcomm.com
Date: Mon, 13 Jul 2026 10:44:28 +1000
In-Reply-To: <tencent_E17E8F6494EE130F71527C6BCE481AF33E08@qq.com>
References: <tencent_E17E8F6494EE130F71527C6BCE481AF33E08@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.152;
 envelope-from=alistair@alistair23.me; helo=fhigh-b1-smtp.messagingengine.com
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

On Sun, 2026-07-12 at 16:45 +0800, Yanfeng Liu wrote:
> This adds RiscV virtual user and supervisor privilege levels to
> uftrace plugin to avoid crashing with H extension guests.
>=20
> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0contrib/plugins/uftrace.c | 13 ++++++++++---
> =C2=A01 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
> index 9b0a4963ae..063e32220b 100644
> --- a/contrib/plugins/uftrace.c
> +++ b/contrib/plugins/uftrace.c
> @@ -109,6 +109,8 @@ typedef enum {
> =C2=A0=C2=A0=C2=A0=C2=A0 RISCV64_SUPERVISOR,
> =C2=A0=C2=A0=C2=A0=C2=A0 RISCV64_RESERVED,
> =C2=A0=C2=A0=C2=A0=C2=A0 RISCV64_MACHINE,
> +=C2=A0=C2=A0=C2=A0 RISCV64_VUSER,
> +=C2=A0=C2=A0=C2=A0 RISCV64_VSUPERVISOR,
> =C2=A0=C2=A0=C2=A0=C2=A0 RISCV64_PRIVILEGE_LEVEL_MAX,
> =C2=A0} Riscv64PrivilegeLevel;
> =C2=A0
> @@ -153,8 +155,10 @@ static void uftrace_write_map(bool
> system_emulation)
> =C2=A0=C2=A0=C2=A0=C2=A0 const char *path =3D "./uftrace.data/sid-0.map";
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 if (system_emulation && access(path, F_OK) =3D=
=3D 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* do not erase existing map =
in system emulation, as a
> custom one might
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * already have been gen=
erated by uftrace_symbols.py */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * do not erase existing=
 map in system emulation, as a
> custom one might
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * already have been gen=
erated by uftrace_symbols.py
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> @@ -706,6 +710,8 @@ static const char
> *riscv64_get_privilege_level_name(uint8_t pl)
> =C2=A0=C2=A0=C2=A0=C2=A0 case RISCV64_SUPERVISOR: return "Supervisor";
> =C2=A0=C2=A0=C2=A0=C2=A0 case RISCV64_RESERVED: return "Unknown";
> =C2=A0=C2=A0=C2=A0=C2=A0 case RISCV64_MACHINE: return "Machine";
> +=C2=A0=C2=A0=C2=A0 case RISCV64_VUSER: return "VUser";
> +=C2=A0=C2=A0=C2=A0 case RISCV64_VSUPERVISOR: return "VSupervisor";
> =C2=A0=C2=A0=C2=A0=C2=A0 default:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_not_reached();
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -986,7 +992,8 @@ QEMU_PLUGIN_EXPORT int
> qemu_plugin_install(qemu_plugin_id_t id,
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 score =3D qemu_plugin_scoreboard_new(sizeof(Cpu)=
);
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_plugin_register_vcpu_init_cb(id, vcpu_init,=
 NULL);
> -=C2=A0=C2=A0=C2=A0 qemu_plugin_register_atexit_cb(id, at_exit, (void *) =
info-
> >system_emulation);
> +=C2=A0=C2=A0=C2=A0 qemu_plugin_register_atexit_cb(id, at_exit,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void *) info->sy=
stem_emulation);
> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_t=
b_trans, NULL);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 return 0;

