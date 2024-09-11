Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E9EEE57C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYd-0002Z2-6o; Wed, 11 Sep 2024 12:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYZ-0002QR-Jk
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:03 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYX-0003gP-UN
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-718d8d6af8fso4618040b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073461; x=1726678261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2ZjvXoH00iViMW0slYpXozl5B8ORorypWDbC2UouOc=;
 b=kZH4iL8tJSQHUybIcKqziBVg1d4rmlzSVGSlwZDccjvchScW3l97PhDdJiFwVKSJsQ
 zdNJjTSyyxdNDunMk2lv1dXBQQPpRMxgfH40XNkk/xctk5ZD9e6hDkeo27MROdwwMT2x
 sDN3Bp13sTFO5upJBuIZbqDObjpTgKGOTE96lJcVsdTb2uZfUh4PvFTF1Bm7znHmHlJ3
 pyjWJYgynz8eBuC8lGeMspgNy0TsCCp76hsAB8VMoJ4iHDcXUhu8hULkBX4rTw5VEQF/
 9+SXqvcHN0yVmWewyY69TORXeT+ul5S6nJnp+v5OVqnMC5gv97eQqfgY1gTnDX3ELhCu
 D+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073461; x=1726678261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2ZjvXoH00iViMW0slYpXozl5B8ORorypWDbC2UouOc=;
 b=VNa+QvUtJBHJEZZviHdZfxU28CEEYYqX6OCEna10QMY8wuo00neR7wtA6K/EVc45E0
 MfJFnPlqpQHXqrZvwg/9UKDtMug8ow+1QLtLZBT+S93d/yzcVxLD9lHVxqwxqbFXCe+U
 W7uetsPTRdMty+9NboygFKlfcNM5FJB/PYHCIotFDLkYDY5HlU7MRD+OmQGaanvvmuVT
 ryqxOHpQtrjIc40bWk2uoMlRsIPWecCWmu/jK/bZNbRKCwg1FKXMNbXHrskBelfk4+rY
 4fMD7t6l0mOGvR6nf1fXYNuYM0+CmYH3ifYgFzQzTxgSfFYuGRIUf4gqgHu+4LOz9oLP
 /e6A==
X-Gm-Message-State: AOJu0YzGE51dZo4t6QMwolD1kI1xRWdlUCNawCi6mHbbANpMp6xXYta/
 9FcK+OXFxTQNhq4yd5i4EhWtWq+3RWL3wt9DowDUgpmfcds5baUEAsCwpBdXmuNv7R0HOmxmOKe
 V
X-Google-Smtp-Source: AGHT+IHxAMN52lfCmQ1WCCsDro1k+d4gyvu6q4UOhAPHh7y3SdV5iIfY6ki6stf4RIVFHP84z00Mjg==
X-Received: by 2002:a05:6a00:b83:b0:70b:a46:7db7 with SMTP id
 d2e1a72fcca58-719260962c0mr12138b3a.16.1726073460572; 
 Wed, 11 Sep 2024 09:51:00 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:51:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 12/18] tcg/i386: Add predicate parameters to
 tcg_out_evex_opc
Date: Wed, 11 Sep 2024 09:50:41 -0700
Message-ID: <20240911165047.1035764-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Extend tcg_out_evex_opc to handle the predicate and
zero-merging parameters of the evex prefix.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index b1d642fc67..f94a2a2385 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -674,7 +674,7 @@ static void tcg_out_vex_opc(TCGContext *s, int opc, int r, int v,
 }
 
 static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
-                             int rm, int index)
+                             int rm, int index, int aaa, bool z)
 {
     /* The entire 4-byte evex prefix; with R' and V' set. */
     uint32_t p = 0x08041062;
@@ -711,7 +711,9 @@ static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
     p = deposit32(p, 16, 2, pp);
     p = deposit32(p, 19, 4, ~v);
     p = deposit32(p, 23, 1, (opc & P_VEXW) != 0);
+    p = deposit32(p, 24, 3, aaa);
     p = deposit32(p, 29, 2, (opc & P_VEXL) != 0);
+    p = deposit32(p, 31, 1, z);
 
     tcg_out32(s, p);
     tcg_out8(s, opc);
@@ -720,7 +722,7 @@ static void tcg_out_evex_opc(TCGContext *s, int opc, int r, int v,
 static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
 {
     if (opc & P_EVEX) {
-        tcg_out_evex_opc(s, opc, r, v, rm, 0);
+        tcg_out_evex_opc(s, opc, r, v, rm, 0, 0, false);
     } else {
         tcg_out_vex_opc(s, opc, r, v, rm, 0);
     }
-- 
2.43.0


