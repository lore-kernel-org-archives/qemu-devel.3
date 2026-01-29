Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A2ED73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyN-0004Wz-J8; Thu, 29 Jan 2026 12:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyK-0004Py-L9
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:24 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyI-0000dj-TY
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:24 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34ccbf37205so586490a91.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708301; x=1770313101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72yLhNJuTU543aChFcgG+P6Xk9XLsSmbf2NcxT4jbhk=;
 b=UjswphfsLdr1iVBJKl/zSGmGCfhnhJNWxBFsxNysK6SQsjnB+7l0HZKGv72zVNYqKq
 j4j/qTNx7CrvTH7CrHWw1xoayR6902PzI8RzKQfgkIOXJ56/79+dcpozcgcSlf4mUFaP
 ME6TQYFKSwq5LAouwv0aRtTpafz8+92eqQKs+p/QFrYdjsZE7wpZ6ICpJCodzhvh6GpZ
 peeaHMjHXbodh9tRNLsojsEXMb8YqRNE8LTQrVHhVrd+bC+npLgr/1FPVm1KsK+3xusp
 vvSgnAZdsUJ2QnnvX8JMRsH4zpJXaPvNOYqz5XWntillGIEH0YEszdm+xNIcaDREurld
 u7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708301; x=1770313101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=72yLhNJuTU543aChFcgG+P6Xk9XLsSmbf2NcxT4jbhk=;
 b=mL56mpu5ZbniVaO/g7yvR9Qc/vGWnv3ZoVW2ou4/CzRwme2YVXECI3N/RuaLmF7TPQ
 zx5YJ0gDx/j14oZThJTVTGyN1xg+tT5p4yKFAqW5pfcY+GcTAKl3pN/Zz1umtRr1qPft
 O7LNqGT5UMWlkUhoClMWzpe+slEl6snQK0ypCWu4b0Zn4eZ0XjZWKEKhFPYBcHMoPYsm
 wTXNJlJLH2NizRbz/riiwYZVO5jYYucWcwVXbT8Qs8UpWgpOcXMbGhy7q9jn6XOVwmay
 fsbQ7ShlIG0wBoYqzJMfkUCpxUcnX6NWv48pkzarEW3YChNT1rOzmaDtPaBFG40ybNXO
 aOow==
X-Gm-Message-State: AOJu0YwGMziyfWyZUFTVGzb9HVsN6NZEI/N9eVIKIyT+m2hgDS2AKqso
 OfbRBajHCdgl6V2W5raWkXzazHp+Gec4WxBNtdoPtpAMBs7VWevcR+MWXSLN19p+KQnb+1U1AHr
 T+eug
X-Gm-Gg: AZuq6aLoJWZ31i5E1skLmdJYcYZd9FKrC1FJv3xLVt+B0XNWp0Xor41CIIB5pFIpKbI
 xkdyHwZnHwD8awFQPA4CKelwL445hwLIKMch4Jsk8Bwn0K/05fkv4CdP8dvbF2Rn8ieYW5hpcjN
 1K/Mkio4txTsTmTiX4KYS30Mf3sdy7My3Wofx58ypIDOsdIcZvfUGGVBiFVaT0p9BdT9hgT8Yux
 QaVDH91PteVg0ojguJcv7WMkvohfbPL54Cxfg4xpz02MfdAKK0Fvzyk6tHfkR5h9PucoPeWolAt
 yRFC3B32K7U1uReGFZHjjbRM3pkpRVc1UYbZEBUtTzg9pBAYdk8uS9tkzZ9CElLX32ypbKlbGW4
 QzWU0qJvEj6PkK2CfjypNsQkbP/KPaL7HdYYJrX3+1SIfspNRIpUqV68AZRKFE2sPeXfi+R3+2g
 U9ub5Zoivq5k6BI/9rgz2SfUci4D2PTzNSBOMCKAZTYlzodjZ8X6WCkAxcqEosDmKfJRssZhEEZ
 EE=
X-Received: by 2002:a17:90a:e7c7:b0:34e:5516:6655 with SMTP id
 98e67ed59e1d1-3543b3097b4mr206930a91.9.1769708301260; 
 Thu, 29 Jan 2026 09:38:21 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:20 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/21] contrib/plugins/hotblocks: Allow limit to be set as a
 command line argument
Date: Thu, 29 Jan 2026 09:37:51 -0800
Message-ID: <20260129173811.138036-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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
Link: https://lore.kernel.org/qemu-devel/58281d6e54bcad1802e8d3dc8d8501d54c2a971e.1753857212.git.asb@igalia.com
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


