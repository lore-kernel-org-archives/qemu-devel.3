Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49120F99C8D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 00:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEFoK-00089W-32; Sat, 18 Apr 2026 20:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEFoI-00089O-Df
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 20:14:50 -0400
Received: from p-east2-cluster3-host3-snip4-4.eps.apple.com ([57.103.77.155]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEFoG-0001eW-8u
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 20:14:50 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPS id
 009F218000BF; Sun, 19 Apr 2026 00:14:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776557686; x=1779149686;
 bh=KpIctzXqg3kXtDhuq4XdOg8zLKPH4SuOnIhqEDtV8Mk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=CZJ+KV7u1b5SzL28wzLs7RHUpCDa9jA4s8T14TklHsnOskTqSs1+SP9ieFfigfguinitkJh3Dhgl/r23ReWxVLlx1+65jQMm76QCKZrmqI+pgi4AupKhlp8ogkM5xhTiyYixez+Z9inaXz/WcqJB/Iw1W5rc+H8EnWoUcs/98CRFuyzjtQ7TRweH6zyHvmCflVT46Hr9RDlAYXchXlrXj6w6ScqT2f5L76v4ueimCXHZnZHNGHYOBPel5S0GcpF4IYzQ5oMfLH7qBnfaLQLApges3Fr8kZl8yMxNeDbgG50ls0u9f3RNgyZCmiFTH7Hmpw+/SMNx+8DTN3IQtO8Y1w==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPSA id
 A3E451800180; Sun, 19 Apr 2026 00:14:44 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] hw: i386: vapic: restore IRQ polling for non-kernel
 irqchip backends
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260418061429.16898-1-rickgcn@gmail.com>
Date: Sun, 19 Apr 2026 02:14:32 +0200
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9926A5B0-8660-433D-B074-3B49E830BC9D@unpredictable.fr>
References: <20260418061429.16898-1-rickgcn@gmail.com>
To: rickgcn <rickgcn@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=NeTrFmD4 c=1 sm=1 tr=0 ts=69e41e76
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=W4rVtugX6geAamtpO3UA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: V2HNkNOKyCf7KTh1lC-86RiJj6tuTwa9
X-Proofpoint-ORIG-GUID: V2HNkNOKyCf7KTh1lC-86RiJj6tuTwa9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDAwMSBTYWx0ZWRfX+dmk/8w/OzVe
 sS/95OoRtNkIs+VF+vMMiuI7aP8oZBEHB9DpAACYSU3mgIUxtUfFBAs2t1xRSXy5GGB9PF+cOzp
 x0Z0PPlgRsDlTprxX4362sEHp0vgNFEE6oWo4we91xIkkBd3qO+2EPNLr3PRMDSZbxACZYWv+Wd
 MGuX7stiapHUV7kqYUm79Y4xV6VYT8NojiGP2kBXRP0ygEkqUM7sZ0TgqZZ8OXCmZkyMDwZ53mY
 CpTgSi7Sag5p4SPO2ZVOvkUYJXG9u4v1PrWqzT5aMzR0F/JoDo0moo+4H80ImwwfTjLp/cGLem2
 cfSK0cdolVp6/hwB6LEv8lCbOCafrMHHv83b/20mH5N7e7dUh+VD9xhP4UptFE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_07,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 clxscore=1030 spamscore=0 lowpriorityscore=0 mlxlogscore=883 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604190001
Received-SPF: pass client-ip=57.103.77.155;
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



> On 18. Apr 2026, at 08:14, rickgcn <rickgcn@gmail.com> wrote:
>=20
> 69dfc078 extended vAPIC handling for WHPX with user-mode irqchip, but =
it
> also changed vapic_write() case 4 in a way that excludes TCG from
> apic_poll_irq().
>=20
> Before that change, IRQ polling happened whenever no in-kernel irqchip
> was active. After the change, it only happened for KVM or WHPX with a
> user-mode irqchip. Under TCG, both kvm_enabled() and whpx_enabled() =
are
> false, so the poll never happens.
>=20
> This regresses 32-bit Windows XP guests on a Windows host with
> -machine pc-i440fx-10.0,accel=3Dtcg, causing a STOP 0x0000000A during =
boot.
>=20
> Fix it by making the decision depend on whether KVM or WHPX is using =
an
> in-kernel irqchip, instead of whether either accelerator is enabled.
>=20
> Fixes: 69dfc078a6f0 ("hw: i386: vapic: enable on WHPX with user-mode =
irqchip")
>=20
> Signed-off-by: rickgcn <rickgcn@gmail.com>
> ---
> hw/i386/vapic.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
> index 41e5ca26df..1acb9f91b2 100644
> --- a/hw/i386/vapic.c
> +++ b/hw/i386/vapic.c
> @@ -716,8 +716,7 @@ static void vapic_write(void *opaque, hwaddr addr, =
uint64_t data,
>         break;
>     default:
>     case 4:
> -        if ((kvm_enabled() && !kvm_irqchip_in_kernel())
> -          || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
> +        if (!kvm_irqchip_in_kernel() && !whpx_irqchip_in_kernel()) {

Hi,

I think we want to keep the kvm_enabled/whpx_enabled checks.

How does this sound?

	if (!(kvm_enabled() && kvm_irqchip_in_kernel())
	 || !(whpx_enabled() && whpx_irqchip_in_kernel())) {

Or

        if ((kvm_enabled() && !kvm_irqchip_in_kernel())
          || (whpx_enabled() && !whpx_irqchip_in_kernel())
	  || tcg_enabled()) {

Thank you,


