Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A838CCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWcw-0000gA-2d; Tue, 16 Sep 2025 10:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaL-0005nu-Ko
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:11 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaB-0008JP-G8
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:02 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-264417f3a26so20495725ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032568; x=1758637368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/1Z+zGdBvcvJv/ItuHePFPF4VkGGlPqEflFLb1drkmY=;
 b=tL49jcOD4qJpcO1BffdGEugL/KZOIBtZTmfqY0HwvXJ7jG4xDEmku3zdRW6gsSrFrV
 KwMhHGclQpL0EX/45wkt1G1VZDy0G9tE2zzPVlRydrY3u5OVImf9J0MIWoWNbPmPi+xf
 Y0+XdqUQeTJutCQ0XyKFGtDsgFHb7lPbqC0b4Ag29fFMaMuB6Cayj4P/Esj4eRL4NGm8
 lTCYcnj53tZac9/jIPaSRRAqu01UQzD5yXMouv2yZsuQTByVNQ7v2YnS8P4fPvY86tkn
 fOvx9fSkGrMvif3uu3hio9HRq5Y/LR3iU5RXuzC84rj6C34DeDA8zQ1cgU+tgFP5qLNL
 lYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032568; x=1758637368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/1Z+zGdBvcvJv/ItuHePFPF4VkGGlPqEflFLb1drkmY=;
 b=Mt9iUIASslEb01vrGK84F6v7UTsgvnd9yI3RnVUWOJhW4puJxu9dI13/9RXebRx7la
 Jsm34JbDE+CY3TJ0SLWst/67lLhcq/vlUhzNcVBLHYEYe5dkcODy31Is0YZYdr0xt7of
 lkxe8OUno06wKSQgGiw59nyyN+UaEu0z4nyjBmnLZ5CqCAlihUXXdTVjTMUDJsWpJgOY
 oPFslArEWy1fBql8MUbknG/Z5lhBVErJr7RNwpA3YHFF66eI/N9nSdr+CGl83zFnvsF9
 9cLpOk1FNcbAetDxXmyE9YT2mEDsrBuH32xd7dijhcRiy0nD2/RbVcR/JzhBN2GzWTx7
 vxtQ==
X-Gm-Message-State: AOJu0Yzc4mI+p1GgDHp6PUVqwyKKg1LHEnJ4fxrf/4Ni0QixN9r78644
 gMYRsrRZLczr2KrnzV/ajJuOzS0CYRTD5UULslDFdFBU1Z51DZ6ZvpOnOZQ9hkEYbR72jzmexA7
 RyCjL
X-Gm-Gg: ASbGncs1bTTwyvhhEUEe528nBCjtPehi9GbKImrSiZlE38LHLxgLsqVaZ1TneBXzl2b
 +8yMbFCr/YfYEgVV5uoMVD6yR3d+WUqQ+t/ZNtOFCP/r3l6PK0Ww+CZNF0jlaR5T7T8cL+c7VDX
 1WEUWigPOZ/fTt53ubsWXluYLKTku7uJYWUJuzOIJSlpXhCMtHvz2Kre7r3piwokCT5wH/CYHL4
 APY1LUAuZPqaNknvrliMds9eF9PcMk2CfLlDEWoktHsOHje3a4Wawuv5J0vqEb+6JspbrjrfIaM
 ZBGQzTkvKHmWJAKAwVNqw1+7rR2RoWFb1kwvwFC2Q8uXkKRX56qHbABfO2PUENVBT8hPpIblLSt
 ROu10P0wlz5rxx6qjWuNHs5dd/Ns/
X-Google-Smtp-Source: AGHT+IF/2DdPkCN70tDr5478PzxXyOUoTp89QLBFx5j4RTOjD2SNk1fiE9y30CdMJvrSmyvAbMVl0Q==
X-Received: by 2002:a17:902:e783:b0:25b:dcbf:43a2 with SMTP id
 d9443c01a7336-25d2762332amr187793705ad.52.1758032568042; 
 Tue, 16 Sep 2025 07:22:48 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 10/36] target/arm: Use raw_write in cp_reg_reset
Date: Tue, 16 Sep 2025 07:22:11 -0700
Message-ID: <20250916142238.664316-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Reduce the places that know about field types by 1.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d0f6fcdfce..48d0f03098 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -192,14 +192,8 @@ static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
      * This is basically only used for fields in non-core coprocessors
      * (like the pxa2xx ones).
      */
-    if (!ri->fieldoffset) {
-        return;
-    }
-
-    if (cpreg_field_is_64bit(ri)) {
-        CPREG_FIELD64(&cpu->env, ri) = ri->resetvalue;
-    } else {
-        CPREG_FIELD32(&cpu->env, ri) = ri->resetvalue;
+    if (ri->fieldoffset) {
+        raw_write(&cpu->env, ri, ri->resetvalue);
     }
 }
 
-- 
2.43.0


