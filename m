Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D50C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59H-0003yo-9S; Fri, 13 Jun 2025 10:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ598-0003ss-Lj
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ595-0002JQ-Nv
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lFbnej612dzDYBb7f39MwYrjr48oz8ZqDhNDlugW4Ys=;
 b=MwbQ+1a0PMf7mc9VgseB9Y9gdUFS5I9wP2erUfE/Njf2yZHVaKPISqBAO6Nz35n6v6JJEY
 tJM4rALdzwNMCG06ihUGSKdJLQ+OeQHN72hiMeRRLjmmFyGhLuGlJDwTrc+j26zZ17LW7o
 CwEORAFUAYHQA9pY97FXbvLidoo2SFI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-v_MendHYMlyu78ulwJpLIQ-1; Fri, 13 Jun 2025 10:12:29 -0400
X-MC-Unique: v_MendHYMlyu78ulwJpLIQ-1
X-Mimecast-MFC-AGG-ID: v_MendHYMlyu78ulwJpLIQ_1749823949
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a43988c314so42712271cf.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823949; x=1750428749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFbnej612dzDYBb7f39MwYrjr48oz8ZqDhNDlugW4Ys=;
 b=voWc8dPHMwPVE6KIoeYY5ir1Iz8tF/XBpGbErAuVZ2HA71hC8hI3Pn81Q7ezURY//5
 E7/QI0PVKJC4TyqcYgJIHFpnHQRPtk5vESAPxCAShOa5HzY0rtNzqgL8jvAj8RsiH9qI
 W1QQ8jkXUaZrLTWuFXoY5Is8nBO19dwd2abMX8NFDFHhlyLKIVJgl1VE48gN5BB9GRaC
 5j3QatoZQVnSEKQuwuWqj0pkBiPlE/D2soOBzVZSbc76hzf7fzhDVjeZy5AMeeQ6d5te
 cjU4aH6T7tn7d9W9TM/2eT45ypOTUAdI1OullHdYPlS+/WQy4eEmZGh9n5ERMzikeyoR
 hQuA==
X-Gm-Message-State: AOJu0YydZumnKgtZgeiUkI844pH1RMN+Yy80l4gTnC7ksS2rZ5PTf0GX
 S13/yqKunT0cfBDztfA7cUhlfX4UqqN/r+phh5qWlQz8YWZSKYuDn7Ed2/KL13gM68uflnzBNeA
 pLECWQEakI7MhidjZfM69C0+lzVP2NvYYShDMr1oznzG/KY90aRFfklxmdv0a3nTpsMszPSxWXD
 SY8PkV/FoBwc3/eIcI95IyOfhM7XDJ500RBD7JaQ==
X-Gm-Gg: ASbGncvE5bfQ/sEpsH0E7CuM3VBuaKZsf6meUMeUyFBwksXcNGcp88D6VQT6C0CWj6+
 sOSFGfBK16tj3RIgsE5pJOZ/MlztiFv9L5+wVqGqGDNWtNN6X/Buj8g2mupXW8FiTx0Fv2XlftC
 eIXp57sAi3edCBz+S0hKFH5mkAV8L8YVPuOd+/8zZubh34qfXXujO5PLTlzuU+Gf3iMSoDZhyfz
 JcVcnhArqX+3j+CXvxBACnXMz7ZZsSu5kL43/QuBrmeWuw9BIiu2dvP9cy8sCQTGWb8GAlueWMD
 wKVxmHnUSRM=
X-Received: by 2002:a05:622a:4c11:b0:4a4:3e89:d5bb with SMTP id
 d75a77b69052e-4a72ff5b926mr58332631cf.49.1749823948486; 
 Fri, 13 Jun 2025 07:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3jBCezMjHKwh5TelEMcSngXaYWXkfoSK2+cU1VU07vH371KUmOjYuGXxA6rrEyislU89FTw==
X-Received: by 2002:a05:622a:4c11:b0:4a4:3e89:d5bb with SMTP id
 d75a77b69052e-4a72ff5b926mr58331721cf.49.1749823947899; 
 Fri, 13 Jun 2025 07:12:27 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 07/14] migration/postcopy: Add blocktime fault counts
 per-vcpu
Date: Fri, 13 Jun 2025 10:12:10 -0400
Message-ID: <20250613141217.474825-8-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613141217.474825-1-peterx@redhat.com>
References: <20250613141217.474825-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a field to count how many remote faults one vCPU has taken.  So far
it's still not used, but will be soon.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9dfa92a62d..15ea106910 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -116,6 +116,8 @@ typedef struct PostcopyBlocktimeContext {
     uint64_t *vcpu_blocktime_start;
     /* blocktime per vCPU */
     uint64_t *vcpu_blocktime_total;
+    /* count of faults per vCPU */
+    uint64_t *vcpu_faults_count;
     /* page address per vCPU */
     uintptr_t *vcpu_addr;
     /* total blocktime when all vCPUs are stopped */
@@ -136,6 +138,7 @@ static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
 {
     g_free(ctx->vcpu_blocktime_start);
     g_free(ctx->vcpu_blocktime_total);
+    g_free(ctx->vcpu_faults_count);
     g_free(ctx->vcpu_addr);
     g_free(ctx);
 }
@@ -155,6 +158,7 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
 
     ctx->vcpu_blocktime_start = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
+    ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
     ctx->exit_notifier.notify = migration_exit_cb;
     qemu_add_exit_notifier(&ctx->exit_notifier);
@@ -857,6 +861,7 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     dc->last_begin = current;
     dc->vcpu_blocktime_start[cpu] = current;
     dc->vcpu_addr[cpu] = addr;
+    dc->vcpu_faults_count[cpu]++;
 
     /*
      * The caller should only inject a blocktime entry when the page is
-- 
2.49.0


