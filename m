Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD379606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sHKcgvtf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3L-0003LO-Cw; Fri, 23 Oct 2026 10:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3C-0003Hf-QM
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG39-0006Z2-T4
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1e477fe16so7366985e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764914; x=1793369714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1+GT1R8fLZYiFokEmWdmyzwIVWFkXuDRWCujfTsYewU=;
 b=sHKcgvtftxxlhrGk4YHO9ZDmxEKl189QPGpeAt93FQe8no847/y+uHTjSSbnDNsAhq
 1/TXr2unLKOAwN1wDdJwQ/GBX72Kdu+c4SlBo3Y9Yp5JvuBhtqGhsUuvyw8AKbMcCJNk
 HJuDlP6YvLUDT9eM8YDEMcCi80LGfhjZ2pNn9OJliK1MLC/8izus6/Lzpu3xjlEY5l9Q
 PMI3S3ynRgfsTga1s+CW3/pddtGTeZYMBVoUUkSZJutCOtU+Mud/h0fMfdg8T/6bONbB
 5m12JAcqWROnHPbSiO6lxg0twa48CzxXkdAZbHyu8U/Cj0qQ1nsd56I8Vw7bhVFIdEKz
 Kjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764914; x=1793369714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1+GT1R8fLZYiFokEmWdmyzwIVWFkXuDRWCujfTsYewU=;
 b=JP+yLJkQTVBORMi7Q6EEwzIfjUkzlVJ06nzNQUc6H51qpNvvRE8iv3eO5lngZnAi/R
 p4RnYON4ourRep0G+YKc5yvyMwb3bZ5Lx84nSdQJi1MaQNHET82cIHi+16lI+11XlPzD
 GhYu/y6p/nmEPWRN/kfu4lZqnQ29QlWvFTnuFszPZOz3j4MgL7Ycm93dtyHPDBDoJTY8
 3ie+IkRTHXE90UM9RTafG/sp4+jAxE7IczrsfXcagwrodxP8eOtoteOmsxSYNs018p5X
 4oRLwjgcNCNaj0G45Vaie51FO6jkepXg3VLdcefkqLznluk8FHvWRNfGwCmtzfR+iaZw
 ucSA==
X-Gm-Message-State: AFq9FYJNgTOIrua7yO/xpj5T19UQpWAoYTkQJyBNbImbsaMDbC0Aepsa
 A0ZpsAcdo58WLWNnAS+kU69DnziH05QmQ0wXoa3EjN7TNk0z5VnOi2n5Vt+LRX1YbjWR6IOT3jt
 FbgjjGwY=
X-Gm-Gg: AYBFou2gIV/xdbjrxpeRp8+cVin1aJxrN5wM8j8Wys3pshRH/j7WbrvWOKKuwzp/G6I
 Kcc0otXGLGDdId9UtVRrnfbT2SuttcJAtkVmcQeUc0TRG2QOpUXxVV31vqEHom1BQHH/wuwV5B2
 rjGQ+SXi0uuiK8di3nnYMi7VXkUf0A4Q5t+eqL/GYwZPhETvepNkVTWU+EoCxMURWjYyXGImYP5
 KdtqNBcECsvU/tHKP/RzIwjGwxy0AuUIY9c2OovXxETXwcHgkaWuPiVEdEV7x4ZU/KHTGaP2WD3
 DEqgO7w5p2R2lpXzUby2ymtCzPKkgZVpTGA4L0NEksUDFQN/QqEjIMACfQeolk8sb5blMTfJP1v
 zYQWWCVzmlUsxkJGuN10yGdUH0xoiuGW95HX8omoBO2s7XpAMXQzfSgmIyie4LsixJOesRqs35F
 xnt0l83y6QwztrRYfZxzC34G8EBUyoxOxXSG7z3USBHKhxoP9z05iTbvDu+QeLKHtCzRLv45itZ
 h3h4cJQsE9WHYP2LEQGmAdy34w5Vm628gJipece1YdyGTKqmH2RCFm4G9VYicOetHaQSlvJoQZK
 TUTenFCCt/ByzjiSpLhpAnaqDmDA8Jl3pa0r4E7JHXAT4EQEgGVwlvfffHMn
X-Received: by 2002:a05:600c:354c:b0:4a2:1197:1de0 with SMTP id
 5b1f17b1804b1-4a211cb23f3mr41430955e9.19.1792764914026; 
 Fri, 23 Oct 2026 07:15:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] tests/functional/aarch64: add raspi4b RNG200/thermal test
Date: Fri, 23 Oct 2026 15:14:52 +0100
Message-ID: <20261023141503.1397009-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marcelo Manzo <marcelomanzo@gmail.com>

Extend test_arm_raspi4_initrd to exercise the RNG200 and thermal
sensor devices added in this series: confirm the RNG200 driver probes
it ("hwrng registered" in the kernel log), then once at a shell
confirm the thermal zone reports the expected fixed reading and that
/dev/hwrng actually yields data rather than just existing.

These checks go into the existing initrd boot test rather than a new
test, to avoid spending test time booting the same kernel again.

Verified locally against this series with the exact kernel/initrd
assets this file already pins.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Message-id: 20261015181111.60491-6-marcelomanzo@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_raspi4.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
index bacecbbe9c7..c61014b5fa2 100755
--- a/tests/functional/aarch64/test_raspi4.py
+++ b/tests/functional/aarch64/test_raspi4.py
@@ -80,6 +80,8 @@ def test_arm_raspi4_initrd(self):
         #                '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
         #                '-device', 'usb-kbd,bus=xhci.0',
         self.vm.launch()
+        self.wait_for_console_pattern(
+            'iproc-rng200 fe104000.rng: hwrng registered')
         self.wait_for_console_pattern('Boot successful.')
 
         exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
@@ -103,6 +105,11 @@ def test_arm_raspi4_initrd(self):
                            'memory node above the 1 GiB peripheral hole '
                            'is probably not being added' % mem_total_kb)
 
+        exec_command_and_wait_for_pattern(
+            self, 'cat /sys/devices/virtual/thermal/thermal_zone0/temp',
+            '25310')
+        exec_command_and_wait_for_pattern(self, 'head -c 8 /dev/hwrng | xxd',
+                                                '00000000:')
         exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
         # TODO: Raspberry Pi4 doesn't shut down properly with recent kernels
         # Wait for VM to shut down gracefully
-- 
2.43.0


