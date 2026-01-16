Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E95C79FBC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkUq-00048R-8z; Fri, 16 Jan 2026 09:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkUn-000480-S1
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:08:14 -0500
Received: from ci-2004f-snip4-6.eps.apple.com ([57.103.89.59]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkUl-0005iE-LT
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:08:13 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-3 (Postfix) with ESMTPS id
 F25E51808DAC; Fri, 16 Jan 2026 14:08:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=jJoHx/Mhvm/zxMA8bXgWR6u+noYEGO4SREi+yWQvoOc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=RWux8A60eyXyxSe0aR83soIBfp3bk6XlM/x5XB23IzZOwjB1Q1HUsNcjm6Qkwd/re31NoDKIeF4iUpOuf2/JJ8yvWZ6YEbFvOFK28386+jRX3vvMuRiKsClLX+ios6+1HLLq0ArGNnCvJnM83Mpf+9mqeIaeGfQ+2y51AH+bbil+OyAASW42MZAl5tGf4pVLe3w388TX3t6zEjKAypDNEY3AVnOTWAqt3Jt7Z/F9q7i1wBvoLDJiXz3I3ijfLbXV0MbrlW66HbmW1NYaroGjl4yoBicSBvr0rTz0EKuOXNIOFOnUE6mfDsow/mMM0qPp9SKYlKmFsyIYLz5LOkyK0g==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-3 (Postfix) with ESMTPSA id
 7E9B518000EF; Fri, 16 Jan 2026 14:08:03 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v16 00/26] WHPX support for Arm
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
Date: Fri, 16 Jan 2026 15:07:50 +0100
Cc: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE1347DA-26A1-4B37-AA0F-5F3B5F530E96@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
 qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-GUID: i33zMLizJjuJHvCdptfwFj3yDXXSZuQI
X-Proofpoint-ORIG-GUID: i33zMLizJjuJHvCdptfwFj3yDXXSZuQI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5OSBTYWx0ZWRfX7BA9dAePsuk7
 8joWEyIVvTZkat7YCSzeBAdL+/3X/ybAkYVGKYU12HpDvDvC66NQVCFgWQ7XRJAPlpUqvbhHJAW
 zAGlyrXOOeVDzFisrKCMgBDLOM/HokEroPGQgRCaWJrJ2WgYyP32b4V6HU/AbI59tvhAnjxCMfX
 IUjuV2tUBWYkZrHYA16BDWnWu5GRCqJ7QIAfthIqhzd/QDFFqOw95ywwgsKR5nHRPH5aG/+kdiz
 /VFewXBVJqSQhNfsdPA/VozGyXIfZjIPe5NxHbNdfxvVb6Wr2ZUv89N8JiAbu/if17kAsEk8ETp
 EFKlABk4Ogt4JlDKk1k
X-Authority-Info: v=2.4 cv=dO+rWeZb c=1 sm=1 tr=0 ts=696a4647
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=bntzG4cGu6g-np6Cdj0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxlogscore=723 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160099
X-JNJ: AAAAAAABI4BkpaC125M/OpJ27uuvcESFAr348SQ4XXlnB7ULZjv/Z1EDPwSShZNdXLqa/tnBCJhDqNFgNdwg5CmMl+od0wIZyeLtdUNJqrcxwO3VF84T5gN2F1o+3Atd80jhz/vnbr9Ru+UoiQ05YOnaXt25PEWQGQbg8hiVPO+GUymylTtBzpIBBCUGwiGDwAYPIIoz7MyYxmwkGJqb+9kUL2W9+JCUv7zzuf9Od5DQwm9kqSkEdWVcHWD5VEPVAX2heM9wrG1ZfPvGKznCwJAewa5KG/tQOpguMqJDRJanQR/z4juKy4DNOyYv+95mcC+snv7kQPjlL3i5KTYOfgNgQx1AJqIpW0vq/XulK8AEw0Xm6oUpAnTpn1eiFT7RXvpOMqbC/n/RA7FWaEiv6QCz7RYgXsn6nSMMy8QdDZzhTOi8z4HHoV8WAj+qGI2Lpg24Gcyw2BM94yLUiQWNTYwrRoKsg4KFuDpejKw9vBdpVeKpmksZwZwooA0vGO/bGEU/IFdNbGKCbeWi93ASa2iRZkrjFT8RY1AnI9Ky02P4eYAX9V0MxL5w4cI3zyrUVSfYJc41yzcjBQdskTtckb9jyyy4ynHp+0lwSHDVabQZgMt058dfdAcAaph4OmLnzDOXQ75hfqvoSVOfuigm/0L2VVaok+ARgXV0tU4+DEsUbyheOb7KirvIC/5NPF9uDgysUVE8LF5/h5ePWVL+GZXY81wwcG+bAS37/9i0o3hBSHbR4O1QB6tKFC+4YOFCQS+2cvmYi4w+2motkQq2kdmSLjgBxmDRspDX+/rKEEBkIr2dtg==
Received-SPF: pass client-ip=57.103.89.59;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



> On 16. Jan 2026, at 14:52, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Link to branch: https://github.com/mediouni-m/qemu whpx (tag for this =
submission: whpx-v17)
>=20


patchew tells me that this doesn=E2=80=99t apply on top of origin/master =
right now but does apply on top of origin/staging, so this should sort =
itself out soon-ish




