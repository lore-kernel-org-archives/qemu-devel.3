Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB33CCA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYwX-0007qM-1E; Mon, 08 Sep 2025 06:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYw8-0007KB-QW
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:24 -0400
Received: from p-east1-cluster7-host2-snip4-10.eps.apple.com ([57.103.88.23]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYw0-0001VX-7K
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:22 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-6 (Postfix) with ESMTPS id
 F04191800227; Mon,  8 Sep 2025 10:17:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=WvGPiAy7brD0Zjae05EmRIxLe3Tdl9IRKCjUIXxqhW0=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=TIfZq1/MPMv0HTgkYgBpaOL0BrkodBtAvB68i6Qs1FASPJGqjz3gmrQ/R/wzWQSmPWKciA2Zo+KsZeKKwHiwev9jKSUsL42Pm1baaZ7VL3uhJFZZ7lt4Tken+fdRUKEfeyYNjqIDZsj6XxXPANAYGA6pBvIy6PGMc/D9RWbxjRDhZ7JTnctXejvdSyFdKZx7hHnwYRLiG7zXOoOncJj5TNncb+KSBT3EZIXbqHNxegcGWjnHUuzU54XufFy/zT/2VW+486uphTIrz/F6U/rP+xWygiRh3KC+i1OGZwblDILgZpeZctmontju0DZDwzigKIUtLB4Ev1SlhXugqoIkCA==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-6 (Postfix) with ESMTPSA id
 EF08618007CA; Mon,  8 Sep 2025 10:17:06 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 03/24] target/arm/hvf: Check hv_vcpu_set_vtimer_mask()
 returned value
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-4-philmd@linaro.org>
Date: Mon, 8 Sep 2025 12:17:05 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <63EA8ADA-614A-4257-AB14-13AE52306E6C@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-4-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: IYX7QWB3RHHssjH4s_la8LSTvxsibM4z
X-Proofpoint-ORIG-GUID: IYX7QWB3RHHssjH4s_la8LSTvxsibM4z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwNCBTYWx0ZWRfXzwRhlDckTtYg
 jckxeOujKV6nf/oLi3YxROGSAYiXz0MR+p7EzfyfTrFGEAW8OQc3tJDw5wN93PrZlrgIaxZZ7b3
 PwmG8k577gbgkMr1rrCvtaSXoXnFQ9FYw/5U7fBv+NPHW0jvNsB7rVGphGDf+iEAuPJso9w6k+n
 0x7Eik4vuBLT5SH8S2OQQ4bmYl0BU0c35RJSMaO6Jy4tkdD9hk0vrNV8XPuUWo/FZpie/v9QHA5
 Em3Rb/Pqd+vIDcAagI5aq0zd4RklszZwHYn727qh9YxuX2vst6sMW2EXL0R9PP1FHX2mFP+k0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1030 malwarescore=0 mlxlogscore=769
 bulkscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080104
X-JNJ: AAAAAAABASzn1YnTgYn5NQEGz1EM2eu3W5zNijPQ3UyFybSbR2Oo3YuJX2emduZK2Tu9xhNB2hWJJYl3CTUP0ZmASKIu32cPwCDOAsjoxnjP+yrJm3ZkUyposkH4TCljTXnIoublWTsQIg0+BftYLc++0SC2jTe8ytt6o6iR3wSKlARAC9VaK63bXA8hQkYKZ2myOpFxeumCvBS94qdr+zGoYRxs+JubkWPebl1GhD2q1DVpmSdhaEy4N76Fifl9T9WVTNQYnWJOXwwgecfBH2mk+zFX0/ZgSuHQ4p/i7+c7z2i9t5L5W9GDL6bWseiYiSWMYlH2H85+aN1osiE2rjY8z6MNnC44yBgEfK4RmsbgVPFmPa6Lt1604GU338yw4WIYIIYYxhJrdjek1FFeg29Dw14w49uCuGeciLGGzj4IRlHOfC7iyHSNQLqQxwh3dV9NG1WcCis9ewAHqIj16RUnGTv2k2fWiZfUlcodcwX2WgVbE6710scS3WJJeqzOjwNWDo3zhEOUZtgzT33v3vVzdjPB8t/RT0qeh3JSRtd/GQ5hLDzWFYKctGlD2WmEHQjh+LorMX1TGZiJn/S87R9xsn8n9Po6T+mq/Qtag5ZITdq5PIgglgmTZyPuq/AvMIDh6Id2m+lhXF8X9cdstl7m3H6jiGYI2xDWT0FwMY1jQNC2dY3K8lMD610S71eAn0APS6/KYWo9ENxODXpzehQf5olZ9OjozkXjdnuPVzu9ARrYAwYz7oM=
Received-SPF: pass client-ip=57.103.88.23; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
> hv_vcpu_set_vtimer_mask() returns a hv_return_t enum type
> (defined in <Hypervisor/hv_error.h>). Assert we succeeded,
> as we are not ready to handle any error path.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

