Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C73CA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 21:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBIzA-0001Gp-JF; Mon, 28 Sep 2026 17:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xBIz8-0001G5-Qq
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 17:34:06 -0400
Received: from ci-2004h-snip6-7.eps.apple.com ([2a01:b747:3005:204::50]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xBIz6-0008Bs-Mc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 17:34:06 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-6 (Postfix) with ESMTPS id
 711771800096; Mon, 28 Sep 2026 21:33:57 +0000 (UTC)
X-ICL-RepId: 01a0e9f0-563b-7eac-8ba2-3f273fc623b1
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkgPOgZZc1l2XXtKACgaX3BID1VyKHJaH0l4TgdcD1oBMghLcC1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1790631239; x=1793223239;
 bh=T5fwcpgDIRvj8ViOiE3NTKX7mGSaZUi4chHHLmuHEHA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=qRS/MN6NAMPLXyiJR5oltymiXzKVqeeyBDWfkl0xYN9z5cnMj3TF+eIi8fbj/2uymtmX62HAyDd/CGVWpcRUJ2rk0x3Z4CzIthcLC8VoW56L7y6b98yIJ+T0//L42hW9M8PELblKYar0aP5iLxWrMUTErk1IPzlOTnfggfbGT5QgK6d7e+5Z8bfFupEa7QPnkkbGKfv7Ooqeedma3LbfTwLdhHJicxkvz3Wc0DPFgruJ6inXFvvnLOgLpN/jFHTMGQvpKrjGwbX7OIYwuyVrgHSa5j/16cDASTlXXCAZvYxEIo9cjWZhTNoVSBYmHR1zHC4DDLabHcoG9lDjjaxCCg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-6 (Postfix) with ESMTPSA id
 2623B18007D5; Mon, 28 Sep 2026 21:33:56 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH] target/i386/whpx: fix VMX capability MSR values
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <LVXPR21MB7009E7B7DB875353A715A0A6AD8D2@LVXPR21MB7009.namprd21.prod.outlook.com>
Date: Mon, 28 Sep 2026 23:33:44 +0200
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86B54D2D-B23E-4B86-AEE1-9A641813B13C@unpredictable.fr>
References: <LVXPR21MB7009E7B7DB875353A715A0A6AD8D2@LVXPR21MB7009.namprd21.prod.outlook.com>
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Authority-Info-Out: v=2.4 cv=SfP6t/Ru c=1 sm=1 tr=0 ts=6abadd45
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=25T-GLOQtfwSc-gPQK0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: I_lAoJaRy7PqoCKAoI_6akD6GdJxCQGd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4NSBTYWx0ZWRfXyaD1LXCEO+ap
 vxWPuoA6pWPceiNgbSHYWwuk7u3puLNpdaSuBgSWSYgkdVfrjYk7JYc6P2RIZooAtZg+RiUb2NP
 jYqRp5UyBN33JhgRqEfcmDzLcg0t/5gSVu7aai4RnPL9pv4M1AVWkYxWq71jDQqFNi7UhyyX1As
 Zf7kWEJwV+yIeqfT3CboKPiNFI8XG0gk0LJ7WNS2CcNN5OxYloOVlQJD+4VMIqigPcX17IGk8PM
 8FyltuO9Bgn4YTS+kgjJoN23YdfkaIouWe3aC6H9hwL+PuyZq27CoBbCIlaATUhfK/KkK6Fn+ay
 qqT0VfJEv76+vgeUwG7LIeEyEyTBS5jUdGrRxax1k4uopI3SPM/zjJHnFwlHos=
X-Proofpoint-GUID: I_lAoJaRy7PqoCKAoI_6akD6GdJxCQGd
X-JNJ: AAAAAAABH6dOKPDjtczRGs9ar7Px+pj2a/QFx1Z9Tl0Ded8Gv+Diup99V6UenLlTA1vXVbzbLpGYlr4T7Py/AJ7X2cPhfELIv8HlSNIe9wBHY33zejoVRFtVFqkkmKRa7hW/LTaip46/tipkQckziY4MQ72VopYjVL53b7g1mNlrZC24Tc4QoFllDrQu4O52lCAzV6qHThCvKrNLSwu14DIBVj+puYmQa+NJKfBry+ylrCYYl5EPFYcWbFhT8K2VTX9mlmzapKwNf622w9XXxmZ9QcoCSpuCC/VDESI2DLr1rIb04BllplQ31Vm6fE6Wor5JrVXlBKgJlbGA3WwXT7y4DXb0QLXpbeRYxs6M40qDlvhtuRcuNIVoe81F7P4M3JwP7RKVpB4wwi+0WD3ifHMc1wIOjQmWQvwP4nsvXt0MfVAuWBnYw6hxU0SWlIybJ0Ns5MxCIr5WGJhLEWTDr3dXq8YDVVzOKw6HXqef/ZXUAq647t6qm9sPnPOFz9YOjZVDglHIJYn0NuPmTkEOKq9qlaESbfpeuJ65hZY7d80V8q4eyyyIiYXr/tKVmz4GdTbFOkTKXfVuWJ8g07mHMhLkm0pXJAqpthasBauGc3zu83zOx6N6JnxmCaIh9Ao/j22+rykRgs7c8KkSfcxajycoH+BILCXSdCw+yv8D53p4WinVhwHSY95MZY9nPRAFKkt8/YW/rcqk7nSQyONrGcqfGJfUarx+WsdvvfFwE5dFqGSMVQnfeuqxWvNjlYXLkJmgg3jSlIDIesl9XwcvWl3/XOi/Z5DBPmYiaioubXg4sw3T6PC7JMlL57uhS+wyAhL9SLeBgr89tzM8yNdlUwDOliYrAuOa1SGNkrmCpLsF22/GYZFV8ogyVIQmuSjwwlIdKeIzGkrn1WHClJ0UN2dlx3X7gecWXHp6RYcTse8zLOtzATt19S4tCR136s5PNnGbEsBHuCz7+xD/IRh4TkowoUXLXvW
 bAikHcFaJ1U1eYOIAAkaHmt4EKpouvvXe3QJf58r0A1hlo+RVT7Jnwp86oOuZkr/AhYoqXP/SDi7cFzzRbBwCSHCGzL5pfQYShN/LtDgKvIF4YS49Lw5O1Mcf+3JUJWsN6hnnYscyDXKExlwUOjs3kS1nF1yBTRe6NshcaOt6xUcgQ//vAgAMJdvke71xiF/0ydFCb+ocQvEC1xmODe/G+qroSRIJASK1M7n85MQVULSoWg9bSqnZF3N9QJrGo6PsUsRK1FzpylqrFQI+YmdfbjEZnwmbrkFyd/VAJpFck+lSTiDqPeixbubPuuvc0dGusY8lSR5Hb+ZJRmlBIV8cLgSMus7Cz9rRnBXtxzDVUc/uk9hauzQUNEswIA==
