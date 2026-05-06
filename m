Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF77DFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKckZ-0003Ws-7Z; Wed, 06 May 2026 09:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckX-0003Q2-7V
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckV-000878-Kf
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488d2079582so67246925e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075833; x=1778680633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9Qd6zcp9RiZdXoE6n5XVtyx6tpGhxU5ssW9UnbrdSnw=;
 b=Wgx63rCGKU/w7dcpj5LQFBZ9SX7hF1GFKUw570dMuR4JVkkvFJ0Lnj3IhvijpIAN+r
 ZfEJXRM+Ipucxn0MqF2Ia56CRmIQEnilZt8v185qHv1U6fqJhBIFkuLImQgj7mD3Wp42
 ultgNB1cX00YoFr1oG/yghhp6uXj24PMjlKZDjA0zSnyyBFvBxY7W52kfwtoBco/mU/v
 nDNLAZGa0ZlpAAlbWvxCf0hLrPbrohGWVwdLgaYiKCxYJwzXBvXyIBkevDvsvUlmwlOo
 SGoLzUb0UB3tEKJnhziiesEcSl34t0EL1SlXhem7ZHjc8+8TCOOa/dZI0liMx+vXqfAE
 1Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075833; x=1778680633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9Qd6zcp9RiZdXoE6n5XVtyx6tpGhxU5ssW9UnbrdSnw=;
 b=aMXWCWAFyLBnkQhULQaUWhYBDZiG3fmmJFE4ipiH6NmTGh+Ta3x3PFAVEPG/bcHNqh
 v8qrA4x3XN6V2XCCmSuZ3u2Px+iz8V2q4q4nGVh9Ug2yQZ4kSfHnnYHaGiNZWyTfQAB4
 hccjhDy1ySCVix6fYUPyUk+HivNLyDYqXpjOstl2EyosILnxQi8s1JZyEq1IKCVIqaU/
 TV7aVALSdWnHuvnCWMCenG7u7vCf00Jdz6A76300mr3f7gLk4VuIEoLLtqffSBIWonTY
 rp3Yg1GjOuz9wWcLReKIuGrfIhvFkX1x4qmyr4VT1YGu28GYXMbsmxV+o83GmSAtiOgl
 VPeQ==
X-Gm-Message-State: AOJu0Yw8zVC6sWfcOUHjaVUVzWsRAZVnqjrCZ2IkqNlT4SnuZ5YGoCzR
 WOuzKVHs/tsqW9Z1Us+DW/Wkk+vURG5P3QmzG+RttbJ6yFhhSYBCHFzun/8VFVqZeoEBcJCR/fJ
 9vrO8TcU=
X-Gm-Gg: AeBDies54avFhizKvVc5c4P43jQEzZGpF88CQdfXPd+m0CIzo80eIaYqWPKgZFnO/QK
 9kotZr7nll3SL0US8PcHrVVhojWVK3QTIVYc1VNZI4V4ddHsL7XO5ay0CnUAG9bdwmrV/pDfyAv
 lgCxB6G0HeKUpCqv9DVjG0+gIX8oXcLkDbDd8htlotVEsiNr1DC/CiVMXa44C1noccGNH6+8SqY
 rJju3mkhK6i0zjEEFJ/G9ySlk0Ke9rE7TxVj9qc39pcFyXLKcbHSKHVhvBFQXnhEULzGNtX3Uy/
 yCfS7GcI3XYtRS1w9c89pH0HC0aQs7hLS2eKNc6XDzaYB4CN/UjFfGhpsYerp/7mtJEPrS/r03O
 s1cTJeaHyMNiRkmkj+vIeuDlBHLxpiS0hpJxLc4vsWt1MclGwv79MgBn5d4U+iFWsVOflP9OSBA
 z5EjID43p4+WFiJefxUe1m/u3SCngIDoIB121B2QSaImQwd/L1nUgffYqLlAJAlrmBeTbLUR93B
 FmH7eN8H+w=
X-Received: by 2002:a05:600c:4343:b0:48a:563c:c8c5 with SMTP id
 5b1f17b1804b1-48e51e15662mr31870205e9.8.1778075832598; 
 Wed, 06 May 2026 06:57:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a48b23sm13017139f8f.14.2026.05.06.06.57.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:57:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 014/110] exec/helper-head: Include missing 'exec/target_long.h'
 header
Date: Wed,  6 May 2026 15:53:46 +0200
Message-ID: <20260506135524.20617-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-19-philmd@linaro.org>
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


