Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC204C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqT2-0006lC-G6; Thu, 22 Jan 2026 03:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSX-0005Ui-Sz
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:40 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSV-0005wW-AX
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:33 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4801d1daf53so7569185e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072063; x=1769676863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T0NIoP5vj7+UtH8d8OaQyAaqLxRNAQHUjCqlru2rVG0=;
 b=JOqkeOqyIDYhNS6XWSsw1UwvOReaUppzErNv65ArEhax0vR1O8pYpdbpY7eznFxmd/
 Odx4Wt0sAHq+P9Ji140/P2EIKIMKYgFjRTbCJG/gXLRMF76XhTV7AEE/XzPQ0HYnriGG
 /j0NV2eLgZ5XGrfOO/Nx+Ywr8pIjNBl4u3m+p9UnGXYj2NUaM9tGO19HbN/MvtV2IkKb
 kgDciCiUoR38tMfq0witjzQ3LJMJaBn9P2h6l59fNIt95mAo4FUfEj43LIV48998hPTe
 2N0/D5PL3v19Y1Lwre91Mi64NTcT54tsvGaA2l2Pa/IlLzM7zncqYIcJmUtkbRc5rkGR
 P84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072063; x=1769676863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T0NIoP5vj7+UtH8d8OaQyAaqLxRNAQHUjCqlru2rVG0=;
 b=tJdQF6MaEL7A+FL3NGUPkJzkStpeQ3nhC1Q74kk0M3Hj+qZIBwZEQ0uXqPhmXwHqVx
 Mm7gcuVkT4/2h7Cz/tY21bwxXYsq5NxQQLISqtHdbQspIGZ4CvGh3CecyBAmlJ6CLgAW
 oEvw4Oi66CW/PJC3yyDleeyH/uWyFHGmysbiWtk3b7FhiyVWHJB9/l4FnZ5dU7hsZS66
 flamlY0mz8VpN8NT+Pff6HNy5lZGUS3fwZUbrQvIrGSToDMqvgBZczBx5VL01hOnF/o4
 OthHeoJa606CEa//akrtMDT3Z0tW5sMW2lL0HYCtqw7ytcznhO9GvGxXz/+oNJA+bJby
 lIVg==
X-Gm-Message-State: AOJu0Yyc3u92sWPEmCmJpSM4FFXPnR1hE5fuyeAfiLRQDp9v1Z1f3W0M
 oEoxJvG2X08N7m+s160smc0UItDyirwzMYQNOib4yyxuSIdJZAs40WJKYtUW6TBCwoBM63Gu9wN
 1fmZQCps=
X-Gm-Gg: AZuq6aIIPBNgVOdxQFnbLzzHYTFHG1z5lYTbQQ85eF0zhAHu0bOq8PVTlj3AVuDZPCh
 9Nj+eI5bCN2K9s+gIw2wr7CpGRkawi7oqY+zoXWnIUuTh3V9gxjm4gAfN2i5LRNKcInTbFpn/4y
 5+SrDmy7e8VS2m0IteeYoNAffsvciWnzEXTlySjRLzRpnltgf/wKy557K2J2waICnKPm2c8/sxi
 AdNNorndUXrJ2ZPqbtIcoiTxHzeN8nysQSl/LMpHSb1e2cNljXIuHDOWLTU51WMpic3X5IH/OGJ
 rGnj4eJssVbKzz2v/O6rpD9xcPz8NBrZAJKm/2ldMb76OVmMFgVztErJQYLgAA/h4sJmCBynxmt
 ZVwTLqoOA6EebLD6qQ5lVQSVd/166bNp3Lfwn9BRzI7MK7gRjhxwJ9E7mcZF9dZPpNrSsXUC76Y
 EHBhuqCoXnM9/qNp2qkvi8eJMzaOty0Uhrxt4wNfHICFHuIEWWlogOm5NWeMI8
X-Received: by 2002:a05:600c:35c6:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-4801e2fdf57mr324732635e9.10.1769072062921; 
 Thu, 22 Jan 2026 00:54:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804706ef6csm46267305e9.15.2026.01.22.00.54.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:54:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/31] system: Allow restricting legacy address_space_ldst()
 native-endian API
Date: Thu, 22 Jan 2026 09:52:36 +0100
Message-ID: <20260122085255.95035-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-16-philmd@linaro.org>
---
 include/system/memory_cached.h   | 2 ++
 include/system/memory_ldst.h.inc | 2 ++
 system/memory_ldst.c.inc         | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/include/system/memory_cached.h b/include/system/memory_cached.h
index e0ed54bd1eb..6eb6179140b 100644
--- a/include/system/memory_cached.h
+++ b/include/system/memory_cached.h
@@ -80,8 +80,10 @@ void address_space_stb_cached(MemoryRegionCache *cache,
     }
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_cached.h.inc"
+#endif
 
 #define ENDIANNESS   _le
 #include "system/memory_ldst_cached.h.inc"
diff --git a/include/system/memory_ldst.h.inc b/include/system/memory_ldst.h.inc
index dd1fb482eac..896550bdd65 100644
--- a/include/system/memory_ldst.h.inc
+++ b/include/system/memory_ldst.h.inc
@@ -25,8 +25,10 @@ uint8_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
           hwaddr addr, uint8_t val, MemTxAttrs attrs, MemTxResult *result);
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #include "system/memory_ldst_endian.h.inc"
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS              _le
 #include "system/memory_ldst_endian.h.inc"
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index ebb441f1a66..a728b7737c2 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -105,9 +105,11 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val,
                                              attrs, result);
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #define ENDIANNESS
 #define MO_ENDIAN               (target_big_endian() ? MO_BE : MO_LE)
 #include "memory_ldst_endian.c.inc"
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #define ENDIANNESS              _le
 #define MO_ENDIAN               MO_LE
-- 
2.52.0