Received-SPF: pass client-ip=2a01:b747:3005:204::50;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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



> On 28. Sep 2026, at 22:00, Doug Cook (WINDOWS) <dcook@microsoft.com> =
wrote:
>=20
> From: Doug Cook <dcook@microsoft.com>
>=20
> whpx_get_supported_msr_feature() had two bugs in how it reports the
> VMX control MSRs:
>=20
> - MSR_IA32_VMX_TRUE_PINBASED_CTLS and MSR_IA32_VMX_TRUE_PROCBASED_CTLS
>  were queried using the non-TRUE capability codes
>  (WHvCapabilityCodeVmxPinbasedCtls and =
WHvCapabilityCodeVmxProcbasedCtls).
>=20
> - For PROCBASED_CTLS2 and the four TRUE_* control MSRs, the raw
>  allowed-0/allowed-1 pair was returned. The feature-word code expects
>  only the bits that may be 1 but are not required to be 1. Apply the
>  same transformation as kvm_arch_get_supported_msr_feature();
>  make_vmx_msr_value() adds the must-be-one bits back afterwards.
>=20
> As a result, with +vmx QEMU treated many VMX features the host does
> support (secondary controls, EPT, VPID, MSR bitmaps, ...) as missing,
> warned about each of them, and dropped them from the CPU model. The
> guest itself reads the VMX MSRs from the hypervisor, not from QEMU,
> so this did not change what the guest saw.
>=20
> Signed-off-by: Doug Cook <dcook@microsoft.com>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/i386/whpx/whpx-all.c | 29 +++++++++++++++++++++++++++--
> 1 file changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index bc6c1e00a2..8fd6b3ce2b 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -1516,10 +1516,10 @@ uint64_t =
whpx_get_supported_msr_feature(uint32_t index)
>         cap =3D WHvCapabilityCodeVmxEptVpidCap;
>         break;
>     case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
> -        cap =3D WHvCapabilityCodeVmxPinbasedCtls;
> +        cap =3D WHvCapabilityCodeVmxTruePinbasedCtls;
>         break;
>     case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
> -        cap =3D WHvCapabilityCodeVmxProcbasedCtls;
> +        cap =3D WHvCapabilityCodeVmxTrueProcbasedCtls;
>         break;
>     case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
>         cap =3D WHvCapabilityCodeVmxTrueEntryCtls;
> @@ -1538,6 +1538,31 @@ uint64_t =
whpx_get_supported_msr_feature(uint32_t index)
>         if (FAILED(hr)) {
>             return 0;
>         }
> +
> +        switch (index) {
> +        case MSR_IA32_VMX_PROCBASED_CTLS2:
> +        case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
> +        case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
> +        case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
> +        case MSR_IA32_VMX_TRUE_EXIT_CTLS: {
> +            /*
> +             * These MSRs hold the allowed-0 settings in the low half =
and the
> +             * allowed-1 settings in the high half.  QEMU's feature =
words want
> +             * only the bits that can be one but do not have to be =
one, so
> +             * apply the same transformation as
> +             * kvm_arch_get_supported_msr_feature(); =
make_vmx_msr_value()
> +             * restores the must-be-one bits later.
> +             */
> +            uint32_t must_be_one =3D (uint32_t)val;
> +            uint32_t can_be_one =3D (uint32_t)(val >> 32);
> +
> +            val =3D can_be_one & ~must_be_one;
> +            break;
> +        }
> +        default:
> +            break;
> +        }
> +
>         return val;
>     }
>     return 0;
> --=20
> 2.55.0.vfs.0.8
>=20


