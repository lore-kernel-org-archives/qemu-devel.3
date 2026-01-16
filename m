Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAA7D47CA3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 00:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgY42-0005x0-5l; Thu, 15 Jan 2026 19:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgY3w-0005vy-Kz
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:51:40 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1vgY3s-0000qa-Qf
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 19:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:From:From
 :Subject; bh=5BqdBaV9GCY2kVp4eGlMG6Vgj6I2T1fTpTIgfWKCIyE=; b=o8+rWcNEI5hPkVgG
 xOBodYGyJL9k0EN0itBmJyiTs2VdWBMr00uSUhtB7wvpo+h4zQdqWwVotfYUQFgskEBy3+6n2BhHW
 rK5sc7H9+wwsnM3lylC0YA6C7FlPc8bC6rAp7f5bW9epFMcDx/AxZG+pgOjpm2ZOL5OYB5DkKz448
 WKsb+Bom22Fg9/kmR1vJuiENIONWbtlEWI4+n8bncnbaCsBHD2P23DFrlDmvGiTG2Fbirhx5SDa9R
 4cEzN5e+HRIAYFRvUzuWM82KtXpDB9hSKKDJX/rKjTMjwHM8UHqB7H6Acazy2MNuQfvw7T+iFy4z/
 QO9kdBbUHpSMVcC3PQ==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <dave@treblig.org>) id 1vgY3r-0000000F7wG-1ifo;
 Fri, 16 Jan 2026 00:51:35 +0000
From: dave@treblig.org
To: dave@treblig.org, armbru@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] hmp-commands-info.hx: Move definition of "info accel"
Date: Fri, 16 Jan 2026 00:50:45 +0000
Message-ID: <20260116005050.376616-2-dave@treblig.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116005050.376616-1-dave@treblig.org>
References: <20260116005050.376616-1-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Markus Armbruster <armbru@redhat.com>

Commit c10eb740108 (accel/system: Add 'info accel' on human monitor)
inserted "info accel" in the middle of "info sync-profile".  Move it
behind "info sync-profile".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hmp-commands-info.hx | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 41674dcbe1..74c741f80e 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -267,18 +267,6 @@ ERST
         .cmd        = hmp_info_sync_profile,
     },
 
-    {
-        .name       = "accel",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show accelerator statistics",
-    },
-
-SRST
-  ``info accel``
-    Show accelerator statistics.
-ERST
-
 SRST
   ``info sync-profile [-m|-n]`` [*max*]
     Show synchronization profiling info, up to *max* entries (default: 10),
@@ -294,6 +282,18 @@ SRST
     being coalesced.
 ERST
 
+    {
+        .name       = "accel",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show accelerator statistics",
+    },
+
+SRST
+  ``info accel``
+    Show accelerator statistics.
+ERST
+
     {
         .name       = "kvm",
         .args_type  = "",
-- 
2.52.0


