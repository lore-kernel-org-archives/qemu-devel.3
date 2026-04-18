Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B617F99C9C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEF8-0006m3-VP; Sat, 18 Apr 2026 18:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEF0-0006Q4-3V
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:23 -0400
Received: from p-east2-cluster1-host7-snip4-1.eps.apple.com ([57.103.76.64]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEt-000502-Ph
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:15 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 C0861180022A; Sat, 18 Apr 2026 22:34:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551650; x=1779143650;
 bh=Sw+c1/Szq2U+GFUwZJhzpKe2Oxhd+T8qz2/AUdFCjpA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=AkE4p1pvpaIP4gLHDnKRyYXSVDbd8oDIMXXZIiNGfiWk14fve8tTuJueSdqqDmXmJo56iOiBevX9k52SAJfSoccLPqksJbDxR7w+l4vmaR9bbYd3yM2gPc5WhUvDpJuoTYB5IDb6DvOY4mYd/mb8Z+sSRqhbBXmCyDDYbJTXeEW1nt/9JkEJEhamIq3l4cm2P+DUXe/fxgxnTqsseEwenL5AQqiEnkfX9Gep6RggF3v2sUNz6qo/x2LKXVI2X8x74wd3HRa6PTGVhecRbWbE/qkciOhSAIDvyKqnUiKjYkPg84DmDIcmBH5j1pmxyqHqIydURPTR+aTZ0ezvb7ILXA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 6551C1800216; Sat, 18 Apr 2026 22:34:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 23/38] whpx: i386: one more CPUID
Date: Sun, 19 Apr 2026 00:33:05 +0200
Message-ID: <20260418223320.51330-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NPMvtsQwQNLiuSPQFQxELSsZpAZe5sva
X-Authority-Info-Out: v=2.4 cv=KIRXzVFo c=1 sm=1 tr=0 ts=69e406e1
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zJD0qBlfmizEQV4F3ZsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfX++qfVw00K/Qt
 Mo+YM7nZ2qbfauVuVE62E/iaMeSXzMhpJHnwxwJOV6HD/3a2MYd5iaPnHT4S9U/C7lhiOsclHL7
 wyJAk2FRkqhREmGBc6gihHaQ8H3cwlwGuVqNkGSHIfu/BaAb1M7b8Rq/No0FG3ZXuj8hyZvpF1+
 0ROyauezEOklnlftvthdNXUyJ8QK/Qhia0XR3vRE+Sg0kmhjFXQMVbFaNn1s1Nxdj7Po22aL4np
 8N+QESU5a8GZX5lpH0GECuG9MomiWQtPEjscl5SgM+hNJwaR0TOFsbb7XeqFQTFg5NscOOe+zsR
 wl04XUeMnDEVTiO1X+X7NSt8NMhrC1UWeL7BmyQRzE2yfbsDGPoRAZ0WyG5CK0=
X-Proofpoint-ORIG-GUID: NPMvtsQwQNLiuSPQFQxELSsZpAZe5sva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=821
 mlxscore=0 suspectscore=0 clxscore=1030
 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.76.64;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Trap cpuid_0xb as it has x2APIC topology information.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4dc4030d87..5c2a9bb8ad 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2527,7 +2527,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
 
-    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0x14, 0x24, 0x29, 0x1E,
+    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0xb, 0x14, 0x24, 0x29, 0x1E,
         0x40000000, 0x40000001, 0x40000010, 0x80000000, 0x80000001,
         0x80000002, 0x80000003, 0x80000004, 0x80000007, 0x80000008,
         0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
-- 
2.50.1 (Apple Git-155)


