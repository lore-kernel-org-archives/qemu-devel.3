Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746ACC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9Ym-0007Fc-KJ; Tue, 23 Jul 2024 03:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9Yh-0006qt-AV
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9Yf-0000u8-In
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721718216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wFiSy8dnquqxFZ4SIsZQtIWnG9t46QRosa8oiF0a59k=;
 b=LW2ZVrUCYBKnzP4jDw+K1Bgd4LxYVv0urQ/FCX5JqTY46C95amwXRT/D2A6C5zRqZ1ZC1Q
 e5Tda+4y+sR8tcsaiTBNG58xnLu6Y9qagqgVl3deFWb23NeNZRTBwZpK1Ic7hsu3EiyoOd
 AD8TDRbUL2OBVzRJHN/N/BQ8LdJjKvE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5--oPRo4r5OyKul12yb84a8w-1; Tue,
 23 Jul 2024 03:03:34 -0400
X-MC-Unique: -oPRo4r5OyKul12yb84a8w-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCDBD1955D59; Tue, 23 Jul 2024 07:03:33 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.211])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37BA43000192; Tue, 23 Jul 2024 07:03:31 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 19/25] qga: move declare of QGAConfig struct to top of file
Date: Tue, 23 Jul 2024 10:02:45 +0300
Message-ID: <20240723070251.25575-20-kkostiuk@redhat.com>
In-Reply-To: <20240723070251.25575-1-kkostiuk@redhat.com>
References: <20240723070251.25575-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

It is referenced by QGAState already, and it is clearer to declare all
data types at the top of the file, rather than have them mixed with
code later.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240712132459.3974109-20-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/main.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 17b6ce18ac..647d27037c 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -70,6 +70,28 @@ typedef struct GAPersistentState {
 
 typedef struct GAConfig GAConfig;
 
+struct GAConfig {
+    char *channel_path;
+    char *method;
+    char *log_filepath;
+    char *pid_filepath;
+#ifdef CONFIG_FSFREEZE
+    char *fsfreeze_hook;
+#endif
+    char *state_dir;
+#ifdef _WIN32
+    const char *service;
+#endif
+    gchar *bliststr; /* blockedrpcs may point to this string */
+    gchar *aliststr; /* allowedrpcs may point to this string */
+    GList *blockedrpcs;
+    GList *allowedrpcs;
+    int daemonize;
+    GLogLevelFlags log_level;
+    int dumpconf;
+    bool retry_path;
+};
+
 struct GAState {
     JSONMessageParser parser;
     GMainLoop *main_loop;
@@ -996,28 +1018,6 @@ static GList *split_list(const gchar *str, const gchar *delim)
     return list;
 }
 
-struct GAConfig {
-    char *channel_path;
-    char *method;
-    char *log_filepath;
-    char *pid_filepath;
-#ifdef CONFIG_FSFREEZE
-    char *fsfreeze_hook;
-#endif
-    char *state_dir;
-#ifdef _WIN32
-    const char *service;
-#endif
-    gchar *bliststr; /* blockedrpcs may point to this string */
-    gchar *aliststr; /* allowedrpcs may point to this string */
-    GList *blockedrpcs;
-    GList *allowedrpcs;
-    int daemonize;
-    GLogLevelFlags log_level;
-    int dumpconf;
-    bool retry_path;
-};
-
 static void config_load(GAConfig *config)
 {
     GError *gerr = NULL;
-- 
2.45.2


