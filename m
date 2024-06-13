Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB43C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmeN-0007Sl-PH; Thu, 13 Jun 2024 11:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmdP-00060t-2x
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmdL-0003gk-PV
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718293502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+JZi29SR4sgi5HZzRjL06PSdcLfzXdnkKMGuCuzMTM=;
 b=ToEbpNs5L3MtDBDhe7yf9pBU+0HbMJNyeiLCMVX3faYGPOgdW+qAqOnaFJ0y33jT4qu3GZ
 D3SD0b8HbYOrELVPZFjL+95zOpS/vWvdv1GWxRKp87LuFiMmgaeWv/F9El2eMkLcDmBchA
 iYEhHs56DgxJaIiT5wGIdIhNTfCNTX0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-F9yuxR3LOvSQSC0wlK7-HQ-1; Thu,
 13 Jun 2024 11:44:57 -0400
X-MC-Unique: F9yuxR3LOvSQSC0wlK7-HQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43FD219560B2; Thu, 13 Jun 2024 15:44:56 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 797A03000219; Thu, 13 Jun 2024 15:44:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 19/22] qga: move declare of QGAConfig struct to top of file
Date: Thu, 13 Jun 2024 16:44:03 +0100
Message-ID: <20240613154406.1365469-14-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-1-berrange@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

It is referenced by QGAState already, and it is clearer to declare all
data types at the top of the file, rather than have them mixed with
code later.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.45.1


