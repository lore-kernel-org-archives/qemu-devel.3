Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B0A1125842
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LnJ-00018u-09; Wed, 11 Mar 2026 11:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LnD-00016G-SK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:48:17 -0400
Received: from p-west2-cluster5-host2-snip4-10.eps.apple.com ([57.103.71.123]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LnC-0000xs-7Q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:48:15 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-7 (Postfix) with ESMTPS id
 16D1F18003B4; Wed, 11 Mar 2026 15:48:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773244093; x=1775836093;
 bh=iCDaR+K5iHrrYDGxKKuv5RtglRZywOBNFAtbm3wakco=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=dpiVl8oURZfT3F7j5iqo6TP+Ip6yCI4SK+qJGzkB38RvUYueevNLNfbmpedsmq0mL1vZYgzm980HE0hUD3dAtrWLi7yKL1S9E9Q4ivhZ5eLhwm/R4QqTA274OdljaFUBgq2AVuaPxjLWnCqPyw3QsT1Q47fufYQNZY72NHKaO+Fjg39U02uPAxHlZi6nyj7VGD4gZUBFo4oZtPIOYTHiqS4MmS+UKYBg8mNto9i1oaSm7LEEgGDiO5RFocQ/x2tUgIxNKH8DNuehAKpJpFjGGz/i+MrVViUYxSCBk3nobkNLyxCtasPmZMiy0tf/ouEtqt1kKeY8fp0KPf6QOHJ+hw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-7 (Postfix) with ESMTPSA id
 76C4D1800586; Wed, 11 Mar 2026 15:48:06 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 02/14] accel/mshv: move msr.c to target/i386
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-2-c31699b7bc1f@anirudhrb.com>
Date: Wed, 11 Mar 2026 16:47:56 +0100
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D360968C-7F55-4B59-B111-4DCC2FA36C20@unpredictable.fr>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-2-c31699b7bc1f@anirudhrb.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: m3ypqHLPGUx-CP-ACe101SXvaS1E3cw9
X-Proofpoint-ORIG-GUID: m3ypqHLPGUx-CP-ACe101SXvaS1E3cw9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzNCBTYWx0ZWRfX2zqa7iDrhNWe
 CfpwY1JfxSwuF6YA2ALiB4z7xLc3Ts+t2ZfCnZIafmJBvAB0pVl2XSp2stiDPgxj5ArX58ceAuj
 HYkjnkwTzuAPn3+QGNXYsIsNgut7YO3EvU4BJ7rztLpNPyjTFmRqnBU/6OAE5x4hvoAxdUPvani
 nH5eJrk5DInMHHJJMeyPNp6cJhN+0mUl1HlS3Spmd9ysWHBmsxkejo/2utd98CewIKst7TiFk8N
 MzqrGES/swuJZ+4o7GlpktEOkJ5k8J1Vg1XsYLMUXZ81TWrw5pRXJe1j92m6xM+SjePUJese2aQ
 l3RTsqG8WRHAbgW8lPUfxKffJIRT+cegWTxnCoALC+9yGQHnsRyEEjwER4qBzY=
X-Authority-Info-Out: v=2.4 cv=Hf4ZjyE8 c=1 sm=1 tr=0 ts=69b18eba
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tFGNSmrwAAAA:8 a=yMhMjlubAAAA:8
 a=JYufygBZZNIU-1FwLxcA:9 a=CjuIK1q_8ugA:10 a=LpD6Tdepsyerr7eS-Jg7:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110134
X-JNJ: AAAAAAABHaH4fPH0ytNNRnqnCX+rJtNUHEBWKfI51btd8dzqzTX38cDHDzodjvHuy6boVGS7CTedS+yuZg5in7K8YYu05jY0mopWPy9VzRJRFWwKBa3wwgHWmK0ZBLxiaqyg1NFI+IKmuCh/tWflcZSRCvUlBIZzaa8awTlkdKosnJZvt2NxSjKheQIuKP4UmSu5DM9hWN2oKMJCQKximDzHZZZu2TByRRk8mYLuhCpDUCtTbTk+NHCH2TNDtpx8Qk4NZd/RFM+0U7mdWn8gGTgb3uiOj580t8QsDTsCWqRs01PknVCTloh2NBtGsSxjcO66AM6gp5/qc+HTWMB9o/2zPg4lr2OesVlMz+rHkwSLOYfHp99VcmhCLfdrAlAUSiBLSlsGflUFc2eaxAYxWLrwn+fxTzuB9YwI6D981sZ0xs+WzC72R3n4JZw5YzGeEpfgHgrgc/mkLSTEgEbzZZUPsIn+/AjCltfG9NHkGNoCP1SlZReApysD+deewVa/g1KEQUZcHnbudNM/4uq2tolUZE0TPOrE6lLLWmW6vTC/PBJSKWAZ4qGvcAloQqimaj13G3kb9NxoSY6az0Zz8iRKWscPQDecsCDM5DSmelWUinjOuyNrIUtbCUEpIz7VwUaH3v4Ddb37t6bM88cbrgDj3OmY/kWRNKdbFyJg/eUcRtbuqTKe3aSTHKtFzL7Y3tpfAU+lg+Y+WO4h+ByA+lWkYB00oBAbcbvaQOeT5Wg6jg2dWkMGI6qPH1pSYg3gifyP3ZNj/egZv9PSfPsCk0pp5PlBP3evre1JT1Ifpm87Kc4Unug=
Received-SPF: pass client-ip=57.103.71.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
> This file has x86 specific implementations. Move this file to i386
> folder in preparation for ARM64 MSHV support.
>=20
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>=20
> ---
> accel/mshv/meson.build            | 1 -
> target/i386/mshv/meson.build      | 1 +
> {accel =3D> target/i386}/mshv/msr.c | 0
> 3 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
> index c1b1787c5e..e433187cde 100644
> --- a/accel/mshv/meson.build
> +++ b/accel/mshv/meson.build
> @@ -1,6 +1,5 @@
> system_ss.add(when: 'CONFIG_MSHV', if_true: files(
>   'irq.c',
>   'mem.c',
> -  'msr.c',
>   'mshv-all.c'
> ))
> diff --git a/target/i386/mshv/meson.build =
b/target/i386/mshv/meson.build
> index 49f28d4a5b..6091c21887 100644
> --- a/target/i386/mshv/meson.build
> +++ b/target/i386/mshv/meson.build
> @@ -2,6 +2,7 @@ i386_mshv_ss =3D ss.source_set()
>=20
> i386_mshv_ss.add(files(
>   'mshv-cpu.c',
> +  'msr.c',
> ))
>=20
> i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)
> diff --git a/accel/mshv/msr.c b/target/i386/mshv/msr.c
> similarity index 100%
> rename from accel/mshv/msr.c
> rename to target/i386/mshv/msr.c
>=20
> --=20
> 2.43.0
>=20
>=20


