Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1062606D81D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EDUXTZQw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOxRZ-0001wu-4b; Thu, 05 Nov 2026 08:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fizikiukas@gmail.com>)
 id 1xOvs1-0003v5-3u
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:43:05 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fizikiukas@gmail.com>)
 id 1xOvrz-0005X6-4R
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:43:04 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c434376dbebso130609966b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 03:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793878981; x=1794483781; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3gok3RHX0hdU8OwhiFU7ML1Z2ViviNh+l7K4BQ51h44=;
 b=EDUXTZQwbqN97fgZZfm6A5lwy7+N+UtvK0XhcdXL+mKA4lKodl261yFOjEHoWjJsnn
 sP+QyCt8lp/H89iHqYT9xTnJhbrCw7GYZ212mVp/t7dhVsP82cwBTC3iyD2SO9gGBiDx
 wohRVJJ96l0T8dVZ1ho1cbDkmiq2OvnRSuwUIq9GCkEMq6Ue7NGbLksSyF8ugC8/VMn8
 HJGtkJN1tRfDdhda180r4QOt8xIlAXB0+8IX+Cqa4GouRk4xBnirQ1hF/kOXLXLZc+L5
 zhl5v/WChXCyH/pfdThYDe2yrRSC1CfY74RNFroyMM1WZ90xAJEBhoonjL0UMn2lIpST
 RDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793878981; x=1794483781;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3gok3RHX0hdU8OwhiFU7ML1Z2ViviNh+l7K4BQ51h44=;
 b=2Bk7trBiCVq5H/Wv1f1IQ8EkXAnf7QilfuSZ/6wLP89G5QgwIsnABKmzFSPhouj3JH
 vPBy2bvMp5zZHs3h3Cq8Yjw6b8eTQOvgUcU9lS+d7Rzw+o+QvkzGe+2115Q9RQmG6lWu
 2niyoFCQZMl5BU+fp5jtDi5fppe0yQ23lAw87duTYJVIuHrJ3X18sfBkiCcuvbDieTDb
 M5GgwqR43A0pA9ZkiRzPnCcl1+USAzmBtfc3No/Aw2zKCR6lnxjx2cGrEJW5NB1a+A5L
 3F+uJr9KYc2H9V4XPyg4SfEqjU8NVWpCe+NYjTpca/rAu954zbtWte7ANDUsmf5/j4oZ
 livA==
X-Gm-Message-State: APuU4Z945zdX+9bQKM1pN+8V8HqWPv3vPgndytDr8X7LEGhDjCB8GgxH
 hjJhHCOg9REZ1ObnUUut2dGmovjyt9F6nwMV+10Txm0gVrjuGjDrmWu5HrilwAmZ
X-Gm-Gg: AYBFou1vZ5N/PsEFHJmTcEl9nITO9cqQNe6n59pACaOVtoZT2XZRChvG9uVdrpNl2Dd
 gU8762bLIoTifPHAhT4pv8ZbKpnYZbNIOfW6VJ7yKZ0GUuXB3Anw6fLVGlMgFCqg0/gd4P4Q14k
 tHWKnIVvS/qVlKPTvv0GdHm9Ax/hYoG/3oBH3/+fYRPm/T09v4wLI4IE+hcf6KVf5JifEN4/eOg
 x+4bTeH9c5upCWa7C0DaHadGWT5+ZerBeDLAqz0JhRacPkPKthZquCUrIBhMDI3AHdms0XuU7Cl
 Rl5S5naHPNqGTkou9LTUdOlFvcse8DYKgRribalepe8VlF7lVmbFjbei0Q9A+jYtzJ/pNJYHrel
 iaXDiMki7IP+OgfFHF8PlaY63uzRrzQpRyS6clzPxhJFQI0k9WZsRdTxvGgWtXJC7fruC/w+CRs
 zk5Qx6bb2EkO8I5H90VBDLAOpjJnVijoozR2077IET1evOAOrJsL67h3J9jEM8u9yXCQOg8RTCI
 20gs53GID2xxWO+O0HxskIPfAgNILNyq7MrclD/zoMa8GvzrSFQZfNc5DF35SjXkr3+ArSsXboU
 1E46dYqKDFFH8Ts0hJoxooLHOWQu7SuVKNHl/MBq8mFzd3iiMuYALKYa7Vdx4VTjrC1fyHTQcIS
 0Vf0PLLG1o+ArBASn0aJoz2xmQDmG44h5Mq5CDz4/3oh0F/JyJr27+sxRod1b/HuIWA==
