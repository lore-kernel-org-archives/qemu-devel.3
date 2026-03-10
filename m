Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70981FD88C3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05Hb-0003cg-Of; Tue, 10 Mar 2026 18:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05Ha-0003cV-M7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:10:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w05HZ-0002N8-33
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:10:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4852e9ca034so37170975e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773180627; x=1773785427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=45Z++vPIrHX3TjF4mstsF5/1HCXT+AWsKRxD65WL50w=;
 b=QgRn4z7UHDFNYXasuO3hbTj40lsU0VLw4ChIqX229YvZ2RovUdPGU7+HJWQjM+PdMe
 cSAvdNU7SY2drHGKvKTt26zjTuwJ1qrBFl4y9WXuiqhqemSSDRbww5AgU0/+v7m3hdGO
 owQ5n47vH/w+LJ2URX1NN1J3qaMlLemGcBfXDCw25ul+yjhrD5WqCoZO1uSnaOoiEbG7
 YCsEfzCW/7h2Kn88iEeI9tYLns6Ai267jictKovjwbjnqqd8INoBR53PbNto5fBttn4S
 sUcVETsvv9un6iV6tlvu/MAo9WTkcQ1PU41mB1qvEl5STFIzo4+K9EWanvXyro3fCM5R
 N/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773180627; x=1773785427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=45Z++vPIrHX3TjF4mstsF5/1HCXT+AWsKRxD65WL50w=;
 b=fmDSOFldxUrnDgQKfs3ICgRkhBrFIhXd+Xj91gXYuoqVDHsDvzQrs5JLKL0YIPpa51
 oWDTNzQR4oOYz+dHrurR2PT3AQGMtcPzJ2Tf2yGz3f8X8gM4v5sJn+0iF/E4xaD9w5S+
 jY/qy8EhxQl0TVyk9dFgGi9GzLWA3dbrH1WcDAlbHDT8kHxggm3+i9zafiuQxwfIDUAV
 RkgPiyyNVXJSBV9EejKIvjrNSUp4MB+v2ws1gJ3IpIhStFov8vCX+1fbrE+sJCJYJVbV
 NDKnH69bG64ogVD6oH2LAGQ6uPbVEZG4kESqd/NecAzw8Zz2Cs2KdzuUq1rNUJQGK5tL
 0AHA==
X-Gm-Message-State: AOJu0YxtR/zfWh85EeIcjaBMZfB6rnvI8GubZqDNVia45PMSKuR7Tejz
 CPV6wbG9lcHcegInzQHxIfvYrM4vEQEg0sR+jn+dXjP9ZfWICXeedny7e+UOecmFzOuzSdbuka3
 PmRP8Ce8=
X-Gm-Gg: ATEYQzz9naQjpw2XSJgVlAsjqOrh+wnYxtrQjpN7nUYU8D2PF9C1rFLbR+pbhFCQLEa
 g4K6+Ko0Y3L1Etlt4vmz1nXftj+jaHaBfVW4l2r2RYM5zzpQfdZUSTncIj9MdwiP1IChUsqxUnd
 LNso/2uAKjEnVJcABWRyiGQ1gCMYeyNL5OzTMjfQ7cHxintF5PDdzubvww941rsT0FglXadzZFa
 mcg2rbzFjNm6gopmFHKxPQOgD5ECKLC51NI3Zkac44J2vYhaeZY0uRTrm2DZAKedPwSjDa/dB9n
 HWEX7sT5SCmY2A7txAFhbbAiczHy3EXVSd8WG8YqzocMIfoPljKzGyju/cZLP0CKB+zSRhGwXwE
 XelJobuWMqFh1UTWAh8aYLpjWIJTM1ZoNMQhTEnuf+oXBCiV42bQMkQ7oJ0A689+xI8QVw3kcA7
 fwXHWPLojw7xSEjFKdaqfM7q69b1zJK0z6UX8oXOL6JaQAb/V4wSykIBryda6mYpCHe4oRpjoH
X-Received: by 2002:a05:600c:8b0a:b0:485:3ae8:2236 with SMTP id
 5b1f17b1804b1-4854b123cd6mr6063875e9.32.1773180626934; 
 Tue, 10 Mar 2026 15:10:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b8d4easm117918415e9.15.2026.03.10.15.09.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 15:10:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v3 06/12] gdbstub: Make base register explicit in m68k GDB XML
 files
Date: Tue, 10 Mar 2026 22:59:09 +0100
Message-ID: <20260310215916.55815-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310215916.55815-1-philmd@linaro.org>
References: <20260310215916.55815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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


