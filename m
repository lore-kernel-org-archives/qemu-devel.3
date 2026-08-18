Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58EDC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwOBY-0000JK-Hf; Tue, 18 Aug 2026 14:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwOBW-0000IU-L4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:05:14 -0400
Received: from pv-2001j-snip6-11.eps.apple.com ([2a01:b747:3003:200::65]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwOBU-00066X-JO
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:05:14 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPS id
 895E41800DDC; Tue, 18 Aug 2026 18:05:05 +0000 (UTC)
X-ICL-RepId: 01a0160c-61ae-741e-b16b-7c25a68a1c53
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBIHVoORQNGCVYLWhcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeSQ4dBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjR4PXEodVpxXX06BysaXwBCC1ULXwJeH0F8OwJbBSpzQHxPAi1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1787076308; x=1789668308;
 bh=qOG91BjG6K6D5Ej2fzP8pY0XUDv2OtJelh3S9vbZhtA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=VxGRacoyBs2EwcwY3pDiMHJoFd3jQ5tyOiwhEoJp2njZQvJ8nfYJM6DCGKW2Zjr3u8aFAf3rQ3kazxQcetWEGOYNH5/1gKJb7JuCwfpi0eV4OX0kRHFnp03tmR483FzXoodOL7rMOEady3J3FWdgEC12twEFHduhKUazRZ/44ZcudyRG28BZU5BjScf4mWfjjbhTa8Cwqo38W8ciZxtH3G5aBQAz8J7j4ixd9hWX9U+zOCyDzMItxD2pB5Jwur2sn04mnrDQRMiA1f2HEwsdDpWkj32mom2T2fseQKspkRgYEqfvHz7MCtM+8qbvcJ0Q8091ldtsyWy3ziwvzeIUrQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.192.29])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPSA id
 1D07D180036C; Tue, 18 Aug 2026 18:05:03 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH] target/i386/whpx: handle processor reset
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <LVXPR21MB70093ED095A01CADE104F3A8ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
Date: Tue, 18 Aug 2026 20:04:51 +0200
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DAEBEB1C-DB4F-4222-8255-1EC162AA0E71@unpredictable.fr>
References: <LVXPR21MB70093ED095A01CADE104F3A8ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEzMyBTYWx0ZWRfXzIkM0b58DhrC
 r4cRMtzpCJ6zh1H+rcdE5WSf8QNyTb2Jz6xIZXLI/YKUhRc1yMFYyJxjdEhsr1ILZNjI0vKrutZ
 W4qUCBiTWzOksIXQWo06XePykzNxzK6DOoFLf/lKE3tk1XxgQ/IZ/N0hoWzLjlPtmh/FHRSACyD
 KPQRP5CgA0HobEA1osPXh+yTZABj4FDJDf/TmJI9G9crYQ9MzpfOUvT9JQZWfgBkZ7F9ByHsgBP
 o6pKqPnoh5w4MqTn/DxNV26EgyOTvu1Ms/J3vqws//I5l8aImwmWKK1A5GPfpm9ztSNQTYfcdsg
 MRRhP/bvUcRpIu32VamMdSk3QUR5+Wgen2gbZtHk1cP4SwmD250cjMC3CkJ3xM=
X-Proofpoint-ORIG-GUID: 6V3mjlQpa6tRfJ6bVDTsKGQdph_TiybT
X-Proofpoint-GUID: 6V3mjlQpa6tRfJ6bVDTsKGQdph_TiybT
X-Authority-Info-Out: v=2.4 cv=f+dFxeyM c=1 sm=1 tr=0 ts=6a849ed1
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=GaQpPoNlAAAA:8 a=yMhMjlubAAAA:8
 a=22ya_mvd5B8fbHfUbRgA:9 a=QEXdDO2ut3YA:10 a=xF5q_uoM5gZT5J3czcBi:22
