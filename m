Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139CEC27C55
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 16:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGLqS-0002vO-1q; Sun, 09 Jun 2024 12:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sGLqP-0002uE-FE
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 12:56:37 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sGLqN-0000vc-Gx
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 12:56:37 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3759a6423a6so3981235ab.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1717952193; x=1718556993;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJYt42UkCG9pSrAZeGw/ivMlzQ7uAl4WEIfygl4y5Jw=;
 b=YORn0eoSEAHkCcWGYmftiATcsVFnC3rp+ClZgaWaQSlZJyjWCCKFZAs/PeZVGCCIUD
 BC4gpQ39QtUq8jeJUBQc8Msj8HCWPjaZxYHl1SOc77HGAuq+RIsCyezZGJN02Klqix83
 fj+oD0g9zEEO1/8WFuwKTUemnqu4g2nZqnvUUzC/QsysNayV5Dk1Co8nOzUag4kvEOHS
 DDHBI0f6Pzp5SzxJ7HvhKLv9vZw6fglXVq77qRVoIrMGi+wd6nW/dDmcA9U19uIVdH1t
 VWxgDsiact/yPiooVW13NFm4NwnaekOz/2WHHBQZYzFB6ORD0i+tPXBV7tiDnebRbQvq
 0gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717952193; x=1718556993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJYt42UkCG9pSrAZeGw/ivMlzQ7uAl4WEIfygl4y5Jw=;
 b=wlzUVW5ZGsQIxZ/y+CmaVFqr2otk46VlybuUzqpTprjWfXUsoatHX8rV5YmZFi7SLF
 DKw5De15Vg3UX5qXM9H8Q9P+KTJSEVcARCClWt4EMFPmVgH3kx7W6jE8TtA+9SmMClwZ
 br4cB03K/Fm37vr+uOq558ugmCkIU9ahMl0U8xuvCy5S2tT1VcgeYcOwbRdnjvz82Dnv
 ho3WFpfLVbC4oPwDJTW4oP9ujOmH65U20W4/7DczKzMTgG+j482vsrYpkLsgOW0xBlQR
 fRljm1TQxsFu4Huv8k79vIbvPYRJD+gz7ANvtt+aCHSnWljGBfeoYrbVnNZWuUAblhCt
 hLMw==
X-Gm-Message-State: AOJu0Yyo3fFxJN/5c6FBjvq8x9ZULU+VQtDL1m98G5pFDnK2JBjRz9ti
 3pki9MIu9fHpt6teqQo4ObcBK7igdtPCKq2B93C3LM8LT3LpJoakekxfZ812TyTW54aKPs1eB86
 ePZc=
X-Google-Smtp-Source: AGHT+IHzd6pRE7hCKK7taodEpWSfj9g3SjZTkyxC5kfe63RQMzPAof9+PoDAHRWKRhRQzaYOj06x5A==
X-Received: by 2002:a05:6e02:b27:b0:374:aa87:bcaa with SMTP id
 e9e14a558f8ab-37580314d52mr91161805ab.14.1717952193058; 
 Sun, 09 Jun 2024 09:56:33 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374bc1c82d4sm18891715ab.80.2024.06.09.09.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 09:56:32 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PULL 2/3] bsd-user: port linux-user:ff8a8bbc2ad1 for variable page
 sizes
Date: Sun,  9 Jun 2024 10:55:56 -0600
Message-ID: <20240609165557.52555-3-imp@bsdimp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240609165557.52555-1-imp@bsdimp.com>
References: <20240609165557.52555-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::129;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x129.google.com
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

Bring in Richard Henderson's ff8a8bbc2ad1 to finalize the page size to
allow TARGET_PAGE_BITS_VARY. bsd-user's "blitz" fork has aarch64
support, which is now variable page size. Add support for it here, even
though it's effectively a nop in upstream qemu.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 29a629d8779..d685734d087 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -46,6 +46,7 @@
 #include "crypto/init.h"
 #include "qemu/guest-random.h"
 #include "gdbstub/user.h"
+#include "exec/page-vary.h"
 
 #include "host-os.h"
 #include "target_arch_cpu.h"
@@ -291,6 +292,7 @@ int main(int argc, char **argv)
     char **target_environ, **wrk;
     envlist_t *envlist = NULL;
     char *argv0 = NULL;
+    int host_page_size;
 
     adjust_ssize();
 
@@ -476,6 +478,16 @@ int main(int argc, char **argv)
                                  opt_one_insn_per_tb, &error_abort);
         ac->init_machine(NULL);
     }
+
+    /*
+     * Finalize page size before creating CPUs.
+     * This will do nothing if !TARGET_PAGE_BITS_VARY.
+     * The most efficient setting is to match the host.
+     */
+    host_page_size = qemu_real_host_page_size();
+    set_preferred_target_page_bits(ctz32(host_page_size));
+    finalize_target_page_bits();
+
     cpu = cpu_create(cpu_type);
     env = cpu_env(cpu);
     cpu_reset(cpu);
-- 
2.43.0


