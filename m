Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADEFC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLRh-0006ug-Oj; Thu, 17 Jul 2025 06:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ucLRd-0006jw-0u
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:02:29 -0400
Received: from p-west2-cluster1-host7-snip4-6.eps.apple.com ([57.103.68.89]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1ucLRb-0005U6-3G
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:02:28 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-2 (Postfix) with ESMTPS id
 103DA1801647; Thu, 17 Jul 2025 10:02:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=mCswh9ebOHY2y2CUP6QFDoqKtC8t4isLF13aUJ/uoF0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=C6NLBQpDEIxHz4dagUiO+03MWwNJfQSZbBLBKHBxPkhjo6vUVCSfBGuKSsEhPa378CrN9er+zUB3K+XmuhEK81se9nDB9GxB9uMAi8olumuSeVg4AXRZlk91KhsSrk0uycoqkCetTs9DQtvxO8JzcSXwKhfARQrwhlXhufkG3yPfeM1o43Xl3pVcvPBpXU4caTmF3o8UGQchbGt83VfAGwRXEmMumB9dLaTWPA8hLRImkVXg6eYocnOOTcTobgxgWkyqTMqylUkgL0g37lUreOoVAau5Cx52ZTQBSt4Rso3bFY27Jnu5WbH9iDiVcCLAr/C/Ll5cWMo91zt4zRBHSw==
X-Client-IP: 194.62.217.67
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com
 [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-2 (Postfix) with ESMTPSA id
 1838C18000A4; Thu, 17 Jul 2025 10:02:19 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH-for-10.1 2/3] accel/hvf: Do not abort in
 hvf_arm_get_*_ipa_bit_size()
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250716172813.73405-3-philmd@linaro.org>
Date: Thu, 17 Jul 2025 12:02:07 +0200
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C83D054-528E-466E-9E00-1AE1179E8DB7@ynddal.dk>
References: <20250716172813.73405-1-philmd@linaro.org>
 <20250716172813.73405-3-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA4OCBTYWx0ZWRfX9trxClqUkROV
 21nkoWHusKcEHsH7jjR8H8NwmAkA89DslSXEDVoITLuHhD2iBQ93eR+oPoXnpiWsL/vcS/kzkdl
 2zEsUbdHZ1QEJWgdtulZO+BaJvfBSCxzdrRpudmdTmzu0han5oooI6wTjNVOgpk87JqNrTmiHcm
 m6P8SxMigHfoQT0/c6kc37mXRiAq0w9ZbyM9XRUqc6u0SNdGdFYoA/4yGDz8w8jhPKI+fd+n+TZ
 XHC8jSPM/3jMjf3m+cJiRpTK0jj6g6pwKe6rZw+ziYYyK71jSHawR8q/W9KkJ3cpD3CvIhV+w=
X-Proofpoint-GUID: bEwb1a2ux0Cu4ZuEGdkNF3uTKNad2I87
X-Proofpoint-ORIG-GUID: bEwb1a2ux0Cu4ZuEGdkNF3uTKNad2I87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=849 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507170088
Received-SPF: pass client-ip=57.103.68.89; envelope-from=mads@ynddal.dk;
 helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> On 16 Jul 2025, at 19.28, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Do not abort in hvf_arm_get_default_ipa_bit_size()
> and hvf_arm_get_max_ipa_bit_size() when the IPA can
> not be fetched. Return 0 (and document it).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf_arm.h | 11 +++++++++++
> target/arm/hvf/hvf.c |  8 ++------
> 2 files changed, 13 insertions(+), 6 deletions(-)

I looked up the different uses of hvf_arm_get_max_ipa_bit_size. There's
an unchecked use in clamp_id_aa64mmfr0_parange_to_ipa_size, but I guess
it'll never reach that far, with your changes to
virt_hvf_get_physical_address_range.

clamp_id_aa64mmfr0_parange_to_ipa_size is already surrounded by other
hv-calls and assert_hvf_ok, so either leave it, or assert ipa_size!=3D0?=

