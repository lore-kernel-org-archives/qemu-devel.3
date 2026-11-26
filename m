Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8219606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G/m8JZ5x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWS1v-0004GU-Bw; Thu, 26 Nov 2026 00:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWS1e-0004EB-U8
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 00:28:07 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWS1d-0001nJ-9q
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 00:28:06 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so42181825e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 21:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795670882; x=1796275682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wH5k6QNkmArm5XncmyqLpKEC7bkf9J2bWJ1i2xZA5VE=;
 b=G/m8JZ5x9teu877VNI2x72bWyXJyznunXLGTAVG2CtTENrf88e5p/7dAFxxxZpSU80
 gWgzNLYFo+Y1+3ojR+iUZ/8Y/nYjeEkn6xEPdvUnJmlerpEUsLsj2NecMJfxvaR6Xst9
 dqeYQPViYvffQmEDyYqs4bxINxu5W9/beui8wKM49P92pfLApyaxDAg5/PMI9M3riMAS
 rlQG9nym8hqf78HdMkHdaX0zcOgh4xfUKJCZZ457/QACq6xJDsGRfmAOZdCMUfMW9fqz
 6TDWMcfiHy/jB85ZafG/1Vqo3FoOXb0wzqb543JD2CLo1NrEYvtmGBA6LqS2lVtNy0DU
 d0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795670882; x=1796275682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wH5k6QNkmArm5XncmyqLpKEC7bkf9J2bWJ1i2xZA5VE=;
 b=rG9uJ2DJlTejvh6sHwlSSRt0QY+EhlnoyfsIIIMwHCy48aSGtdqpn43fMk/mxt1qRK
 QD9eRZasFMdBGCBJ7Nda4mF45pyA/94JoA31Tuy2RpIIGsVK8W1vdH8oELfqkri3sIos
 qDRSnf9PjzoaLhKAREP7SpwFx9r2cA8vQeWygBD3yBPw4F3wPM4HJR/bFJnPcCapa6KS
 GjEXzqemXFYTeX3oZXFw+nj+4oTb6zCOgX3aHP0bAJ71bCAuBmNVGCy6nN0SYwKhGO+h
 k/WGEPvX3QvV83MB9veSNwDJNjtubtp9e4SF1+9dcxQVso9CZ2NjlX5/T+6q7p3C9kox
 m2sA==
X-Forwarded-Encrypted: i=1;
 AL+hErERFSlPXPezvr9L+g/6YUe5w/N+stoptb0+x2NIBMzz2QNhWedB2JBG05dUSkwLUI3YLV/dLk3f5tVM@nongnu.org
X-Gm-Message-State: APuU4Z9Y789qpbKXM3OKx3QqhkJV7ZeYsuBprI4WNFabQdUqbz+lUAyY
 0wlKwlDGQqJzvZGtt3qbeFEFzRiIdGavYmOgM7dFHsN0raiO72nKisVH
X-Gm-Gg: AZFdTZfKMWLoaHsG4r1Z08qMtTiYwII9VCJKh9M0tFhw02u7H+3fvVIxmbn/SAvbmEn
 7YowpUqPX8mV9rKuxTdS3hndoZYKk3blKIPG+WNjaX6IrxfC5a3bsSOt/B1K21OYUS4LEnU4wFE
 rUdxieV0Cu9vi/QVKIO2R684hovqXbhHn6PG+D218+3liXwVq52gxFtx+GPJUru/v4iCnI3831x
 VPMNLMLM4d17+E4utG+dvRU4kTgDULGPqLUg6KMMvJoTciCmiv3yv7P11x6tLrVtnx2MoBYISWl
 k11gD5LEMHBcIVjHuHeiricxc5n3Wim+Ordbxu6xa/fXceGM+oQ+sAJMhZpow4Ef0K3KJbK3zqJ
 Nv1L1l6E/DJaAEs0PZpdP+4LhcEgaIqbZg/G3K/ejURDILnZ17zOI0JbMvouaxK3YU3FtPvixVh
 ix/CYDCaDTRf4g33Tq4CiRBK/RNNsOZ9GznNImNH6xJheLlHdFcYmZDd+TEoOjUC0KO2hIg2Pw4
 f6GRwcLLzJrBBpTYBptPxQC9+O5MKcqoL2mdYMrYKol6vgUC7YFAidB1Tu7YfzK8mj95Wmw8up9
 zc5rXE2Cy9hj05aG0/zbuqAOzXBUBfYgARNB2SC0/6bVzMMbK9yL6nk4+Xbk+ymIVXmgyjb0wP4
 5my4km2FebPF3zGzLsD0w0ZHORXgNjjdWE1JXtzkRq36CqA==
