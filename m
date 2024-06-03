Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F122C27C44
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5ho-0007jE-Ki; Mon, 03 Jun 2024 07:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hl-0007Zl-EV; Mon, 03 Jun 2024 07:18:21 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5hg-0006Wr-Kf; Mon, 03 Jun 2024 07:18:21 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f44b45d6abso29776055ad.0; 
 Mon, 03 Jun 2024 04:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413494; x=1718018294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tj+xbQPw1aTPPkVQS9cYzQUJajn8RHcrOCksv3MTYMs=;
 b=DwOpcmCGes3PI+YWKRpzaGGK3BSN/ZuXH1Ml7kWrC10ueqKA/so0klJ+T2cBeoiDpM
 KBLNIShNQDKjVPW4uu+wbwVw5sGswaRfVZ3ZVRefyqadIic9uKfZ855Y77u926D0U30y
 zJXyjoCXpTxr5VDy7+tjaOgnO3pToCfTezhyGo2AGJrOfgdlGKpszGm+y0Xw+Ld5qXMf
 qdlvLd/uVyiOdbV1lLDwxBsiqk/XQLzfAv0n8hcoqbbB269GcEgBgfrAv60VAZOfS8lo
 X8wZw5Y0cIib3JDBmPj6fnw0SfRRA8DnW94Inxcf6wJ6zBjh61boaaGPPWgQ/r4XPTnO
 v3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413494; x=1718018294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tj+xbQPw1aTPPkVQS9cYzQUJajn8RHcrOCksv3MTYMs=;
 b=IiQDitK85Q25sAEFKRVf+h2rn5cX4xCn2piJ6dKA4c3jY7YVq1Ag2hqNrqKfvNj1+8
 eN1/7slacpRcGk1BgQzm8jQZ3YTeK3tj6yOPpbinwMohd60xn2DaD31oYW9upcsdHoTO
 4p8mcGmrZ9wQkVXlG9ofZwlf836Y8lBo7pegxhNzIkz75xxLfCSGYK7uNKRWOpK5qw1g
 fft5rgqzd8wAh3DmCaHLtndiC2uhmH50G6ZEGeCvxbQ3oNkVMQwqT3aygf7K/kO2Ml2F
 nhSuOKSCiK9kFsDVQiDEpaWyIAmHrlbBCV10RzAzXxYieOlae5YLexIw+R1uN9BKV629
 zeoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6ltbyULYFlHbszYs2rTZ/9NyuTNS4fIKhmcls6wAVz3BUCD1dL0FsYl5ZJQSMgXBUn+SCJAI5Pv1rMzmr7/8DgK6h5eHb
X-Gm-Message-State: AOJu0YzVgfY4C0oqnt7jsvIdGoqn9flaWbXwLerAEoqy8s3wYLEBOiex
 XbN5ZGtDt0qcYQ6G7vojachB48JKFqyE/HN5nRcVIq/TfSWIszOjWNk1IQ==
X-Google-Smtp-Source: AGHT+IGKrY8IagvVVSdQaol6lJys9GgQbHEbjGT0vStfWyb+ZlyPi+R8qVjEdKVhSam3BWg1iSDWog==
X-Received: by 2002:a17:903:32c2:b0:1f3:2e5d:902d with SMTP id
 d9443c01a7336-1f636fd9704mr98098505ad.4.1717413493552; 
 Mon, 03 Jun 2024 04:18:13 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:18:13 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Fabian Thomas <fabian.thomas@cispa.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL v2 24/27] target/riscv: rvzicbo: Fixup CBO extension register
 calculation
Date: Mon,  3 Jun 2024 21:16:40 +1000
Message-ID: <20240603111643.258712-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Alistair Francis <alistair23@gmail.com>

When running the instruction

```
    cbo.flush 0(x0)
```

QEMU would segfault.

The issue was in cpu_gpr[a->rs1] as QEMU does not have cpu_gpr[0]
allocated.

In order to fix this let's use the existing get_address()
helper. This also has the benefit of performing pointer mask
calculations on the address specified in rs1.

The pointer masking specificiation specifically states:

"""
Cache Management Operations: All instructions in Zicbom, Zicbop and Zicboz
"""

So this is the correct behaviour and we previously have been incorrectly
not masking the address.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reported-by: Fabian Thomas <fabian.thomas@cispa.de>
Fixes: e05da09b7cfd ("target/riscv: implement Zicbom extension")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240514023910.301766-1-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvzicbo.c.inc | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzicbo.c.inc b/target/riscv/insn_trans/trans_rvzicbo.c.inc
index d5d7095903..15711c3140 100644
--- a/target/riscv/insn_trans/trans_rvzicbo.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicbo.c.inc
@@ -31,27 +31,35 @@
 static bool trans_cbo_clean(DisasContext *ctx, arg_cbo_clean *a)
 {
     REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
+    TCGv src = get_address(ctx, a->rs1, 0);
+
+    gen_helper_cbo_clean_flush(tcg_env, src);
     return true;
 }
 
 static bool trans_cbo_flush(DisasContext *ctx, arg_cbo_flush *a)
 {
     REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_clean_flush(tcg_env, cpu_gpr[a->rs1]);
+    TCGv src = get_address(ctx, a->rs1, 0);
+
+    gen_helper_cbo_clean_flush(tcg_env, src);
     return true;
 }
 
 static bool trans_cbo_inval(DisasContext *ctx, arg_cbo_inval *a)
 {
     REQUIRE_ZICBOM(ctx);
-    gen_helper_cbo_inval(tcg_env, cpu_gpr[a->rs1]);
+    TCGv src = get_address(ctx, a->rs1, 0);
+
+    gen_helper_cbo_inval(tcg_env, src);
     return true;
 }
 
 static bool trans_cbo_zero(DisasContext *ctx, arg_cbo_zero *a)
 {
     REQUIRE_ZICBOZ(ctx);
-    gen_helper_cbo_zero(tcg_env, cpu_gpr[a->rs1]);
+    TCGv src = get_address(ctx, a->rs1, 0);
+
+    gen_helper_cbo_zero(tcg_env, src);
     return true;
 }
-- 
2.45.1


