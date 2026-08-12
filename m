Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E89C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuC8n-0006MW-UN; Wed, 12 Aug 2026 12:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuC8b-0006Ll-Re; Wed, 12 Aug 2026 12:49:10 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuC8a-0000tT-8d; Wed, 12 Aug 2026 12:49:09 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 7763AEC019E;
 Wed, 12 Aug 2026 12:49:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 12:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786553347; x=1786639747; bh=BGfYPcEK8Qz5xC59PM0p29DQgyoUZ/IC
 7LYgDtnNk60=; b=GEE+DKRadeuzMxL7AB61g1CbHbPbbyOzFkNoz7tq2QG1f/ed
 9uz2/2uYwUtfcRcYK50wseo9y7xAEQAUoK7gb6de13laqa+HTDXp5EO/WJrRy4iG
 wrDdFjp9+ZZdgqhNpsXNZXzXezGWFc/+5cAcYGYiWwkT0Rq8AnYw5UDzF+zSBD7F
 hannoEJN4I+gHVQglrksv7t0s+Z0vNV4JrmP2y4KXyxhUCfuV22M9o0qLhRlhuIr
 ZXeuCnaXapPkJ+DtNEgLEg1uI2++ttz0/cJYBUZdu1fY5vk8w1m/EdZqvVy/roC4
 O0gthBGIvQ6pMp/zha3jqtPYUhGGqvKVWS1Z3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786553347; x=
 1786639747; bh=BGfYPcEK8Qz5xC59PM0p29DQgyoUZ/IC7LYgDtnNk60=; b=V
 6rq+ULSRGgXp3Jy9d473FdfifBwYE3DVnFRm7/9e+lrz+XInK2jC6ZYZGe5m7vT7
 Q1xyDUJCyI8tyUObNmvTvJZeMi9u52JLTHevylfpt5OsbLTHeu9vZViZWoBsq9qH
 FdaJkodQb40BBpFa1gKar0R1soryEoA6+v4TCogVY1AQ3QY4NhRdmP2ZUd2uoqmp
 4ZFgr6fJlr2aoYhTf9D70z24GkI5GHyx+tgqghlS1T1nRkhV+TWXXqdAsO90mK56
 CCG73YmeXSJALZc9ZRqcM3wFC79tJmSmlPeoWoqvk69RgCst9c+deu3vJFEI5aqc
 +Dp7t4ZJTp8MRf7j85w/w==
X-ME-Sender: <xms:A6R8avd_7TuvLRtlRrqLbFklTpTpCsb6Y2yk5zTPyU0tP0E0dN2R5w>
 <xme:A6R8amuQbJTeaP-rKYBJffxf4bdxjMUlFN4YrXzES_wpJQqF85TlOk0sifQdlVrA5
 CYac4X7Uuk8LZPwrl9vYClIH9kXxPcr1wWJPauYO7SLzvJ4nQxVYOQS>
X-ME-Received: <xmr:A6R8aolcs91S1f898IGhHRtoLMJd0Y-8FQcBqcL1gAtB3-PpGoXN3PKLCkIKVsNmGAP1Fw>
X-ME-Proxy-Cause: dmFkZTGPjgCy9eRTbhRe2RXfR/tYtxiNRsfVkgaZ7qvW9PjmBbvGAaQX0C9fQzvbuCv4sD
 Ut79h7w3re4camkSV9VdENhh+t2IPVDPMXhNMUldHAFHi8J9BUQtT2hsVrojQz7DwNi/dl
 MMpmnl8hU/VGkT5lVNIFe8lTu62t1a7dsOt5kK3GQm5OCn1lRdrDKGDXYihGvhSCOw1SZP
 1R363SGFTbbQdCnW/pATDijk5Ss3W6+P0A08IQ6XRRuXYIOkHd16XojoSIc0/OThpJhg08
 RyrfluUCtkp/C3t6StWNBveWG+3tTQTDcYsPcXUO+5G6HJjIjeiIAK+ZwpSR/BnzSlfACy
 m8K3YO0/m64VMdDx6Tl/DPxsRu93N87KqbCTBBVKsj11WwwYMRqYgfa7oTPSIa48FxPNDu
 R4m8sQevA4XLn4f0/LBEC4V4U/pf7Qc7JoZ2snF8lxf8/C2s9XorG/R3mGmiA+VY7GESQx
 qe4VFInRmW374BDin2P7DHFSKThLZPGtLzlynjXfaY9LplHyylmRTNKeQYnvgdc3rRRUKh
 ei9c5N2hT+M6A6Ldp+aCSEwos7GTI4V9OvvTRWd0iYjYXi4AIVumHgUhvCUMsR6oF4x5cb
 QXTtoqcmy9IwUY3+HHgma51vK8jG5zPgGeAlBkC2hwCS+c796TXpl1S7Kbvw
