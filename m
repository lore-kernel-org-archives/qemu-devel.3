Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7915EC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcmO-0007b4-7h; Fri, 04 Jul 2025 05:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXcmK-0007ag-QP
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:32:22 -0400
Received: from p-east3-cluster6-host11-snip4-2.eps.apple.com ([57.103.85.233]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uXcmG-0004HK-7W
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=9rEB08GrSiVE+mWLaqMpZs2n04R7skd7dXhDs5UY6I8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=w2Lqw+F6bxlrqGCYvmq8zo0WeLS3eRG69CjSsLO6LLcVikMY0oAvWusWaICebwIIA
 d/owEDdwYKFOEY0SEcGYbNvfL810oF6M5MtGN42owYij3Ws2awsWi0+Nl0MddkfcNP
 LrZ0YFuPb7i+f+o9qEAB10Zxzx+wH+h4PtJLcN0WnKWi3y88UMpG87gjjnhjVKJWiK
 zlTuTYY6v9hFvHvezvq3r3EE9oNHWhC7SQWqNMx3ZkyMHKzdsmecxnxJCtzGmhvktj
 qOds/ZxNTC2OrcL4t5t3ygKW1Q0cdqGuL8o/JxXxiz/Vf2qsC/V1fB19CugUajqSfv
 Gec9AHcyOFazQ==
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id 09BCE180016E;
 Fri,  4 Jul 2025 09:32:09 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id 1E2D21800162;
 Fri,  4 Jul 2025 09:32:07 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 59/65] accel: Always register
 AccelOpsClass::get_virtual_clock() handler
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250702185332.43650-60-philmd@linaro.org>
Date: Fri, 4 Jul 2025 11:31:55 +0200
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DAE33222-93C1-4B29-A224-7FA6A4F0344C@ynddal.dk>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-60-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA3MyBTYWx0ZWRfX7ooy855ftlpJ
 382CqUnUzm9dvWFlJ4w3bZfbYCF+MOcu5YUJKVmNOQpMuB4hfyDeyYm012SCcxKjAoJ2iYF5NSI
 uirMv84bFEsrokKwUyE7eZorMGGObQZQzT6Inhhr9LehDsMZ1d1NY+RZTif+jvTs5FmpsQI199M
 sVsCd61OOzoBpfVIKqo3XaY74UAmhzazAduwUmWFJZpb7RSDpO8ottAZc/q+sjsCWln8q7BT5rU
 oW4o1oxFfr5sSbP3gC5XOoUOe0VJ3zhCKD4GAn8XrRsTgOFSWSKtJrn77XxbyXc5UG5CdariU=
X-Proofpoint-GUID: yZKEds9rpVCqOGHR4JbLjQYUEdwGwxVu
X-Proofpoint-ORIG-GUID: yZKEds9rpVCqOGHR4JbLjQYUEdwGwxVu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1030 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506060001 definitions=main-2507040073
Received-SPF: pass client-ip=57.103.85.233; envelope-from=mads@ynddal.dk;
 helo=outbound.qs.icloud.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


> On 2 Jul 2025, at 20.53, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> In order to dispatch over AccelOpsClass::get_virtual_clock(),
> we need it always defined, not calling a hidden handler under
> the hood. Make AccelOpsClass::get_virtual_clock() mandatory.
> Register the default cpus_kick_thread() for each accelerator.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> include/system/accel-ops.h        | 2 ++
> accel/hvf/hvf-accel-ops.c         | 1 +
> accel/kvm/kvm-accel-ops.c         | 1 +
> accel/tcg/tcg-accel-ops.c         | 2 ++
> accel/xen/xen-all.c               | 1 +
> system/cpus.c                     | 7 ++++---
> target/i386/nvmm/nvmm-accel-ops.c | 1 +
> target/i386/whpx/whpx-accel-ops.c | 1 +
> 8 files changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

