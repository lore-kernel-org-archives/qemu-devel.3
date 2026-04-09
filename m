Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A0AF364CB
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxe6-0004cF-QF; Thu, 09 Apr 2026 18:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAxe4-0004bb-5y
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:14:40 -0400
Received: from p-east2-cluster6-host2-snip4-9.eps.apple.com ([57.103.76.190]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAxe1-0002JO-A7
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:14:39 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 5457B1800312; Thu, 09 Apr 2026 22:14:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775772876; x=1778364876;
 bh=2u2GKWRSqns7S3qYkRyXeQRWvMouqQwgLDJKwfl6qh4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Sv8FXKPHOGAFjvupX67huh/3v1xUi8jGe3k3sMqNd3HdWZoRyd+Z/WEwu0P9gnXQ3mMdtVpsYYtfKDHYgmSVzllF0LzUrTJZ4vimL+hizTMjxHmbRiLRaLgsvRWaO6KGwatTNhBwofhjEjkWxj0ZVX8ghRgHlaqGY0Ci4LrOqKlX3rV//se8SifUJTj2RVUBNiKdnxcQqw+oUA3fwA8IEqa7t61XdIGR92zLOhXh64UV6rREL6IbkcK5sOyQARQBGPXGudAKh3itJLY6wh0hrjqyyWhWV2d2X+SWUYem89eD4+pB7DSfGXtA4+VdtWA1Mf4ramq6L8S71G3xtzFX7Q==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 41409180031D; Thu, 09 Apr 2026 22:14:31 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v6 1/6] target/arm/emulate: add ISV=0 emulation library
 with load/store immediate
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260409220614.65558-2-lucaaamaral@gmail.com>
Date: Fri, 10 Apr 2026 00:14:19 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D54FE2F-DC48-4BAA-BF5E-B5D0E8168E52@unpredictable.fr>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <20260409220614.65558-2-lucaaamaral@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=dcSNHHXe c=1 sm=1 tr=0 ts=69d824ca
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=qT8vexpjeekLdwMrx4kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: K6lA4lJ7hS6YrmQNsUWKY2RQKRE-AinP
X-Proofpoint-ORIG-GUID: K6lA4lJ7hS6YrmQNsUWKY2RQKRE-AinP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwNSBTYWx0ZWRfX7BcjutZC/ka0
 0sPrLHOmuAzyvD05sGAVznbMHMEoBgnE7bdtpwCzYaeFDedUOuil5ALFeRLy0cM8w01pO8VDsEo
 oHkWj9WWpuWc/rrnpbj2SaoRkLWbRYO7bjHYOp/RLJj0LiTbcenFiprPQtI/x8AYibXrFMAwTxX
 +LWpJSRklhCuaWVPcLlzcDVHVpiYuNwmB3qnLCd+WP8fSQQpKVbD0qad8DGDbvTMRo3AEjZrWXm
 PrHU9Fi10YsbHWqZyQll9MlPIpZz/MgwfsrEMmaOcjqCO5FvFQU/FjopUwJ5V2nqV+j44xWEfgz
 8HS4BcaDjNHN67T1uXTyD41ROsI+dPxdIprW2RrJ+53GO44035stZCHMX2ZEDg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 clxscore=1030
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090205
Received-SPF: pass client-ip=57.103.76.190;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



> On 10. Apr 2026, at 00:06, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>=20
> Add a shared emulation library for AArch64 load/store instructions =
that
> cause ISV=3D0 data aborts under hardware virtualization (HVF, WHPX).
>=20
> When the Instruction Syndrome Valid bit is clear, the hypervisor =
cannot
> determine the faulting instruction's target register or access size =
from
> the syndrome alone.  This library fetches and decodes the instruction
> using a decodetree-generated decoder, then emulates it by accessing =
the
> vCPU's register file (CPUARMState) and guest memory via =
get_phys_addr()
> for MMU translation and address_space_read/write() for physical =
access.
>=20
> This patch establishes the framework and adds load/store single with
> immediate addressing =E2=80=94 the most common ISV=3D0 trigger.  =
Subsequent
> patches add register-offset, pair, exclusive, and atomic instructions.
>=20
> Instruction coverage:
>  - STR/LDR (GPR): unscaled, post-indexed, unprivileged, pre-indexed,
>    unsigned offset =E2=80=94 all sizes (8/16/32/64-bit), sign/zero =
extension
>  - STR/LDR (SIMD/FP): same addressing modes, 8-128 bit elements
>  - PRFM: prefetch treated as NOP
>  - DC cache maintenance (SYS CRn=3DC7): NOP on MMIO
>=20
> This library uses its own a64-ldst.decode rather than sharing
> target/arm/tcg/a64.decode.  TCG's trans_* functions are a compiler:
> they emit IR ops into a translation block for later execution.  This
> library's trans_* functions are an interpreter: they execute directly
> against the vCPU register file and memory.  The decodetree-generated
> dispatcher calls trans_* by name, so both cannot coexist in the same
> translation unit.  Decode patterns are kept consistent with TCG's
> where possible.
>=20
> Decodetree differences from TCG:
>  - &ldst_imm adds a 'u' flag to distinguish 9-bit signed vs 12-bit
>    unsigned immediate forms.  TCG uses %uimm_scaled to pre-scale
>    the unsigned immediate at decode time; here imm:12 is extracted
>    raw and the handler scales it.
>=20
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
> target/arm/emulate/a64-ldst.decode | 129 +++++++++++++
> target/arm/emulate/arm_emulate.c   | 288 +++++++++++++++++++++++++++++
> target/arm/emulate/arm_emulate.h   |  30 +++
> target/arm/emulate/meson.build     |   8 +
> target/arm/meson.build             |   1 +
> 5 files changed, 456 insertions(+)
> create mode 100644 target/arm/emulate/a64-ldst.decode
> create mode 100644 target/arm/emulate/arm_emulate.c
> create mode 100644 target/arm/emulate/arm_emulate.h
> create mode 100644 target/arm/emulate/meson.build
>=20
> diff --git a/target/arm/emulate/a64-ldst.decode =
b/target/arm/emulate/a64-ldst.decode
> new file mode 100644
> index 00000000..c887dcba
> --- /dev/null
> +++ b/target/arm/emulate/a64-ldst.decode
> @@ -0,0 +1,129 @@
> +# AArch64 load/store instruction patterns for ISV=3D0 emulation
> +#
> +# Copyright (c) 2026 Lucas Amaral <lucaaamaral@gmail.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +### Argument sets
> +
> +# Load/store immediate (unscaled, pre/post-index, unprivileged, =
unsigned offset)
> +# 'u' flag: 0 =3D 9-bit signed immediate (byte offset), 1 =3D 12-bit =
unsigned (needs << sz)
> +&ldst_imm       rt rn imm sz sign w p unpriv ext u
> +
> +### Format templates
> +
> +# Load/store immediate (9-bit signed)
> +@ldst_imm       .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=3D0 =
unpriv=3D0 p=3D0 w=3D0
> +@ldst_imm_pre   .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=3D0 =
unpriv=3D0 p=3D0 w=3D1
> +@ldst_imm_post  .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=3D0 =
unpriv=3D0 p=3D1 w=3D1
> +@ldst_imm_user  .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=3D0 =
unpriv=3D1 p=3D0 w=3D0
> +
> +# Load/store unsigned offset (12-bit, handler scales by << sz)
> +@ldst_uimm      .. ... . .. .. imm:12 rn:5 rt:5        &ldst_imm u=3D1 =
unpriv=3D0 p=3D0 w=3D0
> +
> +### Load/store register =E2=80=94 unscaled immediate (LDUR/STUR)
> +
> +# GPR
> +STR_i           sz:2 111 0 00 00 0 ......... 00 ..... .....    =
@ldst_imm sign=3D0 ext=3D0
> +LDR_i           00 111 0 00 01 0 ......... 00 ..... .....      =
@ldst_imm sign=3D0 ext=3D1 sz=3D0
> +LDR_i           01 111 0 00 01 0 ......... 00 ..... .....      =
@ldst_imm sign=3D0 ext=3D1 sz=3D1
> +LDR_i           10 111 0 00 01 0 ......... 00 ..... .....      =
@ldst_imm sign=3D0 ext=3D1 sz=3D2
> +LDR_i           11 111 0 00 01 0 ......... 00 ..... .....      =
@ldst_imm sign=3D0 ext=3D0 sz=3D3
> +LDR_i           00 111 0 00 10 0 ......... 00 ..... .....      =
@ldst_imm sign=3D1 ext=3D0 sz=3D0
> +LDR_i           01 111 0 00 10 0 ......... 00 ..... .....      =
@ldst_imm sign=3D1 ext=3D0 sz=3D1
> +LDR_i           10 111 0 00 10 0 ......... 00 ..... .....      =
@ldst_imm sign=3D1 ext=3D0 sz=3D2
> +LDR_i           00 111 0 00 11 0 ......... 00 ..... .....      =
@ldst_imm sign=3D1 ext=3D1 sz=3D0
> +LDR_i           01 111 0 00 11 0 ......... 00 ..... .....      =
@ldst_imm sign=3D1 ext=3D1 sz=3D1
> +
> +# SIMD/FP
> +STR_v_i         sz:2 111 1 00 00 0 ......... 00 ..... .....    =
@ldst_imm sign=3D0 ext=3D0
> +STR_v_i         00 111 1 00 10 0 ......... 00 ..... .....      =
@ldst_imm sign=3D0 ext=3D0 sz=3D4
> +LDR_v_i         sz:2 111 1 00 01 0 ......... 00 ..... .....    =
@ldst_imm sign=3D0 ext=3D0
> +LDR_v_i         00 111 1 00 11 0 ......... 00 ..... .....      =
@ldst_imm sign=3D0 ext=3D0 sz=3D4
> +
> +### Load/store register =E2=80=94 post-indexed
> +
> +# GPR
> +STR_i           sz:2 111 0 00 00 0 ......... 01 ..... .....    =
@ldst_imm_post sign=3D0 ext=3D0
> +LDR_i           00 111 0 00 01 0 ......... 01 ..... .....      =
@ldst_imm_post sign=3D0 ext=3D1 sz=3D0
> +LDR_i           01 111 0 00 01 0 ......... 01 ..... .....      =
@ldst_imm_post sign=3D0 ext=3D1 sz=3D1
> +LDR_i           10 111 0 00 01 0 ......... 01 ..... .....      =
@ldst_imm_post sign=3D0 ext=3D1 sz=3D2
> +LDR_i           11 111 0 00 01 0 ......... 01 ..... .....      =
@ldst_imm_post sign=3D0 ext=3D0 sz=3D3
> +LDR_i           00 111 0 00 10 0 ......... 01 ..... .....      =
@ldst_imm_post sign=3D1 ext=3D0 sz=3D0
> +LDR_i           01 111 0 00 10 0 ......... 01 ..... .....      =
@ldst_imm_post sign=3D1 ext=3D0 sz=3D1
> +LDR_i           10 111 0 00 10 0 ......... 01 ..... .....      =
@ldst_imm_post sign=3D1 ext=3D0 sz=3D2
> +LDR_i           00 111 0 00 11 0 ......... 01 ..... .....      =
@ldst_imm_post sign=3D1 ext=3D1 sz=3D0
> +LDR_i           01 111 0 00 11 0 ......... 01 ..... .....      =
@ldst_imm_post sign=3D1 ext=3D1 sz=3D1
> +
> +# SIMD/FP
> +STR_v_i         sz:2 111 1 00 00 0 ......... 01 ..... .....    =
@ldst_imm_post sign=3D0 ext=3D0
> +STR_v_i         00 111 1 00 10 0 ......... 01 ..... .....      =
@ldst_imm_post sign=3D0 ext=3D0 sz=3D4
> +LDR_v_i         sz:2 111 1 00 01 0 ......... 01 ..... .....    =
@ldst_imm_post sign=3D0 ext=3D0
> +LDR_v_i         00 111 1 00 11 0 ......... 01 ..... .....      =
@ldst_imm_post sign=3D0 ext=3D0 sz=3D4
> +
> +### Load/store register =E2=80=94 unprivileged
> +
> +# GPR only (no SIMD/FP unprivileged forms)
> +STR_i           sz:2 111 0 00 00 0 ......... 10 ..... .....    =
@ldst_imm_user sign=3D0 ext=3D0
> +LDR_i           00 111 0 00 01 0 ......... 10 ..... .....      =
@ldst_imm_user sign=3D0 ext=3D1 sz=3D0
> +LDR_i           01 111 0 00 01 0 ......... 10 ..... .....      =
@ldst_imm_user sign=3D0 ext=3D1 sz=3D1
> +LDR_i           10 111 0 00 01 0 ......... 10 ..... .....      =
@ldst_imm_user sign=3D0 ext=3D1 sz=3D2
> +LDR_i           11 111 0 00 01 0 ......... 10 ..... .....      =
@ldst_imm_user sign=3D0 ext=3D0 sz=3D3
> +LDR_i           00 111 0 00 10 0 ......... 10 ..... .....      =
@ldst_imm_user sign=3D1 ext=3D0 sz=3D0
> +LDR_i           01 111 0 00 10 0 ......... 10 ..... .....      =
@ldst_imm_user sign=3D1 ext=3D0 sz=3D1
> +LDR_i           10 111 0 00 10 0 ......... 10 ..... .....      =
@ldst_imm_user sign=3D1 ext=3D0 sz=3D2
> +LDR_i           00 111 0 00 11 0 ......... 10 ..... .....      =
@ldst_imm_user sign=3D1 ext=3D1 sz=3D0
> +LDR_i           01 111 0 00 11 0 ......... 10 ..... .....      =
@ldst_imm_user sign=3D1 ext=3D1 sz=3D1
> +
> +### Load/store register =E2=80=94 pre-indexed
> +
> +# GPR
> +STR_i           sz:2 111 0 00 00 0 ......... 11 ..... .....    =
@ldst_imm_pre sign=3D0 ext=3D0
> +LDR_i           00 111 0 00 01 0 ......... 11 ..... .....      =
@ldst_imm_pre sign=3D0 ext=3D1 sz=3D0
> +LDR_i           01 111 0 00 01 0 ......... 11 ..... .....      =
@ldst_imm_pre sign=3D0 ext=3D1 sz=3D1
> +LDR_i           10 111 0 00 01 0 ......... 11 ..... .....      =
@ldst_imm_pre sign=3D0 ext=3D1 sz=3D2
> +LDR_i           11 111 0 00 01 0 ......... 11 ..... .....      =
@ldst_imm_pre sign=3D0 ext=3D0 sz=3D3
> +LDR_i           00 111 0 00 10 0 ......... 11 ..... .....      =
@ldst_imm_pre sign=3D1 ext=3D0 sz=3D0
> +LDR_i           01 111 0 00 10 0 ......... 11 ..... .....      =
@ldst_imm_pre sign=3D1 ext=3D0 sz=3D1
> +LDR_i           10 111 0 00 10 0 ......... 11 ..... .....      =
@ldst_imm_pre sign=3D1 ext=3D0 sz=3D2
> +LDR_i           00 111 0 00 11 0 ......... 11 ..... .....      =
@ldst_imm_pre sign=3D1 ext=3D1 sz=3D0
> +LDR_i           01 111 0 00 11 0 ......... 11 ..... .....      =
@ldst_imm_pre sign=3D1 ext=3D1 sz=3D1
> +
> +# SIMD/FP
> +STR_v_i         sz:2 111 1 00 00 0 ......... 11 ..... .....    =
@ldst_imm_pre sign=3D0 ext=3D0
> +STR_v_i         00 111 1 00 10 0 ......... 11 ..... .....      =
@ldst_imm_pre sign=3D0 ext=3D0 sz=3D4
> +LDR_v_i         sz:2 111 1 00 01 0 ......... 11 ..... .....    =
@ldst_imm_pre sign=3D0 ext=3D0
> +LDR_v_i         00 111 1 00 11 0 ......... 11 ..... .....      =
@ldst_imm_pre sign=3D0 ext=3D0 sz=3D4
> +
> +### PRFM =E2=80=94 unscaled immediate: prefetch is a NOP
> +
> +NOP             11 111 0 00 10 0 --------- 00 ----- -----
> +
> +### Load/store register =E2=80=94 unsigned offset
> +
> +# GPR
> +STR_i           sz:2 111 0 01 00 ............ ..... .....       =
@ldst_uimm sign=3D0 ext=3D0
> +LDR_i           00 111 0 01 01 ............ ..... .....         =
@ldst_uimm sign=3D0 ext=3D1 sz=3D0
> +LDR_i           01 111 0 01 01 ............ ..... .....         =
@ldst_uimm sign=3D0 ext=3D1 sz=3D1
> +LDR_i           10 111 0 01 01 ............ ..... .....         =
@ldst_uimm sign=3D0 ext=3D1 sz=3D2
> +LDR_i           11 111 0 01 01 ............ ..... .....         =
@ldst_uimm sign=3D0 ext=3D0 sz=3D3
> +LDR_i           00 111 0 01 10 ............ ..... .....         =
@ldst_uimm sign=3D1 ext=3D0 sz=3D0
> +LDR_i           01 111 0 01 10 ............ ..... .....         =
@ldst_uimm sign=3D1 ext=3D0 sz=3D1
> +LDR_i           10 111 0 01 10 ............ ..... .....         =
@ldst_uimm sign=3D1 ext=3D0 sz=3D2
> +LDR_i           00 111 0 01 11 ............ ..... .....         =
@ldst_uimm sign=3D1 ext=3D1 sz=3D0
> +LDR_i           01 111 0 01 11 ............ ..... .....         =
@ldst_uimm sign=3D1 ext=3D1 sz=3D1
> +
> +# PRFM =E2=80=94 unsigned offset
> +NOP             11 111 0 01 10 ------------ ----- -----
> +
> +# SIMD/FP
> +STR_v_i         sz:2 111 1 01 00 ............ ..... .....       =
@ldst_uimm sign=3D0 ext=3D0
> +STR_v_i         00 111 1 01 10 ............ ..... .....         =
@ldst_uimm sign=3D0 ext=3D0 sz=3D4
> +LDR_v_i         sz:2 111 1 01 01 ............ ..... .....       =
@ldst_uimm sign=3D0 ext=3D0
> +LDR_v_i         00 111 1 01 11 ............ ..... .....         =
@ldst_uimm sign=3D0 ext=3D0 sz=3D4
> +
> +### System instructions =E2=80=94 DC cache maintenance
> +
> +# SYS with CRn=3DC7 covers all data cache operations (DC CIVAC, CVAC, =
etc.).
> +# On MMIO regions, cache maintenance is a harmless no-op.
> +NOP             1101 0101 0000 1 --- 0111 ---- --- -----
> diff --git a/target/arm/emulate/arm_emulate.c =
b/target/arm/emulate/arm_emulate.c
> new file mode 100644
> index 00000000..bedbdb3e
> --- /dev/null
> +++ b/target/arm/emulate/arm_emulate.c
> @@ -0,0 +1,288 @@
> +/*
> + * AArch64 instruction emulation for ISV=3D0 data aborts
> + *
> + * Copyright (c) 2026 Lucas Amaral <lucaaamaral@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "arm_emulate.h"
> +#include "target/arm/cpu.h"
> +#include "target/arm/internals.h"
> +#include "exec/cpu-common.h"
> +#include "system/memory.h"
> +#include "exec/target_page.h"
> +#include "qemu/bitops.h"
> +#include "qemu/bswap.h"
> +
> +/* Named "DisasContext" as required by the decodetree code generator =
*/
> +typedef struct {
> +    CPUState *cpu;
> +    CPUARMState *env;
> +    ArmEmulResult result;
> +    bool be_data;
> +} DisasContext;
> +
> +#include "decode-a64-ldst.c.inc"
> +
> +/* GPR data access (Rt, Rs, Rt2) -- register 31 =3D XZR */
> +
> +static uint64_t gpr_read(DisasContext *ctx, int reg)
> +{
> +    if (reg =3D=3D 31) {
> +        return 0;  /* XZR */
> +    }
> +    return ctx->env->xregs[reg];
> +}
> +
> +static void gpr_write(DisasContext *ctx, int reg, uint64_t val)
> +{
> +    if (reg =3D=3D 31) {
> +        return;  /* XZR -- discard */
> +    }
> +    ctx->env->xregs[reg] =3D val;
> +    ctx->cpu->vcpu_dirty =3D true;
> +}
> +
> +/* Base register access (Rn) -- register 31 =3D SP */
> +
> +static uint64_t base_read(DisasContext *ctx, int rn)
> +{
> +    return ctx->env->xregs[rn];
> +}
> +
> +static void base_write(DisasContext *ctx, int rn, uint64_t val)
> +{
> +    ctx->env->xregs[rn] =3D val;
> +    ctx->cpu->vcpu_dirty =3D true;
> +}
> +
> +/* SIMD/FP register access */
> +
> +static void fpreg_read(DisasContext *ctx, int reg, void *buf, int =
size)
> +{
> +    memcpy(buf, &ctx->env->vfp.zregs[reg], size);
> +}
> +
> +static void fpreg_write(DisasContext *ctx, int reg, const void *buf, =
int size)
> +{
> +    memset(&ctx->env->vfp.zregs[reg], 0, =
sizeof(ctx->env->vfp.zregs[reg]));
> +    memcpy(&ctx->env->vfp.zregs[reg], buf, size);
> +    ctx->cpu->vcpu_dirty =3D true;
> +}
> +
> +/*
> + * Memory access via guest MMU translation.
> + *
> + * Translates the virtual address through the guest page tables using
> + * get_phys_addr(), then performs the access on the resulting =
physical
> + * address via address_space_read/write().  Each page-sized chunk is
> + * translated independently, so accesses that span a page boundary
> + * are handled correctly even when the pages map to different =
physical
> + * addresses.
> + */
> +
Hello,