X-ME-Proxy: <xmx:A6R8agzWyapQwBIkRQHXvdK7aMLiUTh0iRTRcDaMPYffB8-C6n7vwA>
 <xmx:A6R8aiMziB9zIWdnhCrWAPkMFUT4IxRn9xW4ai6bgo4ZrZRZK2Tv-g>
 <xmx:A6R8akp5pECY9-gS9hRXUkOyInwzyM8jGF1PpmaFcD5U3IUDYTTTIw>
 <xmx:A6R8ajF7-4-_sEMOtn6x4LOG_nV3N7htw7PflAfn16XikFD82cUANg>
 <xmx:A6R8aofXgeHVy0VKbFHqAOCCSrWJUwZ0V9SkKEp3tSlcqUAPmsKrBPsx>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 12:49:06 -0400 (EDT)
Message-ID: <b67a7dc0e378b86b199cf89cc49733115c5c3e57.camel@alistair23.me>
Subject: Re: [PATCH 4/4] target/riscv: make cm.mva01s/cm.mvsa01 high-sreg
 forms illegal on RV32E
From: Alistair <alistair@alistair23.me>
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com
Date: Thu, 13 Aug 2026 02:49:06 +1000
In-Reply-To: <506ceee00a6b4199b3efd87352bbe530@wangyang25.otcaix.iscas.ac.cn>
References: SENT
 0001-target-riscv--honor-zicbo--envcfg-gating-in-linux-user-mode.patch
 Subject: [PATCH 1/4] target/riscv: honor zicbo* envcfg gating in linux-user
 mode Message-ID:
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
 <bd5454f4047447d5b2f1e9756e5c1525@wangyang25.otcaix.iscas.ac.cn>
 <506ceee00a6b4199b3efd87352bbe530@wangyang25.otcaix.iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.146;
 envelope-from=alistair@alistair23.me; helo=fout-a3-smtp.messagingengine.com
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
> The Zcmp pseudocode marks cm.mva01s/cm.mvsa01 as reserved on RV32E
> when either compressed saved-register selector is above s1, but the
> translators only checked REQUIRE_ZCMP.=C2=A0 Since %r1s/%r2s map the
> selectors to register numbers (x8/x9 for s0/s1, x18..x23 for
> s2..s7), add a gate that returns false when RVE is enabled and
> either operand exceeds x9, so the high-sreg forms raise an
> illegal-instruction exception while the s0/s1 forms and all RV32I
> forms keep retiring.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4110
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A01 file changed, 6 insertions(+), 0 deletions(-)
>=20
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzce.c.inc
> b/target/riscv/tcg/insn_trans/trans_rvzce.c.inc
> index 71b4ca5473c..fef522d3932 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzce.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzce.c.inc
> @@ -273,6 +273,10 @@ static bool trans_cm_mva01s(DisasContext *ctx,
> arg_cm_mva01s *a)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_ZCMP(ctx);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 if (has_ext(ctx, RVE) && (a->rs1 > 9 || a->rs2 > 9)) =
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv src1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv src2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
> =C2=A0
> @@ -286,6 +290,10 @@ static bool trans_cm_mvsa01(DisasContext *ctx,
> arg_cm_mvsa01 *a)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 REQUIRE_ZCMP(ctx);
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 if (has_ext(ctx, RVE) && (a->rs1 > 9 || a->rs2 > 9)) =
{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> +=C2=A0=C2=A0=C2=A0 }
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 if (a->rs1 =3D=3D a->rs2) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> =C2=A0=C2=A0=C2=A0=C2=A0 }

