Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888DCC83F10
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Jul 2025 13:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaaHQ-0007fW-UH; Sat, 12 Jul 2025 09:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uaaHL-0007dn-MG
 for qemu-devel@nongnu.org; Sat, 12 Jul 2025 09:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uaaHJ-000398-HD
 for qemu-devel@nongnu.org; Sat, 12 Jul 2025 09:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752326908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NQgnwOxm8SMdCCueXNSX8RnBbLLlgFWSXKeYcZQinkg=;
 b=IL+Op7NCces+5DUFoMQHZMQi68QBjTvCAN65GNon00RsgKNyqY1/wF37i/fIaCjsmnLNp5
 gFrstfoJhRSNmeXggdixrAioA4BC9ylRfWVrNFBBWoyNPvFbQ+jtl0sl+2Y5HfVJVhfYVh
 FYJlCSBbwCJuwj5bV32SPkFt9Ju9+nc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-RG3E7s5lNkygC1QZ9XeQqg-1; Sat, 12 Jul 2025 09:28:26 -0400
X-MC-Unique: RG3E7s5lNkygC1QZ9XeQqg-1
X-Mimecast-MFC-AGG-ID: RG3E7s5lNkygC1QZ9XeQqg_1752326905
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-456106b7c4aso97845e9.0
 for <qemu-devel@nongnu.org>; Sat, 12 Jul 2025 06:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752326904; x=1752931704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NQgnwOxm8SMdCCueXNSX8RnBbLLlgFWSXKeYcZQinkg=;
 b=VZ7ZglhnsJti0gT8MdUug2ZiNbjPh8IojJaJeXwG0yEQDsG8ai/+6KNH2DZMzBpBaO
 ZEqH1lp8zLGRK+Oav3nxRsIBVC3vvoHZ7WKLIAj4G5zrB1OUgBx+q48Li8eIpqVZq9MH
 YzNBO+Tx+cxLTHWDZJsQj1FVitvoipd3Ya+7zFJO+oFyyzw3/KR5aVmqZlXgDzHRJbve
 pW8FZW3+MuRGGg5vIQvbugKVj3DkieEWnA31Gyruddgrx/Ee7ePYQ6r3E7DftJrSq9q9
 azWQELoQCIHWCro+OnrQ/EsFAsVmlU62sixolDvxZgFGHEoqpk/BHE0jSDR/X7WoMnWL
 al+Q==
X-Gm-Message-State: AOJu0YxTj1ohJCI9UGscjVDa3AqPFIyBVrPSfr8+GmZ/48HzlCc6kvhD
 6nlqJykeBiyEMgjHj7AM86/BibtVjW/7MFQ4y64KJq8c4XQYylaEEBaodEgqafAYfAxfX4nh2yj
 LHV+ZPh7ItpzrNQWBU/qwEthGSFXYSxIy6BVztsOB4ZfDA+p41+rSandoI/qvBaPpFAm6ba9kHT
 264QAbKbNe3cyuEhNZnmK5qtaezvQx3oh78Ep57LTP
X-Gm-Gg: ASbGnct3gKwqjIj5RRv/jhHXe0X6+rCClW1g6Jb2Dxtfs0Ryx1yxQTJuth6KRymRz/4
 RFOMGf+bv8+zBxi+HENz2K545166XoVmK9oWXimgOhs58IvTeP4aCgJ64YmyZZ3BaRYTdkH0py3
 I5SzuD3UOZR9WXDPf8YDmflugST1jC1OnxkLNVc7dIVSwQSm+Bx6LYlfDMhP/p2fFM/Xli29myA
 SbGtEmP5211GdcsA70kr2FKWgINd+ro25zknVXYoXvFTtTJgrwJcZR/8YwNLdG3iYYvdwhqsk6l
 7n9hb3x8ZxiIB1q2tmWQ8PmN9r6WiSOjHhlbF5BRCrf+
