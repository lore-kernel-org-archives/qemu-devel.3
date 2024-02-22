Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E5FC54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 15:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdB0C-0005AH-9u; Thu, 22 Feb 2024 10:28:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdB0A-00059s-I3
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:28:46 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdB08-0000Nw-Tb
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:28:46 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4127946aa11so11263515e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 07:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708615723; x=1709220523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJ101CcDEsIgwbCRRwIlIJGFhtgnXY0NDhltmJmVB0g=;
 b=wnXfQxuXCFERBN1w3t23hKd85+GDWIfphAe4Qs9RBTdQMt3V0LgRorITZ8GDWlZPJw
 PRD+2xD9dXOzYtym3l+vBQ2Mjwqx3bcG7o9oYqOdkTenFb0kKxghQtreqjjAtXfrrBCS
 3x4a0VZ9rWmJCds/JJ/cmg304eMnG9whv0pOUsEbGWJSeZNb3LVFHYsYddX3eQpy8Hj+
 WdNNYMeyWlsFyEt2V/Uq+YoEHHOKTvlX7dHfZi62paUAlmMwCjfxfYaaVEMOcEF/VSui
 lgJbbF1GbljWFezhhfQgypk6M/Mxixiy0qFqmIXVWzhOjSOTY59sQIW1Glf9yW2Pi5Sj
 Uv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708615723; x=1709220523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJ101CcDEsIgwbCRRwIlIJGFhtgnXY0NDhltmJmVB0g=;
 b=jcyRMOlGoWisUTetYc08XBw/+7UPP5VNv6PKJxbUd33GUjvlSjdQR1pis0P6tNyM2m
 3396j7fVS0BM/jznMMnYnTCqMcrpUuiOEPiJk6Liv8pt4L1iXy7J2ZWVAWoV2U6RLEgy
 HvfVaZgr+sDnjsnPxYvRJ9D6bHo9i/3a5q0t0zxpDnYcUKDBCEll1eAwdwiX7Q52d5hU
 Mum2F396F+YIss8ZXWZtiw3PJSqpsF4iMe4zAsb738ze09Si3VTEf5Ee9Jq6CVMX5Bzp
 LxuOl3CP5TVgLFne3SX0FnNGTykAbwQCsATgBnMl8b6CpURqh5GDg8CpLy78jf56MQNV
 n2gQ==
X-Gm-Message-State: AOJu0YziEpFw7/pN36ZHV97eNeGhWEZ9Keg4E9RUrpebfbsljEhw50R4
 AfMCskQ1alwD1a8ALKlhafg3Vy83blnqfvhsH2l1B2G7Uwl7MjnxIlOW/8MHuEAf8jN2l6WvCVt
 SSV0=
X-Google-Smtp-Source: AGHT+IFoEO9QA1VxgNNjA3JJzbPRAuR1HlpdndQrBl6cPXw7w5pte/Z4CjGAqFMSHUR7pUfv62lcoQ==
X-Received: by 2002:a05:600c:502c:b0:412:8faa:65db with SMTP id
 n44-20020a05600c502c00b004128faa65dbmr168971wmr.38.1708615723211; 
 Thu, 22 Feb 2024 07:28:43 -0800 (PST)
Received: from m1x-phil.lan (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 26-20020a05600c025a00b0041273fc463csm6349173wmj.17.2024.02.22.07.28.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 07:28:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Dehan Meng <demeng@redhat.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/3] qga/commands-win32: Declare const qualifier before type
Date: Thu, 22 Feb 2024 16:28:33 +0100
Message-ID: <20240222152835.72095-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240222152835.72095-1-philmd@linaro.org>
References: <20240222152835.72095-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Most of the code base use the 'const' qualifier *before*
the type being qualified. Use the same style to unify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.41.0


