Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B620F10854B2
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2026 22:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1XGt-00040p-1l; Sat, 14 Mar 2026 18:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGr-0003zY-GQ
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:45 -0400
Received: from p-west1-cluster3-host4-snip4-2.eps.apple.com ([57.103.66.75]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w1XGq-0001WT-0B
 for qemu-devel@nongnu.org; Sat, 14 Mar 2026 18:15:45 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPS id
 C97DF180009A; Sat, 14 Mar 2026 22:15:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773526542; x=1776118542;
 bh=YQagLCwFmO4F67dvVU7R6YOfqGT2OsNatNHouVOdmCw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=J/0oATE5vfUc1dSuu/bqN98MtbcRfO4RRwEe6D1pq9jxjkXUBOrsO/Qb0k0/E1kH41TwKCq9n/OKbR+L3gMb3KIMAd/a2b1oqrqBCDNv5zjBbH1lDzm9TBmjkfT0/cJ8ONydQh/ygHM2NZaOOaP2LPlPYT53StItem24RYv5BB9IBFDUd6vAVnrkAw7BEQPro+77f6U7Rc8rfqgwf1vRAXWHxpxxYr+dusYvA1G0Ccr2Qb5OmIBQ1kisdZ/096n/unDwRQHbpK9s1hmnnob81vY6Jrg9u7P94+gnP93Plk8w57XIVFe8rnWjbk8dME5+7Ockyjr0d2rhX/tKYGaHuw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-15 (Postfix) with ESMTPSA id
 0270C18000A7; Sat, 14 Mar 2026 22:15:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v3 4/6] whpx: arm: remove comment bit that is no longer
 accurate
Date: Sat, 14 Mar 2026 23:15:27 +0100
Message-ID: <20260314221529.47841-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260314221529.47841-1-mohamed@unpredictable.fr>
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDE3NSBTYWx0ZWRfX3NHnzT/sODKA
 rj8l68Yq7ttVsKav+Wx4Ck5SqKzEw3kT8t1V+sFpPGpQorO5yeY0Z5hxs8cJUcG0NP9gf0AeZ73
 gL/sJov3Wh+9hTEHUU4CNgNyOqICRuzklqXWNyY2RgMsuco/zXvGBqpFGo++FnwhGToMORgF4fM
 4dvFF7eeIK9onvsx+os3AsmZ3pEnMITrkE4vL55eXySRGiPhDlLrQlbfJiREbLI3v3kg3aPfxpL
 IgBaimNn8xQtGFYfPwsruJnPi6qF5yup4v74frOy6bqV4fcJYpWnjSyRjSRnCy2GFHq1k/7v3fm
 uq34Fo2gOL9kW+EZ/ek2ItCFe5/jCVmj7tTBh3kTfTP16/KOiB+YCE7t1aw2Hs=
X-Proofpoint-ORIG-GUID: JxjPYNIRk1TRWfN9-yE_RBlm7jxyK2V_
X-Authority-Info-Out: v=2.4 cv=BIi+bVQG c=1 sm=1 tr=0 ts=69b5de0d
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=91AnuRma_Mvq6p0JRGsA:9
X-Proofpoint-GUID: JxjPYNIRk1TRWfN9-yE_RBlm7jxyK2V_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_06,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603140175
Received-SPF: pass client-ip=57.103.66.75;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As of Windows 11 version 26H1, SME support shipped. However the MIT-licensed headers aren't updated yet.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 9e5bc03a21..8aa24f2adc 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -717,7 +717,7 @@ static bool whpx_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * Work needed for SVE support:
      * - SVE state save/restore
      * - any potentially needed VL management
-     * Also disable SME at the same time. (not currently supported by Hyper-V)
+     * Also disable SME at the same time.
      */
     SET_IDREG(&ahcf->isar, ID_AA64PFR0,
               GET_IDREG(&ahcf->isar, ID_AA64PFR0) & ~R_ID_AA64PFR0_SVE_MASK);
-- 
2.50.1 (Apple Git-155)


