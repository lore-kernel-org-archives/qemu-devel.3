Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C53AC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 08:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta9se-0002eV-Np; Tue, 21 Jan 2025 03:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta9sc-0002eH-QG
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:45:02 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta9sb-0004Lk-19
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:45:02 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so3346599f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737449099; x=1738053899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQw8hecSqNH6i5kzCWTZhqTCpjqpw+LPVTLqVJJZAzs=;
 b=nodf7CKF5t08ZFBn5CHUU+tr051Wkofn/KU3ypQ7FBWtmIkYD5lKVWBGdLl0PMIgAj
 jonnQBOL7bKJg5NkWWG8LZF5+ewMWu3tedZu6g78k4l9NfTEZXHR7T8wGw+48Js1Oj3k
 LM1ZCz4A51acGGugPnqwR9BcmVMhSmPWAL+cyCK10eLknR5Ogs+NpeiCT2zcH02+tJRX
 mTdg4vz4wuL9ifF98Qv0ISIPBzwV0Rn23Bc9hPzM8NvThjUPh3TO+vSvKxOXZQGNBo0L
 ebsei9gTvCYmcA86m483DolmZUBgk7X+dRqFEHYpaFZ5G1tjBxHstnbAsS81+WGfIB15
 I+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737449099; x=1738053899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQw8hecSqNH6i5kzCWTZhqTCpjqpw+LPVTLqVJJZAzs=;
 b=sst5/Ei41Bdsi9TuvmMKMK90zEgQfPlU2AlKnk1nMFxFbaiuQakaAt+EAXmUQfmGLo
 stmqvu0W2iEhmuiI6YG5zPCke8ChlbZGUwaRT1nP7u334B6Jtu6dRcMrwLgtQqD0du+9
 ray9ZGRzkoFmXY8AQpxUM6c4IHxfuHx4HTKGrbvgLaACX8E5wSoLFrFa5wp66BIa5zzZ
 JX5fxwqiSMkTPuxhXb9c7B5R9s5IJElOzGPoPDKr3/ROTb/BmWDnmdhGSyCFEP5r4//X
 xX30OGjVxdCu/QiO3mOhj5DjWOqaCIbAVz59UO7DOB4h1OU54HXRRVefkTcaD8hjBtsp
 rmGQ==
X-Gm-Message-State: AOJu0YxZLS0uUqwgPB7rPaNyqbOreWhD9jI6+3uD+hFnNY+IPelcGZW0
 ebVfLwyKiq+fMuFT2ZXbdGaquZOhB/2NqJjb4VHs0DDldmZDE1Ik3IYhenWOMyClJYwR4mQzyXz
 HGhg=
X-Gm-Gg: ASbGncsSJs8kM0DN+BtaVNSa546NemtAwC8SlAZlvVJNX3ftrfH/Pl75pe6w84Z51bg
 PTkqCu+kJ0++eHNqH82BBIDtQ28eIIwPwdu9jl4bLiTaOqnNIJ3MG823f8DZz1lnlBumsBnJVnl
 7MnXK6idBc4aDsxlpMSPhE25Wr01l5J7HYbkkZ51JGHYCWqXfjM0V7/zi7tHT/iP63mur6zhAHL
 pf+2+MT0O7yAHQbr/9duK8fD9JyQfUHDvZRagthQSQ1K5kczt2CWTLhJpPshPIH5052zSPvQ090
 MaLMK3nXqMg01nu38uBcZDLJXZHjkWbfTrxVzStolI7k
X-Google-Smtp-Source: AGHT+IGaFZswu2kRxQ7vKo3249nyITc9nwEYmMgX9Zu2YuHwBuG1eLLld8I0FL7E4WkB4vcqSnPm5w==
X-Received: by 2002:a5d:47c9:0:b0:386:416b:9c69 with SMTP id
 ffacd0b85a97d-38bf5662912mr15444351f8f.16.1737449098950; 
 Tue, 21 Jan 2025 00:44:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac5f9sm225589985e9.11.2025.01.21.00.44.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 00:44:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] hw/ipack: Clarify KConfig symbols
