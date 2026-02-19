Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1080CE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 11:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt20B-0003W7-SB; Thu, 19 Feb 2026 06:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vt20A-0003Vp-Ek
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 06:15:22 -0500
Received: from p-west1-cluster3-host12-snip4-9.eps.apple.com ([57.103.66.42]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vt208-0001tM-SZ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 06:15:22 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPS id
 CFB00180121D; Thu, 19 Feb 2026 11:15:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771499716; x=1774091716;
 bh=KzNogFJPz7Agr86nKC+JPgnUuMll1pF42KoNePxyWtg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=bJFUGhvf+H6gwd0ciWVpzu/hFJFDpsVbksxmUCsEsKNcAeDUfxP85QTDIYBvT+h7rW+rs2JVat0x7GbpvP8ICTmxEYe0txRPkFdCalZdTJIT5yfTQhIh0Hc5TLjZD2TSfPwALc7AIFsxpda66QuExAhcKRVx7kvqKT1ZNYd7Rvk4jIHKqe+WzIMq9nHzA4L1cMDPI8GQXiqDpMFStchB0mPr0utW3K/ysfK2XFjCjr4N+7DFCM6XPRlWI/8Nv2xr9ATsqnoCMNqGQZ0hDxaf0D5DczEVXcySRLEzRnKOOYnntdbKZJFRrc6wuA1rz+mHgjPHt+81eLZR+EhwlxWzvA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-11 (Postfix) with ESMTPSA id
 AC05C1800878; Thu, 19 Feb 2026 11:15:14 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH] hw/arm/virt: Update error message for bad gic-version
 option
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260219110228.3804482-1-peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 12:15:02 +0100
Cc: qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E736C533-340E-4E5E-80D0-4038E44114A6@unpredictable.fr>
References: <20260219110228.3804482-1-peter.maydell@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDEwMyBTYWx0ZWRfX7Thazpa9l3jc
 9EwdjA6/pEkPF9U1aBxpfV5wgNT4AWM1hLBpE7tdgJY/9SkWermZpnDi6iDNcl0CsxzJAaZu6nN
 3fquKSRpvZ6/O/Itvr4G6GliMothwL5yDiXJ2G3pnGe+a51xO/Mj0vxijULIUR5mh7ETUVzqxic
 0mrPU4wyU/eYeI0GHWIuuOmCztwxAIpvs2Vmp8tjNbC8lMk5wQYQ6RWbMXJioCQh6oKsyOTl7F3
 SpiOAwD7t9ocW1SsgklEVF+WYJZnFz6RBTtWZ5dg7K3AQWIJh0pThj2Wggcc8wBujlhoR/ZiRmk
 htNq8GXJEh9qmD5EqVT91CFqh/WuvuOoEnezIelcnWzB94Y7JkDWi2GFgpNFO8=
X-Proofpoint-ORIG-GUID: nLy9gw7fLi4pOSoiXEwDvum4FFc4zCI6
X-Authority-Info-Out: v=2.4 cv=fd6gCkQF c=1 sm=1 tr=0 ts=6996f0c3
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=5Qp-V6bWqe7nvp7XcxIA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: nLy9gw7fLi4pOSoiXEwDvum4FFc4zCI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190103
X-JNJ: AAAAAAABGUroYwwQvRlo62Ul8Tq8Oo4uIo3c6eVKpmrNgnw8YGp5dPjx5I+IL4spd1/yIWMrHIuW1YXVxt4wGn3msfGNvT7Lypbt2r2My/1YfggkqeKYqPtMD4iUequTWoZTnaDgGux9jNqjeGnExDzD2dk5w6+75qML3ZMFEMioSAGRQd5Z7LTzM4NGsngMMYf+YvjUqptzLUNIOKd71bAhMuvpjcUtTFNYWvcxOXPy0haGt4hf1A+O7iF3Zb1PnMpIGchlh1aGUfbEPj/E/b3bZ45UXqu295iasD62vcg6k8O3J4oED49WKRic4aAitJYhXk7FFgvupm5JfhpLTtN58jUS++LEjNsd8UzXWlbltDs1hmVLLwHCbNIrcQ7JXZuLF2N5TF22SPJgU9w0MpmvGnFui8+6Z1C656ibDmobVltieB6NqCOcsYoT8jWX8oXOWejGuIc8q97WoMQMoBkby5QNb8TlWO1tEg9O2+d5kpu9EihnRLtsv5KJefNmgXZUQH5KjHGTN13U7vVbuFnsro1ntquxFuToYNF/fqFwkH2Tk4gyCV8HOVmeVZt0THeASEQUt5GDdYR6ZdbAExF7f6iGk6i9UkNDlH4/yMnzURqnnFYLjSWhsriJEB8BRMoTPAm6
Received-SPF: pass client-ip=57.103.66.42;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 19. Feb 2026, at 12:02, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> As we added different valid gic-version option settings,
> we forgot to update the hint in the error message produced
> when the user specifies an invalid value:
>=20
> $ qemu-system-aarch64 -M virt,help | grep gic-version
>  gic-version=3D<string>   - Set GIC version. Valid values are 2, 3, 4, =
host and max
> $ qemu-system-aarch64 -M virt,gic-version=3Dbang
> qemu-system-aarch64: Invalid gic-version value
> Valid values are 3, 2, host, max.
>=20
> Update the error string to match the one we use in the help text
> for the option.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> hw/arm/virt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 50865e8115..8dc999712c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2971,7 +2971,7 @@ static void virt_set_gic_version(Object *obj, =
const char *value, Error **errp)
>         vms->gic_version =3D VIRT_GIC_VERSION_MAX; /* Will probe later =
*/
>     } else {
>         error_setg(errp, "Invalid gic-version value");
> -        error_append_hint(errp, "Valid values are 3, 2, host, =
max.\n");
> +        error_append_hint(errp, "Valid values are 2, 3, 4, host, and =
max.\n");
>     }
> }
>=20
> --=20
> 2.43.0
>=20
>=20


