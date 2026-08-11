Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F920C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtseX-0006D8-U9; Tue, 11 Aug 2026 16:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtseO-0006CO-5s; Tue, 11 Aug 2026 16:00:42 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtseM-0000Xa-QS; Tue, 11 Aug 2026 16:00:39 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 914C9EC0190;
 Tue, 11 Aug 2026 16:00:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 16:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478437; x=1786564837; bh=1em1IjqIK/7w3cV5iwW0euD3HBiN8iSF
 jQHpMuT/G1w=; b=IrAcz5+QehCqwTfcmE3JniBR2M/EdbO52JqjUfPYffJYnr6T
 uFfC8a4pfyJg0vNQvX0jMIh6kHyTBDEXtWbpMRbHHRWnjmmC1VZ3oZoKoP/9782o
 qkkPHYGQtfblU6Pr917nl6dBfm8eUBIixCnIGSLnxpb/gcZgHYpeyiRB9FImCk9Z
 HfZxA4hxCtNUitx2Hz32faOrQwewSRxQakaONJdfSp+/BnQ3VqJweFIigTCEo5br
 lrbmppS70mLkchrNRwiw/bot+H8MKMkUqA4m4b5uBDq+EuufeU6nCBaXYEzgIX05
 JHCdJgVTH1DDBQ/SBCETjzxdptS7YZh+ZRjnzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478437; x=
 1786564837; bh=1em1IjqIK/7w3cV5iwW0euD3HBiN8iSFjQHpMuT/G1w=; b=g
 r220JnlXvLz3B6dVDzTwlqcMo/3nDeoJy1uonhtMNeEcpPzyjzUY3mJ+zmdEv/Tp
 r2uNGoz6J+qJ/HIWk8R7evobDGRWQJBWXAtr/IOxa5xLtyyWy5L6sPsgxS7azrdN
 dU9m9LsbJjl2SZzoaJ5a56RGdHiOjyR3D/9yQbodBKcjjzBJmMYDw4WTtMBXTOhe
 uSHHBGPVmEwGhAt86ql6wMcjpdUjnyDdGGc72Db/McwJ6ec1hC4OpYUlXMMRf9/3
 s7QlnQFm3NxDTZM54ceuHoCYQIrPAnjNj9bb9l99llgf3eLl3spvYuqou1//Tp4G
 6w2h63NVUfIu65EgtsHgQ==
X-ME-Sender: <xms:ZX97amyq1kcXFCpDh_4TKU6Za-QSg63ZsLE0TDE81xZB5ljRD0bm0g>
 <xme:ZX97ammDq9SfeynWZmeQWkNyZ9e0t3mS4E0xaXZ_jzUjkhaYpTdoGRFvH2svH0Tzi
 Oev37HdGtHfmhnzMsKauhjDJqWbkMVzU0tBS-G_wKNNDlIYx9b_d7M>
X-ME-Received: <xmr:ZX97anf8d7N4CZMVpTRmr1XY_WePgZn02bJesuFpl1yAPJn8YeSabnIomj0CO8FlTYr3IA>
X-ME-Proxy-Cause: dmFkZTG022mVQphzI7AWPJwf5iH2zrR/m6qBn9XfRmKRpHDMJFydYTJQKVsM1QV+rwV6La
 5lrePzwx4fvDAbuWGvHeRfj/XXR7cRigp+VFqRksAUG14iVvyA71KFanGk670lEqM8JVu4
 s34RyOYIIjP0W8WBcm0e1tPVBp/pNSsHcdVX1Ks29W2b9Vr5JvJeEXiSndrwW6yXxb4+J4
 eZfRbt29FtMtF3dLgjNB6mepufrYu6ZS9dF46cYmkr7C0VornlkrAZTNc8V+Abmi0Y7yME
 8S+ZxumAgsgCiVLwzI8RB5uG9SF/jOVVCcorsE69lSTOl6wZGe9l8hpUAF/XNdPBWsb4gQ
 8zHIGxU4dY9l4GTSFGIWjCwMKTIORS5IjtUkwgO5SWW+wY+634k05ib9g8e2VuZDQduNTj
 bCekoHGKZ+CxVlQ3xQs4yICeGHi/y84oF4PwsB9DJDDVbtk/T4TQzC7sXTDeAZ0cTbo9Zq
 bd48CxTaOnYqwRc0qJh1OYyQdZSpaxbLJeriqcyxh4Z4NbsrIRkcGTPtprteFXCHV3lw8g
 4n/E44IK2V+2Elatgph4uI6fk/Y7o5Y/iSn2kv4irqtXNIUdesn1RewWfGzWuOEgGKmRaT
 Y39rS7IUDcCcKCTFo4hkf9F6D1AATzeXUpwWKDM8TJglLN1OlqYs8y8EC/fA
X-ME-Proxy: <xmx:ZX97akpgb9ipehFPLE-gTNI-XYbAdY8MxkddU57-9roWY6dAK3ATug>
 <xmx:ZX97at6DpFyLeRzjhTVJ9U14cHBTjwEGFgNkL5N1glkkqB3Oy6ngjA>
 <xmx:ZX97aiod-D2Vhsb9curwC1_DOAqRFUelwh4VsLXQ_XirAZCDKqIReA>
 <xmx:ZX97anii8QWFUZKHHSGP0GTBv30KQOkOQr-INdL9n4ng7i_53VOgEw>
 <xmx:ZX97ajGt3rbBneDrVjfjk8bgN_aE_nakaAsDVMHxojABMcFYS_RfWZrU>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:00:37 -0400 (EDT)
Message-ID: <ca35830e2c4a22bd1b38603375fc78944f9417bb.camel@alistair23.me>
Subject: Re: [PATCH 08/56] disas/riscv: Tidy dec initialization in disasm_inst
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:00:37 +1000
In-Reply-To: <20260809223545.730664-9-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=alistair@alistair23.me; helo=fout-a7-smtp.messagingengine.com
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

On Sun, 2026-08-09 at 15:34 -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 9 +++++----
> =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 012f90fce6..986dc6b752 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -5441,10 +5441,11 @@ static void decode_inst_decompress(rv_decode
> *dec, rv_isa isa)
> =C2=A0static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const RISCVCPUConfig *cfg)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 rv_decode dec =3D { 0 };
> -=C2=A0=C2=A0=C2=A0 dec.pc =3D pc;
> -=C2=A0=C2=A0=C2=A0 dec.inst =3D inst;
> -=C2=A0=C2=A0=C2=A0 dec.cfg =3D cfg;
> +=C2=A0=C2=A0=C2=A0 rv_decode dec =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pc =3D pc,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .inst =3D inst,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfg =3D cfg,
> +=C2=A0=C2=A0=C2=A0 };
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 static const struct {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool (*guard_func)(const=
 RISCVCPUConfig *);

