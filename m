Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BCDC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh8df-0000Zv-AW; Mon, 04 Mar 2024 08:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh8dU-0000ZQ-Ux
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:45:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh8dQ-0000ue-9A
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709559939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSwkEkSW6CtLjOsJilX8J3bkrv/9gWdnkPWWOnvuipw=;
 b=V/Ng13tpGtR5/TYY08yb/yDAptT1Si8IGHBbpPWYdtFEj+PxF5ajn8nZJw1tzE8PJK5wWv
 HmhbiMv9Vk/NuEh8SE3FvHGfBBDCyNarQZyNzfDwveCn+/71LHMG1HXccQd2KmgMTS3QA0
 pBI/wpB8340E3XJIJSYvJbHL1ZAy9ps=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-F5Le5QRLO3WHRtP-MBGbeQ-1; Mon,
 04 Mar 2024 08:45:36 -0500
X-MC-Unique: F5Le5QRLO3WHRtP-MBGbeQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05BD83C0F232;
 Mon,  4 Mar 2024 13:45:36 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.226.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F193624D;
 Mon,  4 Mar 2024 13:45:34 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dehan Meng <demeng@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Subject: [PATCH v4 1/3] qga/commands-win32: Declare const qualifier before type
Date: Mon,  4 Mar 2024 15:45:30 +0200
Message-ID: <20240304134532.28506-2-kkostiuk@redhat.com>
In-Reply-To: <20240304134532.28506-1-kkostiuk@redhat.com>
References: <20240304134532.28506-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

Most of the code base use the 'const' qualifier *before*
the type being qualified. Use the same style to unify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240222152835.72095-2-philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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


