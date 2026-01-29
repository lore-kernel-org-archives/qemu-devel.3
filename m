Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A09CD46BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 01:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlGtG-00006w-Ab; Wed, 28 Jan 2026 20:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGt1-0008QL-2p
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:55 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlGsx-00037r-Bn
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 20:31:53 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34c2f335681so194377a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 17:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769650310; x=1770255110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EF08xIaER/Brt/G4K9v56Pf963Rxs8WHbqL4EuG9O1M=;
 b=ywp5642k/898WahiTAOKsvjPLRpGSVcPvOx+Fl5NbZl62OjZEOe0vTF3WQgoZ9H4ot
 ljqvSz8ZlMyuGFxwG6gvDVCb2QdKrUosNA8+RoLmbyjGSZFo51PPvdIVpm1f8OwG6Zha
 gARtAzUjRiTHZd+7kiz1mP9uZzoPMWozUoE68YL2+rN4C90sVXT2pHzRiqIHt4sBWkPZ
 WLVx5O4Pd6sRudYPyXbq3XnhsybUCBXKn+k+VpbAQTX4L2uP7sSuzQzcshdXFWK5wmA0
 fVcKHE8QVH2NIQa7+Y8kHZ9XjAxFw2AtLtEEVSwCTx8Zrk8/5awU4ddkilvrqsk0tZuj
 ZNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769650310; x=1770255110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EF08xIaER/Brt/G4K9v56Pf963Rxs8WHbqL4EuG9O1M=;
 b=gm8lawfVs2k9Gpw2w4AojASiqJeNH23fnmXY+T/UrlRyprfWrrJ8P4WtCW1TO2+cNh
 ALMBzSUylP5OkNqaBbUuoJYfWEGwp96hXS132ZduAYJ03m0ms2JYxiz8V4K2iIlWM23J
 eZY+aFVScIn+vngkstb8iSBCSwnez2JQkmoprJdOWGdX61RL0e+n99Cmz1AM91I3ppKp
 al8HBcLLYTL0kV4YZFqypvD+xJK8jVLqJ/12rh81ExvFYQ8XGd6XIPpr0YGD1QDHAbol
 yZSrBt0uU+Ai7MWIh0pieRxPTZCx0VoltCB5ldA85/FJ/kqYeUHc+DCsuokQiURNp/R2
 CFwQ==
X-Gm-Message-State: AOJu0YyJFUO2wL+05APmBkFa1N2tPSbSuTwzlAOA/7mPNrxA0IFDo2Hj
 F47tGrsmZLR+Ak3dKrWoF2PZBTqYF1GayDorOeJpZER83lv2lMILAyWJ8cAo/wUc10FtnteRMu0
 eDJuv
X-Gm-Gg: AZuq6aIS8uMhfexcHRFBsp8+iTiFmrOx4+xK1VXeRWYg7sa6cdDCBQB2csGyyq/VyiO
 DJpoI4YAF1STzGyqEMdmY9sKujWj716ukhtTW/wf1fXZS9PLOQdKfXD4NZbeZFPKJtg9qHn71b5
 LuFZ18+0hs4Jc3jwrj6JFJBNhPJnhXdu7qavPsPo0J6Uxxq1GisRhALn7kn+43Oy241cEYniDeF
 p2p8QTgOpZt0Q9U+HJ4fJVmsiEKqpTVm6SqZnr56lLsyTfQgYMrNSlOiER1buXoHvUTNPUQCBp1
 OOcK7lhbHJXtaHf+y76vbs1yJrMLr7u82CBqwZxPOwSBoEmsclGfFuKVjmXIRlQLmIrpHBXRi34
 +nDi9lmLfw1xV57cpjTVmDW40HFpdl21M1hcQpw7+Oy30eGFoYNM7IV0OY+hOgoW0nju3Di0sbA
 7iea5MJAJ6f/fjiazYZtxWUwrbNluVQkGuGTkZx9NXpQ3pozIes0zLQhoQZIujlqCR
X-Received: by 2002:a17:90a:d603:b0:34e:5516:6655 with SMTP id
 98e67ed59e1d1-353fecde1c9mr6173985a91.9.1769650309931; 
 Wed, 28 Jan 2026 17:31:49 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61e0007sm6627143a91.12.2026.01.28.17.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:31:49 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/20] contrib/plugins/hotblocks: Allow limit to be set as a
 command line argument
Date: Wed, 28 Jan 2026 17:31:19 -0800
Message-ID: <20260129013134.3956938-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alex Bradbury <asb@igalia.com>

Also add documentation for this argument. This allows the default of 20
to be overridden, and is helpful for using the hotblocks plugin for
analysis scripts that require collecting data on a larger number of
blocks (e.g. setting limit=0 to dump information on all blocks).

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst    |  2 ++
 contrib/plugins/hotblocks.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 543efc4d7dc..e8793b0f9ce 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -473,6 +473,8 @@ Behaviour can be tweaked with the following arguments:
     - Description
   * - inline=true|false
     - Use faster inline addition of a single counter.
+  * - limit=N
+    - The number of blocks to be printed. (Default: N = 20, use 0 for no limit).
 
 Hot Pages
 .........
diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 40d8dae1cd3..8ecf0339974 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -84,7 +84,8 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     if (sorted_counts) {
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
 
-        for (i = 0, it = sorted_counts; i < limit && it; i++, it = it->next) {
+        for (i = 0, it = sorted_counts; (limit == 0 || i < limit) && it;
+             i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(
                 report, "0x%016"PRIx64", %d, %ld, %"PRIu64"\n",
@@ -170,6 +171,13 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "limit") == 0) {
+            char *endptr = NULL;
+            limit = g_ascii_strtoull(tokens[1], &endptr, 10);
+            if (endptr == tokens[1] || *endptr != '\0') {
+                fprintf(stderr, "unsigned integer parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
-- 
2.47.3


