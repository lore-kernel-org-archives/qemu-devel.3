Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00268D148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibo-0005It-Lv; Thu, 08 Jan 2026 00:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibh-0005BW-WF
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:51 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibc-0005K4-5V
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:46 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-bbf2c3eccc9so631821a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850240; x=1768455040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jBZFhd3mroDQaEMxtTd2Hevbbgwe0OuSzrCp3aQ80K8=;
 b=wVaLGGSKXQlJOR5n2sAODIDoBeC1Xik3gbvZojqkFaFuQbtqbXK/E6w2n9FHH4nJtm
 HF7mFhcDx93UYHXlB0lyP8OBjSCCRSqiiQ3iLncU8y1cYbwVujFFWzDUs4hjMsLWZp/I
 KReP26SAcD9O2vtKf2evZq71765ClXi7pHIiRSXAfL7Ec0oimQERb72pYRcg1/bumd2C
 ebXuyLY2AlFTONWYrT5PWylIelxfX7c31eQCS+wGq6ufUIeF61kPt4Jm8u5LAwSW2HCS
 RwJqJmXK8GdsmTXEeSIUzqrpZdOExuRhUmguLPP4L2Mj/30idENfQaz6J0UCjyGFzS5y
 2Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850240; x=1768455040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jBZFhd3mroDQaEMxtTd2Hevbbgwe0OuSzrCp3aQ80K8=;
 b=N8REuydYoRLBTVfLW46wgFV2RhMfKrgt5yrdByVoqVOsyYfnOb21IyBeey7pycEonE
 4VQp+NNZ+9FkxCvZP8I+8ItgdigXsDSmhfsyLOCSYS7qJ1fMQYceidNsUaFn8H8+DPfe
 R9NdGjipjfWPmHhqQSEQk8Izt/0GCQqtNoIoCCsWNCiNOW07F3I5ipm6OhZAzdjj2+HT
 NNY8tGJA441oJisvNo+PpTVv0vu8E9AjKL98ASNBMJqxuVs5p/vSaQKUAuV9JnXAmGao
 KOE4o1iGoZepuMWvmDgncqzFsgoB1FOZdGC0pGsbo1qHN+SE2PrNYBRsIyO+OwqrJYQm
 KLjA==
X-Gm-Message-State: AOJu0Yw3UW20SU+U7/uY6/u3bCKOw0NLIsPd2D/l0eI+uBQDm+uzEmAy
 qJZaqOhOAOpJmEkv6yu8FQsyWDT5hMnZIzAuxbrCcLRCPAQXFa45IOKSyShun7YaCqsFMAVWtAj
 0UnV4kQw=
X-Gm-Gg: AY/fxX4wDcp0GhlgrLmRFd6lo0r/ZH8PXhh9JpWVFk5/hGdD9cqmdb7UT9l5IlcYi9i
 v2xG2sRKORE6j9asF2XaZtcqQlKaeBNff/YWbpsh5Xb0DScB27msXAocXeWBXAdHwwVg9/Cmqt8
 iNoo72+zHjnFwBcy29ezhMA868aT4dLGCGOisd4czH3A6c0Q0NQSmxfCViJICYUUBlImdXEvFxA
 Qfi2SpaFZQpz7CsuRab58s55ZISpVIFO0Cd1Vg+a1o1a/Uuh+BV+kSu73Pg2BdDEpuGPdJ41Ozo
 0tnmcfOn/AATn0tqrsYmKt6UrzLmW9/wIkTWjEmPLVtwuwrixCcAO4g9CCVAan9qHGdvqz4WzvU
 PNJMIj1p0U6Zk87wbkmwBw5YYIHyfb750LB0A40DP1+uCbCvFV3ZTNmDHWNBr5ZX8kGyup/MDvH
 bzN4WguIVvLEhJryAfyA==
X-Google-Smtp-Source: AGHT+IEeezcXoEWbPvSkpSCDmB56mdGryQAIhjARM/AMF387OFnv6UoGen9VXKf4w5THjzlCw49K0A==
X-Received: by 2002:a05:6a20:c702:b0:366:14b0:4afb with SMTP id
 adf61e73a8af0-38982b715acmr7878954637.34.1767850240117; 
 Wed, 07 Jan 2026 21:30:40 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/50] meson: Remove cpu == x86 tests
Date: Thu,  8 Jan 2026 16:29:36 +1100
Message-ID: <20260108053018.626690-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

The 32-bit x86 host is no longer supported.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure   | 16 +---------------
 meson.build | 49 ++++++++++---------------------------------------
 2 files changed, 11 insertions(+), 54 deletions(-)

diff --git a/configure b/configure
index 00e455be57..846fab904e 100755
--- a/configure
+++ b/configure
@@ -440,13 +440,6 @@ case "$cpu" in
     linux_arch=arm64
     ;;
 
