Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A78C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 16:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjiy7-00057Q-SE; Mon, 11 Mar 2024 12:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rjiy5-00057B-QL
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rjiy4-00061u-2M
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710176259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQ4JxGLRjBFYllQ7HhDkk3GD2IJwmIxf2BTco2CgMWw=;
 b=TOqMJ/ed7U32K7zhlOzMHb4Z+QcCZCkXtyy1JzF1ne0aofsDUuvVBuiI5LsZJrK7kGzBxT
 o9z/V6JTcWdNEbI83lrxLXAxgYrAcq26gyS0WYhWEIML0ehblnc0GItDT6agJ45VbwXyQa
 MdEifqCNinoIiDGG5bxDvsP3/88mVrI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-hLO8EQKhOi6KlCp97Rg7Qg-1; Mon, 11 Mar 2024 12:57:30 -0400
X-MC-Unique: hLO8EQKhOi6KlCp97Rg7Qg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86D75855300;
 Mon, 11 Mar 2024 16:57:30 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D8D610E49;
 Mon, 11 Mar 2024 16:57:29 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 2/3] qga/commands-win32: Do not set matrix_lookup_t/win_10_0_t
 arrays size
Date: Mon, 11 Mar 2024 18:57:23 +0200
Message-ID: <20240311165724.176168-3-kkostiuk@redhat.com>
In-Reply-To: <20240311165724.176168-1-kkostiuk@redhat.com>
References: <20240311165724.176168-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

ga_get_win_name() iterates over all elements in the arrays by
checking the 'version' field is non-NULL. Since the arrays are
guarded by a NULL terminating element, we don't need to specify
their size:

  static char *ga_get_win_name(...)
  {
      ...
      const ga_matrix_lookup_t *table = WIN_VERSION_MATRIX[tbl_idx];
      const ga_win_10_0_t *win_10_0_table = ...
      ...
      while (table->version != NULL) {
                    ^^^^^^^^^^^^^^^
              while (win_10_0_table->version != NULL) {
                                     ^^^^^^^^^^^^^^^

This will simplify maintenance when adding new entries to these
arrays.

Split WIN_VERSION_MATRIX into WIN_CLIENT_VERSION_MATRIX and
WIN_SERVER_VERSION_MATRIX because  multidimensional array must
have bounds for all dimensions except the first.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240222152835.72095-3-philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Link: https://lore.kernel.org/r/20240304134532.28506-3-kkostiuk@redhat.com
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-win32.c | 48 +++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 79b5a580c9..659dfb624a 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2124,26 +2124,23 @@ typedef struct _ga_matrix_lookup_t {
     const char *version_id;
 } ga_matrix_lookup_t;
 
-static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][7] = {
-    {
-        /* Desktop editions */
-        { 5, 0, "Microsoft Windows 2000",   "2000"},
-        { 5, 1, "Microsoft Windows XP",     "xp"},
-        { 6, 0, "Microsoft Windows Vista",  "vista"},
-        { 6, 1, "Microsoft Windows 7"       "7"},
-        { 6, 2, "Microsoft Windows 8",      "8"},
-        { 6, 3, "Microsoft Windows 8.1",    "8.1"},
-        { 0, 0, 0}
-    },{
-        /* Server editions */
-        { 5, 2, "Microsoft Windows Server 2003",        "2003"},
-        { 6, 0, "Microsoft Windows Server 2008",        "2008"},
-        { 6, 1, "Microsoft Windows Server 2008 R2",     "2008r2"},
-        { 6, 2, "Microsoft Windows Server 2012",        "2012"},
-        { 6, 3, "Microsoft Windows Server 2012 R2",     "2012r2"},
-        { 0, 0, 0},
-        { 0, 0, 0}
-    }
+static const ga_matrix_lookup_t WIN_CLIENT_VERSION_MATRIX[] = {
+    { 5, 0, "Microsoft Windows 2000",   "2000"},
+    { 5, 1, "Microsoft Windows XP",     "xp"},
+    { 6, 0, "Microsoft Windows Vista",  "vista"},
+    { 6, 1, "Microsoft Windows 7"       "7"},
+    { 6, 2, "Microsoft Windows 8",      "8"},
+    { 6, 3, "Microsoft Windows 8.1",    "8.1"},
+    { }
+};
+
+static const ga_matrix_lookup_t WIN_SERVER_VERSION_MATRIX[] = {
+    { 5, 2, "Microsoft Windows Server 2003",        "2003"},
+    { 6, 0, "Microsoft Windows Server 2008",        "2008"},
+    { 6, 1, "Microsoft Windows Server 2008 R2",     "2008r2"},
+    { 6, 2, "Microsoft Windows Server 2012",        "2012"},
+    { 6, 3, "Microsoft Windows Server 2012 R2",     "2012r2"},
+    { },
 };
 
 typedef struct _ga_win_10_0_t {
@@ -2152,17 +2149,17 @@ typedef struct _ga_win_10_0_t {
     const char *version_id;
 } ga_win_10_0_t;
 
-static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[4] = {
+static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[] = {
     {14393, "Microsoft Windows Server 2016",    "2016"},
     {17763, "Microsoft Windows Server 2019",    "2019"},
     {20344, "Microsoft Windows Server 2022",    "2022"},
-    {0, 0}
+    { }
 };
 
-static const ga_win_10_0_t WIN_10_0_CLIENT_VERSION_MATRIX[3] = {
+static const ga_win_10_0_t WIN_10_0_CLIENT_VERSION_MATRIX[] = {
     {10240, "Microsoft Windows 10",    "10"},
     {22000, "Microsoft Windows 11",    "11"},
-    {0, 0}
+    { }
 };
 
 static void ga_get_win_version(RTL_OSVERSIONINFOEXW *info, Error **errp)
@@ -2191,7 +2188,8 @@ static char *ga_get_win_name(const OSVERSIONINFOEXW *os_version, bool id)
     DWORD minor = os_version->dwMinorVersion;
     DWORD build = os_version->dwBuildNumber;
     int tbl_idx = (os_version->wProductType != VER_NT_WORKSTATION);
-    const ga_matrix_lookup_t *table = WIN_VERSION_MATRIX[tbl_idx];
+    const ga_matrix_lookup_t *table = tbl_idx ?
+        WIN_SERVER_VERSION_MATRIX : WIN_CLIENT_VERSION_MATRIX;
     const ga_win_10_0_t *win_10_0_table = tbl_idx ?
         WIN_10_0_SERVER_VERSION_MATRIX : WIN_10_0_CLIENT_VERSION_MATRIX;
     const ga_win_10_0_t *win_10_0_version = NULL;
-- 
2.44.0


