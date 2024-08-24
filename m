Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BDCC5472C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 04:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shiqI-00009T-Qb; Sat, 24 Aug 2024 00:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shiqH-0008Vp-VJ
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:38 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shiqG-0002KP-FU
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:57:37 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5d5e97b8adbso2179331eaf.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 21:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724475454; x=1725080254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaqkhcr8XXVjz3AUT5s3kLltD+ErMtVDTb6FVMqoohs=;
 b=JZypJInpXhZXa2ZQBbBl960duu6640MH3fEtRa6uf5dOLGNf/713oTmjiiPWjQYVaY
 R6IPWsq367KINwXpSR5A1gbOxZu0kpvufuyksP/DacgCQfGxBBrIBXYCvZEoYuIVL9K3
 A4Ba6qkrryZnrrBYfE1x73KRqasAWff7ucDKJqhLziQnTTyLNhOuztyVkstWNYyVv6hz
 9QI9Qt3ZWPYcGghfo5DGJagj0Os9TK5uukK9sQQg/oTHRVRhcmRBoxDJ9bt3SMN0w9bC
 SrN3gKyyCyM6FzYdDQyneOoGrHfFZm7coAPitMwYS0XpbqQf6FZkAsbtMnktu4Tv1Vq0
 RLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724475454; x=1725080254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaqkhcr8XXVjz3AUT5s3kLltD+ErMtVDTb6FVMqoohs=;
 b=Hq83ViyC2aaTGzSsz+XiMqPTV5RH48Xwi7d3Vb1WHc+L9FwRg2wMkB3s108LWmhY8E
 FBmQ1/L1mFkTb+9HkRixRPu9YK+CK5Y9UQ+ejypTqtxFsNt69+Xw1FJcMk4oVroSC/7Z
 xVs8Id408nUgcxOoHFl7a+/hr3fgq25k7cRejrRaIuto5YAfYl/edOqShQIo514opnxg
 ntHZgqjUz0B/Xf06zdhaJz3uyMNuUHOGM644G7TZg5Q24EyJLPTfLAqR+OGWYXOWZA03
 RWRFZ1apIWxmxL/S6zREKkDRC8OTs5MfO79WsW/+bagm8eFWyaMe4kWEnw8zp+3b/Han
 ct1w==
X-Gm-Message-State: AOJu0Yz/Hj6ReePBcXXlbycH37nw+wBIXLSGgAV/s5Q21osU0XW0B1YH
 orjyMIfrN7bXgQiX6Eob+12uIZRllgcT957LE7EYyjV1XyD5vyjYpNEXOr0djLA=
X-Google-Smtp-Source: AGHT+IE+35AgkpQlQG3YkgB02rLXb0ZrTFB62eAO5VINgkswUXRn08sERGZyVIXapb5b9ZyQlL40YQ==
X-Received: by 2002:a05:6870:330d:b0:261:9fc:16b9 with SMTP id
 586e51a60fabf-273e6620ea8mr5520395fac.33.1724475454028; 
 Fri, 23 Aug 2024 21:57:34 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422ecedsm3805934b3a.25.2024.08.23.21.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 21:57:33 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 17/17] bsd-user: Add RISC-V 64-bit Target Configuration and
 Debug XML Files
Date: Sat, 24 Aug 2024 14:56:35 +1000
Message-Id: <20240824045635.8978-18-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824045635.8978-1-itachis@FreeBSD.org>
References: <20240824045635.8978-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=itachis6234@gmail.com; helo=mail-oo1-xc35.google.com
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


