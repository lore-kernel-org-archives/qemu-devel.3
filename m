Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D03D37E39
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg194-00083o-Qg; Wed, 14 Jan 2026 08:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg192-000822-TB
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:44 -0500
Received: from p-east2-cluster5-host7-snip4-3.eps.apple.com ([57.103.79.26]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg191-0007R9-5Q
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:44 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 100AD1800160; Wed, 14 Jan 2026 13:42:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=usn+5WRKOGJaDLoRmA1S0SGx2PVU5yWwDmjw2JCpvZ4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ITjG/MEW/k7t1dmFCTlErglavB0qp83KIgy3dryNpqowS8+ZOAyNSTTG7UbVs3DPiR/45lpnhHfAqFxU8zQFbNcIRKkGXwMwebZNT2zM5K7HoTZmyZcjWc0585ONBcuEi4J1tnzS/YLEy1Oi6b1FPaZ+tpycc2LhcW7l8++7h3/NJj3zNnouvDSCINY+YcikqVhkB6D2H3tiG5LYlAUbyVkor9DOf6Mol/ZyreimQ4MSwelbn7kL9kCzQuuzVzrMp26hR0uRz8zxzUKfq9frEBzzg+wBrRBDNFUwO3lZDg4K44ACeYA4ooEzW/2TO4Mb45QhK9DFc5+oNTNJxaxogQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 B13C01800334; Wed, 14 Jan 2026 13:42:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 12/26] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Wed, 14 Jan 2026 14:41:29 +0100
Message-ID: <20260114134143.26198-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Su8mb2hJMuwDjy8YI0t06e7fG-KO47oz
X-Proofpoint-GUID: Su8mb2hJMuwDjy8YI0t06e7fG-KO47oz
X-Authority-Info: v=2.4 cv=UcpciaSN c=1 sm=1 tr=0 ts=69679d50
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=2psWIPzlEfUqwKpUe20A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX5tzOwaQBl+LW
 k6uz7n7ju+BC/XFyHxKyXQA/yLxPBqFpZFgb++9Akn+npk75ErVhTnPRbMzVrhf8mBS2k7eLCYh
 A4zRg/2paF4Cr7cKgWLe5MH8B/O3GtApEC60nJvST8+DlG87O4n2sFCzvByH2JmK0WbZc33hhx/
 MZ0HJEMuC4ksnhFaK7PEdsVEkuwUNMjaMRAQrBvDA3fCqECtIuWOU1CvhSnGtGKLk8Dv4qkMLh/
 JDWc8v5y62SNlARUAE/5zZYZVqBNxZ0x+av92ssMxPpkYjwEbixIKD+We1YaUHyKqasbZ1GztH0
 BfFunifHlESZ0vZhtAU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAABQJTFM2EEXgUXzvDUwB34vZtSS776B37Zyw+JE//10mYT6vxyA7f4s3E1rlIZYgEvsQAJt2eg+Ldo6lyiD40/6X570i8xGpphIb18dyQH3djw4Cus+pa/o3/I+UrcrPh1dZhEViWpvZzXK1mRKQXOGDmSM8Y9gIdQylfMM0pbBNkXsx8lRx92rMltjDL53T3yn4PnEztWSMBlyQumcpuEqRV0EuKLnxxYHI4Atd1Bi3SET1bR+lizn0bHPByhQIhlHjpveCEl4YbyvMLBiNoSgsOxvEuBdG11J1i87pTF6XpQqvdjE0ZGkY5qiexa+Yxvvc/7wTT1/qotGO4KPzlldx8IpfWj22HxwBwhszy5h3Li2ZN+bhpOCBNC4Bww90rCMOIG8x4nCgGOJlT5E6xguevEyu7eLUA2+joVQge7Ov64DETZN+CBGEFDZ9YJX/XAZtAnD7K7NXQ2dpHQXkI+E6vpk34DfXrjtqtyS06LDWCRp6MpxM2OxSkNe+qr8EaBCdtGqI0MGaYUO7LEI5kwI5xICIn5HI0+wgWJv4m7k0PioIkvv3LIaiwdoiHTrXrMSuyHZud9yi/7HBacbQDEWM0SFpppBfpIXjDU8qxQyNhtnphakLRsR8L8i5FFP2XiW3wGGdc0MHOfYuthdXnLHKFhnBehCuidFMPAOqRFj3EF0Xzt3ONAZQ/1QkbcW96iZLa8x6JTUOnbjUNQR7l7Ac7RFI91nMhLeelxOr15FPqnRmv/Bx4AUkkcF769NlTrl//3EVZeqqJTst1qXCkhO1LWQFhpYNdMEloOAsFpgR30MHJLQ6A2sOywIkCvC5cTKneaI7b+hthaTLbnrrD2eM9DJHD5rn0H+mLqGugOgZxKGbzX0Zh8GwwJT+5XztihxpB25fdbrbsRjGzgjvzzsoPAp1qFwuRS4LLifGSiTPl+Sg==
Received-SPF: pass client-ip=57.103.79.26;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


