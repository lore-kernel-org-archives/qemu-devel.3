Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA70CAC5AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 00:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqiOw-0000mp-G4; Tue, 17 Sep 2024 20:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1sqiOr-0000jk-QE; Tue, 17 Sep 2024 20:18:30 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>)
 id 1sqiOq-0007kh-1d; Tue, 17 Sep 2024 20:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=NIZ9CevHyKnMjtjd6Im/4I0L6VZ6smkjC8yC3U2DLwU=; b=CbZjzb6cpKpF33mJ
 y2A7RXmwu/MXh5XHeWxN6FpvFDjtSmZhHSq5lEIluDwBIoY9PO6UfxiNjSivDCMnse7LPD00gwNzy
 x5VvESZrdTKqbPuIc7flX1cPQ+wzt9MbBqwthLOU+IYFU5DeG8VO6Qvff2IfnUqEYQNt4P0OvsYmD
 vR3qQwCwb8ti9cUq7zMMq4ZExp9CAQ5PG09rVcezmCu4QjstDq8jpAfW00xdfufZY6CMAn3PBcP2P
 O8waERfo0QXWkUlc0Cipf7878cLJ0m/P1I0Jc65xHZQT9LRXyICnVFxLV5xP8nOpunKPTzwmqVMkr
 qtwyHTxnSFYY7F4nLA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqiOn-006DmB-06;
 Wed, 18 Sep 2024 00:18:25 +0000
From: dave@treblig.org
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] envlist: Remove unused envlist_parse
Date: Wed, 18 Sep 2024 01:18:23 +0100
Message-ID: <20240918001823.185701-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

envlist_parse, envlist_parse_set, envlist_parse_unset were added
in 2009 but never used, see:
  04a6dfebb6 ("linux-user: Add generic env variable handling")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 include/qemu/envlist.h |  2 --
 util/envlist.c         | 69 ------------------------------------------
 2 files changed, 71 deletions(-)

diff --git a/include/qemu/envlist.h b/include/qemu/envlist.h
index 6006dfae44..b2883f6659 100644
--- a/include/qemu/envlist.h
+++ b/include/qemu/envlist.h
@@ -7,8 +7,6 @@ envlist_t *envlist_create(void);
 void envlist_free(envlist_t *);
 int envlist_setenv(envlist_t *, const char *);
 int envlist_unsetenv(envlist_t *, const char *);
-int envlist_parse_set(envlist_t *, const char *);
-int envlist_parse_unset(envlist_t *, const char *);
 char **envlist_to_environ(const envlist_t *, size_t *);
 
 #endif /* ENVLIST_H */
diff --git a/util/envlist.c b/util/envlist.c
index db937c0427..15fdbb109d 100644
--- a/util/envlist.c
+++ b/util/envlist.c
@@ -12,9 +12,6 @@ struct envlist {
     size_t el_count;                        /* number of entries */
 };
 
-static int envlist_parse(envlist_t *envlist,
-    const char *env, int (*)(envlist_t *, const char *));
-
 /*
  * Allocates new envlist and returns pointer to it.
  */
@@ -51,72 +48,6 @@ envlist_free(envlist_t *envlist)
     g_free(envlist);
 }
 
-/*
- * Parses comma separated list of set/modify environment
- * variable entries and updates given enlist accordingly.
- *
- * For example:
- *     envlist_parse(el, "HOME=foo,SHELL=/bin/sh");
- *
- * inserts/sets environment variables HOME and SHELL.
- *
- * Returns 0 on success, errno otherwise.
- */
-int
-envlist_parse_set(envlist_t *envlist, const char *env)
-{
-    return (envlist_parse(envlist, env, &envlist_setenv));
-}
-
-/*
- * Parses comma separated list of unset environment variable
- * entries and removes given variables from given envlist.
- *
- * Returns 0 on success, errno otherwise.
- */
-int
-envlist_parse_unset(envlist_t *envlist, const char *env)
-{
-    return (envlist_parse(envlist, env, &envlist_unsetenv));
-}
-
-/*
- * Parses comma separated list of set, modify or unset entries
- * and calls given callback for each entry.
- *
- * Returns 0 in case of success, errno otherwise.
- */
-static int
-envlist_parse(envlist_t *envlist, const char *env,
-    int (*callback)(envlist_t *, const char *))
-{
-    char *tmpenv, *envvar;
-    char *envsave = NULL;
-    int ret = 0;
-    assert(callback != NULL);
-
-    if ((envlist == NULL) || (env == NULL))
-        return (EINVAL);
-
-    tmpenv = g_strdup(env);
-    envsave = tmpenv;
-
-    do {
-        envvar = strchr(tmpenv, ',');
-        if (envvar != NULL) {
-            *envvar = '\0';
-        }
-        if ((*callback)(envlist, tmpenv) != 0) {
-            ret = errno;
-            break;
-        }
-        tmpenv = envvar + 1;
-    } while (envvar != NULL);
-
-    g_free(envsave);
-    return ret;
-}
-
 /*
  * Sets environment value to envlist in similar manner
  * than putenv(3).
-- 
2.46.0


