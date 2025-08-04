Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C9FC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 21:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj34D-0006i8-7T; Mon, 04 Aug 2025 17:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj349-0006eW-HU
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:49:58 -0400
Received: from p-east3-cluster5-host7-snip4-7.eps.apple.com ([57.103.86.198]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj348-00079F-0s
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:49:57 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-8 (Postfix) with ESMTPS id
 4617418001EB; Mon,  4 Aug 2025 21:49:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=D0VcgbntvXmoHBUyQ0HsTLH3GjKUHWCII+4sCV9anAc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=GQGQ+zoZkbBKAVhfAim8ZBiD9ad6fbvifJjd9v91SNufi+vZIRcVXZfsTwETuQ3iphFpgQmf8jqQg3KkxeEfirNMSJK3Bxga44AGGauxHoaBkOBzzIKRmpyZkSTaTlLMgkK23Wgc6DnCaelbsmdsmverJqgne7cQ7j8TNiyLQtz4xLHQ/stihpDqB9Ygo+7mWffMstOA6Wnp2NoRKlqrP17UlKA8mWx6TiJU7xDChc+WgEaurVsrHtNqev/67QLWol9u95pL8kzwy78nhta+Zx0s4mObM7DfHYVk9b5r651UnQHc2qr/x+6jsr+Oz2Est9SEb86Ka4GLAkr2vajwNA==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-8 (Postfix) with ESMTPSA id
 41ACD18000A8; Mon,  4 Aug 2025 21:49:49 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v4 15/17] whpx: arm64: implement -cpu host
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <4182240b-59bf-4bb3-ba73-e5c4216608e4@linaro.org>
Date: Mon, 4 Aug 2025 23:49:37 +0200
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5B6EDCE-D9C5-4F8F-9D26-86E153F6C6B0@unpredictable.fr>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-16-mohamed@unpredictable.fr>
 <4182240b-59bf-4bb3-ba73-e5c4216608e4@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-GUID: Wxaf5J3yKeuTWTUYMrgLJFEA3-45dN2c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEzMyBTYWx0ZWRfX6yxphPqOeySV
 8JJBA1v7iOyzumz1p8uhVsDrZ7yYjoCcxBRknGztzNm+Eka3uc4mBVbPGw2Rx4IBp/1e3LYhMGc
 VhH5qj7Ok/HLGEn/if/BCT8e/nbe2FTJxkxqoJrdfDjkGw+NOdHWYqbzsjrPjMF/22tzwdDDdPa
 d7mTYfZXsvdOpgh1pjFfwvdaM+XiRghTURHv/cui+LqXIObSUcJLEQyFph4yWmnhL0iT7zot3c7
 iv3DHccc5RXtiW78CCYZ85V2hvrPm55uOJKG8OJ9gMNN9mU+892TA1+lM7q591SuN5FkhaCdY=
X-Proofpoint-ORIG-GUID: Wxaf5J3yKeuTWTUYMrgLJFEA3-45dN2c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_09,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2508040133
Received-SPF: pass client-ip=57.103.86.198;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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



> On 4. Aug 2025, at 23:27, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
>> OpenProcessorKey and ReadRegU64 adapted from:
>> =
https://github.com/FEX-Emu/FEX/blob/e6de17e72ef03aa88ba14fa0ec13163061608c=
74/Source/Windows/Common/CPUFeatures.cpp#L62
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  hw/arm/virt.c              |   2 +-
>>  target/arm/cpu64.c         |  19 ++++---
>>  target/arm/whpx/whpx-all.c | 107 =
+++++++++++++++++++++++++++++++++++++
>>  target/arm/whpx_arm.h      |   1 +
>>  4 files changed, 122 insertions(+), 7 deletions(-)
>=20
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>=20
> Additional question, what is missing for SVE/SME support?
For SVE it=E2=80=99s mainly about the state save/restore part. And =
having good hardware for testing it too.

For SME, Hyper-V doesn=E2=80=99t support it yet, but done preventively =
so that it doesn=E2=80=99t suddenly get enabled once that happens. (and =
that scenario happened on macOS and promptly broke things)


