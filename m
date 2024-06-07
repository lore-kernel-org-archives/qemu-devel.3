Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B198C41513
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 04:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFRB0-0004l5-1O; Fri, 07 Jun 2024 00:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sFRAu-0004kF-GM
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 00:26:00 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sFRAs-000514-W4
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 00:26:00 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7eb2db841f2so65492439f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 21:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1717734357; x=1718339157;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/j33GhWtIBI0v34ghg84N3DhwSzzaAp7dsCaoBrlq4=;
 b=Yyi2gcII815T/pAA+1Wjrbeg+l5UOILhLc91hn1PKgvPXUnceOPff0YblcrUon0yd/
 lfPfCxajr4Y7uc45aX8do42fl1tDfg1Nan5i7ESJnceuwfX4l3OF9r/hcyk8A/D3pGyw
 TB7r3DAduV3RD3cTOLfRulDLDb7sPzKrA3RBH64H8oA0kSCMqZNee1z+k+8O7xBFkmy6
 xj6YsfSVy/wRFR2chyMepjGoKNGW/i3cp6/inaR5bKjEEFt7/E/CtJVq9a8p8WyUKaZG
 wjKxwc5BJDSN5j8Neg7DZ3i0uNie0zD9vhtrJYCbvuWyf0hAl69WbyAwbtYV6Bh73UHY
 itCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717734357; x=1718339157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/j33GhWtIBI0v34ghg84N3DhwSzzaAp7dsCaoBrlq4=;
 b=hpk5jgZZxSXn0lbSYoKRDki2CDGy8P00Zl8D67c2srAOcO72c9I6aBBW+zI9Xwcuyk
 w3vMNJkSAadMyef6DS5ZGWEdoIWA5x/3utZlzwr2ldSoqRxJtOfGcI/X5AL/proxb9Na
 GiaIJELz27+Iwj/b9TDu5D/VQcy1uo5gRed+YIT6J50xqO4XbbPU1LsPwSvXAxZl/xr1
 5dfgT+C6INFXOme/EQQ6nOObkdsgGWQwLaszavVtnjzOGL2Mex7w16hT6wYgtuJB8S2d
 gRi2AFtV6EmyVPFzrnqOLOYaZp1aGmmjckal+hWMOUnaR+RMZIa6eVCWRzr1nc5oO5gx
 HK2w==
X-Gm-Message-State: AOJu0YyBo4T4vfPKEtw/CUCwQ3Le6kXVgzhvi7EBO1MGSfIYAXuTljK5
 rZjreZkYT3aZLHHdFptQfg8f1PLru0IFCXqI4hyRNMEoKSA8uDwdRwEHY+qlUcUYFkFoNBgHHWU
 0CQE=
X-Google-Smtp-Source: AGHT+IFJnkYLTSNSLqMkyGCaFlIcBtiiYPjxVRD4xAQ7s7uBR32660iDZgHpZ99lro/Dbohsg8/Q4g==
X-Received: by 2002:a05:6e02:b43:b0:375:fa2:5195 with SMTP id
 e9e14a558f8ab-375803224a3mr19401295ab.8.1717734357266; 
 Thu, 06 Jun 2024 21:25:57 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374bc15d9d9sm6162585ab.37.2024.06.06.21.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 21:25:56 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH 2/3] bsd-user: port linux-user:ff8a8bbc2ad1 for variable page
 sizes
Date: Thu,  6 Jun 2024 22:25:02 -0600
Message-ID: <20240607042503.25222-3-imp@bsdimp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607042503.25222-1-imp@bsdimp.com>
References: <20240607042503.25222-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d34;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd34.google.com
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


