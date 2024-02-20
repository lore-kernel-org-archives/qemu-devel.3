Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C2AC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 21:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcXOt-00042Z-Bx; Tue, 20 Feb 2024 16:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gRXVZQcKCjYcgedgVaYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--komlodi.bounces.google.com>)
 id 1rcXOo-0003yn-Hl
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:11:34 -0500
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gRXVZQcKCjYcgedgVaYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--komlodi.bounces.google.com>)
 id 1rcXOm-0008QK-6x
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 16:11:33 -0500
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-5c65e666609so5160396a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 13:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708463490; x=1709068290; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ROn/UHUR1Rw30ZBr5JAvf733dMegwZEnijudzImnin8=;
 b=UT75fZh268oTh2TK9ni7H6Zi725x+0dllBnlJP+KwL1tyjdlosXyy1bSsVdayCeli4
 uLs++MjtKkPGUHX9JlwTV0G6WwbZrVdSmK5OY9K6iTgKUQKMVI2jtPEPHY+saJW51pR5
 5YcOY/7aqI2usja8ZZQGLhNmY3tNgKZ6QSxSZFnMB15AMC/fj7vfI4vSZmLYOxDgATa5
 XqTxlPURCpDubASTg0AcSjVnrHqBgv4lBSTAT3CzjueQmXT7QK/pT3NW05m8P/c0a2GB
 XRnUWesXR6LPOnCoR+7Py3OV2saSzkjeXVZFqQRRgBVjjQfENHx76uT3qJk/fE3mAY1g
 0GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708463490; x=1709068290;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ROn/UHUR1Rw30ZBr5JAvf733dMegwZEnijudzImnin8=;
 b=AopQsC7oIco+PF6vTsXSmKl8tj3N1WWfy4ItzOag/EEnf9Glfg4wajkOxaQNj7/zlb
 C4iRI2zUd3kGrqEcnZY00jS8ALY64+D0gmEcPq9+A/kYMHiXwQKhZLy6K6QVFab4e3aF
 0/ob7ELmOygFBIi5bW1U0PMk0Mmb0fTo1Putd+y+dI4UocUop0i+ZcvVTe8tcYPyNPCQ
 o6Kd/v+ZBqQE1u0wzgdzmEsHqlwlo4vHEzA6pCeSWPHHFnBGFseMR4No1U16I2t7DDw2
 IwvWJUnLqwbiPOVKxEsXgOudtKC8LmgccPyiBzRIo90MVdmAxo92YEyOXaexfK+/zUX4
 uuxw==
X-Gm-Message-State: AOJu0YwCPfFZWPxt4t45jHIkuUeUEHBtKRTDIw3ogaBRzItHFknxBxuT
 Rsq/PRHjHF9UHG88Fsf01B6WLQiB0xCY68v1R7FiP7/O5ytXhuMZwavJoi9jadmPwnIag/ltGgB
 tplBTC5Z6vCHvbG46zGBPFoy2R09nUc0COKhuKvXHNoZTpgfGMOe7pU15zRGcCeQMnpl15l5Gms
 +acYPW6Ai974Q+zuKw9USU7Kos53EyhuIHNQbL
X-Google-Smtp-Source: AGHT+IEFk6pV6okFHuuA92zIWwRoT+SWAbczcX0elUKXoKhQDnfca1efDFCFve4ZKDc6sWPXowtAdpiTmkC5
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a65:6943:0:b0:5d6:cfc:2f39 with SMTP id
 w3-20020a656943000000b005d60cfc2f39mr92357pgq.11.1708463489505; Tue, 20 Feb
 2024 13:11:29 -0800 (PST)
Date: Tue, 20 Feb 2024 21:11:22 +0000
In-Reply-To: <20240220211123.2664977-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240220211123.2664977-1-komlodi@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220211123.2664977-3-komlodi@google.com>
Subject: [PATCH v4 2/3] hw/i2c/smbus_slave: Add object path on error prints
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: komlodi@google.com, venture@google.com, minyard@acm.org, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=3gRXVZQcKCjYcgedgVaYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--komlodi.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The current logging doesn't tell us which specific smbus device is an
error state.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/smbus_slave.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 1300c9ec72..9f9afc25a4 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -25,11 +25,15 @@
 #define DPRINTF(fmt, ...) \
 do { printf("smbus(%02x): " fmt , dev->i2c.address, ## __VA_ARGS__); } while (0)
 #define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__); exit(1);} while (0)
+do { g_autofree char *qom_path = object_get_canonical_path(OBJECT(dev));  \
+    fprintf(stderr, "%s: smbus: error: " fmt , qom_path, ## __VA_ARGS__); \
+            exit(1); } while (0)
 #else
 #define DPRINTF(fmt, ...) do {} while(0)
 #define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__);} while (0)
+do { g_autofree char *qom_path = object_get_canonical_path(OBJECT(dev));  \
+    fprintf(stderr, "%s: smbus: error: " fmt , qom_path, ## __VA_ARGS__); \
+             } while (0)
 #endif
 
 enum {
-- 
2.44.0.rc0.258.g7320e95886-goog


