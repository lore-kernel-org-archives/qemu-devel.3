Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA87C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQnU-0007WU-4n; Tue, 18 Aug 2026 16:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwQnR-0007WD-Gq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:52:33 -0400
Received: from mr-2004b-snip6-11.eps.apple.com ([2a01:b747:3000:203::15]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwQnM-0000No-Vo
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 16:52:33 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-1 (Postfix) with ESMTPS id
 012AD1800ADC; Tue, 18 Aug 2026 20:52:23 +0000 (UTC)
X-ICL-RepId: 01a016a5-8dc2-7edd-b590-f3bf697e2dcd
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBIHVoORQNGCVYLWhcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeVAodBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDjEMPQRUc1t2XXpJBFoaX3BHfFUKLgIpHzN7SAJYcloDMQg7AC1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1787086345; x=1789678345;
 bh=+xoyfmvZYh3Wjq/5XFwsT2GHM/F0rTXWkXcPgnF5tA4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=YQdzmsCUZBBBslmXCGDjvsdhOYG31Sa2LODWK7RDAUUV2S0WiZW6s0EYvFQVBz+dbw4PdO6ff2rTd5lWM35gTIECE/Pz6ivx9/yl6xfgNx9X0D2cdioLrsIhvwjVu731lHBnPiocV/5F2WSMCd40Wk0NXVeSKROoaFrEppi9qedmScwX90Xp76KvKrA/P5oyPmnJRSwlkV+/lrPrsowNaSlyIMuS9c42q+FYLM/nlDHqkTscaUzZ8UNUQONke+o/s+41WJghy4nMkh0jbx9O2hdp/oUHnCgv4ZUMumjxIONhd6Y4DfFrCvQpdKSCAwhJ4VgSTniu0h1LNKHZFVRQUA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-1 (Postfix) with ESMTPSA id
 1D7401800100; Tue, 18 Aug 2026 20:51:15 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH] target/arm/whpx: fix whpx-arm reset hang
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <LVXPR21MB7009095A64089AACFA91DB10ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
Date: Tue, 18 Aug 2026 22:50:23 +0200
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5E79D0D-C177-4B7E-9C5B-CB015E11A1C3@unpredictable.fr>
References: <LVXPR21MB7009095A64089AACFA91DB10ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Authority-Info-Out: v=2.4 cv=Le4xKzfi c=1 sm=1 tr=0 ts=6a84c608
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=wr1TRPdcCIM70eNNwfcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DjrHsi6h7ertRZxfbvQI2taF89oR0ES0
X-Proofpoint-GUID: DjrHsi6h7ertRZxfbvQI2taF89oR0ES0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MyBTYWx0ZWRfXwf99jnnYVO3l
 ev3rr/jv6hGK2Zm4i/M2EV+dBqwW6xWUvMw5ZboF3CgZFPhB3hbA40Y3Jz5Qo08UJzR03sd9zpX
 wy6C/xsXqHIaF12A7MxkVmJdp71hJnCEWawcDFjkhwWrj2zPJjM/QqRhWFKtfm9GsarwYPhkHcb
 7VLQU5ooP5Ac+p6xncSsbKiuX6oV4WcGxlA0/YviWIBIgw3rXgzcKlMffhJP5HEWxG/52kprApl
 m/ZpxLci2AmdoTVU7QNPpsVH3cMvjrkz4zZcCm8lvp14Vok7/AQI+v7Me2D1lbHL29Ud1eCWL91
 HfRCx0SI2CFOuLR6fq+bEWp5+F0+rNLkGsrhR8Gn0/Ui5YN8DnPpqMnoXdTdfE=