-  i386|i486|i586|i686)
-    cpu="i386"
-    host_arch=i386
-    linux_arch=x86
-    CPU_CFLAGS="-m32"
-    ;;
-
   loongarch*)
     cpu=loongarch64
     host_arch=loongarch64
@@ -1933,14 +1926,7 @@ if test "$skip_meson" = no; then
   if test "$cross_compile" = "yes"; then
     echo "[host_machine]" >> $cross
     echo "system = '$host_os'" >> $cross
-    case "$cpu" in
-        i386)
-            echo "cpu_family = 'x86'" >> $cross
-            ;;
-        *)
-            echo "cpu_family = '$cpu'" >> $cross
-            ;;
-    esac
+    echo "cpu_family = '$cpu'" >> $cross
     echo "cpu = '$cpu'" >> $cross
     if test "$bigendian" = "yes" ; then
         echo "endian = 'big'" >> $cross
diff --git a/meson.build b/meson.build
index e53bc1e643..e5bdcf651d 100644
--- a/meson.build
+++ b/meson.build
@@ -50,7 +50,7 @@ qapi_trace_events = []
 
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
-supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
+supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86_64',
   'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32']
 
 cpu = host_machine.cpu_family()
@@ -265,8 +265,6 @@ enable_modules = get_option('modules') \
 
 if cpu not in supported_cpus
   host_arch = 'unknown'
-elif cpu == 'x86'
-  host_arch = 'i386'
 elif cpu == 'mips64'
   host_arch = 'mips'
 elif cpu in ['riscv32', 'riscv64']
@@ -275,9 +273,7 @@ else
   host_arch = cpu
 endif
 
-if cpu == 'x86'
-  kvm_targets = ['i386-softmmu']
-elif cpu == 'x86_64'
+if cpu == 'x86_64'
   kvm_targets = ['i386-softmmu', 'x86_64-softmmu']
 elif cpu == 'aarch64'
   kvm_targets = ['aarch64-softmmu']
@@ -300,9 +296,7 @@ else
 endif
 accelerator_targets = { 'CONFIG_KVM': kvm_targets }
 
-if cpu == 'x86'
-  xen_targets = ['i386-softmmu']
-elif cpu == 'x86_64'
+if cpu == 'x86_64'
   xen_targets = ['i386-softmmu', 'x86_64-softmmu']
 elif cpu == 'aarch64'
   # i386 emulator provides xenpv machine type for multiple architectures
@@ -391,40 +385,17 @@ endif
 
 qemu_isa_flags = []
 
-# __sync_fetch_and_and requires at least -march=i486. Many toolchains
-# use i686 as default anyway, but for those that don't, an explicit
-# specification is necessary
-if host_arch == 'i386' and not cc.links('''
-  static int sfaa(int *ptr)
-  {
-    return __sync_fetch_and_and(ptr, 0);
-  }
-
-  int main(void)
-  {
-    int val = 42;
-    val = __sync_val_compare_and_swap(&val, 0, 1);
-    sfaa(&val);
-    return val;
-  }''')
-  qemu_isa_flags += ['-march=i486']
-endif
-
 # Pick x86-64 baseline version
-if host_arch in ['i386', 'x86_64']
-  if get_option('x86_version') == '0' and host_arch == 'x86_64'
+if host_arch == 'x86_64'
+  if get_option('x86_version') == '0'
     error('x86_64-v1 required for x86-64 hosts')
   endif
 
   # add flags for individual instruction set extensions
   if get_option('x86_version') >= '1'
-    if host_arch == 'i386'
-      qemu_common_flags = ['-mfpmath=sse'] + qemu_common_flags
-    else
-      # present on basically all processors but technically not part of
-      # x86-64-v1, so only include -mneeded for x86-64 version 2 and above
-      qemu_isa_flags += ['-mcx16']
-    endif
+    # present on basically all processors but technically not part of
+    # x86-64-v1, so only include -mneeded for x86-64 version 2 and above
+    qemu_isa_flags += ['-mcx16']
   endif
   if get_option('x86_version') >= '2'
     qemu_isa_flags += ['-mpopcnt']
@@ -1031,7 +1002,7 @@ have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
            error_message: 'Xen PCI passthrough requested but Xen not enabled') \
   .require(host_os == 'linux',
            error_message: 'Xen PCI passthrough not available on this platform') \
-  .require(cpu == 'x86'  or cpu == 'x86_64',
+  .require(cpu == 'x86_64',
            error_message: 'Xen PCI passthrough not available on this platform') \
   .allowed()
 
@@ -4553,7 +4524,7 @@ if have_tools
                               libcap_ng, mpathpersist],
                install: true)
 
-    if cpu in ['x86', 'x86_64']
+    if cpu == 'x86_64'
       executable('qemu-vmsr-helper', files('tools/i386/qemu-vmsr-helper.c'),
                dependencies: [authz, crypto, io, qom, qemuutil,
                               libcap_ng, mpathpersist],
-- 
2.43.0