Date: Tue, 21 Jan 2025 09:44:51 +0100
Message-ID: <20250121084452.81941-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121084452.81941-1-philmd@linaro.org>
References: <20250121084452.81941-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Split IPACK Kconfig key as {IPACK, TPCI200, IP_OCTAL_232}

  - IPack is a bus
  - TPCI200 is a PCI device providing an IPack bus
  - IP-Octal232 is an IPack device plugged on an IPack bus

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/Kconfig                | 5 +++++
 hw/char/meson.build            | 2 +-
 hw/ipack/Kconfig               | 4 ++++
 hw/ipack/meson.build           | 3 ++-
 tests/qtest/libqos/meson.build | 4 +++-
 tests/qtest/meson.build        | 4 +++-
 6 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 4b73a803bf3..1dc20ee4c2c 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -78,3 +78,8 @@ config GOLDFISH_TTY
 
 config SHAKTI_UART
     bool
+
+config IP_OCTAL_232
+    bool
+    default y
+    depends on IPACK
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 1750834385a..ed3529cbbb7 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -4,7 +4,7 @@ system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
 system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
-system_ss.add(when: 'CONFIG_IPACK', if_true: files('ipoctal232.c'))
+system_ss.add(when: 'CONFIG_IP_OCTAL_232', if_true: files('ipoctal232.c'))
 system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugcon.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_uart.c'))
diff --git a/hw/ipack/Kconfig b/hw/ipack/Kconfig
index f8da24a62be..28d668727c8 100644
--- a/hw/ipack/Kconfig
+++ b/hw/ipack/Kconfig
@@ -1,4 +1,8 @@
 config IPACK
     bool
+
+config TPCI200
+    bool
+    select IPACK
     default y if PCI_DEVICES
 	    depends on PCI
diff --git a/hw/ipack/meson.build b/hw/ipack/meson.build
index 26567f1068e..e4805228926 100644
--- a/hw/ipack/meson.build
+++ b/hw/ipack/meson.build
@@ -1 +1,2 @@
-system_ss.add(when: 'CONFIG_IPACK', if_true: files('ipack.c', 'tpci200.c'))
+system_ss.add(when: 'CONFIG_IPACK', if_true: files('ipack.c'))
+system_ss.add(when: 'CONFIG_TPCI200', if_true: files('tpci200.c'))
diff --git a/tests/qtest/libqos/meson.build b/tests/qtest/libqos/meson.build
index 46f130ccfdb..1ddaf7b095b 100644
--- a/tests/qtest/libqos/meson.build
+++ b/tests/qtest/libqos/meson.build
@@ -32,7 +32,6 @@ libqos_srcs = files(
         'i2c-omap.c',
         'igb.c',
         'sdhci.c',
-        'tpci200.c',
         'virtio.c',
         'virtio-balloon.c',
         'virtio-blk.c',
@@ -70,6 +69,9 @@ endif
 if config_all_devices.has_key('CONFIG_RISCV_IOMMU')
   libqos_srcs += files('riscv-iommu.c')
 endif
+if config_all_devices.has_key('CONFIG_TPCI200')
+  libqos_srcs += files('tpci200.c')
+endif
 
 libqos = static_library('qos', libqos_srcs + genh,
                         build_by_default: false)
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 94b28e5a534..e60e92fe9de 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -286,7 +286,6 @@ qos_test_ss.add(
   'e1000-test.c',
   'eepro100-test.c',
   'es1370-test.c',
-  'ipoctal232-test.c',
   'lsm303dlhc-mag-test.c',
   'isl_pmbus_vr-test.c',
   'max34451-test.c',
@@ -317,6 +316,9 @@ qos_test_ss.add(
 if config_all_devices.has_key('CONFIG_VIRTIO_SERIAL')
   qos_test_ss.add(files('virtio-serial-test.c'))
 endif
+if config_all_devices.has_key('CONFIG_IP_OCTAL_232')
+  qos_test_ss.add(files('ipoctal232-test.c'))
+endif
 
 if host_os != 'windows'
   qos_test_ss.add(files('e1000e-test.c'))
-- 
2.47.1


