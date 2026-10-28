Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A81606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KcRN+OLo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM0Bx-0007l7-FT; Wed, 28 Oct 2026 05:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM0Ad-0006tZ-SF
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM0Ab-0008Ra-QK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793180529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b54msd3s5LCaRfGkCwsJ1ziMbvtGqsr/nJB0EDM+edg=;
 b=KcRN+OLoR9TN3yFFqsBAoIlzjOzkl+olX2F3vZkr9ANnq1tFJIAgfiUQo0BGJDPTSEcmWp
 /sYTRMtxEAW+rhx9WrGymVVoXiTiNkAYdq9Ges4NRJMYqGF9bDWj1yImo5wqXK1fcA95xl
 JLPxayGt93t9xcObPZUuByFu+ce6bYU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-qQexNUqENk6xh7N4LdDdkw-1; Wed,
 28 Oct 2026 05:42:05 -0400
X-MC-Unique: qQexNUqENk6xh7N4LdDdkw-1
X-Mimecast-MFC-AGG-ID: qQexNUqENk6xh7N4LdDdkw_1793180524
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38D9E19560B4; Wed, 28 Oct 2026 09:42:04 +0000 (UTC)
Received: from Kostiantyns-MacBook-Pro.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26DDA1956086; Wed, 28 Oct 2026 09:42:02 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 4/6] qga/vss-win32: remove orphaned VSS provider service
Date: Wed, 28 Oct 2026 11:41:50 +0200
Message-ID: <20261028094152.14934-5-kkostiuk@redhat.com>
In-Reply-To: <20261028094152.14934-1-kkostiuk@redhat.com>
References: <20261028094152.14934-1-kkostiuk@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Abed Agbaria <aagbaria@redhat.com>

COMRegister() probes the COM+ catalog to decide whether to unregister
first, but it is the SCM that blocks installation when a service of the
same name is left over.  If the COM+ application is gone and the service
survives, install fails with 0x80070431 and never recovers.

 - Check the SCM as well as the COM+ catalog in COMRegister().
 - Delete the provider service in COMUnregister() and at the
   DllUnregisterServer() call sites in DllRegisterServer().

Opening the SCM, opening the provider service and closing both handles
is boilerplate that StopService() already contains, so move it into
QGAProviderOpenService(), which returns a single service handle and
reports the win32 error through an out parameter, and convert
StopService() to it.  The service handle stays valid after the SCM
handle is closed, so the helper closes it and each caller is left with
one handle to release.

While at it, fix two pre-existing problems in StopService():

 - It logged errmsg(E_FAIL, ...) and returned E_FAIL for every failure,
   discarding the GetLastError() value.  It now passes the win32 error
   code to errmsg() and returns HRESULT_FROM_WIN32().
 - It opened the SCM with SC_MANAGER_ALL_ACCESS, which implies
   SC_MANAGER_CREATE_SERVICE and is therefore refused to
   non-administrators, and passed that same SCM mask to OpenService()
   as a service access mask.  Each operation now requests only what it
   needs: SC_MANAGER_CONNECT on the SCM, and SERVICE_QUERY_CONFIG,
   DELETE or SERVICE_STOP on the service.

StopService()'s return value changes from E_FAIL to a specific
HRESULT_FROM_WIN32(); its only caller, in requester.cpp, ignores it.

Signed-off-by: Abed Agbaria <aagbaria@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260917154901.321702-1-aagbaria@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/vss-win32/install.cpp | 118 ++++++++++++++++++++++++++++++++------
 1 file changed, 101 insertions(+), 17 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 09d94edd4f..431fcd1cbe 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -257,6 +257,96 @@ static void qga_vss_open_log(void)
     }
 }
 
