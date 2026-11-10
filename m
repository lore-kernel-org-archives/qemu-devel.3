Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B775E606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=OVCs0h/H;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QaAStlwF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQZMB-0000GU-5N; Mon, 09 Nov 2026 19:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQZM8-0000Fn-3a
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 19:04:56 -0500
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQZM6-0004Qg-2P
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 19:04:55 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 48D13EC0597
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2026 19:04:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 09 Nov 2026 19:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1794269093; x=1794355493; bh=XRBUtZ9zAz0vXQSdvAlykc1oROjG3bQh
 7mXy+MHlWzE=; b=OVCs0h/HlXlrAZldApl4MuptWYekW+X1FrkP1bxG72hGUNAy
 3YLTtl1gTzROLGLaKsyiXTNTDYBGiLEYqd34JYOG+ruEM7Q1M//XJHF/woaheEii
 Gfa0+XyZWh4RvvJOpNOPnv+kYpW1f+GLYXWaJ3GIrEdma0dLXUcax334k96tcHvP
 k1WE6UUV7QOGVdKiharYVigdijGwN69AtRwUu0b1cHPVfSg/Tapnnm3xU3BrNVNG
 Ja9PZ5wk/l8FIPEGuKqlNzz7/dRG96Lmbcq+cA45EB1DwnIWHxjwexyYITrPTGtl
 XFVvG4CYq48l53qb5Svj+CJfFFQCW8L5XGnvuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794269093; x=
 1794355493; bh=XRBUtZ9zAz0vXQSdvAlykc1oROjG3bQh7mXy+MHlWzE=; b=Q
 aAStlwFGlhd8ocjsFNBcOoR5FX4ynbCTyhfQoTtnIbz1HrOkRDEAnv0bA08mcdmk
 RRgRUR6D0m2anrVDV1soTJWnzZPpLKM3tS0WevDqbVN98XhgVQYe222m81f6nSWX
 bh98ZZQG6mOPgIRSDp0tWy3yz0AodPUsM12pgdRHlzDntBnFDsrw6p8ChEWTUHnL
 78WYUtx+J28iG4lV4XfWfomjn2uEm/TRlo8JG0lbEaWaOpudJT6xLlUqYp7YCfR1
 Pig/9Pc9OjFmuWOV23fWBvFHWoePaqi4gEq6XfuJ1hccigIfykzHS5vAqib7SSZ1
 mKEbsrueXAa1jasv7vpOA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794269093; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:Dc1VAB3GW/NcOU0+Pi2d0efbeTXLlZ+B6c9ef4gXTe5ZznK
 MVf2DyJek0gTL21p6xHwk6om0MrYycEvHI/AlhOBryL+J4I6VUV7SAA/BghU+hW0
 qMLs8Qj3LMIjsXWK+XOlbZIDIJk+BDlT2CVFlvM97CmyFv5M1AR4yvAqAHi4UYFZ
 tFnjo5+2pGRATgWTv/havFjLVmtGZ8KAh0y681git7w3FuPW5z10ZPXiE8PB8rdk
 KPmJqGcYA35XEy0FvtrOikxwWPKBVEp2RN5kIgeiKArGc0Z3WEsZKCZ+ArxpO1mE
 mY9M8r4Nc7iE0VCMu6ZKePvgbIFlB0vDIkbSXUA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:7TsZ/dF+KoJej1UH2auk1lHm5EKbo9Riz/cWfIn0Lps=:XRBUtZ9zAz0vXQSdvAlykc1oROjG3bQh7mXy+MHlWzE=;
X-ME-Sender: <xms:pF_yajfw_RjmyrUZzL-rgXhjpqBq-NvSR-ghDwm6t3Hcjt2uj6B1dQ>
 <xme:pF_yappnRgCpzsuK4wAFuUKKPX7oSV8pmLP_aU5XSUuCk5sXVb-YGrXBHpxKS9Za8
 t75VgE7FL2QMrsjUYPFzv6m2LspZPqS3DK_8eHiGwp60mOpB1G-5ng_>
