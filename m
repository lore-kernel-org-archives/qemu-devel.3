Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1606E64AA4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIT8h-0006L6-Qt; Tue, 03 Dec 2024 08:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tIT8a-0006KG-02
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:40:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tIT8Y-00020C-Dv
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733233221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5ChKXtHIpjzQSjyahis7qpZuTfzIJGucF5eGbHoAV8=;
 b=CLfrcHPio6oP/ujWwkQ1nUEs2Jthyit8dRig+dUbaJUP/0naXAzN8NL9R6Zu33iNHAsJl1
 I1y2aL/beCuaTeDWDp165pTHXGe43G1tcXDOy6zRX1qZy5yqGxXqxuyCN4NMiSZmgO+5O+
 Is1LW8tA+qzko3jAjuh7FATvgOQxmqo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-f4-ub7Z5MaCrRKr2Tv5buA-1; Tue,
 03 Dec 2024 08:40:18 -0500
X-MC-Unique: f4-ub7Z5MaCrRKr2Tv5buA-1
X-Mimecast-MFC-AGG-ID: f4-ub7Z5MaCrRKr2Tv5buA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4083319560A3; Tue,  3 Dec 2024 13:40:17 +0000 (UTC)
Received: from localhost (unknown [10.39.208.11])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 360BD1956052; Tue,  3 Dec 2024 13:40:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 2/2] chardev: Remove __-prefixed names
Date: Tue,  3 Dec 2024 17:40:01 +0400
Message-ID: <20241203134001.750958-3-marcandre.lureau@redhat.com>
In-Reply-To: <20241203134001.750958-1-marcandre.lureau@redhat.com>
References: <20241203134001.750958-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Peter points out double underscore prefix names tend to be reserved
for the system. Clean these up.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240828043337.14587-3-npiggin@gmail.com>
---
 chardev/char.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 1c7f6c711a..d06698228a 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -633,8 +633,8 @@ static void qemu_chardev_set_replay(Chardev *chr, Error **errp)
     }
 }
 
-static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
-                                         bool replay, Error **errp)
+static Chardev *do_qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
+                                          bool replay, Error **errp)
 {
     const ChardevClass *cc;
     Chardev *base = NULL, *chr = NULL;
@@ -712,12 +712,12 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
                                 Error **errp)
 {
     /* XXX: should this really not record/replay? */
-    return __qemu_chr_new_from_opts(opts, context, false, errp);
+    return do_qemu_chr_new_from_opts(opts, context, false, errp);
 }
 
-static Chardev *__qemu_chr_new(const char *label, const char *filename,
-                               bool permit_mux_mon, GMainContext *context,
-                               bool replay)
+static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
+                                       bool permit_mux_mon,
+                                       GMainContext *context, bool replay)
 {
     const char *p;
     Chardev *chr;
@@ -740,7 +740,7 @@ static Chardev *__qemu_chr_new(const char *label, const char *filename,
     if (!opts)
         return NULL;
 
-    chr = __qemu_chr_new_from_opts(opts, context, replay, &err);
+    chr = do_qemu_chr_new_from_opts(opts, context, replay, &err);
     if (!chr) {
         error_report_err(err);
         goto out;
@@ -765,7 +765,8 @@ out:
 Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
                                bool permit_mux_mon, GMainContext *context)
 {
-    return __qemu_chr_new(label, filename, permit_mux_mon, context, false);
+    return qemu_chr_new_from_name(label, filename, permit_mux_mon, context,
+                                  false);
 }
 
 static Chardev *qemu_chr_new_permit_mux_mon(const char *label,
@@ -773,7 +774,8 @@ static Chardev *qemu_chr_new_permit_mux_mon(const char *label,
                                           bool permit_mux_mon,
                                           GMainContext *context)
 {
-    return __qemu_chr_new(label, filename, permit_mux_mon, context, true);
+    return qemu_chr_new_from_name(label, filename, permit_mux_mon, context,
+                                  true);
 }
 
 Chardev *qemu_chr_new(const char *label, const char *filename,
-- 
2.47.0