Perhaps having a common version of this for fetching the instruction

Apart from that

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> +static int mem_access(DisasContext *ctx, uint64_t va, void *buf, int =
size,
> +                      MMUAccessType access_type)
> +{
> +    ARMMMUIdx mmu_idx =3D arm_mmu_idx(ctx->env);
> +
> +    while (size > 0) {
> +        int chunk =3D MIN(size, TARGET_PAGE_SIZE - (va & =
~TARGET_PAGE_MASK));
> +        GetPhysAddrResult res =3D {};
> +        ARMMMUFaultInfo fi =3D {};
> +
> +        if (get_phys_addr(ctx->env, va, access_type, 0, mmu_idx,
> +                          &res, &fi)) {
> +            ctx->result =3D ARM_EMUL_ERR_MEM;
> +            return -1;
> +        }
> +
> +        AddressSpace *as =3D arm_addressspace(ctx->cpu, res.f.attrs);
> +        MemTxResult txr;
> +
> +        if (access_type =3D=3D MMU_DATA_STORE) {
> +            txr =3D address_space_write(as, res.f.phys_addr, =
res.f.attrs,
> +                                      buf, chunk);
> +        } else {
> +            txr =3D address_space_read(as, res.f.phys_addr, =
res.f.attrs,
> +                                     buf, chunk);
> +        }
> +
> +        if (txr !=3D MEMTX_OK) {
> +            ctx->result =3D ARM_EMUL_ERR_MEM;
> +            return -1;
> +        }
> +
> +        va +=3D chunk;
> +        buf +=3D chunk;
> +        size -=3D chunk;
> +    }
> +    return 0;
> +}
> +
> +static int mem_read(DisasContext *ctx, uint64_t va, void *buf, int =
size)
> +{
> +    return mem_access(ctx, va, buf, size, MMU_DATA_LOAD);
> +}
> +
> +static int mem_write(DisasContext *ctx, uint64_t va, const void *buf, =
int size)
> +{
> +    return mem_access(ctx, va, (void *)buf, size, MMU_DATA_STORE);
> +}
> +
> +/*
> + * Endian-aware GPR <-> memory buffer helpers.
> + *
> + * mem_read/mem_write transfer raw bytes between guest VA and a host =
buffer.
> + * mem_ld/mem_st convert between a uint64_t register value and the =
guest
> + * byte order in a memory buffer.
> + */
> +
> +static uint64_t mem_ld(DisasContext *ctx, const void *buf, int size)
> +{
> +    return ctx->be_data ? ldn_be_p(buf, size) : ldn_le_p(buf, size);
> +}
> +
> +static void mem_st(DisasContext *ctx, void *buf, int size, uint64_t =
val)
> +{
> +    if (ctx->be_data) {
> +        stn_be_p(buf, size, val);
> +    } else {
> +        stn_le_p(buf, size, val);
> +    }
> +}
> +
> +/* Apply sign/zero extension */
> +static uint64_t load_extend(uint64_t val, int sz, int sign, int ext)
> +{
> +    int data_bits =3D 8 << sz;
> +
> +    if (sign) {
> +        val =3D sextract64(val, 0, data_bits);
> +        if (ext) {
> +            /* Sign-extend to 32 bits (W register) */
> +            val &=3D 0xFFFFFFFF;
> +        }
> +    } else if (ext) {
> +        /* Zero-extend to 32 bits (W register) */
> +        val &=3D 0xFFFFFFFF;
> +    }
> +    return val;
> +}
> +
> +/* Load/store single -- immediate (GPR) (DDI 0487 C3.3.8 -- C3.3.13) =
*/
> +
> +static bool trans_STR_i(DisasContext *ctx, arg_ldst_imm *a)
> +{
> +    int esize =3D (a->sz <=3D 3) ? (1 << a->sz) : 16;
> +    int64_t offset =3D a->u ? ((int64_t)(uint64_t)a->imm << a->sz)
> +                          : (int64_t)a->imm;
> +    uint64_t base =3D base_read(ctx, a->rn);
> +    uint64_t va =3D a->p ? base : base + offset;
> +
> +    uint8_t buf[16];
> +    uint64_t val =3D gpr_read(ctx, a->rt);
> +    mem_st(ctx, buf, esize, val);
> +    if (mem_write(ctx, va, buf, esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
> +static bool trans_LDR_i(DisasContext *ctx, arg_ldst_imm *a)
> +{
> +    int esize =3D (a->sz <=3D 3) ? (1 << a->sz) : 16;
> +    int64_t offset =3D a->u ? ((int64_t)(uint64_t)a->imm << a->sz)
> +                          : (int64_t)a->imm;
> +    uint64_t base =3D base_read(ctx, a->rn);
> +    uint64_t va =3D a->p ? base : base + offset;
> +    uint8_t buf[16];
> +
> +    if (mem_read(ctx, va, buf, esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    uint64_t val =3D mem_ld(ctx, buf, esize);
> +    val =3D load_extend(val, a->sz, a->sign, a->ext);
> +    gpr_write(ctx, a->rt, val);
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
> +/*
> + * Load/store single -- immediate (SIMD/FP)
> + * STR_v_i / LDR_v_i (DDI 0487 C3.3.10)
> + */
> +
> +static bool trans_STR_v_i(DisasContext *ctx, arg_ldst_imm *a)
> +{
> +    int esize =3D (a->sz <=3D 3) ? (1 << a->sz) : 16;
> +    int64_t offset =3D a->u ? ((int64_t)(uint64_t)a->imm << a->sz)
> +                          : (int64_t)a->imm;
> +    uint64_t base =3D base_read(ctx, a->rn);
> +    uint64_t va =3D a->p ? base : base + offset;
> +    uint8_t buf[16];
> +
> +    fpreg_read(ctx, a->rt, buf, esize);
> +    if (mem_write(ctx, va, buf, esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
> +static bool trans_LDR_v_i(DisasContext *ctx, arg_ldst_imm *a)
> +{
> +    int esize =3D (a->sz <=3D 3) ? (1 << a->sz) : 16;
> +    int64_t offset =3D a->u ? ((int64_t)(uint64_t)a->imm << a->sz)
> +                          : (int64_t)a->imm;
> +    uint64_t base =3D base_read(ctx, a->rn);
> +    uint64_t va =3D a->p ? base : base + offset;
> +    uint8_t buf[16];
> +
> +    if (mem_read(ctx, va, buf, esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    fpreg_write(ctx, a->rt, buf, esize);
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
> +/* PRFM, DC cache maintenance -- treated as NOP */
> +static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
> +{
> +    return true;
> +}
> +
> +/* Entry point */
> +
> +ArmEmulResult arm_emul_insn(CPUArchState *env, uint32_t insn)
> +{
> +    DisasContext ctx =3D {
> +        .cpu =3D env_cpu(env),
> +        .env =3D env,
> +        .result =3D ARM_EMUL_OK,
> +        .be_data =3D arm_cpu_data_is_big_endian(env),
> +    };
> +
> +    if (!decode_a64_ldst(&ctx, insn)) {
> +        return ARM_EMUL_UNHANDLED;
> +    }
> +
> +    return ctx.result;
> +}
> diff --git a/target/arm/emulate/arm_emulate.h =
b/target/arm/emulate/arm_emulate.h
> new file mode 100644
> index 00000000..7fe29839
> --- /dev/null
> +++ b/target/arm/emulate/arm_emulate.h
> @@ -0,0 +1,30 @@
> +/*
> + * AArch64 instruction emulation library
> + *
> + * Copyright (c) 2026 Lucas Amaral <lucaaamaral@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef ARM_EMULATE_H
> +#define ARM_EMULATE_H
> +
> +#include "qemu/osdep.h"
> +
> +/**
> + * ArmEmulResult - return status from arm_emul_insn()
> + */
> +typedef enum {
> +    ARM_EMUL_OK,         /* Instruction emulated successfully */
> +    ARM_EMUL_UNHANDLED,  /* Instruction not recognized by decoder */
> +    ARM_EMUL_ERR_MEM,    /* Memory access failed */
> +} ArmEmulResult;
> +
> +/**
> + * arm_emul_insn - decode and emulate one AArch64 instruction
> + *
> + * Caller must synchronize CPU state and fetch @insn before calling.
> + */
> +ArmEmulResult arm_emul_insn(CPUArchState *env, uint32_t insn);
> +
> +#endif /* ARM_EMULATE_H */
> diff --git a/target/arm/emulate/meson.build =
b/target/arm/emulate/meson.build
> new file mode 100644
> index 00000000..e5455bd2
> --- /dev/null
> +++ b/target/arm/emulate/meson.build
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +gen_a64_ldst =3D decodetree.process('a64-ldst.decode',
> +    extra_args: ['--static-decode=3Ddecode_a64_ldst'])
> +
> +arm_common_system_ss.add(when: 'TARGET_AARCH64', if_true: [
> +    gen_a64_ldst, files('arm_emulate.c')
> +])
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 6e0e504a..a4b2291b 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -57,6 +57,7 @@ arm_common_system_ss.add(files(
>   'vfp_fpscr.c',
> ))
>=20
> +subdir('emulate')
> subdir('hvf')
> subdir('whpx')
>=20
> --=20
> 2.52.0
>=20


