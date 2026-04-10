Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A92F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHwn-0002xp-T4; Fri, 10 Apr 2026 15:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwl-0002kp-Bx
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHwi-00027T-7R
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:55:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso23616715e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850914; x=1776455714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HAEsPfskfREToikV46U/wzGFh7dU/0uRJHIvrZhc2k=;
 b=r0bVxLJ1D0yokeu8pO4DRnbsVu6Y61xTQbb0rAc1LReFEH1BwRx/HrF+JgB868QIqq
 TE4lda9jJl3KqVKFtK4vACPA2FNv/vGrgOVm9ZKB2HSOZzV/k+G96NH930aB6K1ylhGs
 nwfJJZDXhg4/zMgFABfKF1B9TS0g6FEwaEIr9wI5d6w+FwXnK3S2OLB6eEb5i3QA6rpi
 WpXfvOld3zVrQbrOFH6+illDvIIQ2T7pNiXny5+hzbLARde0lPOCc4tkyzrTq4EN0L/U
 98eXUqV22FF1XSt0B1yQxtArSb92nHNS+8ByBiuoIjwyJmOYzHwEA7ltPSFQBMMzP7Jo
 3YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850914; x=1776455714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6HAEsPfskfREToikV46U/wzGFh7dU/0uRJHIvrZhc2k=;
 b=mrvXiWOrfXpP12j8bKhKh0+eIWvTCcaU5W4vIE7tMUdf1dVO8iLT+xPeNflWh99qb1
 sr+Nrf646g0jM7pauY3EuwsaZ9FVkznA8FJRX84k80DM7/ZmVYK3OQXHtExrn5a+vxXN
 Q+eClDtcRLJmX90xVZhawP9os5ekiNr4yxP0msILR0uXHvlVN+4v9bTMkpTYU6z9UDxk
 oqqJxVaZIWXLolJKfONLnwSwJEfOhiUPEuK9ShYmTRMuo25izE3s4dPse6WLjceLa/dj
 0nw4tCZrXlSxEcdw1UU5D9xLTOSSEvuArTCp14VgIaFqzp+UhGBVNnt6cMtPf8/EpV5U
 V3tg==
X-Gm-Message-State: AOJu0YxQmUbIMixe57PgmOson4iQjWkNZH5VcynyFKpHnDQIfVPupIyp
 Hr3d/LYmNccKu8yLRc0d1okat7lho3/R8wmNft+Wohh71SDD/DZdqRIdVHQ4o3xw5c+ZA01ulNY
 ay+szJNQ=
X-Gm-Gg: AeBDiet3k/bZ1YRbR0Gve/tc8pzvC0v3K10yVCK+G6ChSrqbGfGB+cAWumV4HzhQh+1
 INeGz89m0fhE2T5jeSV7gNW2ZGpXY9T4cjdzr7cmlXc0alRpR3rLYqbC2fndAv8zBGUGBpqWOcL
 uAriXg7j47M0O594mJ/frv/7f7N4R/YD6pMUGHcMNK+A88pFIMY1p7BXUgzRtJfR9InPx2UGCAM
 QPkcBE40uF34m+XxzNWSZ7lGcYYf4BoBZsYHiTYl9rj34y0LRjaZczMaZqdDLd7tWZy+34wMmoY
 qzeIRUMM8XztPWhQrFPe94mXs9wTyVHYSYHplCDFap3RHaCzlYt9voOimzdjOgeWftLBKomKHGd
 8jqh7KYnP6vNsfR6HuYoqVVC2u8UeHFkmcsxKxLDHZJ8AdBMmhPdJRQRGYfNaJuay85IRaCapK9
 vUx1sjhflQG3bL5j3wrw0KLYtLM/KGip+Sk99DtrOVj5XoVjwL/evTHh1PqsxKNw1dvy4EJTko
X-Received: by 2002:a05:600c:5397:b0:488:b8bc:6a32 with SMTP id
 5b1f17b1804b1-488d68a4765mr64730165e9.23.1775850913981; 
 Fri, 10 Apr 2026 12:55:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5d80bafsm29702685e9.5.2026.04.10.12.55.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:55:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 15/27] stubs: Rename monitor* -> qmp* files
Date: Fri, 10 Apr 2026 21:53:09 +0200
Message-ID: <20260410195323.17937-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

