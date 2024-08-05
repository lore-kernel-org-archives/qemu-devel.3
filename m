Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CD0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49F-0002Wo-8j; Mon, 05 Aug 2024 16:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WDOxZgUKCr8yf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com>)
 id 1sb49A-00027p-6O
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:36 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WDOxZgUKCr8yf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com>)
 id 1sb495-0001PB-Os
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:35 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e08bc29c584so16243575276.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889048; x=1723493848; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=4wdCCjeNwO8Nd9IfMEbL3mdHNd1GL/ZDoT8770kOdC0=;
 b=WrqolcYQBHWy7OionzClsj44BhCmSQiASSBGyWqwgpymxsAzjdx2rsmBFi62Kfxlyw
 W/ma450owifF6OI1wfkPGodGqROI4J/w0sl7C9D6JIs0T6ZOqg5Vmi0gkpdtHby2CzgA
 2oNbzQDbEWGKgep4znkRXuusLfdJcqcaLzBgEn8A2pm4aaBIX0QKnLmg0Q+Rru0cFv3r
 HmJ/z6+lefWX6pFri4bD9VrVOrGABdQDsdHsQoHoHV+DIa2wRwBjpg0MVcqv37jYv5/6
 4LMqazq07GdYg4i/Fe452U03jWo+Q3fX8VQ9/VJsNdaucUk+3EhBJw4RSkugfVvjFp7Q
 Ab8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889048; x=1723493848;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4wdCCjeNwO8Nd9IfMEbL3mdHNd1GL/ZDoT8770kOdC0=;
 b=TeJ2b/cE3YkLJgAUMkWi0HWUSutXvX1mWosgsn9bicpVIoVc2C0bbqw/ljkpSjGqIy
 kATiL2XCMsvdtBpNX573kvv1p4CQKriwE0GtfeDWLw9GGyQHbnavSemnrJm3Lh+V87Wq
 N8O/zQChsfawdF8jAEtqg7ifHBzaMp8X475EjeKd7eNKwH51CVQbrU7JNj/mAbBbFw4y
 krERLg50CBIU7MXKbsdD5mvKZ7uyh9PoTrUrukC7R4RLJYbFRs7AXaJp6o3X/gCCtIfO
 wGA5A2MsjeNK7aqg5/i95+41AOQzpRsgdcw+nHamUF+2X2jUmSJ9TpT9addm8JKJXJnV
 JOiA==
X-Gm-Message-State: AOJu0YyJJzkB90N0bI1sRnlSpLgKsryc8Pbjtylv21nMNKLZ2qj2uz8I
 +edtqCJs+YXqgSbFwNa9vl+ZHt9sgDP+cOBUkPO7u8wbplmUztIZvEhDjn6vUOirSeM5TScE75T
 r5emEiFphUn8/MtCRJ/FGRAq5sI5Y1tLDznAccbUYWra5Z1/tT65XmwWseLelmhSRkVeG5CiUcT
 QaOqXyKxD+csONip/4O5BfxHq+Iw==
X-Google-Smtp-Source: AGHT+IFc6T3TAxrL7s5Lv7ug2GUJd5MzzOoyezk2KKzPhvbVP98dIUt1LyxRK3Igl2effMsOknmdhYg5+A==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6902:709:b0:e0b:9412:3295
 with SMTP id
 3f1490d57ef6-e0bde1eaf4bmr23833276.3.1722889048127; Mon, 05 Aug 2024 13:17:28
 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:16:59 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-5-tavip@google.com>
Subject: [RFC PATCH 04/23] hw/arm: add SVD file for NXP i.MX RT595
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3WDOxZgUKCr8yf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Picked from:

https://github.com/nxp-mcuxpresso/mcux-soc-svd/blob/main/MIMXRT595S/MIMXRT595S_cm33.xml

NOTE: the file is truncated to keep the email size reasonable. Please
use the link above and download the full file if you want to try out
the patch.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 hw/arm/svd/MIMXRT595S_cm33.xml | 224052 ++++++++++++++++++++++++++++++
 1 file changed, 224052 insertions(+)
 create mode 100644 hw/arm/svd/MIMXRT595S_cm33.xml

