Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A5CCA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYwA-0007P6-Qt; Mon, 08 Sep 2025 06:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYw1-0007FE-1K
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:17 -0400
Received: from p-east1-cluster7-host8-snip4-10.eps.apple.com ([57.103.88.83]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYvv-0001Uj-J8
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:16 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-1 (Postfix) with ESMTPS id
 3EC9018020C4; Mon,  8 Sep 2025 10:17:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=CbWo/lKy2ZE+lS5eXQPdvDbVqc1KV/Sm1xufJOU6lS4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Q3NiX7AAFs2wzlL1BceJESJhv/fhqY+ogsk1dErJ9Bzyb2MEUIkmDscwCt32l+2+I1YbEnYEG/ZY+YxwwkwVFf10tWHjQGV1T1NTB08Qglyl/rp4U3QHdu659xWgKhGZZWTouIqK/Eg3FDk0Hflgs11udu30FR9EkuvLbFi3tBFKVs7obMI6QMkiMKYG9NatLwVAT7VkRP24u6gn1WG4RrF2RLiT8V2swdA1Q9P6XuXVYFcJ9YvYO5wWNEw6QPdaQWO0Bs7kSSQLWsnxZneqPEP7PoXyGrvWhqqQtbbzVUtlPZyfO80ZJoSVIsawYWGshAZjRBoZJzKAicdjUG+Apg==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-1 (Postfix) with ESMTPSA id
 47DAC18020D8; Mon,  8 Sep 2025 10:17:02 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 04/24] accel/hvf: Rename hvf_vcpu_exec() ->
 hvf_arch_vcpu_exec()
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-5-philmd@linaro.org>
Date: Mon, 8 Sep 2025 12:17:00 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F1C5A4F0-F0D6-4E6B-A9EE-5498346C9F2E@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-5-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: VSgn3KsNan0Ov-amgzmOUHBOjQW2kJXj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwNCBTYWx0ZWRfX73Ep1YKXclic
 yP+xu7bChOGan4XH2EA3rZ+7AKv2JwLvG52BmP0jjQY7Djs2/9HrdPD0IJ+sjuoiYClUfmXmaMl
 9wrznJwV/FaYQUFZ6SSlexxxs+q7DGaA0X8OPGZ/N6Gg4QjgI3dPvwHUAwD666aiI9yh9/fPQA9
 V4g8nTi3Ti1OYRLKrwzb6+ZfqqOd+YLjsEIwGqrKsDddYITYYcr8WvPCVdgfg8lRtk78C5WkHf5
 Qqyhq0SzUDn5g4B06H+JpijXmlPbHStRk7QRHeetVZ9ixdr/uY563RY1l6J1UMJjnRqiJMjG8=
X-Proofpoint-ORIG-GUID: VSgn3KsNan0Ov-amgzmOUHBOjQW2kJXj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=949 malwarescore=0
 adultscore=0 clxscore=1030 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080104
X-JNJ: AAAAAAABIvMHl0Wh6DLxuiLJ1GJv9gHk25gl9h3Cz6pgP1HMv2Ia+3nSu+9z/LpU7UZK9GgBVl1ltgZZ/UkqLD7UVPIIWoQXSlqfoikaJDlyfc0PEjY0szaJxok9yRHBHRGSLTwJFHCqeTrXUf9R7UmE29FpbMEOsNYOer/5LTjTBIbiwoMtRF0N63ybSQ97vtIF+4SeFaYLmTeocc8B8N4K3x/mZ2xnRYoCocBdfoATlxoRDGuVqkxUxnkSLH4k6OUCJ3V3Eziv3ZFsMt4ii1+k+7654N8THCJiz8Eq6vGiByUaspVJRSUVMJSZ6D7fczCBUpjt7xai8m8Vfb73nYgpALGWEf6iCYsdzYErwfpEt/ZmbdcI2Ac0+4gySso75u7MSPk5oCIkGb8KrwsbV1CgolX44+bsL+UvskBCaf0pVMHRrDueU7D4eN6IFPNbaPOeWpwMe2tt2wHiFIBwTw96c7lrr7LQMtDs+96MlVgIkJSP02boMplN77BhIoBdSf6GEXcMxfMgyclrgptr/IKHudRtSN6JmK8qg79+ydbIIECR17qgwj3H/NIhC8cgetzmRfevQPtlM+yrHmnzpVTGRb8bXnuNWkN9ugPUU3seftAe03GBMvtGKWxwE5da9tVMaJAxZPVpls8DtrYh6kHscuDHfioemitcwfFtV36GYFkcPtE0pLaUjJ2tk7Zzd8dXUW2IU9XBGH6dk/Mw463gvDyz25lG
Received-SPF: pass client-ip=57.103.88.83; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
> hvf_vcpu_exec() is implemented per target, rename it as
> hvf_arch_vcpu_exec(), following the per target pattern.
>=20
> Since it calls hv_vcpu_run(), mention it must be called
> on the vCPU.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> include/system/hvf_int.h  | 4 +++-
> accel/hvf/hvf-accel-ops.c | 2 +-
> target/arm/hvf/hvf.c      | 2 +-
> target/i386/hvf/hvf.c     | 2 +-
> 4 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

