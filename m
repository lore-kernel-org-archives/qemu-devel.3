Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F680C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sChAO-000780-Lv; Thu, 30 May 2024 10:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sChAN-00076l-6Y
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:54:07 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sChAL-00023T-LU
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:54:06 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe639a5so851469a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717080843; x=1717685643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBGdGeMx1eXvGpTXQ7NHtXTGnuO25PcPWZ9ArhDIKyk=;
 b=dzZappirn4JNbpyuq1Uvp9mveY3E1km5yWnhSm2OgXqPVQH0ho6pnLzhiMWmuqXD+r
 BGQSgeAaiSVzpHpbf/fzIm3i495g94RH+3jkdD2KcQ8dcGaOj3TazRPfY2QCv6XkrTyy
 xMk6NVtGRFgNqNWldBFYJVg1B+x1dlJAN3EQ/oj7q4ZMQZ7qu7b08JKQbY4Cn60uimTO
 gGQ1sKGpfbuUbn+MknU5r5WJZ5uA7hm+G0D064It2JJD6Ciq/B9qT+HmaPcOj36uU4XR
 /Gtyq1kD2BqaLCKMRVBUrvJ2+VjMiMOSYBkGk/KRa7os5YXe13t7eWirZggNb0DPLE8w
 xb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717080843; x=1717685643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBGdGeMx1eXvGpTXQ7NHtXTGnuO25PcPWZ9ArhDIKyk=;
 b=qOPv1EZahGsX4BuhwVO6mHfj1RMeXap0NjP4Vmk4kxyXjyOo6bV9g4MCL0nKI/8myn
 ZwbFl0D5pKPCfd55mxnfA2zfBJS+8TKsxRxlytOjteQLrcJ78W/DtOzeOjIMm9GN8Ib7
 +Xvx2wCEueTH9dOf+mnigB6KVLe8dOhCPv+VdwjN/o6cIfUz6kz0mftgpc7QWskfrq76
 LAeCqRu9Ne9hA7+bzjZiLqQdV+X5Kg17ioNj6DpjcoL32UYT3iG4pEsuju5/O9C9tTKZ
 FEnpDDkMpUXiric5bgh8984autUkN44SRWZCjCl3rOoLoMkeosBUtBRVnrkQfBSTwK5T
 y4uw==
X-Gm-Message-State: AOJu0YxUJcgtkGW4YwYzMQllkAj5eBwcrCrIfxDsbBXCBny/MmxvZLKA
 KIgmV00lkduz86t5iOlWpRiiU48r5w7/ktY5qb3a34Iosd8spODSOni+VEQ/vWnUz38v385Ctgl
 K
X-Google-Smtp-Source: AGHT+IHMNWc0aCjvuL5SKuCH2G4gkI0IdDsBXAqqpToxg8v0WrjsEdua+j8hYDW9NEQs2GKbBiKgiQ==
X-Received: by 2002:a50:cd9e:0:b0:579:d1c6:1647 with SMTP id
 4fb4d7f45d1cf-57a1797ba60mr1482707a12.42.1717080843680; 
 Thu, 30 May 2024 07:54:03 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578524b5898sm9988661a12.82.2024.05.30.07.54.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 07:54:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] target/riscv: Restrict semihosting to TCG
Date: Thu, 30 May 2024 16:53:48 +0200
Message-ID: <20240530145349.41309-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240530145349.41309-1-philmd@linaro.org>
References: <20240530145349.41309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Semihosting currently uses the TCG probe_access API. To prepare for
encoding the TCG dependency in Kconfig, do not enable it unless TCG
is available.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
index 5f30df22f2..cbafbedaeb 100644
--- a/target/riscv/Kconfig
+++ b/target/riscv/Kconfig
@@ -1,9 +1,9 @@
 config RISCV32
     bool
-    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
+    imply ARM_COMPATIBLE_SEMIHOSTING if TCG # for do_common_semihosting()
     select DEVICE_TREE # needed by boot.c
 
 config RISCV64
     bool
-    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
+    imply ARM_COMPATIBLE_SEMIHOSTING if TCG # for do_common_semihosting()
     select DEVICE_TREE # needed by boot.c
-- 
2.41.0


