Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1004606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=M5lmUOu7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDS2-0005nN-5D; Sun, 08 Nov 2026 19:41:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRv-0005jZ-Q1
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:27 -0500
Received: from ci-2003g-snip6-11.eps.apple.com ([2a01:b747:3005:200::49]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRs-0006Mk-0J
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:27 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 7BD7518007FB; Mon, 09 Nov 2026 00:41:19 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-9d7c-7d9f-8203-fcea6dc3fe70
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0cZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeXAVGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184880; x=1825720880;
 bh=jUaC27K84HIh4oYu0Zv9O7MV92rVDjSftsTK307Bs00=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=M5lmUOu7G7u6QcB/m1U/aHMkLyUc2LgQ5VSjCaw7Ckaoj8wyNSfpoN5csLkvIJ8QKVjNflHATr2TtLSh+z+U/8dtz1SMX/wOSOHmm5saWN294UkSwwes4flanlBI+G8SnU/UhPMY+KzTRY0jxgbHGHpqtlUMge15s8yQjo7XPRNd+RfjpYHCX62T+p/3D1aoBLIp8mktmz3VARaz1xiBVevC7vpuLL8JpfDWpsDQrPfT/1XlyuReymtNy7O7uaFHCtr+GoGSG60pJIjXZzyI7nn2TChKlsstgy+zA/v0arV/12d252eBEHb7lk9Bn5BcX2HbpAMBcqSiQqDEtSR7aw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 C8A4A18000B6; Mon, 09 Nov 2026 00:41:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Akshey Taneja <aksheynew.tanejanew@gmail.com>
Subject: [PULL 11/13] whpx: i386: do not require ProcessorFeaturesBanks on
 legacy Windows
Date: Sun,  8 Nov 2026 17:41:06 -0700
Message-ID: <20261109004108.85808-12-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: a-mng1z6v5M4BEqkNCMVAtRFmqMbFboB
X-Authority-Info-Out: v=2.4 cv=LbwxKzfi c=1 sm=1 tr=0 ts=6af116af
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=gf5HlC0yx7l-uUfkWeAA:9
X-Proofpoint-GUID: a-mng1z6v5M4BEqkNCMVAtRFmqMbFboB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfX0ZIA7SVvq2gi
 r8ZV91z2YAbLIXai0hlxqvaG5tuzRd33A3jJ0qrOav2Ej0FCyCWSu6ED7HoMxajcr8nENQNCp8V
 DUibzPXQ3V686jZ10upEoIM90I1iBwvP/kJEPORWt+dKliHRM23psCHzhQUNmj8EzEuboAnPHVw
 bBuAvA7/at0x22bR9Am6KzgARZsz0xLcFn6TarRe59nwjJ0eC1H6+WV1TyRcRhGXVKGk+rbyRH0
 HovRnpTIkB43+B8XG1v8ncUcSH8uSsQHBHLYWTvC4R8pcO56jNUATolli6xKsx/lqN3xSETlv8Y
 17UDgBqWlJYvyMgAoVQ9OTbwh/DIHC2BDLmzsxxqxV6Fr0aW1qXFUrSclws4as=
X-JNJ: AAAAAAAB9t8iijDfD8a3GNk/zn0pwxbjB1YJE10TwViiZF0Ftoh8HIEUgeYg0HYv1u+UCb
 mniTEZRmID7tGuNcpAdiK7aqTQz4mvzuatt/S+dTFFdo2cSOVnECQOkwsnGMB8e46m8zKB
 DNbSkkGmrJaJ3a6TJCBuz/I9lEyrdKdNPj6NVHgT3EoLLCorHVuTUvCH/APTD0O1Cnvp9V
 z5zC6UE8M517wLxbreLU+0xEitVXSsXl+noVOKiLxCr4TyI9+fYoxaRjsy23s79FT7F3uz
 pRcRMQGs9dF/OLuqSVEJ8nIrtS8rQc56gmEBuxfWyOX51nDX6O4jP4BbhBEtxaMrQfcHYm
 aDMfw1lJON34b6IwKdWI+CEjX9OhQwMoqFTzHJANHtZt09I9zQDR6Uy+TuG5+hZW05gV/d
 LJpP649xdDSY/rnwmNXOQk02bLELLNGnPylZiTpLNaGQtxvEmNvLfN1mYm7KJck/dJGY2m
 puxkutxYngxKNRqNk9RPhmdIXusLXn3HgvzFpi2uwof9h0dViBF34T3It2l80S44/T02d7
 qT+qJ5nugumBGDdBGL3b3jzxqFGJ3wGcOfmuKp+CV2JzqZKNDhoCA0ItMQeshDPwf2IzF4
 5FkgkZsSa1VEx+PfVf6/3x6lVBkVSDnNmEtNGCwGigcHHF1XyRzFdCSxgQkBu6niVpwRG7
 zGvKLSQlPJI7BSJo1dUGob/eMvWEjxRGziOAfm5i1o6d7/PN1gaW7LGLdkkKlB/ryPHyop
 RD7xMBSLVhKQVMQfKt7+oV+6fuKzYsY06LS8A0ACu1DoLNZFIO+4L0bA0UnRzSjH9vksrs
 ybWmZzYczUgIVB9Q07IncBo9UUgcxBIwgP6IXg==
Received-SPF: pass client-ip=2a01:b747:3005:200::49;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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

Reported on Windows 10 Enterprise LTSC (version 1809, build 17763)

Signed-off-by: Akshey Taneja <aksheynew.tanejanew@gmail.com>

[Editing patch for reflecting the availability of this API, which is
available in Windows 10 version 2004 onwards]
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 59 +++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8cfbc5f676..7c2172a7ed 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3273,13 +3273,33 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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
@@ -3324,15 +3344,22 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
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


