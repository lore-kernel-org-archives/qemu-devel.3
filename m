Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE12F459F8
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEak-0006xf-9T; Fri, 10 Apr 2026 12:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wBEaf-0006pb-E4
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:20:20 -0400
Received: from p-west2-cluster2-host9-snip4-5.eps.apple.com ([57.103.68.168]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wBEac-0003UW-UR
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:20:17 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with ESMTPS id
 0529618000AC; Fri, 10 Apr 2026 16:20:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775838013; x=1778430013;
 bh=9C9EfZBCmJzTDp9vPQ8rjVTNZBfPyjCtGagVGhQwjV8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=V0H3toQrGd5lN65Up6OaQfEadZXKqXVLI4se8p/U1AGSnJGUKZ35QPHURHIikzMYvbLSWak/nwqaTPbA+c+BLTe3u8odccEbL3SEDhBlGRruXBAW0wAxMTLYWJC6wfoA/ID/OxDp74JlHcUNgGWN4kjpPKBiYHgN+/RIWrfRwMjF5D9DTutBPt87rtC4vEhLKEkbFf3RHSZDwUfeom86CRbvdAIOOWiFF+Dti0eCx7wbDDCzZxUAF1n5fKBvJvDiuAuHlNxjX+mw/ddoje6yo80jImLbXZz4TRJ2d2jLUz0gVr9AT1PWPus/sSURE9gtdo6oUhOJmu6nou29iGSvWA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-20-percent-0 (Postfix) with ESMTPSA id
 726A21800119; Fri, 10 Apr 2026 16:20:07 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] target/i386/mshv: Fix segment regression in MMIO emu
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260410142652.367541-1-magnuskulke@linux.microsoft.com>
Date: Fri, 10 Apr 2026 18:19:53 +0200
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@microsoft.com>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Wei Liu <liuwe@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8678AD43-795C-4803-925C-38AE29473D4C@unpredictable.fr>
References: <20260410142652.367541-1-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE1MyBTYWx0ZWRfX5uhVmZWg77Od
 r99PzA31p5zXcuIJJ7DpHxQbM8r2FiFOFD1ANbbmSBRlinyJWahwrWJVPwqp4T63DjfyAh0sIXu
 dbEhfdp+S418qt9zn/kBHwRoFfcKZvWZ4RJMaOF8/iloj1KWeeHsSu356sG/aah5DiykMjZSr2J
 vbDDUHoJ9+w5iRwROyGUpafmCyeKkzrpJBC/rm+/iB8u8d5O2Bk678Ew2lpgaFatQAUU/C3Q+T9
 DPNRsWJ/KIL/KkZifGJN2Ia55fEVqA2DSR6LYT6l5JBMCVRrNZLp83ayoiK9FbAP6AOSOreN9lp
 woky5U0LS71e9eDom/Mn/7adwOqOik2347HfwYH39NGrwUKV2n9Jb3IZEB7gEA=
X-Proofpoint-ORIG-GUID: 6thnDMEqVsSmhQSG2nL7O8zRQhg5n6X8
X-Authority-Info-Out: v=2.4 cv=LJxrgZW9 c=1 sm=1 tr=0 ts=69d9233b
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=-qgjkGIHYDdkKxKmpZ4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 6thnDMEqVsSmhQSG2nL7O8zRQhg5n6X8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604100153
Received-SPF: pass client-ip=57.103.68.168;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 10. Apr 2026, at 16:26, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> When the segmentation code has been reworked, there is now an
> unconditional call to emul_ops->read_segment_descriptor(). The MSHV =
impl
> was delegating this to x86_read_segement_descriptor(), which read from
> the GDT in guest memory. This fails for selector.idx =3D=3D 0 and when =
no
> GDT is set up (which is the case in real mode).
>=20
> In the fix we change the MSHV impl to fill segment descriptor from
> SegmentCache, that was populated from the hypervisor by =
mshv_load_regs()
> before instruction emulation.
>=20
> Fixes: 09442d98ab (target/i386: emulate: segmentation rework)
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> ---
> target/i386/mshv/mshv-cpu.c | 39 ++++++++++++++++++++++++++++++-------
> 1 file changed, 32 insertions(+), 7 deletions(-)
>=20
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 2bc978deb2..4ed6e7548f 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1552,17 +1552,42 @@ static void read_segment_descriptor(CPUState =
*cpu,
>                                     struct x86_segment_descriptor =
*desc,
>                                     enum X86Seg seg_idx)
> {
> -    bool ret;
>     X86CPU *x86_cpu =3D X86_CPU(cpu);
>     CPUX86State *env =3D &x86_cpu->env;
>     SegmentCache *seg =3D &env->segs[seg_idx];
> -    x86_segment_selector sel =3D { .sel =3D seg->selector & 0xFFFF };
> -
> -    ret =3D x86_read_segment_descriptor(cpu, desc, sel);
> -    if (ret =3D=3D false) {
> -        error_report("failed to read segment descriptor");
> -        abort();
> +    uint32_t limit;
> +
> +    memset(desc, 0, sizeof(struct x86_segment_descriptor));
> +
> +    desc->type =3D (seg->flags & DESC_TYPE_MASK) >> DESC_TYPE_SHIFT;
> +    desc->s    =3D (seg->flags & DESC_S_MASK)    >> DESC_S_SHIFT;
> +    desc->dpl  =3D (seg->flags & DESC_DPL_MASK)  >> DESC_DPL_SHIFT;
> +    desc->p    =3D (seg->flags & DESC_P_MASK)    >> DESC_P_SHIFT;
> +    desc->avl  =3D (seg->flags & DESC_AVL_MASK)  >> DESC_AVL_SHIFT;
> +    desc->l    =3D (seg->flags & DESC_L_MASK)    >> DESC_L_SHIFT;
> +    desc->db   =3D (seg->flags & DESC_B_MASK)    >> DESC_B_SHIFT;
> +    desc->g    =3D (seg->flags & DESC_G_MASK)    >> DESC_G_SHIFT;
> +
> +    /*
> +     * SegmentCache stores the hypervisor-provided value verbatim =
(populated by
> +     * mshv_load_regs). We need to convert it to format expected by =
the
> +     * instruction emulator. We can have a limit value > 0xfffff with
> +     * granularity of 0 (byte granularity), which is not =
representable
> +     * in real x86_segment_descriptor. In this case we set =
granularity to 1
> +     * (4k granularity) and shift the limit accordingly.
> +     *
> +     * This quirk has been adopted from =
"whpx_segment_to_x86_description()"
> +     */
> +
> +    if (!desc->g && seg->limit <=3D 0xfffff) {
> +        limit =3D seg->limit;
> +    } else {
> +        limit =3D seg->limit >> 12;
> +        desc->g =3D 1;
>     }
> +
> +    x86_set_segment_limit(desc, limit);
> +    x86_set_segment_base(desc, seg->base);
> }
>=20
> static const struct x86_emul_ops mshv_x86_emul_ops =3D {
> --=20
> 2.34.1
>=20
>=20


