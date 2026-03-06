Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE130F01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUfR-0006d9-7Y; Fri, 06 Mar 2026 07:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUfO-0006cu-0C
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:52:30 -0500
Received: from p-west1-cluster3-host12-snip4-3.eps.apple.com ([57.103.66.36]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUfM-0005Yu-1H
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:52:29 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-4 (Postfix) with ESMTPS id
 B216318000A7; Fri,  6 Mar 2026 12:52:24 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772801546; x=1775393546;
 bh=VKiarpPWn4SDFb8GnIawhshkjbI5X447KDdHUVZ0sZ8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=ePicUP2iEtMYR+BJiTHrOjPU1PFMcWBRq1NH19ImG633xoMYP+TDcL3K6JOmt5hBtJar6prvYj9znjJTV2xpxBG0KJIqAtI+nNeugrYuwNZbyDWSKIj898Yz3yoMtQtuISlqn6iqs9pQFWodVrsG/ARXwWz8c9CSuvAUd6FgED12zp8zU9akE0RwRntaAwOdgBCtQ6JhdZQgWv+W4hSRgaWWcOV9hkDba6BX/VOPQCtEyVD/rNKBpfhmonCD9jKcoD2cUymcUpKWic3/o6r70/s1bozbKATVriDtpDwJgRpkbJuym4Ayi2mWYjUn4KvxAStflLgk6LkqSH/Zvl0IeQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-4 (Postfix) with ESMTPSA id
 612A41800224; Fri,  6 Mar 2026 12:52:22 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v7 0/2] arm/hvf: Add SME2 support
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260306-sme2-hvf-v7-0-e72eeda41ed3@linaro.org>
Date: Fri, 6 Mar 2026 13:52:10 +0100
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AEB372A-013D-478D-82F6-F5C0E288CB1B@unpredictable.fr>
References: <20260306-sme2-hvf-v7-0-e72eeda41ed3@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: H0DBvL4ubImwTe1YoqWAGLP3n9EMNRTP
X-Authority-Info-Out: v=2.4 cv=GpRPO01C c=1 sm=1 tr=0 ts=69aace09
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=nfPvrw19EpdZ7zV4emMA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyMyBTYWx0ZWRfX4ZU+JeCWdZ9R
 iUE9+9oHiCxMUKfJdPIyEmueH/R3Xd2EwfT3QP2CyE9ipIpVDiTdo3eTFiFyh8qx/M9E8kREfBn
 ZUgyoTcG/U32cJb86WY1R7ilq0bUjLEW8WkPhLFRWgtMCS3E6QFuf03dNtd5gPfBnIKssuEfuae
 39aC96uXGpnwNcasXLtq4HVNi80WFWgbWzJF5nlcp3O7WtNh/dhwxQxSoJLwkd7/IDS5OxoAiQB
 q+hFRsnYnaNCyfEcytUw9tjNe/WuSCKL6sB/n/iv3dfHMqrEBpA1LlAIyotMZNMTQCjSnfhiN/w
 WbHLBGhQ9r7G+d0BB6k0jBbriQKhR0WigJPKGi/4nCmwXwU3KEcVUp/U2axPV0=
X-Proofpoint-ORIG-GUID: H0DBvL4ubImwTe1YoqWAGLP3n9EMNRTP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060123
Received-SPF: pass client-ip=57.103.66.36;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 6. Mar 2026, at 13:45, Manos Pitsidianakis =
<manos.pitsidianakis@linaro.org> wrote:
>=20
> M4/M5 Macs support SME2, and HVF exposes this functionality in its
> public API.
>=20
> Add support for it in QEMU.
>=20
> This was tested by running an SME2 benchmark from Arm [0]. savevm and
> loadvm during the benchmark's run were used to verify migration works.
>=20
For the series:

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> [0]:
> =
https://learn.arm.com/learning-paths/cross-platform/multiplying-matrices-w=
ith-sme2/1-get-started/
>=20
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> Changes in v7:
> - Set ID config registers properly
> - Fix build with non-clang compilers
> - Link to v6: =
https://lore.kernel.org/qemu-devel/20260303-sme2-hvf-v6-0-b473702d8287@lin=
aro.org
>=20
> Changes in v6:
> - Remove host isar adjustment (thanks Richard)
> - Link to v5: =
https://lore.kernel.org/qemu-devel/20260227-sme2-hvf-v5-0-1c60a92910c8@lin=
aro.org
>=20
> Changes in v5:
> - Fix NEON registers getting zeroed when loading vmstate by setting =
SVCR first
> - Link to v4: =
https://lore.kernel.org/qemu-devel/20260227-sme2-hvf-v4-0-3dae31a1876d@lin=
aro.org
>=20
> Changes in v4:
> - Set cpu->sme_vq.supported in hvf_arm_set_cpu_features_from_host =
(thanks Richard)
> - Removed two rogue lines that were smuggled in by git-rebase (thanks =
Mohamed)
> - Link to v3: =
https://lore.kernel.org/qemu-devel/20260226-sme2-hvf-v3-0-ea5763dbeba2@lin=
aro.org
>=20
> Changes in v3:
> - Rebased against master now that it supports SME-without-SVE setups =
for
>  gdbstub
> - Link to v2: =
https://lore.kernel.org/qemu-devel/20260115-sme2-hvf-v2-0-2eca481bd7ee@lin=
aro.org
>=20
> Changes in v2:
> - Added stubs if hvf 15.2 headers are not available (suggested by =
agraf)
> - Link to v1: =
https://lore.kernel.org/qemu-devel/20260114-sme2-hvf-v1-0-ce9599596736@lin=
aro.org
>=20
> ---
> Manos Pitsidianakis (2):
>      hvf/arm: handle FEAT_SME2 migration
>      hvf/arm: expose FEAT_SME2 to guest if available
>=20
> target/arm/hvf/hvf.c           | 334 =
+++++++++++++++++++++++++++++++++++++++--
> target/arm/hvf/hvf_sme_stubs.h | 172 +++++++++++++++++++++
> target/arm/hvf/sysreg.c.inc    |   8 +
> target/arm/hvf_arm.h           |  41 +++++
> target/arm/machine.c           |   2 +-
> 5 files changed, 541 insertions(+), 16 deletions(-)
> ---
> base-commit: 483cb5b74cd247b1520e0994b4fae4d8fe44cb00
> change-id: 20260114-sme2-hvf-105767189521
>=20
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=CE=
=B8=CE=AE=CF=84=CF=89
>=20
>=20


