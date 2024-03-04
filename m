Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F58C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh8dm-0000dA-0H; Mon, 04 Mar 2024 08:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh8di-0000co-8H
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:45:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh8dR-0000uk-Cn
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709559940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6J5oh8U2LJyvNNXLz/CYBSqH4JLeLvNtvRZckNxhbIQ=;
 b=c6CgDlHECR/tGcfR9gT7lekT2/JhLLuqCnaQ5B6mQJay5O2a4i2YhisHYRCZ2w1HQIVuWR
 p8+TrtZri9r5SIp5wOPlgby7VdTle7OtFOYNopnXK1qZ1zksmDxP7+VRai1YUX6TwrujKi
 oXLLB2spweOixNrqWytByszi+x32HdE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-NvctdcphMQ6OuGfgzJmTFQ-1; Mon, 04 Mar 2024 08:45:37 -0500
X-MC-Unique: NvctdcphMQ6OuGfgzJmTFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52C6A85A58F;
 Mon,  4 Mar 2024 13:45:37 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.226.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A91B24D;
 Mon,  4 Mar 2024 13:45:36 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dehan Meng <demeng@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Subject: [PATCH v4 2/3] qga/commands-win32: Do not set
 matrix_lookup_t/win_10_0_t arrays size
Date: Mon,  4 Mar 2024 15:45:31 +0200
Message-ID: <20240304134532.28506-3-kkostiuk@redhat.com>
In-Reply-To: <20240304134532.28506-1-kkostiuk@redhat.com>
References: <20240304134532.28506-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-win32.c | 52 +++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 79b5a580c9..a830f1494e 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2124,45 +2124,42 @@ typedef struct _ga_matrix_lookup_t {
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
     int first_build;
-    const char *version;
-    const char *version_id;
+    char const *version;
+    char const *version_id;
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


