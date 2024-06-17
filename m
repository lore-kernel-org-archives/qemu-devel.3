Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD05EC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJHZF-0005v4-3l; Mon, 17 Jun 2024 14:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZ7-0005EM-Tu
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:53 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sJHZ4-000519-My
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:58:53 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5ba33b08550so2187045eaf.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718650729; x=1719255529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXCAWBNkEFL7RtMWqPmqBDwDa9EwuUs2bp+eoNQh6Bc=;
 b=EAhUfXnRT15utVQeZavQjJzStymB9ZeIxuMIOTE34/Thz0/dxS9BjY5/DABxO9SI3Y
 i2eY7Y2HHoKa20lznccn5spjmFOO8F0NDAifDirwIjCK7qJ/UEd1CdMqUAs4wiKRL7/v
 uY/L11fwdHx835s7DLaPFbAKTB5VoZEw/kmhwoMHpzfkmxHCma7Ie+52bQI4Avvk5N8Q
 +r8dCQmU2Do92lGsYwJkcBQJLdY7gjcePJykYZm52/vCOaO+Uqeiyds8S3tIUTT4UZzx
 pCXQ0wc2oxGlesul5C1b1sHZXUUYY3xum1cC7viJxTSOUBXwDC4vtz9cpUwW44lwb+0x
 bedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718650729; x=1719255529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KXCAWBNkEFL7RtMWqPmqBDwDa9EwuUs2bp+eoNQh6Bc=;
 b=gX9oXG/vuC1+zRfXDAMIuotugxAFZXIJcE76hNqR10SQobSZhx3KH455ntmo7EIKod
 OUbUxHQAKlZ0tdN81ueUHGIKrF6Xo8t/vTHXcZXikYOIsDRPmWtp2rhbxTqczd0QSiaE
 uxboI4N27BFhr4Z5FLrsN33InGG5P/Z6Ek+tX0GbSlYT+KVfXdWQnIWihT/zVDfFx4LO
 IGDH3vfI0hLV2wUq9I991SIADXHmvT7Aap4Pixc6C/Ltz3YM3AZivtSBjvmkZc/xPyeO
 ULyuoGjxeGF1K46IwsGtsCNUgwauyDxywNiFdJexVKMVSVir83ze6ZVwDF0j+wYilciF
 e84A==
X-Gm-Message-State: AOJu0YyA7yu2+RN1MUhTZwTK7jq2S63o+mg7rn6oLmJj1p7XIYCRbiBq
 beqJzBRMIT5toIhG4lQWaZ4juIuxUIOb+rwgFHVAcoQp3KHDwaDOoCib05h8m2Q=
X-Google-Smtp-Source: AGHT+IHocEAvQVGqvIPHrRScbgVTQEHVre3JJn9syRoleAFMoZNti/IJZodQYbrYZd+hjpaqvMcRsQ==
X-Received: by 2002:a05:6870:a18a:b0:24c:ae57:b4ab with SMTP id
 586e51a60fabf-25842893a0fmr11304216fac.11.1718650728678; 
 Mon, 17 Jun 2024 11:58:48 -0700 (PDT)
Received: from localhost.localdomain ([106.222.222.115])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb4aa4fsm7660637b3a.131.2024.06.17.11.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:58:48 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Ajeet Singh <itachis@FreeBSD.org>,
 Kyle Evans <kevans@FreeBSD.org>
Subject: [PATCH 13/23] Add ARM AArch64 ELF definitions for bsd-user
Date: Tue, 18 Jun 2024 00:27:54 +0530
Message-Id: <20240617185804.25075-14-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617185804.25075-1-itachis@FreeBSD.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=itachis6234@gmail.com; helo=mail-oo1-xc31.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Defined mmap and dynamic load adresses and
set various elf parameters

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Kyle Evans <kevans@FreeBSD.org>
---
 bsd-user/aarch64/target_arch_elf.h | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 bsd-user/aarch64/target_arch_elf.h

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
new file mode 100644
index 0000000000..6d0fa3525f
--- /dev/null
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -0,0 +1,37 @@
+/*
+ * ARM AArch64 ELF definitions for bsd-user
+ *
+ * Copyright (c) 2015 Stacey D. Son
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARCH_ELF_H
+#define TARGET_ARCH_ELF_H
+
+#include "target/arm/cpu-features.h"
+
+#define ELF_START_MMAP 0x80000000
+#define ELF_ET_DYN_LOAD_ADDR    0x100000
+
+#define elf_check_arch(x) ((x) == EM_AARCH64)
+
+#define ELF_CLASS       ELFCLASS64
+#define ELF_DATA        ELFDATA2LSB
+#define ELF_ARCH        EM_AARCH64
+
+#define USE_ELF_CORE_DUMP
+#define ELF_EXEC_PAGESIZE       4096
+
+#endif /* TARGET_ARCH_ELF_H */
-- 
2.34.1