+/*
+ * Open the QGA VSS provider service with the requested access rights.
+ *
+ * On success, return a service handle which the caller must release with
+ * CloseServiceHandle().  On failure, return NULL and store the win32 error
+ * code in *err.  ERROR_SERVICE_DOES_NOT_EXIST just means the service is not
+ * installed, which is a normal condition for all callers, so it is not
+ * reported here; the caller decides what it means.
+ */
+static SC_HANDLE QGAProviderOpenService(DWORD access, DWORD *err)
+{
+    qga_debug_begin;
+
+    SC_HANDLE service = NULL;
+    SC_HANDLE manager = OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT);
+
+    *err = ERROR_SUCCESS;
+
+    if (!manager) {
+        *err = GetLastError();
+        errmsg(*err, "Failed to open service manager");
+        goto out;
+    }
+
+    service = OpenService(manager, QGA_PROVIDER_NAME, access);
+    if (!service) {
+        *err = GetLastError();
+        if (*err != ERROR_SERVICE_DOES_NOT_EXIST) {
+            errmsg(*err, "Failed to open service");
+        }
+    }
+
+out:
+    if (manager) {
+        CloseServiceHandle(manager);
+    }
+    qga_debug_end;
+    return service;
+}
+
+/* Check whether the QGA VSS provider service is registered with the SCM */
+static bool QGAProviderServiceExists(void)
+{
+    qga_debug_begin;
+
+    DWORD err;
+    SC_HANDLE service = QGAProviderOpenService(SERVICE_QUERY_CONFIG, &err);
+
+    if (service) {
+        CloseServiceHandle(service);
+    }
+
+    qga_debug_end;
+    return service != NULL;
+}
+
+/* Delete a QGA VSS provider service that COM+ no longer owns */
+static HRESULT QGAProviderRemoveService(void)
+{
+    qga_debug_begin;
+
+    HRESULT hr = S_OK;
+    DWORD err;
+    SC_HANDLE service = QGAProviderOpenService(DELETE, &err);
+
+    if (!service) {
+        if (err != ERROR_SERVICE_DOES_NOT_EXIST) {
+            hr = HRESULT_FROM_WIN32(err);
+        }
+        goto out;
+    }
+
+    qga_debug("Removing service: %s", QGA_PROVIDER_NAME);
+
+    if (!DeleteService(service)) {
+        err = GetLastError();
+        if (err != ERROR_SERVICE_MARKED_FOR_DELETE) {
+            hr = HRESULT_FROM_WIN32(err);
+            errmsg(err, "Failed to delete service");
+        }
+    }
+
+out:
+    if (service) {
+        CloseServiceHandle(service);
+    }
+    qga_debug_end;
+    return hr;
+}
+
 /* Unregister this module from COM+ Applications Catalog */
 STDAPI COMUnregister(void);
 STDAPI COMUnregister(void)
@@ -268,6 +358,7 @@ STDAPI COMUnregister(void)
 
     DllUnregisterServer();
     chk(QGAProviderFind(QGAProviderRemove, NULL));
+    chk(QGAProviderRemoveService());
 out:
     qga_debug_end;
     return hr;
@@ -304,7 +395,7 @@ STDAPI COMRegister(void)
     }
 
     chk(QGAProviderFind(QGAProviderCount, (void *)&count));
-    if (count) {
+    if (count || QGAProviderServiceExists()) {
         qga_debug("QGA VSS Provider is already installed. Attempting to unregister first.");
         hr = COMUnregister();
         if (FAILED(hr)) {
@@ -517,6 +608,7 @@ STDAPI DllRegisterServer(void)
                                      g_gProviderVersion);
     if (hr == (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
         DllUnregisterServer();
+        QGAProviderRemoveService();
         hr = pVssAdmin->RegisterProvider(g_gProviderId, CLSID_QGAVSSProvider,
                                          const_cast<WCHAR * >
                                          (QGA_PROVIDER_LNAME),
@@ -533,6 +625,7 @@ STDAPI DllRegisterServer(void)
 out:
     if (FAILED(hr)) {
         DllUnregisterServer();
+        QGAProviderRemoveService();
     }
 
     qga_debug_end;
@@ -594,33 +687,24 @@ STDAPI StopService(void)
     qga_debug_begin;
 
     HRESULT hr = S_OK;
-    SC_HANDLE manager = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
-    SC_HANDLE service = NULL;
-
-    if (!manager) {
-        errmsg(E_FAIL, "Failed to open service manager");
-        hr = E_FAIL;
-        goto out;
-    }
-    service = OpenService(manager, QGA_PROVIDER_NAME, SC_MANAGER_ALL_ACCESS);
+    DWORD err;
+    SC_HANDLE service = QGAProviderOpenService(SERVICE_STOP, &err);
 
     if (!service) {
-        errmsg(E_FAIL, "Failed to open service");
-        hr =  E_FAIL;
+        hr = HRESULT_FROM_WIN32(err);
         goto out;
     }
+
     if (!(ControlService(service, SERVICE_CONTROL_STOP, &status))) {
-        errmsg(E_FAIL, "Failed to stop service");
-        hr = E_FAIL;
+        err = GetLastError();
+        hr = HRESULT_FROM_WIN32(err);
+        errmsg(err, "Failed to stop service");
     }
 
 out:
     if (service) {
         CloseServiceHandle(service);
     }
-    if (manager) {
-        CloseServiceHandle(manager);
-    }
     qga_debug_end;
     return hr;
 }
-- 
2.54.0 (Apple Git-157)


