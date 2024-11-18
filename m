Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1198D49219
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1Nk-0007HM-1d; Mon, 18 Nov 2024 08:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1NV-0007EO-SH
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:01:20 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1NU-00071z-2Z
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:01:17 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38230ed9baeso1672643f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 05:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934872; x=1732539672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gTRgv2swMMRQLOEh0jdwrtgy201rtzP+J8h2YvJfYEw=;
 b=I5VuzzaP9ybIllvJXyf3/FDYTbAKnP8l/m3g1pYa0HBZl240BEV5dsO9qdW4LH8ybH
 0ZuW1f5IXRrBXhKa/kKlgHYiTVSOiHtNpRNr/98dPdAnTUaSBD/B5BXY7ovBJck3GG1x
 R60UlJ4rFUSQ2ajBMfeg8suuwnr6JhMTtwyNRiqT7H90aQ5BH3g8DGjZ7B/Vn53reurr
 Bhvufyn/sn6STZTyGJ3E87uvet4j+tOgQcUD3lJmAcRcIBktjhIr65JWu0xdvXvz1hR4
 swAOjNb4rkCvurFD+ZmLsbaQtxAJbIgVsVXVBqiB74t/fn+i8VLmULcudQ0x3Sg/a/Vq
 Ob4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934872; x=1732539672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gTRgv2swMMRQLOEh0jdwrtgy201rtzP+J8h2YvJfYEw=;
 b=wB+pC7v7Ltih5sMSIhUXZecuNTAF7SjOWprpE4h9nLPu+rP3yuEFw/6pFSXAvgs0cm
 hnYVeLowNtd055yALOQNy1wWfTyLl0YBoaldGnJCXmxBVgpxuYg0RdBfi+BZmwSjpInm
 eEoBRXLB4NF7nohx9fXcb/64WOgDUlwYRQoLWwBaf0wck37bfwEByN+PTC+ccaGzpNlf
 2nDaPSzwrv1UKrnIXpRSnIniK527L+Smhl5dB/Cpcck6Y+dJqSLdnab4yhNIVOHfoVwe
 iQ5jWbY8sahUP++R5iU+xIBP18CRnn4swrgEsNYOBiOlHmoAdrxr9jg3//NHtO9+J1f6
 nShw==
X-Gm-Message-State: AOJu0Yz8+S7Mtry2bUe7ZyTU+SjQ3btsG5NMnQxxS1oNRKhSu/89iL17
 +tf3usJnwe1oNhTUaYJh7XbZ9/7JySnGI/YZb1p+RB3v5uPn3ViUUPNSFusgeHkErwAwxVAcKzx
 3
X-Google-Smtp-Source: AGHT+IGZP3cwR15Elcgtrn+x/Zn035cI3RQ5T5U3eSZrmGNSKSZyqHxK2RNp6bfluEAXkux3f5rWlA==
X-Received: by 2002:a5d:598e:0:b0:37c:cee0:96e6 with SMTP id
 ffacd0b85a97d-38225a0d457mr11458759f8f.27.1731934871672; 
 Mon, 18 Nov 2024 05:01:11 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae161d8sm13025177f8f.78.2024.11.18.05.01.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 05:01:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Iris Artin <iris@artins.org>
Subject: [PATCH-for-9.2] hw/avr/arduino: Check for CPU types in
 machine_run_board_init()
Date: Mon, 18 Nov 2024 14:01:09 +0100
Message-ID: <20241118130109.7838-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Leverage the common code introduced in commit c9cf636d48 ("machine:
Add a valid_cpu_types property") to check for the single valid CPU
type. This allows reporting an error for invalid CPUs:

  $ qemu-system-avr -M 2009 -cpu avr51-avr-cpu
  qemu-system-avr: Invalid CPU model: avr51
  The only valid type is: avr5

Reported-by: Iris Artin <iris@artins.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/avr/arduino.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
index 48ef478346..a8da2728f0 100644
--- a/hw/avr/arduino.c
+++ b/hw/avr/arduino.c
@@ -71,6 +71,10 @@ static void arduino_machine_class_init(ObjectClass *oc, void *data)
 
 static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        AVR_CPU_TYPE_NAME("avr5"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
 
@@ -80,12 +84,17 @@ static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
      */
     mc->desc        = "Arduino Duemilanove (ATmega168)",
     mc->alias       = "2009";
+    mc->valid_cpu_types = valid_cpu_types;
     amc->mcu_type   = TYPE_ATMEGA168_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000;
 };
 
 static void arduino_uno_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        AVR_CPU_TYPE_NAME("avr5"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
 
@@ -95,12 +104,17 @@ static void arduino_uno_class_init(ObjectClass *oc, void *data)
      */
     mc->desc        = "Arduino UNO (ATmega328P)";
     mc->alias       = "uno";
+    mc->valid_cpu_types = valid_cpu_types;
     amc->mcu_type   = TYPE_ATMEGA328_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000;
 };
 
 static void arduino_mega_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        AVR_CPU_TYPE_NAME("avr51"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
 
@@ -110,12 +124,17 @@ static void arduino_mega_class_init(ObjectClass *oc, void *data)
      */
     mc->desc        = "Arduino Mega (ATmega1280)";
     mc->alias       = "mega";
+    mc->valid_cpu_types = valid_cpu_types;
     amc->mcu_type   = TYPE_ATMEGA1280_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000;
 };
 
 static void arduino_mega2560_class_init(ObjectClass *oc, void *data)
 {
+    static const char * const valid_cpu_types[] = {
+        AVR_CPU_TYPE_NAME("avr6"),
+        NULL
+    };
     MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
 
@@ -125,6 +144,7 @@ static void arduino_mega2560_class_init(ObjectClass *oc, void *data)
      */
     mc->desc        = "Arduino Mega 2560 (ATmega2560)";
     mc->alias       = "mega2560";
+    mc->valid_cpu_types = valid_cpu_types;
     amc->mcu_type   = TYPE_ATMEGA2560_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000; /* CSTCE16M0V53-R0 */
 };
-- 
2.45.2