X-ME-Received: <xmr:pF_yatN0DTbBUn5urL5S198Lz49_WoIbnIcETlrM3ufKKAKVAxrL3A9hlx-wALJkZiH4CpEsgg1q17s_blLdkovSMQI>
X-ME-Proxy-Cause: dmFkZTEV/YgG2qKCUebORMrb/VGkEigBLsyCNrs/9Wk4lvqemCFuldtrn4rgvQmdl5Av/J
 C64zVAC3bw/avzNTV3cL0rLaMFgvtAJ1Z+I5O68jAqOY7YjlbwtQX4pSG6Az7konzQQFkH
 2loa/S/XQ11Xcm0veLrG5APiPO+86ttf6/wdCpnqe3eRxkNbLAGfkBbIeSR5CizLT4PNYb
 FBFdewglKowbbw/jVzeHakovAnJFJGmie8uU+fGq4DpvU2QSgO6HsaeyM9cbv6GYiiaA9/
 MpuOiLXVe17tPTpVwI53I2SBCDhHCu587Nr70J2ASO/hP26AxUPaxtiK/73BZEc6erABYk
 /U53gewHPU2A8WccAsIY9PRAFmKX7X9zTvsqxsj3elLQHiFiTuxKoOhX/fvAbxeVdnLi/U
 xk/uXK9ezB+GHw/s1Z/x47WTuqG5uFOCFIeskCKwlJe1Nfj/Glr8JYTuSpjqP/dp+LcI7A
 OeUrf+hot5pvBv/506XswHlNQbvcb153dBWuoiu4zUwvg8FD04LuC5ORkVeHpTmDbKQZi3
 oBZ3xLBDEp61ijBQQarL/u06brRT8E0ju/SSy9vmhRO2XIZm1zxsCLfVCO2xnzL8Dh2Glh
 1eefyAo4mewvcguy9kzR6z1YWipxLQZeKTXmZcnOTRjkQe5XER+KHP/dcC2Q
X-ME-Proxy: <xmx:pF_yasg2AD9MXmjqnfvz5avA0bygTFD_0o0vTBSWGbhvIRnlDFZn6Q>
 <xmx:pF_yags8VWhgElIoBv5FUVuPh45x6WQ21DGXYMzbUWQ5-PDMw4cMyQ>
 <xmx:pF_yagh01RSVqhzPv_IwsgxZmOJ75lOgxHWCaYXBE7n0c04s4ESLoQ>
 <xmx:pF_yamZvn-hLZC5lnbcQyz3Pzi7s0e3VWdwlPPAc3WFoS-ClZHb1ZA>
 <xmx:pV_yauY-5f0BNK6ryL8o-xAGHOr-giojt3xvssdH5YJjy-pVGZrSMqEx>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 19:04:49 -0500 (EST)
Message-ID: <a5a795ce70bebc47410b60907a3430afbd350934.camel@alistair23.me>
Subject: Re: [PATCH v2 for-11.2 2/2] include/hw/core/ptimer.h: Fix 'version'
 argument of VMSTATE_PTIMER
From: Alistair <alistair@alistair23.me>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Chao Liu <chao.liu@processmission.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Bernhard Beschow <shentey@gmail.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Date: Tue, 10 Nov 2026 10:04:47 +1000
In-Reply-To: <20261106163657.3825938-3-peter.maydell@linaro.org>
References: <20261106163657.3825938-1-peter.maydell@linaro.org>
 <20261106163657.3825938-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.151;
 envelope-from=alistair@alistair23.me; helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-06 at 16:36 +0000, Peter Maydell wrote:
