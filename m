Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5882AC5B552
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 01:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGbe-0006Pe-ID; Mon, 02 Jun 2025 21:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGbd-0006PA-2F
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:21 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uMGba-0001Pb-Kp
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:38:20 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 091FD1F38D;
 Tue,  3 Jun 2025 01:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xwhv7kZ76ctBgvWwEJwBH34oWjsd5YnGAL8IAiI5Sc=;
 b=XPCEvjEKJxkvQA/VjhrqOyM3Xau/9VLGXMdireGj22D389OdL+mYEHRGjBfDTmpQwwNFT5
 tmtpcbhUEAkiUd7XbOJA7utQETe3r//eWgYGLQFhKN2ZMarh9EI17YB2UKwOX+xPb8WkcD
 LMLJMWptMNgjpChClbCLRV/Jkg1Qevc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914697;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xwhv7kZ76ctBgvWwEJwBH34oWjsd5YnGAL8IAiI5Sc=;
 b=KNC70mD5dickLlXouEhF4VtoAuSxzSXdSbBbvdy4IegNreVMMyfJAxb4MAK9DEKfeVgpSI
 y/sQ03unioDygDAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748914697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xwhv7kZ76ctBgvWwEJwBH34oWjsd5YnGAL8IAiI5Sc=;
 b=XPCEvjEKJxkvQA/VjhrqOyM3Xau/9VLGXMdireGj22D389OdL+mYEHRGjBfDTmpQwwNFT5
 tmtpcbhUEAkiUd7XbOJA7utQETe3r//eWgYGLQFhKN2ZMarh9EI17YB2UKwOX+xPb8WkcD
 LMLJMWptMNgjpChClbCLRV/Jkg1Qevc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748914697;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xwhv7kZ76ctBgvWwEJwBH34oWjsd5YnGAL8IAiI5Sc=;
 b=KNC70mD5dickLlXouEhF4VtoAuSxzSXdSbBbvdy4IegNreVMMyfJAxb4MAK9DEKfeVgpSI
 y/sQ03unioDygDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A72C13700;
 Tue,  3 Jun 2025 01:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yK67DgdSPmiNLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Jun 2025 01:38:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/21] migration: Normalize tls arguments
Date: Mon,  2 Jun 2025 22:37:50 -0300
Message-Id: <20250603013810.4772-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603013810.4772-1-farosas@suse.de>
References: <20250603013810.4772-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The migration parameters tls_creds, tls_authz and tls_hostname
currently have a non-uniform handling. When used as arguments to
migrate-set-parameters, their type is StrOrNull and when used as
return value from query-migrate-parameters, their type is a plain
string.

Not only having to convert between the types is cumbersome, but it
also creates the issue of requiring two different QAPI types to be
used, one for each command. MigrateSetParameters is used for
migrate-set-parameters with the TLS arguments as StrOrNull while
MigrationParameters is used for query-migrate-parameters with the TLS
arguments as str.

Since StrOrNull could be considered a superset of str, change the type
of the TLS arguments in MigrationParameters to StrOrNull and add a
helper to ensure they're never actually used as QTYPE_QNULL.

This will allow the type duplication to be removed in the next
patches.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c |   8 +-
 migration/migration.c          |   2 +
 migration/options.c            | 149 ++++++++++++++++++++-------------
 migration/options.h            |   1 +
 migration/tls.c                |   2 +-
 qapi/migration.json            |   6 +-
 6 files changed, 99 insertions(+), 69 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index e8a563c7d8..bc8179c582 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -276,14 +276,12 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: %u\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_CPU_THROTTLE),
             params->max_cpu_throttle);
