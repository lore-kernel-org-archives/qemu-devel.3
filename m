Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268BCCD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 14:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYPoB-0003Vx-GR; Sat, 13 Jun 2026 10:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wYPo6-0003Vb-Oy
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 10:57:59 -0400
Received: from p-east2-cluster1-host3-snip4-10.eps.apple.com ([57.103.76.13]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wYPo5-0002Am-6k
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 10:57:58 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-3 (Postfix) with ESMTPS id
 2806B1800108; Sat, 13 Jun 2026 14:57:52 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0NWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkANO3JUdFhwXQs8clkaX3AzC1UKXANbH0h4SQdacigLQA5AAi1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1781362675; x=1783954675;
 bh=K+ZBThJvybLX8P/PfEay1+FldsDrGmYy3kxt33K9h3c=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=RS5Di/Ebl91J1uokdLLnfZn5jqbLta//CTIlojDaMptQ5Yr1IrwOCzc2oN+z3DPCJi5SMjsDGCFSmfdB2SY0kk/QhBGPOU0AM6R+oB2VcSHaoq1PtiIAeKB3PTmjRUMMfSvhDBY8h3Gz5pdfgjxUdMNuXcQMpvquYm09BoGwkOfUBkMMqteEGD1CNm9A1eAunOXKv/IjfSSAUChcRkrKadX0IZBSU64JlybDvl1eE6zA5iRfplR39iIA39Usg5Xbu9NT9sIbXfa2cPd8FAgaJp4ILoWQ/65bQwBYNmMAGYOwBqAcwplqFKo+1CqmfF6feC0LN6GNFzXQcDbgCi+awQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-3 (Postfix) with ESMTPSA id
 8B6061800121; Sat, 13 Jun 2026 14:57:51 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3891.100.17.1.3\))
Subject: Re: [PATCH] accel/hvf: Reduce hvf_kernel_irqchip_override scope
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260613145356.88410-1-philmd@oss.qualcomm.com>
Date: Sat, 13 Jun 2026 16:57:39 +0200
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <04CA9C3B-2DA4-4BC2-9140-8A147EC90781@unpredictable.fr>
References: <20260613145356.88410-1-philmd@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3891.100.17.1.3)
X-Proofpoint-GUID: uWhZHL41myEXcCdjCoyhnPOaWOpx8PF7
X-Proofpoint-ORIG-GUID: uWhZHL41myEXcCdjCoyhnPOaWOpx8PF7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDE1NCBTYWx0ZWRfX3Y9CJqMIaEGP
 a50M8PX9PlntNI12nF1PmbamsfHXitgaD0VqiTMwdp/Ibg9DM1F0tTmRMRQN2p0mS+5uTKVr3Bn
 owOLrdukMuJFkfr9v3R13njCdRqjylIxN2XkJjQfq7SSUQK2JiTDVHjWUXZri4IS8rDsm34ucOL
 V9Z0sRViEv584deY2gLHrRxkyNhzggqIRWcJhngYMjmhJ0KcM2jg/kEpK6UY/TgVkItSkUHnnSz
 6zLY4xggLPPJhGFx8TxC+bgCyiQOYd53W3MnPLY9plKYn+lMHhMkr6VF8+806PSW7trOc6D1xx8
 vAjTzJGkyd2UWsIw56L
Received-SPF: pass client-ip=57.103.76.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 13. Jun 2026, at 16:53, Philippe Mathieu-Daud=C3=A9 =
<philmd@oss.qualcomm.com> wrote:
>=20
> hvf_kernel_irqchip_override is only used within the
> accel/hvf/hvf-all.c file, no need to expose the symbol.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> include/system/hvf_int.h | 1 -
> accel/hvf/hvf-all.c      | 2 +-
> 2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index d5eaf26dda8..58fb865ebae 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -113,5 +113,4 @@ bool hvf_arch_cpu_realize(CPUState *cpu, Error =
**errp);
> uint32_t hvf_arch_get_default_ipa_bit_size(void);
> uint32_t hvf_arch_get_max_ipa_bit_size(void);
>=20
> -extern bool hvf_kernel_irqchip_override;
> #endif
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 946dbca59d0..21b9b71a6df 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -25,7 +25,7 @@
> bool hvf_allowed;
> bool hvf_kernel_irqchip;
> bool hvf_nested_virt;
> -bool hvf_kernel_irqchip_override;
> +static bool hvf_kernel_irqchip_override;
>=20
> void hvf_nested_virt_enable(bool nested_virt)
> {
> --=20
> 2.53.0
>=20
>=20


