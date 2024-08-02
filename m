Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFCEC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkx-0001vQ-G0; Fri, 02 Aug 2024 04:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkw-0001qp-9y
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:22 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnku-0006mM-Gb
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:35:21 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3db16b2c1d2so5501923b6e.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587719; x=1723192519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/c7XPXCGphIQcWf9DM6pYQS1OQlMPuogQElOCWHT9Q=;
 b=brJoU8mECo9LGSeyRiHdDCk6e0lYkLf/KTHBZdhpe43jXEyovyG6T0x0r/YCbbLEr4
 93B2z8N+2KxMHt0/Ii34fbGUtVHillJuaT4yTmBlyH9vgYsmrRyqsdYEgm22ceoxugL+
 MxSGVEHvSNuXWzyaSExzkxvtlGQ66EqPZjyinVlQddAXiIPZhBlasKjTfyxWyHtXIicu
 qgZMXYyXQeZdWvCwrsbIsQajTVba4S+tn378C8xyY6tuLTXMJdvZAa74VIqOe6d/UfCL
 nDFwwAv6lSK8jzVXChLKj0tn3bESZ60Zwc5tfR6q+uTUX+zTd/mtevdyJX4LHyjDu8UU
 EXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587719; x=1723192519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/c7XPXCGphIQcWf9DM6pYQS1OQlMPuogQElOCWHT9Q=;
 b=BestxiefyEvDLop4Uw8uCYq3hIliFJB0dnutAZuwwjYDvZ7MpNAGLl478b3F1z6Xyq
 KpOUKYp2OW2KiuUNzjdbdC2RZ24mIuwIF7kOuJyMzitdrKk6wr9gIsdknpEdKRqwEO6K
 ht/5gxnX2gOSFwhuwbQEl33LsVVsbXovu5nrslcXjjyrCgFph3Fuhpc13UwhZgo6VS5J
 k0Tyayxzu8NpI+9qO0KlZqqic0pLGIxNcSO+c8fQmgdzB3YUWpc4QXNKAxDlNnzcfBe3
 0tx94e/P1lcDbBIzbwb1IB4auN6zHx5f6RyGJUXd9xffWIxSOYUGAIiP3yQew4HuGKtW
 z8Cg==
X-Gm-Message-State: AOJu0YzmLwAep1cT0SXCEk8uLAadA94w+g/XLkI6+h7JXzW8IQ2xOpXf
 4Ov26sORH09PSwP5H5pJvSWbLORf/UP0S7iGOXIfBIZBTwV+O0hmMlBVlfKAxOk=
X-Google-Smtp-Source: AGHT+IE4B2z66dlStDzJhfHcDP54JjZEW/FzE/yfrOxG8aajSbi3qz96Wk8yh2kOXPs0xOW1l7Cx3w==
X-Received: by 2002:a05:6808:302c:b0:3d9:2373:e75d with SMTP id
 5614622812f47-3db55830825mr2982065b6e.35.1722587718902; 
 Fri, 02 Aug 2024 01:35:18 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:35:18 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 18/18] bsd-user: Add RISC-V 64-bit Target Configuration and
 Debug XML Files
Date: Fri,  2 Aug 2024 18:34:23 +1000
Message-Id: <20240802083423.142365-19-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802083423.142365-1-itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=itachis6234@gmail.com; helo=mail-oi1-x22c.google.com
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


