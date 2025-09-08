Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D97CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYw5-0007IC-QM; Mon, 08 Sep 2025 06:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYw0-0007Ep-2s
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:16 -0400
Received: from p-east1-cluster7-host8-snip4-1.eps.apple.com ([57.103.88.74]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvYvm-0001Tk-Oe
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:17:13 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPS id
 0DF1C1801CA8; Mon,  8 Sep 2025 10:16:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=kmR5rG013JEtb7kKaT0cSdmRPXWwAJtgxolRJBBQWjw=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=gJNLW17kCzeF5Z6BFPNLu4CVPNG0b2AdoF+ld0k5RcG3/rWxzp94oe0oPQfWPQQB9jtYykXzDAZmHBuvj20FQz7i6YofYfYjLQYv7AAdNJECOIO83kckkgtlnfe+bXNqDgMyT4xxeWDFaKyjHs0EPRG7fe0jEle96tipRL1CP+qBnYS6sh+9Wln8nVnIYFggJVJczOmNLOLu0HuML0gf3b06c80XHkef0APcyfVmvaghevZoXY3ZARU8vEvzgaRzsyQKwzBHL985XtA56Q1IPkVsANYE27Vuhs6Xm8GjGypoo8aTk4PWsyxS0GZCFAPh/I3m1Nwaa8DYw5kM8cGz6w==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPSA id
 1BD821801C91; Mon,  8 Sep 2025 10:16:53 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 06/24] target/arm/hvf: Mention flush_cpu_state() must run
 on vCPU thread
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-7-philmd@linaro.org>
Date: Mon, 8 Sep 2025 12:16:51 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5DA7F6E-9334-47A2-AE0B-CE21931DAB13@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-7-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwNCBTYWx0ZWRfXy3l0x05kE7n7
 hKjh8STu0F2OQTp7rOgvC2MRcEXqjia0ayylq5Kmmd/HVVN8vk1Tc+gCQzOcRqAcdu2WijRWxXj
 nwNWCgMKQ1444lck4zbuFbkuUx9Zqv6/imCA9pEarG8XMD2RdXZCJtsLGyTIXXMq5mLrt6sb3TO
 sxdu2NW79wDwTHPJqQ5Q8H2BLjJdL5RwzH07hbVDM5AGPyqU3OZ5XDkpGWpgZ7oOTNHLT82bs/R
 RZUH01XSE5oQ2z5WmAILDTblRAbhvjUXd17igLJpE4VhivHpR4jcScaYqyF7N7mu3g+LKle1Y=
X-Proofpoint-ORIG-GUID: 8EvhDQthacB3F4xOlV6X7z9eNFvqK3SL
X-Proofpoint-GUID: 8EvhDQthacB3F4xOlV6X7z9eNFvqK3SL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxscore=0 clxscore=1030
 adultscore=0 spamscore=0
 mlxlogscore=736 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080104
X-JNJ: AAAAAAABGuuzoXZwFOHo1ppOEYe0T9zdPQadIEVzfvxvA1nFr43iyrsHYXywKu4xuEjAExF7vy78mv4MHQ6KDryZWpcw0N1DmpsjrUo6yUzwlVYpZ5zsq7/aPZ3+KUm0LEtc+lkczCikIq24pxBiVh0mY0MJsrUY3vM2J+Ij+kCsbZsYMYWGRfL3MsMS6WptogZUeM0sYJf6rjF175aVWuf2wsF41T7jm0aALVN8bZwolAFspLpOtSCE8icg0i1kbHeR+29hF2/R7XVq43x9dia3JkE8/o5ZGTl2IpO5ObcF/bSOw2BaH+kf4LIF9STRGMc6TgA2SVNwnOgGRV1lo+P51riahmBTI6yr2jDq778HIedbkV8nsVL6MF2q3Ri0T9iIbBf3nUU4M/eNtx/elY7sbvaLjvGX5revhKI5oDB8ByKVdjHPuoLqG3IVoRQXYY6NGcndrQfQLkoliHdsuIVYuSF8jqCuHDzT4o1uFAo5/HmE+SJzRMAnc20hjzHCI3Yq2ITlzYVfz+/c3QXjcfg9Sb98M2j+ZAkBP0nxNL+nJetrTyi0AzeSxt3pFnZUVhwPnQkC3W2EAzYEa/fW9S9Eq0dcwis7l0Eh7DtrTxM2DO6tgxzf8Kx7qFNq5PAnGsyGXKRjhLiB7yqW4Q4KZ0JUDdIg2ax2TaRIDP/W2pAjcq7932Z9fq0OHqzJGvhQWsFs5m9L7z5ecBVq93czD+ukUTdA46SZYNdi1Xw8tbCW2w==
Received-SPF: pass client-ip=57.103.88.74; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
> Since flush_cpu_state() calls hvf_arch_put_registers(),
> which must run on a vCPU, it also must. Mention it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

