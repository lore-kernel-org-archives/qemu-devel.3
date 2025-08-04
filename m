Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CDAC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 22:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj3M9-0005gA-6a; Mon, 04 Aug 2025 18:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj3M7-0005df-9s
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:08:31 -0400
Received: from p-east3-cluster3-host9-snip4-5.eps.apple.com ([57.103.86.88]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uj3M3-00036c-S8
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:08:30 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 A0E1B1800124; Mon,  4 Aug 2025 22:08:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=n4hRRamurj7kPsOOlJEJ1SVIB5MDEDrqG7nh3u2wjcM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=V0ji6iS/POWfrlxzT5NJv5VBsDjcABSYD5jQbILKX69xsGH+p4anpjTgJPbqAER739X60Ez+1dWOZcLtQXIH1A9U8J5WFWOl1LYbRmONQSBl2BpPthpY+6FADXqa410QP4QzWEHnb3vTT2ogyA2ZJACkmbPFAU9KDK3gol581y3hjD4bfExuuQjhTxw4Jg3xkb2bz2JuJEai5xwHiBsoNFnhPuFPVTeSqr6OSntSFyQszlgXJyxq7pIH7UNv//Cs0+AUj8PLeqPG7xz0qG0L+gOYRWyE1XrjNjZvzfXmQpCTMAxiALIdzHkxD49P2sbGo9/O1TCd/BtWEPbpoyT9Dg==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 9ED071800139; Mon,  4 Aug 2025 22:08:19 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v4 09/17] whpx: add arm64 support
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <de952126-10d3-4562-b3c5-779483eeaed1@linaro.org>
Date: Tue, 5 Aug 2025 00:08:07 +0200
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
Message-Id: <F3EA0A07-D4DA-4618-BA34-A999066E5496@unpredictable.fr>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-10-mohamed@unpredictable.fr>
 <de952126-10d3-4562-b3c5-779483eeaed1@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDEzNSBTYWx0ZWRfX4ssx6eileP1b
 DMoDBktlKLdZCEH5yiLx+a+CaRLz/m9IEz0cMZFQGlZXMuh/qNkatnBkZGoVbuAZljnhkEyza4w
 pOYCpeDxPepziyyUx8oZED+rQz5DuVS46ygdYs/AhHTv8xcJcigL4JahlBdbxbIqWHEv9KwNbbf
 TrJeutunfq/O9c1v79x0l9UJ9mN3dniMA50/BWtiKNa30Q9chmpiqkjVJX2T4UP/wSn45BW6GSM
 PHZrFODfrqVx41GN1JYPOQ0rKbEKpINkgIrNzh8N0nuNDtXxXnwuewUk5WWsZaEfvizFiTMoA=
X-Proofpoint-ORIG-GUID: nJpEcX1XaKI4GbSWqKW1HRliFIWN-e35
X-Proofpoint-GUID: nJpEcX1XaKI4GbSWqKW1HRliFIWN-e35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_09,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508040135
Received-SPF: pass client-ip=57.103.86.88;
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



> On 4. Aug 2025, at 23:59, Pierrick Bouvier =
<pierrick.bouvier@linaro.org> wrote:
>=20
> On 8/4/25 7:23 AM, Mohamed Mediouni wrote:
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  accel/whpx/whpx-common.c    |   1 +
>>  meson.build                 |  21 +-
>>  target/arm/meson.build      |   1 +
>>  target/arm/whpx/meson.build |   3 +
>>  target/arm/whpx/whpx-all.c  | 845 =
++++++++++++++++++++++++++++++++++++
>>  5 files changed, 864 insertions(+), 7 deletions(-)
>>  create mode 100644 target/arm/whpx/meson.build
>>  create mode 100644 target/arm/whpx/whpx-all.c
>>=20
>> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
>> new file mode 100644
>> index 0000000000..2e32debf6f
>> --- /dev/null
>> +++ b/target/arm/whpx/whpx-all.c
>=20
> ...
>=20
>> +    { WHvArm64RegisterDbgbvr15El1, WHPX_SYSREG(0, 15, 2, 0, 4) },
>> +    { WHvArm64RegisterDbgbcr15El1, WHPX_SYSREG(0, 15, 2, 0, 5) },
>> +    { WHvArm64RegisterDbgwvr15El1, WHPX_SYSREG(0, 15, 2, 0, 6) },
>> +    { WHvArm64RegisterDbgwcr15El1, WHPX_SYSREG(0, 15, 2, 0, 7) },
>> +#ifdef SYNC_NO_RAW_REGS
>> +    /*
>> +     * The registers below are manually synced on init because they =
are
>> +     * marked as NO_RAW. We still list them to make number space =
sync easier.
>> +     */
>> +    { WHvArm64RegisterMidrEl1, WHPX_SYSREG(0, 0, 3, 0, 0) },
>> +    { WHvArm64RegisterMpidrEl1, WHPX_SYSREG(0, 0, 3, 0, 5) },
>> +    { WHvArm64RegisterIdPfr0El1, WHPX_SYSREG(0, 4, 3, 0, 0) },
>> +#endif
>> +    { WHvArm64RegisterIdAa64Pfr1El1, WHPX_SYSREG(0, 4, 3, 0, 1), =
true },
>> +    { WHvArm64RegisterIdAa64Dfr0El1, WHPX_SYSREG(0, 5, 3, 0, 0), =
true },
>> +    { WHvArm64RegisterIdAa64Dfr1El1, WHPX_SYSREG(0, 5, 3, 0, 1), =
true },
>> +    { WHvArm64RegisterIdAa64Isar0El1, WHPX_SYSREG(0, 6, 3, 0, 0), =
true },
>> +    { WHvArm64RegisterIdAa64Isar1El1, WHPX_SYSREG(0, 6, 3, 0, 1), =
true },
>> +#ifdef SYNC_NO_MMFR0
>> +    /* We keep the hardware MMFR0 around. HW limits are there anyway =
*/
>> +    { WHvArm64RegisterIdAa64Mmfr0El1, WHPX_SYSREG(0, 7, 3, 0, 0) },
>> +#endif
>=20
> ...
>=20
> I understand this comes from existing hvf implementation, but I can't =
find where SYNC_NO_.* defines are supposed to come from (including on =
hvf side). Any idea?

They=E2=80=99re just annotations for developer use so that readers of =
the code know why they aren=E2=80=99t in the list.