> The VMSTATE_PTIMER macro is defined to pass a 'version' argument of 1
> to VMSTATE_STRUCT_POINTER_TEST_V.=C2=A0 This means that the field will
> only be used in migration when the vmstate struct that uses
> VMSTATE_PTIMER has a version_id of at least 1.=C2=A0 This doesn't match
> how we define other VMSTATE_FOO which don't take an explicit
> version_id, which is to use a version argument of 0 (e.g. all the
> common macros like VMSTATE_UINT32 are written to pass 0 to their
> VMSTATE_UINT32_V counterparts, and so on). It also doesn't match
> how we define VMSTATE_PTIMER_ARRAY.
>=20
> The practical effect of this is that users of VMSTATE_PTIMER in
> vmstate structs which explicitly or implicitly have a version_id of 0
> were actually not getting their ptimers migrated.
>=20
> This affects:
> =C2=A0vmstate_xlnx_csu_dma in wh/dma/xlnx_csu_dma.c
> =C2=A0vmstate_k230_wdt in hw/watchdog/k230_wdt.c
>=20
> which are used in:
> =C2=A0* Arm Xilinx versal and zynq machines
> =C2=A0* RISC-V K230 machine
>=20
> Most ptimer users are unaffected because they took the usual approach
> of explicitly setting their starting version_id to 1.
>=20
> Fix the version_id in this field.=C2=A0 This is a migration compatibility
> break for all the above listed devices/machines.=C2=A0 Since the timers
> involved are in devices where the timer is usually stopped (e.g.=C2=A0 th=
e
> watchdogs only have the timer active when the watchdog is enabled and
> counting down), the consequences of the bug are likely not visible to
> most users.
>=20
> We could perhaps attempt to preserve migration compatibility here,
> but none of the affected machine types are versioned and so we do not
> promise cross-version compatibility, so do the simple thing.=C2=A0 Bump
> the version_id and version_id on the two affected vmstate structs so
> that attempted migration between old and new QEMU fails cleanly.
>=20
> Fixes: 852f771ec9e5c ("vmstate: port pmtimer")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4705
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> Not cc: stable because it's a migration format change and we
> don't generally backport those
> ---
> =C2=A0include/hw/core/ptimer.h | 2 +-
> =C2=A0hw/dma/xlnx_csu_dma.c=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0hw/watchdog/k230_wdt.c=C2=A0=C2=A0 | 2 ++
> =C2=A03 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/core/ptimer.h b/include/hw/core/ptimer.h
> index 4dc02b0de47..8513f8917e3 100644
> --- a/include/hw/core/ptimer.h
> +++ b/include/hw/core/ptimer.h
> @@ -300,7 +300,7 @@ void ptimer_stop(ptimer_state *s);
> =C2=A0extern const VMStateDescription vmstate_ptimer;
> =C2=A0
> =C2=A0#define VMSTATE_PTIMER(_field, _state) \
> -=C2=A0=C2=A0=C2=A0 VMSTATE_STRUCT_POINTER_V(_field, _state, 1, vmstate_p=
timer,
> ptimer_state)
> +=C2=A0=C2=A0=C2=A0 VMSTATE_STRUCT_POINTER_V(_field, _state, 0, vmstate_p=
timer,
> ptimer_state)
> =C2=A0
> =C2=A0#define VMSTATE_PTIMER_ARRAY(_f, _s,
> _n)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(_f, _s, _n,
> 0,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
> index 436f9915e02..ea703dc00ce 100644
> --- a/hw/dma/xlnx_csu_dma.c
> +++ b/hw/dma/xlnx_csu_dma.c
> @@ -679,8 +679,8 @@ static void xlnx_csu_dma_realize(DeviceState
> *dev, Error **errp)
> =C2=A0
> =C2=A0static const VMStateDescription vmstate_xlnx_csu_dma =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 .name =3D TYPE_XLNX_CSU_DMA,
> -=C2=A0=C2=A0=C2=A0 .version_id =3D 0,
> -=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 0,
> +=C2=A0=C2=A0=C2=A0 .version_id =3D 1,
> +=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 1,
> =C2=A0=C2=A0=C2=A0=C2=A0 .fields =3D (const VMStateField[]) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_PTIMER(src_timer=
, XlnxCSUDMA),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT16(width, Xl=
nxCSUDMA),
> diff --git a/hw/watchdog/k230_wdt.c b/hw/watchdog/k230_wdt.c
> index 1f83b499e82..fba2013b8f3 100644
> --- a/hw/watchdog/k230_wdt.c
> +++ b/hw/watchdog/k230_wdt.c
> @@ -234,6 +234,8 @@ static const MemoryRegionOps k230_wdt_ops =3D {
> =C2=A0
> =C2=A0static const VMStateDescription vmstate_k230_wdt =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "k230.wdt",
> +=C2=A0=C2=A0=C2=A0 .version_id =3D 1,
> +=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 1,
> =C2=A0=C2=A0=C2=A0=C2=A0 .fields =3D (const VMStateField[]) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_PTIMER(timer, K2=
30WdtState),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(cr, K230W=
dtState),

