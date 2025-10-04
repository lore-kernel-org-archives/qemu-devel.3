Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3239CCA472
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wTn-00077G-BP; Sat, 04 Oct 2025 03:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTa-0006nX-2A
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTW-000533-Oh
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:41 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e430494ccso17716935e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562075; x=1760166875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5fuCE2g8uEdvgYnLyt/C6CN2FbGxrhgerrqmN+1Yzng=;
 b=xWwEDg9ienYceFoJvCwHZksAuWgdW9xMykDWJpHqljAl5ccJIyCCt3FL/5UCalTb0B
 BRnl93jPW3xh+a7+gwwKZ3yhha5lgQw9OWEbOr9mEwwmyMg6jXXnU5zfRYX5wY4G2sJm
 WZxYZiLr2nZjsO3MkTk6OGGbsXfTv8m4bqVpZKC0KBEyADbCEQJRpx4Y7bnwxTgF/Eog
 RMLp3sdLuJ6uHWedK34DkQx/aBDBUwE6recAAqdKTU8pOx8zCdZ58zv6+6t5hAbY//R+
 kZ7oYVgTYAHyry0cdrs2SU9F8A2k4JNF9kFil5Nivrf7wBbAe69/b/nYdpQspfnZs1JL
 qOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562075; x=1760166875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fuCE2g8uEdvgYnLyt/C6CN2FbGxrhgerrqmN+1Yzng=;
 b=vpZAA3y2Fb19D3xV45rI1KtZTECkveoGx1Ta4ffb+iZd9Bz6AiFI5x23E7gyb6Q9hT
 jcTCS4p3gbcQebXfs3YWboBcKjjfcKrqmlJrGsN/3qXFJ7gLiS1gH/x14S3DQHorBc89
 S5OsW+nAv1S9Kbl5VWr60mbPhko0fzmR5KLH6h1fCnmY/J6N09oEI9o1g4oNoXiF28XU
 uGkg+9FKyRHxPLTvZ7rxhnVnlp+XMmlNwtHdBgII+M4wrp5PB+mwYW5HZYWu+scXCxoH
 s5hALaP+VT5yd6pkDyCXoF9RuBnkyxzHCcWFeZDKSMrxiUulWaDdUVOBP1AJNKhfWUX2
 Ddeg==
X-Gm-Message-State: AOJu0YxUP0QaS9I70A+iMnm5p0pBAp2ju8mrWkBBAJtcFNSeLEQQPjDz
 kD5C2/T5+EhAm8QztjTJsHJLqrx0QbwDNnLzNcFA03e9ScOEdTrEonRd4R5dpkXxWHA3esAjEQq
 DJ04o0bu2Rw==
X-Gm-Gg: ASbGncvVOug3RXdhobr6epns8cJlAL4qOdfkginQtrvDuthNOyEL1aKGNLeu6Kgodfv
 OhGT+45GB0ZJRgXOzD+0qif3npI4+G0MJhZ36vZokxbYrYwE6Iih5BiaFJwpRaT6mkweq9wKD3h
 FF2Ko/5db5bINPyEE3VkvIpBZwE6djo/ObB2gvRmGVKnav+8PZHbAt+/jJ+RsBkA37meFI1LX1A
 4fnYNTG20cpWQAtKk/1v0I1lyD7XZQXHK5XAUOSdFfPVpcQygi8wYLwZGZhajUaMBM8N+5IkZbz
 pr+Slk4tJDBdpKU6Y1pUH8CZQzbqa9nQpdF3nvZAZhTdZiHlbmiKgg619kKtM0HWUELIuRoxMg2
 MT0A3UmrnrA4rbqZMqAzqdJPAQDLMoV7hNtKYymYKJ2L9UWyGf9A5eDyZfpVfLgL9S+IYUt4Ts/
 4qjWWrq8/IRE6ACOzy6aPicFMA
X-Google-Smtp-Source: AGHT+IENqboDKBZ1Ja9Vy28cPF6QPl8RiDRgmKc92ZL64n2zrfM8/Zj2GtTaQ6gnMazs+Yzko/9YlQ==
X-Received: by 2002:a05:600c:4fd3:b0:46d:d6f0:76d8 with SMTP id
 5b1f17b1804b1-46e7115c338mr36679045e9.35.1759562075226; 
 Sat, 04 Oct 2025 00:14:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723437d8sm61288395e9.3.2025.10.04.00.14.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/41] hw/xen/hvm: Inline cpu_physical_memory_rw() in
 rw_phys_req_item()
Date: Sat,  4 Oct 2025 09:12:44 +0200
Message-ID: <20251004071307.37521-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

cpu_physical_memory_rw() is legacy, replace by address_space_rw().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-13-philmd@linaro.org>
---
 hw/xen/xen-hvm-common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 78e0bc8f644..52e2cce397a 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -12,6 +12,7 @@
 #include "hw/xen/xen-bus.h"
 #include "hw/boards.h"
 #include "hw/xen/arch_hvm.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "system/system.h"
 #include "system/xen.h"
@@ -279,8 +280,8 @@ static void do_outp(uint32_t addr,
  * memory, as part of the implementation of an ioreq.
  *
  * Equivalent to
- *   cpu_physical_memory_rw(addr + (req->df ? -1 : +1) * req->size * i,
- *                          val, req->size, 0/1)
+ *   address_space_rw(as, addr + (req->df ? -1 : +1) * req->size * i,
+ *                    attrs, val, req->size, 0/1)
  * except without the integer overflow problems.
  */
 static void rw_phys_req_item(hwaddr addr,
@@ -295,7 +296,8 @@ static void rw_phys_req_item(hwaddr addr,
     } else {
         addr += offset;
     }
-    cpu_physical_memory_rw(addr, val, req->size, rw);
+    address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                     val, req->size, rw);
 }
 
 static inline void read_phys_req_item(hwaddr addr,
-- 
2.51.0


