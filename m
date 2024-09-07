Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6746FE6FE47
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 03:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smm3F-0005kd-TO; Fri, 06 Sep 2024 23:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzv-00045Y-W1
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:31 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1smlzs-00056R-Rf
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 23:20:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2068bee21d8so28855175ad.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 20:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725679222; x=1726284022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaqkhcr8XXVjz3AUT5s3kLltD+ErMtVDTb6FVMqoohs=;
 b=HMzZB1a2akFzQ7pwRMTRFaghctca1ea3oHSxSjsKvfsKU7CAPUhUe6kiUABzVPROUY
 Y09fgsngMfOeqFw+9eY4OymiRecHAILdnmIZG+R9adGjV5So05pJW9Pgb6PAdXQb0Bv8
 6NioB3N3fSuMWhgrPcuZ0viyh8zy4S4zskzm0vtge/xNnV9vivzfQPhu+l2I+2S65/5O
 i0Ui43mOcRxjZGG930XQpq9CjmUGR6pguBsLJBTFGGDAqhr+6tIe3jA/0FguXcDqiKt1
 QZKH/DlDrqZlx6tMc8YLIkohWpHmSsXqCH31MROgEYH7Hqn5+C7abj8LpC8BkSYMC0y2
 TDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725679222; x=1726284022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaqkhcr8XXVjz3AUT5s3kLltD+ErMtVDTb6FVMqoohs=;
 b=upLE1VfZyT8o4nKx5uf6/lVSPdAM5ivgcq/JyZoyanxqDGGjU/oXdKEivMGXSipZme
 5gE3Xf07pgVXeGrdorNCqVgIEbAjCYj8UARDWiE2UWMhyxByUzNa6NdrmFV/TfM3mw0V
 3Ffk3VhG+3H2Twbwhv/jZ4qV4CwlJUoxCZ9r1sYCyE6AWdl0eCR2n7gl7S2dGMsTv4Rg
 TlYvaEZpSJTn9ZgOCTKR67TSKcUKpLoRpXKJ/HBBadEDgDNO1QrVaV4joWMEGBufzPo2
 MFBOLAci4r1VDa5tBdM+8FQFeGFDwSltq42ayj/eWN6qZVVsBdXGGFkxE4wLUyxM293x
 d4CQ==
X-Gm-Message-State: AOJu0YxtlvK/Q97c/Q2hsgkwWpVxb9lUZhMCA4xqs9DDKrmiEtmjYAAE
 /vU62vNOhTlVk5T0ZZFeXydNlGb6VMO4tjZzqH8bD7O1iQuHua8nE7LBlA==
X-Google-Smtp-Source: AGHT+IGUyBMcYb40djbR1sequ/+q/0Qj6iSvwbWh0IgiybVrIVuR4iceyYyDAU85+GDriSos2Bc5dA==
X-Received: by 2002:a17:902:db12:b0:207:1570:13e8 with SMTP id
 d9443c01a7336-207157015e5mr377305ad.12.1725679221530; 
 Fri, 06 Sep 2024 20:20:21 -0700 (PDT)
Received: from localhost.localdomain (115-64-160-35.tpgi.com.au.
 [115.64.160.35]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1d4c6sm1703745ad.187.2024.09.06.20.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 20:20:21 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 17/17] bsd-user: Add RISC-V 64-bit Target Configuration and
 Debug XML Files
Date: Sat,  7 Sep 2024 13:19:27 +1000
Message-Id: <20240907031927.1908-18-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240907031927.1908-1-itachis@FreeBSD.org>
References: <20240907031927.1908-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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


