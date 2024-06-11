Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489F8C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGypx-0003T7-Gz; Tue, 11 Jun 2024 06:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGypw-0003Sv-KM
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:34:44 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGypu-0002oI-QD
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:34:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4217d451f69so8262685e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718102081; x=1718706881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kfBlhlKJNBiXVGnmXKNokqgloJowB7odFyWS6IGw2Bs=;
 b=SkHn5mq7Efdp6LptQ6JdrW4ikM6FIHSs8Scp3acXFiN87AmT23DAYvZbHxdBOJSkz+
 fBlLitBb8512MxLqIGpuPoCMGDXcNpX3f2tBUm/qEWvtNLsnk6dLbRWy5dbpSwiMHkCR
 /MOvWUqeER2hOfAXwSYfG9loFjps5BOU55VAoyrMf3HilvXxiD5R3zxPCv0Wl+KqSYP4
 8lxZrqOlxhk0JTX/fZSLYMHGBLLeTzo8l14K8V5UikgPZrtnVmkMIEp1ppeIo3BAeI9h
 SB9m2eX3WT52xpzHesRDfsYrAFL4VdMBnxhPhjKK9KTMlykLxJ42a9VtHkA3OWmS2HL5
 ZSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718102081; x=1718706881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kfBlhlKJNBiXVGnmXKNokqgloJowB7odFyWS6IGw2Bs=;
 b=C6x5Qdvs+RynV+XtnSyzrumDNF/X0UKZmiyOSYWuT9Q/M3TIE+taZ+9t3TyAZQ/krx
 oeFV9oJFK1V4GQI8X4WCBDJ2eUdHfKydd0Qbr8BGkZXkF/0kqzmvKCMCUGGNM+v5m7nd
 gwGr+a1OBdFsiwNvR0hBGkYG0yRrgAcHsf9unUp0Mi0VOEYjKf20PStR9dQ9DoNheZuw
 5hEm/2KbsFLaxvlRG36sL4uhAzwWK3wRnijHeMl9ZvAhr7vdmXHF8G6qMFsOZhIA98gv
 C//Ozxkgo3xV9ZEeVv+67sPdaWP/ASl/dNOzfx+cUN4sGbrZgAoPJGojlmMUKiujg6sg
 lg1Q==
X-Gm-Message-State: AOJu0Yy6NfCXSWRxPOBDOBr6h6nqYrQuiFG8liNF9114NXa1/TNL2Rxk
 vBzfuAVgu0pwlMiMZs3oV8ltnIV2pap3eSJOuvPaEvSpidMNpOxmeL63TBSGadpGs3NDJJqjIZ4
 FPW0=
X-Google-Smtp-Source: AGHT+IHWhKEzSBa2cdO917EciC082ul2gV+2J3yF1YY0erif6toRa9ToN8jZI1IA+OA7xlFcRJ1Sbg==
X-Received: by 2002:a05:600c:4ec9:b0:41a:821b:37f7 with SMTP id
 5b1f17b1804b1-42164a328a6mr85033065e9.27.1718102081217; 
 Tue, 11 Jun 2024 03:34:41 -0700 (PDT)
Received: from localhost.localdomain (adsl-33.37.6.162.tellas.gr.
 [37.6.162.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42232e71865sm30878795e9.46.2024.06.11.03.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 03:34:41 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org
Subject: [RFC PATCH v2 5/5] DO NOT MERGE: replace TYPE_PL011 with x-pl011-rust
 in arm virt machine
Date: Tue, 11 Jun 2024 13:33:34 +0300
Message-ID: <52534c3166e2b8b89421990d62ef90e8c73f9e9e.1718101832.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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

Convenience patch for testing the rust device.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3c93c0c0a6..f33b58ae0d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -912,7 +912,11 @@ static void create_uart(const VirtMachineState *vms, int uart,
     int irq = vms->irqmap[uart];
     const char compat[] = "arm,pl011\0arm,primecell";
     const char clocknames[] = "uartclk\0apb_pclk";
+#ifdef CONFIG_WITH_RUST
+    DeviceState *dev = qdev_new("x-pl011-rust");
+#else
     DeviceState *dev = qdev_new(TYPE_PL011);
+#endif
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     MachineState *ms = MACHINE(vms);
 
-- 
γαῖα πυρί μιχθήτω


