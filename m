Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69407E68952
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MQs-0003nb-C4; Thu, 31 Oct 2024 00:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQk-0003et-87
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:07 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQi-0004rb-Fu
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:06 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e30116efc9so392197a91.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347503; x=1730952303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sm6RxNg+VAWQBzeQTWA0D+UajI2IQKoU/Rfc9RmIGOo=;
 b=pH+r6WuB1/avRqOvfla8F/QlXyWZ9btRtaNenea9XTvpn3fFCEJSJgy64mQER8e2ba
 QjWphNg3beNj1vHzvxYlosBu+nBsuqvmVG2vt/TCpdQw1c5Ca0cAkorSZPhSHZpKz6jw
 HH+FWtPmWqdYg6+QA0nYyJgCkbzmiyZKBnDaLOXzk1RUnqNOhWOmyNXyiBKu3F+gfvxX
 sdKHMoKAoK0AAXaHRPSDFQDay+pWALkE9ztIfvarp6tjfzH4vx4QHghbvqFxA2QvmSxe
 juzYdgReBS5P5fsHhOkQdzXc29EAxfsO573A3W2Mh+ZVtyh3FxTz2/uvzPxBoyWe0dHm
 e6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347503; x=1730952303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sm6RxNg+VAWQBzeQTWA0D+UajI2IQKoU/Rfc9RmIGOo=;
 b=TaI0yb1QXIFjTYSTdsql0KmJNn4BSxQwdqnKU9XPcak0kWIF0DUluMOEz+LaDvHptL
 49DN5iz5kFdVOR46e45YSRZsPXEqwWj7W7YqtCNU1WJQFmHnquzjsOVCGv04dxtiDUvk
 LmAWXvNbENfK0rKp348ySjnpG52w8racO4lPyyh7qx8h5Fn73tTsLwmV9uwVKeJ55nQl
 3w88UchIomeam16ZZIZM44t+vge/GEnNqtMWm3z6i3rShh/5WoVANlb9xI7R9GilWzcj
 lCJn6S09WbjUuLYyxUw6eM02gcYHVFv5i4vkp4tDy8YtkLJIvyVzN3jY8Kll/Gc83B/2
 M6kQ==
X-Gm-Message-State: AOJu0YxwwCV0aHzQoLcZwCTI4vDjvPq5CaNCfCZLLYoWAZjcpnJel8ZV
 s6Mc5RJXPfPMV0D9LZFdpN2iOPIMKQgE3ZWneHKwSH77Lrj5KrMLrcxjW+C+REjKVVwGgrP6ve0
 n9Znd9A==
X-Google-Smtp-Source: AGHT+IHwyu+hau5X04RX9j6EFsNSJrEUmxTeMe33/MNSYJBt0a7atlZ0f5/7jO3Ig2+f2jwmlyTBnQ==
X-Received: by 2002:a17:90a:4e0a:b0:2e2:c6b9:fd4a with SMTP id
 98e67ed59e1d1-2e8f1072087mr20872679a91.18.1730347502813; 
 Wed, 30 Oct 2024 21:05:02 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:05:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 06/12] qga: fix missing static and prototypes windows warnings
Date: Wed, 30 Oct 2024 21:04:20 -0700
Message-Id: <20241031040426.772604-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reported by clang++, but not by g++.

../qga/vss-win32/provider.cpp:48:6: error: no previous prototype for function 'LockModule' [-Werror,-Wmissing-prototypes]
   48 | void LockModule(BOOL lock)
      |      ^
../qga/vss-win32/provider.cpp:48:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   48 | void LockModule(BOOL lock)
      | ^
      | static
../qga/vss-win32/provider.cpp:531:13: error: no previous prototype for function 'DllMain' [-Werror,-Wmissing-prototypes]
  531 | BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved)
      |             ^
../qga/vss-win32/provider.cpp:531:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
  531 | BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved)
      | ^
      | static

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qga/vss-win32/install.cpp   | 6 +++++-
 qga/vss-win32/provider.cpp  | 5 ++++-
 qga/vss-win32/requester.cpp | 8 ++++----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 84944133f79..5cea5bcf747 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -39,7 +39,7 @@ const GUID CLSID_WbemLocator = { 0x4590f811, 0x1d3a, 0x11d0,
 const GUID IID_IWbemLocator = { 0xdc12a687, 0x737f, 0x11cf,
     {0x88, 0x4d, 0x00, 0xaa, 0x00, 0x4b, 0x2e, 0x24} };
 
-void errmsg(DWORD err, const char *text)
+static void errmsg(DWORD err, const char *text)
 {
     /*
      * `text' contains function call statement when errmsg is called via chk().
@@ -242,6 +242,7 @@ out:
 }
 
 /* Unregister this module from COM+ Applications Catalog */
+STDAPI COMUnregister(void);
 STDAPI COMUnregister(void)
 {
     qga_debug_begin;
@@ -256,6 +257,7 @@ out:
 }
 
 /* Register this module to COM+ Applications Catalog */
+STDAPI COMRegister(void);
 STDAPI COMRegister(void)
 {
     qga_debug_begin;
@@ -380,11 +382,13 @@ out:
     return hr;
 }
 
+STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int);
 STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int)
 {
     COMRegister();
 }
 
+STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int);
 STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int)
 {
     COMUnregister();
diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index cc72e5ef1b9..a102a23fbf1 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -45,7 +45,7 @@ const IID IID_IVssEnumObject = { 0xAE1C7110, 0x2F60, 0x11d3,
     {0x8A, 0x39, 0x00, 0xC0, 0x4F, 0x72, 0xD8, 0xE3} };
 
 
-void LockModule(BOOL lock)
+static void LockModule(BOOL lock)
 {
     if (lock) {
         InterlockedIncrement(&g_nComObjsInUse);
@@ -527,6 +527,9 @@ STDAPI DllCanUnloadNow()
     return g_nComObjsInUse == 0 ? S_OK : S_FALSE;
 }
 
+EXTERN_C
+BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved);
+
 EXTERN_C
 BOOL WINAPI DllMain(HINSTANCE hinstDll, DWORD dwReason, LPVOID lpReserved)
 {
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 9884c65e707..4401d55e3a4 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -254,8 +254,8 @@ out:
     qga_debug_end;
 }
 
-DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR valueName,
-                          DWORD defaultData)
+static DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR valueName,
+                                 DWORD defaultData)
 {
     qga_debug_begin;
 
@@ -272,12 +272,12 @@ DWORD get_reg_dword_value(HKEY baseKey, LPCSTR subKey, LPCSTR valueName,
     return dwordData;
 }
 
-bool is_valid_vss_backup_type(VSS_BACKUP_TYPE vssBT)
+static bool is_valid_vss_backup_type(VSS_BACKUP_TYPE vssBT)
 {
     return (vssBT > VSS_BT_UNDEFINED && vssBT < VSS_BT_OTHER);
 }
 
-VSS_BACKUP_TYPE get_vss_backup_type(
+static VSS_BACKUP_TYPE get_vss_backup_type(
     VSS_BACKUP_TYPE defaultVssBT = DEFAULT_VSS_BACKUP_TYPE)
 {
     qga_debug_begin;
-- 
2.39.5


