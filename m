Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB26CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYvg-0006rq-JC; Mon, 08 Sep 2025 06:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYvc-0006pb-U5
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:16:52 -0400
Received: from p-east1-cluster1-host3-snip4-6.eps.apple.com ([57.103.91.29]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYvS-0001Re-3U
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:16:51 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-7 (Postfix) with ESMTPS id
 3023218000B9; Mon,  8 Sep 2025 10:16:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=wiZW7rftnpzvn1BVfH92/dT2nJc5YtLb8ooBCb9/qDY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=kgIIE+3/GvJPQU4fLV+mEZQjBNHSls886uT7OFsdbgNItqEF0RDBxOsiKW9MQNIqdiClo23yKcZXQMHIh8ryAnQZ0198nFJi5q7Ag1R1GSh05oV9keQ1cP2mt+3iRMl7xsoX7tPG5AiGA25lnw0eyaPHJno80JNMaE1aWDWIiZIiyBHPtHZo7vA7HkiLRwJMG4OZjfJF8XAlt1zhMqslm8Y/pDxsJ7UPIs0hbAtlT2T8t1SIOy65B14qXz0fNQFmY8eWkF3TwXrQqGvwHuS6j3ciM68Fi8gWBXtcXOADU4DqCZ4OTOp2M0ll6anHMmSDwfBfmhmaM9t/EP0uzi+hlw==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-7 (Postfix) with ESMTPSA id
 72B0C1800186; Mon,  8 Sep 2025 10:16:30 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 10/24] target/arm/hvf: Mention hvf_arch_set_traps() must
 run on vCPU thread
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-11-philmd@linaro.org>
Date: Mon, 8 Sep 2025 12:15:01 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7284245B-7C8E-4F58-89D2-6C24C807963A@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-11-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwNCBTYWx0ZWRfX6HPjGMk4P+vD
 Rh8k658D6WuCp0YTIhOXFamFqDFj6hoGXQDuKKb3G7pAty8agL/BSvqxgrB33IhIZYbY3zOcjuA
 0DXXZtb3IyRNfOBPWyVOtnX3wyFVZafgSG2oS6OqJx/1Qzkqd9zTqICD7tC4shVoDI0w4vpBnBG
 e0TOdo60ZysAjNEKmavl0mpjGNm9sviwY8apfZ84NiEC+US10XooV8I+AmCpgvqf194t78DcSC6
 HYXcK5kaG3XBPvIXwKYNE8i5e/ID3v2FIs3u6C2mMSvlYIWlsdVvCpyH6RQ6cwDF4Al+Ss+eA=
X-Proofpoint-ORIG-GUID: udl0NJEAMGn-BlYTK-X2ArVaK9slI50-
X-Proofpoint-GUID: udl0NJEAMGn-BlYTK-X2ArVaK9slI50-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1030
 malwarescore=0 suspectscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2509080104
X-JNJ: AAAAAAAB9Px5oCzkvYFV7DXVIFOeYjy1TumrztuH7atZG93MkcBdCewvBcyBno1To1FQn1InAYIr5r2OHvNAdFye6YBlp82E/W/I7vxiKM0WHTVGsTnGfKrmuQgqcmWNrL+bbyIyzJHu+p/P8oADrk/5kqCKEaBnedb0TUSjS8GyXZK29HQkxBifavEv2OwC0MSG+8z5B8kDQHFMRFDF8oYCRYEzOiekogA371SPeh02wtKEKBH4l96AvTf4TSlDfz1rwwtN8m0la2WsknDRWeFWFg9W3fQoS7TslseS9PhDOQ9NRQ6n4Gpq58umi6V2OqeNyCkD2Nf2554K6iT6ZlqGHks149XA0YR2sRwAQD9gAT0qd8M24Y4zcd/ak3gktbfbkT9C0iTIFUzPx8lBjWaIWIehV+xCAkpPXyO+XF/D8Jr/Iw8ETM9SM5ETKFwV6I8X4gfbHFqzNLY/yYNVq1b61RZu/hvfTqkrmr5L0ChpjZB/H97qOCFYEfmUszBH/PAdeXWmRm7a8LIct/Zl5dUlEvCpSLqObtkltlQH1fNdpLgDkqMHrBLkTkeQHL3ZPo+GMR7NBVGyuQQlRHHb5zbHl67+1AxC73wnb/bV7MMWLKcwwBATpzVbVyzsQjSL2zbWhCODo/TEz3knH6W3bvVMGxs4vIUxx3SM9EMTZeedgKjKD2qOCH7rs34jw4N0v4VcazZCkphAbRTnJb/I57pJB7sZaxMI6//rTMY=
Received-SPF: pass client-ip=57.103.91.29; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> On 3 Sep 2025, at 12.06, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Since hvf_arch_set_traps() calls hv_vcpu_set_trap_debug_exceptions()
> and hv_vcpu_set_trap_debug_reg_accesses(), which must run on a vCPU,
> it also must. Mention it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

