Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2B1FD0047
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 21:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwS9j-0004CU-1K; Sat, 28 Feb 2026 16:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9d-0004Ai-GU
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:17 -0500
Received: from qs-2005b-snip4-7.eps.apple.com ([57.103.86.148]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vwS9a-0002To-OC
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 16:47:17 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPS id
 61D5518000BB; Sat, 28 Feb 2026 21:47:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772315234; x=1774907234;
 bh=x5vmcSdYHKQ1byZOmRZeGIdImPo+Cp8DSOTH0Tm5/x8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=U09EEvdooAeDDUH+0xUiw58D3P0YOSUqw8gdeWPaCBnftX8xSBCiidRDQC2Ahx7lXmd56qy2yZPbcRRbLB5K4rslPRaxftov9WeK9j+bE5I1FhYkFDHp3B6ugLG9TARG7OFU2PTOzrujHLgraOK1m4mf1whwWALa6y9WrhFZQ8U2h2P7rshwgixTtVZ04CD14POBGUxz3tloJ7uYtG0c71bMXgyp70xako1ApYfGLQRiCayL7LRiTkG1IjKVdCipUCZNNQh8lomYy/z+y95gFNhSfMpHazGUWOMWaIW240inPak+aydAVDbfEPigySbhgGIk1lS+4U940BzTNs03gQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-20-percent-1 (Postfix) with ESMTPSA id
 871731800194; Sat, 28 Feb 2026 21:47:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 2/8] whpx: i386: enable all supported host features
Date: Sat, 28 Feb 2026 22:46:58 +0100
Message-ID: <20260228214704.19048-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228214704.19048-1-mohamed@unpredictable.fr>
References: <20260228214704.19048-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=J9GnLQnS c=1 sm=1 tr=0 ts=69a36260
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=268zvHjo1I8v1SDp_XwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIwMyBTYWx0ZWRfXxw/xQmOOt2pF
 fOoaSQb4F/CUljlJMwACTBBs0QA+CCfvB1DFoVOtXkQUO1fM2JCCimCfChGSRqA3c4JQak2zgxt
 Wz++xa2ol5iLYKDK762xT+sc1qQpOJpyKF68bbl5YPreLKK9cPj0fq0JdybcMI/AxPdq0ZKh2Jb
 i8yHtj3v40zLeSpmRlhtq2PMQ4DuttU9iLuFGnsX9GTc3t5pSTEszMIFzB9X58Rgr21yXoeTZf8
 CMYPYrcprrsZ8ApTwhHFDPp45ntc3POK3r6lIEoBwv86v3Sru4LmlPENJfL2AFV7A0j7r8GcVMc
 BTspBAjC8kdK66c4q/vArTzWOAiwvKVLGXR+uaEeLLnnG1+VJTI6oMxuFBSVLk=
X-Proofpoint-GUID: BtXkmyHs4GLoq2dBFJ4MR-Twp9Yh8Gfw
X-Proofpoint-ORIG-GUID: BtXkmyHs4GLoq2dBFJ4MR-Twp9Yh8Gfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=760 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602280203
X-JNJ: AAAAAAABUTq6UU5bAjYLgeH+Y2D+ACx9BtFLNXrH8c2TG3KXrBitNHpwv8UmE5sdJaACQoDFaQAOmeSWFQzp+IuNv7tDdIzs2uUB4lcq4lHrUlhBSmhazQu4/+leadFjYdIpwTtkzPpsCGTPTkokmb3FurgVM81L5gy05p//ET8pzbfT1TIkhg0hXpPpkLBezPbsy3tnhDSOg4Jvr6GMKYgHJvXtTzLO6dElivmE1QuREXQLkbd26JuwWKEwIHpVXVOLTKW/w2ghAzhh9eNNA+IFzLRiaFmuipiKhcdp9Fg9fgTL8z/smNgX/HRhlSp4wv3IfuUzKhPgxyP4OxUnNdmXTc6zTdQU2+aDYi4QeDpm9UDJhSNyq+1UGQUERg5bUBpIDE5NLMdQBE32Rndaa0Kzw9rbdvfJpLzEoYkldnR/uJt6NhtTuwh4KlUpzxNi1sfh4byU4W58vVzxqg6LjQZy74xvnID/MW6NpmTV/cxUdvZvyL03hYOaykkGewQK8pvzay2/dKHfViipCUfwRNTFAf8E+9fCADuP849VBiElaIxU1Sp1vqvDdq2WEKbrtOYZ4AO1oviaLCkdIMdOuhr1WHKb/upD7l+6WbYbEACFmTcdED6CL76zF4bwErgNmYN0LR+I5Bjj5VXlbWK2sV5qKefMtAczJ/2Vx3OVZjmmiQ2l3te95Aj4T+WhWg==
Received-SPF: pass client-ip=57.103.86.148;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
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
 target/i386/whpx/whpx-all.c | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 90f51fc4dd..ccc52d1f96 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2007,6 +2007,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
     WHV_CAPABILITY_FEATURES features = {0};
+    WHV_PROCESSOR_FEATURES_BANKS processor_features;
 
     whpx = &whpx_global;
 
@@ -2112,6 +2113,45 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         }
     }
 
+    /* Set all the supported features, to follow the MSHV example */
+    memset(&processor_features, 0, sizeof(WHV_PROCESSOR_FEATURES_BANKS));
+    processor_features.BanksCount = 2;
+
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeProcessorFeaturesBanks, &processor_features,
+        sizeof(WHV_PROCESSOR_FEATURES_BANKS), &whpx_cap_size);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get processor features, hr=%08lx", hr);
+        ret = -ENOSPC;
+        goto error;
+    }
+
+    if (processor_features.Bank1.NestedVirtSupport) {
+        memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
+        prop.NestedVirtualization = 1;
+        hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeNestedVirtualization,
+            &prop,
+            sizeof(WHV_PARTITION_PROPERTY));
+            if (FAILED(hr)) {
+                error_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
+                ret = -EINVAL;
+                goto error;
+        }
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeProcessorFeaturesBanks,
+            &processor_features,
+            sizeof(WHV_PROCESSOR_FEATURES_BANKS));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set processor features, hr=%08lx", hr);
+        ret = -EINVAL;
+        goto error;
+    }
+
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
-- 
2.50.1 (Apple Git-155)