X-JNJ: AAAAAAABObGEFCaCtUj840GCsdPKTDxa4AH1eneVjFdGQ3o2zqh8glIZNAhvWOKh5GwUV1awpkraR2cVIMC57DP1DAKLoNiwq1k2DND3MGAnCdNBtRlSCwrlqrqr2J6X74x9pHB4j1YNEcImDp8ehE14J5qyimhQFACt8KozNm3w01dXkh3QgoxDa5s/I28pT8AmnZKenqLlmKc71X695tP+Z+hl1WZ01gUTzBgBHJZmk+c7FwersD/txbC/5nNqlRLM2u83K0LOFNHTj/wu7tMB4brewyTuqPOVCI76BlSh/3dOAx31BqxPDXibkNjGt2hF0iOUp+wJ2b2NFxBsz5dhwoxC/9kv5v2C0lWERBPEBqF5A6z4thHroL2BwOePSjb566VIGv+FctCqOLv7tG7JNIWn64Nr6+Jc6fnBmW2yMZl718XAFYcfZJRGYfwO8pQglrnWnBNq8BzdDVe0HM10NumUtiHp44GrVXTIa8eqJIYNLRFEOHt2P9iZVDe9o5GlUABGGFHeaNIKtSTliGVvVXG8ivr7nFi1lOr2p6VRHDPAZsOTZDPgzbsg52D50SPfSHxAJhbPAOc2KMZQFVncbAt2WoQSrWobX3o3DSC+oSuLwm1FGfnYj01432DTSdRdhCY2m0NJMk4IagN9UxCSDqdRapLQ9NxbrqFmNhSzZi3ztUnWdhQNiXAwoo1ieccWjVTnUGzCx94cCmuUJGQSwwjI332jLbA2ZrbdOcCH2S/QM1iyZluFEu+elQfQ6IgafL426Yyf/Hh1wn9qQdnaFJoRqawX6BgQIDW5yO3BYdINfKfa0r52O9dvMoftjs+9Ysu3GmZdTpXg0tdWZAkEbx3ABao5rJrKH663mNVttvoluUIPO1iaJn+SXaa1lbPOR/vCgxuZWWLwKDaCeSO8ih0fYU4yFNYEHzJCm3i5dNov3spAYI264BUuEFYypcWRwQrVoqVj6eOqS5Pwfr7PuQV4rW8
 O7g22Ud7LuC53ZCua4VCTA10tlEIT/GyKjvF1x6TFFinQ81bewFP7K+ElT0JCYiW5DAIwoRkfuP+COERTkjeTGjOig8E+7Q2y68wTFePPLz4O523qpqRQRzdIjfhduBMEDkqXcYXxMr4kOTOWKoifmGR809siGGvsmpcAQGjEv+EKeGcHh0thgcxEwrQWBX/ORTdgqcBMxorOaUQMNR9k9AixuGWvydjtqViIBGyBt3wM53Y26RiHXLCblTZj9duT4MTASXzO4ZZ+8y9Nf2wDSwra1oOB8v1Is7u7PGlydrbI9eTj/2+njBIwXz+z0erlcUvwjjbqK3SHz7d+bjwOfSwLPB6RcKqwNrlsmYjYwzs5jQpxOJJcSK8Bx7p3K7QkegP2dYCV7Aue08Qprrrp1AsY7g==
Received-SPF: pass client-ip=2a01:b747:3003:200::65;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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



> On 18. Aug 2026, at 19:58, Doug Cook (WINDOWS) <dcook@microsoft.com> =
wrote:
>=20
> WHPX is not properly handling processor reset:
>=20
> - Does not reset partition, so several registers (e.g. Hypercall,
>  GuestOsId) carry values forward as "Locked" into the next session.
> - Does not clear hypervisor-managed TSC deadline (live-lock).
> - Does not re-arm the wait-for-SIPI trigger, so all CPUs start running
>  immediately after reset.
>=20
> Some firmware may tolerate this, but OVMF does not. Typical result is
> that boot hangs or ends in triple-fault, e.g.
>=20
>  qemu-system-x86_64: WHPX: Unexpected VP exit code 4
>=20
> After this patch, I am able to boot to Windows desktop, reset, and =
boot
> back to Windows desktop. Tried many times in sequence with no =
problems.
> Used several different reset mechanisms (OS shutdown menu, external
> "reset", watchdog reset) with no problems.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2402
> Signed-off-by: Doug Cook <dcook@microsoft.com>

Hi,

Previous version of this concept at: =
https://patchew.org/QEMU/20260421205749.55060-1-mohamed@unpredictable.fr/ =
(with it intertwined in a common path for Arm support)

Using WHvResetPartition as a workaround for some state not being fully =
synchronised isn=E2=80=99t
ideal though...

> ---
> target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++++
> 1 file changed, 29 insertions(+)
>=20
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 634d542821..54f9b50536 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -528,6 +528,35 @@ void whpx_set_registers(CPUState *cpu, =
WHPXStateLevel level)
>=20
>     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
>=20
> +    /* Assumes that cpu_synchronize_all_post_reset() runs cpu 0 =
first. */
> +    if (level =3D=3D WHPX_LEVEL_RESET_STATE && cpu->cpu_index =3D=3D =
0) {
> +        hr =3D whp_dispatch.WHvResetPartition(whpx->partition);
> +        if (FAILED(hr)) {
> +            error_report("WHPX: Failed to reset partition, hr=3D%08lx",=
 hr);
> +        }
> +    }
> +
> +    /* Reset hypervisor-owned TSC deadline. */
> +    if (level =3D=3D WHPX_LEVEL_RESET_STATE) {
> +        WHV_REGISTER_VALUE tsc_deadline =3D {};
> +
> +        whpx_set_reg(cpu, WHvX64RegisterTscDeadline, tsc_deadline);
> +    }
> +
> +    /*
> +     * Re-arm partition's wait-for-SIPI state.
> +     * whpx_vcpu_run() ignores cpu->halted, depends on SIPI for this.
> +     * This must follow WHvResetPartition.
> +     */
> +    if (level =3D=3D WHPX_LEVEL_RESET_STATE && =
whpx_irqchip_in_kernel()) {
> +        WHV_REGISTER_VALUE activity =3D {};
> +
> +        whpx_get_reg(cpu, WHvRegisterInternalActivityState, =
&activity);
> +        activity.InternalActivity.StartupSuspend =3D =
!cpu_is_bsp(x86_cpu);
> +        activity.InternalActivity.HaltSuspend =3D 0;
> +        whpx_set_reg(cpu, WHvRegisterInternalActivityState, =
activity);
> +    }
> +
>     /*
>      * Following MSRs have side effects on the guest or are too heavy =
for
>      * runtime. Limit them to full state update.
> --=20
> 2.55.0.vfs.0.3
>=20


