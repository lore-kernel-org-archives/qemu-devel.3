Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C26DCF45D7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQjl-0003KY-HX; Mon, 12 Jan 2026 17:50:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQjj-0003At-Mk
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:11 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQji-0002pg-4b
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:50:11 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so3617649f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258208; x=1768863008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m4WK0WCMD/FZzoXl81PVwF7WQ9tvZJH8+XWvkiTSRug=;
 b=xhWELb9Z3ObR6lVEEkvCzRvHgpad+VYQfH0Dw0A6DXeEjCZiZ+IsxVV+o4wGD4UNx1
 ANZegQ0YmFP19hTymHX2Dl+OaaPQA0yLQBFdts03DJJgVMDhRn3UGlkAmiG35AtBvQTC
 7fRBEQtku+uXImd5RidGir41JqBKlOHg0o43HPsijaEgXiwuNfph3swliI68gUxCj8iO
 +l5FqfEoappFkN0B6gHJh1fitney8+nVIWBL/3zpomMzY0axgHR3HtombzNVwEFsl/io
 HwqfgpulOQBZg0z2DtO2QE6rnSErL3aCrIgOn1f5LIUGfQcnrRWLNHdQ8+ip2DxeaoFb
 3x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258208; x=1768863008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m4WK0WCMD/FZzoXl81PVwF7WQ9tvZJH8+XWvkiTSRug=;
 b=aXCwP40wqE/7Xp1glzoDRjoicvp0g9W+1P/NMAmmPDUZkKbwayKg+iKuncFMZfgTkC
 3nyGViipO1UtIHI84J7JcLxFsoYeeKyieRcDTpB4tdY72MS0T0VOaf1Sfgux4KLysTGo
 VxbnJFU0YRLR5iTCJ6KDYUuynMVXB939CvaJxsV58hS7FKI7ojq6jrWWnHGp3Pnd1O0A
 f2/4BXCk1Q1Ew6/hyOXOCBepAJzGiOlIUE/MxH2eA+bg/sPcrAmeAZSH03+jy9aQEPOJ
 bRK7h0ppD7W6FSswyLJCTTcbOJ0v6Yk5F9jDyzcx0vlpWLtzdRHYKRV/wjW5b52Pk2Ew
 KBUg==
X-Gm-Message-State: AOJu0YyNskhNMb1mHem9VhegeTq+KNfFkRN84cJTEbwugiZk7JqkUVOT
 b4xjQHscu0pKdl/F6eSX9RAEXJ7u0CwFblpIeYLKmp5Q8Pa7abC65VWcEQYGQlor1BijkA7qJ7D
 HSSidEmw=
X-Gm-Gg: AY/fxX5yXe3Sdcjad3p0AI5x6xsys+PcHEn8mYQl9OPqlMePSeF5o8nesgTI5DV0+FX
 8R0ZR14gctT3+cAJCvtIAmw7zRs22rkBkNFrRlqjbG10Z9UbRlH+UAB1jfBTg1y8SxG8Gfj/cxY
 C1lbZaG/WWq9FS6wJnmtO/ucRdIi2S9g58zMZo8Mj5YsIG+xW/4lrPmmO+URoySovG0xi6UiRZQ
 REA6qia0iGPgLo8IjheYuLhlCG7pbEqHTrlgH71nCxsHxni01r0wEadKV5skySEJunliT3ivQf1
 q1VFM7d5/z8FZN4gAewodjDSnUGi+nTSkqAs84vTIuAdOrD5Hoeflc9kHzImghgqpVaxVF5x/Us
 4aWCTsh7F0Pi88KvNvHe0KduaPwqxkBvAHY4lZQhtq9qjBiqffCDb8DSzLVEWiNLV+buN3DZs1r
 Qc3cstB+7wyli91/1BrLUUOhIRX3DMuCHmGW/KpqxKOtRt8tghnobrS3S5wU+9
X-Google-Smtp-Source: AGHT+IHiRoQ7uyy1Dvt3Dv/W24GuBItnOC+I+w1OhoaRTp890FBzJx1qXGnXpAeZJHlytsiChKlUbQ==
X-Received: by 2002:a05:6000:310b:b0:431:7a0:dbbb with SMTP id
 ffacd0b85a97d-432c374ff56mr25377391f8f.33.1768258207853; 
 Mon, 12 Jan 2026 14:50:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm38748012f8f.26.2026.01.12.14.50.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:50:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/61] system/ioport: Do not open-code address_space_ld/st_le()
 methods
Date: Mon, 12 Jan 2026 23:48:05 +0100
Message-ID: <20260112224857.42068-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

When a variable size is known, prefer the address_space_ld/st()
API. Keep address_space_read/write() for blobs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-23-philmd@linaro.org>
---
 system/ioport.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 4b94f2f8111..9209bff2eab 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -62,58 +62,50 @@ const MemoryRegionOps unassigned_io_ops = {
 void cpu_outb(uint32_t addr, uint8_t val)
 {
     trace_cpu_out(addr, 'b', val);
-    address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
-                        &val, 1);
+    address_space_stb(&address_space_io, addr, val,
+                      MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 void cpu_outw(uint32_t addr, uint16_t val)
 {
-    uint8_t buf[2];
-
     trace_cpu_out(addr, 'w', val);
-    stw_le_p(buf, val);
-    address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
-                        buf, 2);
+    address_space_stw_le(&address_space_io, addr, val,
+                         MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 void cpu_outl(uint32_t addr, uint32_t val)
 {
-    uint8_t buf[4];
-
     trace_cpu_out(addr, 'l', val);
-    stl_le_p(buf, val);
-    address_space_write(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
-                        buf, 4);
+    address_space_stl_le(&address_space_io, addr, val,
+                         MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 uint8_t cpu_inb(uint32_t addr)
 {
     uint8_t val;
 
-    address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
-                       &val, 1);
+    val = address_space_ldub(&address_space_io, addr,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
     trace_cpu_in(addr, 'b', val);
     return val;
 }
 
 uint16_t cpu_inw(uint32_t addr)
 {
-    uint8_t buf[2];
     uint16_t val;
 
-    address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED, buf, 2);
-    val = lduw_le_p(buf);
+    val = address_space_lduw_le(&address_space_io, addr,
+                                MEMTXATTRS_UNSPECIFIED, NULL);
     trace_cpu_in(addr, 'w', val);
     return val;
 }
 
 uint32_t cpu_inl(uint32_t addr)
 {
-    uint8_t buf[4];
     uint32_t val;
 
-    address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED, buf, 4);
-    val = ldl_le_p(buf);
+    val = address_space_ldl_le(&address_space_io, addr,
+                               MEMTXATTRS_UNSPECIFIED, NULL);
     trace_cpu_in(addr, 'l', val);
     return val;
 }
-- 
2.52.0


