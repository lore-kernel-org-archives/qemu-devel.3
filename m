Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDF4D58E4E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 03:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwttw-0004A1-R4; Sun, 01 Mar 2026 22:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwttq-00048m-3s
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:24:50 -0500
Received: from p-west2-cluster6-host7-snip4-10.eps.apple.com ([57.103.70.53]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwtto-0008JO-PJ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 22:24:49 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with ESMTPS id
 206141800171; Mon,  2 Mar 2026 03:24:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772421887; x=1775013887;
 bh=QTr9+DhQbA8z2ptcwK+NwgjYEPC4vv3DDRrzD0hRmz8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OQGFPoMOG45tPUcvHFqz5V2qax0aax8Ri7/VZOJ/oPm8I0n4j5Ybtx/nMGYyGlRtZluuJOnrgSp7Lx8AqBykvJFbH4K2KduSZQZHEjJ+QS9GE0o3KUMAfSWVt7Hfg2Omr4BqLWOaMvbt1n9Zrx0ardvLuG0O3zJvEvcN5D/kqTvgkUj7TE1nHQSRGvBv6dZqRxZKsAZOBDhMwT+rCItgm4xUCnIPGr1SesNKPKmwmKHD4DYNFzn+fyQIyoUyrCBMoPJi6qqzBE2PR5zHJSRw5GENT5bSxKS8z7ezIznvRCRbBmcLNqgsqb9rqPjwTndP8Nkxzt6yYiqukFhuLhU6Ag==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-11 (Postfix) with ESMTPSA id
 1872518000A6; Mon,  2 Mar 2026 03:24:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 3/3] whpx: i386: enable some more enlightenments
Date: Mon,  2 Mar 2026 04:24:35 +0100
Message-ID: <20260302032435.42698-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260302032435.42698-1-mohamed@unpredictable.fr>
References: <20260302032435.42698-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDAyOCBTYWx0ZWRfX67CGOgBXRilp
 vJMjeHTFLeKfWPxQzfU3pXgsEl51qEVqLfn4ENoD5m8y0s9hONri4CGAVdfxdfJyCnNaAVN7sDc
 K2QPP75WI64tiujQgJ8+LF9HNTbxCV3n3CvKUUpAiqw/NC8Rc21dA0DhNgpq8tQBA6OADw02tjJ
 B+I1+eTzQ5H9ul+oVN2UBouY+PgpmCRypwhiqzNi3Cf329aD4rB/OHn0Ltl1xUD19qmDUiDWdDZ
 TebI2ErKZMR6cgWo64zb62p465AkcKaCmwNbcKcl6L6j6PfNXWDdBvp+rhH/tbf576fnEr6CD4R
 jMK4HxeSyLzsp8lYghJcWor8GEAlzky/O4VPGE24r/ZjU4WN4iwv9JsMV9EVfE=
X-Proofpoint-GUID: 6UwK83FJjBVz7UqI2f88FVfhnSU-scTg
X-Proofpoint-ORIG-GUID: 6UwK83FJjBVz7UqI2f88FVfhnSU-scTg
X-Authority-Info-Out: v=2.4 cv=YbKwJgRf c=1 sm=1 tr=0 ts=69a502fe
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=lWQTlSF5RC17BzGQrLAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1030 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=758 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603020028
X-JNJ: AAAAAAABT/cVV45kfeorZ6r8z3cWs4CEhoCnSg2YiNkNrAt/tBM2+vywZMyElDtuF3rxvfUH/WpcPPTiVeXbbckGmNT787Ie3x3wftHwOWYo0Q8YE4bsqSF4cdn6zHxpOzreaynepxJNuR5+AFndS8WPxR76F4ih8ZXN6fFmNhrs2YYev5GghHiUybYUUNmRnYaQBig6eh+6GI3UDWQNoZYM8AKOy5sYgQPZC1paZA6WsF6yMXb+MD7iYhq7cApEpuHr0ZCMLPeDd4wGwvNcgS/1I6+6cXpIOX1XJWkvR0wfCMFvSrMHSqVWXuLV5Jw6tFuVuXpodkUPxB3H+MERmUZPu5dkwnxlFKjwFQdOUHaLl9zdYa3WKgvW/Ia9ZH0WJWHhbWxLNX5KgLZd6GmM+anjmVGocdsn53vHf9XWouO8Vn6lhMzgSTBdlqA+WOe7DbflaEbyCUE2yA7b77nZQusmt8AioIp+2RBzEkf57JuidSY45+DjQxna1O+hkF123tq0bNcVdf/cTD+jhPjsj0efemEgo97By3obC6l2zT4ZYvwZ16HMD9A85cGsgqhFB6wy2I15tP+7gaBNVXWxm3DcX2kxiHbvuYddSUp5TL7nYkO7quPoz25LpevBf6B22YgVf7ennPe3hemvYD0zr2osDsKBdQ7jF78NqAGCU0gar8UtGjr0tWDJfGdsYroYB9s=
Received-SPF: pass client-ip=57.103.70.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 99c4d03f42..84fa980d35 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2199,9 +2199,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     synthetic_features.Bank0.HypervisorPresent = 1;
     synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessVpRunTimeReg = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
+    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.TbFlushHypercalls = 1;
-- 
2.50.1 (Apple Git-155)


