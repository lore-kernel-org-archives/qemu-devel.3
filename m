Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4423FCD1297
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIlcl-0008U0-S8; Tue, 11 Nov 2025 05:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcU-0007yj-KV
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:29:02 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcL-0000L1-Ba
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:29:02 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b714b1290aeso670735566b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 02:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762856932; x=1763461732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTAwoU/vFvjfdf76mRBJgt9Wu8TZhU78HWJTQRj5fFo=;
 b=WfPZIWGH7ezKTLA3SSVgfmZbZh4nU73V+ysws6+aiaqkpZns4xtQSGb0Pimp/jhjwS
 e2jKCv/kLLTJ2s7xSHM7teewKb30cHomBIKTlDYPeHyxSV+1lCmtDOM4Wmv3uzcal56M
 t3dN3TqDpJS3fRdiLVSeRvPhwixM/Q9In3fAp3++pzONiClOHhW4N+yTu7QkwZRV+D5U
 GNJCMF9rdad5iS/K1nlWuhb1qnwMXF6M94Fuis/Pw75ZppxX8fJx4U34BcYHpF3YfOk0
 16zN2QTiH+lJj/ODOG/TD5o8VQHj84//N+v0Fh0I1BxdyRlVRXagskzKV1+QOquVIH2a
 1pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762856932; x=1763461732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KTAwoU/vFvjfdf76mRBJgt9Wu8TZhU78HWJTQRj5fFo=;
 b=bGars4jNkAislXeJPW1cHN/JkJJoyu++Fl35C0r2rN8B9vrUK8O8YmxE128GYq7yTd
 FWDZraZPOvRCEiMgw6W7vYAkKHQzwoW7yQ1pyruj6CTPBe6yA6rLssKz0aotg2tP73J5
 YCojYeFlKcdgxW7XaQZ9M/02b4C58XvhuGdr/2dJ9H6CTytagy5ho62IoTynHMWKkblV
 tDTRRnRiuozIAe51Jlr/O/rBgXkw9yScpztNBdMsVSv6fE7oNitBC0Wz8V51VQLI6KjN
 NLuVwhAyY7jbsiGM8wHekhBwDzHZrVz2b3PneBs1R4RsFCIb5wsh8IUx+lnUpAhyIrkl
 PWtQ==
X-Gm-Message-State: AOJu0YxJXwVZrgdzn8Wx/DJ3kqQF6HC+xdzFIOwfet1nVVJUWCCRXVC0
 A62RVi3/7eV6RrzpyFztNXpU0Sb4INQSB74YlF+GHdq5joIbu1Mzo837dpUd6e5+
X-Gm-Gg: ASbGncvgndAnIUoO+/CiAI8E/HDZ72xieqob3csIYyDVpRL0Gh6YOLCPVGU/4sOBmTs
 uMjv4OMQJJdcmbsFgWKZjGE4/79KpmNDf0YT/L/Ha/uPO+GyfLsFXJ4DTfgfbtET6CLa0ohEMGZ
 8qE2GRApn1qhSDE2ZQG1DXxv2Yk7caqeB1g3OWonyVZ62d3Wv/Ir0cgPcOoh5I2BZVSERzUNcU8
 MHDeN1Levi7RE+LwWv9a1C8vs6v9Nuc/DWbhp0CK7qxMDS7+FHgzK6H+EM5EUjhjskMZpv+CRU5
 LuWkz0Trl1GGpayOB6IPhTsIlmguWVDHCsgMBmrIv49V/huW4fCcpPEpMWyXMh5tLkWpVXo6AVK
 GOg9u+rkiet34ewZdmNAnxOLJvyvldmPqYFibhsNUcnXvIP7qj5U778pE9jX0VOm4tr4TWd0TH2
 646+mo5shviJUizbQjDhFqMMjSQsEEmRwB
X-Google-Smtp-Source: AGHT+IHM7PGebo7cIzDfUZUWGQzmalIBIMPc5QitvlTwhA7K5rcX+qNr3gE+ZfFwxwDPG96tlslHXg==
X-Received: by 2002:a17:907:3f23:b0:b72:5983:dafd with SMTP id
 a640c23a62f3a-b72e036c329mr1108332266b.24.1762856931492; 
 Tue, 11 Nov 2025 02:28:51 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc12:ce00:ae91:a1ff:fe8b:15a7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbd1ecfsm1290619366b.10.2025.11.11.02.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 02:28:51 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v4 15/15] docs/system/arm: Add support for Beckhoff CX7200
Date: Tue, 11 Nov 2025 11:28:36 +0100
Message-ID: <20251111102836.212535-16-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111102836.212535-1-corvin.koehne@gmail.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: YannickV <Y.Vossen@beckhoff.com>

This commit offers some documentation on the Beckhoff CX7200
qemu emulation.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 docs/system/arm/beckhoff-cx7200.rst | 57 +++++++++++++++++++++++++++++
 docs/system/target-arm.rst          |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 docs/system/arm/beckhoff-cx7200.rst

diff --git a/docs/system/arm/beckhoff-cx7200.rst b/docs/system/arm/beckhoff-cx7200.rst
new file mode 100644
index 0000000000..f060319b0f
--- /dev/null
+++ b/docs/system/arm/beckhoff-cx7200.rst
@@ -0,0 +1,57 @@
+Beckhoff CX7200 (``beckhoff-cx7200``)
+======================================
+The Beckhoff CX7200 is based on the same architecture as the Xilinx Zynq A9.
+The Zynq 7000 family is based on the AMD SoC architecture. These products
+integrate a feature-rich dual or single-core Arm Cortex-A9 MPCore based
+processing system (PS) and AMD programmable logic (PL) in a single device.
+The Beckhoff Communication Controller (CCAT) can be found in the PL of Zynq.
+
+More details here:
+https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Zynq-7000-SoC-Technical-Reference-Manual
+https://www.beckhoff.com/de-de/produkte/ipc/embedded-pcs/cx7000-arm-r-cortex-r/cx7293.html
+
+The CX7200 supports following devices:
+    - A9 MPCORE
+        - cortex-a9
+        - GIC v1
+        - Generic timer
+        - wdt
+    - OCM 256KB
+    - SMC SRAM@0xe2000000 64MB
+    - Zynq SLCR
+    - SPI x2
+    - QSPI
+    - UART
+    - TTC x2
+    - Gigabit Ethernet Controller
+    - SD Controller
+    - XADC
+    - Arm PrimeCell DMA Controller
+    - DDR Memory
+    - DDR Controller
+    - Beckhoff Communication Controller (CCAT)
+        - EEPROM Interface
+        - DMA Controller
+
+Following devices are not supported:
+    - I2C
+
+Running
+"""""""
+Directly loading an ELF file to the CPU of the CX7200 to run f.e. TC/RTOS (based on FreeRTOS):
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M beckhoff-cx7200 \
+        -device loader,file=CX7200_Zynq_Fsbl.elf \
+        -display none \
+        -icount shift=auto \
+
+
+For setting the EEPROM content of the CCAT provide the following on the command line:
+
+.. code-block:: bash
+
+        -drive file=eeprom.bin,format=raw,id=ccat-eeprom
+
+The size of eeprom.bin must be aligned to a power of 2 and bigger than 256 bytes.
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 9aaa9c414c..5f15fda630 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -81,6 +81,7 @@ Board-specific documentation
    arm/aspeed
    arm/bananapi_m2u.rst
    arm/b-l475e-iot01a.rst
+   arm/beckhoff-cx7200
    arm/sabrelite
    arm/highbank
    arm/digic
-- 
2.47.3


