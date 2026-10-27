Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58577606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=CQ7C3IdN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjaB-0002jc-VS; Tue, 27 Oct 2026 11:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYx-0000zq-LX
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:13 -0400
Received: from ci-2002a-snip6-11.eps.apple.com ([2a01:b747:3005:206::d]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xLjYo-0005nH-Qz
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:58:06 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id
 1F751180010D; Tue, 27 Oct 2026 15:57:59 +0000 (UTC)
X-ICL-RepId: 01a17e15-2f6e-7b59-a1ba-ad519506d95b
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0OWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIJSgVcB1kFQQxNBF4ARQdJC08CQAZfHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1793116681; x=1824652681;
 bh=sn39T+5R49cZnnz7KKaC1XtgTLfw6r3MZ58PDt9K8o0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CQ7C3IdNYxcDEsaD1aIEXFLAyNswmLsog+x/fWODUFjTG2lAgDbP62OHmqwJKHpJjFy0GFmIa/n5cKvhRoRQnCBDZfzyVzy8GtUFXhiZedxLgYOQ1Al6umP6LlY00G06C2ikiUoNhU7SxA9h7Bcy8V3Tu8uz/Ya6BatIu0qeT4h8EksycjmqVr3cbYiIRpmiZuEiLP2hl2+Qo5CGCswKgYL+RDaFkl7Z2G4KNR0Pz21JTSCjYIOqO1ILP4Ic6EemrySs4PSBiSyW2mQe2+tLIemY7CVTrrNwjuCfaCxbyvY053yzGmTZZQvbAeI1Yjn9FZmsfHe1XUv3xo4iigbTRQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id
 775491801A47; Tue, 27 Oct 2026 15:57:58 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Akshey Taneja <aksheynew.tanejanew@gmail.com>
Subject: [PATCH v2 13/18] whpx: i386: do not require ProcessorFeaturesBanks on
 legacy Windows
Date: Tue, 27 Oct 2026 16:57:32 +0100
Message-ID: <20261027155737.59271-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155737.59271-1-mohamed@unpredictable.fr>
References: <20261027155737.59271-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=GrtPO01C c=1 sm=1 tr=0 ts=6ae0ca08
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=gf5HlC0yx7l-uUfkWeAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MyBTYWx0ZWRfXxuSthb+Wg0Tk
 38r/Jxqy8ZpRnv8GUFC1b1QczLI/B+zbHFx0Vw+RcXMarrgEUN3nalqYT8APfuiCQFu2sN2yits
 QS7cennIqSAquOtxmA0TdwlwrpAhpgvDNTl2M7sh2UGmvCfA187J/j4i3adUXvrljK74MFLWgNu
 vxPbH5A7kesbnRbCbOL76oKs43Zab01P9OuUQAjfL7GrDxu4+9wkfXtXlH0lIi217uQGV6YIUdY
 AJoQdxQrWTbQtSirEinrDwonvMOX6t6dhjB8FosAqcfARirhuQGyCPYvMTDhlwDx2Hk/UK3poIh
 1PFy5YkcasdRTHa2TjCcU2NCHiXmuDqJg0llc8RhHsZM+EmJX+E28VqgKr0Mo0=
X-Proofpoint-GUID: DTWh1pQLKblJc2izsoCq5KKJsy2-olyO
X-Proofpoint-ORIG-GUID: DTWh1pQLKblJc2izsoCq5KKJsy2-olyO
X-JNJ: AAAAAAABDihSdPk3tuiI1VhUH8v5MIFV/sYNAi3N8pYcq4V5YJTKtpyMdlyeRCh2M2dvlpf20SXrMQP4yX7UOIlwVmjbKl81CLlKzM/uk2ZyIthevShLW6UHNOOjU3MkQLQkojDfJ1obQVcB+YVDodQUEK7bO9JG60ZLI/+OMqUFVHRSAc2fzeqrcQOuoWmwR6YT0NusGz6wX3EAYgkW831cRJTnqLUuqovoJjbwPCi4PdLMZ6ZpTot2SoOW2iTa18qLLK2qJaDdRwIgKpsCgQgTvfh/HRqEq5cXqoM+ANDXb9Tku7KelaTOESWZriFPCn6k9g6BVK7s6S1sb/M4SLTGy4bv4Zg9mRGjwG5FyhfhPJzp8eBY3kCDPa7xiPKRtm7/B7trIOz7ZpiEY8FvljO09sJ0cJX1FCeVc60zCoR40L+fp5QSAZuIsA1Q9OE6sTy20GzARhJTYbqo5uiDIaabMershrABIk2RQD5k/6FboWjAAheCmPSmLvryyFvG1UDnWcr17MxiD3FzIBe80lmz6emViVLPkGs5oDW9i0wn51Vi7gE1LJGpZZuzxysL+x24ECtnBiqtZLwTDP4u/9a3+ng15fwKYkuBs8CtvKvUA4wjqw3Z/oV8FFTAwVN/adAXAJm2w0uLXf5qMgh7vN8z+cNOt4z7nBK/0l6eMANzGElqpUlFRZDTEAAmacSvR3xpVLFtje6DmJAMz+UqxeihHt2eenKYSRf5e6icPXPgwQzydDR5dvy4Lv4uVDqiCb9jt53wAgSCJMRduCdbv0Y+tf7jdya0ktJVbAnpBGaoomJ4y2Dwmo7jmu58
Received-SPF: pass client-ip=2a01:b747:3005:206::d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reported-on: Windows 10 Enterprise LTSC 17763, Intel i7-6700
Signed-off-by: Akshey Taneja <aksheynew.tanejanew@gmail.com>

[Editing patch for reflecting the availability of this API, which is
available in Windows 10 version 2004 onwards]
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 59 +++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 065cfacf3b..7552e9f4da 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3331,13 +3331,33 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
+            warn_report("WHPX: Failed to get legacy processor features, "
+                        "hr=%08lx", hr);
+        } else {
+            processor_features.Bank0 = legacy_features;
+        }
+    } else {
+        hr = whp_dispatch.WHvGetCapability(
+            WHvCapabilityCodeProcessorFeaturesBanks, &processor_features,
+            sizeof(WHV_PROCESSOR_FEATURES_BANKS), &whpx_cap_size);
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to get processor features, hr=%08lx", hr);
+            ret = -ENOSPC;
+            goto error;
+        }
     }
 
     whpx_rdtsc_cap = processor_features.Bank0.RdtscpSupport;
@@ -3382,15 +3402,22 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
+     * The matching partition property is also Windows Server 2022 and later.
+     * Legacy hosts simply keep the features the hypervisor gave them, which
+     * is how WHPX behaved before the banked feature set was introduced.
+     */
+    if (!whpx_is_legacy_os()) {
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeProcessorFeaturesBanks,
+                &processor_features,
+                sizeof(WHV_PROCESSOR_FEATURES_BANKS));
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set processor features, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
     }
 
 
-- 
2.54.0 (Apple Git-157)


