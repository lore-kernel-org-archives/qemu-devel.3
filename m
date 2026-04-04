Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61ECE88D84
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 05:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8tdT-0008MH-Pd; Sat, 04 Apr 2026 01:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8tba-0007BL-U1
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 01:31:34 -0400
Received: from p-west3-cluster5-host1-snip4-4.eps.apple.com ([57.103.72.67]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8tbY-0003rn-ID
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 01:31:34 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPS id
 5D3AB18000D3; Sat, 04 Apr 2026 05:31:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775280689; x=1777872689;
 bh=Hu2KKijghiT58ujR7hIe3z/kmfJxc7AkGtWu3RDKuLI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=d1dIdO86IPt0u07nh/kS6OTS8LOSofQuQ4wnQwS6BVrFz21J7VmN0xs1udq8EU9BulvcjQ6jP3cw4gYv5Gh6RIE1b5gw6lLvRqUGNbe79n4rIpC6DeZFVG4JHLfPXZthT3Sz9U0NuRKCuQ1j83y6K6zE8Gl6bn5PvchpxGsMpkkKbZCMmLRw7g7LzeywUZMxahEAqjLRu2um+9Zl3ocEAuvpuyppuMdL6y1UkJ7BALyC5afW/DqLdDG/QzBPdPR2lWAWX1xK9/loKn8IM5brvv9kDQ0UyPOco6Gz2+rATj3ZsmdtzorDwfBYiEvECJSrK49PVJvENal1JglNw9EIHg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-10-percent-1 (Postfix) with ESMTPSA id
 0D8DF18000E6; Sat, 04 Apr 2026 05:31:24 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v6 07/11] whpx: i386: introduce proper cpuid support
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260404042015.86580-8-mohamed@unpredictable.fr>
Date: Sat, 4 Apr 2026 07:31:12 +0200
Cc: Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <13310089-FC17-42D8-9283-B9D380C925E7@unpredictable.fr>
References: <20260404042015.86580-1-mohamed@unpredictable.fr>
 <20260404042015.86580-8-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-GUID: LTOUl0zd13eLVZgxpgDA4ggDvpx55TSv
X-Proofpoint-ORIG-GUID: LTOUl0zd13eLVZgxpgDA4ggDvpx55TSv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA0NiBTYWx0ZWRfX1WKbjXMYQ3Nn
 eKDM7dx5QuhywUGnmHp9tsi5LWmIFs13yZ5EDlehimGe1dHByQkpbsJX8D93RErT83xQTNSqyis
 qV0PyOeLLSWJgFGfgT52mD7kkdzJHhQ22tx0lPWtJGQItohKJjXUgyCGsLajEMDPaIGUlSmjILb
 j95TQgLRTvQt878TVKe8fvLZJ2xy7lNGQrgMKAi6KWovn3ZJzRe88fKU2J90p6B4DADd6hil1LT
 sgVIw979ZtBq1KDhBALZkM787ukdOc8SWss299LbelVjFn6u9cJE+kkAtxXDR1miPd0YLtEL+hh
 coRSfNY0gh0Vyw1zjA2QsHFZt1RcFPczJMN7ozd/AuyWNb95vEetZeWAnByF70=
X-Authority-Info-Out: v=2.4 cv=epHSD4pX c=1 sm=1 tr=0 ts=69d0a230
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=xdUuE5n_Jaq1-9jlNbcA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1030 mlxlogscore=892 suspectscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604040046
Received-SPF: pass client-ip=57.103.72.67;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



> On 4. Apr 2026, at 06:20, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Unlike the implementation in QEMU 10.2, this one works.
>=20
> It's not optimal though as it doesn't use the Hyper-V support for =
this.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/i386/whpx/whpx-all.c | 39 ++++++++++++++++++++++++++++++++++---
> 1 file changed, 36 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 03233d1b94..3e006496be 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -2127,6 +2127,35 @@ int whpx_vcpu_run(CPUState *cpu)
>                     }
>                     break;
>                 }
> +            } else {
> +                switch (vcpu->exit_ctx.CpuidAccess.Rax) {
> +                case 0x40000000:
> +                case 0x40000001:
> +                case 0x40000010:
> +                    reg_values[1].Reg64 =3D =
vcpu->exit_ctx.CpuidAccess.DefaultResultRax;
> +                    reg_values[2].Reg64 =3D =
vcpu->exit_ctx.CpuidAccess.DefaultResultRcx;
> +                    reg_values[3].Reg64 =3D =
vcpu->exit_ctx.CpuidAccess.DefaultResultRdx;
> +                    reg_values[4].Reg64 =3D =
vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
> +                    break;
> +                }
> +            }
> +
> +            /* Dynamic depending on XCR0 and XSS, so query =
DefaultResult */
> +            if (vcpu->exit_ctx.CpuidAccess.Rax =3D=3D 0x07
> +                && vcpu->exit_ctx.CpuidAccess.Rcx =3D=3D 0) {
> +                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRdx
> +                    & CPUID_7_0_EDX_CET_IBT) {
> +                    reg_values[3].Reg32 |=3D CPUID_7_0_EDX_CET_IBT;
> +                } else {
> +                    reg_values[3].Reg32 &=3D ~CPUID_7_0_EDX_CET_IBT;
> +                }
> +
> +                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
> +                    & CPUID_7_0_ECX_CET_SHSTK) {
> +                    reg_values[2].Reg32 |=3D CPUID_7_0_ECX_CET_SHSTK;
> +                } else {
> +                    reg_values[2].Reg32 &=3D =
~CPUID_7_0_ECX_CET_SHSTK;
> +                }

Hello,

To not send yet another revision again (if no further revision
needed, can be squashed with this when the time comes):

From: Mohamed Mediouni <mohamed@unpredictable.fr>
Date: Sat, 4 Apr 2026 07:00:42 +0200
Subject: [PATCH] whpx: i386: fix osxsave

OSXSAVE is dynamic and relies on the state of CR4.
Instead of reading CR4, falling back on the default
CPUID results provided by the hypervisor.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index ac2671745f..71cc3e0991 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2149,6 +2149,16 @@ int whpx_vcpu_run(CPUState *cpu)
                 }
             }
=20
+            /* OSXSAVE is dynamic. Do this instead of syncing CR4 */
+            if (vcpu->exit_ctx.CpuidAccess.Rax =3D=3D 1) {
+                if (vcpu->exit_ctx.CpuidAccess.DefaultResultRcx
+                    & CPUID_EXT_OSXSAVE) {
+                    reg_values[2].Reg32 |=3D CPUID_EXT_OSXSAVE;
+                } else {
+                    reg_values[2].Reg32 &=3D ~CPUID_EXT_OSXSAVE;
+                }
+            }
+
             hr =3D whp_dispatch.WHvSetVirtualProcessorRegisters(
                 whpx->partition,
                 cpu->cpu_index,
--=20
2.50.1 (Apple Git-155)