X-Received: by 2002:a05:6000:2c0f:b0:3a5:3993:3427 with SMTP id
 ffacd0b85a97d-3b5f1e95fb8mr7120394f8f.26.1752326904447; 
 Sat, 12 Jul 2025 06:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3D+5fuXdcxlaFf7zuVs3WV4wxpW3FruQKwQSkVZRzFzf2NBwywMk6b6u7QpI/HGlb4OJVlQ==
X-Received: by 2002:a05:6000:2c0f:b0:3a5:3993:3427 with SMTP id
 ffacd0b85a97d-3b5f1e95fb8mr7120368f8f.26.1752326903875; 
 Sat, 12 Jul 2025 06:28:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d70csm7435748f8f.62.2025.07.12.06.28.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Jul 2025 06:28:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/functional: test_x86_cpu_model_versions: remove dead
 tests
Date: Sat, 12 Jul 2025 15:28:22 +0200
Message-ID: <20250712132822.69236-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Tests that require machines older than 4.2 are now unconditionally skipped.
Remove them if they test legacy behavior, or use the latest machine if
they test current behavior.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../functional/test_x86_cpu_model_versions.py | 110 ++----------------
 1 file changed, 12 insertions(+), 98 deletions(-)

diff --git a/tests/functional/test_x86_cpu_model_versions.py b/tests/functional/test_x86_cpu_model_versions.py
index bd18acd44fa..36c968f1c0b 100755
--- a/tests/functional/test_x86_cpu_model_versions.py
+++ b/tests/functional/test_x86_cpu_model_versions.py
@@ -72,44 +72,11 @@ def validate_variant_aliases(self, cpus):
         self.assertNotIn("EPYC-IBPB-v1", cpus,
                          "EPYC-IBPB shouldn't be versioned")
 
-    def test_4_0_alias_compatibility(self):
-        """
-        Check if pc-*-4.0 unversioned CPU model won't be reported as aliases
-        """
-        self.set_machine('pc-i440fx-4.0')
-        # pc-*-4.0 won't expose non-versioned CPU models as aliases
-        # We do this to help management software to keep compatibility
-        # with older QEMU versions that didn't have the versioned CPU model
-        self.vm.add_args('-S')
-        self.vm.launch()
-        cpus = dict((m['name'], m) for m in
-                    self.vm.cmd('query-cpu-definitions'))
-
-        self.assertFalse(cpus['Cascadelake-Server']['static'],
-                         'unversioned Cascadelake-Server CPU model must not be static')
-        self.assertNotIn('alias-of', cpus['Cascadelake-Server'],
-                         'Cascadelake-Server must not be an alias')
-        self.assertNotIn('alias-of', cpus['Cascadelake-Server-v1'],
-                         'Cascadelake-Server-v1 must not be an alias')
-
-        self.assertFalse(cpus['qemu64']['static'],
-                         'unversioned qemu64 CPU model must not be static')
-        self.assertNotIn('alias-of', cpus['qemu64'],
-                         'qemu64 must not be an alias')
-        self.assertNotIn('alias-of', cpus['qemu64-v1'],
-                         'qemu64-v1 must not be an alias')
-
-        self.validate_variant_aliases(cpus)
-
-        # On pc-*-4.0, no CPU model should be reported as an alias:
-        for name,c in cpus.items():
-            self.assertNotIn('alias-of', c, "%s shouldn't be an alias" % (name))
-
-    def test_4_1_alias(self):
+    def test_unversioned_alias(self):
         """
         Check if unversioned CPU model is an alias pointing to right version
         """
-        self.set_machine('pc-i440fx-4.1')
+        self.set_machine('pc')
         self.vm.add_args('-S')
         self.vm.launch()
 
@@ -133,7 +100,7 @@ def test_4_1_alias(self):
 
         self.validate_variant_aliases(cpus)
 
-        # On pc-*-4.1, -noTSX and -IBRS models should be aliases:
+        # On recent PC machines, -noTSX and -IBRS models should be aliases:
         self.assertEqual(cpus["Haswell"].get('alias-of'),
                          "Haswell-v1",
                          "Haswell must be an alias")
