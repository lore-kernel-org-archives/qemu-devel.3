Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A6EFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEIa-0000Ik-71; Tue, 05 May 2026 07:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEIY-0000HZ-SV
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEIV-0001Vm-OG
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777981842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1buz1HvBXbVUjkVrpfYDgQfDA+7ra88clPVwnrf1Y8=;
 b=QXp7Ptpc7QOd7n82CixnZ1RuPNsf7O57CaYbpY0kd0kIXhyIw4h5WBBGiuu86jffn0bA38
 V4ow22Btzeqz/N2UJFN5LVEznisqD5md+EWrZhzBCoz96MsLR+buHfNM/tIcKBxb2r7OmM
 NoLi6yUyEzO+H0ISmwCBKXwFxr41fSw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-SRD4hwqNP1uMbmZ10d96mg-1; Tue,
 05 May 2026 07:50:40 -0400
X-MC-Unique: SRD4hwqNP1uMbmZ10d96mg-1
X-Mimecast-MFC-AGG-ID: SRD4hwqNP1uMbmZ10d96mg_1777981840
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2C33195608F
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 11:50:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6417F1800347
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 11:50:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C72C421E6A03; Tue, 05 May 2026 13:50:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 2/5] error: Fix "to current monitor if we have one" comments
Date: Tue,  5 May 2026 13:50:33 +0200
Message-ID: <20260505115036.1170186-3-armbru@redhat.com>
In-Reply-To: <20260505115036.1170186-1-armbru@redhat.com>
References: <20260505115036.1170186-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

A number of print functions are documented to print to "current
monitor if we have one, else stderr".  Wrong, they print to the
current monitor only when it's HMP.  This is the case since commit
4ad417baa43 (error: Print error_report() to stderr if using qmp).

Fix the comments to say "current HMP monitor if we have one".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260114124713.3308719-2-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[Commit a582a5784e5f (monitor: move error_vprintf back to
error-report.c) lost a comment this commit fixes, restore it]
---
 include/qapi/error.h |  3 ++-
 util/error-report.c  | 29 +++++++++++++++++++----------
 util/qemu-print.c    |  4 ++--
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 2356b84bb3..d1d37fc656 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -64,7 +64,8 @@
  *
  * = Reporting and destroying errors =
  *
- * Report an error to the current monitor if we have one, else stderr:
+ * Report an error to the current HMP monitor if we have one, else
+ * stderr:
  *     error_report_err(err);
  * This frees the error object.
  *
diff --git a/util/error-report.c b/util/error-report.c
index bbea49a55d..92b04915ce 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -62,6 +62,9 @@ error_printf_mon(Monitor *cur_mon, const char *fmt, ...)
     return ret;
 }
 
+/*
+ * Print to the current HMP monitor if we have one, else to stderr.
+ */
 int error_vprintf(const char *fmt, va_list ap)
 {
     return error_vprintf_mon(monitor_cur(), fmt, ap);
@@ -174,7 +177,8 @@ void loc_set_file(const char *fname, int lno)
 }
 
 /*
- * Print current location to current monitor if we have one, else to stderr.
+ * Print current location to current HMP monitor if we have one, else
+ * to stderr.
  */
 static void print_loc(Monitor *cur)
 {
@@ -214,7 +218,8 @@ char *real_time_iso8601(void)
 }
 
 /*
- * Print a message to current monitor if we have one, else to stderr.
+ * Print a message to current HMP monitor if we have one, else to
+ * stderr.
  * @report_type is the type of message: error, warning or informational.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
@@ -270,7 +275,8 @@ static void vreport(report_type type, const char *fmt, va_list ap)
 }
 
 /*
- * Print an error message to current monitor if we have one, else to stderr.
+ * Print an error message to current HMP monitor if we have one, else
+ * to stderr.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
@@ -282,7 +288,8 @@ void error_vreport(const char *fmt, va_list ap)
 }
 
 /*
- * Print a warning message to current monitor if we have one, else to stderr.
+ * Print a warning message to current HMP monitor if we have one, else
+ * to stderr.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
@@ -293,8 +300,8 @@ void warn_vreport(const char *fmt, va_list ap)
 }
 
 /*
- * Print an information message to current monitor if we have one, else to
- * stderr.
+ * Print an information message to current HMP monitor if we have one,
+ * else to stderr.
  * Format arguments like vsprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
@@ -305,7 +312,8 @@ void info_vreport(const char *fmt, va_list ap)
 }
 
 /*
- * Print an error message to current monitor if we have one, else to stderr.
+ * Print an error message to current HMP monitor if we have one, else
+ * to stderr.
  * Format arguments like sprintf().  The resulting message should be
  * a single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
@@ -321,7 +329,8 @@ void error_report(const char *fmt, ...)
 }
 
 /*
- * Print a warning message to current monitor if we have one, else to stderr.
+ * Print a warning message to current HMP monitor if we have one, else
+ * to stderr.
  * Format arguments like sprintf(). The resulting message should be a
  * single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
@@ -336,8 +345,8 @@ void warn_report(const char *fmt, ...)
 }
 
 /*
- * Print an information message to current monitor if we have one, else to
- * stderr.
+ * Print an information message to current HMP monitor if we have one,
+ * else to stderr.
  * Format arguments like sprintf(). The resulting message should be a
  * single phrase, with no newline or trailing punctuation.
  * Prepend the current location and append a newline.
diff --git a/util/qemu-print.c b/util/qemu-print.c
index 69ba612f56..4a30cd1a8e 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -16,7 +16,7 @@
 
 /*
  * Print like vprintf().
- * Print to current monitor if we have one, else to stdout.
+ * Print to current HMP monitor if we have one, else to stdout.
  */
 int qemu_vprintf(const char *fmt, va_list ap)
 {
@@ -29,7 +29,7 @@ int qemu_vprintf(const char *fmt, va_list ap)
 
 /*
  * Print like printf().
- * Print to current monitor if we have one, else to stdout.
+ * Print to current HMP monitor if we have one, else to stdout.
  */
 int qemu_printf(const char *fmt, ...)
 {
-- 
2.54.0


