Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7593CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 14:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKzk3-0003xv-Ai; Thu, 07 May 2026 10:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wKzjt-0003wa-UH
 for qemu-devel@nongnu.org; Thu, 07 May 2026 10:30:10 -0400
Received: from pv-2001h-snip4-5.eps.apple.com ([57.103.64.38]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wKzjr-0007Mo-Hf
 for qemu-devel@nongnu.org; Thu, 07 May 2026 10:30:09 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-10 (Postfix) with ESMTPS id
 EBF131800175; Thu, 07 May 2026 14:30:00 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwROEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTHg8C1gFUgRAFEh2VARGBjQKQB4sD1gAXQ9OAVQDKQVJD0wFL3ceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1778164204; x=1780756204;
 bh=uJjeXrVqITKsix0UIG7tjHa2I2LF3i20YmjLM4w7oHg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=fY6WO3f3CR+6LO9CsM2S72d9n62mBvOZft8SjcdJtfacaJ85vlOJQijD3Fau6b+er0w1PZIidA8UlCS2oFDzurBo1JAlnmhhPu/jE2ML472tr8s6oiK2CqGXNRBVD1inQQfjb9ke+5OCZASWQMg+cw5BijohmwyCzhmILSLVdv5dOcuoIZwUAkGgVUbk+XttNGk5ILV1frepihKfRJyZCtnPTSN+kZNnb7ngiEECouxf9db6z7cmnOuuvie5SswFUXrJ6p3bXYzW0Vwruf1bnfp/OSBArSCDBuKfZH8sjX/IkmO8A0i9kGbwZeOvrRsNd+JKNEEJPExOzzofgwfNyQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-10 (Postfix) with ESMTPSA id
 DE7EB1800135; Thu, 07 May 2026 14:29:58 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] hw/arm: Build ARM/HVF GICv3 stub once
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260507135816.71171-1-philmd@linaro.org>
Date: Thu, 7 May 2026 16:29:46 +0200
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD852960-0E93-4D38-A832-66294B79646B@unpredictable.fr>
References: <20260507135816.71171-1-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=Sr6dKfO0 c=1 sm=1 tr=0 ts=69fca1e9
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=4Kp0-FD2ekAT1qDPWe0A:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE0NSBTYWx0ZWRfX5OLErR/aoGnv
 OoIFIBASlw+b6PXq5CSOOVd7x7ZXWucilpT6VB28YbJQkfUi4zir/8mbMMOvjfVj8RttYN6L8bB
 rDhGd946SNG1kGl25+GBGuOvmKFq0AxO+VJBMgrCQr4crKO5KGpAA8Xam/03rAhRKKNTKwruRs8
 CfF4MEhB7n4mfYo5vqbLt/o10F33WpoxmYxJ3GiEt9EEaGqLudRDwdL5TZ5dQ+/2O7EsYtFXfRm
 DkyMHfeY+IzmX6NrflaRqBJ8+mh48K/PxCKjwtAS1kgoZavt1ddZHl7M0q49j2biAU6y3BlrE7f
 ATktBE/moo7qrqAEEJSRD6n0cm5yWE7/xpeLhcU40WjQ+t0YF0DEjV09PPRd+k=
X-Proofpoint-GUID: eBM-GHAD06V9Q6ya8D7BAiOEKGzSPhy7
X-Proofpoint-ORIG-GUID: eBM-GHAD06V9Q6ya8D7BAiOEKGzSPhy7
Received-SPF: pass client-ip=57.103.64.38;
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


> On 7. May 2026, at 15:58, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Move arm_gicv3_hvf_stub.c, introduced in commit 48396ad6ce9
> ("hw/intc: arm_gicv3_hvf: save/restore Apple GIC state"), to
> the global stub_ss[] source set which holds stub files being
> built once for all binaries, instead of one time per system
> binary. This prevents symbol clash when trying to build a
> single QEMU system binary:
>=20
>  clang: error: linker command failed with exit code 1 (use -v to see =
invocation)
>  duplicate symbol '_vmstate_gicv3_hvf' in:
>      libqemu-aarch64-softmmu.a.p/hw_intc_arm_gicv3_hvf_stub.c.o
>      libqemu-arm-softmmu.a.p/hw_intc_arm_gicv3_hvf_stub.c.o
>  ld: 1 duplicate symbols
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> =E2=80=94--

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> hw/intc/meson.build | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index c6de2d9d00c..25a4144c83e 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -43,7 +43,7 @@ arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: =
files('arm_gicv3_cpuif.c'))
> specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: =
files('arm_gic_kvm.c'))
> specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: =
files('arm_gicv3_whpx.c'))
> specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: =
files('arm_gicv3_hvf.c'))
> -specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_false: =
files('arm_gicv3_hvf_stub.c'))
> +stub_ss.add(files('arm_gicv3_hvf_stub.c'))
> specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], =
if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
> arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: =
files('armv7m_nvic.c'))
> specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
> --=20
> 2.53.0
>=20
>=20