X-JNJ: AAAAAAABF7L0cY+eRWAoA9cz4zo/3jm8qw13Hjl21WoPdAcw+/CcG38WHlJT+ImESI9FV+FOnYK0G/ddnS7h3EprSWI3PEopkqQDMzISnmRFpzsvQmsFLVpC/ph3ZZovV+IiJPqTRAwKhWf/r0uWZM+xDDI2DC0+j0GvqhbuTYd7sjseZPfFMufTvhfg150xdPZzGeqJmCoqzgvxuy+zj6uOme9xlFVbnrslTWBJuWUTp0/yS/enYszfWnY7ZaPJVrkVbqfU51WWdaEa0ObnTVvfzK91V01VWvW20hd8pNTMYnxP9h0mWe9Vqkio+kIhx/Wx02K9I8iqB8IpQXAkqaPuDGKrJEgYDcVH7geRbQElezOU0dXAlozpYJYzntqBGdfA983BuqqzcHw+mL/NTK5C3Uw1U0VVaxhrLCN8ylY7mFYdhPAfiIoCvWNC52xEEBxHX8+m9JrcyKVPddv0Ka/H0jy/CCalHfoMzuUkcgBjFXrKBsaFdnAjObramZpx3ALkonFbnCHUJ7RtwDhrFLU/yDsZ9DlOonjBGoJLwVVhweHbHZa+hEUN+VVoq10vt3Mq8qbQkiArgEswQDx7bBc/3WXAeCpVPcP0xT59S56w9OY6mCsQO7fNXXZwurnfqjpqTqoS0zYPr89kAoBkmIGhlLfZ2Q6e7nchc0ROnYzxtIUjTt+3rEK2MfQ4ZxgL539PcJ6lrbTgeRFaLg0sTc6Omzdn3HsXiYL3XtilzatiT7c5LavueCCwyG1H7B+XHF+zhO7zuiwbKP9DlOxXcT9wrFKsuypgFbd1pR0UduzYQfdu01YAP2gwXTCIinDTB8pOjwCqMkF/GXOJE6g7hf4e5F1HQm0rUDAQ9DL/dxVOXXYTCpXFPT2xlaGvLwlRvi7flyJMo3Gx5uxQaF94WmBhp6z6ce2hOGiPRN5ZpJt/1Gto+z5kvVZ6LNO9u27ge3DpcAcl0fZXgVRg+fOvmlkzgeVR2I+
 0vYOx+E5XdGn52L4LZ3qlP4sATkKGNBlB+QCbXCjWvF0x6kdlTzjqJ5H/5ay+XNOi9f836S2UG+yIii1liTlzlTUQpJJQkf+5n9YPCw/kzPLl0ci5cQBkx1q8wTKjYprPvfV4CfydU43hEZu8mJM7Lno8YxIc/D3813aXwBq/dymBX7fWyjUDukU37AcjjD6bWWKnS+BSZnZNAO7/1z+38Sebr6RLuLWOCXiyPwwKG08qnFznnfONNpRVgaEFCbiZBMcVVYkcHii8LoGhHJWFi812zkXtuNBUh6CQF1O7nBjfPin3P8Hq6Jizkpe2ZPO2I6PikVDz8XhtQTfWhm42qV6Pu1TxOZ4IaOjq4b81cNVmQ54CVM18PSqScgOEnSbnIhg=
Received-SPF: pass client-ip=2a01:b747:3000:203::15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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



> On 18. Aug 2026, at 20:52, Doug Cook (WINDOWS) <dcook@microsoft.com> =
wrote:
>=20
> Under whpx, arm reset results in hangs and crashes.
>=20
> - Arguments out of order in ENCODE_AA64_CP_REG, so =
get_arm_cp_reginfo()
>  fails, whpx_set_registers does nothing for reset, and SCTLR_EL1 =
retains
>  guest state with MMU enabled after reset, resulting in fault and =
hang.
>  Fix via wrapper macro to retain existing ordering convention.
> - Fixing the ENCODE_AA64_CP_REG issue results in assertions while =
trying
>  to write to ARM_CP_CONST registers. Skip them.
> - Correct four entries in the breakpoint/watchpoint index 1 block that
>  named index 0 registers.
> - CPUs that are idle at time of reset remain in suspend after reset.
> - CPUs are not in the correct StartupSuspend state after reset.
>=20
> After this change, I am able to repeatedly reset an arm64 guest, using
> shutdown-reset, external reset, and watchdog reset.
>=20
> Signed-off-by: Doug Cook <dcook@microsoft.com>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

