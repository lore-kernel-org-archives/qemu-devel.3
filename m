Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CB0F99C98
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEF8-0006gg-2U; Sat, 18 Apr 2026 18:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEj-0006J4-Cd
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:01 -0400
Received: from p-east2-cluster3-host11-snip4-3.eps.apple.com ([57.103.77.174]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEg-0004xF-GC
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:00 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 8AAB518000C4; Sat, 18 Apr 2026 22:33:56 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551637; x=1779143637;
 bh=6dRDJ5VEmS78xsRk6kMHBpp9Wu7kQoHjBWY816Egd9Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YtlC/9Y56yhtbRa+XjmzSFOtZubmXQ7B0DiMIJSCkJz5/6NSToVdu36Kq+NSjcb4hgw2pGMEMxM4aJlCXePkr7x7enN4Eg6xpUl2KdjaSEZo7UaglUY2AK6UnT5GudmpH21IWA2KmjIis1T1buCN8/cznv/z+xh8FpGQXVMEPrQqSMIngL6/7safzGN1DcC7HYG9soPXJamTFOlilqEXCm0VDnr0vYXsaAh0pkdLTy8bPxR60U1Zl3nWBauy3kqwvdvSBMYF9laOiBplDCbwtneT6QxA5Bkcx7UbnfXwd7YC54bUY8U9YicHfHejfgl5As1rNNQ297KeSWW1KKr5Lg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 6E81F18000A8; Sat, 18 Apr 2026 22:33:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 17/38] whpx: i386: unknown MSR configurability
Date: Sun, 19 Apr 2026 00:32:59 +0200
Message-ID: <20260418223320.51330-18-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: X8uOZ2NOvbwt4S0PKLmgUNdWFjWuG6Hb
X-Proofpoint-GUID: X8uOZ2NOvbwt4S0PKLmgUNdWFjWuG6Hb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfX/s5O1QghGj4+
 akGzB9x2JL+q7ZeCKF27hpVmpzdq28M+Lcw+5PM20TKKEgVnaGKAa0Kfnf85GN0POpVzI+wk8w2
 xP/eZLbGvUQ7FnbxdBaHdC1r4M9q+yuNWD5DFypuysKOF97afvzkdFHvGRP2T8hs25d+ONNzQ2x
 7ShUvMU01HnRRKRoIwDHkC7ySo3hAKVTrxX+sQb8TExdbl0C8WzBJnzlQBvv6MduAM6/lpkixtf
 hL4weVO8dNDDHgF7C2hG3bw/+Yo7JznO9nvsjDqKFoZ562K8eEKNgsH/C7NqssJwPC+pmOow+oF
 TH9WDWCAFVil6mi79kp2jL6ldsDY3LxpPMlohzcAohnGkPCcaZ3y8uHWZogpaw=
X-Authority-Info-Out: v=2.4 cv=L78QguT8 c=1 sm=1 tr=0 ts=69e406d5
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9z_AL-2ZILZrMqfKHsQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1030 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.77.174;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

Add an option to inject back a GPF for unknown MSRs.

Keep it on by default for now as Linux expects accesses to some
AMD-specific MSRs to always succeed when on an AMD host.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/whpx/whpx-common.c       | 38 ++++++++++++++++++++++++++++++++++
 include/system/whpx-internal.h |  1 +
 target/i386/whpx/whpx-all.c    |  4 ++++
 3 files changed, 43 insertions(+)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 59be996aef..706871f138 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -505,6 +505,38 @@ static void whpx_set_hyperv(Object *obj, Visitor *v,
     }
 }
 
+static void whpx_set_unknown_msr(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    struct whpx_state *whpx = &whpx_global;
+    OnOffAuto mode;
+
+    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_AUTO_ON:
+        whpx->ignore_unknown_msr = true;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        whpx->ignore_unknown_msr = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        whpx->ignore_unknown_msr = true;
+        break;
+    default:
+        /*
+         * The value was checked in visit_type_OnOffAuto() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+}
+
 static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
@@ -538,6 +570,11 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "hyperv",
         "Configure Hyper-V enlightenments");
+    object_class_property_add(oc, "ignore-unknown-msr", "OnOffAuto",
+        NULL, whpx_set_unknown_msr,
+        NULL, NULL);
+    object_class_property_set_description(oc, "ignore-unknown-msr",
+        "Configure unknown MSR behavior");
 }
 
 static void whpx_accel_instance_init(Object *obj)
@@ -552,6 +589,7 @@ static void whpx_accel_instance_init(Object *obj)
     whpx->hyperv_enlightenments_required = false;
     /* Value determined at whpx_accel_init */
     whpx->hyperv_enlightenments_enabled = false;
+    whpx->ignore_unknown_msr = true;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index cf782cf5f8..86639627b3 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -47,6 +47,7 @@ struct whpx_state {
     bool hyperv_enlightenments_required;
     bool hyperv_enlightenments_enabled;
 
+    bool ignore_unknown_msr;
 };
 
 extern struct whpx_state whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0d72e93621..550f30d50a 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2048,6 +2048,10 @@ int whpx_vcpu_run(CPUState *cpu)
                     vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
             }
 
+            if (!is_known_msr && !whpx->ignore_unknown_msr) {
+                x86_emul_raise_exception(&X86_CPU(cpu)->env, EXCP0D_GPF, 0);
+            }
+
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
                 whpx->partition,
                 cpu->cpu_index,
-- 
2.50.1 (Apple Git-155)


