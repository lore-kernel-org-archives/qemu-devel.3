Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616FE112584F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Lo8-0001gZ-QN; Wed, 11 Mar 2026 11:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Lnt-0001Vf-Pf
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:48:59 -0400
Received: from p-west2-cluster5-host7-snip4-5.eps.apple.com ([57.103.71.68]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Lnr-00013c-Bo
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:48:56 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-7 (Postfix) with ESMTPS id
 DA03818032CF; Wed, 11 Mar 2026 15:48:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773244133; x=1775836133;
 bh=BxI+0jJfQSj4TE6F8K85BnhHqRgaqRW7btty/cBLVFc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=a8hgsf0xCh/RWUOpEIVqNhH4faHvdDaJNXpaJctpUED4FrmnNTX96YAR29w0igvfT4kaHR27rCJskFGEATcb/w82jnfmxi6paSUYO7p8V+RS8bS7pS94olpgCijeDAkclynqM2q47mvMB7Z8qCNcYlzvR6rNvDmhcWaqpB0OTXscmUzaczqs+GPjk7F1y9iT5ixZN4s0dSA3lKbG96qXrP2xdnNKtBGHEeyIaWnASsI4pl8sstzF393TrXH0zGv2SG9LkfqnBM5I9a7rJCOo/15eL9NDs7zR/VxTA4DBEpPhnv3dgafuKWzQEG8+Bw+f+Tn3p2VeFD/zxHRcqvyAYg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-7 (Postfix) with ESMTPSA id
 BCE7718003B5; Wed, 11 Mar 2026 15:48:48 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 09/14] target/arm: cpu: Mark MSHV supporting PSCI 1.3
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-9-c31699b7bc1f@anirudhrb.com>
Date: Wed, 11 Mar 2026 16:48:38 +0100
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <22F075E2-F8A8-4DDC-BFD7-BC5C306ABBD0@unpredictable.fr>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-9-c31699b7bc1f@anirudhrb.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=cOLtc1eN c=1 sm=1 tr=0 ts=69b18ee3
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tFGNSmrwAAAA:8 a=yMhMjlubAAAA:8
 a=3cm_JcPUJR9xieiBe1sA:9 a=CjuIK1q_8ugA:10 a=LpD6Tdepsyerr7eS-Jg7:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzNCBTYWx0ZWRfX4orCC6t1xLI+
 H6kVyn582fwTwcMW0pV00b18R/Xc4LB7QmWnY3izh4jH47y8XJ4wuQpjzRkDfz5BPThSks4U18b
 IgLEdrGnR+hlAWLriDJMf4gsP34PEDvhWi8ysoZDxAAzsFiArdt9+dJOwKoYXiEaCSwAxFll2cv
 rR1VhymlDRoz1qJZW9sX2bCEom2wdycX/OrcEkclchVm7ffu7aiqb/VzAlVgF0LZadjNI4YIKe5
 N7lt7mK0rHpAbVTAHjfrC/JjyXZlyoc2y292oDzyVNY0i7R9TEnPv6uZL20uMK57QJtOPUFoLIm
 T65YWX7OAIr3ie4KDNfNll+5cfF37Rggie/LQ+WtecXEIVNSs2+8D7gvaRm9CQ=
X-Proofpoint-ORIG-GUID: F-iBPiY9UQ__peOYVn1yXSvhzztX1Abe
X-Proofpoint-GUID: F-iBPiY9UQ__peOYVn1yXSvhzztX1Abe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110134
X-JNJ: AAAAAAABCbMGSm+NHSiaJHl88THI/8t5sj+waiQbT9uuhz7rsDG9yhSOXaaa/Kv79M1YdEpr5+CCdsLw0vRvCy0Lkx5BU2mJJwN3xNOZNP5x820mpYZd7EVwJNKGVbLP9CInC7L/i9PLAMTZIPOKzG9pod7cXYGLtyI4csM12WVNUSQc+njvNl7D9Zb/Eum+Y6Lp27NWllaP/+VmkMzaa7C0+FEv/AtwAoJkm1jt+FwGymvaymB2xj+nc69CWll6e2f36KX9GZk2UfIizV9+ieG65qfFhr3EH9u4EPV+HO3CHBpcvaTV4OSDZ8HTA/OGdtjSqJVPN2oW7flm60loY4fTzrf3km0Ej7UI9sx8Ev2JORNUvSc5S8do5iLkVut42O+IsTEtsmjpZpgRcA6GtrpzU6cDIW1ouXRhsBU21UKfRJXFoSCoWUf+RzG87kBUScVa/CNR+ReQKkhdeKqJiju81gttujj0NQWxmSI73PthioOdjRSFjyvx46Um8Dd87BgwOGJwyWKRrpr1Z93ah6wjwsligELIt6hIKCgdPwuySp0V6Ml4bikDPXl77LRBIgaLLsNd11bOrnKm7XSTPNQCrADGJKRirzGnGJQUlqkjrGcPwixJuy2VZhY8++5zswT9kFVLtwc55+WXiGRZVPSJwE1jTjxKlAbtgPFS7z+NsG5Z9EVIUVZDB/4MDX5YXnCkWw5uH7ErxmhnflEsb6Gnenlpoy4LL5WFe8tKffUCSVotRQi/q+8MVGag7ZAu2JpKRukfFqVAlBfeOTj1jY0=
Received-SPF: pass client-ip=57.103.71.68;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 11. Mar 2026, at 16:15, Anirudh Rayabharam <anirudh@anirudhrb.com> =
wrote:
>=20
> From: Aastha Rawat <aastharawat@linux.microsoft.com>
>=20
> MSHV supports PSCI 1.3. Expose this version to guests.
>=20
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> ---
> target/arm/cpu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 4b1e9750e6..a0a018a8cd 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1157,7 +1157,7 @@ static void arm_cpu_initfn(Object *obj)
>     if (tcg_enabled() || hvf_enabled()) {
>         /* TCG and HVF implement PSCI 1.1 */
>         cpu->psci_version =3D QEMU_PSCI_VERSION_1_1;
> -    } else if (whpx_enabled()) {
> +    } else if (whpx_enabled() || mshv_enabled()) {
>         cpu->psci_version =3D QEMU_PSCI_VERSION_1_3;
>     }
> }
>=20
> --=20
> 2.43.0
>=20
>=20


