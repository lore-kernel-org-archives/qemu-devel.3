Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BA3C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0TT-0007Nb-30; Fri, 16 Aug 2024 13:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0TP-0007Ac-Oi
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:47 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0TO-0007Qa-4M
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:47 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70d316f0060so2333944b3a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828244; x=1724433044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaqkhcr8XXVjz3AUT5s3kLltD+ErMtVDTb6FVMqoohs=;
 b=IiVxSPaWOdiB5pSlwd4b/cK8ASi6eGxVLE2EvQfqzULdbWbpIatFVqScLCjVsd60jl
 pkgVTTUJP5mUyqnCndpimk+CYOtXPRjaVi4fTED9i8Hp4w2t4vU2MheugIlLweyNNeSO
 HIa+IEI/vPG+yLFIjbEHz8aaGDQwF0BjPt667aaHyX6DYrE7lk48ipyWfruzqeWKq/38
 N6zuDtkhEzTLzQPgej1oLRbMYANfvUtNyT7criu2b+lWvo7JzcjRLLuA40lBlcaH8ToU
 oh6jPoMJ+Rlh+dmJRT5xCwOM1q4P1GrWxb/NcM1H4rIjHT0kKOlHU6JQRTfIHLKpWmug
 unAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828244; x=1724433044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaqkhcr8XXVjz3AUT5s3kLltD+ErMtVDTb6FVMqoohs=;
 b=ewi3hIGTAAKrwwK4GQwaIqrTG0oCEzxXfUp4zeUesdiM0oQyx5zYV+MxXzHpcWiHqs
 qqIe1Kn8qRZbiXVlfV3wklYCt5FEpNVy75GEPryBdKxPz9Nn5Rw34wKoM+sVVEc78x90
 27/2zO+toK/xEYkbx2exslZ5nVmeIOsRlYWaiao+PfR7RNBMF7iVtdu59JjR+7AVvtsH
 dYP2sEQVLuvt82CqZw145ELnR0UAg/LzmdIkounk2mhoY6+1JqAwN41vk9IoLt36rEsb
 INEUYC8MT1WuO0cm0Dz/1n1spwa7Soh2YKErfsmV8UiSVC7r1e0qi9ImdHxeSv3pHq8d
 I24w==
X-Gm-Message-State: AOJu0YyjZTD6MiQplYMuQPdkauQAm5rQ9jPrNkImI7y7VCG5YurqwORs
 6Hzp5swNWBjPN4gePxwnyNzl213WOfPTEClWXcHRFwQKDADCt9eA9AXwxb7xceM=
X-Google-Smtp-Source: AGHT+IHwOUYQGoaGBeYGTM0yLVdCBxBAy4BwKtU5BVk4lSybcw2q0fKl7lg0punoN2s0CIne36xdXA==
X-Received: by 2002:a17:90b:1083:b0:2cb:4c30:51bd with SMTP id
 98e67ed59e1d1-2d3e45f6011mr4860872a91.19.1723828244006; 
 Fri, 16 Aug 2024 10:10:44 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:43 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 17/17] bsd-user: Add RISC-V 64-bit Target Configuration and
 Debug XML Files
Date: Sat, 17 Aug 2024 03:09:49 +1000
Message-Id: <20240816170949.238511-18-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=itachis6234@gmail.com; helo=mail-pf1-x436.google.com
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


