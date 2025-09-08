Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D6ACAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYuv-0005E0-AW; Mon, 08 Sep 2025 06:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYuZ-00050N-CY
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:15:51 -0400
Received: from p-east1-cluster5-host7-snip4-10.eps.apple.com ([57.103.89.201]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYuO-0001NB-Rg
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:15:47 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-4 (Postfix) with ESMTPS id
 0ED531800219; Mon,  8 Sep 2025 10:15:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=yJMidEk5wiFaPVHBwo+RNVqxs0dtzwjMe7SbeWbMTvk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=UoUBYRVchuaAQZN/V3S9bN3zg9jeoTrpbkBRHvnct0pLN9wHFVlDngQXOyWjaoxizIyiVZUqDQh43V9aGVzFi8tzW6wZ7WeRwZGMK/h1NVTyp421ERf9JXOcbdBGLfxvsOKITwdYdBfmL/uDAmLUGV1Nkg+UsuDh1wQOWZiOa3tBdmMmLYxl9rvtvJ/+PGNw0x6QfUiPW0wssVyTsrFCJ8ldDtnY/cLKh0rxSRNDRtnSrUsUgNesc7YofECTO3vRg0PlirVIZ5/LN+b4tb/NmQ2cmTW0IlBDr6noKaD5GynycPsrL2Ar3LB1smujJHbLwmTc9AwIkk/n4IQjcYBPkQ==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-4 (Postfix) with ESMTPSA id
 DAE4B18021C7; Mon,  8 Sep 2025 10:15:20 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 11/24] accel/hvf: Mention hvf_arch_update_guest_debug()
 must run on vCPU
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-12-philmd@linaro.org>
Date: Mon, 8 Sep 2025 12:15:09 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A7CD30B3-BD92-487E-B524-A6051EDAB6FE@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-12-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: E0SwCEoQbE1E6P3GWH5No9zdk48RYil4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwNCBTYWx0ZWRfX3pIN0622aiiY
 zh70dgyrzEYVPAIPUMPb36aWS5lCbmt9k2zXgwmRTWbdqQVphrFjGulEeMH4/EgLrzbsuds6LYH
 tqDNqL8SdxAVG7oxbZCJuFkdoGCo6U+Iw5jDDGnhWBX1SEK9BnpYS5j9MycKxOB4119cLtNXyDB
 wK7jWRr2vkqmE2EtSLxQ9atjzMWkdtHhOqjsh/7+HVNzWQFIIUCX6yF1DZQO65Kry/jDe2YkuH7
 x3iRWZbo/tUyIETjoyTNUex8x2wHd5lSbLm8bgnp9oknmz4dgyIpwUX//cWM9/hB0oR2fUTeI=
X-Proofpoint-ORIG-GUID: E0SwCEoQbE1E6P3GWH5No9zdk48RYil4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0
 clxscore=1030 adultscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=919 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080104
X-JNJ: AAAAAAABUBy8wN7AmP/YDGYgf4q3waxfyt+NKWAKoHiavnJxsJXHYYNYusUY+SgN72OkDH3vkgHIX5WXW+AyR5eKAh60SYnv5v0Fdg4K57EYJjizHuPAp/i6joBQ52XW0WScXfiXfiBkg8gHCht9OGG9RgKcAFweT+nYmTWVy38anIN0BMO+MOsa6rGhxHIl678/cNMm221dVZDvgwSyTa7yrkCpbqKMKiHB/EZ/PjIrmHLl9voC+1GbqOPi/lDRbi8eQ2dmh2N3Foq3W4nRKkV4rghtCWdeFUtiMjMy5OisQSs6XrsdqlD1/TuHv2Yb233dRk+bvzyeC1pQJnCLtjXgtUHYIyWdIAfhgKPZ+JtHp6fVSFZ9La4ZhbzCs4sG9q0ZjDWRPx1CAjmqfRI+KTPSOtpdqdfe7m4hiPqCvpwsUaZMavQgkjNH+/gVS3eQ1gKbsMm9TX9fVfxPGV1Bea7LyOYjN6ITzwraGWkPkRCgsRML8zlnyYgS6EOmpnme1eYZYSkMgxZSYQKqyYYhrmxh+hPvOVxdaLSsUtrr2B/tlzQD34qC26IpcURVBtCMX4jC9EaU4lTpCeZMvIOpw4qwithHoRoMLQ1pOxSap4QFcY86673wBLfjb2xnNfplJoj7SjENQPtI/uDCfrzyWUMxF8M7X6Ac1KlzfBqr8AUd8DUaW208Wd7J8AByfWisZWm2do0cXgaaW2vPJb91LElHALIMaNVVNaNnu8JcqlToGR1sJW7gf3ze9c327gV/is0=
Received-SPF: pass client-ip=57.103.89.201; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Since hvf_arch_update_guest_debug() calls hvf_arch_set_traps()
> and hvf_arch_update_guest_debug(), which must run on a vCPU, it
> also must. Mention it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> include/system/hvf_int.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