@@ -247,8 +214,8 @@ def get_cpu_prop(self, prop):
         cpu_path = self.vm.cmd('query-cpus-fast')[0].get('qom-path')
         return self.vm.cmd('qom-get', path=cpu_path, property=prop)
 
-    def test_4_1(self):
-        self.set_machine('pc-i440fx-4.1')
+    def test(self):
+        self.set_machine('pc')
         # machine-type only:
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
@@ -256,80 +223,27 @@ def test_4_1(self):
                         'enforce=off')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
-                         'pc-i440fx-4.1 + Cascadelake-Server should not have arch-capabilities')
+                         'pc + Cascadelake-Server should not have arch-capabilities')
 
-    def test_4_0(self):
-        self.set_machine('pc-i440fx-4.0')
-        self.vm.add_args('-S')
-        self.set_vm_arg('-cpu',
-                        'Cascadelake-Server,x-force-features=on,check=off,'
-                        'enforce=off')
-        self.vm.launch()
-        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
-                         'pc-i440fx-4.0 + Cascadelake-Server should not have arch-capabilities')
-
-    def test_set_4_0(self):
-        self.set_machine('pc-i440fx-4.0')
-        # command line must override machine-type if CPU model is not versioned:
-        self.vm.add_args('-S')
-        self.set_vm_arg('-cpu',
-                        'Cascadelake-Server,x-force-features=on,check=off,'
-                        'enforce=off,+arch-capabilities')
-        self.vm.launch()
-        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
-                        'pc-i440fx-4.0 + Cascadelake-Server,+arch-capabilities should have arch-capabilities')
-
-    def test_unset_4_1(self):
-        self.set_machine('pc-i440fx-4.1')
+    def test_unset(self):
+        self.set_machine('pc')
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
                         'Cascadelake-Server,x-force-features=on,check=off,'
                         'enforce=off,-arch-capabilities')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
-                         'pc-i440fx-4.1 + Cascadelake-Server,-arch-capabilities should not have arch-capabilities')
+                         'pc + Cascadelake-Server,-arch-capabilities should not have arch-capabilities')
 
-    def test_v1_4_0(self):
-        self.set_machine('pc-i440fx-4.0')
-        # versioned CPU model overrides machine-type:
-        self.vm.add_args('-S')
-        self.set_vm_arg('-cpu',
-                        'Cascadelake-Server-v1,x-force-features=on,check=off,'
-                        'enforce=off')
-        self.vm.launch()
-        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
-                         'pc-i440fx-4.0 + Cascadelake-Server-v1 should not have arch-capabilities')
-
-    def test_v2_4_0(self):
-        self.set_machine('pc-i440fx-4.0')
-        self.vm.add_args('-S')
-        self.set_vm_arg('-cpu',
-                        'Cascadelake-Server-v2,x-force-features=on,check=off,'
-                        'enforce=off')
-        self.vm.launch()
-        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
-                        'pc-i440fx-4.0 + Cascadelake-Server-v2 should have arch-capabilities')
-
-    def test_v1_set_4_0(self):
-        self.set_machine('pc-i440fx-4.0')
-        # command line must override machine-type and versioned CPU model:
-        self.vm.add_args('-S')
-        self.set_vm_arg('-cpu',
-                        'Cascadelake-Server-v1,x-force-features=on,check=off,'
-                        'enforce=off,+arch-capabilities')
-        self.vm.launch()
-        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
-                        'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-capabilities should have arch-capabilities')
-
-    def test_v2_unset_4_1(self):
-        self.set_machine('pc-i440fx-4.1')
+    def test_v2_unset(self):
+        self.set_machine('pc')
         self.vm.add_args('-S')
         self.set_vm_arg('-cpu',
                         'Cascadelake-Server-v2,x-force-features=on,check=off,'
                         'enforce=off,-arch-capabilities')
         self.vm.launch()
         self.assertFalse(self.get_cpu_prop('arch-capabilities'),
-                         'pc-i440fx-4.1 + Cascadelake-Server-v2,-arch-capabilities should not have arch-capabilities')
+                         'pc + Cascadelake-Server-v2,-arch-capabilities should not have arch-capabilities')
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.50.0


