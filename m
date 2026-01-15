Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0206AD3CC8B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB2S-0006w0-22; Wed, 14 Jan 2026 19:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB2N-0006qS-P3
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:16:31 -0500
Received: from p-west3-cluster6-host10-snip4-4.eps.apple.com ([57.103.75.97]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB2M-00020D-5x
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:16:31 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 3FD6A18000EF; Thu, 15 Jan 2026 00:16:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=usn+5WRKOGJaDLoRmA1S0SGx2PVU5yWwDmjw2JCpvZ4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YRry34nI0UaIfVA5RWAf4qX7eDASWHrKRcSfMXXqNY3q5eyyAdVsLZ9shPkqCirEpz0lHlgmXIPJjZu2u+0lpPWExzQp66D5fQ6HM+aA2S2ZOkYfpoyIgRa62/9puM9pdGk4eabBNJnvburaBbqYuxFou+YpL3ziUjCsT8yAYnnRxUnczqT+LM4bd75he8CrckeZJold7m6VRXuvmVXKu9POsfrtE6MPSgHm/xb15dkpU80evQPedIV+8cVXpxq1TiTUss7kiRPHqjjF1l7UCeiArYJP+Kb2jMtwiwQgEYnm05FlYciT6ZBo40IIYYJEfM09PbTgr3tlvjaIoGOyGg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 75C4A18000B2; Thu, 15 Jan 2026 00:16:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 12/26] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Thu, 15 Jan 2026 01:14:51 +0100
Message-ID: <20260115001505.57237-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lrsEPbI1MGdoxhRIMXUggJzB9gMwsyOD
X-Authority-Info: v=2.4 cv=L48QguT8 c=1 sm=1 tr=0 ts=696831dc
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=2psWIPzlEfUqwKpUe20A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfXwkbnfNnxfo9u
 R5FN8IaCdOVfrCNjUusrRZLmtxKEGOL3rHtmrs9R1YRzCg9Gh9/VO2jQkQXTO/l1FGz4T7sDlSd
 D6H00U9Gg7Njvz7GdJ7/j6k4pGG3jeuqJZxHAkT0svxLyHEQVlcgqqK+16srzV6Tp2inSJINxbD
 C4C4yjKT3Ob1uG+1Rz0KOPvwvrWPCIlvkvouk6Vhi6ifjYuDlh/eWpQpdlo69I+x997urkXbCAE
 BM9iUStL7tkf4NCyv1z2ogvUvbOWey2HYMk1hSjV5kwm3IMFJSn+39yalEHXvMOysrHZNZuXLIi
 YxrAbPLO0yaTLcyl36Y
X-Proofpoint-GUID: lrsEPbI1MGdoxhRIMXUggJzB9gMwsyOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 clxscore=1030 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601150000
X-JNJ: AAAAAAABgeKrtCuXGb3tbzsgH7re08hyLgfx35B/++oY15bD9dhTIXBb6g6P9odb5XiBJ4ivpBMzh7NVuMYYCm5WNKI1NBdHAh5WaR+Q0KCSDHQhbDra5AS1IYs3u/6tOKSYrqBrb9pj7wBZu80bP82hXPzu/UKPsE3QhRJgwxDCMUP2rpwWeWQ4lwJEG5suOZwCeHFyn83hDvdOO1v8Pe0GUvFDEiX5yUFGpnNvamw/QpmhFFwU/yPYbLfeLfcPqtHwwV0ghWh++cPLl1GPaNy1ShwC3YbIV8eZGu69NhXPBG5pKQXtljrNXdEOCAd75DXmLkQDi5qHkAwMf5+GsOPy/AffTEfzNuomTtTVXhfvT16vouZtt4PjFHRiAX36EV8GftDgZWt8Gd8pJEBF3KwGKsBgxyEsMBFtCckM3WC78aKh0jSaeJijDW41B9/taZYUEdPVJBJqTGVMjqsQ3erJhzHcQBEOMDvaswkF6NsKI5CC7xGEVuwabkQI9E/0+kHIA3F8Qr0PPYOn8Rj61hXT/N2C3avAY5ypnZkuTxoq5iExLith1rErYNA2tsVX6MwqJFeb9QS8xEBmZLyZRCMkJ9miFsV/XSITwF8IHV7iCMLIVQm5nt2WFTUBF0JHipp3jjnvR4a0yEd3dVik1C+7aWtrTd8RdqBkD2UQ6DWfjZVs4wNcnLkEU5G9R4nhfajCY3UVRJWecF73gAhzCVFeaXhxud1WiIeg+8pF90GSDT6s+ayFQn+6NdbXFaw4bksNKwW5VIjPAcXTVkLsR6myG7Sb3CPXofcpBnmIZQmR0kQYbkEOPVe4u2aQPLbQPLDoCJdZsYpdI/grdjJsrHu25/bwB6k3y+NkDtfaFc5gT5mJ4IOs2jgirVghyzv5kl6pdvewkoTqjnsH+5ytByBEnDQoAPLAlGc62SLz4RSVGy0Pl1hmKSB8/593aKC/8UfzhL09SMRUWcY=
Received-SPF: pass client-ip=57.103.75.97;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index c58344cb61..c0610815d9 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -119,7 +119,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 8f171d1397..b86fe9db6e 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.50.1 (Apple Git-155)


