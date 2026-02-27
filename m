Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E189104891A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5ZN-0007JF-9Y; Fri, 27 Feb 2026 16:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5ZL-0007IT-H7
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:40:19 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw5ZJ-0001b9-WE
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:40:19 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4376acce52eso1717882f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772228416; x=1772833216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prhn08uOlxPn0rR3qWJNqzjhjl91rkBybWu+Asu3G+Y=;
 b=sStj83LD6lc+HC/EL7+sdGZZDeMnZ9TvhYY+YFk9+Ox8Ce1/ebiDx3X8tws9ia0/Q0
 +qQp/AFCdWI7q2gtbYtsP9IVev+tIwJ+GNsrtoplFzcABPt1CgZelw0626rc/oGMZlfF
 6oiFSsFgcFX2Vk+93ZvxM42iS+0GJI8/vyIEdgOQ1+NF5IOXB85eiMB4/QrbIpcYFOxS
 YpvL1Hv64h/CQArUxyRHn/9yyrIBpwu/iEzfTntnMIFXikTVjpP4UQDSFx+vmVF+N2bK
 eqFfNTbgsAj6X490DbITuNrkKBd0j7xSOWcaSGdAv67BlpMxikViGvbFlodZInZgckmO
 X4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772228416; x=1772833216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=prhn08uOlxPn0rR3qWJNqzjhjl91rkBybWu+Asu3G+Y=;
 b=jGUda3mI1SyLnSAIhDPEf4NSsgV+ib4WmTruwuHdD9zeElwMYrOtHBtsozLJ57wMSf
 8Ko1hPXBguJ8kGHvhyCI5EQg7DPaV9Tt8P5XrdjyQVhaP93s3q89hmu51T6NtyF9CAY/
 V+iX3YTBcuSizPZH+QEfCBIh6H+ZlW0fQ1u8R/hFyICGxn9gN3Jog1vZfwZ4svn9LlRt
 1P7L0cXGx1vMRBtlN33G07zOb0AfLGQ07TAxPxJIYu06nAPanirKqjzFu9VhDeSs6D8D
 BsgaI0qqCCD9jfpHRyvgh0cwuUgvnwV2l36rmdnHDrThDOWFDu2SYJs2sJEjkoKqmN70
 dYIA==
X-Gm-Message-State: AOJu0YyLn/08JNzTv5Tqas3tKVB3m8387U9jQA2B81l348f9z7tFetBS
 rM164eQyTCg5z1TtW0kr9scEtZOTQrrSCotkQPMrb9+B2hL2I7xbbQQMaVypCu2VrgNRUYLTtCH
 iHgzsnX0=
X-Gm-Gg: ATEYQzxfYS+6VcXDe841F4QbEJY71jDZhkDOmMuucU94bIpw0j7F+sWT86Tui0/d5Pu
 q5n6GrsCBDLKgvdbighYwS8NkQLbRQwJ+q43rd/eU2YacyHRDTMlCviZi22AKB58q85Jb0wtsPz
 7qUhOrsEIEPJJbAJ7rEyWX4mEgecXlUD44xoXvPkH9XVNX2RHjhgqRuPkNM6tH0Z8ogH3S5n2Qa
 yKqR6P33aSDqR2RG0+JjKfhruXpED7lNTM4c3k6M9+CUsu10Ztf7fJ7HAbssni5l7zdGZDKtD/l
 c83K1ugsig80FmU5eLU/yursqHxBfgQn6cS4JhrxJHwvWCPbIanVbjZT8B5aBx+g7Z+hfLoiDWF
 ZbMiEEnlTjQhMOUxyllqgrQRnK3J5Y3vvXSSj/xfxi9f19l6doGWMiNvWh+g9YykVVI5nUoCPRs
 fb+Rif8l3eNgq0Gxk2kCtZIRqO98OlUyqG4AyZxL++9zhd+/1l52oXaJJVhSScf2f3jsajojIO
X-Received: by 2002:a05:6000:1841:b0:436:30e1:6c1 with SMTP id
 ffacd0b85a97d-4399ddd88bamr7341511f8f.5.1772228415929; 
 Fri, 27 Feb 2026 13:40:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c76b40esm9115275f8f.36.2026.02.27.13.40.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Feb 2026 13:40:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH 2/4] gdbstub: Make base register explicit in m68k GDB XML files
Date: Fri, 27 Feb 2026 22:39:56 +0100
Message-ID: <20260227213958.21170-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227213958.21170-1-philmd@linaro.org>
References: <20260227213958.21170-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.52.0


