Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05889C3ABA1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 15:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spr9W-0008Cy-GV; Sun, 15 Sep 2024 11:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr9U-00085q-NI
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:27:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1spr9T-0008Hr-85
 for qemu-devel@nongnu.org; Sun, 15 Sep 2024 11:27:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2053525bd90so20691915ad.0
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726414021; x=1727018821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaqkhcr8XXVjz3AUT5s3kLltD+ErMtVDTb6FVMqoohs=;
 b=bRLhdGUYplXROMulrjDNF1zV3ewkQdnztkHD7W4EVX218qOcKO4GrjrNu++6dvm1ZL
 Evr84EqDeKt5bZee3czEbmC9vYLfX/BrUMdi0xWCjPj9qnbayv5rjdZSe9DpHB6yfBS2
 HRur6XHKho/Eo51TVdJx+AgNKgUB/P61UnT3FeCo+Hj9pZJYLAlo8FKRDBG5uqRXTTT7
 UQX2PEVosPbLMCZGgpxFbJUPzaPgjEhz6mK5rJE2YG13CSbXCpIn3zQMAIdci9YBpy+V
 TKkgnZibUgspNSmDmX5+o3HYPhEXO1LB86WD0kTUhB/XGf8eWnxeMhnIes4fCs7XXnll
 X1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726414021; x=1727018821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaqkhcr8XXVjz3AUT5s3kLltD+ErMtVDTb6FVMqoohs=;
 b=qM1rBwwheVd96JzYcxt0+Xuk+jenDSkq+3mP9zbzImPAffcxasPUXw3Szt9rQhHO2V
 x2Ln2zF2FfTyEh8XLjzsV9adc1KOEP9ukuxMhE9Y47VT9TlNBVioedkLvNBPQiQGdXYR
 RCY/QKqUaect0GaRXmnGuUIDnTyXxvVrCTvyxKHnu1N2NH6Q2ZWE18P3z0heXo9AABW+
 FhL0hMzxXkAm91Id/YbSiNBoDzoIzoNs0M9ZuDjXdcH8rqOs72vRauU0yzSgjHQysheh
 1nY2Gq+2It7/hmrhwy8AejOSG5iDLsNI6QHJpJ/4SgSzJS0WZhj1WqTBRNcWt1Beq2Vt
 X0EQ==
X-Gm-Message-State: AOJu0Yy2Zn/Vz7PxFddPeMixAUf2rHFZaEuiFyqOIPjZf7zP7VF9BJI7
 vMfYaovxOtBpFxDjvvdLr9vVSJH1QBUHKN0xsIqR0Sw6H5Bho50G73ESHw==
X-Google-Smtp-Source: AGHT+IF0WRb5M1/22dLzA1ljr710dtsIz0J1flgFKOQ5gLw2EjtyT020wvuLM0xjg3HY/z10CPItHA==
X-Received: by 2002:a17:902:db05:b0:205:7cae:4d29 with SMTP id
 d9443c01a7336-2078296b277mr132856665ad.48.1726414020908; 
 Sun, 15 Sep 2024 08:27:00 -0700 (PDT)
Received: from localhost.localdomain (14-200-149-22.tpgi.com.au.
 [14.200.149.22]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207946f34c1sm22554335ad.184.2024.09.15.08.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:27:00 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 17/17] bsd-user: Add RISC-V 64-bit Target Configuration and
 Debug XML Files
Date: Mon, 16 Sep 2024 01:25:54 +1000
Message-Id: <20240915152554.8394-18-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915152554.8394-1-itachis@FreeBSD.org>
References: <20240915152554.8394-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Warner Losh <imp@bsdimp.com>

Added configuration for RISC-V 64-bit target to the build system.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/riscv64-bsd-user.mak | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 configs/targets/riscv64-bsd-user.mak

diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv64-bsd-user.mak
new file mode 100644
index 0000000000..191c2c483f
--- /dev/null
+++ b/configs/targets/riscv64-bsd-user.mak
@@ -0,0 +1,4 @@
+TARGET_ARCH=riscv64
+TARGET_BASE_ARCH=riscv
+TARGET_ABI_DIR=riscv
+TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
-- 
2.34.1


