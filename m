Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10222C5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDfT-0003jc-6u; Wed, 28 May 2025 06:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfQ-0003iM-P1
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfO-0007Dm-Am
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4BcFeHZdhTzXIhCu3ar2uLEb5iCDSRwkE8Rgxvkcgk=;
 b=gLOEN6F0nB8h8yaxacxGwD/3+i14WrCFnsavqVFRORjkNpjKdiPOqQ4bAN9HBZhmMZkcVA
 Nf0VSo4BBvtYRK3rM2lLwXE2tPHEt824Xd6XcL2tZcoG8nP270GDk5oT2urzJsQopaA4KL
 pkktEsbpUcutEdf619gABM7ftTfGECo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-pMATDg3INvygN3Hne6Dhmw-1; Wed,
 28 May 2025 06:05:44 -0400
X-MC-Unique: pMATDg3INvygN3Hne6Dhmw-1
X-Mimecast-MFC-AGG-ID: pMATDg3INvygN3Hne6Dhmw_1748426743
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4D8E1800373; Wed, 28 May 2025 10:05:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30970180049D; Wed, 28 May 2025 10:05:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 10/27] hw/i386/pc: Remove deprecated pc-q35-2.4 and
 pc-i440fx-2.4 machines
Date: Wed, 28 May 2025 12:04:50 +0200
Message-ID: <20250528100507.313906-11-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Remove the qtest in test-x86-cpuid-compat.c file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20250512083948.39294-2-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc_piix.c                   | 13 -------------
 hw/i386/pc_q35.c                    | 13 -------------
 tests/qtest/test-x86-cpuid-compat.c | 14 --------------
 3 files changed, 40 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0dce512f184..04213b45b44 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -791,19 +791,6 @@ static void pc_i440fx_machine_2_5_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 5);
 
-static void pc_i440fx_machine_2_4_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_2_5_options(m);
-    m->hw_version = "2.4.0";
-    pcmc->broken_reserved_end = true;
-    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
-    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 4);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index c538b3d05b4..47e12602413 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -685,16 +685,3 @@ static void pc_q35_machine_2_5_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 5);
-
-static void pc_q35_machine_2_4_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_q35_machine_2_5_options(m);
-    m->hw_version = "2.4.0";
-    pcmc->broken_reserved_end = true;
-    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
-    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
-}
-
-DEFINE_Q35_MACHINE(2, 4);
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index c9de47bb269..456e2af6657 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -365,20 +365,6 @@ int main(int argc, char **argv)
                        "level", 10);
     }
 
-    /*
-     * xlevel doesn't have any feature that triggers auto-level
-     * code on old machine-types.  Just check that the compat code
-     * is working correctly:
-     */
-    if (qtest_has_machine("pc-i440fx-2.4")) {
-        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
-                       "SandyBridge", NULL, "pc-i440fx-2.4",
-                       "xlevel", 0x80000008);
-        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
-                       "SandyBridge", "svm=on,npt=on", "pc-i440fx-2.4",
-                       "xlevel", 0x80000008);
-    }
-
     /* Test feature parsing */
     add_feature_test("x86/cpuid/features/plus",
                      "486", "+arat",
-- 
2.49.0


