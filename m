Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563A7106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vvN-0006Qw-QV; Fri, 13 Mar 2026 02:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvL-0006JF-O8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:03 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vvJ-00074i-Ri
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:23:03 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so2023369f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382980; x=1773987780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZRmXTsWwF92i38CWzyioQ3gYSkR93NF6ooKugCOGYcw=;
 b=k7L7eJPeG9onAby4pXzH7rBbsXFNBLHh5z2/8OGnaraNLEWrn6ZyJ/bKmROe7ObQMt
 iXnbQ9D+JZqCd5tg6T4/IGMuwEqmx28g4BPOS2EJJm5rrdiGkvJyFApGviVCOvACF5PA
 3fvPldV8e3r98heJjCnSy4iNPXKzNiPmenOiXAdHY+Ht5PIehkpUAMF6kS7cL0wkTIfv
 BWOvoUEDMSrQjd76cvsa/vXJgEgLcV4K6hUmfFQvoL5b5VFRutshmiv4pjbwzGNmO89m
 jgeVUQnjcXQ/USL5lpH2OybUnDSY2oKV4+HMmleiyNAXYn6SF1J2HXg/3gkCftevp/8o
 E/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382980; x=1773987780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZRmXTsWwF92i38CWzyioQ3gYSkR93NF6ooKugCOGYcw=;
 b=JxLLy+OoavfbC+E/d8vINLsoPPn6O+7Zu4pmK59cPTA31yt1+mnlyL0JSqUwa1PrcT
 OE+eGTW+i/nw1Ysbh7K8+0arDtzzLVYU+dBaqkFeuEvjS1luZWmvhoZw5OqizpdN/svC
 T8XcUxvc+shMUz/VZIm8IuzsPLPiAE2OhfLHwxUy02a/fUhPH3hOxDG8qy1VEVR/uGFB
 LjquYmn2QBacEpKJ7CDLDFnAHLhgh5mojolojqXSvcgnmlDFcxk/6QeawONm4wbHLK26
 YFK4W9C9rH1yUy59yGxinBihl3fflkzMjV1hp8dWTApt9QfOEe4XGX5cVB2MmZyr88RB
 QnAQ==
X-Gm-Message-State: AOJu0Yxl8Qwin11IOjCo53lzp01KonvhA0qEkQV71tGJRrOOdxMlwiTw
 DNVDnz6cvd3tVAMWr+XCl30QOTmj+mhmnJRovrURO0/TJJmcUuL43mqj3b/2LSnhJ2UUqlaf982
 nPfLyB/c=
X-Gm-Gg: ATEYQzzK4GqtI8rv6GM/ry+G0Soy4xgUDrbonS5Hr6FVxxRxGp01n0xDh560hb3S4y0
 5Ia3sQJaz7YaOrnhPaQhVDma++15ug/sBBL+CFc0DTgtxG7HeXIlVLF7A7DoY15qEt10pWECTRX
 KqXDJ0RaH7uJF86Ean0scYQy1Hadv+n03CYrlQf+PUZbQQryq9RNp/gteylDpgXyViOwqGSa2uu
 o38D5kXmcBIaHdutz0JTLLj+MZDy6wT1UgS5okPKaGyb7KPCJs8fSadmc62/yGJ0QhBqomhM303
 CT4JC9uwXk+T424Id9yEpvUNCp5K524+DnDorAPpBMV2tBtbPDfCY7huJUP8/JRjNM9EA+j03CI
 6TnjDqK6xcM9hXHf5YB7Z3rV/Qr/ccCpMJ9RmDoGo1eUmcpA2rX2XIw5+y5syKyyL9EO74a9A0N
 Mb6/Xsl2uMX2+mDQ5CAQsUZSLtvYBENQnZB0pV2ttaBsykh8NS+ui18rGV5mj9Lg8xkP5aqAG6K
 AnJcg==
X-Received: by 2002:a5d:5e01:0:b0:439:be67:a034 with SMTP id
 ffacd0b85a97d-43a04dc0c3fmr3882963f8f.47.1773382979938; 
 Thu, 12 Mar 2026 23:22:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe2187aasm13080229f8f.30.2026.03.12.23.22.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:22:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 18/38] exec/helper-head: Include missing
 'exec/target_long.h' header
Date: Fri, 13 Mar 2026 07:20:34 +0100
Message-ID: <20260313062055.2188-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

TARGET_LONG_BITS is defined in "exec/target_long.h" (which
is currently included implicitly by various headers).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/helper-head.h.inc | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index 5b248fd7138..7dec5f5b067 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -46,14 +46,13 @@
 #define dh_ctype(t) dh_ctype_##t
 
 #ifdef COMPILING_PER_TARGET
-# ifdef TARGET_LONG_BITS
-#  if TARGET_LONG_BITS == 32
-#   define dh_alias_tl i32
-#   define dh_typecode_tl dh_typecode_i32
-#  else
-#   define dh_alias_tl i64
-#   define dh_typecode_tl dh_typecode_i64
-#  endif
+# include "exec/target_long.h"
+# if TARGET_LONG_BITS == 32
+#  define dh_alias_tl i32
+#  define dh_typecode_tl dh_typecode_i32
+# else
+#  define dh_alias_tl i64
+#  define dh_typecode_tl dh_typecode_i64
 # endif
 # define dh_ctype_tl target_ulong
 #endif /* COMPILING_PER_TARGET */
-- 
2.53.0


