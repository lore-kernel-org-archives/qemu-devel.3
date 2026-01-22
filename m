Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A939D3EE86
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 15:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viwrQ-00012L-0p; Thu, 22 Jan 2026 10:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viwrO-00010q-21
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:44:38 -0500
Received: from p-west1-cluster6-host4-snip4-4.eps.apple.com ([57.103.67.57]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1viwrL-0004B9-WA
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 10:44:37 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-4 (Postfix) with ESMTPS id
 C1D46180050C; Thu, 22 Jan 2026 15:44:29 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769096672; x=1771688672;
 bh=hKvvqd46hba0/mqnaxz/ijvE405oIW2CS4k+iwInPC4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=RDVxG4aG7aVRU+V+VZUGVDYeUML/dLQX7N9AgZQMZOY5o7HZhLG+4EBHTCwrB5cyRPP/K+NkAkXZOQXePITyFtUfER0SRfbXjdFuIjXfWRVwo967trIDwo9V6I649SvdzvCI0lEMjzUCTGOMxEIMrxJSBqeUxh/SDvzeuJ+NUf1Jwb8RiQ37sRcLiwAfu8BDU7XlooIeuiUsBoHkwBoEozmxLTGgCF7eV8uwWxJpOi7P0luiwsDKqc/EtoPzrt/JpjNppesjkFKMRTITBlJ2xoEad6z7YUsLwYOof5mZDdJQgKsdYJfmk7uCr6j2CBB/8wGNKH5IGaQx24HTHDdlmA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-4 (Postfix) with ESMTPSA id
 EC72118007D5; Thu, 22 Jan 2026 15:44:27 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [RFC PATCH 2/4] hw/arm/virt: Don't use vms->tcg_its in
 create_gic()
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260120180339.1416328-3-peter.maydell@linaro.org>
Date: Thu, 22 Jan 2026 16:44:15 +0100
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D52D655C-4204-4DD3-814F-1330B675AA00@unpredictable.fr>
References: <20260120180339.1416328-1-peter.maydell@linaro.org>
 <20260120180339.1416328-3-peter.maydell@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Authority-Info-Out: v=2.4 cv=fbKgCkQF c=1 sm=1 tr=0 ts=697245de
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=WmESvH20LQ8JE5vgt2wA:9
 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nQ7VCVd1fFMbTbS1ylv6pfJhgq9Cs0Zi
X-Proofpoint-GUID: nQ7VCVd1fFMbTbS1ylv6pfJhgq9Cs0Zi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMCBTYWx0ZWRfX6Ws8A/K64xwt
 nkqV7zIyrzUzi9lmhLxUaUVyRX3YVWWaiLINsaenCsZhc8logWDLbPQ6LaXGYzy7LCqzRm3PFRw
 8R9pdHXA5YwmjB8q74obOtXkf0rNAag5wRtlNpFv6ZD+uGIROXL0lt5d9z7P+8LaaYLRFcj2YHB
 doQ8CtLDumy0v38KKGOXC5/YEykB8yUCm/F3NrshiZL5dkwZDowDb+noPubmoKCEW9hFAvW7vHh
 s2H0irLA85Kg+OHl8df1a/vtH6ghajkkmHTDW7nWeXzhMEPbvmaNSWwCPu/Ice7SXWz+ge3aoDN
 V1oT2gsvGeQzpp0r3Ev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1030 suspectscore=0 spamscore=0 mlxscore=0
 mlxlogscore=986 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601220120
X-JNJ: AAAAAAABbTpIWZxqV/mzxHemZqYl5W1R0xVWkR8UB4AHWhBvMe0uI43JMiOu9RROIkUlpQrbFLGZ0WI5YWVPMB1jLhUFbVeQlHQsjy8aXwWrJXB1mVP7nJQ5XZmU/zcqNXNX/AcHVIfNdmjq7xut0NwoW2M/qWhZfSSHXUM+1zCgV+AfK36yN+C7PsTKV5VsYyy/scEMW0Q0MgcS4zoDqCrAZy2mFNAlEVx6Ef8HD9calDcKDZS2AyxLbAKISA2mrLJq/smAo1SVCwncvz+ODoV4RmBeQHcKS8W9r6RglcNdvalOljxqh3RBvVFyhlljs9DS/to+JUPYVY8S/OVSW8qnTDVxQGQ4VFL0AAZGkH8YiTFo9Gu+O8w/ae78IY+ncmXJZ+R0GmoqIHtEiqg6TIvEJGTfaWDyW/Se/wfomqbRwFYyxsTiesvPNskGqKAbFV61jbDUPn7K1y97up0sLKgWHoqeJmzXP0OJvcGVLigitWoqSq/BtQrIpaYwiPH8Xw76PVyhpmiMHmSQlptMHxw55h3f4om7jk8WuQi88eqLgUFAkxUDT4dJplg45crTTvDk4qfxT94lZWlZn9ivTfVNxezCNyRNeC1Z2ZpK/5Igwzh/qNAHWTdW3pc3pmObIotzFm1/AykmOA==
Received-SPF: pass client-ip=57.103.67.57;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 20. Jan 2026, at 19:03, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> The create_gic() function needs to know whether the GIC
> has a TCG ITS attached, as it should set the "sysmem" and
> "has-lpi" properties of the GICv3 only in that case.
> Currently it does this with
> (!kvm_irqchip_in_kernel() && vms->tcg_its)
> which implicitly relies on knowing that the only case
> where we aren't using a KVM GIC and we don't have an ITS
> is where we suppressed the TCG ITS because of the
> board-version-compatibility no_tcg_its setting.
>=20
> We can avoid direct use of vms->tcg_its now that we
> can identify what MSI controller we are using from the
> vms->msi_controller field.
>=20
> This means that the only use of vms->tcg_its is in
> the logic in finalize_msi_controller().
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> hw/arm/virt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b55297455f..a231aef268 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -851,7 +851,7 @@ static void create_gic(VirtMachineState *vms, =
MemoryRegion *mem)
>                             redist_region_count);
>=20
>         if (!kvm_irqchip_in_kernel()) {
> -            if (vms->tcg_its) {
> +            if (vms->msi_controller =3D=3D VIRT_MSI_CTRL_ITS) {
>                 object_property_set_link(OBJECT(vms->gic), "sysmem",
>                                          OBJECT(mem), &error_fatal);
>                 qdev_prop_set_bit(vms->gic, "has-lpi", true);
> --=20
> 2.47.3
>=20
>=20
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>