X-Received: by 2002:a17:907:3d94:b0:c2e:902e:5208 with SMTP id
 a640c23a62f3a-c4d204bdf35mr204555466b.5.1793878980814; 
 Thu, 05 Nov 2026 03:43:00 -0800 (PST)
Received: from Mac-FVFFP2HZQ05N ([86.106.20.24])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e4a7797sm161770866b.87.2026.11.05.03.42.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 03:42:59 -0800 (PST)
From: =?UTF-8?q?Valentinas=20=C4=8Cirba?= <fizikiukas@gmail.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Valentinas=20=C4=8Cirba?= <valentinas.cirba@hostinger.com>
Subject: [PATCH] qga: keep a trailing newline in authorized_keys
Date: Thu,  5 Nov 2026 13:41:50 +0200
Message-ID: <20261105114242.35394-1-fizikiukas@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=fizikiukas@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 05 Nov 2026 08:23:50 -0500
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Valentinas Čirba <valentinas.cirba@hostinger.com>

After guest-ssh-add-authorized-keys the file has an empty line before the
new key and no final newline, so a key appended later with ">>" is
merged into the previous line.

read_authkeys() / g_strsplit leaves a trailing empty element;
write_authkeys() / g_strjoinv adds no final newline.

Both write_authkeys() functions, in qga/commands-posix-ssh.c
and qga/commands-windows-ssh.c, now end non-empty contents
with \n. An empty key list is still written as "".

Also also changes read_authkeys() in qga/commands-common-ssh.c,
so it drops the trailing empty element.

Fixes: 8d769ec777dc ("qga: add ssh-{add,remove}-authorized-keys")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4803
Cc: qemu-stable@nongnu.org
Signed-off-by: Valentinas Čirba <valentinas.cirba@hostinger.com>
---
 qga/commands-common-ssh.c  | 12 ++++++++++-
 qga/commands-posix-ssh.c   | 41 +++++++++++++++++++++++++++++++++-----
 qga/commands-windows-ssh.c |  7 ++++++-
 3 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/qga/commands-common-ssh.c b/qga/commands-common-ssh.c
index 537869fb98..5f5b631689 100644
--- a/qga/commands-common-ssh.c
+++ b/qga/commands-common-ssh.c
@@ -11,13 +11,23 @@ GStrv read_authkeys(const char *path, Error **errp)
 {
     g_autoptr(GError) err = NULL;
     g_autofree char *contents = NULL;
+    GStrv lines;
+    guint len;
 
     if (!g_file_get_contents(path, &contents, NULL, &err)) {
         error_setg(errp, "failed to read '%s': %s", path, err->message);
         return NULL;
     }
 
-    return g_strsplit(contents, "\n", -1);
+    lines = g_strsplit(contents, "\n", -1);
+
+    len = g_strv_length(lines);
+    if (len > 0 && lines[len - 1][0] == '\0') {
+        g_free(lines[len - 1]);
+        lines[len - 1] = NULL;
+    }
+
+    return lines;
 }
 
 bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index aa3411049f..924c5bdeb0 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -113,7 +113,12 @@ write_authkeys(const char *path, const GStrv keys,
     g_autofree char *contents = NULL;
     g_autoptr(GError) err = NULL;
 
-    contents = g_strjoinv("\n", keys);
+    if (keys[0] != NULL) {
+        g_autofree char *joined = g_strjoinv("\n", keys);
+        contents = g_strconcat(joined, "\n", NULL);
+    } else {
+        contents = g_strdup("");
+    }
     if (!g_file_set_contents(path, contents, -1, &err)) {
         error_setg(errp, "failed to write to '%s': %s", path, err->message);
         return false;
@@ -402,7 +407,7 @@ test_add_keys(void)
                                       &err);
     g_assert(err == NULL);
 
-    test_authorized_keys_equal("algo key2 comments");
+    test_authorized_keys_equal("algo key2 comments\n");
 
     qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
                                       (strList *)&test_key1_2,
@@ -412,7 +417,7 @@ test_add_keys(void)
 
     /*  key2 came first, and shouldn't be duplicated */
     test_authorized_keys_equal("algo key2 comments\n"
-                               "algo key1 comments");
+                               "algo key1 comments\n");
 }
 
 static void
