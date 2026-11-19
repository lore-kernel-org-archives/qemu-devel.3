Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A46606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=IxFIzW/p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU4Gw-000334-Qn; Thu, 19 Nov 2026 10:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xU4Gu-00030J-6x
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 10:42:00 -0500
Received: from mr-2005g-snip6-6.eps.apple.com ([2a01:b747:3000:206::43]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xU4Gs-0003nV-I8
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 10:41:59 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 B487918001B7
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:41:54 +0000 (UTC)
X-ICL-RepId: 01a1f478-b86f-766c-87fd-2d6beb0e6e98
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795102916; x=1826638916;
 bh=GakfYVuiFXaoXLtyIFQ8JE8cIfQYuyspbnej5Els7K0=;
 h=From:Content-Type:Mime-Version:Subject:Date:To:Message-Id:x-icloud-hme;
 b=IxFIzW/pTszQcShgwlxmFUj4ZBXYsyK9nTcCGyhl9U1pJregBK43hRBMP3Nv8OWARUlZdlNPfkIrt7l9eVOUwjfCs/GT25d6m2m89GJznzO2rbiIX8pkoAIFsLc9sG0D1hSHEfjsJ61l8K8qkJWgiToZ3ehGxs8KlOX2h86eMdJKu4IX5GGREzR0HuXd2CYbAcWkVgN9IxWetPXT4GThiaOePMfIASGry3fJt+qtqO6TjpKUzMpRBdLDCvlqOBmiaryPZ/Gd9yGi+RyJCT7wK2/KNYLYzoDnUrH6u3bhLNYrWO7uO0taTRF8EHUc6HZpdCubAe5UkOQFX7WBAB6QQw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 B9A021800289
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 15:41:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] whpx: i386: only do partition reset when exposed
Date: Thu, 19 Nov 2026 16:41:41 +0100
References: <20261119153918.87662-1-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
In-Reply-To: <20261119153918.87662-1-mohamed@unpredictable.fr>
Message-Id: <32292088-F0CD-45A1-959B-CA1BA4E846A7@unpredictable.fr>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-ORIG-GUID: iV0Ux5iEDSxP55XOo37pN-GMxlp8_91R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2MiBTYWx0ZWRfX19jT9GR5dxiP
 a7oFS1zTZ3hwRsT5tYCxLwtXoLige/rYBGGJkVuncRlhFpoKG2EzAQTutNqK1O750aMuTs4w7Kx
 ANeKNZOOMrisqy6eJhq1xWDsNVU1X+4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2MiBTYWx0ZWRfXx5fS+y/hxymT
 NYaVMUsQ/FdAOR7Ntpe1EDQOZMxKyb8g/jlftjF53+fw2iRGByd/eVUtnKt4fpSwVejHmflNSB3
 FB2fW8DZcHn9hhdZY8Uj7dEimQ9E1/L3rHvsYCbF36iSLzzbDgW7LDtbMTHWzCoA3IKlunLJp7S
 W3Jzg2r3zcSQzSA1eOd8wwNHiXdMztnrK1rIEoG1nF59qe5fZ0qkFlQCC9B84Wilu/iIzjWKu/F
 SjRiCcEprWnixNRsaL6ZwQXOXx/sk2HJQBa3I9jXEyvZ2T5sRXZDIBfyBXTYDwIzBgNALrsUhnW
 w0qydCVTIIhCAW/9HPNwOofEgIEZmTvGFfMFhT6Tw8T6xAvyA4+O0kFPyEWc3E=
X-Authority-Info-Out: v=2.4 cv=QNn91QLL c=1 sm=1 tr=0 ts=6aff18c2
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=AZoGnDOZhPiq548KR6q9:22 a=S9oidJ0X30WSrBQ5NySO:22
 a=p0WdMEafAAAA:8 a=XwEauuoPsXiJ0_X0o8wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iV0Ux5iEDSxP55XOo37pN-GMxlp8_91R
