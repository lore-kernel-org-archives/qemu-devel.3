Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE61DC88E7F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Ugt-0006yZ-Me; Tue, 15 Sep 2026 11:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aagbaria@redhat.com>)
 id 1x6UYw-0003gk-Ou
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aagbaria@redhat.com>)
 id 1x6UYu-0005gm-Aj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789484104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CgKk1faJYIh+LtPfleUaw9NjernxztxGAamFfM7vvBs=;
 b=S6K0+fi7HLSIzF5LqpIBKjqPLbGoTnwpIaWW22++24iYu8BrCyll1twxhmwk7gVduWslz1
 DldnXBo+CT0D9w1t96bcBAGhxORW0RLWedsbR+/or/dTkMtaVB/TJMiISjFp+naL5SjIHj
 SNNuVz3BDSpTqqLC7vuirJwwTZf4ezo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-_UmHChufN72jeRUA6QnLOw-1; Tue,
 15 Sep 2026 10:53:42 -0400
X-MC-Unique: _UmHChufN72jeRUA6QnLOw-1
X-Mimecast-MFC-AGG-ID: _UmHChufN72jeRUA6QnLOw_1789484021
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67A78195D003; Tue, 15 Sep 2026 14:53:41 +0000 (UTC)
Received: from aagbaria-thinkpadt14gen6.raanaii.csb (unknown [10.47.238.83])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F35F83003EF5; Tue, 15 Sep 2026 14:53:39 +0000 (UTC)
From: Abed Agbaria <aagbaria@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com, michael.roth@amd.com,
 Abed Agbaria <aagbaria@redhat.com>
Subject: [PATCH] qga/vss-win32/install.cpp: remove orphaned VSS provider
 service
Date: Tue, 15 Sep 2026 17:53:20 +0300
Message-ID: <20260915145320.215663-1-aagbaria@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aagbaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 15 Sep 2026 11:03:20 -0400
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

COMRegister() probes the COM+ catalog to decide whether to unregister
first, but it is the SCM that blocks installation when a service of the
same name is left over.  If the COM+ application is gone and the service
survives, install fails with 0x80070431 and never recovers.

 - Check the SCM as well as the COM+ catalog in COMRegister().
 - Delete the provider service in COMUnregister() and at the
   DllUnregisterServer() call sites in DllRegisterServer().

Signed-off-by: Abed Agbaria <aagbaria@redhat.com>
---
 qga/vss-win32/install.cpp | 88 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 5b7a8e9bc5..0e4f2ac009 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -241,6 +241,89 @@ out:
     return hr;
 }
 
+/* Check whether the QGA VSS provider service is registered with the SCM.*/
+static bool QGAProviderServiceExists(void)
+{
+    qga_debug_begin;
+
+    bool exists = false;
+    DWORD err;
+    SC_HANDLE manager = OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT);
+    SC_HANDLE service = NULL;
+
+    if (!manager) {
+        errmsg(GetLastError(), "Failed to open service manager");
+        goto out;
+    }
+
+    service = OpenService(manager, QGA_PROVIDER_NAME, SERVICE_QUERY_CONFIG);
+    if (service) {
+        exists = true;
+    } else {
+        err = GetLastError();
+        if (err != ERROR_SERVICE_DOES_NOT_EXIST) {
+            errmsg(err, "Failed to open service");
+        }
+    }
+
+out:
+    if (service) {
+        CloseServiceHandle(service);
+    }
+    if (manager) {
+        CloseServiceHandle(manager);
+    }
+    qga_debug_end;
+    return exists;
+}
+
+/* Delete a QGA VSS provider service that COM+ no longer owns.*/
+static HRESULT QGAProviderRemoveService(void)
+{
+    qga_debug_begin;
+
+    HRESULT hr = S_OK;
+    DWORD err;
+    SC_HANDLE manager = OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT);
+    SC_HANDLE service = NULL;
+
+    if (!manager) {
+        hr = HRESULT_FROM_WIN32(GetLastError());
+        errmsg(hr, "Failed to open service manager");
+        goto out;
+    }
+
+    service = OpenService(manager, QGA_PROVIDER_NAME, DELETE);
+    if (!service) {
+        err = GetLastError();
+        if (err != ERROR_SERVICE_DOES_NOT_EXIST) {
+            hr = HRESULT_FROM_WIN32(err);
+            errmsg(hr, "Failed to open service");
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
+            errmsg(hr, "Failed to delete service");
+        }
+    }
+
+out:
+    if (service) {
+        CloseServiceHandle(service);
+    }
+    if (manager) {
+        CloseServiceHandle(manager);
+    }
+    qga_debug_end;
+    return hr;
+}
+
 /* Unregister this module from COM+ Applications Catalog */
 STDAPI COMUnregister(void);
 STDAPI COMUnregister(void)
@@ -251,6 +334,7 @@ STDAPI COMUnregister(void)
 
     DllUnregisterServer();
     chk(QGAProviderFind(QGAProviderRemove, NULL));
+    chk(QGAProviderRemoveService());
 out:
     qga_debug_end;
     return hr;
@@ -286,7 +370,7 @@ STDAPI COMRegister(void)
     }
 
     chk(QGAProviderFind(QGAProviderCount, (void *)&count));
-    if (count) {
+    if (count || QGAProviderServiceExists()) {
         qga_debug("QGA VSS Provider is already installed. Attempting to unregister first.");
         hr = COMUnregister();
         if (FAILED(hr)) {
@@ -499,6 +583,7 @@ STDAPI DllRegisterServer(void)
                                      g_gProviderVersion);
     if (hr == (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
         DllUnregisterServer();
+        QGAProviderRemoveService();
         hr = pVssAdmin->RegisterProvider(g_gProviderId, CLSID_QGAVSSProvider,
                                          const_cast<WCHAR * >
                                          (QGA_PROVIDER_LNAME),
@@ -515,6 +600,7 @@ STDAPI DllRegisterServer(void)
 out:
     if (FAILED(hr)) {
         DllUnregisterServer();
+        QGAProviderRemoveService();
     }
 
     qga_debug_end;
-- 
2.55.0


