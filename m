Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FF8C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuC6G-0005YN-39; Wed, 12 Aug 2026 12:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuC68-0005Un-JG; Wed, 12 Aug 2026 12:46:38 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuC64-0008Qd-Tj; Wed, 12 Aug 2026 12:46:35 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0E36B140006F;
 Wed, 12 Aug 2026 12:46:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 12:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786553190; x=1786639590; bh=uWbvr2Az1orP0RlHuyqtuYNOL1GgfqbL
 IwH/e0Um88M=; b=uIEflQXHI2Xe5sHbJSLPoiQKuXSv/JlrDfDTcHEL9yZphFKS
 I4jBRIhSMUgRDEZzsZaETv2Xyh9OwXYrBEm2T8TfhhuLshZE1Xji3EerVDhNkeQy
 UBaQM7u2oz6wm3qA/mgeLM8SuttezPLTcoY46y9hZaN0i/rELXADguYMqYrOCDJ5
 cG0pUHCWPClUmiZBy06r8xo3d5dRqNtu+kfpdOwQDvpVKG72idJuUofMPYkbdGIB
 sg0ZnrrDU29Q5wRsvk4yYVlFW1J1r8hV0gorGkWfq/MHAwSgSO6qekucNwYIPsM6
 HEzdMZhMObAlD4vPLIwPKPnNApLHhkqOODYpeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786553190; x=
 1786639590; bh=uWbvr2Az1orP0RlHuyqtuYNOL1GgfqbLIwH/e0Um88M=; b=m
 cNkU3W5lMOCjuq1qEDFfMA32qdFZ1aN6obH2mKrxcPBIIwLB9ANXJsdyI9H3CGNi
 9aWG4LGMHyvu4GxvXq3pxrtjzVmwyO092A8OIgNHOyMCRmyERnnzZX9TwwLuepcL
 w2JbCsyHSRtEBdb9Oq5oHzTyERxL1zpTeLzdOqTWqhnEdaPG1S83BVargVh3A3jL
 23/rrCIKkUgWaS5z5bRbbHg3kWDZWrJ8k2PnP4SCU894BPS3Gm+h1kCMHHtLqO7v
 a6t0W2eYEjg4FhKjBAFedH1QiO8CU0QRtoJMVA647Oi4j039zOHS8rT0UdDkMgWy
 a0BmwoBQ8GW9fO5TezZaA==
X-ME-Sender: <xms:ZaN8amR4rIYj82m28WroscMw-If3L2lXZAlvr63N5dYQwO8pjnljUw>
 <xme:ZaN8atREaoXj5O616uJyi8oTLj8nf8VUws4Cf5MQVYXI_I5lBtzrPW2km9Gql-8on
 1TU836vaI6ENOUAxPlzkz-H27gVm1tG1MhiaRGqqlVm7CEi14RPl1lm>
X-ME-Received: <xmr:ZaN8aj6Dm8gG4pbZv0phR_9cRgQchGqeWojSx9cy_hNKeVlW4QbpZpWAVDW8TPrjJrhQbg>
X-ME-Proxy-Cause: dmFkZTGrvtvoMH7MTC7wizaAOflFVB1jP6lqJ3HfyauHz/5F1EKmkRol9fF3sWj2mAHpnx
 MdfcSpJbh3ds1F8got/cyyrdNYnLkyUctn5jiG8UIXB36EMNjRdwJ9XSNwSViNW12FdEOF
 EC7DekuBatOB3KwUR5CAo6iSAKuGiQUBct4ymChvOLMa1Ne6Nu7gmUAzcDj4H3QUaEnQJE
 QIf3SEHp9WQ1Y/iQI+kyeGm6gvLXkGwnBvPR23yrSZFghRnG5b4CxxyWB99SDF9V+S5pjI
 yVwzuDhspkpEOBtWXKz4TUW5Rg0DOqmUi2XyqFyrYS43fHdBZGcaGgxLfQ4ewP2oQUciPH
 tA/63KGLWCMuoTvfcOtOVtrEcPc7xqhdRl/WizG02LWJfSXorbRNrNAhrREud6iqaWaiX4
 tsglY2Je8NoOtAplxeciTwl9DGeZbDJoDaAs+6Ksp5Op/fGl8F/7UumPhD7iIwx+s5uFeE
 u6SyrfqJ/hyKAJQQuApnqBYWhtvgRGv/xiuFWyzusoVGLFK612PT7UwYMWFzC99U5OivCh
 8oDsMAbf9gnBxlnCDPPDKuU6cqM5pbrIa6Jae69mlCXBsFhmFbywIQ5PR/BibHb7WgcIC2
 WJ1lUHAopvAhD3BgSVgcJXYT2Ui4YtDRzf9OJ+M63LLyXqEo5WysjdP9yX2Q