X-Received: by 2002:a05:600c:1d29:b0:4a9:2a92:231f with SMTP id
 5b1f17b1804b1-4bb88804d4dmr428985945e9.7.1795670881703; 
 Wed, 25 Nov 2026 21:28:01 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm808310475e9.13.2026.11.25.21.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 21:28:01 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Eric Auger <eric.auger@redhat.com>,
 Khushit Shah <khushit.shah@nutanix.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [RFC PATCH v3 3/3] tests/functional: Add a KVM selftest for an
 nVHE-only EL2
Date: Thu, 26 Nov 2026 10:27:41 +0500
Message-ID: <20261126052741.90607-4-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126052741.90607-1-haseebashraf091@gmail.com>
References: <20261121204601.741616-1-haseebashraf091@gmail.com>
 <20261126052741.90607-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Run the existing kvm-unit-tests smoke test with VHE hidden from the
guest hypervisor through SYSREG_ID_AA64MMFR1_EL1_VH=0.  The SYSREG_*
properties are available only for the host CPU model with KVM, so
select the accelerator and CPU model explicitly, and check that the
guest kernel initialized its hypervisor in nVHE mode.  The test is
skipped when the host kernel cannot limit EL2 to nVHE.

Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---

v3:
 - No changes from v2.

 tests/functional/aarch64/test_kvm.py | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
index c977e8c6d2..b7a4aceb66 100755
--- a/tests/functional/aarch64/test_kvm.py
+++ b/tests/functional/aarch64/test_kvm.py
@@ -30,7 +30,7 @@ class Aarch64VirtKVMTests(LinuxKernelTest):
     # base of tests
     KUT_BASE = "/usr/share/kvm-unit-tests/"
 
-    def _launch_guest(self, kvm_mode="nvhe"):
+    def _launch_guest(self, kvm_mode="nvhe", cpu="max", accel=None):
 
         self.set_machine('virt')
         kernel_path = self.ASSET_KVM_TEST_KERNEL.fetch()
@@ -39,7 +39,9 @@ def _launch_guest(self, kvm_mode="nvhe"):
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                f"console=ttyAMA0 kvm-arm.mode={kvm_mode}")
 
-        self.vm.add_args("-cpu", "max")
+        if accel:
+            self.vm.add_args("-accel", accel)
+        self.vm.add_args("-cpu", cpu)
         self.vm.add_args("-machine", "virt,gic-version=3,virtualization=on",
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
@@ -50,6 +52,9 @@ def _launch_guest(self, kvm_mode="nvhe"):
         except VMLaunchFailure as excp:
             if "does not support providing Virtualization" in excp.output:
                 self.skipTest("accelerator has no virtualization support")
+            elif ("SYSREG_ID_AA64MMFR1_EL1_VH" in excp.output and
+                  "not found" in excp.output):
+                self.skipTest("host KVM cannot limit EL2 to nVHE")
             else:
                 self.log.info("unhandled launch failure: %s", excp.output)
                 raise excp
@@ -73,5 +78,18 @@ def test_aarch64_vhe_selftest(self):
         self._launch_guest("vhe")
         self._smoketest_kvm()
 
+    def test_aarch64_nvhe_only_selftest(self):
+        # Hiding VHE from the guest hypervisor is a KVM feature: the
+        # SYSREG_* properties only exist for the host CPU model with KVM.
+        self.require_accelerator("kvm")
+        self._launch_guest("nvhe", "host,SYSREG_ID_AA64MMFR1_EL1_VH=0",
+                           accel="kvm")
+        # The guest kernel must run its hypervisor in nVHE mode
+        ec_and_wait(self, "dmesg | grep -Eq "
+                    "'Hyp (nVHE )?mode initialized successfully' && "
+                    "! dmesg | grep -q ' VHE mode initialized'",
+                    self.OK_CMD)
+        self._smoketest_kvm()
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.34.1


