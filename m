Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BCAC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 16:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHR3g-0008BI-L5; Wed, 12 Jun 2024 12:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sHR3e-0008B1-Tr
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 12:42:46 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1sHR3c-0001EP-Ka
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 12:42:46 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3737b47c0acso36185ab.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718210562; x=1718815362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N003PrPmAhjPYh7joxXcoLTZxO3o0vP2cs9r7k+a9L8=;
 b=QPxCb8NmEt8VOiClKs6cRHL7NZrkxsLDWXSEfebzpTvt+ruaGyoS1vpYauSTlwnwtZ
 UtuOmk+qiNdB6e3sw5X4ZrGk04fly2vvAsHnLwHVwl2xk/Mjgyo4J5LjeNt+tVg4hvna
 eOqrBftj1kmNt5StdO4pRaJ67h/MfswDxKGicQlHgwOh9N8qzrt6Z6UWV5YX/F9QGzRz
 VPSuAEE4vsZp2BhUZo1WqRP3mtlR6qxdEdFhA4kYm/44L7u2mdMd4n5vsW844uxgk+jk
 7RC/uo66jCnCWiO8w1n/yQ5EvgQYryb0qidSPdzMTbkbfAeAZZxq10Uwu0ZFC29fsGEt
 1yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718210562; x=1718815362;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N003PrPmAhjPYh7joxXcoLTZxO3o0vP2cs9r7k+a9L8=;
 b=GV0DYJpIXqP9VJ5bdvCAuy9wi14rnGvS0LxDrBb5cK1JbnJTQ2rByh5uKBEaaKDxhv
 tWDdN5IE3yXIRNSr7x0pmB9UE7asXGnYgi88O10P3QZEOhIrr5eYcI7NzgLuIHlXCjKa
 6jkgTjMRSQTmV6t7LZaLOy7OsJ5xTCba9yJ+4W4H8J93Z+UKBJiBXYvs4ezJHqfJNgAh
 YFzdtCyF5PIPOK/MerWUG3JO49FCAtJnZv3p5w9i1uOIebbBUgRJnTM/0/LnIzal2BSC
 uePBZCR9xgEuPA7H6+eFSVCK6GVnxCDSl80vQJKxxYwycSZSByUtGBWUPeG5LF6BN8vE
 Kw/w==
X-Gm-Message-State: AOJu0YxWI6dM4KCvIz90XFwkvJmDk7lWe+C3WkvxSi5kMoWe/3bqZOiW
 jV8S1M2kFqPcjgzd7t/SsGvr7RWNOjwXjykvKsIyUZYLDHIfdfMU+I1teiOn
X-Google-Smtp-Source: AGHT+IEt/TmRsK+ngXGYthOEzU46yqjEzz6lZkvVpqSHD2ROzTi8lFefxZmrgAuII/BQykeoSkK02A==
X-Received: by 2002:a92:c54b:0:b0:375:b567:a69f with SMTP id
 e9e14a558f8ab-375cd14a530mr28282645ab.8.1718210562105; 
 Wed, 12 Jun 2024 09:42:42 -0700 (PDT)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-73-169-12-54.hsd1.co.comcast.net. [73.169.12.54])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b91dfed8c6sm1600847173.6.2024.06.12.09.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:42:41 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, tedwood@quicinc.com, alex.bennee@linaro.org,
 quic_mathbern@quicinc.com, sidneym@quicinc.com, quic_mliebel@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH] Hexagon: lldb read/write predicate registers p0/p1/p2/p3
Date: Wed, 12 Jun 2024 10:42:39 -0600
Message-Id: <20240612164239.90276-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

hexagon-core.xml only exposes register p3_0 which is an alias that
aggregates the predicate registers.  It is more convenient for users
to interact directly with the predicate registers.

Tested with lldb downloaded from this location
https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.4/clang+llvm-18.1.4-x86_64-linux-gnu-ubuntu-18.04.tar.xz

BEFORE:
(lldb) reg read p3_0
    p3_0 = 0x00000000
(lldb) reg read p0
error: Invalid register name 'p0'.
(lldb) reg write p1 0xf
error: Register not found for 'p1'.

AFTER:
(lldb) reg read p3_0
    p3_0 = 0x00000000
(lldb) reg read p0
      p0 = 0x00
(lldb) reg read -s 1
Predicate Registers:
        p0 = 0x00
        p1 = 0x00
        p2 = 0x00
        p3 = 0x00

(lldb) reg write p1 0xf
(lldb) reg read p3_0
    p3_0 = 0x00000f00
(lldb) reg write p3_0 0xff00ff00
(lldb) reg read -s 1
Predicate Registers:
        p0 = 0x00
        p1 = 0xff
        p2 = 0x00
        p3 = 0xff

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/gdbstub.c | 19 ++++++++++++++++++-
 gdb-xml/hexagon-core.xml |  6 +++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index 502c6987f0..e67e627fc9 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright(c) 2019-2021 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -36,6 +36,14 @@ int hexagon_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         return gdb_get_regl(mem_buf, env->gpr[n]);
     }
 
+    n -= TOTAL_PER_THREAD_REGS;
+
+    if (n < NUM_PREGS) {
+        return gdb_get_reg8(mem_buf, env->pred[n]);
+    }
+
+    n -= NUM_PREGS;
+
     g_assert_not_reached();
 }
 
@@ -56,6 +64,15 @@ int hexagon_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         return sizeof(target_ulong);
     }
 
+    n -= TOTAL_PER_THREAD_REGS;
+
+    if (n < NUM_PREGS) {
+        env->pred[n] = ldtul_p(mem_buf);
+        return sizeof(uint8_t);
+    }
+
+    n -= NUM_PREGS;
+
     g_assert_not_reached();
 }
 
diff --git a/gdb-xml/hexagon-core.xml b/gdb-xml/hexagon-core.xml
index e181163cff..b94378112a 100644
--- a/gdb-xml/hexagon-core.xml
+++ b/gdb-xml/hexagon-core.xml
@@ -1,6 +1,6 @@
 <?xml version="1.0"?>
 <!--
-  Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+  Copyright(c) 2023-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.
 
   This work is licensed under the terms of the GNU GPL, version 2 or
   (at your option) any later version. See the COPYING file in the
@@ -80,5 +80,9 @@
   <reg name="c29"              bitsize="32" offset="244" encoding="uint" format="hex" group="Thread Registers" dwarf_regnum="61"/>
   <reg name="utimerlo"         bitsize="32" offset="248" encoding="uint" format="hex" group="Thread Registers" dwarf_regnum="62"/>
   <reg name="utimerhi"         bitsize="32" offset="252" encoding="uint" format="hex" group="Thread Registers" dwarf_regnum="63"/>
+  <reg name="p0"               bitsize="8"  offset="256" encoding="uint" format="hex" group="Predicate Registers" dwarf_regnum="64"/>
+  <reg name="p1"               bitsize="8"  offset="257" encoding="uint" format="hex" group="Predicate Registers" dwarf_regnum="65"/>
+  <reg name="p2"               bitsize="8"  offset="258" encoding="uint" format="hex" group="Predicate Registers" dwarf_regnum="66"/>
+  <reg name="p3"               bitsize="8"  offset="259" encoding="uint" format="hex" group="Predicate Registers" dwarf_regnum="67"/>
 
 </feature>
-- 
2.34.1


