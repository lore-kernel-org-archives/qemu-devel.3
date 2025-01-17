Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE80EC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:28:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjaK-0001mM-AG; Fri, 17 Jan 2025 05:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYjaE-0001lm-Kq
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:28:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYjaC-0004Fp-C1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737109686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yvrLcmeZVqKJRbAqvOvMCTKyKz4Kx/RoToFyOYy1EaI=;
 b=Xjmtec2gQ9wJJy4W4ha+rMD+HR62sZd0fY+//V4H+t3jMwsugdOtK2V1KMYNKAXwXAZOA/
 tVBsqDyni1krUMSR1EtHQYCtfwaraCofIcsTF49PoBq8XSXmIRCl5Xp333LZxWhk7Z6wtk
 O/1z7P/s99HNVheE/kX5wfFvFbpVrMk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-B4GebhnvPsS9pkqXXnMJNQ-1; Fri,
 17 Jan 2025 05:28:01 -0500
X-MC-Unique: B4GebhnvPsS9pkqXXnMJNQ-1
X-Mimecast-MFC-AGG-ID: B4GebhnvPsS9pkqXXnMJNQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67808195608D; Fri, 17 Jan 2025 10:28:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.246])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62C90195608A; Fri, 17 Jan 2025 10:27:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 3/3] tests/qtest/test-x86-cpuid-compat: Replaced the removed
 pc-i440fx-2.* machines
Date: Fri, 17 Jan 2025 11:27:38 +0100
Message-ID: <20250117102738.59714-4-thuth@redhat.com>
In-Reply-To: <20250117102738.59714-1-thuth@redhat.com>
References: <20250117102738.59714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since the pc-i440fx-2.* machine types have been removed, let's run
the tests with the corresponding q35 machine types instead (until
those get removed, too, then we have to remove the tests completely).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/test-x86-cpuid-compat.c | 34 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 9cbc8b7ae9..f77e481279 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -346,23 +346,23 @@ int main(int argc, char **argv)
 
     /* Check compatibility of old machine-types that didn't
      * auto-increase level/xlevel/xlevel2: */
-    if (qtest_has_machine("pc-i440fx-2.7")) {
-        add_cpuid_test("x86/cpuid/auto-level/pc-2.7",
+    if (qtest_has_machine("pc-q35-2.7")) {
+        add_cpuid_test("x86/cpuid/auto-level/pc-q35-2.7",
                        "486", "arat=on,avx512vbmi=on,xsaveopt=on",
-                       "pc-i440fx-2.7", "level", 1);
-        add_cpuid_test("x86/cpuid/auto-xlevel/pc-2.7",
+                       "pc-q35-2.7", "level", 1);
+        add_cpuid_test("x86/cpuid/auto-xlevel/pc-q35-2.7",
                        "486", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                       "pc-i440fx-2.7", "xlevel", 0);
-        add_cpuid_test("x86/cpuid/auto-xlevel2/pc-2.7",
-                       "486", "xstore=on", "pc-i440fx-2.7",
+                       "pc-q35-2.7", "xlevel", 0);
+        add_cpuid_test("x86/cpuid/auto-xlevel2/pc-q35-2.7",
+                       "486", "xstore=on", "pc-q35-2.7",
                        "xlevel2", 0);
     }
-    if (qtest_has_machine("pc-i440fx-2.9")) {
-        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
-                       "Conroe", NULL, "pc-i440fx-2.9",
+    if (qtest_has_machine("pc-q35-2.9")) {
+        add_cpuid_test("x86/cpuid/auto-level7/pc-q35-2.9/off",
+                       "Conroe", NULL, "pc-q35-2.9",
                        "level", 10);
-        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/on",
-                       "Conroe", "erms=on", "pc-i440fx-2.9",
+        add_cpuid_test("x86/cpuid/auto-level7/pc-q35-2.9/on",
+                       "Conroe", "erms=on", "pc-q35-2.9",
                        "level", 10);
     }
 
@@ -371,12 +371,12 @@ int main(int argc, char **argv)
      * code on old machine-types.  Just check that the compat code
      * is working correctly:
      */
-    if (qtest_has_machine("pc-i440fx-2.4")) {
-        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
-                       "SandyBridge", NULL, "pc-i440fx-2.4",
+    if (qtest_has_machine("pc-q35-2.4")) {
+        add_cpuid_test("x86/cpuid/xlevel-compat/pc-q35-2.4/npt-off",
+                       "SandyBridge", NULL, "pc-q35-2.4",
                        "xlevel", 0x80000008);
-        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
-                       "SandyBridge", "svm=on,npt=on", "pc-i440fx-2.4",
+        add_cpuid_test("x86/cpuid/xlevel-compat/pc-q35-2.4/npt-on",
+                       "SandyBridge", "svm=on,npt=on", "pc-q35-2.4",
                        "xlevel", 0x80000008);
     }
 
-- 
2.47.1