X-JNJ: AAAAAAABPe9nMrkUhdTtUFI2RjgBB8ZDayufydEOBFBld1wkiISGFBuWWs1LjkAStTwz1R
 nZO8uOUGmDrN01WM1HXfgbedCcSHdicYg3xWB0A8mmX07ErOYmOgRAXUBZmo+/2dft0jnK
 3ZPckq7oyHmII5pb/x4FWWEmgmMTBEln+cR2dE+7K90QqyCAO4tbt28N1V3Xs4nbgN+6UF
 ce18Vehi24xNQM1/J2K0gbfvexbI2J9ChrNyhRM820xkMMsLlz4pCTDDyQkUeVSSWBVUt3
 t1mUk6nocpeWUuMBZdt+n0v7ye4KDhDSE/GSIf+DHjymiLFHDxI4X3TOxXNKG5ESjseRsL
 tDZrS7Uk0mboOO1H4YPKksi0m/gz4WUrXObpkfTZuFnW4ugwTC7D657QeI/b//8gnd7U+f
 WsUcrfPwhdiUpt92PBayzQc7xItrEdmKBT/Ti28mXeKA/G69WgDhf9roEuS0DtHUYE/qe6
 xly5E73hJqoKjtIQgx/1ZzhK2OayM9Skd5y8RMWrm0D17K0+h1uxpufYmqnEwFIhkrkW5F
 0qvjuCtKh86CcvOlVg58NOYx5+mu8ZIliNQE3Z0ozl0UKawSPSje3UdxIc/PuYrHWdESnx
 oJZW+z+MQ/FcHtg/A/XUpiPtmzjpuzzEytPSQIo+fSBnwNuFHaXBOkQfh7mOYQiZF+RUQx
 R5Uvi3ZPVDc/MeIIzQhc0GChrzGIkjksWGGQzEaJUMJoMZelRV46ules6FswOF/M/FTO6f
 TszcXgn9KpelwANzyeoXPP2HwcZ7gBpOQkErASXcG7jrLiGkq9GIAF1hig3u2cZKaaZB6O
 znjC3WzhjfTHvnTY6NYFR9n4ND8hzhL8rMynU7231k4G3itZIHtTlG7sp21EWP7fK3vrgb
 kKZtFglpn61j1CT9xeFWNa/E6VwKnz/njBO842noen8pThd37rDG26Yu/6z7UVV0wVH68X
 D874G6Ef7cotFXBhFsq5yv7Go4t2I3k+b60Iq2MaynkULsjhxHRbJ7ozzXojFPty42mhvK
 FoPbgQB/1stoL4Zcjgn7afCpsf7ALFkbK/c82bjS0vS2QBZpcNFL2voRZh2riHr8QThu+/
 q2E7/ZzBnnfS78kvrNVufdLC9otzJQpXofC3jgT7lfJXQ4lgTWNB2U4SKhPBeM2MKLN38s
 4gqLCeCDpdEXDIJp21uBVjoTeD3a2tLpfkP7zHkaitR9H0VwyA3Z6ZrjsxEoD0ovo7oeNe
 36QJQaa+FdpoUPTdKoAeN1QirYsbJNlLGSvnBakpbIOEtmXf6V9Sztdzgt4rAe0xM4dOEo
 kfnpPJsCkaqZ6t9Upeer+wkBqPR65LcoLOqMF7E8dupFv+xKEa2NNkTSU=
Received-SPF: pass client-ip=2a01:b747:3000:206::43;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 19. Nov 2026, at 16:39, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> WHvResetPartition is not exposed before Windows 11 and
> Windows Server 2025.
>=20
> It is also not exposed on Server 2022, which passes the
> legacy OS check otherwise.
>=20
> As such, gate it behind availabilty of WHvResetPartition.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4908
Fixes: 6275714a ("target/i386/whpx: handle processor reset=E2=80=9D)

> ---
> target/i386/whpx/whpx-all.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index df1c772eb3..6c6af6c4d5 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -530,7 +530,8 @@ void whpx_set_registers(CPUState *cpu, =
WHPXStateLevel level)
>     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
>=20
>     /* Assumes that cpu_synchronize_all_post_reset() runs cpu 0 first. =
*/
> -    if (level =3D=3D WHPX_LEVEL_RESET_STATE && cpu->cpu_index =3D=3D =
0) {
> +    if (whp_dispatch.WHvResetPartition &&
> +        level =3D=3D WHPX_LEVEL_RESET_STATE && cpu->cpu_index =3D=3D =
0) {
>         hr =3D whp_dispatch.WHvResetPartition(whpx->partition);
>         if (FAILED(hr)) {
>             error_report("WHPX: Failed to reset partition, hr=3D%08lx", =
hr);
> --=20
> 2.54.0 (Apple Git-157)
>=20
>=20


