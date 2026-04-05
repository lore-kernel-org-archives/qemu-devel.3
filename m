Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891F9E9D80A
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 15:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9PN5-0006ni-3K; Sun, 05 Apr 2026 11:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w9PN3-0006nP-Ha
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 11:26:41 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vikingtc4@gmail.com>)
 id 1w9PN1-0008S9-OG
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 11:26:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82cf976ecacso1275050b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775402798; x=1776007598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1GcBsKVAD50cVidc+/vzB6+ClCQQmkI2qkFkMTszqY=;
 b=NbE8dZpsK1vjMNTAz7dfdIm7F/wNBgHcpPgmtddchVKJM5lH5aUOq5JsXr2gkxDbyW
 rZvE4QLKr6CZqFPcSeCQJwSQHQJmENMtn+mBaQEFKUnYkloR6W+/PI6RzA/t1zdB813D
 WNuZGyiVELZ/m4phHTGP3GbqqXVv7o10ULA3aQkTqc87lKtPwn+X+uXBjCY5twJ1BqPF
 EiHU6buvQJPXt1dE4fdq1ffXoG8lt59y/wp9c+kVJD/5WNWyetkdiFYaFGbSV4/JWFe7
 w7oU8iOOEJfWeNyLE2Ikf4DBMYSzwN1cKPpljtNLmp+ihatSkGnenNM2U6MVVfPnYcVQ
 dADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775402798; x=1776007598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y1GcBsKVAD50cVidc+/vzB6+ClCQQmkI2qkFkMTszqY=;
 b=alio23m5sZQoTiFzhKtPsT5nCXu7hZyL5WfFa+VzRAmPb/TyNJFg6aueBR188iDJPL
 vkLE3lffEGg/v+u6cxHyo77kKyjl1A2xmIIQcQO/9y3y5nstK1LpGo7ag1tyOUDVqFsE
 7T61PXNvGROAUBMeKfnRPQ7k8qKlzulrsxttSwSccjElVI0uwEYhbf9106nUOnvZhiqg
 0cIbN+VnLpSWivI0/S32ShrTt89S0EtX8r8P/U84djTaqepvrn/qAeZ9AsyCf+NZG4v2
 KvABr/F1Of0ltbZOR51ggIhv8+fM1ax+Ze88ujTxZaa07lCU8ZA/w5qW3EWQyGxdX5VN
 qQ0g==
X-Gm-Message-State: AOJu0YyAZIqxxNz/g783Me1U3zMh/fS01Yz7aTdTNFV6PGYusc+cXJ9T
 kT2Ohes0C2UaJqeD2gFYqSKjCZC7kD4tsfdZM+3XZCOf12cqrTqM7PMkkxu19Z42elg=
X-Gm-Gg: AeBDiesLAOrIqqRDalj2Gez8mxlQpMQZbQIU0F474Duj6LL3U3iPzdl0+/HlpN0Nkz0
 YypDGwlPybC585NPgt2y2vUm9vt8DG8rPoXpNfp3C57SAscXRZ93hmBXhPdyIHHrpOipm+qjBdN
 Q3q4zVo38nmyOqGYi81RwzkBZoNm5pnCYv1aex6p4RdbBUKw1I3Tw2XMBwZG/fmd7g5i5GPezer
 S8svwTosIh1ljo8gbxJXs+srqBaskbPcSOYCZ78O9o2fFQFADzHk25b54QT7AqcqawflgQn4ZQP
 JEQbhbOymnyeULO24YZAKvo6lS68FO8hpkjpbgiRJgqvkUBTVKEy3iJxQ1bJHVjXl148bt8RDRL
 3L5jer1rInn7xkxzWG6rbGObbIcaxAfpTEywsOPqisWgzw06x7YkfWkkLSMI9v4A+ZYZ8WQDR6u
 nAowm+Kb9O/XvAJDFkg/1ub1YqKMCmxIaKtkLPrcVWDsUY3zsAtWLK8CWcbQ==
X-Received: by 2002:a05:6a00:3499:b0:829:8041:83f with SMTP id
 d2e1a72fcca58-82d0da2e724mr8742921b3a.7.1775402798051; 
 Sun, 05 Apr 2026 08:26:38 -0700 (PDT)
