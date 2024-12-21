Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153A0E77184
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 05:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOsJt-00032X-DU; Sat, 21 Dec 2024 00:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <davidsondfgl@gmail.com>)
 id 1tOsJr-00032O-6n
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 00:46:31 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <davidsondfgl@gmail.com>)
 id 1tOsJp-0007s6-Nz
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 00:46:30 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21644e6140cso25387595ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 21:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734759988; x=1735364788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REbKrQEg1WAfMUxdXCsYduhWwMfqG/uN1u1AmzwOqik=;
 b=JSmKXs/TJvBkNmkPWor5+QFlkfXYgB04uKmMynSkZms++qpOGIkga80o4Nv50PgZtg
 ZFApOMwKd+NXHqhNc8RA7ey+jlU7xvsadMX3mpg6rIy6EoXBW4ooDZCmBtCR8pAgW4kH
 v051AOQqIENSh7YsxDyu9+sQhQywZYlr0Eq8Cp75oP2wXDCsja7maObr1wkOrC5VSCZz
 2Nw2+A0TntpX10KSKCSDHsTRBnJoFmixVTUJWJnYJI1yWOKjxc03+hnv8+2J3aGMN9Nk
 5c9EhdaAczbepEtu0gE3jIaRKdVax5Eq1krlDAygBgOV2P4prR8IG/CR0Frttj3Eaj7H
 f0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734759988; x=1735364788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REbKrQEg1WAfMUxdXCsYduhWwMfqG/uN1u1AmzwOqik=;
 b=a4kQ13vyVcnG3qYTMcE0Tu9e0PQYtH4IOoCLDTbd53vJbBFSvWZEzyJ7Y6/urOSxX7
 BqjNGWJaAFNtSXKEnDiHK6xHY6JtluOX6M9KDf24SZV8tgAPO0LSWRcLjn4ATBBJXAFF
 hTsmBOIGk9kGfisHsNvCpVq9pMgSsZ5Oqd6tcp8rP+4kmUgrdbK5xeUdFU+as9DPPXsB
 V8KGkdVpIpTMcodmBGHt5HdxcwWJqKhNZb616Fk+bMOM7qLu8njU8+hON6Plj/T9NlAE
 c+e7njIA/My0Qhv3qwfky6Nayg2bCQ6ZsVVD5tYPnmeSdnRWD0HZuVOhDRCS/HIDJqUE
 isqw==
X-Gm-Message-State: AOJu0YyyiC+LXYtlaOA3SZzf4kHAkq/MvwjLhwxotmnB2PW9vsuNu+W4
 lunmmsgb20o39k40xyqP1QIvNl9m36G07f00eHpSVHmoBM8gaovnsOnkkqno1Vw=
X-Gm-Gg: ASbGncsfsVsL5kZ5fOjNIc4HI0H04DEc8vaVDNSbE6KDI6REH/Jlwn6rhM//jGH9g6A
 8wnd/5J1iXRcHSOXHIb343a8GvfNYHBy+TRAsf2AQRnawNi3+5MJWZFWgNWUuhi0dzwAlA+7ocI
 gpEuo9QtRaqgJlwsNEWYYeIJL3KzaB9BXgOm7nRnccvznV5PXtWv2jIZ0ZsjToVF3XY6oKGIolW
 Gjt/WDtk4tTv5kSuhm/0pTbxkaYC0p5WUy5WSSf1zJoscGarKKcmcnJ2oeXlzyMxxDZVlKgkFPQ
 rJSQ8extGsjMijtGG4TTYCzpPXwCYg==
X-Google-Smtp-Source: AGHT+IGPck+Lh+ZjDCt1OZW6v+xDaX4Hq+6rSwr+3oJm1mbxy8BcqGnd76D20urAT+15YmdS/ES9xw==
X-Received: by 2002:a17:902:ebc9:b0:216:7cde:523 with SMTP id
 d9443c01a7336-219e6ed39d6mr87217915ad.32.1734759987772; 
 Fri, 20 Dec 2024 21:46:27 -0800 (PST)
Received: from darkstar.example.net (189-71-161-74.user3p.vtal.net.br.
 [189.71.161.74]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9d4474sm37916405ad.142.2024.12.20.21.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 21:46:27 -0800 (PST)
From: Davidson Francis <davidsondfgl@gmail.com>
To: qemu-devel@nongnu.org
Cc: davidsondfgl@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] target/i386: Improve 16-bit/real mode debug support in GDB
Date: Sat, 21 Dec 2024 02:45:49 -0300
Message-Id: <20241221054549.21883-1-davidsondfgl@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241219013535.GB4298@darkstar>
References: <20241219013535.GB4298@darkstar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=davidsondfgl@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Debugging 16-bit/real mode code in QEMU+GDB is challenging due to
incorrect architecture detection and segmented memory addressing issues.

This patch improves the debugging experience by reporting i8086
architecture to GDB when in real mode and converting segmented addresses
(CS:EIP, SS:ESP) to their physical equivalents when reporting to GDB.
This enables proper instruction disassembly and stack inspection without
complex workarounds.

Note: Mode switches after GDB attachment still require manual
architecture change, as GDB RSP does not support runtime architecture
switches.

Signed-off-by: Davidson Francis <davidsondfgl@gmail.com>
---
 target/i386/cpu.c     |  8 +++++++-
 target/i386/gdbstub.c | 15 +++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5253399459..65bdc48cc0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6404,7 +6404,13 @@ static const gchar *x86_gdb_arch_name(CPUState *cs)
 #ifdef TARGET_X86_64
     return "i386:x86-64";
 #else
-    return "i386";
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    if (env->cr[0] & 1) {
+        return "i386";
+    } else {
+        return "i8086";
+    }
 #endif
 }
 
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 04c49e802d..d600aee953 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -136,7 +136,13 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
                 return gdb_get_regl(mem_buf, 0);
             }
         } else {
-            return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]]);
+            if (n != R_ESP || (env->cr[0] & 1)) {
+                return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]]);
+            } else {
+                return gdb_get_reg32(mem_buf,
+                                     (env->segs[R_SS].selector << 4) +
+                                      env->regs[gpr_map32[n]]);
+            }
         }
     } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
         int st_index = n - IDX_FP_REGS;
@@ -155,7 +161,12 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     } else {
         switch (n) {
         case IDX_IP_REG:
-            return gdb_get_reg(env, mem_buf, env->eip);
+            if (TARGET_LONG_BITS != 32 || (env->cr[0] & 1)) {
+                return gdb_get_reg(env, mem_buf, env->eip);
+            } else {
+                return gdb_get_reg(env, mem_buf,
+                                   (env->segs[R_CS].selector << 4) + env->eip);
+            }
         case IDX_FLAGS_REG:
             return gdb_get_reg32(mem_buf, env->eflags);
 
-- 
2.37.3


