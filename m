Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF97D42B86
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 14:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tArdO-0003PK-75; Tue, 12 Nov 2024 09:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tArdI-0003OE-Be
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 09:12:41 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tArdG-0005dV-T3
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 09:12:40 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7240fa50694so4281338b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 06:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731420756; x=1732025556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JM+EJG8uPTvGoZU+1TdInhch32L1euUCIAwGo1PQ03s=;
 b=hlxBDVAUMATdgV29hKbC8bP63uChJpfylgxLcZeZR1pdU6/hxiP37TAmgaSCU4lLlI
 LqJGWBt4KUishV9xfJnkZm2ncpYVhfqCCuJ4xdZ6gM1ZfhEa6MJagkaKR8U15I3G2ifT
 Ct+EfakZJOUVcJzuhCRctWcyGTfQhDVV2PM5pEV9nSTLK5IXvKqpA7Au0MkbkxznUwLs
 Dx6SgxfXxWO5qoYcHvON0Dh6vw45rVEKTCA7yk6qr3YZXnxQmWIRT+/y3A4EZNLo4BMv
 QAOUamuqf33m32XAg/asnHImpUOL5BVjR0OzDYYqbskwsPriPKPvcYwTySqJZZKysjrK
 RS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420756; x=1732025556;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JM+EJG8uPTvGoZU+1TdInhch32L1euUCIAwGo1PQ03s=;
 b=ejnBFEXC0QV3PqvgWHwp+yfbUGS6NL27Z02StdrOJSZ0NuQOJdU48Ukrf0YYp6H/IO
 eRWBZgzbFW6UQY/NQlfkHUGpSB8y0S6RBAmnBNRK1h7hGOl4kh5FlaMD/XuDn5uYCCXf
 O6kL/8UmJXHLQMOzVg8x+MxemZOAHPeVSjiPLRC7cth+r9rHVa7t17rPnp4qsEZ8k4Ln
 G8hl+IOwdvRu6mj8QvYjxU/OcJBIaWQnAnKSoIg2WAlkd5rr1Y948W2PQQJois3lIZMn
 1WWriZarWodTYpUS5XAW8s6h9IhWH2UVvDYRCuaTOZUB119aHjgDxVZW/ApGAjmvjQoS
 21qA==
X-Gm-Message-State: AOJu0YyYbwf35qT0Z861YrtHgbpx35dAJeCGJ41OcpzWKslmvCxuuIpR
 ZIRDFj3/swl9SZFR/8QkDrtKRyEcPkDRwRr2MnP0rWYkOS81BAs2dITnQT0QHsIwdOm871MG63C
 S
X-Google-Smtp-Source: AGHT+IE5r3Sy2M4aTX4WFuIVEi/mlOCEgbi6QUGsOrdeC7Ix+KJvU+7zC9YUtfMyOQSfkpl3Sx+Qxw==
X-Received: by 2002:a05:6a20:9f03:b0:1db:dafa:e9da with SMTP id
 adf61e73a8af0-1dc22a2670amr22189262637.27.1731420755869; 
 Tue, 12 Nov 2024 06:12:35 -0800 (PST)
Received: from stoup.. (wsip-24-120-228-34.lv.lv.cox.net. [24.120.228.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724549a899csm335330b3a.115.2024.11.12.06.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:12:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH for-9.2] target/arm: Drop user-only special case in sve_stN_r
Date: Tue, 12 Nov 2024 06:12:32 -0800
Message-ID: <20241112141232.321354-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

This path is reachable with plugins enabled, and provoked
with run-plugin-catch-syscalls-with-libinline.so.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index f1ee0e060f..904296705c 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6317,9 +6317,6 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
 
     flags = info.page[0].flags | info.page[1].flags;
     if (unlikely(flags != 0)) {
-#ifdef CONFIG_USER_ONLY
-        g_assert_not_reached();
-#else
         /*
          * At least one page includes MMIO.
          * Any bus operation can fail with cpu_transaction_failed,
@@ -6350,7 +6347,6 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
             } while (reg_off & 63);
         } while (reg_off <= reg_last);
         return;
-#endif
     }
 
     mem_off = info.mem_off_first[0];
-- 
2.43.0


