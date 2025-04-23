Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EB8C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wcx-0007qD-UE; Wed, 23 Apr 2025 05:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcI-0005g2-Ix
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcG-0008PE-9B
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YveATmqR4bi/32CuQ7nwLHBxXPQoI2PI/rY8EiGJUug=;
 b=JEEk6Y2EDBO89ao2i7AOGRFpzlgYNFJwKN4g/NuTf1PRDSRy6VBEF5N08OGr7lyo9TkOh1
 /IRaTsEfPoJBbenMWkAVGNymgInIa//m8lASBSVrqSKs/LFHaVYMBwQ51MmYcU/oaGkEUh
 6GiJJ8wpKbh03QRPKa5Eew0Fdw/3Gbo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-rxuLX8uiPUWSYYkdcSOl1w-1; Wed, 23 Apr 2025 05:42:00 -0400
X-MC-Unique: rxuLX8uiPUWSYYkdcSOl1w-1
X-Mimecast-MFC-AGG-ID: rxuLX8uiPUWSYYkdcSOl1w_1745401320
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab68fbe53a4so490885166b.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401319; x=1746006119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YveATmqR4bi/32CuQ7nwLHBxXPQoI2PI/rY8EiGJUug=;
 b=hB9ru7Uvo/oj46UdzDi/dP0H+5vXYMKT3xGGgoTNS6ouz2ksxSVInBn8+YoIZkDqR7
 iGAwwJHrhhi9YcUL76K1YLwHZn7TmjYoTRhhz+EJ4HmIEPfOOBjKPwGfr9ZGDaD2c0Gf
 ZHwGSl2sSe/XOKz6tNDJe5ao24pXHdJPwChUxHLfpFGqRb/NFwdan7E8Vo8sWMbyKUmn
 9Q/liJgSAr+gkeKoCVNoPcD9eNiftwpWQSSS1rLdIOU8gXaX1m2o0s86ZAFji2yd7CzV
 BbiIHs27s2MYSvQp8wAqt6mJERCyYgqnHJDGlCPJrAZ6oOtvB+ns85mVlzIMEEYxUTRD
 Owmw==
X-Gm-Message-State: AOJu0YySt59oEReHMTDaPecOcCL5WKL31Y5cMgkgmMP8MOX5mHRlzBI0
 FdTeAo1R4WgrCnrMQlrW/n91wo76V5p13JKwmmXrnNoTIQiNJAYbqNgXZVY32D2xwwokTf4JVXe
 m52jU0nu9jj2mB1Ky4rrcXk1FTDn2yS9UG9gUhzz3kW1ywKvYPVLr52n20TAOf6Xg30Rva/XBEG
 mCG3JwcMZy40KHGX0yGzUXRl32bOw/FJByTkcd
X-Gm-Gg: ASbGncsrm3pvLRLs8mptXnjDSqw5I8q5uQiscUq+gS4vHOtrpYA7htXygpsmD4HUGV/
 B/JZwB8UYQYMCTLWfc26Gl3JERFfpDcvIAhVAq5J/MK6MPDRVHWSPDxDJLLwRwyYg6XLeIbiTQf
 sHUaejPKaN0PNJIZarA6Ugy7FGy+4rVv/bJsps471Bz9GlORGExKBII3OYj5+crl+KhQ4o85Ezx
 c8LMua6Rm+QIc5tfEex4IxtGUmUmAFbDAvyeLV/NUuQUQ2frJBN+PJSoIVlrDbJ/S9+xyaHxMmA
 ntwAPeA4NkLE+OId
X-Received: by 2002:a17:907:7f9e:b0:ace:3c0b:1951 with SMTP id
 a640c23a62f3a-ace3c0b22efmr206353766b.46.1745401319264; 
 Wed, 23 Apr 2025 02:41:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZFr0D8+8P1z2RLnkWofPleWTY3U2J4LLJhhmrBGB1JfbR8dYmXWirCIOFTz/Jw25/EfSdFA==
X-Received: by 2002:a17:907:7f9e:b0:ace:3c0b:1951 with SMTP id
 a640c23a62f3a-ace3c0b22efmr206351466b.46.1745401318782; 
 Wed, 23 Apr 2025 02:41:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb6ef475ccsm780232266b.137.2025.04.23.02.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 24/34] target/i386/emulate: add a panic.h
Date: Wed, 23 Apr 2025 11:40:54 +0200
Message-ID: <20250423094105.40692-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Wei Liu <liuwe@linux.microsoft.com>

The macros will be used by the instruction emulator. The code is the same as
the one under hvf.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-13-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/panic.h | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 target/i386/emulate/panic.h

diff --git a/target/i386/emulate/panic.h b/target/i386/emulate/panic.h
new file mode 100644
index 00000000000..71c24874ba0
--- /dev/null
+++ b/target/i386/emulate/panic.h
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2016 Veertu Inc,
+ * Copyright (C) 2017 Google Inc,
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef X86_EMU_PANIC_H
+#define X86_EMU_PANIC_H
+
+#define VM_PANIC(x) {\
+    printf("%s\n", x); \
+    abort(); \
+}
+
+#define VM_PANIC_ON(x) {\
+    if (x) { \
+        printf("%s\n", #x); \
+        abort(); \
+    } \
+}
+
+#define VM_PANIC_EX(...) {\
+    printf(__VA_ARGS__); \
+    abort(); \
+}
+
+#define VM_PANIC_ON_EX(x, ...) {\
+    if (x) { \
+        printf(__VA_ARGS__); \
+        abort(); \
+    } \
+}
+
+#endif
-- 
2.49.0