-        assert(params->tls_creds);
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_CREDS),
-            params->tls_creds);
-        assert(params->tls_hostname);
+                       params->tls_creds ? params->tls_creds->u.s : "");
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_HOSTNAME),
-            params->tls_hostname);
+                       params->tls_hostname ? params->tls_hostname->u.s : "");
         assert(params->has_max_bandwidth);
         monitor_printf(mon, "%s: %" PRIu64 " bytes/second\n",
             MigrationParameter_str(MIGRATION_PARAMETER_MAX_BANDWIDTH),
@@ -319,7 +317,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
             params->max_postcopy_bandwidth);
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
-            params->tls_authz);
+                       params->tls_authz ? params->tls_authz->u.s : "");
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
diff --git a/migration/migration.c b/migration/migration.c
index 4697732bef..f65cb81b6d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -4053,6 +4053,8 @@ static void migration_instance_finalize(Object *obj)
 {
     MigrationState *ms = MIGRATION_OBJ(obj);
 
+    migrate_tls_opts_free(&ms->parameters);
+
     qemu_mutex_destroy(&ms->error_mutex);
     qemu_mutex_destroy(&ms->qemu_file_lock);
     qemu_sem_destroy(&ms->wait_unplug_sem);
diff --git a/migration/options.c b/migration/options.c
index 162c72cda4..45a95dc6da 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -162,9 +162,11 @@ const Property migration_properties[] = {
     DEFINE_PROP_SIZE("announce-step", MigrationState,
                       parameters.announce_step,
                       DEFAULT_MIGRATE_ANNOUNCE_STEP),
-    DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
-    DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
-    DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
+    /*
+     * tls-creds, tls-hostname and tls-authz are of type StrOrNull,
+     * which can't be easily handled (if at all) by qdev. So these
+     * will not be exposed as global migration options (-global).
+     */
     DEFINE_PROP_UINT64("x-vcpu-dirty-limit-period", MigrationState,
                        parameters.x_vcpu_dirty_limit_period,
                        DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD),
@@ -379,13 +381,6 @@ bool migrate_rdma(void)
     return s->rdma_migration;
 }
 
-bool migrate_tls(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->parameters.tls_creds && *s->parameters.tls_creds;
-}
-
 typedef enum WriteTrackingSupport {
     WT_SUPPORT_UNKNOWN = 0,
     WT_SUPPORT_ABSENT,
@@ -834,21 +829,44 @@ const char *migrate_tls_authz(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.tls_authz;
+    if (s->parameters.tls_authz &&
+        s->parameters.tls_authz->type == QTYPE_QSTRING &&
+        *s->parameters.tls_authz->u.s) {
+        return s->parameters.tls_authz->u.s;
+    }
+
+    return NULL;
 }
 
 const char *migrate_tls_creds(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.tls_creds;
+    if (s->parameters.tls_creds &&
+        s->parameters.tls_creds->type == QTYPE_QSTRING &&
+        *s->parameters.tls_creds->u.s) {
+        return s->parameters.tls_creds->u.s;
+    }
+
+    return NULL;
 }
 
 const char *migrate_tls_hostname(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return s->parameters.tls_hostname;
+    if (s->parameters.tls_hostname &&
+        s->parameters.tls_hostname->type == QTYPE_QSTRING &&
+        *s->parameters.tls_hostname->u.s) {
+        return s->parameters.tls_hostname->u.s;
+    }
+
+    return NULL;
+}
+
+bool migrate_tls(void)
+{
+    return !!migrate_tls_creds();
 }
 
 uint64_t migrate_vcpu_dirty_limit_period(void)
@@ -888,6 +906,36 @@ AnnounceParameters *migrate_announce_params(void)
     return &ap;
 }
 
+void migrate_tls_opts_free(MigrationParameters *params)
+{
+    qapi_free_StrOrNull(params->tls_creds);
+    qapi_free_StrOrNull(params->tls_hostname);
+    qapi_free_StrOrNull(params->tls_authz);
+}
+
+/* needs BQL if dst is part of s->parameters */
+static void tls_option_set_str(StrOrNull **dstp, StrOrNull *src)
+{
+    StrOrNull *dst = *dstp;
+
+    assert(!dst);
+
+    dst = *dstp = g_new0(StrOrNull, 1);
+    dst->type = QTYPE_QSTRING;
+
+    if (!src) {
+        dst->u.s = g_strdup("");
+        return;
+    }
+
+    if (src->type == QTYPE_QSTRING) {
+        dst->u.s = g_strdup(src->u.s);
+    } else {
+        assert(src->type == QTYPE_QNULL);
+        dst->u.s = g_strdup("");
+    }
+}
+
 MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 {
     MigrationParameters *params;
@@ -903,10 +951,11 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->cpu_throttle_increment = s->parameters.cpu_throttle_increment;
     params->has_cpu_throttle_tailslow = true;
     params->cpu_throttle_tailslow = s->parameters.cpu_throttle_tailslow;
-    params->tls_creds = g_strdup(s->parameters.tls_creds);
-    params->tls_hostname = g_strdup(s->parameters.tls_hostname);
-    params->tls_authz = g_strdup(s->parameters.tls_authz ?
-                                 s->parameters.tls_authz : "");
+
+    tls_option_set_str(&params->tls_creds, s->parameters.tls_creds);
+    tls_option_set_str(&params->tls_hostname, s->parameters.tls_hostname);
+    tls_option_set_str(&params->tls_authz, s->parameters.tls_authz);
+
     params->has_max_bandwidth = true;
     params->max_bandwidth = s->parameters.max_bandwidth;
     params->has_avail_switchover_bandwidth = true;
@@ -963,9 +1012,6 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
 
 void migrate_params_init(MigrationParameters *params)
 {
-    params->tls_hostname = g_strdup("");
-    params->tls_creds = g_strdup("");
-
     /* Set has_* up only for parameter checks */
     params->has_throttle_trigger_threshold = true;
     params->has_cpu_throttle_initial = true;
@@ -1142,7 +1188,8 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
 #ifdef CONFIG_LINUX
     if (migrate_zero_copy_send() &&
         ((params->has_multifd_compression && params->multifd_compression) ||
-         (params->tls_creds && *params->tls_creds))) {
+         (params->tls_creds && params->tls_creds->type == QTYPE_QSTRING &&
+          *params->tls_creds->u.s))) {
         error_setg(errp,
                    "Zero copy only available for non-compressed non-TLS multifd migration");
         return false;
@@ -1204,18 +1251,24 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     }
 
     if (params->tls_creds) {
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        dest->tls_creds = params->tls_creds->u.s;
+        tls_option_set_str(&dest->tls_creds, params->tls_creds);
+    } else {
+        /* drop the reference, it's owned by s->parameters */
+        dest->tls_creds = NULL;
     }
 
     if (params->tls_hostname) {
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        dest->tls_hostname = params->tls_hostname->u.s;
+        tls_option_set_str(&dest->tls_hostname, params->tls_hostname);
+    } else {
+        /* drop the reference, it's owned by s->parameters */
+        dest->tls_hostname = NULL;
     }
 
     if (params->tls_authz) {
-        assert(params->tls_authz->type == QTYPE_QSTRING);
-        dest->tls_authz = params->tls_authz->u.s;
+        tls_option_set_str(&dest->tls_authz, params->tls_authz);
+    } else {
+        /* drop the reference, it's owned by s->parameters */
+        dest->tls_authz = NULL;
     }
 
     if (params->has_max_bandwidth) {
@@ -1320,21 +1373,18 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     }
 
     if (params->tls_creds) {
-        g_free(s->parameters.tls_creds);
-        assert(params->tls_creds->type == QTYPE_QSTRING);
-        s->parameters.tls_creds = g_strdup(params->tls_creds->u.s);
+        qapi_free_StrOrNull(s->parameters.tls_creds);
+        tls_option_set_str(&s->parameters.tls_creds, params->tls_creds);
     }
 
     if (params->tls_hostname) {
-        g_free(s->parameters.tls_hostname);
-        assert(params->tls_hostname->type == QTYPE_QSTRING);
-        s->parameters.tls_hostname = g_strdup(params->tls_hostname->u.s);
+        qapi_free_StrOrNull(s->parameters.tls_hostname);
+        tls_option_set_str(&s->parameters.tls_hostname, params->tls_hostname);
     }
 
     if (params->tls_authz) {
-        g_free(s->parameters.tls_authz);
-        assert(params->tls_authz->type == QTYPE_QSTRING);
-        s->parameters.tls_authz = g_strdup(params->tls_authz->u.s);
+        qapi_free_StrOrNull(s->parameters.tls_authz);
+        tls_option_set_str(&s->parameters.tls_authz, params->tls_authz);
     }
 
     if (params->has_max_bandwidth) {
@@ -1433,32 +1483,11 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
 {
     MigrationParameters tmp;
 
-    /* TODO Rewrite "" to null instead for all three tls_* parameters */
-    if (params->tls_creds
-        && params->tls_creds->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_creds->u.n);
-        params->tls_creds->type = QTYPE_QSTRING;
-        params->tls_creds->u.s = strdup("");
-    }
-    if (params->tls_hostname
-        && params->tls_hostname->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_hostname->u.n);
-        params->tls_hostname->type = QTYPE_QSTRING;
-        params->tls_hostname->u.s = strdup("");
-    }
-    if (params->tls_authz
-        && params->tls_authz->type == QTYPE_QNULL) {
-        qobject_unref(params->tls_authz->u.n);
-        params->tls_authz->type = QTYPE_QSTRING;
-        params->tls_authz->u.s = strdup("");
-    }
-
     migrate_params_test_apply(params, &tmp);
 
-    if (!migrate_params_check(&tmp, errp)) {
-        /* Invalid parameter */
-        return;
+    if (migrate_params_check(&tmp, errp)) {
+        migrate_params_apply(params, errp);
     }
 
-    migrate_params_apply(params, errp);
+    migrate_tls_opts_free(&tmp);
 }
diff --git a/migration/options.h b/migration/options.h
index 82d839709e..999eee6f3b 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -91,4 +91,5 @@ ZeroPageDetection migrate_zero_page_detection(void);
 
 bool migrate_params_check(MigrationParameters *params, Error **errp);
 void migrate_params_init(MigrationParameters *params);
+void migrate_tls_opts_free(MigrationParameters *params);
 #endif
diff --git a/migration/tls.c b/migration/tls.c
index 5cbf952383..8a89d3f767 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -126,7 +126,7 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
     }
 
     const char *tls_hostname = migrate_tls_hostname();
-    if (tls_hostname && *tls_hostname) {
+    if (tls_hostname) {
         hostname = tls_hostname;
     }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 41826bde45..fa42d94810 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1293,9 +1293,9 @@
             '*cpu-throttle-initial': 'uint8',
             '*cpu-throttle-increment': 'uint8',
             '*cpu-throttle-tailslow': 'bool',
-            '*tls-creds': 'str',
-            '*tls-hostname': 'str',
-            '*tls-authz': 'str',
+            '*tls-creds': 'StrOrNull',
+            '*tls-hostname': 'StrOrNull',
+            '*tls-authz': 'StrOrNull',
             '*max-bandwidth': 'size',
             '*avail-switchover-bandwidth': 'size',
             '*downtime-limit': 'uint64',
-- 
2.35.3


