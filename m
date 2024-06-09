Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654C0C27C65
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 16:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGLqT-0002vw-Im; Sun, 09 Jun 2024 12:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sGLqP-0002uP-N5
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 12:56:37 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sGLqN-0000vg-Rb
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 12:56:37 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3758fdbd2daso6928675ab.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1717952194; x=1718556994;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEhu8GM1157Qc3Msyh5LPqHzer+V664PIF9A9S8sV0c=;
 b=sBLQ6/KdWVphCHCHUybiUBldhGzNYz9ikZ4OZYHpU0UvE4EL8onrEAZ//rj2PjSh/n
 k5OPZbiGhxqhe5GMSHsx4QckWtRp7LMQe3KGNbtL+mJF+NgrEHgwWQ8UAm3D0V75pNSl
 b+fym0Pi7nVV/Gp38lH3Jns2rGSr6mkN2bZpP7QOKN5tPRwSZyLjrV47fZ4bsvJJYHZB
 emx0uLvuCRn+V3E2zwpqlqFA7mSMzW8GJWdTVkLHbPyWZXkOk1thnwV0ifpDZiN8haQj
 K0H3br8Md4otE44f46ee6GbYIoD//TPnokHt832xTqQpL4sm5l3aqR5JGHCWoX0IjgKR
 uRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717952194; x=1718556994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DEhu8GM1157Qc3Msyh5LPqHzer+V664PIF9A9S8sV0c=;
 b=VnomH/11Bd5QNVPZmTy0uKT4hzIQb1siM0E7e7FPxkz3Qz7qsde6Kt3Un1i+uDbkjZ
 LJlCvnJ0C0oJBdN+ftbRIHpz7vsHQzMnq4LLKZHfWU+Jj3tihedTYudxhNhLLqG1lwon
 vxsVBDTzA8hf/jyfQz+ckvrMNBjQrS/lbE0INTg5NiNacIEXiuZL/a6/ihi9yzBfH76r
 TQKnX/CQ0oMe2me156UtRwtCKmCe+Fuutq+opMQTU8rCNDaSVuSMDBX9d7r5gZgD0iX9
 iA1NNPIL3NC2zr6pIxjC7S4jogOdFv5ln3S/MdD+ZR5qeS7astG81mkjh28kF2xE2HYj
 cqlQ==
X-Gm-Message-State: AOJu0Yxt7XBZFYy8jczzI33B/qJmbHseIeOjpFYty7ABLoZQM2Fq+DGB
 0VmMz6h43QTxjIGwFzUdfDS+eT+wikmSg6ErCAO/AP5xPLaIDk2VLRtReJtVF+Ii9PrxMCV/9On
 3oo0=
X-Google-Smtp-Source: AGHT+IECiRnsti1SWZU3P63wwX1+HGDEo6b9gPoGrL2luIk/ntqm5uDwxjXbcpBpqQpsKr3Vm0IZng==
X-Received: by 2002:a92:cd81:0:b0:374:aa60:a5c3 with SMTP id
 e9e14a558f8ab-375803bf248mr88838905ab.28.1717952194395; 
 Sun, 09 Jun 2024 09:56:34 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374bc1c82d4sm18891715ab.80.2024.06.09.09.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 09:56:33 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PULL 3/3] bsd-user: Catch up to run-time reserved_va math
Date: Sun,  9 Jun 2024 10:55:57 -0600
Message-ID: <20240609165557.52555-4-imp@bsdimp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240609165557.52555-1-imp@bsdimp.com>
References: <20240609165557.52555-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12f;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Catch up to linux-user's 8f67b9c694d0, 13c13397556a, 2f7828b57293, and
95059f9c313a by Richard Henderson which made reserved_va a run-time
calculation, defaulting to nothing except in the case of 64-bit host
32-bit target. Also include the adjustment of the comment heading that
work submitted in the same patch stream. Since this is a direct copy,
squash it into one patch rather than follow the Linux evolution since
breaking this down further at this point doesn't make sense for this
"new code".

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/main.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index d685734d087..dcad266c2c9 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -77,25 +77,16 @@ bool have_guest_base;
 # if HOST_LONG_BITS > TARGET_VIRT_ADDR_SPACE_BITS
 #  if TARGET_VIRT_ADDR_SPACE_BITS == 32 && \
       (TARGET_LONG_BITS == 32 || defined(TARGET_ABI32))
-#   define MAX_RESERVED_VA  0xfffffffful
+#   define MAX_RESERVED_VA(CPU)  0xfffffffful
 #  else
-#   define MAX_RESERVED_VA  ((1ul << TARGET_VIRT_ADDR_SPACE_BITS) - 1)
+#   define MAX_RESERVED_VA(CPU)  ((1ul << TARGET_VIRT_ADDR_SPACE_BITS) - 1)
 #  endif
 # else
-#  define MAX_RESERVED_VA  0
+#  define MAX_RESERVED_VA(CPU)  0
 # endif
 #endif
 
-/*
- * That said, reserving *too* much vm space via mmap can run into problems
- * with rlimits, oom due to page table creation, etc.  We will still try it,
- * if directed by the command-line option, but not by default.
- */
-#if HOST_LONG_BITS == 64 && TARGET_VIRT_ADDR_SPACE_BITS <= 32
-unsigned long reserved_va = MAX_RESERVED_VA;
-#else
 unsigned long reserved_va;
-#endif
 
 const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
 const char *qemu_uname_release;
@@ -293,6 +284,7 @@ int main(int argc, char **argv)
     envlist_t *envlist = NULL;
     char *argv0 = NULL;
     int host_page_size;
+    unsigned long max_reserved_va;
 
     adjust_ssize();
 
@@ -493,6 +485,29 @@ int main(int argc, char **argv)
     cpu_reset(cpu);
     thread_cpu = cpu;
 
+    /*
+     * Reserving too much vm space via mmap can run into problems with rlimits,
+     * oom due to page table creation, etc.  We will still try it, if directed
+     * by the command-line option, but not by default. Unless we're running a
+     * target address space of 32 or fewer bits on a host with 64 bits.
+     */
+    max_reserved_va = MAX_RESERVED_VA(cpu);
+    if (reserved_va != 0) {
+        if ((reserved_va + 1) % host_page_size) {
+            char *s = size_to_str(host_page_size);
+            fprintf(stderr, "Reserved virtual address not aligned mod %s\n", s);
+            g_free(s);
+            exit(EXIT_FAILURE);
+        }
+        if (max_reserved_va && reserved_va > max_reserved_va) {
+            fprintf(stderr, "Reserved virtual address too big\n");
+            exit(EXIT_FAILURE);
+        }
+    } else if (HOST_LONG_BITS == 64 && TARGET_VIRT_ADDR_SPACE_BITS <= 32) {
+        /* MAX_RESERVED_VA + 1 is a large power of 2, so is aligned. */
+        reserved_va = max_reserved_va;
+    }
+
     if (getenv("QEMU_STRACE")) {
         do_strace = 1;
     }
-- 
2.43.0


