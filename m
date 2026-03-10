Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA921EB1076
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzPk-0003Kx-Mw; Tue, 10 Mar 2026 11:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPY-00030T-GQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzzPT-0006aS-If
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:54:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso30603295e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773158054; x=1773762854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45Z++vPIrHX3TjF4mstsF5/1HCXT+AWsKRxD65WL50w=;
 b=kVxf1PEOiwmapXQWsFFaEXRMdBTfdBE3KKe4U5Kp+C05I3Gv0u2z/mTIUNRDUnAaqB
 dG9VICCftfgAk9OliT6kL1tonDxfOvoKI1hem4rIMV+0SrH1LSlMqnij6Q8ZJnqJfmVB
 HtGEd8+Ddzbx0u5y1gapUB0SH5wc4uQ2JxyWXNUx1k6sIyH3VYT3nm7Kj1JtwvZlxvXA
 d2SuimjzY0mxp+QpPx+O7R6kFusbwrDqP2J/o4OHREo5uPRZIelpVvmJPO3XUzPXb4mj
 pGCHYfmeuo/RETyOa2d3SO+hY6t/CS5s3GzhhMLCs2LJ52kcXycS+XLbt5bCTVq10xrO
 SsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158054; x=1773762854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=45Z++vPIrHX3TjF4mstsF5/1HCXT+AWsKRxD65WL50w=;
 b=i6rYlWbQjcDMRX20lvCrdhXGoUf9FHZjQotlIpzI65mkGp8zmtnZ55hcOKs0aSn+hW
 KUhZBZYX2qyG++roPP9DXfiyyp8ZF5RQADgVdKUDEA0dkKkJ+ERSvHJ7nPHg3nxzdmmm
 08B3UZYNd9V9mmOrzpU59zrLOtOX6R1/flVBH55qA5ezbja+ctVIBy3LdGMhscxIWeuK
 zMSZRDSgHoTpsatLkvOAVDtgX1rf3mpaM05eBZA4WIXGObHx3Xk+FTJ1yap8D89KL25W
 r3OlFOHaapkJSlXLGcTIXraWFR/vrSSi4izNWpDgpMm7om50wpMz4CmPepxCdFmgmmak
 Cm+Q==
X-Gm-Message-State: AOJu0Yz2/yhGZQgnJWaXAidFx5uo+b6mfz7NYCrAqceDPql78Td6bqv3
 Tn3yeuaKzKFQ/e7qxq93XW9BE4rRrwFU87XMJkrAJfWYxf92afFmLAhJqd/K6635nzg3myejHiS
 8ckfJxmU=
X-Gm-Gg: ATEYQzwNZ7MHSt0csdtK3o5dA0Hcoi113A2/WRfF3v0VS04fiYXWDjrXCIxw9BlRJ8B
 +PxpbElp3NyZsdjbZB6UtrSOv40g91FHjeBv7rfKA6ngEE0AgPBz/tu/BWb0dgYuGH5Xb5a3DUJ
 2WTQDoUgxt54s9jHEKt8KLlGuLMLBdfPReqFNfQ3i8CkFwMyGdn/Vckh4h4732MV4RCn4e2/Car
 1QmJ+aIuV36o7XgeSXLwESBTnxzs7ie1MHRrd3QJwuAfOVnzYfLO6zoHbhJZe5K6MAnmvjcfTaS
 J1BYwtmof5tlJQMxi1G6PjHnSQ2UHmL+P8hMiTA0NGxqCm2Tbq74CFdhHgFMHLnPOsZ/AXP5H2L
 0t1s5HoCd5fZICZ5uavkfWCXE30iOs+/dEB2/tS1vRh38BwqXRXK3nYxhrBwz0VxiD5RlXp43w7
 SkkRTm4tSlm1lkcuRvwM45RaQfXMEqjdp7MifNlocKN7+F7L91fTlKkaowIXzO2QGNMudKGvg2
X-Received: by 2002:a05:600c:c117:b0:485:2f6a:6ed with SMTP id
 5b1f17b1804b1-4852f6a07f5mr166398385e9.28.1773158053600; 
 Tue, 10 Mar 2026 08:54:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aba60esm87225255e9.5.2026.03.10.08.54.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 08:54:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
Subject: [PATCH v2 06/13] gdbstub: Make base register explicit in m68k GDB XML
 files
Date: Tue, 10 Mar 2026 16:53:22 +0100
Message-ID: <20260310155329.48772-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310155329.48772-1-philmd@linaro.org>
References: <20260310155329.48772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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


