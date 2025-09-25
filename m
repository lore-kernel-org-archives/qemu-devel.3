Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870FCCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 00:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1aDH-0000mT-Ec; Wed, 24 Sep 2025 20:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1aDB-0000m5-3m
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:51:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1aD1-0002tT-Kw
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:51:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so1323995e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758761499; x=1759366299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zmAsxF8bAB/jwrRMnOPKZsGgL9JiMFdCA0Iuk+iUc28=;
 b=NAs54qDMx9+dawMlWMal9n8VlTlxLsX+eA4O9u4T6KxP1hpTInsSxr7ttLZDyrLqoJ
 mVw/yE3ztSzvV+bGKu8HfBw3DBlH8P++JzxUt0DY+LEFIm+nEg7FRIIaecA+TTdcq1JU
 iWERFrV6Qe+slc0PWDPzwQpLMsalsMvRV64y7dYsO+cmvjvRxqi0yFGnBmr5KQQ5LaWh
 wF4r8QFhsjvwQdsuzP/OhaXkluNkW98becicUH/GhsVkhQmUnPTK/nRoBHTstGt61jfJ
 o5irdUyIKqPOXH2zcuYcfPvG7fGVFTe/LF2cRvH2wUHncg32z/FQ57FQ2KOK5Q9r8nor
 Ph+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758761499; x=1759366299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zmAsxF8bAB/jwrRMnOPKZsGgL9JiMFdCA0Iuk+iUc28=;
 b=pY3NMX2qShjcsmeZSJPbRV24/qDcYnSJd3gLHYFgkZPVYyuPhMqkd4MBDK6SOAZXIL
 6DFGVkyZpAklrU5aLtMN31RvE1GF5Hv7Lt6JuNZij2LCoxoUFI0mSxrvTk3D9IcEYCJu
 39d8c7w8qvkksMheM1WNNzam6tmxrrEkAZDXtITdAUSS/azCNiYEAhLo5dMRumNq0Gl+
 a0OXmmG75cFLdl5modEz/lrtee+o1BvmNBSDhYJBuUjYS255BVxFMAlq9ue+fQM4loxd
 tcdkKT5p0JNJcKoZbzP+mjZ3gUoo+oVx38Ohvsos6OIMEAQCd6x3432P2VadU10QqXM3
 xXTw==
X-Gm-Message-State: AOJu0YyD5+87J04UdBl9ipyh3J8pLfRfqQIJyBOaTyRzM5bqSAX39Ixa
 suvLWUvoWpyWcjFFRgWQT8z48UoYc7r+wQ9wMrLYghYzh7f5Yd0g+suOqSj8hzJkJ1HMGATQBa7
 ttuGnW73Gsw==
X-Gm-Gg: ASbGnctjOYxMXjyCxWzSRVx6W4SyDDr42WpfOBIMWG9hUP0oaHrF/FnyMKOvGzqnHEo
 cnYCeG2apWiMYglnXj58dq2NMDS+M80uMvOJ13nEG7FBbOgCflj4C8BKfxf/fGIBe2I6eyC7f6O
 K6GT/loD25408gRu5y/gZf2Z7S0D1+6H4sLg4huRUDDOEcziLSLg1HOMeDVVTsQ38AZPJ/tIhI+
 eVSql/rbAlnFCwP5a9/mLdHXrTP38+xMlvPJJhzFbsDT5LneoZxqKzxidKH+wz+j0zGB7uttzaO
 NZh+8ogfrtd8Zy7orM3gInvHeWUlpluypltOxidLfXR39WBKOtwpUKRsmLg15tDNZVg4iv3wzX/
 4OnaMEBAm/j//jqpNOF87SKgEoO94kC6mdd833/7gEWV77runJS5spAIlGPyUqh1eTKoFSggP
X-Google-Smtp-Source: AGHT+IFogZ5pUyd4EEZ3cCmJ6oU0vZ9093motJ2GPJr8tXiiRPqsbwXWrQish0FTv5DQpKuYIwB/pw==
X-Received: by 2002:a05:600c:1695:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-46e32a19e88mr11686705e9.31.1758761498874; 
 Wed, 24 Sep 2025 17:51:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602df0sm595669f8f.36.2025.09.24.17.51.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 17:51:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] target/alpha: Replace VMSTATE_UINTTL() -> VMSTATE_UINT64()
