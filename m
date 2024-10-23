Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911C7D2E010
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9Z-0007QH-IY; Tue, 22 Oct 2024 23:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S9A-00071l-C1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:58 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S93-0008Mu-Kc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:55 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7db238d07b3so4695958a12.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654488; x=1730259288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNvZhuw+Bf1omcEW8TpFi1p3fkU8it6HGeh8TuxBNsg=;
 b=eBxHGdbXxczgFyv3E0UBFpIGhn4ylq/QaZqleJPwBTG+JWmz/0C0bsucM12sWNzMED
 PQBxh+mGcD0v1wpIbnPf7d3rxEb75NZKS4h/Pyo7TB389dhNNbYBhH3n8UNqu/OlYWer
 /8yBonGDvJ9PNC9XaSiWcw0pVRJWL5NrV10ZWnMjKr/HkppEWLO8RkAp6WJzfhIwbEVe
 55OZsrVsYIUYE+FoOVIMwC2kB6CABQxaMuLe/1k42o8Gka6dAwqCg6HJePivB8a0yyH/
 Yu8IkgzFOemWiCKHZDRuDhQPWCEqm7CKTvV9L4IgKRys2IQTrdyxfKDaQUb5ObDdfxUx
 6BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654488; x=1730259288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNvZhuw+Bf1omcEW8TpFi1p3fkU8it6HGeh8TuxBNsg=;
 b=JRnnVnooYGoIeKk/wXcVBs0ZqEso5FiIt8TULvHl8W3LyUgHnQmRyQDcO1P3YxM47s
 ri/OKWObiGwr3n3Sqz4a8sHa0/6SIqJ/+asv8g9OZJht89OyaX3YobEmMMy1MoHpRzTA
 N/cDq+SZ+DlkTLlLdBXjFTxfvDByHeIqqZUyTrIEeZvakpPE5UGrgdpcfy1O3SLzH780
 1+f07TKVuOxl/5ofpqWf1ibX7tNxrqlqs3spEpzevR4qFDOQZutl6sIcoCKstm0DxV54
 MIUpnkmiTVhKBVhex80DCKcKeAEuhD+zk0rVlsn9TitXLEU4w4E/d4+FM9EN796k1Yk9
 94Qg==
X-Gm-Message-State: AOJu0YzOwQxeLR64kEEzkGooKt++ow6MSQZGmSl6yVaKRshHyZkM41eo
 6tMWDoumimboAH50IM6vtnvX+28l1Y2O0h9Yb3rJWwXo+Ekr2QIsPx0NFjKz7qA9V4Yj5SCjJw+
 o
X-Google-Smtp-Source: AGHT+IHo1PzmI1r1+nPkupOd9It60odBBY4iHt+9zsI2HPkZZ+SLF9o+1UKb/WdlaLFjEadfkfnXLg==
X-Received: by 2002:a05:6a21:398b:b0:1d9:542:8d40 with SMTP id
 adf61e73a8af0-1d978aeacb5mr1341914637.5.1729654488143; 
 Tue, 22 Oct 2024 20:34:48 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 18/24] target/i386: Use probe_access_full_mmu in ptw_translate
Date: Tue, 22 Oct 2024 20:34:26 -0700
Message-ID: <20241023033432.1353830-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

The probe_access_full_mmu function was designed for this purpose,
and does not report the memory operation event to plugins.

Cc: qemu-stable@nongnu.org
Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument memory ops")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241013184733.1423747-3-richard.henderson@linaro.org>
---
 target/i386/tcg/sysemu/excp_helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8cb0d80177..8b046ee4be 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -62,12 +62,11 @@ typedef struct PTETranslate {
 
 static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
 {
-    CPUTLBEntryFull *full;
     int flags;
 
     inout->gaddr = addr;
-    flags = probe_access_full(inout->env, addr, 0, MMU_DATA_STORE,
-                              inout->ptw_idx, true, &inout->haddr, &full, ra);
+    flags = probe_access_full_mmu(inout->env, addr, 0, MMU_DATA_STORE,
+                                  inout->ptw_idx, &inout->haddr, NULL);
 
     if (unlikely(flags & TLB_INVALID_MASK)) {
         TranslateFault *err = inout->err;
@@ -440,9 +439,8 @@ do_check_protect_pse36:
         CPUTLBEntryFull *full;
         int flags, nested_page_size;
 
-        flags = probe_access_full(env, paddr, 0, access_type,
-                                  MMU_NESTED_IDX, true,
-                                  &pte_trans.haddr, &full, 0);
+        flags = probe_access_full_mmu(env, paddr, 0, access_type,
+                                      MMU_NESTED_IDX, &pte_trans.haddr, &full);
         if (unlikely(flags & TLB_INVALID_MASK)) {
             *err = (TranslateFault){
                 .error_code = env->error_code,
-- 
2.43.0


