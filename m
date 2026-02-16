Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AD4E63F2A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 04:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrq9V-0007c0-Od; Sun, 15 Feb 2026 23:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrq9U-0007bi-A9
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 23:24:04 -0500
Received: from p-west2-cluster5-host7-snip4-5.eps.apple.com ([57.103.71.68]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vrq9Q-0007Q9-VA
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 23:24:03 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPS id
 EF6F618000B6; Mon, 16 Feb 2026 04:23:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771215837; x=1773807837;
 bh=ZUANVoxjvPiHSDhH9eAlBvPxH8iR58Ao9x9uaxKTMLE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Vz0NQlew6ywPTi2NnYWFS3RHVpfdaePM9ih1EtdEaMm0JdNH7yV3aETUXQVl2psyCcwCihuZwXCRXkst1zK7364dDDcbNuOoKDe8/HOWWEHtTHV9jseFoMLUA1T3luaZBpfYn55+gO7gC0hPbxmu8099eZUJvE37MLRCGuj5EUI+Uh4bC0rz9Q4V+S7GbdlUwpvdgY0W640zCAzhuiqBBIVdwb6CaD6luEmnrPfcOIpRbFJogOgL2wH3n7LSbWYFhtpt8ADSI+4CE6U0KwwLrkDwTKkCeyEEWfFyPY2a5wfbHb9ZCROcbyUwFaiLTEJcFcMMyXyvKan4aWgB9W/Y6g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-6 (Postfix) with ESMTPSA id
 C13C31800124; Mon, 16 Feb 2026 04:23:54 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [RFC PATCH 02/13] target/arm: Remove aarch64 test for kvm
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260216034432.23912-3-richard.henderson@linaro.org>
Date: Mon, 16 Feb 2026 05:23:42 +0100
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D63EE934-C780-46F6-A944-0786463BE8F7@unpredictable.fr>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-3-richard.henderson@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDAzNCBTYWx0ZWRfX7IkZQM1CGBXt
 kAQ8sdej33Wa93LwtfxjcBYn2FnP+JkDEFdiqAw2J32h8Bn6Bwt7un+KiTEg/t8sEm21bwMATHs
 Buh3IIQNJBgHdtMKtQ5rV8ner3jH+rmLagcrUP0hiak7G6fYEyCWW0Gxme/2r6pMI+f6DTVtXHn
 1YWy5tRRVZ0SQ0mh8j36ijTpj+6+fuvW1x7Pk8tuREGOv4kuhLzI/fnLSyxOJ1rdBzPYoU+mo1I
 BGZN5ep8VWbTHfZP5daUOgzYbJAdPdjCX4TC2rqA+z/bSq5qu4tkC1jb4X8pfgBcGmFbhSo3obK
 ejuHl7p7myZCZGWlgUzDD8hvxXNFK7a/tanT6PIzITYGFP+hSSBQGvgWjTtqzc=
X-Authority-Info-Out: v=2.4 cv=FMQWBuos c=1 sm=1 tr=0 ts=69929bdc
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=KKAkSRfTAAAA:8 a=_RmgBsbcXBIpdXDbF5QA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Kw9Klj57eUXRtjgwNLh0Ne8onUbPtjvo
X-Proofpoint-ORIG-GUID: Kw9Klj57eUXRtjgwNLh0Ne8onUbPtjvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=946 suspectscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1030
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602160034
X-JNJ: AAAAAAABzEokOFs1N2zANZR/HryTLbLh9xnhcaAPcvdNbXquMrTIhkkTNraGhucPDVBSWgEyzFJiE9H6L0axZsUp0+7c1hrnfDqUEFbucTVvI+VA5vtgrqE2NV3V4kgPjfKCuEsY2fGCkovDKsMqHSK+BfA0LfD1de2GJIyMZs2z5VdIkPFQVi3sO9omWfmPzdkaraT/HyMN+0C3XxBFM0dSw+XYUuSAsqBX0IK74DcYsGVsP1OHPuUWqE/TLyg2Vxoki7JAMNdQhwDLqkEH5Yump28oF3g5pyUaB+PJuZ7LrtPD1eDv/Q6tZTLq9EtsO63t6ZF+n5U5zOzShiS+Lc0nPliM66ukbuuLPvM00HPvOo14PMi4/+f0HO3FA0kw4EqAFZnk0mSvf27ksNjQaZ6qGFbO6XwqFLOTttar1EKCZQTeT8P60I0QtyJ5TjCBJEHHczqqLWWk0Hi2ZI7KLgwaGSRGUlNdi5agDSRg7RgJYw8xpp+5UdXRLNlWJPA4hOiB4bOJ3UD6cO1U2bUUbDxREiGE0MyeS2924qENmKGNaE2xmCkCgply6hKC4b7S3eKvE+C+haZgIt4rOUZH/Qa1MClvP9bMu5RdETnFIHJ9Zw==
Received-SPF: pass client-ip=57.103.71.68;
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


> On 16. Feb 2026, at 04:44, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> We no longer support kvm for aarch32, therefore the aarch64
> test is trivially true.
>=20
Hello,

Probably harmless but aren=E2=80=99t AArch32 guests on an AArch64 KVM =
host still supported?

aarch64_cpu_set_aarch64 in target/arm/cpu.c unsets ARM_FEATURE_AARCH64
for being able to support that case.

Thank you,
>=20
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> target/arm/cpu64.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 5d7c6b7fbb..10c6796548 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -767,9 +767,7 @@ static void aarch64_host_initfn(Object *obj)
>     ARMCPU *cpu =3D ARM_CPU(obj);
> #if defined(CONFIG_KVM)
>     kvm_arm_set_cpu_features_from_host(cpu);
> -    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> -        aarch64_add_sve_properties(obj);
> -    }
> +    aarch64_add_sve_properties(obj);
> #elif defined(CONFIG_HVF)
>     hvf_arm_set_cpu_features_from_host(cpu);
> #elif defined(CONFIG_WHPX)
> --=20
> 2.43.0
>=20
>=20


