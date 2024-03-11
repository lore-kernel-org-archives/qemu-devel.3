Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B19EC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 16:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjiy0-00056G-Ac; Mon, 11 Mar 2024 12:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rjixz-00054C-0p
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rjixx-0005zf-E9
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710176252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9d+LTN83r2rY7ixxhzwmhw6wv45EVmHvQQDqrHorbps=;
 b=b5ypW+GaLNnf0Q3Lt53qoxnhJTRMdyYoUeFfvXUHVHuH3MmC05LjneLwenwE2f4sogCc3C
 YMaXYeGlO4h5X0gOBNOwg1R2C7JvdV7mQsXXMf/ZQO4HGxsT8mOOdLqB8/n130pOe9zRhq
 0COYOzDTW4TgCHvjCpNC5G+dJ/TFxrA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-hJGUVA3GPtWOsZbDXTzDCg-1; Mon, 11 Mar 2024 12:57:29 -0400
X-MC-Unique: hJGUVA3GPtWOsZbDXTzDCg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 494318007A2;
 Mon, 11 Mar 2024 16:57:29 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E73D10F43;
 Mon, 11 Mar 2024 16:57:28 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 1/3] qga/commands-win32: Declare const qualifier before type
Date: Mon, 11 Mar 2024 18:57:22 +0200
Message-ID: <20240311165724.176168-2-kkostiuk@redhat.com>
In-Reply-To: <20240311165724.176168-1-kkostiuk@redhat.com>
References: <20240311165724.176168-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Most of the code base use the 'const' qualifier *before*
the type being qualified. Use the same style to unify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240222152835.72095-2-philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Link: https://lore.kernel.org/r/20240304134532.28506-2-kkostiuk@redhat.com
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-win32.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index a1015757d8..79b5a580c9 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2120,11 +2120,11 @@ GuestUserList *qmp_guest_get_users(Error **errp)
 typedef struct _ga_matrix_lookup_t {
     int major;
     int minor;
-    char const *version;
-    char const *version_id;
+    const char *version;
+    const char *version_id;
 } ga_matrix_lookup_t;
 
-static ga_matrix_lookup_t const WIN_VERSION_MATRIX[2][7] = {
+static const ga_matrix_lookup_t WIN_VERSION_MATRIX[2][7] = {
     {
         /* Desktop editions */
         { 5, 0, "Microsoft Windows 2000",   "2000"},
@@ -2148,18 +2148,18 @@ static ga_matrix_lookup_t const WIN_VERSION_MATRIX[2][7] = {
 
 typedef struct _ga_win_10_0_t {
     int first_build;
-    char const *version;
-    char const *version_id;
+    const char *version;
+    const char *version_id;
 } ga_win_10_0_t;
 
-static ga_win_10_0_t const WIN_10_0_SERVER_VERSION_MATRIX[4] = {
+static const ga_win_10_0_t WIN_10_0_SERVER_VERSION_MATRIX[4] = {
     {14393, "Microsoft Windows Server 2016",    "2016"},
     {17763, "Microsoft Windows Server 2019",    "2019"},
     {20344, "Microsoft Windows Server 2022",    "2022"},
     {0, 0}
 };
 
-static ga_win_10_0_t const WIN_10_0_CLIENT_VERSION_MATRIX[3] = {
+static const ga_win_10_0_t WIN_10_0_CLIENT_VERSION_MATRIX[3] = {
     {10240, "Microsoft Windows 10",    "10"},
     {22000, "Microsoft Windows 11",    "11"},
     {0, 0}
@@ -2185,16 +2185,16 @@ static void ga_get_win_version(RTL_OSVERSIONINFOEXW *info, Error **errp)
     return;
 }
 
-static char *ga_get_win_name(OSVERSIONINFOEXW const *os_version, bool id)
+static char *ga_get_win_name(const OSVERSIONINFOEXW *os_version, bool id)
 {
     DWORD major = os_version->dwMajorVersion;
     DWORD minor = os_version->dwMinorVersion;
     DWORD build = os_version->dwBuildNumber;
     int tbl_idx = (os_version->wProductType != VER_NT_WORKSTATION);
-    ga_matrix_lookup_t const *table = WIN_VERSION_MATRIX[tbl_idx];
-    ga_win_10_0_t const *win_10_0_table = tbl_idx ?
+    const ga_matrix_lookup_t *table = WIN_VERSION_MATRIX[tbl_idx];
+    const ga_win_10_0_t *win_10_0_table = tbl_idx ?
         WIN_10_0_SERVER_VERSION_MATRIX : WIN_10_0_CLIENT_VERSION_MATRIX;
-    ga_win_10_0_t const *win_10_0_version = NULL;
+    const ga_win_10_0_t *win_10_0_version = NULL;
     while (table->version != NULL) {
         if (major == 10 && minor == 0) {
             while (win_10_0_table->version != NULL) {
-- 
2.44.0


