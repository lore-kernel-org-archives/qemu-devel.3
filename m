Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E889BE66882
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfVI-0001cI-1B; Fri, 19 Dec 2025 13:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vWfVG-0001bZ-2n
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:47:02 -0500
Received: from p-west2-cluster5-host4-snip4-1.eps.apple.com ([57.103.71.94]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vWfVD-00026L-UK
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:47:01 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-10 (Postfix) with ESMTPS id
 D750C18000B8; Fri, 19 Dec 2025 18:46:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=Bep4jY7Sk3/bKH7xP2oBaX1JqNU6QYuP245WqL4hHfk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=dDAVy/P7UJ8p43sPQ/u98nqQekUgzaUtcyxYSPusF2n9mRYC8NIfAih5grLlvWIY2Kra3OibOTCG4qfLp3+Bp0AIbfgmc+/cAk7UmUMCCtPRCYlELFdcLJXnqiWT3OjJjeKDgMYPaNAaZ27LQobzWPTWLQChbhXl2lLNR0ICRrIDhXvTKTO2nwpK/+x2n2fwj6+d9T7WIP6Uv+o3WfjYRSLSN5ym/+i1LW5Vwt5bPP0GNVyW69ZXWqqiOdVHanJ+5EbIezLjh74CqV5jJ5DYy2x1nJ30UT8rF9SF4ktiKzsT+aXT17jLBLTheDven+P/l+1eEQyfe+PLSXPAK+w8bQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-10 (Postfix) with ESMTPSA id
 070B91800179; Fri, 19 Dec 2025 18:46:53 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] hvf: support changing IPA granule size
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20251219183716.4379-1-j@getutm.app>
Date: Fri, 19 Dec 2025 19:46:40 +0100
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C0540B1-1D8F-470B-8719-34CF03A93573@unpredictable.fr>
References: <20251219183716.4379-1-j@getutm.app>
To: Joelle van Dyne <j@getutm.app>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Authority-Info: v=2.4 cv=PNoCOPqC c=1 sm=1 tr=0 ts=69459d9f cx=c_apl:c_pps
 a=9OgfyREA4BUYbbCgc0Y0oA==:117 a=9OgfyREA4BUYbbCgc0Y0oA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zpFRZEGqInM2nEw2eyEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: k7TYuDhDoUNzT7QevL-Bi3XlF2FCHfJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDE1OCBTYWx0ZWRfX9S1zcgPu6Ntu
 P+0YY1/bTdYJGsnHW/d7JAN4c24/lREHuMHgFrDY2RT4ZLko73bVeRx9vgKUC2kU9GTg12/ER//
 LsOGfQ9np9dspK6GM7qSYsxS38EHt/6rkBFse0JBFee9/TBUXln2rtszeNalt2IyRVeLKK8piiy
 5d4uDk9oV36a33yQHFRcFkhzxcI8jblxdtsmmIANS/LP5zjoeC/0IW74Df02fznjhVitqU2FhEu
 8kbgtxebIXLy3pQC+hzI0/xuLLN+2R6dAmo8dWKDuByfVNIp6mC1EZdD0cuKiVND6nvMS21RJMx
 fUqquyei7W8Cj3Wn8mk
X-Proofpoint-GUID: k7TYuDhDoUNzT7QevL-Bi3XlF2FCHfJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_07,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1030 mlxlogscore=603
 bulkscore=0 mlxscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512190158
X-JNJ: AAAAAAABcwEr3bknGrG3N6kzFuy+fMOM/NDNXeZ8OAReJ0bD+K5w4MWNb1RRcs2DVGpIKGh774elmZMM4XLUsohA9Xxosbf6ZRqG9ufDhp2buIF4u5iaF3dRm6AmrIvmzRyFMl6cYZ1yhtvyW61B+ZpX24Vd0VOFK/AyukMUWdFdDBjOODL45s9mhlK242CUs9B6J/iVW3ZDp6SysHxnDdKkagWxVTzjBs5vupfs56M0/CWrj6B45+g2Qx5/RMc+/iR2OfPzLz/w7FEAm8+w66Y/ia/SmShV1WSy/hbL0yfFSaZSxOy+jdOnVpwkdzZZRfY4f+cDs5XktnjYlcyZ3qAn6YSoxDeXHXP29sz/Vet2qlEeq6nKqEZIzbV/EHw0kQ7XDcvTW0q4JHr1vZqEC3vsOd3jFUI+GQvOUja3rzkXB32oxVHi7FrLn2iQBtOpieV5M3DKStnhSBqeR1W5JqZYDGDKk4imePAIROMBARwSmctPOMHuWmq0NNaNIGUPAcAynUAzu2sk1VWpk/q+Z/v2j8uuUkcOj1o8UTu/5SdezqqUmvsySmAfCr4KcKchddTPs6zLsb3PO1A4bPZG0Rnln22qFkuP8j1iDxGYTncg2nMpKCH5KfVc67j9Uo85SH0qGYl4HcZUvKj3yH5sIsB+lajrSGxFsImf8KP+srdQSo+TBD7c+zYwDpkzRp8PtoY1Dgv8bum4SFmMrHE4/KaPs8/roPUS3Q==
Received-SPF: pass client-ip=57.103.71.94;
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

> On 19. Dec 2025, at 19:37, Joelle van Dyne <j@getutm.app> wrote:
>=20
> The IPA granule is the smallest page size hv_vm_map() support. For =
Venus, we
> need to support 4KiB pages. macOS 26 introduces a public API for =
setting
> the granule size. We can only use this when compiled with macOS 26 SDK =
and
> run on macOS 26+. Otherwise, we fall back to an older, private, API =
which
> achieves the same purpose.
>=20

Let=E2=80=99s have an HVF_NO_PRIVATE_API define (or the opposite) to =
have a single toggle to disable all private API use at build time

> +
> +    /* older macOS need to use a private API */
> +    if (!set_ipa_granule) {
> +        set_ipa_granule =3D dlsym(RTLD_NEXT, =
"_hv_vm_config_set_ipa_granule");
> +    }
> +    if (set_ipa_granule) {
> +        return set_ipa_granule(config, ipa_granule_size);
> +    } else if (ipa_granule_size !=3D page_size) {
> +        error_report("Failed to find _hv_vm_config_set_ipa_granule");
> +        return HV_UNSUPPORTED;
> +    }
> +
> +    return HV_SUCCESS;
> +}
> +
> +hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range,
> +                               uint32_t ipa_granule_size)
> {
>     hv_return_t ret;
>     hv_vm_config_t config =3D hv_vm_config_create();
> @@ -891,6 +932,13 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, =
uint32_t pa_range)
>     }
>     chosen_ipa_bit_size =3D pa_range;
>=20
The PA range is actually different depending on the IPA granule size.

An example from M4 Max:

% sysctl -a | grep ipa
kern.hv.ipa_size_16k: 4398046511104
kern.hv.ipa_size_4k: 1099511627776

> +    if (ipa_granule_size) {
> +        ret =3D hvf_set_ipa_granule(config, ipa_granule_size);
> +        if (ret !=3D HV_SUCCESS) {
> +            goto cleanup;
> +        }
> +    }
> +
>     ret =3D hv_vm_create(config);
>=20


