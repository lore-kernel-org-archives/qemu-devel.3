Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EAECA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYwY-0007q7-U3; Mon, 08 Sep 2025 06:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYwI-0007Xh-JE
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:35 -0400
Received: from p-east1-cluster6-host1-snip4-2.eps.apple.com ([57.103.90.133]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYw9-0001Wu-JS
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:34 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-9 (Postfix) with ESMTPS id
 A49991801FEA; Mon,  8 Sep 2025 10:17:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=Pg/farx3xzo9K3HwfjqCU6MjNcJpLqh/iQDwewzbGYo=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=IbCoO3Xm5IynoPC+DTspokc1D4Sh0ojJbKgNG70jKLA+IEJFxqEwjF2Ygt0DUs1mwMbuPn4QW2tfqYQvwdZpNynPSN8xYl5dISGwft54m/CGOP4i2Vz6lhVJK7YfqPIzH00l3jU6DZ7eliB4BKs9k9T+hLcBslA55a1z6BzoQuCQf84IRHFZwxXHTtwRmgZ/Ept8Cu1rXHEakoH5KMTxnZrCKGx5L2Z5XGOYzu/mtq4rltD3wYl6beZfdHn4w+chBWsiDohOHP6lpcqKfZpLn49j3h1r8EHTsGGKOh0Tvx+ff5dQzMbQIwmoioxVjfo+IqiSRKVJiAdzTrQJRHUKdg==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-9 (Postfix) with ESMTPSA id
 9EEE21801FC4; Mon,  8 Sep 2025 10:17:16 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 01/24] target/arm/hvf: Release memory allocated by
 hv_vcpu_config_create()
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-2-philmd@linaro.org>
Date: Mon, 8 Sep 2025 12:17:15 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0887CA6-204F-4051-8B3E-D3B546056297@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-2-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: cVrD8QocYxWVNx8rcOQLScy3TdqkDpy8
X-Proofpoint-ORIG-GUID: cVrD8QocYxWVNx8rcOQLScy3TdqkDpy8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwNCBTYWx0ZWRfX5lr21h6w9wEs
 gvgw/H9uIpx+S9ToxDKcbsc1c65efE8IPnKJERsKn0KyvUDZP7J/SZ7xZ2uda7zaLrImTvTlcca
 hvEgmQB7lF0Q3IXBK5PZNwV87oFT40crYMrLhtWDzoQkVBto4W+K92ariXdHRHQjRIy6xVnm41T
 DmUEt/coRFfskR/EIg7Y5b0O1nkTcw4HLywt0w3yodfaaE2xOepQZTU6Mr9BzMK7CDKum3a8Znh
 L2ER6y45CifgwtTSs0R76sM+C7DcquOu2CdWrXZH+8yB5kRol4+FKgNyAdOoxIojcaWS5KVik=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 clxscore=1030 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080104
X-JNJ: AAAAAAABvpKVDBihe9SJOK4xmVkJxQIdZaD2DdT/t8/E5R6NfXRlTL98FjKHzwdGQVX8UKX+SMqCPNbdOhkQ5/SvES8v/fgDX8qi2iusPsUxTabRhlu5ymVRSzUSuesQQorJPKatR8TYYukK0xylhKXnKlgy/PRtcxPwC0tG1oMBCj8dq9G5jIAHJUkPtDy1Q+pT/HyceAuGhVrd9mEkvij4cszI6300M0jZxC8Q1cGBs8kbYU3mCzkPCQTcCdLSB9eKaH9/wJ7J44UnFGgBh9NRbg8vfQkHGouOnhLgyZ7Ci5w52zM4gx/m5ixkHCiownP+T9ZID2QJKt+7+fiqSuzDfc7dDUQNhiYVNa3bb45C8dhzggcmww+LDewIbGDAUXjmcLekp/Fx/VB4Uw5+4IQvgOjA9Vdn+FyqWmcgXObeurkiC9mtbHiEMfAtAEY85NxUkp2L8au40+FiYnDom22W0vWbtnO5TWMXQdpoBx/xiYy2s3S5b+n/jwENy7wQSURQ0fOU3eTzpodbTC4BhBd4tXyACF2Nok5dbonMMxlpEZizNHiYcmJteNB2FUKbXlhHFznlJ4I1HLaAcSEGdnOCbR8/10TqsM8K/qSi6n1/1kT2Nfokb1Ldn+voQ6+CVVRHKa9eEyrP6gZsvKf/+61tLEXrmTxVzc+qDqmg1YM0fNWfNGNJOMAgyj8pgLBhxwfZ/JTeTTpco/b5vfoPQoleB/4Z+D0=
Received-SPF: pass client-ip=57.103.90.133; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> On 3 Sep 2025, at 12.06, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> hv_vcpu_config_create() is documented in <Hypervisor/hv_vcpu_config.h>
> as:
>=20
>  /*!
>   @abstract Creates a vcpu configuration object.
>   @result A new vcpu configuration object. This should be released =
with os_release when no longer used.
>   */
>  OS_OBJECT_RETURNS_RETAINED OS_WARN_RESULT
>  hv_vcpu_config_t hv_vcpu_config_create(void);
>=20
> Release the memory allocated by hv_vcpu_config_create() with
> os_release().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

