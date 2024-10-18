Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A7AD30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oDe-0001Vd-Qy; Fri, 18 Oct 2024 10:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t1oDT-000195-P3
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t1oDP-0002ea-4j
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729262670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eqvcMv9fdiTSg98pEWDzr99aw1UQnXlSysZyeqn3YP0=;
 b=MGj0a7zhqMskipJ6VESncYNfu5w1J5nLdktf5sm0HKhx0FwF3j/CdOB5zugbRUI6MkdSwo
 fqnNCXohOlfGVPaGhq/I58YK2tvkA98tA0rjcN11qPUh2vQv6zqoCkAv9H89xFagsnjguC
 QYTv3HnbjaO2rRoRFQ/rCVLD2e+lWUI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-zs-JDimKPuGzeB2y-OFXgw-1; Fri, 18 Oct 2024 10:44:29 -0400
X-MC-Unique: zs-JDimKPuGzeB2y-OFXgw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b14fc05206so285409285a.2
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 07:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729262668; x=1729867468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eqvcMv9fdiTSg98pEWDzr99aw1UQnXlSysZyeqn3YP0=;
 b=LxeSbPCruFZfZgKVE+QauqzCdAYZWHWk4i25ZxFf5ClixFxh25sVEQfUPjz7bhKsv+
 X8LUUeTLHxuzHpvWhI2ndGdTJ48OtGBPyyCGw9TZB0/r92zYfC9agTSaMKQK9bLx6tmU
 tEKjPr/HOn13pD8x1xIbMVigLBHsT80ye/GgFNsnQilJ/h2KZWI4QJPKfgGAkfSAI6S1
 MaRXJqc+NShNOgsZdqyj7ObUoyJAIhTf7t307fS/UO+jCp21FzhMD7/h+C5ywSowyiWf
 vr2hnkbNbVvXy5WuaEigmB3y8aYAJTLXkHr5b3cQi5DMa9NEBg9kH5l3hfb4RbDnjXVI
 itaA==
X-Gm-Message-State: AOJu0Yy8qaEGct1MMN8bysnwzEQN3h9sp2O0oJfJDITkiG0WWKJMhxEc
 M2eimM+Sclt63VHlBdhiflUPmsICXvPon49EQwE7qkOhq88yqZyfPTMhWTrgCKWvwYhniXcbawh
 lQZ4CYzpj30OkIwgMQ6daILIuyLVyzfS+4NPMxPniRUiAkV/gXP5rxaqSU/ASlSm9A0W64zpv8R
 IQCqc7WxvTLywFQ8dwT7QJf74ZIbH5sm34nA==
X-Received: by 2002:a05:620a:29d3:b0:7af:cdf9:8c30 with SMTP id
 af79cd13be357-7b157b7c7c1mr343680585a.37.1729262668357; 
 Fri, 18 Oct 2024 07:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBNiWxcnCjx9+YuVNWKg30Dw+MMqWOzctQKULgyC0zAnuB3EzZp+1fJjOWO5S+ypHGRjFOOA==
X-Received: by 2002:a05:620a:29d3:b0:7af:cdf9:8c30 with SMTP id
 af79cd13be357-7b157b7c7c1mr343676785a.37.1729262667924; 
 Fri, 18 Oct 2024 07:44:27 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b156f8b2cdsm75435785a.8.2024.10.18.07.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:44:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] Migration: Add trace points for vmstate handler
 insertion/removal
Date: Fri, 18 Oct 2024 10:44:26 -0400
Message-ID: <20241018144426.826802-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SaveStateEntry has lots of magics internally, on alias_id, get_id() being
able to overwrite the original idstr, compat fields, ID_ANY, and so on.  It
may not be always clear that what all these fields are being registered for
some device we care.

Add trace points for SaveStateEntry insertions/removals, so that we know
what was being registered.  For insertions, we dump everything that might
be useful.  For removal, only section_id is needed because that's the
unique identifier for an SeveStateEntry.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c     | 7 +++++++
 migration/trace-events | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index e796436979..57f058bd40 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -718,6 +718,11 @@ static void savevm_state_handler_insert(SaveStateEntry *nse)
 
     assert(priority <= MIG_PRI_MAX);
 
+    trace_vmstate_handler_insert(
+        nse->idstr, nse->instance_id, nse->alias_id, nse->version_id,
+        nse->section_id, nse->compat ? nse->compat->idstr : NULL,
+        nse->compat ? nse->compat->instance_id : 0);
+
     /*
      * This should never happen otherwise migration will probably fail
      * silently somewhere because we can be wrongly applying one
@@ -754,6 +759,8 @@ static void savevm_state_handler_remove(SaveStateEntry *se)
     SaveStateEntry *next;
     MigrationPriority priority = save_state_priority(se);
 
+    trace_vmstate_handler_remove(se->section_id);
+
     if (se == savevm_state.handler_pri_head[priority]) {
         next = QTAILQ_NEXT(se, entry);
         if (next != NULL && save_state_priority(next) == priority) {
diff --git a/migration/trace-events b/migration/trace-events
index 0638183056..3411f2f699 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -50,6 +50,8 @@ vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
 vmstate_downtime_save(const char *type, const char *idstr, uint32_t instance_id, int64_t downtime) "type=%s idstr=%s instance_id=%d downtime=%"PRIi64
 vmstate_downtime_load(const char *type, const char *idstr, uint32_t instance_id, int64_t downtime) "type=%s idstr=%s instance_id=%d downtime=%"PRIi64
 vmstate_downtime_checkpoint(const char *checkpoint) "%s"
+vmstate_handler_insert(char *idstr, uint32_t instance_id, int alias_id, int version_id, int section_id, char *compat_idstr, int compat_instance_id) "id=%s instance_id=%"PRIu32" alias_id=%d version_id=%d section_id=%d compat_id=%s compat_instance_id=%d"
+vmstate_handler_remove(int section_id) "section_id=%d"
 postcopy_pause_incoming(void) ""
 postcopy_pause_incoming_continued(void) ""
 postcopy_page_req_sync(void *host_addr) "sync page req %p"
-- 
2.45.0