diff --git a/hw/arm/svd/MIMXRT595S_cm33.xml b/hw/arm/svd/MIMXRT595S_cm33.xml
new file mode 100644
index 0000000000..8943aa3555
--- /dev/null
+++ b/hw/arm/svd/MIMXRT595S_cm33.xml
@@ -0,0 +1,1725 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<device schemaVersion="1.3" xmlns:xs="http://www.w3.org/2001/XMLSchema-instance" xs:noNamespaceSchemaLocation="CMSIS-SVD.xsd">
+  <vendor>nxp.com</vendor>
+  <name>MIMXRT595S_cm33</name>
+  <version>1.0</version>
+  <description>MIMXRT595SFAWC,MIMXRT595SFFOC</description>
+  <licenseText>
+Copyright 2016-2023 NXP
+SPDX-License-Identifier: BSD-3-Clause
+  </licenseText>
+  <cpu>
+    <name>CM33</name>
+    <revision>r2p0</revision>
+    <endian>little</endian>
+    <mpuPresent>true</mpuPresent>
+    <fpuPresent>true</fpuPresent>
+    <vtorPresent>true</vtorPresent>
+    <nvicPrioBits>3</nvicPrioBits>
+    <vendorSystickConfig>false</vendorSystickConfig>
+  </cpu>
+  <addressUnitBits>8</addressUnitBits>
+  <width>32</width>
+  <peripherals>
+    <peripheral>
+      <name>RSTCTL0</name>
+      <description>Reset Controller 0</description>
+      <groupName>RSTCTL0</groupName>
+      <baseAddress>0x40000000</baseAddress>
+      <addressBlock>
+        <offset>0</offset>
+        <size>0x7C</size>
+        <usage>registers</usage>
+      </addressBlock>
+      <registers>
+        <register>
+          <name>SYSRSTSTAT</name>
+          <description>System Reset Status Register</description>
+          <addressOffset>0</addressOffset>
+          <size>32</size>
+          <access>read-write</access>
+          <resetValue>0x1</resetValue>
+          <resetMask>0xFFFFFFFF</resetMask>
+          <fields>
+            <field>
+              <name>VDD_POR</name>
+              <description>VDD CORE Power-On Reset (POR) was detected</description>
+              <bitOffset>0</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>VDD_POR_EVENT_IS_NOT_DETECTED</name>
+                  <description>No VDD CORE POR event is detected</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>VDD_POR_EVENT_WAS_DETECTED</name>
+                  <description>VDD CORE POR event was detected</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>PAD_RESET</name>
+              <description>RESETN pin reset was detected</description>
+              <bitOffset>4</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>PAD_RESET_IS_NOT_DETECTED</name>
+                  <description>No RESETN pin event is detected</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>PAD_RESET_WAS_DETECTED</name>
+                  <description>RESETN pin event was detected. Write '1' to clear this bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>ARM_RESET</name>
+              <description>ARM reset was detected</description>
+              <bitOffset>5</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>ARM_RESET_IS_NOT_DETECTED</name>
+                  <description>No ARM reset event is detected</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>ARM_RESET_WAS_DETECTED</name>
+                  <description>ARM reset was detected. Write '1' to clear this bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>WDT0_RESET</name>
+              <description>WatchDog Timer 0 reset was detected</description>
+              <bitOffset>6</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>WDT0_RESET_IS_NOT_DETECTED</name>
+                  <description>No WDT0 reset event detected</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>WDT0_RESET_WAS_DETECTED</name>
+                  <description>WDT0 reset event detected. Write '1' to clear this bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>WDT1_RESET</name>
+              <description>WatchDog Timer 1 reset was detected</description>
+              <bitOffset>7</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>WDT1_RESET_IS_NOT_DETECTED</name>
+                  <description>No WDT1 reset event detected</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>WDT1_RESET_WAS_DETECTED</name>
+                  <description>WDT1 reset event detected. Write '1' to clear this bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+          </fields>
+        </register>
+        <register>
+          <name>PRSTCTL0</name>
+          <description>Peripheral Reset Control Register 0</description>
+          <addressOffset>0x10</addressOffset>
+          <size>32</size>
+          <access>read-write</access>
+          <resetValue>0x7DF51F0A</resetValue>
+          <resetMask>0xFFFFFFFF</resetMask>
+          <fields>
+            <field>
+              <name>DSP</name>
+              <description>Fusion F1 DSP reset control</description>
+              <bitOffset>1</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>DSP_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>DSP_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>AXI_SWITCH</name>
+              <description>AXI Switch reset control</description>
+              <bitOffset>3</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>AXI_SWITCH_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>AXI_SWITCH_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>POWERQUAD</name>
+              <description>POWERQUAD reset control</description>
+              <bitOffset>8</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>POWERQUAD_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>POWERQUAD_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>CASPER</name>
+              <description>CASPER reset control</description>
+              <bitOffset>9</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>CASPER_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>CASPER_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>HASHCRYPT</name>
+              <description>Hash-Crypt reset control</description>
+              <bitOffset>10</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>HASHCRYPT_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>HASHCRYPT_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>PUF</name>
+              <description>PUF reset control</description>
+              <bitOffset>11</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>PUF_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>PUF_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>RNG</name>
+              <description>RNG reset control</description>
+              <bitOffset>12</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>RNG_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>RNG_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>FLEXSPI0_OTFAD</name>
+              <description>FLEXSPI0 and OTFAD reset control</description>
+              <bitOffset>16</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>FLEXSPI0_OTFAD_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>FLEXSPI0_OTFAD_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>FLEXSPI1</name>
+              <description>FLEXSPI1 reset control</description>
+              <bitOffset>18</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>FLEXSPI1_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>FLEXSPI1_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>USBHS_PHY</name>
+              <description>USB PHY reset control</description>
+              <bitOffset>20</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>USBHS_PHY_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>USBHS_PHY_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>USBHS_DEVICE</name>
+              <description>USB HS Device reset control</description>
+              <bitOffset>21</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>USBHS_DEVICE_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>USBHS_DEVICE_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>USBHS_HOST</name>
+              <description>USB HOST reset control</description>
+              <bitOffset>22</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>USBHS_HOST_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>USBHS_HOST_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>USBHS_SRAM</name>
+              <description>USB RAM reset control</description>
+              <bitOffset>23</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>USBHS_SRAM_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>USBHS_SRAM_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>SCT</name>
+              <description>SCTimer reset control</description>
+              <bitOffset>24</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SCT_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SCT_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>GPU</name>
+              <description>GPU reset control</description>
+              <bitOffset>26</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>GPU_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>GPU_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>DISPLAY_CONTROLLER</name>
+              <description>LCDIF Display Controller reset control</description>
+              <bitOffset>27</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>DISPLAY_CONTROLLER_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>DISPLAY_CONTROLLER_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>MIPI_DSI_CONTROLLER</name>
+              <description>MIPI Digital serial Interface controller reset control</description>
+              <bitOffset>28</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>MIPI_DSI_CONTROLLER_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>MIPI_DSI_CONTROLLER_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>MIPI_DSI_PHY</name>
+              <description>MIPI DSI PHY reset control</description>
+              <bitOffset>29</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>MIPI_DSI_PHY_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>MIPI_DSI_PHY_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>SMARTDMA</name>
+              <description>SMARTDMA Event/Algorithm handler reset control</description>
+              <bitOffset>30</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SMARTDMA_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SMARTDMA_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+          </fields>
+        </register>
+        <register>
+          <name>PRSTCTL1</name>
+          <description>Peripheral Reset Control Register 1</description>
+          <addressOffset>0x14</addressOffset>
+          <size>32</size>
+          <access>read-write</access>
+          <resetValue>0x101800C</resetValue>
+          <resetMask>0xFFFFFFFF</resetMask>
+          <fields>
+            <field>
+              <name>SDIO0</name>
+              <description>SDIO0 reset control</description>
+              <bitOffset>2</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SDIO0_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SDIO0_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>SDIO1</name>
+              <description>SDIO1 reset control</description>
+              <bitOffset>3</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SDIO1_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SDIO1_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>ACMP0</name>
+              <description>Analog comparator reset control</description>
+              <bitOffset>15</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>ACMP0_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>ACMP0_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>ADC0</name>
+              <description>Analog-to-Digital converter reset control</description>
+              <bitOffset>16</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>ADC0_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>ADC0_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>SHSGPIO0</name>
+              <description>Secure GPIO 0 reset control</description>
+              <bitOffset>24</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SHSGPIO0_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SHSGPIO0_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+          </fields>
+        </register>
+        <register>
+          <name>PRSTCTL2</name>
+          <description>Peripheral Reset Control Register 2</description>
+          <addressOffset>0x18</addressOffset>
+          <size>32</size>
+          <access>read-write</access>
+          <resetValue>0x1C000001</resetValue>
+          <resetMask>0xFFFFFFFF</resetMask>
+          <fields>
+            <field>
+              <name>UTICK0</name>
+              <description>Micro-tick timer reset control</description>
+              <bitOffset>0</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>UTICK0_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>UTICK0_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>WWDT0</name>
+              <description>Watchdog timer reset control</description>
+              <bitOffset>1</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>read-write</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>WWDT0_CLR</name>
+                  <description>Clear Reset</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>WWDT0_SET</name>
+                  <description>Set Reset</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+          </fields>
+        </register>
+        <register>
+          <name>PRSTCTL0_SET</name>
+          <description>Peripheral Reset Control Register 0 SET</description>
+          <addressOffset>0x40</addressOffset>
+          <size>32</size>
+          <access>write-only</access>
+          <resetValue>0</resetValue>
+          <resetMask>0</resetMask>
+          <fields>
+            <field>
+              <name>DSP</name>
+              <description>Fusion_ DSP reset set</description>
+              <bitOffset>1</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>DSP_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>DSP_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>AXI_SWITCH</name>
+              <description>AXI SWITCH reset set</description>
+              <bitOffset>3</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>AXI_SWITCH_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>AXI_SWITCH_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>POWERQUAD</name>
+              <description>POWERQUAD reset set</description>
+              <bitOffset>8</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>POWERQUAD_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>POWERQUAD_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>CASPER</name>
+              <description>CASPER reset set</description>
+              <bitOffset>9</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>CASPER_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>CASPER_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>HASHCRYPT</name>
+              <description>HASHCRYPT reset set</description>
+              <bitOffset>10</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>HASHCRYPT_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>HASHCRYPT_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>PUF</name>
+              <description>PUF reset set</description>
+              <bitOffset>11</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>PUF_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>PUF_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>RNG</name>
+              <description>RNG reset set</description>
+              <bitOffset>12</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>RNG_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>RNG_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>FLEXSPI0_OTFAD</name>
+              <description>FLEXSPI0 and OTFAD reset set</description>
+              <bitOffset>16</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>FLEXSPI0_OTFAD_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>FLEXSPI0_OTFAD_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>FLEXSPI1</name>
+              <description>FLEXSPI1 reset set</description>
+              <bitOffset>18</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>FLEXSPI1_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>FLEXSPI1_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>USBHS_PHY</name>
+              <description>USB PHY reset set</description>
+              <bitOffset>20</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>USBHS_PHY_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>USBHS_PHY_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>USBHS_DEVICE</name>
+              <description>USB Device reset set</description>
+              <bitOffset>21</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>USBHS_DEVICE_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>USBHS_DEVICE_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>USBHS_HOST</name>
+              <description>USB HOST reset set</description>
+              <bitOffset>22</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>USBHS_HOST_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>USBHS_HOST_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>USBHS_SRAM</name>
+              <description>USBHS SRAM reset set</description>
+              <bitOffset>23</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>USBHS_SRAM_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>USBHS_SRAM_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>SCT</name>
+              <description>SCTimer reset set</description>
+              <bitOffset>24</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SCT_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SCT_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>GPU</name>
+              <description>GPU reset set</description>
+              <bitOffset>26</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>GPU_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>GPU_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>DISPLAY_CONTROLLER</name>
+              <description>LCDIF DISPLAY CONTROLLER reset set</description>
+              <bitOffset>27</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>DISPLAY_CONTROLLER_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>DISPLAY_CONTROLLER_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>MIPI_DSI_CONTROLLER</name>
+              <description>MIPI DSI controller reset set</description>
+              <bitOffset>28</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>MIPI_DSI_CONTROLLER_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>MIPI_DSI_CONTROLLER_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>MIPI_DSI_PHY</name>
+              <description>MIPI DSI PHY reset set</description>
+              <bitOffset>29</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>MIPI_DSI_PHY_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>MIPI_DSI_PHY_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>SMARTDMA</name>
+              <description>SMARTDMA Event/Algorithm handler reset set</description>
+              <bitOffset>30</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SMARTDMA_CLR</name>
+                  <description>No Effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SMARTDMA_SET</name>
+                  <description>Sets the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+          </fields>
+        </register>
+        <register>
+          <name>PRSTCTL1_SET</name>
+          <description>Peripheral Reset Control Register 1 SET</description>
+          <addressOffset>0x44</addressOffset>
+          <size>32</size>
+          <access>write-only</access>
+          <resetValue>0</resetValue>
+          <resetMask>0</resetMask>
+          <fields>
+            <field>
+              <name>SDIO0</name>
+              <description>SDIO0 reset set</description>
+              <bitOffset>2</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SDIO0_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SDIO0_SET</name>
+                  <description>Sets the PRSTCTL1 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>SDIO1</name>
+              <description>SDIO1 reset set</description>
+              <bitOffset>3</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SDIO1_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SDIO1_SET</name>
+                  <description>Sets the PRSTCTL1 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>ACMP0</name>
+              <description>ACMP0 reset set</description>
+              <bitOffset>15</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>ACMP0_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>ACMP0_SET</name>
+                  <description>Sets the PRSTCTL1 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>ADC0</name>
+              <description>ADC0 reset set</description>
+              <bitOffset>16</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>ADC0_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>ADC0_SET</name>
+                  <description>Sets the PRSTCTL1 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>SHSGPIO0</name>
+              <description>SHSGPIO0 reset set</description>
+              <bitOffset>24</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SHSGPIO0_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SHSGPIO0_SET</name>
+                  <description>Sets the PRSTCTL1 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+          </fields>
+        </register>
+        <register>
+          <name>PRSTCTL2_SET</name>
+          <description>Peripheral Reset Control Register 2 SET</description>
+          <addressOffset>0x48</addressOffset>
+          <size>32</size>
+          <access>write-only</access>
+          <resetValue>0</resetValue>
+          <resetMask>0</resetMask>
+          <fields>
+            <field>
+              <name>UTICK0</name>
+              <description>Micro-tick timer 0 reset set</description>
+              <bitOffset>0</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>UTICK0_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>UTICK0_SET</name>
+                  <description>Sets the PRSTCTL2 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>WWDT0</name>
+              <description>WWDT0 reset set</description>
+              <bitOffset>1</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>WWDT0_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>WWDT0_SET</name>
+                  <description>Sets the PRSTCTL2 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+          </fields>
+        </register>
+        <register>
+          <name>PRSTCTL0_CLR</name>
+          <description>Peripheral Reset Control Register 0 CLR</description>
+          <addressOffset>0x70</addressOffset>
+          <size>32</size>
+          <access>write-only</access>
+          <resetValue>0</resetValue>
+          <resetMask>0</resetMask>
+          <fields>
+            <field>
+              <name>DSP</name>
+              <description>Fusion_ F1 DSP reset clear</description>
+              <bitOffset>1</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>DSP_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>DSP_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>AXI_SWITCH</name>
+              <description>AXI SWITCH reset clear</description>
+              <bitOffset>3</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>AXI_SWITCH_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>AXI_SWITCH_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>POWERQUAD</name>
+              <description>POWERQUAD reset clear</description>
+              <bitOffset>8</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>POWERQUAD_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>POWERQUAD_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>CASPER</name>
+              <description>CASPER reset clear</description>
+              <bitOffset>9</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>CASPER_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>CASPER_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>HASHCRYPT</name>
+              <description>HASHCRYPT reset clear</description>
+              <bitOffset>10</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>HASHCRYPT_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>HASHCRYPT_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>PUF</name>
+              <description>PUF reset clear</description>
+              <bitOffset>11</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>PUF_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>PUF_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>RNG</name>
+              <description>RNG reset clear</description>
+              <bitOffset>12</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>RNG_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>RNG_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>FLEXSPI0_OTFAD</name>
+              <description>FLEXSPI0 and OTFAD reset clear</description>
+              <bitOffset>16</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>FLEXSPI0_OTFAD_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>FLEXSPI0_OTFAD_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>FLEXSPI1</name>
+              <description>FLEXSPI1 reset clear</description>
+              <bitOffset>18</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>FLEXSPI1_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>FLEXSPI1_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>USBHS_PHY</name>
+              <description>USB PHY reset clear</description>
+              <bitOffset>20</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>USBHS_PHY_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>USBHS_PHY_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>USBHS_DEVICE</name>
+              <description>USB DEVICE reset clear</description>
+              <bitOffset>21</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>USBHS_DEVICE_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>USBHS_DEVICE_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>USBHS_HOST</name>
+              <description>USB HOST reset clear</description>
+              <bitOffset>22</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>USBHS_HOST_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>USBHS_HOST_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>USBHS_SRAM</name>
+              <description>USBHS SRAM reset clear</description>
+              <bitOffset>23</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>USBHS_SRAM_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>USBHS_SRAM_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>SCT</name>
+              <description>SCT reset clear</description>
+              <bitOffset>24</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SCT_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SCT_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>GPU</name>
+              <description>GPU reset clear</description>
+              <bitOffset>26</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>GPU_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>GPU_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>DISPLAY_CONTROLLER</name>
+              <description>LCDIF DISPLAY CONTROLLER reset clear</description>
+              <bitOffset>27</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>DISPLAY_CONTROLLER_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>DISPLAY_CONTROLLER_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>MIPI_DSI_CONTROLLER</name>
+              <description>MIPI DSI controller reset clear</description>
+              <bitOffset>28</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>MIPI_DSI_CONTROLLER_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>MIPI_DSI_CONTROLLER_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>MIPI_DSI_PHY</name>
+              <description>MIPI DSI PHY reset clear</description>
+              <bitOffset>29</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>MIPI_DSI_PHY_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>MIPI_DSI_PHY_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>SMARTDMA</name>
+              <description>SMARTDMA Event/Algorithm handler reset clear</description>
+              <bitOffset>30</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SMARTDMA_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SMARTDMA_SET</name>
+                  <description>Clears the PRSTCTL0 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+          </fields>
+        </register>
+        <register>
+          <name>PRSTCTL1_CLR</name>
+          <description>Peripheral Reset Control Register 1 CLR</description>
+          <addressOffset>0x74</addressOffset>
+          <size>32</size>
+          <access>write-only</access>
+          <resetValue>0</resetValue>
+          <resetMask>0</resetMask>
+          <fields>
+            <field>
+              <name>SDIO0</name>
+              <description>SDIO0 reset clear</description>
+              <bitOffset>2</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SDIO0_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SDIO0_SET</name>
+                  <description>Clears the PRSTCTL1 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>SDIO1</name>
+              <description>SDIO1 reset clear</description>
+              <bitOffset>3</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SDIO1_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SDIO1_SET</name>
+                  <description>Clears the PRSTCTL1 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>ACMP0</name>
+              <description>ACMP0 reset clear</description>
+              <bitOffset>15</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>ACMP0_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>ACMP0_SET</name>
+                  <description>Clears the PRSTCTL1 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>ADC0</name>
+              <description>ADC0 reset clear</description>
+              <bitOffset>16</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>ADC0_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>ADC0_SET</name>
+                  <description>Clears the PRSTCTL1 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>SHSGPIO0</name>
+              <description>Secure HSGPIO0 reset clear</description>
+              <bitOffset>24</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>SHSGPIO0_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>SHSGPIO0_SET</name>
+                  <description>Clears the PRSTCTL1 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+          </fields>
+        </register>
+        <register>
+          <name>PRSTCTL2_CLR</name>
+          <description>Peripheral Reset Control Register 2 CLR</description>
+          <addressOffset>0x78</addressOffset>
+          <size>32</size>
+          <access>write-only</access>
+          <resetValue>0</resetValue>
+          <resetMask>0</resetMask>
+          <fields>
+            <field>
+              <name>UTICK0</name>
+              <description>Micro-tick timer 0 reset clear</description>
+              <bitOffset>0</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>UTICK0_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>UTICK0_SET</name>
+                  <description>Clears the PRSTCTL2 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+            <field>
+              <name>WWDT0</name>
+              <description>WWDT0 reset clear</description>
+              <bitOffset>1</bitOffset>
+              <bitWidth>1</bitWidth>
+              <access>write-only</access>
+              <enumeratedValues>
+                <enumeratedValue>
+                  <name>WWDT0_CLR</name>
+                  <description>No effect</description>
+                  <value>0</value>
+                </enumeratedValue>
+                <enumeratedValue>
+                  <name>WWDT0_SET</name>
+                  <description>Clears the PRSTCTL2 Bit</description>
+                  <value>0x1</value>
+                </enumeratedValue>
+              </enumeratedValues>
+            </field>
+          </fields>
+        </register>
+      </registers>
+    </peripheral>
+  </peripherals>
+</device>
\ No newline at end of file
-- 
2.46.0.rc2.264.g509ed76dc8-goog