@@ -428,7 +433,7 @@ test_add_reset_keys(void)
 
     /* reset with key2 only */
     test_authorized_keys_equal("algo key1 comments\n"
-                               "algo key2 comments");
+                               "algo key2 comments\n");
 
     qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
                                       (strList *)&test_key2,
@@ -436,7 +441,7 @@ test_add_reset_keys(void)
                                       &err);
     g_assert(err == NULL);
 
-    test_authorized_keys_equal("algo key2 comments");
+    test_authorized_keys_equal("algo key2 comments\n");
 
     /* empty should clear file */
     qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
@@ -448,6 +453,30 @@ test_add_reset_keys(void)
     test_authorized_keys_equal("");
 }
 
+static void
+test_add_keys_trailing_newline(void)
+{
+    Error *err = NULL;
+
+    test_authorized_keys_set("algo key1 comments\n");
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)&test_key2,
+                                      FALSE, FALSE,
+                                      &err);
+    g_assert(err == NULL);
+    test_authorized_keys_equal("algo key1 comments\n"
+                               "algo key2 comments\n");
+
+    test_authorized_keys_set("algo key1 comments");
+    qmp_guest_ssh_add_authorized_keys(g_get_user_name(),
+                                      (strList *)&test_key2,
+                                      FALSE, FALSE,
+                                      &err);
+    g_assert(err == NULL);
+    test_authorized_keys_equal("algo key1 comments\n"
+                               "algo key2 comments\n");
+}
+
 static void
 test_remove_keys(void)
 {
@@ -507,6 +536,8 @@ int main(int argc, char *argv[])
     g_test_add_func("/qga/ssh/invalid_key", test_invalid_key);
     g_test_add_func("/qga/ssh/add_keys", test_add_keys);
     g_test_add_func("/qga/ssh/add_reset_keys", test_add_reset_keys);
+    g_test_add_func("/qga/ssh/add_keys_trailing_newline",
+                    test_add_keys_trailing_newline);
     g_test_add_func("/qga/ssh/remove_keys", test_remove_keys);
     g_test_add_func("/qga/ssh/get_keys", test_get_keys);
 
diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
index df45c17b75..f5cf30cc88 100644
--- a/qga/commands-windows-ssh.c
+++ b/qga/commands-windows-ssh.c
@@ -431,7 +431,12 @@ static bool write_authkeys(WindowsUserInfo *userInfo, GStrv authkeys,
     g_autofree char *contents = NULL;
     g_autoptr(GError) err = NULL;
 
-    contents = g_strjoinv("\n", authkeys);
+    if (authkeys[0] != NULL) {
+        g_autofree char *joined = g_strjoinv("\n", authkeys);
+        contents = g_strconcat(joined, "\n", NULL);
+    } else {
+        contents = g_strdup("");
+    }
 
     if (!g_file_set_contents(userInfo->authorizedKeyFile, contents, -1, &err)) {
         error_setg(errp, "failed to write to '%s': %s",
-- 
2.54.0 (Apple Git-157)