X-ME-Proxy: <xmx:ZaN8ah3vROc-4Zfj3DeAGPGJ1VAFt8uLDVkPVZP9EYlvUjBClao7mQ>
 <xmx:ZaN8amAlI1LOg3IB1KSlPVOuylkcRZcp_GUWrqnpfE5uVboN9jcIpw>
 <xmx:ZaN8akNrfDhS3QvFJ0P50Ch1_8y7H7VE34W6sCvqTrHLXN3PoDn1oA>
 <xmx:ZaN8ajY43xkN7R-fn6e82736-0Lt9YFSouD_XbIHu1x2lDRvYXYD-g>
 <xmx:ZqN8atiPvxfQB9XMU88DRnJ7QYYmLkjuxKktcrdEDPGggy6RvELh6NbK>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:46:28 -0400 (EDT)
Message-ID: <84cfd0fbc849b87d76053086ec5bc5a8ef44a0a9.camel@alistair23.me>
Subject: Re: [PATCH 3/4] target/riscv: enforce even register constraints for
 Zdinx fcvt pairs
From: Alistair <alistair@alistair23.me>
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: Thu, 13 Aug 2026 02:46:28 +1000
In-Reply-To: <1244b2ba3a874624a23e2c5a18922ae2@wangyang25.otcaix.iscas.ac.cn>
References: SENT
 0001-target-riscv--honor-zicbo--envcfg-gating-in-linux-user-mode.patch
 Subject: [PATCH 1/4] target/riscv: honor zicbo* envcfg gating in linux-user
 mode Message-ID:
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
 <1244b2ba3a874624a23e2c5a18922ae2@wangyang25.otcaix.iscas.ac.cn>
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

On Tue, 2026-08-11 at 09:14 +0800, wangyang wrote:
> fcvt.d.h and fcvt.h.d access a 64-bit double held in a register
> pair, so under Zdinx/Zhinxmin the odd-rd (fcvt.d.h) and odd-rs1
> (fcvt.h.d) encodings are reserved.=C2=A0 Add the missing REQUIRE_EVEN
> checks so those encodings raise an illegal-instruction exception
> instead of retiring.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4109
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A01 file changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> index f36b46c2118..6ee71506d62 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> @@ -413,6 +413,7 @@ static bool trans_fcvt_d_h(DisasContext *ctx,
> arg_fcvt_d_h *a)
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_FPU;
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_ZFHMIN_OR_ZHINXMIN(ctx);
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_ZDINX_OR_D(ctx);
> +=C2=A0=C2=A0=C2=A0 REQUIRE_EVEN(ctx, a->rd);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv_i64 dest =3D dest_fpr(ctx, a->rd);
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv_i64 src1 =3D get_fpr_hs(ctx, a->rs1);
> @@ -447,6 +448,7 @@ static bool trans_fcvt_h_d(DisasContext *ctx,
> arg_fcvt_h_d *a)
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_FPU;
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_ZFHMIN_OR_ZHINXMIN(ctx);
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_ZDINX_OR_D(ctx);
> +=C2=A0=C2=A0=C2=A0 REQUIRE_EVEN(ctx, a->rs1);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv_i64 dest =3D dest_fpr(ctx, a->rd);
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv_i64 src1 =3D get_fpr_d(ctx, a->rs1);

