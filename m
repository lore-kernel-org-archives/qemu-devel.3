Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494E6606D802
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=JeVmhYB5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPSz-0004gQ-Ud; Mon, 09 Nov 2026 08:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPSg-0004dx-Bw
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:31:03 -0500
Received: from st-2001k-snip6-5.eps.apple.com ([2a01:b747:3001:206::6a]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPSY-0004a8-Lg
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:59 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 4A56C1800E2C; Mon, 09 Nov 2026 13:30:42 +0000 (UTC)
X-ICL-RepId: 01a1c081-041a-75c8-b748-7fd9a90d55f6
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQdNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQABJAF4HWAdeDkELWBpcHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794231047; x=1825767047;
 bh=SJsiKhxQGi4n2J2TRm6+9Ts2Kj0gCyIqXjJEDLbcS3I=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JeVmhYB5qzVsZ39PuNUezFauG3rvK8ffJqahOQQQ/PiB1E36UB8boLX2569djv8xWvcCn3kWzoLuJZDfWXUFSZi5kdClbTVwmAHM9jFbMnULsMVhSI5WgbSTlwwo4FxQ21fGKcIkdQVrho1ux4BIiFIka4byIIAum53Beg9fHswvoKSCoS/PSZ0KtnwV9fKNUCBChserZ7tmLGI22P03wlZ1bk7Ojv2Nj4FMBWe+o1dDf51qsG58zV0zewdJp7yNw+XVTaS6DWgYIfS/ZHHwIl/xiC0gvpNvbvSNpK0nW8XP0DY+ADVc/Z3kDV8K6SBbn3UdqtQcTm+l86+eWabB8w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 0AE851801958; Mon, 09 Nov 2026 13:30:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Akshey Taneja <aksheynew.tanejanew@gmail.com>
Subject: [PULL 6/7] whpx: i386: do not require ProcessorFeaturesBanks on
 legacy Windows
Date: Mon,  9 Nov 2026 06:30:34 -0700
Message-ID: <20261109133035.7985-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109133035.7985-1-mohamed@unpredictable.fr>
References: <20261109133035.7985-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=UuJu9uwB c=1 sm=1 tr=0 ts=6af1cb05
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=gf5HlC0yx7l-uUfkWeAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX6fZXKLrDKEub
 slmOnvBpZ0UNnG1G5u+4HfAQBXK/3igedU3eHlOkSoUr9K+m8Nub/15tfCXsBwMJA1Vbf220ogI
 /8FSia0HY01RfjhJedRbKxDFcIf+qKnILFFccww4meH/H1eQwLIfZeueAaw44CcsIFrNmxqb1SZ
 fVQxYyxv/n/c6vocPn6+4eF7teqfAxJCm7Hbk3ZDvFIlVQxQhNuWb5qoePzdb0LuJjjA9xsJrrP
 t1jCw93iLe3YBNjBVjQSGbKbZzbXvyB3x5a5fAL867auz89f2hjxLohZt0NIDNM36qLJSVjbkai
 KjPKu5oQ2r+ZQMK/JDptd+CtHv/Jkvk7Re0YYbF7300DVPQqrLD/yz3YO9/MsU=
X-Proofpoint-ORIG-GUID: T1IgJx4qWJYbgSG0603754CVaCLZ6M7a
X-Proofpoint-GUID: T1IgJx4qWJYbgSG0603754CVaCLZ6M7a
X-JNJ: AAAAAAABk588P7BcAcVLH/dZSf3cZ70gPGEXjw8ELwR65TAU/zqCMbIm0oBmmF7hJ9ulOR
 UYy8p+49cn1YHLq1P3KxQgS52bOLjiD0yvVAHTKUkiOsa6wqQmPmkJwHy4Fkb0UxYHAkfi
 39TPDjYKQxz3hOMBxqkfLkO1KFZbfJkD9dyIjlGauUmhfud0h4wLCGB4yrbDYP2TXUPi4j
 LO0Dz9J7wWQw+RKfuSMy3mANZ1fJ+WFLx3ndPnqUf4xoJubmwrtyGAaYmlruJauvcbaHVa
 4AEGAOF2b9b0YjNzNauAtqV2AnY72ZvkTJRCvAHdBeWgIefm/1lRaXBh/+WE/DzDC9w1iP
 tpMAuFbcquL4ZKpjGyuhM/kzUMwV6y3kOGwkzCVWlgD4v1b+aruWRrg4XTndoeOkkLz/9V
 mcCoPKXtSrDVCgxbTD1KWC4I2mGHA4RSUkHz56npESUJGJhUdBUuO4aAJSGuLf4fooknwY
 SAT/7hVaFCM85vq49Rk2XOuEA+FwlwRLfFUCYDJt6dX7ZlFJ7fY7rtGcKZ0uAY9kPgXuQx
 YGnZyxxe7ho5WDuQMz6eeYYkRUsCKwngfkw/jAhcrPtyZtmSDxAn28lkaKT13TK6V++1Sq
 QPTakKPE1d0k8CiBGl4u+vu3LqvjTHDuEiV/cM2x056fE2LFgHpgE082UI7DLCcmNpxUof
 YsAW+CTdqQc1MYLn5MOd1wh/mddhgXwVafTX9oQvcvyY6UgC6jMkZDd0d/Sf0AaAx6j5hp
 2ABlBpxDiBwa23vxWncvLC9T04LXo=
Received-SPF: pass client-ip=2a01:b747:3001:206::6a;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Akshey Taneja <aksheynew.tanejanew@gmail.com>

WHvCapabilityCodeProcessorFeaturesBanks and the matching partition
property are implemented starting from Windows 10 version 20H1.

On earlier Windows 10 releases, the capability query returns
WHV_E_UNKNOWN_CAPABILITY (0x80370300) and whpx_accel_init()
aborts with -ENOSPC, reported to the user as "failed to initialize
whpx: No space left on device". This regressed older Windows 10
releases in 8b87283ce4 ("whpx: i386: enable all supported host features").

Fall back to the original single-bank WHvCapabilityCodeProcessorFeatures
on legacy hosts and skip the corresponding SetPartitionProperty, which
restores the pre-8b87283ce4 behaviour there.

Reported on Windows 10 Enterprise LTSC (version 1809, build 17763)

Signed-off-by: Akshey Taneja <aksheynew.tanejanew@gmail.com>

[Editing patch for reflecting the availability of this API, which is
available in Windows 10 version 2004 onwards]
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 61 +++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e14fce74d6..b386368f1d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3245,13 +3245,34 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     memset(&processor_features, 0, sizeof(WHV_PROCESSOR_FEATURES_BANKS));
     processor_features.BanksCount = 2;
 
-    hr = whp_dispatch.WHvGetCapability(
-        WHvCapabilityCodeProcessorFeaturesBanks, &processor_features,
-        sizeof(WHV_PROCESSOR_FEATURES_BANKS), &whpx_cap_size);
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to get processor features, hr=%08lx", hr);
-        ret = -ENOSPC;
-        goto error;
+    if (whpx_is_legacy_os()) {
+        /*
+         * WHvCapabilityCodeProcessorFeaturesBanks is implemented starting
+         * from Windows 10 version 20H2 (19041). Fall back to the single-bank
+         * capability on earlier Windows 10 releases.
+         */
+        WHV_PROCESSOR_FEATURES legacy_features = {0};
+
+        processor_features.BanksCount = 1;
+        hr = whp_dispatch.WHvGetCapability(
+            WHvCapabilityCodeProcessorFeatures, &legacy_features,
+            sizeof(legacy_features), &whpx_cap_size);
+        if (FAILED(hr)) {
+            warn_report("WHPX: Failed to get legacy processor features,"
+                        " hr=%08lx", hr);
+        } else {
+            processor_features.Bank0 = legacy_features;
+        }
+    } else {
+        hr = whp_dispatch.WHvGetCapability(
+            WHvCapabilityCodeProcessorFeaturesBanks, &processor_features,
+            sizeof(WHV_PROCESSOR_FEATURES_BANKS), &whpx_cap_size);
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to get processor features,"
+                " hr=%08lx", hr);
+            ret = -ENOSPC;
+            goto error;
+        }
     }
 
     whpx_rdtsc_cap = processor_features.Bank0.RdtscpSupport;
@@ -3298,15 +3319,23 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         }
     }
 
-    hr = whp_dispatch.WHvSetPartitionProperty(
-            whpx->partition,
-            WHvPartitionPropertyCodeProcessorFeaturesBanks,
-            &processor_features,
-            sizeof(WHV_PROCESSOR_FEATURES_BANKS));
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set processor features, hr=%08lx", hr);
-        ret = -EINVAL;
-        goto error;
+    /*
+     * The matching partition property is available on Windows 10 version
+     * 20H2 (19041). and later. Rely on the whpx_is_legacy_os() check to
+     * enable this code only on Server 2022 or Windows 11.
+     */
+    if (!whpx_is_legacy_os()) {
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeProcessorFeaturesBanks,
+                &processor_features,
+                sizeof(WHV_PROCESSOR_FEATURES_BANKS));
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set processor features,"
+                " hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
     }
 
 
-- 
2.54.0 (Apple Git-157)


