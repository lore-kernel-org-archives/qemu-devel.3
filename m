Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B66ACF2591
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pz-0007GM-67; Sun, 13 Oct 2024 18:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pf-0007Bl-10
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:13:00 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pd-0000wr-Cp
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:58 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ea78037b7eso739984a12.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857576; x=1729462376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=617h4byv7OP/ct3y2kJCr5k6Qy1wZsttJUBcCYmwvNQ=;
 b=S7/pl+SZlm/Jr7EDi9K8b6MvpZQu0oiS6LLIgBmHbnLP+HTVv2AdQKx/WWIskg/kRv
 lMsOLj+XnXpk+ExO48fJETZHBO6S47UTu3auEoP5sTOMqBqg4+OdxfqAnR0tCBcYKz4u
 ydv/T9AuewN/QRQdbK31fzbzaOkqlvG8w9S3HJBOGX0EZ1Q+F2QJKDttR51GYpvUpMIk
 xOqDLbbANdPOgdL/CS+vGbuaVEbutfByIIYTU0nNqKmE6jlCDprJ2A+HtwKpXZfvi5U4
 mFTG38C1bdZ2E+aBeu3QXWTl46QHkVdEVuaGNr6zGS3GIpIdENXmahx/xfah80G0cfwJ
 R5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857576; x=1729462376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=617h4byv7OP/ct3y2kJCr5k6Qy1wZsttJUBcCYmwvNQ=;
 b=kfDR16tN+wpT1X36C92u+sfJQw49Bdn2aJ9IWoyp+LOzyJNrsWnOZtDPQK0AvcqFIy
 W/05p5mVkI5mW7y2bPYZO+SuzIdbPkf2GTK/L5Rv0L5ClN0vkfx7upEOzeP/NYurQ36R
 H6jUZxG3KlxHOHa1TsxM/GwB4l46LsN7GuY40iBlwjVTHcmvKyN0EHBJp36u5pDMAegW
 3fhbGSxUEQtRPN3MHre3PDiQRoN3nxx870e1SlK2vAwJ9kQ3K7YShltuYHPqpL2NOk1F
 To549NjjbsEbu94ge4cvzhubxqHkTT15YKTQ54xQ5AL3oYXwygD/A8r/x4HxwCUOVP/4
 Uc8Q==
X-Gm-Message-State: AOJu0YzrDFHZcHMFNyrgiembd23Z0zqIjL+KUGISWvo+64ZbGBPXfLGF
 LksiraTniUk1V6sTrebOGk/mQT3Ggh2vFwO9MbztLO6tMuWLWEjclNU1aXqPFsmHIm8G2uO2Ht5
 j
X-Google-Smtp-Source: AGHT+IHCMfP0iC9XhE4zqzCwrjlXAEwJsfkBayeYy0o/GQ2AmM8uNqokYJDfnVG3m3dndoGmWaSQVg==
X-Received: by 2002:a17:90a:f40f:b0:2e2:e092:5323 with SMTP id
 98e67ed59e1d1-2e2f0d8c914mr10886896a91.29.1728857576065; 
 Sun, 13 Oct 2024 15:12:56 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 21/27] target/arm: Pass MemOp to get_phys_addr_gpc
Date: Sun, 13 Oct 2024 15:12:29 -0700
Message-ID: <20241013221235.1585193-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Zero is the safe do-nothing value for callers to use.
Pass the value through from get_phys_addr.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9af86da597..e92537d8f2 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -81,7 +81,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               vaddr address,
-                              MMUAccessType access_type,
+                              MMUAccessType access_type, MemOp memop,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi);
 
@@ -579,7 +579,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         };
         GetPhysAddrResult s2 = { };
 
-        if (get_phys_addr_gpc(env, &s2ptw, addr, MMU_DATA_LOAD, &s2, fi)) {
+        if (get_phys_addr_gpc(env, &s2ptw, addr, MMU_DATA_LOAD, 0, &s2, fi)) {
             goto fail;
         }
 
@@ -3543,7 +3543,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               vaddr address,
-                              MMUAccessType access_type,
+                              MMUAccessType access_type, MemOp memop,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi)
 {
@@ -3641,7 +3641,8 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
     }
 
     ptw.in_space = ss;
-    return get_phys_addr_gpc(env, &ptw, address, access_type, result, fi);
+    return get_phys_addr_gpc(env, &ptw, address, access_type,
+                             memop, result, fi);
 }
 
 hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
@@ -3660,7 +3661,7 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
     ARMMMUFaultInfo fi = {};
     bool ret;
 
-    ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, &res, &fi);
+    ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
     *attrs = res.f.attrs;
 
     if (ret) {
-- 
2.43.0


