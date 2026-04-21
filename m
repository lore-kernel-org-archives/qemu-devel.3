Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFF9F94CA8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 19:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFGsi-0006uR-2c; Tue, 21 Apr 2026 15:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFGsg-0006u2-EA
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 15:35:34 -0400
Received: from qs-2006h-snip4-11.eps.apple.com ([57.103.85.211]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFGse-0006W2-WB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 15:35:34 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-4 (Postfix) with ESMTPS id
 C4AA1180011D; Tue, 21 Apr 2026 19:35:27 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRPEwVSB11NVg1HD1geXBQXCUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTHxPByx0WXc2FEkBLgBGBjEPOx5VdS1xXQ85BlgFUgMyfE5wXHceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776800130; x=1779392130;
 bh=hmVQvqMmygaos5w9mlBVhCZSAEfye9lLHB8QlMy62a8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=QRKDF+rHBs0JMG7cmbR2W9T8dpjhKvsv4CdYTk0uolA13u5uEVvimaKfOrHQEfnFc8gxfufUs2PBuakHaoxd33YIhWms0CxMvJsE0h6vgB6yw0ur27N5B7gQC49HJauiztCIAtHe6FyJBtOU9vGE42bdqhd6hwa4NyT4ulVe5Kv6XiqLnwS4fOJ3sznWeJWSwJL8p4ITg+9XGIlDjQyUMFMDwDhtALrEWVtYAsJrtUuN07bCEI0vPJKRwEwjycwxkIXbGlyZXeNvb646YXppMJB2Lfqh/szwuc18HBPCRPb+5eRXS35MCUjCi2UYH/9w6BG3NN62/nx7E5Zu1ksyXw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-4 (Postfix) with ESMTPSA id
 C4B3F1800126; Tue, 21 Apr 2026 19:35:25 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] hw: i386: vapic: restore IRQ polling for non-kernel
 irqchip backends
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260418061429.16898-1-rickgcn@gmail.com>
Date: Tue, 21 Apr 2026 21:35:13 +0200
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, qemu-stable@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E74AC2EF-12C7-4A6C-8BFC-6A55291BE6C1@unpredictable.fr>
References: <20260418061429.16898-1-rickgcn@gmail.com>
To: rickgcn <rickgcn@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-ORIG-GUID: vSjQLkWZfUKCkTeympmLSmEjnbkcgLbS
X-Proofpoint-GUID: vSjQLkWZfUKCkTeympmLSmEjnbkcgLbS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE5NSBTYWx0ZWRfX7AFMgHgXbn7P
 5ivSixyY/q1HPz9QzjmlFTfM7RDaauDnQzN6GUJW6UWeGYAdySQtMiExNrIIyZNl3+lxlGiUrp3
 v4JA4baelhqK7LL3JQ6ejzOX4GlW4FjTtq1H92Uk7V/dAN4r4eltf7zQ9A15+cf0VX7Zl5/DcZu
 fRQcHGiJNWIpTKF3F+WUatuTpDQnfc5pmv46HzxTcCqXlWA2kt0EuJRIRcVojUpPZxdIYKAxBqK
 B5eENUB+XZUqAOSeeH9eB/JNNxO0eILcTRhjzzjDcQ3h/7BFYU1hV6kfhpxhCVAE9eqby2fhQYa
 NTi1Ntml8/ZCbNZUWiMx7AouQLKl0P/++6WNnuvxruSmU1h4hxuuUIUbZ2rvEk=
X-Authority-Info-Out: v=2.4 cv=I8Nohdgg c=1 sm=1 tr=0 ts=69e7d180
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=W4rVtugX6geAamtpO3UA:9
 a=lqcHg5cX4UMA:10 a=CjuIK1q_8ugA:10
Received-SPF: pass client-ip=57.103.85.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr =
<mailto:mohamed@unpredictable.fr>>

Also a good candidate for backporting for QEMU 11.0(.1)

cc qemu-stable
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
>             apic_poll_irq(cpu->apic_state);
>         }
>         break;
> --=20
> 2.53.0
>=20
>=20


