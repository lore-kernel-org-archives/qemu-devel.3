Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4CED74EDE
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIpH-00025G-Fv; Fri, 23 Jan 2026 10:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInU-00078G-DV
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:09 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInR-00036v-Ts
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:04 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so1581491f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769181000; x=1769785800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mP+whJkVyK+SSs6Mqc5tBKekpoTk7ckeOTEMEVQCY7c=;
 b=NDRk5GDKkxY3hWkbfcRfxV+cGZvu+X/mfIZnqMsbJXIKLQmDoXQz3bHqKtrl3/11/U
 hvXzcK8EYEpN3ym1W8Ne9DO+H0WCQ4Z/lPN53hOOmWElhZ8Vsto3o91ILr8RmChBaXcn
 xXpE/SGnQa0C7vk5TfQQbQoQ8rlmfcxcef7VEsOF3r7p55yG+hzx9+7sRcml6q+rG1pI
 GZ90KKCIKD8K5g64AQnolHHj+xDr98ySyTo303b9t+hmNAFC8vOiApxaQ3vvOj6R87in
 0re/h/R7td1sDMaK3yUpPrYe8bEBdgcq3yA227WpO6eIelxe8Gk42acRH0kv6N+xdSlZ
 JZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769181000; x=1769785800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mP+whJkVyK+SSs6Mqc5tBKekpoTk7ckeOTEMEVQCY7c=;
 b=vFR9ok9mjZN/vPjE6MNJO/V617VEeXqhheYLwunGClahpReVrJVq/uGo1RxtO9eTid
 Eohqa0zzrezU0MaS4P+amwnf1aLJENllnL0xWvSEwFt0S5CYo4USsyLGE74qHFkf48GV
 fT+K6igw3GO0ALiw3CBYNBR/Pbo6YPItnWci+WD93k76U9uKWqrHEfcclldijP7hMncb
 X9bLJGDQfQdDq9wXIue71NbsEXdtxy1JWzLzvrbdpfII0PgLIYrz0fJS42N9qxUl0a62
 C+CdSftOoZflsd0+CoTUrian7ShOMETu5kYNUv2zVoxyTdblEho0rcZf+SSRxj/WaFtg
 FYOA==
X-Gm-Message-State: AOJu0YwPoVG1FFWTT+JKHN5k/Wl0mXlD/MVWhxh3o/Cq9Wj3kx8eHRy1
 zgBMWrNAJUgeFZZEyct9MuM3m4/y7wh61xSs+dpz06xLhlhIWWuLdKtsBgekSIACetUQxdWOV5p
 okXM15PU=
X-Gm-Gg: AZuq6aKDynzbotTbfKHdgLTS7gTuEoAbfO1Bo/PfeXtzuh2HDRMUnO1Q5D0XP3SOV9z
 iFuHbJfgRxTkQtK8SgB7J0X3/3Y0bQhfSMBuWi5C6UgY1twOZcuEeDedQorsN2c60Ejjp6XbtZ2
 2eGIF/6XGiIZ9wQL1cv7Fw7CwQHz8RhyRFlNPpF/DoD6hTOjwMogy0R9UXQ9GS8yI3UJVLI91BV
 Q/cF835o4kvWOyBRRfv4q8ItwY2YVTJTbDaD4xmUKV/KwJS+OquP3Ycz8v6V8RqKzBjcbpGWAPF
 vH84Iyjbf5xZdfnV39gU/m2vzQ/A121p8fP+tX6z9ymDFe84hN/XfQG7nqHoEQ6RqSIZeY2/SXy
 fYax1Q8o/GbDIRPPJN8dBUxwuAu/W6/BkBNyDS184Nl+9mTGr9JMjE1k5v7boHwiumy0w+jFEpo
 N2S1zZUYZnhBJw4W0jw4vRhhN4JAZ7jCU9izJMN0UisoRDFRoLobSn
X-Received: by 2002:a05:6000:288c:b0:430:fd60:93fb with SMTP id
 ffacd0b85a97d-435b160378dmr5408499f8f.32.1769181000246; 
 Fri, 23 Jan 2026 07:10:00 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/22] docs/system/arm/xlnx-zynq.rst: Improve docs rendering
Date: Fri, 23 Jan 2026 15:09:37 +0000
Message-ID: <20260123150941.1877768-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Make some minor improvements to the rendering of the docs for
the xlnx-zynq-a9 board:

 * use a proper hyperlink rather than a bare URL for the
   link to the reference manual
 * drop the hex address of the SMC SRAM: the bare '@' is
   rendered as bogus mailto: hyperlink, and the information
   is not very interesting to the user anyway
 * expand out the abbreviations in the list of Cortex-A9
   per-CPU devices
 * correct the bullet-point list markup so it doesn't render
   with odd highlighted lines
 * capitalize 'Arm' correctly

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Message-id: 20260115142629.665319-2-peter.maydell@linaro.org
---
 docs/system/arm/xlnx-zynq.rst | 51 ++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/docs/system/arm/xlnx-zynq.rst b/docs/system/arm/xlnx-zynq.rst
index ade18a3fe1..aa37df2926 100644
--- a/docs/system/arm/xlnx-zynq.rst
+++ b/docs/system/arm/xlnx-zynq.rst
@@ -4,32 +4,35 @@ The Zynq 7000 family is based on the AMD SoC architecture. These products
 integrate a feature-rich dual or single-core Arm Cortex-A9 MPCore based
 processing system (PS) and AMD programmable logic (PL) in a single device.
 
-More details here:
-https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Zynq-7000-SoC-Technical-Reference-Manual
-
-QEMU xilinx-zynq-a9 board supports following devices:
-    - A9 MPCORE
-        - cortex-a9
-        - GIC v1
-        - Generic timer
-        - wdt
-    - OCM 256KB
-    - SMC SRAM@0xe2000000 64MB
-    - Zynq SLCR
-    - SPI x2
-    - QSPI
-    - UART
-    - TTC x2
-    - Gigabit Ethernet Controller x2
-    - SD Controller x2
-    - XADC
-    - Arm PrimeCell DMA Controller
-    - DDR Memory
-    - USB 2.0 x2
+The SoC is documented in the
+`Zynq 7000 Technical Reference manual <https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Zynq-7000-SoC-Technical-Reference-Manual>`__.
+
+The QEMU xilinx-zynq-a9 board supports the following devices:
+
+- Arm Cortex-A9 MPCore CPU
+
+  - Cortex-A9 CPUs
+  - GIC v1 interrupt controller
+  - Generic timer
+  - Watchdog timer
+
+- OCM 256KB
+- SMC SRAM 64MB
+- Zynq SLCR
+- SPI x2
+- QSPI
+- UART
+- TTC x2
+- Gigabit Ethernet Controller x2
+- SD Controller x2
+- XADC
+- Arm PrimeCell DMA Controller
+- DDR Memory
+- USB 2.0 x2
 
 Running
 """""""
-Direct Linux boot of a generic ARM upstream Linux kernel:
+Direct Linux boot of a generic Arm upstream Linux kernel:
 
 .. code-block:: bash
 
@@ -44,4 +47,4 @@ For configuring the boot-mode provide the following on the command line:
 
    -machine boot-mode=qspi
 
-Supported values are jtag, sd, qspi, nor.
+Supported values are ``jtag``, ``sd``, ``qspi`` and ``nor``.
-- 
2.47.3


