Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66587606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=zReIFCcZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzcy-0006JU-8F; Sun, 08 Nov 2026 04:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbT-0005Tu-9V
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:23 -0500
Received: from st-2004i-snip6-1.eps.apple.com ([2a01:b747:3001:201::54]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbR-00061f-6W
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:23 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 0E60E18001AB; Sun, 08 Nov 2026 09:54:16 +0000 (UTC)
X-ICL-RepId: 01a1ba94-80d2-7f79-868f-5f2dffad2765
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQRNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGA0IUFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131660; x=1825667660;
 bh=vnx12hWY372/I+Rub5yA74xV6JLVi9u6a26PjApLWjM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=zReIFCcZA0CWyTwtkoMxEBWMD5019V2Nx//TnDOBi8t5Rvdl85gPiOhCVyRecpzdlG3Ff+0qLMIIwDvXPvpvKlsp5GO7t6TfShl0A/u5W3uegak7zkowt28EXdNAnR6ov0IcWMsBI+5hfv7sVKoNGCYLV+gb0ekGs4KR3nesowpqNoM3XNmM3daZ3PjsgjriI+Rwn33qON3EAKR9djzyqCcxShRSa1yDvyLbRhaVbAKerAUZ5bSudAHCWK2/4KNNOv85UfLY1DQ1vgcDjSMiR8An4qqWVc1pWb2MwtYRraffcAtbUgbm6zd0lF+UL8omNlsVOgGAH9ExNSrQ6Urt7Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 5804218000CF; Sun, 08 Nov 2026 09:54:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Akshey Taneja <aksheynew.tanejanew@gmail.com>
Subject: [PULL 11/13] whpx: i386: do not require ProcessorFeaturesBanks on
 legacy Windows
Date: Sun,  8 Nov 2026 02:54:01 -0700
Message-ID: <20261108095403.70813-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _XyI6T1xMKkGnXATy-kqg_TmByOQLbhO
X-Authority-Info-Out: v=2.4 cv=K60v3iWI c=1 sm=1 tr=0 ts=6af046ca
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=gf5HlC0yx7l-uUfkWeAA:9
X-Proofpoint-ORIG-GUID: _XyI6T1xMKkGnXATy-kqg_TmByOQLbhO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfX/uPG/ABs8gHs
 cIh+aLv0M0Nx/WBkkfi9ZjvVE0p6JyT/UWNxLKUHGeKkO6wfjhaC3DBu9aZk1rcsFVNMxvNtZDo
 Ig7wYQtu5ZmpL0CtvxI9i2vUPkbH2asmPScNFH1E2fUZw4hMALxC8L7O5lXgOOfQPcsRmF6nbbq
 9nlMeJB6NJjV8E9hUclJtlm+fMld26RvThq1U09eI96Icy6PnlRueb7Yq54+73wqtkLlXoBwPl7
 v0S8HDspY62ohiuAxYzGIIv4DERCYKAMkwRq11ex0EFoRYe2T9v8zTvkvgjA6TuCPaNZFuY2a63
 +eOYqsRjVRBXMNkrXWAWJ0Z3D4Engdn9z+jIc/Z7mZc4jS5+j7J7L00PlCtcjU=
X-JNJ: AAAAAAABLYn6O7VZeBGafSE9qm0NbjkwfpwvM8cxZIvYK71Zq2bhycVm/Vh5wY2K/rCpuq
 XzRKpL0+ysdJgWJRA899epCQ3644Dl7SSdk3zTOOHM2PRo2ToXIfv+rgu44S6Ei/mRB3gk
 WtQn+HIJovGQVgHSb25FqA2qOLFEnGDecrzYkPZ+mN61BoTeQNqBWTuMDNyrDTs5FU+0GH
 RJWwrBu4XrTnIevzkOJdprwRYMEe+MmJ/Ax8yJJPfzpnOh+dLaV8PSE4aOOOwWrzuCpsZy
 DpN0ao+Djc6Ph8pfXrdjUAYKvhc+bZ1hYKIGobpff/065/CW46RTcKvGo3sw5mVMWAz/Gc
 nQpZQ8PPz7/W+LBvH0pM6y31ZuuqY4bHabGYJi46XzY9A53lD+CZc56hkHkaIZJGS8y6ky
 QkXUsr0LcRmhczZV71rWeacrKjThsnPzt6OgZgLObFh475ng3zlrIonqNeQZQBWiinwZIa
 kGvPNnmySkF0/vrqry1RmBi8F7plY44ZE3tU0G/PPWPDL11oE0V2NZuHF5sUhTGPVf0l2P
 iwlSfOWSbub02vABtxI1RcZvRn+2qZs9a7xHE2F/1SaLbd8MOX3CRPRaXFKxLxE4/CJdW6
 z3E6i9ZlCq6211496alVzds06xYPgCCXwi+1me7nWcPp7O7G/lxClHGQfVON4CRpMlPsYL
 3fSsOYCpfdQHSzyWPOAUWTVsgguXHSky+GA8u8stygJWVd94jhdT1hvrQQ+thSSTusIkEr
 6LHgToQ2Nc6KWCZPuF9oNlSdYbd62y2M1xjnOSDzm3gJtl/6dzTjfy5Ucvb4dYW7XsMSV5
 GX6YV5Jdgx2SRbO7sdTAmXZzPcS5yeGhfzKMPfK1g/ZWU5KG5zCuq+tOM3g84j2E
Received-SPF: pass client-ip=2a01:b747:3001:201::54;
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
index 1790b1c7b6..f40409b330 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3312,13 +3312,33 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
@@ -3363,15 +3383,22 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
+     * The matching partition property is available on Windows 10 version 20H2 (19041).
+     * and later. Rely on the whpx_is_legacy_os() check to enable this code only on Server
+     * 2022 or Windows 11.
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


