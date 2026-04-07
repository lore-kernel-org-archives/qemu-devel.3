Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9416FF513C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaL-00042P-Gj; Tue, 07 Apr 2026 15:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaF-0003wl-NT
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:37 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaD-0007Ii-QI
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:35 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35c124d2613so3171938a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591972; x=1776196772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bt74HgDQm6QWm4ci9bJjS4WKY7nrk6DWez5uAlhy+BI=;
 b=bMubTEBPBtOpUNN25o0zzf2y/htl1Wsxd1C/t8m7HDlxexuEkLBAKEqk1Wm/eGlBu3
 p+9gQ9j9CTmU7yhcGOv+0eyieF7/RROAYnPZzZ8BMoU/oSscr6TF6NlrCUHT8Tav48A7
 jz/Suorzp2bOVuMJUI0MFSm3rRpyp8ejLu58aVvN+dgOADnr6+oOCjHQHxEOTtU4ab8m
 UEjvGpnbGTxywf6YSU3qSGjdd2/68ymX72ZjzUmk9POT4geQdwHooMYo+HPxTLkXQrH0
 0i6ydo2xBJkEw43SNppQws/E8e2eY6Gr5bfa6b5TdCkrjcOsZuIVjWj3LIOkcIZPzZg5
 TiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591972; x=1776196772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bt74HgDQm6QWm4ci9bJjS4WKY7nrk6DWez5uAlhy+BI=;
 b=alDm246Jk74xPn/XqFawo3S8TXPyGHOx7KdRxJpzgIlFSne2J3hpV7oUc85Nffm7vj
 hGAuJSUKbDcRJg1ZvWBHej/Kd9zDL0r6R7XvPcPO8ngsUyJTw6NCpp2rzYuKE8bNC6hK
 rLCyUb4dTZFHB0bYy4jxnMvEA6TYsKui8M83TzLOVeyiqo/AQcF4+M8EOv1kw/Kb/Hx1
 IeGb8X9DUYOFmWBzXd6BfDtIAG4Epz2tIGyy3VZ8yrIswyc7SSsqQd7x+L5c+sWDXbQn
 T5jpq4KVgS631s2GpRt+MdSHYpwr9OKaa585i/fRuONMogsDYt50asqNosk75Uk2nsqc
 W3DA==
X-Gm-Message-State: AOJu0YwJC2HAcLuthSIiik/Aam7uExrc3i0meAlZTGV4YCXXeaRfl6Sj
 hcIAwEBRUw8hfFxgusLUcmpMcYGZL74F1lpdvPKv7ITcCblKZfX+M+U8Kxelq92NI+s7qCtDYXm
 O/AiEmZ4=
X-Gm-Gg: AeBDievxB6FbAN1844L3r6yCAeEOB0KkH2Wp+rfY/51j1o5jrM6po4u8n527JfchMNo
 B3+RQk2DKqVUtzE0FoNmqbPdp2hZ7KktUAraEc9f5gFa2L1g+g2Qj9JEnVFjbdNWB8jyrob5EfP
 eghIMAzyFJYFivQ/ozMgU0UksVK0vxXzkf5OCbPbNysFMIOo7J7sbXc/WMD14sfazZqfOIhz2RK
 HwGToKANMz4mrLrlIii5tuU95fqrEQfTzDMh+VHHOYqGM2WffMBtEffYvwkVFdsuDbrUvbYZxCi
 D6nK39Ws0H+emTwAhbgmFvIUog8JWFbonmI652l1eJ1BJbA2jvbZ4RpOODgNIjiCZU9Dm6GNAPo
 h0f6toU1IUk1dhJs8V4myAONQAAV2k66a4cLq+4iILWIXUv/ulrYtECE+dPlEJRYyxd0DuTQM2W
 x5An5uCT+G4nHny6HuXGJjTLEVdQmFEBfI96YCY9k5Kb0jC5lF68GHjgfw1s8UA8cHvPKQRHRIr
 r0e
X-Received: by 2002:a17:90b:1d8b:b0:35d:a0b7:960f with SMTP id
 98e67ed59e1d1-35de67d99damr17340787a91.5.1775591972154; 
 Tue, 07 Apr 2026 12:59:32 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 02/21] target/arm/translate.h: remove tcg-op.h include
Date: Tue,  7 Apr 2026 12:59:03 -0700
Message-ID: <20260407195922.196410-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

Include tcg-op-common.h instead, and include target specific tcg-op.h in
files needing it. This intermediate step allows to clean up every file
(TCGv, tcg_gen.*_tl.*) in separate commits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h     | 2 +-
 target/arm/tcg/translate-a64.c | 1 +
 target/arm/tcg/translate-sme.c | 1 +
 target/arm/tcg/translate-sve.c | 1 +
 target/arm/tcg/translate.c     | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3e3094a463e..6d52606f9b7 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -2,7 +2,7 @@
 #define TARGET_ARM_TRANSLATE_H
 
 #include "cpu.h"
-#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-common.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d261a5e32b..35ad7530c4b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7d25ac5a51f..08254b088ed 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 
 /*
  * Include the generated decoder.
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 5bace3fda1a..aa7d72a35ef 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 #include "fpu/softfloat.h"
 
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f9d1b8897d2..56ef1e0eb59 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -22,6 +22,7 @@
 
 #include "translate.h"
 #include "translate-a32.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
-- 
2.47.3


