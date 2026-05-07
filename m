Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58072CD3447
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1Ea-0004el-Kp; Thu, 07 May 2026 12:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EU-0004c1-ET
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:50 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1ES-00071F-J7
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:50 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dccb8644c4so567398a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169947; x=1778774747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrUvh73Uqf5KK7Sqxeffo+zQ1jx0mgO/cnwZGHKztPQ=;
 b=IguKe7GgomL9GDtO1nXgNDjBnVtBPkqkjrpqXgAGKDNuyanT+L1zGwvBCQ1i/o1ega
 KIjsGnx5bbLRpcPvrVJiUqBVP/tkfe6OV2/V9sffwcOa3p/lFj36L5E/qD0xW1aJtYyb
 BweM8W7DzxFuXMs7QsTBoLatomcEUjB8S76wiZQCMvDcQyZ4aiLOWJjwyQrBHUrgELlm
 aVvehJKqSb1lavr3nu1nqHzTEOMtvpMWTSgNT/1QYATG6Yiul0rf7Nibl5M/ri3GaVD3
 oUBJMLDIKNaZ8fia42O6L15V0BkOknp0YoLpdrlBQf6V+inI7L3HSHxozrQT6Dv/BH+h
 VD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169947; x=1778774747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IrUvh73Uqf5KK7Sqxeffo+zQ1jx0mgO/cnwZGHKztPQ=;
 b=hAjuKIJHYDJID+PEBygYoW+MtJj5WQxDlV1aZntjuNoXkQWA00sPoWqSV1yqV5Gbmn
 4g7Jv0CBTmP3wytDK5ltiO3tPVjDHMOhO5ABhetJmbnBDMvqDlXWKk7JWYWGzzKpzjf3
 OwNiT2Nzry2o/XxjjyfLPUfju3aYJEewxN3VHUTXNKYQZ1arZ1do+T5IHjmTRhy2n7la
 sGyO726x9qcLUw23OuRYl62gxl4eI8hvrBrnMJIybVsT0dj2EfjOGkA0IxjQ8QTUA6Wt
 Krl84HcG/lgmeYudSR9OONr5ir/U2qV0eodJB1QynP6TQ5mkJGKAwdQrAXOpWPGKDkMo
 0q1A==
X-Gm-Message-State: AOJu0YwR1d2W3D3HfMD86mqbBq7hrFBXA3uOfzIFvZx65OeHcQQNwPUV
 0ln9OHSm6PLvxmwvbQfJhXEyX6V8PoxzuDFS9XNgpqwUH7sGmATXqJiZ4W59AvcCXTK4q3fplIe
 Y1kOg
X-Gm-Gg: AeBDieuH/S9ffUQD6Jwa/4oXceyaXh3M/g22hVc8Tg56EfE5V7euvCKbKJeWeXacLGB
 DPAMw9N5i7GOljqKDdLtab1MscOoIi+CvSVi08pnXCDyD9Tw8XeGP0+eQyrvknZVSyowtAB9vd8
 UCFMu/7ABTJavDhrXSIDJhroL4bqunIKHDQWTVqHyzT1Y9LuVtPZ7ZLFME4V379o4+6KqHRsgcx
 6YtU0ABiwPdwy0ksIqc/QoUq187RvL92ER0Buqouyf+Tf7sCLJ1POPbUttO9s3u3snhvXqH06Jj
 /AAtk/vB1fsN5bNsAJ2KlqmWfLaC+dDIjNjursSMiJqnF2SrkMKkr1cZrZdmspwPi8QmQlbMgvK
 X5He7JYX2WelSy7aX5+BYcy26/zbTMVeEZVuHLSB+rOlLELWgEs61EQfV8kTurvX4H8BJ3UsKEM
 4V4mdU3XHB6fkcPNxcI4/eZRQw/MrBZi6yL9OLYslS7i1+aA==
X-Received: by 2002:a05:6830:3907:b0:7dc:c301:d0b7 with SMTP id
 46e09a7af769-7e1df24e19amr5237587a34.28.1778169947094; 
 Thu, 07 May 2026 09:05:47 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/29] fpu: Export parts{64,128}_compare
Date: Thu,  7 May 2026 11:05:12 -0500
Message-ID: <20260507160518.444797-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

At the same time, constify the inputs.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h | 5 +++++
 fpu/softfloat-parts.c.inc     | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 1876264d43..0dd8d9c526 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -182,6 +182,11 @@ FloatParts128 parts128_return_nan(const FloatParts128 *a, float_status *s);
  * Operations
  */
 
+FloatRelation parts64_compare(const FloatParts64 *a, const FloatParts64 *b,
+                              float_status *s, bool quiet);
+FloatRelation parts128_compare(const FloatParts128 *a, const FloatParts128 *b,
+                               float_status *s, bool quiet);
+
 FloatParts64 parts64_div(const FloatParts64 *a, const FloatParts64 *b,
                          float_status *s);
 FloatParts128 parts128_div(const FloatParts128 *a, const FloatParts128 *b,
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index b8baaf1e76..7f5abbc6e6 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1569,8 +1569,8 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
 /*
  * Floating point compare
  */
-static FloatRelation partsN(compare)(FloatPartsN *a, FloatPartsN *b,
-                                     float_status *s, bool is_quiet)
+FloatRelation partsN(compare)(const FloatPartsN *a, const FloatPartsN *b,
+                              float_status *s, bool is_quiet)
 {
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
 
-- 
2.43.0


