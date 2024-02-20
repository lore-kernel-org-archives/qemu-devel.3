Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8DDC54787
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsK-0008JJ-4Z; Tue, 20 Feb 2024 03:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsG-0008GH-St
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:14 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsE-000892-FR
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:12 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a3ddc13bbb3so698407866b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419189; x=1709023989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KqgvfmG+DXSd3FVh56Y/uB3s8jURKVxULGjKdZhCvn0=;
 b=YdVNoMPdU2xFOrWFNw8iE1p/AGT9O1tKU4fCan13E369Kq6dI86SBib/z2SlJP8Eiz
 J3DBx/rydSPVjUCVvFsSFLX8tiOcH1ZArq92ox1bXfFhBqfxunwlkHmnDljDkzZCGJDb
 cBs3wVkih+vkN/1nojKk9DUoEgnPpZNSQJAw/dPFQmyWuzgBdar0zVHLREP5K1PngD2x
 aU/GDSO0Im8MFA2UHTzWYGcca6zh0Bma2kwYPMfkUPFWmjCGEGKssJqs8hopvEKSrlIU
 bU2rNod4BWpIaWnm2jCRzcDHi5qOriOSZrXxYaO/zj3cZTN04/00hyZVfz5Q9yWg88Ne
 lowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419189; x=1709023989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KqgvfmG+DXSd3FVh56Y/uB3s8jURKVxULGjKdZhCvn0=;
 b=Y8tyeJ2joeY4pGS7Ez3pVzevRLtQD2M1N88yLjXOLrNJZX11Qa40T6/jZjxgcELTSc
 u/+qjMy77LhrAbk4Bagjg10vcu6fk3pAeB2XeUSbzaseYpDmh+eYAfpGjGHB3Okc7x+c
 85rMgXePkBS5lCNln6K8O95yOTTxiLKiLyvuZ6nb3EmxhcrxyYfK5kLKx9ovgj9NMbV+
 ZKAoe98JKATAfqes43N1r8pqwhkua/hx+C/oYheKNV/JGYO4gM2Z5Ky5YINjO3vB+DnD
 IoQUbfHO9lo2dfd72XrDK3swQVatQe/v0RRX8a00Roo3l1AKTIVAkN6GHRx4NKmrTI+l
 w2wQ==
X-Gm-Message-State: AOJu0YzL4/ttOVc7y4JrGXvEUdcySHgpNsmzVXQTA3NXD0aHXx4Z+x1y
 NsomJdn6GNe2UTGN3UVFftNUP3Rtauz29p6bnltpPR/Nvz9pLID1LFchjnljS7s=
X-Google-Smtp-Source: AGHT+IF9qtfeZbYHH+CSYQX9qugSRfjCx+hXAzdUovz7bS2uY2+gVwp4FBph/DeVGm5bWrIVJLmUeg==
X-Received: by 2002:a17:906:aac5:b0:a3e:cb4a:6e71 with SMTP id
 kt5-20020a170906aac500b00a3ecb4a6e71mr3271990ejb.18.1708419188729; 
 Tue, 20 Feb 2024 00:53:08 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:08 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 02/21] tests: correct typos
Date: Tue, 20 Feb 2024 10:52:09 +0200
Message-Id: <723e7a4b522cebce583e924fbd965f110cbc2af4.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 tests/avocado/acpi-bits/bits-tests/smbios.py2 | 2 +-
 tests/avocado/mem-addr-space-check.py         | 6 +++---
 tests/avocado/reverse_debugging.py            | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/avocado/acpi-bits/bits-tests/smbios.py2 b/tests/avocado/acpi-bits/bits-tests/smbios.py2
index fc623de072..5868a7137a 100644
--- a/tests/avocado/acpi-bits/bits-tests/smbios.py2
+++ b/tests/avocado/acpi-bits/bits-tests/smbios.py2
@@ -1060,7 +1060,7 @@ class EventLogDescriptor(unpack.Struct):
             0x16: 'Log Area Reset/Cleared',
             0x17: 'System boot',
             xrange(0x18, 0x7F): 'Unused, available for assignment',
-            xrange(0x80, 0xFE): 'Availalbe for system- and OEM-specific assignments',
+            xrange(0x80, 0xFE): 'Available for system- and OEM-specific assignments',
             0xFF: 'End of log'
         }
         yield 'log_type', u.unpack_one('B'), unpack.format_table("{}", _event_log_type_descriptors)
diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-addr-space-check.py
index 363c3f12a6..af019969c0 100644
--- a/tests/avocado/mem-addr-space-check.py
+++ b/tests/avocado/mem-addr-space-check.py
@@ -165,7 +165,7 @@ def test_phybits_low_tcg_q35_70_amd(self):
         For q35-7.0 machines, "above 4G" memory starts are 4G.
         pci64_hole size is 32 GiB. Since TCG_PHYS_ADDR_BITS is defined to
         be 40, TCG emulated CPUs have maximum of 1 TiB (1024 GiB) of
-        directly addressible memory.
+        directly addressable memory.
         Hence, maxmem value at most can be
         1024 GiB - 4 GiB - 1 GiB per slot for alignment - 32 GiB + 0.5 GiB
         which is equal to 987.5 GiB. Setting the value to 988 GiB should
@@ -190,7 +190,7 @@ def test_phybits_low_tcg_q35_71_amd(self):
         AMD_HT_START is defined to be at 1012 GiB. So for q35 machines
         version > 7.0 and AMD cpus, instead of 1024 GiB limit for 40 bit
         processor address space, it has to be 1012 GiB , that is 12 GiB
-        less than the case above in order to accomodate HT hole.
+        less than the case above in order to accommodate HT hole.
         Make sure QEMU fails when maxmem size is 976 GiB (12 GiB less
         than 988 GiB).
         """
@@ -297,7 +297,7 @@ def test_phybits_ok_tcg_q35_71_amd_41bits(self):
         :avocado: tags=arch:x86_64
 
         AMD processor with 41 bits. Max cpu hw address = 2 TiB.
-        Same as above but by setting maxram beween 976 GiB and 992 Gib,
+        Same as above but by setting maxram between 976 GiB and 992 Gib,
         QEMU should start fine.
         """
         self.vm.add_args('-S', '-cpu', 'EPYC-v4,phys-bits=41',
diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 4cce5a5598..92855a02a5 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -191,7 +191,7 @@ def reverse_debugging(self, shift=7, args=None):
         self.check_pc(g, steps[-1])
         logger.info('successfully reached %x' % steps[-1])
 
-        logger.info('exitting gdb and qemu')
+        logger.info('exiting gdb and qemu')
         vm.shutdown()
 
 class ReverseDebugging_X86_64(ReverseDebugging):
-- 
γαῖα πυρί μιχθήτω


