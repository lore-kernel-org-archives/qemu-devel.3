Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4694CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 11:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZbq-0003ug-5f; Mon, 08 Sep 2025 07:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvZbm-0003rc-HA
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 07:00:26 -0400
Received: from p-east1-cluster4-host11-snip4-10.eps.apple.com ([57.103.89.113]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvZbc-0007XN-RV
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 07:00:25 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPS id
 DFEAD18041AA; Mon,  8 Sep 2025 11:00:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=ZhcvMHIeLtSYdW7P/KUJmlBVtKauwK8EsDK0M+QAk8k=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=sWqZqhG1Toha0hCDqcgWuTZyjym5twWJmaoCi2wnXNVVJR3ELa7NuiaBXB7tWGOvZSMQfYMHzwh7cIXkJSfH71O+ZNFNjIx3hMuAZkuOG3bpvkM6fjVem2ZlMseSiRCnqlJmPgmorbSyn5nfo81k6LEh6mt0dEYoV/IyAik6DiuVu0kXdx/eRc5vGbR0p9Rka/8fLH0DcrnvvdAlrKYxYCLy4+zJD05Xa3iot8aeftPuMNhvl9y3jMTBQIEw20MV1+FZFNOkUZrPArBAfyIU3dkZccGQc20/4UoZ8jF5lxjU2eGAobSqycdgrDzoBtboU8xLFVOt0U39sMz/Ul+qbA==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-10-percent-2 (Postfix) with ESMTPSA id
 C924018028A0; Mon,  8 Sep 2025 11:00:03 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 12/24] target/arm/hvf: Mention hvf_inject_interrupts()
 must run on vCPU thread
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-13-philmd@linaro.org>
Date: Mon, 8 Sep 2025 13:00:02 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <28FD3EBA-5904-4ED6-8803-DDA6C51D1D9A@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-13-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: kDf3wwXH7nwmMi15Kr9Ud8p-rlh8abin
X-Proofpoint-ORIG-GUID: kDf3wwXH7nwmMi15Kr9Ud8p-rlh8abin
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDExMiBTYWx0ZWRfXx2ZluTbyiRhC
 HJ8QxJqvK86IYvnDEtCg0mJuJWA42Dt7w9RMnbB+oC96+eBohIx61TBXkbZ+kbSQ9viH7sCxhPa
 xKSCzs0MgxBjhOk8O6FNOMsp/BgOGIagVuKzw1k5ALkw49XmEKP2mjlSlwDBhkUfd59bg44jbhS
 Dc70qD1k6B5mXS+opF+Gia0jn8shM4Xiw1tRIvfVE3PX/GDL7RoM2uF0Wbz9/zRSW9pZikNFgEo
 RbeGzNQGWLK865Ro0WahPemafEukk30/euhq6AXLiIkNjmGs5U4qA8eIO0cC/s9QhtASkshzA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=760 clxscore=1030 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080112
X-JNJ: AAAAAAABd7nN5T+/pmO6W1VJefeRJbW3Jzg/y/U79dJbhD/qyuY3haTjtvmAxGH13Art7P1t4jqDrUooIcy+98eFcc+lemGOvBfv+lQ29PsaQbNkcPhDY4WxMu5mD3t4ggj0UKzLPQcdEtTE+T8DiYnup0HNOCgbx8Dv7iG+i6wH+euAriOv5gzYfZo0+dQSPrgy6B80VmEoZBcNkuyALC4EQnzptNzgNCKERqGRwOLwUyfikVZSx1m24YySzIuRNK9IVyrq35aEqJIiHs1DO6TZY997ZRUM429z4RUxraVivvDux7cunv6cdQDX9roK//5O5q+jFFOL8wryvvJgznnoYmXS9NBIu4hpXJ0q2dz9Hivq0Qxs9aHp/bQjLHVyPPm+UyqV/A48er8ZBDNoQK9LuNoWuOm1kt56OEQSK+HOib3GOjQQGzW1MRJW0tK6OIQ2JYK5izX63Jw8Z0+OOyjhuWj9PFWYHDWyvInzYwb2i9pkziRdeZnDUPppNeHoayx/RCk8oiuDNIBP2bbMz5F38Fzxvw5XemcnlRI2Fa7ETWoooc2KqLy8IBbu0sKke7NSuc4unXuEKB6c+8JEJnw/ObnIea5WuSVtPOnG0iuC/Hozs6Ja/gVv5i9aCvJHg9D/lqgDOpRsnFEMkwraMwE597zjIhXmGK3dJP5JNiYnX/XZN0UzRAT6788xkKZ6RbCWR134JlqOzdP4tBrqa653b2Ek1W+A5ABtmjIUCJN3jgtpUPA=
Received-SPF: pass client-ip=57.103.89.113; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> On 3 Sep 2025, at 12.06, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Since hvf_inject_interrupts() calls hv_vcpu_set_pending_interrupt(),
> which must run on a vCPU, it also must. Mention it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

