Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB2AC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYja4-0001kz-97; Fri, 17 Jan 2025 05:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYja2-0001kE-1F
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYjZz-0004DP-GA
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737109674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ysEtvbwR2oM7KzpPPmqWFHrBhbWKMWCq5lzJWnFKaRo=;
 b=LC2LfmKF9o0b7poJTiOEcjD17bDMYu381u4wO+SN/ayX1IxKkJkPqP1gY6Cp8U/wwuLrdL
 czI41ne91k27aL8dsU8W9Qn9xKWtVPbWaxUjkGoUcDnujufvMWPUKFJzW4qhVWkZdwttsv
 U/9873xaN5OlS/2a0W0eLYoUGG3LItU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-_NgbYu_IMEKbXsXX9N0_Ww-1; Fri,
 17 Jan 2025 05:27:51 -0500
X-MC-Unique: _NgbYu_IMEKbXsXX9N0_Ww-1
X-Mimecast-MFC-AGG-ID: _NgbYu_IMEKbXsXX9N0_Ww
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A77751955D8F; Fri, 17 Jan 2025 10:27:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.246])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E76F195E3E1; Fri, 17 Jan 2025 10:27:44 +0000 (UTC)
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
Subject: [PATCH 1/3] tests/qtest/test-x86-cpuid-compat: Remove tests related
 to pc-i440fx-2.3
Date: Fri, 17 Jan 2025 11:27:36 +0100
Message-ID: <20250117102738.59714-2-thuth@redhat.com>
In-Reply-To: <20250117102738.59714-1-thuth@redhat.com>
References: <20250117102738.59714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.797,
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

The pc-i440fx-2.3 machine type has been removed in commit 46a2bd5257
("hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine") already, so
these tests are just dead code by now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/test-x86-cpuid-compat.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index b9e7e5ef7b..9cbc8b7ae9 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -357,19 +357,6 @@ int main(int argc, char **argv)
                        "486", "xstore=on", "pc-i440fx-2.7",
                        "xlevel2", 0);
     }
-    /*
-     * QEMU 2.3.0 had auto-level enabled for CPUID[7], already,
-     * and the compat code that sets default level shouldn't
-     * disable the auto-level=7 code:
-     */
-    if (qtest_has_machine("pc-i440fx-2.3")) {
-        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/off",
-                       "Penryn", NULL, "pc-i440fx-2.3",
-                       "level", 4);
-        add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/on",
-                       "Penryn", "erms=on", "pc-i440fx-2.3",
-                       "level", 7);
-    }
     if (qtest_has_machine("pc-i440fx-2.9")) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
                        "Conroe", NULL, "pc-i440fx-2.9",
@@ -384,11 +371,6 @@ int main(int argc, char **argv)
      * code on old machine-types.  Just check that the compat code
      * is working correctly:
      */
-    if (qtest_has_machine("pc-i440fx-2.3")) {
-        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.3",
-                       "SandyBridge", NULL, "pc-i440fx-2.3",
-                       "xlevel", 0x8000000a);
-    }
     if (qtest_has_machine("pc-i440fx-2.4")) {
         add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
                        "SandyBridge", NULL, "pc-i440fx-2.4",
-- 
2.47.1