We use 'HMP' for Human monitor and 'QMP' for 'Machine protocol'.
These files aren't about human monitor but QMP, so rename them
for clarity using the 'qmp-' prefix instead of 'monitor-'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                      |  6 ++++++
 stubs/{monitor-arm-gic.c => qmp-arm-gic.c}       |  0
 ...nitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} |  0
 stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c}   |  0
 stubs/{monitor-cpu.c => qmp-cpu.c}               |  0
 stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c}     |  0
 stubs/{monitor-i386-sev.c => qmp-i386-sev.c}     |  0
 stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c}     |  0
 stubs/{monitor-i386-xen.c => qmp-i386-xen.c}     |  0
 stubs/meson.build                                | 16 ++++++++--------
 10 files changed, 14 insertions(+), 8 deletions(-)
 rename stubs/{monitor-arm-gic.c => qmp-arm-gic.c} (100%)
 rename stubs/{monitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} (100%)
 rename stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c} (100%)
 rename stubs/{monitor-cpu.c => qmp-cpu.c} (100%)
 rename stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c} (100%)
 rename stubs/{monitor-i386-sev.c => qmp-i386-sev.c} (100%)
 rename stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c} (100%)
 rename stubs/{monitor-i386-xen.c => qmp-i386-xen.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index edbbd544d62..932d6aee507 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -121,6 +121,7 @@ F: include/hw/s390x/
 F: include/hw/watchdog/wdt_diag288.h
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
+F: stubs/qmp-cpu-s390x.c
 F: target/s390x/
 F: docs/system/target-s390x.rst
 F: docs/system/s390x/
@@ -496,6 +497,7 @@ M: Christian Borntraeger <borntraeger@linux.ibm.com>
 R: Eric Farman <farman@linux.ibm.com>
 R: Matthew Rosato <mjrosato@linux.ibm.com>
 S: Supported
+F: stubs/qmp-cpu-s390x-kvm.c
 F: target/s390x/kvm/
 F: target/s390x/machine.c
 F: target/s390x/sigp.c
@@ -510,6 +512,8 @@ L: kvm@vger.kernel.org
 S: Supported
 F: docs/system/i386/amd-memory-encryption.rst
 F: docs/system/i386/sgx.rst
+F: stubs/qmp-i386-sev.c
+F: stubs/qmp-i386-sgx.c
 F: target/i386/kvm/
 F: target/i386/sev*
 F: scripts/kvm/vmxcap
@@ -522,6 +526,7 @@ S: Supported
 F: include/system/kvm_xen.h
 F: target/i386/kvm/xen*
 F: hw/i386/kvm/xen*
+F: stubs/qmp-i386-xen.c
 F: tests/functional/x86_64/test_kvm_xen.py
 
 Guest CPU Cores (other accelerators)
@@ -800,6 +805,7 @@ F: include/hw/timer/a9gtimer.h
 F: include/hw/timer/arm_mptimer.h
 F: include/hw/timer/armv7m_systick.h
 F: include/hw/misc/armv7m_ras.h
+F: stubs/qmp-arm-gic.c
 F: tests/qtest/test-arm-mptimer.c
 
 Bananapi M2U
diff --git a/stubs/monitor-arm-gic.c b/stubs/qmp-arm-gic.c
similarity index 100%
rename from stubs/monitor-arm-gic.c
rename to stubs/qmp-arm-gic.c
diff --git a/stubs/monitor-cpu-s390x-kvm.c b/stubs/qmp-cpu-s390x-kvm.c
similarity index 100%
rename from stubs/monitor-cpu-s390x-kvm.c
rename to stubs/qmp-cpu-s390x-kvm.c
diff --git a/stubs/monitor-cpu-s390x.c b/stubs/qmp-cpu-s390x.c
similarity index 100%
rename from stubs/monitor-cpu-s390x.c
rename to stubs/qmp-cpu-s390x.c
diff --git a/stubs/monitor-cpu.c b/stubs/qmp-cpu.c
similarity index 100%
rename from stubs/monitor-cpu.c
rename to stubs/qmp-cpu.c
diff --git a/stubs/monitor-i386-rtc.c b/stubs/qmp-i386-rtc.c
similarity index 100%
rename from stubs/monitor-i386-rtc.c
rename to stubs/qmp-i386-rtc.c
diff --git a/stubs/monitor-i386-sev.c b/stubs/qmp-i386-sev.c
similarity index 100%
rename from stubs/monitor-i386-sev.c
rename to stubs/qmp-i386-sev.c
diff --git a/stubs/monitor-i386-sgx.c b/stubs/qmp-i386-sgx.c
similarity index 100%
rename from stubs/monitor-i386-sgx.c
rename to stubs/qmp-i386-sgx.c
diff --git a/stubs/monitor-i386-xen.c b/stubs/qmp-i386-xen.c
similarity index 100%
rename from stubs/monitor-i386-xen.c
rename to stubs/qmp-i386-xen.c
diff --git a/stubs/meson.build b/stubs/meson.build
index 85f9e3a4f23..356d7800760 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -76,14 +76,14 @@ if have_system
   stub_ss.add(files('kvm.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
-  stub_ss.add(files('monitor-arm-gic.c'))
-  stub_ss.add(files('monitor-i386-rtc.c'))
-  stub_ss.add(files('monitor-i386-sev.c'))
-  stub_ss.add(files('monitor-i386-sgx.c'))
-  stub_ss.add(files('monitor-i386-xen.c'))
-  stub_ss.add(files('monitor-cpu.c'))
-  stub_ss.add(files('monitor-cpu-s390x.c'))
-  stub_ss.add(files('monitor-cpu-s390x-kvm.c'))
+  stub_ss.add(files('qmp-arm-gic.c'))
+  stub_ss.add(files('qmp-i386-rtc.c'))
+  stub_ss.add(files('qmp-i386-sev.c'))
+  stub_ss.add(files('qmp-i386-sgx.c'))
+  stub_ss.add(files('qmp-i386-xen.c'))
+  stub_ss.add(files('qmp-cpu.c'))
+  stub_ss.add(files('qmp-cpu-s390x.c'))
+  stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
 endif
 
 if have_system or have_user
-- 
2.53.0