Date: Thu, 25 Sep 2025 02:51:37 +0200
Message-ID: <20250925005137.59378-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

All these CPUAlphaState fields are of uint64_t type (except
the @fir[] array which uses float64, expanded to the same
type definition). Use the appropriate VMSTATE_UINT64() macro.

There is no functional change (the migration stream is not
modified), because the Alpha targets are only built as 64-bit:

  $ git grep TARGET_LONG_BITS configs/targets/alpha*
  configs/targets/alpha-linux-user.mak:4:TARGET_LONG_BITS=64
  configs/targets/alpha-softmmu.mak:2:TARGET_LONG_BITS=64

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2: "target is" -> "targets are"
---
 target/alpha/machine.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index 5f302b166da..6828b123ca1 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -25,8 +25,8 @@ static const VMStateInfo vmstate_fpcr = {
 };
 
 static const VMStateField vmstate_env_fields[] = {
-    VMSTATE_UINTTL_ARRAY(ir, CPUAlphaState, 31),
-    VMSTATE_UINTTL_ARRAY(fir, CPUAlphaState, 31),
+    VMSTATE_UINT64_ARRAY(ir, CPUAlphaState, 31),
+    VMSTATE_UINT64_ARRAY(fir, CPUAlphaState, 31),
     /* Save the architecture value of the fpcr, not the internally
        expanded version.  Since this architecture value does not
        exist in memory to be stored, this requires a but of hoop
@@ -41,27 +41,27 @@ static const VMStateField vmstate_env_fields[] = {
         .flags = VMS_SINGLE,
         .offset = 0
     },
-    VMSTATE_UINTTL(pc, CPUAlphaState),
-    VMSTATE_UINTTL(unique, CPUAlphaState),
-    VMSTATE_UINTTL(lock_addr, CPUAlphaState),
-    VMSTATE_UINTTL(lock_value, CPUAlphaState),
+    VMSTATE_UINT64(pc, CPUAlphaState),
+    VMSTATE_UINT64(unique, CPUAlphaState),
+    VMSTATE_UINT64(lock_addr, CPUAlphaState),
+    VMSTATE_UINT64(lock_value, CPUAlphaState),
 
     VMSTATE_UINT32(flags, CPUAlphaState),
     VMSTATE_UINT32(pcc_ofs, CPUAlphaState),
 
-    VMSTATE_UINTTL(trap_arg0, CPUAlphaState),
-    VMSTATE_UINTTL(trap_arg1, CPUAlphaState),
-    VMSTATE_UINTTL(trap_arg2, CPUAlphaState),
+    VMSTATE_UINT64(trap_arg0, CPUAlphaState),
+    VMSTATE_UINT64(trap_arg1, CPUAlphaState),
+    VMSTATE_UINT64(trap_arg2, CPUAlphaState),
 
-    VMSTATE_UINTTL(exc_addr, CPUAlphaState),
-    VMSTATE_UINTTL(palbr, CPUAlphaState),
-    VMSTATE_UINTTL(ptbr, CPUAlphaState),
-    VMSTATE_UINTTL(vptptr, CPUAlphaState),
-    VMSTATE_UINTTL(sysval, CPUAlphaState),
-    VMSTATE_UINTTL(usp, CPUAlphaState),
+    VMSTATE_UINT64(exc_addr, CPUAlphaState),
+    VMSTATE_UINT64(palbr, CPUAlphaState),
+    VMSTATE_UINT64(ptbr, CPUAlphaState),
+    VMSTATE_UINT64(vptptr, CPUAlphaState),
+    VMSTATE_UINT64(sysval, CPUAlphaState),
+    VMSTATE_UINT64(usp, CPUAlphaState),
 
-    VMSTATE_UINTTL_ARRAY(shadow, CPUAlphaState, 8),
-    VMSTATE_UINTTL_ARRAY(scratch, CPUAlphaState, 24),
+    VMSTATE_UINT64_ARRAY(shadow, CPUAlphaState, 8),
+    VMSTATE_UINT64_ARRAY(scratch, CPUAlphaState, 24),
 
     VMSTATE_END_OF_LIST()
 };
-- 
2.51.0