But with comments below:

> ---
> target/arm/whpx/whpx-all.c | 306 +++++++++++++++++++++----------------
> 1 file changed, 177 insertions(+), 129 deletions(-)
>=20
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 00a5de8cdc..f3e7caf794 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -134,143 +134,150 @@ struct whpx_sreg_match {
>     uint32_t cp_idx;
> };
>=20
> +/*
> + * Adapt conventional order WHPX_SYSREG(crn, crm, op0, op1, op2) to
> + * ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2).
> + */
> +#define WHPX_SYSREG(crn, crm, op0, op1, op2) \
> +    ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2)
> +
> static struct whpx_sreg_match whpx_sreg_match[] =3D {
> -    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 0, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr0El1, ENCODE_AA64_CP_REG(0, 1, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr2El1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr3El1, ENCODE_AA64_CP_REG(0, 3, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr4El1, ENCODE_AA64_CP_REG(0, 4, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr5El1, ENCODE_AA64_CP_REG(0, 5, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr6El1, ENCODE_AA64_CP_REG(0, 6, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr7El1, ENCODE_AA64_CP_REG(0, 7, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr8El1, ENCODE_AA64_CP_REG(0, 8, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr9El1, ENCODE_AA64_CP_REG(0, 9, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr10El1, ENCODE_AA64_CP_REG(0, 10, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr11El1, ENCODE_AA64_CP_REG(0, 11, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr12El1, ENCODE_AA64_CP_REG(0, 12, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr13El1, ENCODE_AA64_CP_REG(0, 13, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr14El1, ENCODE_AA64_CP_REG(0, 14, 2, 0, 7) =
},
> -
> -    { WHvArm64RegisterDbgbvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 4) =
},
> -    { WHvArm64RegisterDbgbcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 5) =
},
> -    { WHvArm64RegisterDbgwvr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 6) =
},
> -    { WHvArm64RegisterDbgwcr15El1, ENCODE_AA64_CP_REG(0, 15, 2, 0, 7) =
},
> +    { WHvArm64RegisterDbgbvr0El1, WHPX_SYSREG(0, 0, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr0El1, WHPX_SYSREG(0, 0, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr0El1, WHPX_SYSREG(0, 0, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr0El1, WHPX_SYSREG(0, 0, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr1El1, WHPX_SYSREG(0, 1, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr1El1, WHPX_SYSREG(0, 1, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr1El1, WHPX_SYSREG(0, 1, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr1El1, WHPX_SYSREG(0, 1, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr2El1, WHPX_SYSREG(0, 2, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr2El1, WHPX_SYSREG(0, 2, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr2El1, WHPX_SYSREG(0, 2, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr2El1, WHPX_SYSREG(0, 2, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr3El1, WHPX_SYSREG(0, 3, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr3El1, WHPX_SYSREG(0, 3, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr3El1, WHPX_SYSREG(0, 3, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr3El1, WHPX_SYSREG(0, 3, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr4El1, WHPX_SYSREG(0, 4, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr4El1, WHPX_SYSREG(0, 4, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr4El1, WHPX_SYSREG(0, 4, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr4El1, WHPX_SYSREG(0, 4, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr5El1, WHPX_SYSREG(0, 5, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr5El1, WHPX_SYSREG(0, 5, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr5El1, WHPX_SYSREG(0, 5, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr5El1, WHPX_SYSREG(0, 5, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr6El1, WHPX_SYSREG(0, 6, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr6El1, WHPX_SYSREG(0, 6, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr6El1, WHPX_SYSREG(0, 6, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr6El1, WHPX_SYSREG(0, 6, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr7El1, WHPX_SYSREG(0, 7, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr7El1, WHPX_SYSREG(0, 7, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr7El1, WHPX_SYSREG(0, 7, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr7El1, WHPX_SYSREG(0, 7, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr8El1, WHPX_SYSREG(0, 8, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr8El1, WHPX_SYSREG(0, 8, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr8El1, WHPX_SYSREG(0, 8, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr8El1, WHPX_SYSREG(0, 8, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr9El1, WHPX_SYSREG(0, 9, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr9El1, WHPX_SYSREG(0, 9, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr9El1, WHPX_SYSREG(0, 9, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr9El1, WHPX_SYSREG(0, 9, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr10El1, WHPX_SYSREG(0, 10, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr10El1, WHPX_SYSREG(0, 10, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr10El1, WHPX_SYSREG(0, 10, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr10El1, WHPX_SYSREG(0, 10, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr11El1, WHPX_SYSREG(0, 11, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr11El1, WHPX_SYSREG(0, 11, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr11El1, WHPX_SYSREG(0, 11, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr11El1, WHPX_SYSREG(0, 11, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr12El1, WHPX_SYSREG(0, 12, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr12El1, WHPX_SYSREG(0, 12, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr12El1, WHPX_SYSREG(0, 12, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr12El1, WHPX_SYSREG(0, 12, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr13El1, WHPX_SYSREG(0, 13, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr13El1, WHPX_SYSREG(0, 13, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr13El1, WHPX_SYSREG(0, 13, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr13El1, WHPX_SYSREG(0, 13, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr14El1, WHPX_SYSREG(0, 14, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr14El1, WHPX_SYSREG(0, 14, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr14El1, WHPX_SYSREG(0, 14, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr14El1, WHPX_SYSREG(0, 14, 2, 0, 7) },
> +
> +    { WHvArm64RegisterDbgbvr15El1, WHPX_SYSREG(0, 15, 2, 0, 4) },
> +    { WHvArm64RegisterDbgbcr15El1, WHPX_SYSREG(0, 15, 2, 0, 5) },
> +    { WHvArm64RegisterDbgwvr15El1, WHPX_SYSREG(0, 15, 2, 0, 6) },
> +    { WHvArm64RegisterDbgwcr15El1, WHPX_SYSREG(0, 15, 2, 0, 7) },
> #ifdef SYNC_NO_RAW_REGS
>     /*
>      * The registers below are manually synced on init because they =
are
>      * marked as NO_RAW. We still list them to make number space sync =
easier.
>      */
> -    { WHvArm64RegisterMidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 0) },
> -    { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
> -    { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
> +    { WHvArm64RegisterMidrEl1, WHPX_SYSREG(0, 0, 3, 0, 0) },
> +    { WHvArm64RegisterMpidrEl1, WHPX_SYSREG(0, 0, 3, 0, 5) },
> +    { WHvArm64RegisterIdPfr0El1, WHPX_SYSREG(0, 4, 3, 0, 0) },
> #endif
> -    { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, =
1), true },
> -    { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, =
0), true },
> -    { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, =
1), true },
> -    { WHvArm64RegisterIdAa64Isar0El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, =
0), true },
> -    { WHvArm64RegisterIdAa64Isar1El1, ENCODE_AA64_CP_REG(0, 6, 3, 0, =
1), true },
> +    { WHvArm64RegisterIdAa64Pfr1El1, WHPX_SYSREG(0, 4, 3, 0, 1), true =
},
> +    { WHvArm64RegisterIdAa64Dfr0El1, WHPX_SYSREG(0, 5, 3, 0, 0), true =
},
> +    { WHvArm64RegisterIdAa64Dfr1El1, WHPX_SYSREG(0, 5, 3, 0, 1), true =
},
> +    { WHvArm64RegisterIdAa64Isar0El1, WHPX_SYSREG(0, 6, 3, 0, 0), =
true },
> +    { WHvArm64RegisterIdAa64Isar1El1, WHPX_SYSREG(0, 6, 3, 0, 1), =
true },
> #ifdef SYNC_NO_MMFR0
>     /* We keep the hardware MMFR0 around. HW limits are there anyway =
*/
> -    { WHvArm64RegisterIdAa64Mmfr0El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
0) },
> +    { WHvArm64RegisterIdAa64Mmfr0El1, WHPX_SYSREG(0, 7, 3, 0, 0) },
> #endif
> -    { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
1), true },
> -    { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
2), true },
> -    { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, =
3), true },
> -
> -    { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
> -    { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
> -    { WHvArm64RegisterCpacrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 2) },
> -    { WHvArm64RegisterTtbr0El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 0) },
> -    { WHvArm64RegisterTtbr1El1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 1) },
> -    { WHvArm64RegisterTcrEl1, ENCODE_AA64_CP_REG(2, 0, 3, 0, 2) },
> -
> -    { WHvArm64RegisterApiAKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 0) =
},
> -    { WHvArm64RegisterApiAKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 1) =
},
> -    { WHvArm64RegisterApiBKeyLoEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 2) =
},
> -    { WHvArm64RegisterApiBKeyHiEl1, ENCODE_AA64_CP_REG(2, 1, 3, 0, 3) =
},
> -    { WHvArm64RegisterApdAKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 0) =
},
> -    { WHvArm64RegisterApdAKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 1) =
},
> -    { WHvArm64RegisterApdBKeyLoEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 2) =
},
> -    { WHvArm64RegisterApdBKeyHiEl1, ENCODE_AA64_CP_REG(2, 2, 3, 0, 3) =
},
> -    { WHvArm64RegisterApgAKeyLoEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 0) =
},
> -    { WHvArm64RegisterApgAKeyHiEl1, ENCODE_AA64_CP_REG(2, 3, 3, 0, 1) =
},
> -
> -    { WHvArm64RegisterSpsrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 0) },
> -    { WHvArm64RegisterElrEl1, ENCODE_AA64_CP_REG(4, 0, 3, 0, 1) },
> -    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 0, 0) },
> -    { WHvArm64RegisterEsrEl1, ENCODE_AA64_CP_REG(5, 2, 3, 0, 0) },
> -    { WHvArm64RegisterFarEl1, ENCODE_AA64_CP_REG(6, 0, 3, 0, 0) },
> -    { WHvArm64RegisterParEl1, ENCODE_AA64_CP_REG(7, 4, 3, 0, 0) },
> -    { WHvArm64RegisterMairEl1, ENCODE_AA64_CP_REG(10, 2, 3, 0, 0) },
> -    { WHvArm64RegisterVbarEl1, ENCODE_AA64_CP_REG(12, 0, 3, 0, 0) },
> -    { WHvArm64RegisterContextidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, =
1) },
> -    { WHvArm64RegisterTpidrEl1, ENCODE_AA64_CP_REG(13, 0, 3, 0, 4) },
> -    { WHvArm64RegisterCntkctlEl1, ENCODE_AA64_CP_REG(14, 1, 3, 0, 0) =
},
> -    { WHvArm64RegisterCsselrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 2, 0) },
> -    { WHvArm64RegisterTpidrEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 2) },
> -    { WHvArm64RegisterTpidrroEl0, ENCODE_AA64_CP_REG(13, 0, 3, 3, 3) =
},
> -    { WHvArm64RegisterCntvCtlEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 1) =
},
> -    { WHvArm64RegisterCntvCvalEl0, ENCODE_AA64_CP_REG(14, 3, 3, 3, 2) =
},
> -    { WHvArm64RegisterSpEl1, ENCODE_AA64_CP_REG(4, 1, 3, 4, 0) },
> +    { WHvArm64RegisterIdAa64Mmfr1El1, WHPX_SYSREG(0, 7, 3, 0, 1), =
true },
> +    { WHvArm64RegisterIdAa64Mmfr2El1, WHPX_SYSREG(0, 7, 3, 0, 2), =
true },
> +    { WHvArm64RegisterIdAa64Mmfr3El1, WHPX_SYSREG(0, 7, 3, 0, 3), =
true },
> +
> +    { WHvArm64RegisterMdscrEl1, WHPX_SYSREG(0, 2, 2, 0, 2) },
> +    { WHvArm64RegisterSctlrEl1, WHPX_SYSREG(1, 0, 3, 0, 0) },
> +    { WHvArm64RegisterCpacrEl1, WHPX_SYSREG(1, 0, 3, 0, 2) },
> +    { WHvArm64RegisterTtbr0El1, WHPX_SYSREG(2, 0, 3, 0, 0) },
> +    { WHvArm64RegisterTtbr1El1, WHPX_SYSREG(2, 0, 3, 0, 1) },
> +    { WHvArm64RegisterTcrEl1, WHPX_SYSREG(2, 0, 3, 0, 2) },
> +
> +    { WHvArm64RegisterApiAKeyLoEl1, WHPX_SYSREG(2, 1, 3, 0, 0) },
> +    { WHvArm64RegisterApiAKeyHiEl1, WHPX_SYSREG(2, 1, 3, 0, 1) },
> +    { WHvArm64RegisterApiBKeyLoEl1, WHPX_SYSREG(2, 1, 3, 0, 2) },
> +    { WHvArm64RegisterApiBKeyHiEl1, WHPX_SYSREG(2, 1, 3, 0, 3) },
> +    { WHvArm64RegisterApdAKeyLoEl1, WHPX_SYSREG(2, 2, 3, 0, 0) },
> +    { WHvArm64RegisterApdAKeyHiEl1, WHPX_SYSREG(2, 2, 3, 0, 1) },
> +    { WHvArm64RegisterApdBKeyLoEl1, WHPX_SYSREG(2, 2, 3, 0, 2) },
> +    { WHvArm64RegisterApdBKeyHiEl1, WHPX_SYSREG(2, 2, 3, 0, 3) },
> +    { WHvArm64RegisterApgAKeyLoEl1, WHPX_SYSREG(2, 3, 3, 0, 0) },
> +    { WHvArm64RegisterApgAKeyHiEl1, WHPX_SYSREG(2, 3, 3, 0, 1) },
> +
> +    { WHvArm64RegisterSpsrEl1, WHPX_SYSREG(4, 0, 3, 0, 0) },
> +    { WHvArm64RegisterElrEl1, WHPX_SYSREG(4, 0, 3, 0, 1) },
> +    { WHvArm64RegisterSpEl1, WHPX_SYSREG(4, 1, 3, 0, 0) },
> +    { WHvArm64RegisterEsrEl1, WHPX_SYSREG(5, 2, 3, 0, 0) },
> +    { WHvArm64RegisterFarEl1, WHPX_SYSREG(6, 0, 3, 0, 0) },
> +    { WHvArm64RegisterParEl1, WHPX_SYSREG(7, 4, 3, 0, 0) },
> +    { WHvArm64RegisterMairEl1, WHPX_SYSREG(10, 2, 3, 0, 0) },
> +    { WHvArm64RegisterVbarEl1, WHPX_SYSREG(12, 0, 3, 0, 0) },
> +    { WHvArm64RegisterContextidrEl1, WHPX_SYSREG(13, 0, 3, 0, 1) },
> +    { WHvArm64RegisterTpidrEl1, WHPX_SYSREG(13, 0, 3, 0, 4) },
> +    { WHvArm64RegisterCntkctlEl1, WHPX_SYSREG(14, 1, 3, 0, 0) },
> +    { WHvArm64RegisterCsselrEl1, WHPX_SYSREG(0, 0, 3, 2, 0) },
> +    { WHvArm64RegisterTpidrEl0, WHPX_SYSREG(13, 0, 3, 3, 2) },
> +    { WHvArm64RegisterTpidrroEl0, WHPX_SYSREG(13, 0, 3, 3, 3) },
> +    { WHvArm64RegisterCntvCtlEl0, WHPX_SYSREG(14, 3, 3, 3, 1) },
> +    { WHvArm64RegisterCntvCvalEl0, WHPX_SYSREG(14, 3, 3, 3, 2) },
> +    { WHvArm64RegisterSpEl1, WHPX_SYSREG(4, 1, 3, 4, 0) },
> };

Ow, carried this mess in formats from HVF, don=E2=80=99t think we wanna =
keep this really.

(switching to the ENCODE_AA64_CP_REG format across the board would be =
better)

>=20
> HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
> @@ -610,6 +617,37 @@ void whpx_set_registers(CPUState *cpu, =
WHPXStateLevel level)
>             whpx_set_reg(cpu, whpx_sreg_match[i].reg, val);
>         }
>     }
> +
> +    if (level =3D=3D WHPX_LEVEL_RESET_STATE) {
> +        /*
> +         * WHPX keeps the "vCPU is in a low-power wait" state =
(entered when the
> +         * guest executes WFI/WFE) in =
WHvRegisterInternalActivityState, and that
> +         * state is not affected by writing the architectural =
registers above.
> +         * If the guest happened to be idle when the reset was =
requested, the
> +         * vCPU would stay suspended forever.
> +         *
> +         * StartupSuspend is the bit WHP uses to hold a vCPU that has =
not been
> +         * started yet, and it is how secondary vCPUs are parked =
until PSCI
> +         * CPU_ON releases them.
> +         */
> +        WHV_REGISTER_NAME name =3D WHvRegisterInternalActivityState;
> +        bool powered_off =3D arm_cpu->power_state =3D=3D PSCI_OFF;
> +        WHV_REGISTER_VALUE ia;
> +        HRESULT hr;
> +
> +        clean_whv_register_value(&ia);
> +        hr =3D whp_dispatch.WHvGetVirtualProcessorRegisters(
> +            whpx_global.partition, cpu->cpu_index, &name, 1, &ia);
> +        if (SUCCEEDED(hr) &&
> +            (ia.InternalActivity.IdleSuspend ||
> +             ia.InternalActivity.HaltSuspend ||
> +             ia.InternalActivity.StartupSuspend !=3D powered_off)) {
> +            ia.InternalActivity.IdleSuspend =3D 0;
> +            ia.InternalActivity.HaltSuspend =3D 0;
> +            ia.InternalActivity.StartupSuspend =3D powered_off;
> +            whpx_set_reg(cpu, WHvRegisterInternalActivityState, ia);
> +        }
> +    }
> }

Looks good :) Although perhaps this is better as a separate commit from =
the change
above.

>=20
> static uint32_t max_vcpu_index;
> @@ -789,8 +827,18 @@ int whpx_init_vcpu(CPUState *cpu)
>         uint32_t key =3D whpx_sreg_match[i].key;
>=20
>         ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, key);
> -        if (ri) {
> -            assert(!(ri->type & ARM_CP_NO_RAW));
> +        /*
> +         * Only registers with raw backing store in CPUARMState can =
take part
> +         * in the cpreg list sync:
> +         *
> +         * - ARM_CP_NO_RAW registers have no state to sync at all;
> +         *   write_cpustate_to_list() and write_list_to_cpustate() =
skip them.
> +         *
> +         * - ARM_CP_CONST registers (the ID registers in the table =
above)
> +         *   ignore raw writes and always read back the value the CPU =
model was
> +         *   built with.
> +         */

But not this bit, which should be dropped.

The CPU model gets synced through this bit and registers that error
out through ARM_CP_NO_RAW should be behind a #ifdef SYNC_NO_RAW_REGS
block.

The former characteristic is what allows for example -cpu cortex-a72
to be used on WHPX instead of only the native machine, while masking off
the newer feature from feature regs.

> +        if (ri && !(ri->type & (ARM_CP_NO_RAW | ARM_CP_CONST))) {
>             whpx_sreg_match[i].cp_idx =3D sregs_cnt;
>             arm_cpu->cpreg_indexes[sregs_cnt++] =3D =
cpreg_to_kvm_id(key);
>         } else {
> --=20
> 2.55.0.vfs.0.3
>=20
>=20


