Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1CAC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 08:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4ErL-00054V-Hx; Mon, 14 Apr 2025 04:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1u4ErB-00053E-RC
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 04:07:56 -0400
Received: from p-east3-cluster7-host2-snip4-5.eps.apple.com ([57.103.84.146]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1u4Er4-0003En-0S
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 04:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=d+IXLMoawXqX/xjHW2ZgqT+C1iQaEI+DOzSb9WG04Vg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=jukc+wKCWyKwyo++K+D16oo9ApqpdsW/JjsDQLrIy6H9q/hJw3Nwq9YxNys6UMCo5
 FvhP00PjJ4Q4lFdh+XTjuYgpSWiVYDmh+ftO/PR8VVlS+wJanVjOkIt4WtEQbgtiVQ
 vyspHZcB6I6VPeufD1T2fNes6FHgRTY+zhnn4X7nzs9fx2flzsph+z7+hyX72dwCkT
 STZoX81z2F0wjOwXiaGpg2rCfQSuBApqNqyW3VM/LW7r5uQL0aUknoMhbotVN0Zvgl
 NnX3/2i1LFTrWwHrA29ZbLFGxplo6rjFyu63yVDTwiyqK6DF/UT4Yfkco9+gpw7Mr3
 QsPqYZxuF7xUw==
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id F20D118005F5;
 Mon, 14 Apr 2025 08:07:39 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 0/2] Fix GDB support for macOS hvf
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250402135229.28143-1-mads@ynddal.dk>
Date: Mon, 14 Apr 2025 10:07:26 +0200
Cc: qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <m.ynddal@samsung.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <13247C25-632F-444B-BAAC-648490F1B4FA@ynddal.dk>
References: <20250402135229.28143-1-mads@ynddal.dk>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Proofpoint-ORIG-GUID: AHtOJgL35LJa09qbRarPzhSU5FAaVtUf
X-Proofpoint-GUID: AHtOJgL35LJa09qbRarPzhSU5FAaVtUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=707 adultscore=0 spamscore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504140057
Received-SPF: pass client-ip=57.103.84.146; envelope-from=mads@ynddal.dk;
 helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> In (recent versions of?) macOS, calls to hv_vcpu_set_sys_reg were =
failing if
> they were issued outside of the specific thread that owns the vCPU.
>=20
> This caused a crash when attaching a debugger through the GDB stub.
>=20
> This GDB stub has worked before, so it is unclear if Apple changed the
> behavior of the function in a release of macOS.
>=20
> Mads Ynddal (2):
>  hvf: avoid repeatedly setting trap debug for each cpu
>  hvf: only update sysreg from owning thread
>=20
> accel/hvf/hvf-all.c  |  7 ++++++-
> target/arm/hvf/hvf.c | 27 +++++++++++----------------
> 2 files changed, 17 insertions(+), 17 deletions(-)
>=20

Daniel Gomez and I have been using this patch for the past two weeks. It =
seems to be the right fix for the issue.

=E2=80=94
Mads Ynddal=

