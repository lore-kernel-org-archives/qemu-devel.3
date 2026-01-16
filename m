Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4729D4A5FB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgabI-0005ip-W5; Thu, 15 Jan 2026 22:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabG-0005Ud-U9
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:14 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabF-0005ad-9X
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:14 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-81dab89f286so747495b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534452; x=1769139252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwGPpfxzsG4LOsiRJ3NVV7jG3uJ4HK6BFewRFRnb1bM=;
 b=uNhZti0bPn1C1sUL1V4U+VOLzz5kBltTaA3FoJXE0kshtVcs3RdS24vfM8CGeyUiQW
 BSCwyO1q4xvrvoDmIceaXXTrGuYZ+TnoG2/J5Rz0t0jNoRyxi0MdF8vqFpHaw0fvH7zy
 jP2BBOcZQrLJ8O4TUgtS3MHJ71NNF+jIpyuR7+Ad06ito8wPB0fatOylDWceGpijF/PF
 2vrpsJVTCnnXie8u1lHtHTw03AZxFmFb5IoeBNsBtoVHBI/sN3HXEWZNXTn+W+w8lupZ
 laEqMPCQIEIgG1GeGRNLkSYfVLrJU1eZQrHsu4ZXuBQJ0xhFGYtV0vX7/YkCF3v0K0NH
 Mzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534452; x=1769139252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cwGPpfxzsG4LOsiRJ3NVV7jG3uJ4HK6BFewRFRnb1bM=;
 b=QWduNu7Kp8BTfB9ov/zND4wA0NHz1b/hugKJ2czOaWwIPo4GN1uS8RRMzvIk900zoC
 mlZgPpjQ/wiCdaW1CO+7S4f6CoTZ+0W/VsRyQYtlbzjaxV7pkvMOkYrzApAKlkuNNJ30
 VOb7Mjk+GZhDsutGjF4fKI7dNLRHSbeV13TnihkicO22eESqsJQa6KU23RAmjGqXHy9t
 +fHRwnnlY2X3MUUSvcxyN3zUVNudPCAt3vXlg2BJb3vjx89OJUZh7GHNbwMmrpsAMat9
 C83V2MyBCrAkqb72uKinJntEYHbq9zfXbOocYxKWWCIzBQyi+1Hs9FcYo4W5e0WXrPTk
 7/7Q==
X-Gm-Message-State: AOJu0YyUppwJExpcaP3U4/4DZpUuVRGw21FnlKaTvVjcUUum5pfsmIDL
 sa4bzrS6wI6KmuWWoV1zr88AQ0ZjaQqLGNUwiEjdEDX228OYzNd1+LWdlEWZROEDNnEKo1g62mr
 QL8q+D8Lhlg==
X-Gm-Gg: AY/fxX5oQR5cb1lJNpxeQMzQIkm3tJ2Hb6NEsOal9d4F2AiK5/0ddke9BxUxS+qHcei
 xRuH5UdbVljH13eTtx7kjxSKHRwPoVNDJATCa60jH9fZlquoo/6Xp1PlVPPFOnHDDNNjRc8sfF2
 SIsxA56xnIUdGGfAnxBn+0bXDRt0gSR4+yD4n2zsMa6wSRiTw6TkWlPmVXVG/h+6UKp0IytPy8E
 YdGy5mwx+vxD+hEccfOm6s6xNkqgdaFy3OhhfLeL5xl+8K8UBSFi8ULejMHA/8bM1re4xv0kHBf
 h0cPog8pF1bq5fbnpeYVJEvA0/cDX4KN5FvuQKYW//04fPzqzbnGoC+Nfa02N5EERq63bhgwF/k
 Ds7kS9lBik0ZTordZDAqUhH1X2UW7hw0ssvjDAwY9CE9aOqN+9Z5GOXiwngyziatV4SH+38BaOi
 Xy6FhT7e7iOYwal5ZNxg==
X-Received: by 2002:a05:6a00:1910:b0:81c:92ec:ccf3 with SMTP id
 d2e1a72fcca58-81f9f6aae13mr1604600b3a.19.1768534451895; 
 Thu, 15 Jan 2026 19:34:11 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:34:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 14/58] host/include/x86_64/bufferiszero: Remove no SSE2
 fallback
Date: Fri, 16 Jan 2026 14:32:20 +1100
Message-ID: <20260116033305.51162-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Since x86_64 always has SSE2, we can remove the fallback
that was present for i686.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/x86_64/host/bufferiszero.c.inc | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/host/include/x86_64/host/bufferiszero.c.inc b/host/include/x86_64/host/bufferiszero.c.inc
index 74ae98580f..7e9d896a8d 100644
--- a/host/include/x86_64/host/bufferiszero.c.inc
+++ b/host/include/x86_64/host/bufferiszero.c.inc
@@ -3,7 +3,6 @@
  * buffer_is_zero acceleration, x86 version.
  */
 
-#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
 #include <immintrin.h>
 
 /* Helper for preventing the compiler from reassociating
@@ -119,7 +118,3 @@ static unsigned best_accel(void)
 #endif
     return info & CPUINFO_SSE2 ? 1 : 0;
 }
-
-#else
-# include "host/include/generic/host/bufferiszero.c.inc"
-#endif
-- 
2.43.0


