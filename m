Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C618606A331
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M51xt1Tq;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qkXe++Zh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7F1-0005fN-Nm; Wed, 28 Oct 2026 13:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EX-00050o-1n
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7ET-0003UF-C5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nSlL15lWvmG2UcqLAQ8JC/mDb8TNmvQnypS5u18oTBI=;
 b=M51xt1Tqpusu8bZJL4pVwUmfCWjBt//JhlF7RXvCNcMGZaMyZDWfL0XC1yRjr+Slwb6OsJ
 JasQSFVe+gk3TOuPq9u+ZEaakWWjnkx1fA3IN9TjNadmwhqDwL2a95DNe1rNcyi3perh0K
 Iw3ynudW67aSRHIuYNzIRzKPUhpQlMk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-N4eTId-gN5qE6F9sTv-FhQ-1; Wed, 28 Oct 2026 13:14:34 -0400
X-MC-Unique: N4eTId-gN5qE6F9sTv-FhQ-1
X-Mimecast-MFC-AGG-ID: N4eTId-gN5qE6F9sTv-FhQ_1793207674
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48b00febba3so789870f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207673; x=1793812473; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nSlL15lWvmG2UcqLAQ8JC/mDb8TNmvQnypS5u18oTBI=;
 b=qkXe++Zhrwm0ka36wdru+7jH0wuvUcca4HZEQ5yAq4vr4rDaA5+WcOH/y9JZIzxKoy
 Mx9q5uAjxXLPZO+rWepe3cMlb4HK+v8Pcs+p2VBDvKOx7e9tAodPGurM6UFZDPYA77M5
 +Iq1aCGVm74YNMo91rwPvHXW5FWxDD7Q4ua4bpL8TwQkxYAlukbXA+9tOXKTudg8jJDe
 j4yIxpSVSraxM2XBRFx0QN5iHwxFpTh4Bsa0mYnv2py/G0iyw50M+6O6jRAd8zoQm4Yq
 T1y07IsjtLmdBHJ09E5K5wKxb33I5OYpgYfvK8sK/e8I1h03GNatW+6EYWVU5wJje9AD
 K17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207673; x=1793812473;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nSlL15lWvmG2UcqLAQ8JC/mDb8TNmvQnypS5u18oTBI=;
 b=zIU86Iw5I0UuQ+U2UZvHNfbTka2d+YDDgguv48l0JAWlds+ga4aTfL81lXa+WyAV45
 XF5NjDhfCzbfqR+8MSC4D8sH8uDQ3pjqZFMQVa8luCeB3omnzNQI0R/CSz9fKAU81ixy
 L8SpYeGwwXBndNX2DfDtG9J+jNIeRz73UPtzHgIhonSLQ8sfOxoPmuMQahb+uFmZWDa6
 kpizbo3O/yhbMu6t2YlXShn5HsSFAYL8Bre6bnn8yxi+NkDvdz9LD/OE/l25JoeAzmdO
 yRdee2mg5fvGnjxcgu8MfVGB/kgaNnS+7dhvI0+AW7PQGq6KBWbR3qwiWRnlN/ykuvL1
 nNFQ==
X-Gm-Message-State: AFq9FYL3zGkXRUDas7vHXVGFh/iaHqgqYOE6Akcz3+UQJocJlaFBv8oo
 wd4oDOAIuUxF8qu8zc8NtICMnR73a3bBNxD3/67ZLx++3r6MpesKQtHpaPvNVFvO7g6K2t8kMTP
 aAerNiis3pdlbV1kXXzKgUTen4w+xN8t/pcox3ky6Bkc1jb4ND6onKwCApCpM2QD9g5SbfRbjSA
 N5/jXpI1RYcytKFETbWAG5w+4mh2usfJ/+sA==
X-Gm-Gg: AYBFou1/2K3YxfWgl0UTiKXDHanqn+FoiV0peE8swTkNAZQAsgb0Idcxgcvpa1SUqCc
 cB7696+eFIqW7fo59HcMbAvxe4zvrTiOD5y0Ltush8Ccb3kO7vmJwbKfk9av7dqlmXfmseyBWzt
 c8cTLXX/FUpeGHj6GuXVmwUar01OhE89kYVfGY28NAiiF0/CeOvAm1e0U8d9hKOvEoWruat1euX
 N+f2aNlU0Feyv4MtY4+0okTsgrelKy8D9e+IHggj9dCVSXhfS5XBs6TLxCmmkl97fGN+V95hUMW
 e/0H8MDHyMKnDwc/S/9msRNE3pCeZf7Qlqx7XK/QTQkkUsTsfOxC0fgM6DEikepldmmzsm8kSga
 eA5KogpBtRmZDGopXDG3UP5/7PaanFc6VcW1bqMfc
X-Received: by 2002:a05:600c:4454:b0:4a4:3a2d:15da with SMTP id
 5b1f17b1804b1-4a966774f47mr72572175e9.15.1793207673469; 
 Wed, 28 Oct 2026 10:14:33 -0700 (PDT)
X-Received: by 2002:a05:600c:4454:b0:4a4:3a2d:15da with SMTP id
 5b1f17b1804b1-4a966774f47mr72571325e9.15.1793207672964; 
 Wed, 28 Oct 2026 10:14:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f4188f4sm5424395e9.4.2026.10.28.10.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:32 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 14/78] tests/qtest/migration: add test for snapshot rejection
 in CPR modes
Message-ID: <6c10bab556a6017af4c54d946322b72d98e904fd.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Snapshots are refused whenever a CPR migration mode is set.  Add a test
which sets each of the CPR modes in turn and checks that 'savevm' and
'loadvm' fail with the corresponding error, then switches back to
'normal' mode and checks that the error is gone.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-5-36c38bd15ffc@virtuozzo.com>
---
 tests/qtest/migration/cpr-tests.c | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 0bec753b4a..05c2ac1336 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -290,6 +290,44 @@ static void test_mode_exec(char *name, MigrateCommon *args)
     test_cpr_exec(args);
 }
 
+/* Snapshots must be refused while a CPR migration mode is set */
+static void test_mode_no_snapshot(char *name, MigrateCommon *args)
+{
+    static const char *const modes[] = {
+        "cpr-reboot", "cpr-transfer", "cpr-exec",
+    };
+    QTestState *vm = qtest_init("-nodefaults -machine none");
+    char *out;
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(modes); i++) {
+        g_autofree char *expected = g_strdup_printf(
+            "Snapshots are not compatible with migration mode %s", modes[i]);
+
+        migrate_set_parameter_str(vm, "mode", modes[i]);
+
+        out = qtest_hmp(vm, "savevm snap");
+        g_assert_nonnull(strstr(out, expected));
+        g_free(out);
+
+        out = qtest_hmp(vm, "loadvm snap");
+        g_assert_nonnull(strstr(out, expected));
+        g_free(out);
+    }
+
+    /*
+     * The check should no longer fire in normal mode.  savevm still fails
+     * (there's no block device for storing the snapshot).  We just check
+     * that it's not the mode error any more.
+     */
+    migrate_set_parameter_str(vm, "mode", "normal");
+    out = qtest_hmp(vm, "savevm snap");
+    g_assert_null(strstr(out, "not compatible with migration mode"));
+    g_free(out);
+
+    qtest_quit(vm);
+}
+
 void migration_test_add_cpr(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
@@ -300,6 +338,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
         return;
     }
 
+    migration_test_add("/migration/mode/no-snapshot", test_mode_no_snapshot);
+
     /*
      * Our CI system has problems with shared memory.
      * Don't run this test until we find a workaround.
-- 
MST


