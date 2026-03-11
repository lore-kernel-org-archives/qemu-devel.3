Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D613FD88D9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08XV-00042V-Kh; Tue, 10 Mar 2026 21:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XL-0003ya-L4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:39:00 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08XJ-0004qJ-OB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:38:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so60584625ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193136; x=1773797936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rzIZT+O9WouNnlbZw1uqmZ1dd0NGIjRk4rEHgD+bYRU=;
 b=Wp6lknew2uYst5zyLgPhrzu/3IzinyREA2vDqhqLHNNnMnreIJRprx+KRimn4Z8HVt
 5ZaWLK7XA3+67qGmNyL+NUQpTYSphHtS95hOkcWcszut7PpwRk+2nGKR2kWJjVh33QsF
 4XKjBMZm5617aSJ7QnsCuLSeHMGacblgxRclP8wzLVFdbdXvjZ852LokDC9SMV2CXLaV
 HvWzMXVCg4S2CLrt7IqVoxvKCBsMI+DOq30DSttuJptFos37mWwqrpL7nqesGRxo46mx
 aVjSQuL9/4mjuw0Q4X1DPzOeEfFpG1NcodbjBHYVyzIbmjLA7/05x1MYFqCDBe3rdt9X
 Trkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193136; x=1773797936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rzIZT+O9WouNnlbZw1uqmZ1dd0NGIjRk4rEHgD+bYRU=;
 b=L3UEtF3405qje+SF7zASoHyzRNu9i3HxhtSKDJy5XWZNRiyhQaqAxFoytLSTHzkYCN
 b3++HRfR8cFMXqje8tRi2x4SAYSH9x4r9+2X+cq6M/WpC0r3goZVzS/RufYBpy2JT/tZ
 A5G5cQjY99cl/R4orPycKR/oeQP9zpUqPyVxKIhQnE5WlXw0M3/octsu1fma8wKsG1RP
 m8SeeLDlttJZhCNa1Ca9E72Uk1momPbleFIdn7Az0GmnWCDbMzCMCoi+aRbcycqwAKdx
 6rdRXUhegfKgBfFW+nfxRmU8hOjq7bUmQy1BJ7UcoaC/3Jz6tKziWgf9UWkW/S8mIn4s
 q1iA==
X-Gm-Message-State: AOJu0YwsZwRf3YCKgr22bbjp6IDebbYX8lp0KCcVNOiUWFbHd3lhabYc
 lAd1vNd8FIFVOXYcYel4vOj3x4zIdQYPsFjh/uT0grX2a7o7AQViFBCDxch3FLVNCdxQUPvHjLc
 ZMDeP
X-Gm-Gg: ATEYQzzb+PjX6kIZadBvlDLMRXHJ2I053l4CrzhD2QwXkASSn3rLF6UDi0g51YPREuh
 jfoppYMDhk/6Hu2otmp9R48rwGUMjCh37vtxRLEl+Y0FIF8ofXR6UCixFPiJtD4NtN4LGDLHNAq
 FuYODKXDb2P/fS1NAf/KY1ESZlJDsmw4EB0Bc5zZPzEt5svRnQkCwprWUnuiaSBVpWSJ9I8KPw7
 ikHny8SF2dUhR/oWt4fy0lQb/4VC1bC1xABgbUyoQX6gQENNBxS41SWROlQUIZTKRK6iGnYsrCY
 Mb+0BVnAyC4U06dmNi09HIwqUk7BVfNW6DbbjBB/Ef+dQZZxsuZ6yTsRB75bvbXe43MWl/4MjED
 ckrAMvvmhN/eR1p7UNF1HUt9zhOgq1R9Jk9r7VGQEL5cYl/GGk84O3nDINiYQZvmj4LNvo38pHO
 ushrEzauP5ENleIJDAw7yWunE1TZKR8Vqn3756jaOYHPj7Kft2VzqnX652XBKZZoPj0xN7OzsOs
 VFD0UwbOt7mDe4=
X-Received: by 2002:a17:903:234a:b0:2ae:5f65:171 with SMTP id
 d9443c01a7336-2aeae8720e0mr7240695ad.33.1773193136295; 
 Tue, 10 Mar 2026 18:38:56 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aeae2466d3sm5390175ad.22.2026.03.10.18.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 18:38:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 09/16] gdbstub: Make base register explicit in m68k GDB XML
 files
Date: Tue, 10 Mar 2026 18:38:30 -0700
Message-ID: <20260311013837.69945-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Both gdb-xml/cf-fp.xml and gdb-xml/m68k-fp.xml aren't imported
from GDB repository. Presumably they are hand-written, and lack
the @regnum XML tag.

This might explain why gdb_register_coprocessor() have a @g_pos
argument, only used for these 2 m68k files.

Fixes: 56aebc89167 ("Add GDB XML register description support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-10-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
2.47.3


