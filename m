Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9532FD88CD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06Ok-0001QB-Bm; Tue, 10 Mar 2026 19:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06Oh-0001Fu-I3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w06Of-0008KW-0X
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:21:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so3263363f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184910; x=1773789710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygQ/v0cdpGrwH8lnrmi7lhlM+ablab0Z37ZCJxHh2pw=;
 b=T4qnvzg0NYPQk4JUkUEYxnWt2CABXf06gpMQJyceGNaH4Wqt2uoMkAAZCI5XooWemn
 zPv/efsNaX5gXAEJo+Dpb8nRniW+YuXslbPk3PFoZ/TXy2MSfnbxe9P3rQpS2ecSmG7x
 f+Gxli1vrQkCMree2VzcgwQog9TXiP8+jv27KrKKaKiQRnulhHoNmJKjETwQx6lAvVrU
 0r7Cqkf9xabAaY7saDLxNFyHxCiK0sz7N2p5LksaTVBJMJ8GHHISKeS2vqy1XwnWdkI8
 7+XgnpNlDWdpvXD7xRyjNZb+rrv7aoCDtfakwuhHHOjIH7zImUAytWk1zLSLWk1gof2N
 Q+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184910; x=1773789710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ygQ/v0cdpGrwH8lnrmi7lhlM+ablab0Z37ZCJxHh2pw=;
 b=PfGsqlFtrqbdNHj/D9sC2cEdAf79+HQ6rSMiSrX38HJ3Bynm3falLfLI21BJPIs/Wu
 BP7GPbgMRDWRX9AGXk+ldK+C/kAYMpHFTcHWEFjfZwVgpW2PggazeptAChcpTROSIZ1P
 XCDPx9Y68hjkv6XnGwSEQZP8zZ+2/MG/Grm5QBqKI9OgOIAO8DRMi71FDBgGjFZCE0dS
 +5296GdyTwuAG2zHgj1cik8rsxtQGhbgQggODMfFnjjjG1CWni+V62BHmCiSLsDzUkOf
 ZVuOns5Fwx+slEK7BbDkCFlhu1qrwhOfDWAO80f3BGi+Sld0NKUIDkQnwUFypuMC0IbU
 ap8g==
X-Gm-Message-State: AOJu0YxWQAgyZEOX4X/6JIJ5zXDxGseCIjUVqQCSjJJtwv2fHyTTN6cU
 iiOLcCiHf4q0jydH4V0Zz+vL+hZ6wZwxGYwqKiS4kbHUwMwtRKGl1moM9ZqtV7wa9hnMmqpsPp2
 MflOK3X4=
X-Gm-Gg: ATEYQzwUPdW+oU/f9BUTfWDaW1erd3GcHI9zjXcU89UmEjRbZQrwSJPSLiSMufcmyUp
 lDqlfU3ixtxk5ZJXDI2NQp2kdxqCz50MF4n9+OHkLHYXoGsNPRdn7GFVwyloQRFGnpnAhudGptq
 LlPvq2TEjvkKvO57N+sfzqoAUpwsnz7CeYPTsu0OovNBAucxpG1n04Yfhy9clzNDhoYHDhypfM6
 76uqgMCJC+hXpNbkG8p913Yaw81rP0dFLOJiU5OmkUC3fy3BQ53jAINnhYazZR7tVZJq80nCHHz
 sGJfFDVKXoZ4z2jg1qsL+LUINS7GcAn+ryuzx69B3+JXi3/NtP8xnvrjg7WjxvyCiq05lusjtWn
 h0zHNYxWyInzS9BSJNp9TlixfvzacLvFvF1lld9K5qY4hlLPR7GgmUPSVd4jd02cxAqEKkP1HCR
 G5X6XEy70V4hqkUBXQOIi9u83ogCQ2/AMSsJc3LOZGY3RYwLLktlrcN9VA4uXEcRBp9KcnBC0Nu
 2BtLMTVX7Y=
X-Received: by 2002:a05:6000:2c03:b0:439:afcd:b629 with SMTP id
 ffacd0b85a97d-439f843c3f9mr1084952f8f.55.1773184909937; 
 Tue, 10 Mar 2026 16:21:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81f1357sm1603724f8f.19.2026.03.10.16.21.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 16:21:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v4 09/16] gdbstub: Make base register explicit in m68k GDB XML
 files
Date: Wed, 11 Mar 2026 00:20:37 +0100
Message-ID: <20260310232045.58440-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310232045.58440-1-philmd@linaro.org>
References: <20260310232045.58440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Both gdb-xml/cf-fp.xml and gdb-xml/m68k-fp.xml aren't imported
from GDB repository. Presumably they are hand-written, and lack
the @regnum XML tag.

This might explain why gdb_register_coprocessor() have a @g_pos
argument, only used for these 2 m68k files.

Fixes: 56aebc89167 ("Add GDB XML register description support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/m68k/helper.c | 4 ++--
 gdb-xml/cf-fp.xml    | 2 +-
 gdb-xml/m68k-fp.xml  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 15f110fa7a2..c566cb0a16c 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -129,10 +129,10 @@ void m68k_cpu_init_gdb(M68kCPU *cpu)
 
     if (m68k_feature(env, M68K_FEATURE_CF_FPU)) {
         gdb_register_coprocessor(cs, cf_fpu_gdb_get_reg, cf_fpu_gdb_set_reg,
-                                 gdb_find_static_feature("cf-fp.xml"), 18);
+                                 gdb_find_static_feature("cf-fp.xml"), 0);
     } else if (m68k_feature(env, M68K_FEATURE_FPU)) {
         gdb_register_coprocessor(cs, m68k_fpu_gdb_get_reg, m68k_fpu_gdb_set_reg,
-                                 gdb_find_static_feature("m68k-fp.xml"), 18);
+                                 gdb_find_static_feature("m68k-fp.xml"), 0);
     }
     /* TODO: Add [E]MAC registers.  */
 }
diff --git a/gdb-xml/cf-fp.xml b/gdb-xml/cf-fp.xml
index bf71c320bfc..27db66ae963 100644
--- a/gdb-xml/cf-fp.xml
+++ b/gdb-xml/cf-fp.xml
@@ -6,7 +6,7 @@
      notice and this notice are preserved.  -->
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
 <feature name="org.gnu.gdb.coldfire.fp">
-  <reg name="fp0" bitsize="64" type="float" group="float"/>
+  <reg name="fp0" bitsize="64" type="float" group="float" regnum="18"/>
   <reg name="fp1" bitsize="64" type="float" group="float"/>
   <reg name="fp2" bitsize="64" type="float" group="float"/>
   <reg name="fp3" bitsize="64" type="float" group="float"/>
diff --git a/gdb-xml/m68k-fp.xml b/gdb-xml/m68k-fp.xml
index 64290d16306..ec45931b673 100644
--- a/gdb-xml/m68k-fp.xml
+++ b/gdb-xml/m68k-fp.xml
@@ -6,7 +6,7 @@
      notice and this notice are preserved.  -->
 <!DOCTYPE feature SYSTEM "gdb-target.dtd">
 <feature name="org.gnu.gdb.coldfire.fp">
-  <reg name="fp0" bitsize="96" type="float" group="float"/>
+  <reg name="fp0" bitsize="96" type="float" group="float" regnum="18"/>
   <reg name="fp1" bitsize="96" type="float" group="float"/>
   <reg name="fp2" bitsize="96" type="float" group="float"/>
   <reg name="fp3" bitsize="96" type="float" group="float"/>
-- 
2.53.0