Received: from localhost.localdomain ([123.19.199.205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c72967sm11187938b3a.49.2026.04.05.08.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 08:26:37 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
X-Google-Original-From: Trieu Huynh <viking4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/2] migration: expose RAM stats and timing on destination via
 query-migrate
Date: Sun,  5 Apr 2026 22:26:08 +0700
Message-ID: <20260405152612.93027-3-viking4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405152612.93027-1-viking4@gmail.com>
References: <20260405152612.93027-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=vikingtc4@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Trieu Huynh <vikingtc4@gmail.com>

MigrationStats had all-required QAPI fields, so partially populating
info->ram on the destination would force display of source-only metrics
(dirty-sync-count, precopy-bytes, etc.) as misleading zeros.

Make those source-only fields optional with '*' in the QAPI schema.
Update populate_ram_info() to set them via has_* setters so source
output is unchanged.

As per schema's changes, fill_destination_migration_info() can now
populate info->ram for the COMPLETED case with the fields that are
meaningful on the receive side:

  * total, remaining, page-size         (RAM layout)
  * transferred, normal, normal-bytes   (bytes/pages received)
  * duplicate                           (zero pages received)
  * mbps                                (throughput: transferred*8
                                         /time_ms/1000)
  * pages-per-second                    (total pages / duration in
                                         seconds)

Others optional fields (dirty-sync-count, precopy-bytes,
downtime-bytes, postcopy-bytes, multifd-bytes, postcopy-requests,
dirty-sync-missed-zero-copy, dirty-pages-rate) are left unset and
are absent from the destination output.

On dst, {"execute":"query-migrate"}
* As-is:
{
    "return": {
        "status": "completed"
}
* To-be:
{
    "return": {
        "status": "completed",
        "total-time": 94,
        "ram": {
            "total": 554508288,
            "pages-per-second": 1440234,
            "page-size": 4096,
            "remaining": 0,
            "mbps": 97.955404255319152,
            "transferred": 1150976,
            "duplicate": 135101,
            "normal-bytes": 1150976,
            "normal": 281
        }
    }
}

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 migration/migration.c | 35 +++++++++++++++++++++++++++++++++++
 qapi/migration.json   | 14 +++++++-------
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 17c9a8b344..925d29890d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1063,17 +1063,24 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     info->ram->normal = qatomic_read(&mig_stats.normal_pages);
     info->ram->normal_bytes = info->ram->normal * page_size;
     info->ram->mbps = s->mbps;
+    info->ram->has_dirty_sync_count = true;
     info->ram->dirty_sync_count =
         qatomic_read(&mig_stats.dirty_sync_count);
+    info->ram->has_dirty_sync_missed_zero_copy = true;
     info->ram->dirty_sync_missed_zero_copy =
         qatomic_read(&mig_stats.dirty_sync_missed_zero_copy);
+    info->ram->has_postcopy_requests = true;
     info->ram->postcopy_requests =
         qatomic_read(&mig_stats.postcopy_requests);
     info->ram->page_size = page_size;
+    info->ram->has_multifd_bytes = true;
     info->ram->multifd_bytes = qatomic_read(&mig_stats.multifd_bytes);
     info->ram->pages_per_second = s->pages_per_second;
+    info->ram->has_precopy_bytes = true;
     info->ram->precopy_bytes = qatomic_read(&mig_stats.precopy_bytes);
+    info->ram->has_downtime_bytes = true;
     info->ram->downtime_bytes = qatomic_read(&mig_stats.downtime_bytes);
+    info->ram->has_postcopy_bytes = true;
     info->ram->postcopy_bytes = qatomic_read(&mig_stats.postcopy_bytes);
 
     if (migrate_xbzrle()) {
@@ -1094,6 +1101,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
 
     if (s->state != MIGRATION_STATUS_COMPLETED) {
         info->ram->remaining = ram_bytes_remaining();
+        info->ram->has_dirty_pages_rate = true;
         info->ram->dirty_pages_rate =
            qatomic_read(&mig_stats.dirty_pages_rate);
     }
@@ -1209,6 +1217,33 @@ static void fill_destination_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_COMPLETED:
         info->has_status = true;
         fill_destination_postcopy_migration_info(info);
+        if (mis->total_time > 0) {
+            info->has_total_time = true;
+            info->total_time = mis->total_time;
+        }
+        {
+            size_t page_size = qemu_target_page_size();
+            uint64_t normal  = mis->received_normal_pages;
+            uint64_t zero    = mis->received_zero_pages;
+            uint64_t xbzrle  = mis->received_xbzrle_pages;
+
+            info->ram = g_malloc0(sizeof(*info->ram));
+            info->ram->total        = ram_bytes_total();
+            info->ram->remaining    = 0;
+            info->ram->normal       = normal + xbzrle;
+            info->ram->normal_bytes = (normal + xbzrle) * page_size;
+            info->ram->duplicate    = zero;
+            info->ram->transferred  = (normal + xbzrle) * page_size;
+            info->ram->page_size    = page_size;
+
+            if (info->has_total_time) {
+                info->ram->mbps = info->ram->transferred * 8.0
+                                  / info->total_time / 1000.0;
+                info->ram->pages_per_second = (normal + xbzrle + zero)
+                                              * 1000.0 / info->total_time;
+            }
+            /* source-only optional omitted from output */
+        }
         break;
     default:
         return;
diff --git a/qapi/migration.json b/qapi/migration.json
index 7134d4ce47..a695d04a22 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -68,13 +68,13 @@
   'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
            'duplicate': 'int',
            'normal': 'int',
-           'normal-bytes': 'int', 'dirty-pages-rate': 'int',
-           'mbps': 'number', 'dirty-sync-count': 'int',
-           'postcopy-requests': 'int', 'page-size': 'int',
-           'multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
-           'precopy-bytes': 'uint64', 'downtime-bytes': 'uint64',
-           'postcopy-bytes': 'uint64',
-           'dirty-sync-missed-zero-copy': 'uint64' } }
+           'normal-bytes': 'int', '*dirty-pages-rate': 'int',
+           'mbps': 'number', '*dirty-sync-count': 'int',
+           '*postcopy-requests': 'int', 'page-size': 'int',
+           '*multifd-bytes': 'uint64', 'pages-per-second': 'uint64',
+           '*precopy-bytes': 'uint64', '*downtime-bytes': 'uint64',
+           '*postcopy-bytes': 'uint64',
+           '*dirty-sync-missed-zero-copy': 'uint64' } }
 
 ##
 # @XBZRLECacheStats:
-- 
2.43.0


