Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC46CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1Eh-0004gY-3X; Thu, 07 May 2026 12:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Eb-0004f1-8p
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:58 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EZ-00072P-9E
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:56 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7de7c57b52cso802951a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169950; x=1778774750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvDAz6TNBVJ1gXLXpmwXOO0ZCnNIm5yTD5SwDCkiTzg=;
 b=BHjY+NhXimEihaAjczvHiQd3hgO3EZeF0vtQz+So5N143lf4DMu+mJa1625DeRCJxG
 sWBut02Ai52H+pokoZ0CTpWVSlRkGOmbTP0y+dV4cu8H3pbHZoVOEo4E/W4UkWJzj2+s
 ZaqybJW2ZhNciivGXVUGlu+eF5j4H1cz5ELPl7EkK6gD5GEsch8diUZ17J25Upijv2pa
 dK2iJyxo/EjnQBqhvmZ4s3ZpWo/7JcyoPMjujHrXV6tRJGZFbOhRSHi4iWYMRGlnrv2y
 N+4ixcRilODRq+0hrU/6XCAbXK6i3GaYhBN//i0ThJYZLnSXBxpye3ZNxyAv7qx4+4Y4
 qeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169950; x=1778774750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JvDAz6TNBVJ1gXLXpmwXOO0ZCnNIm5yTD5SwDCkiTzg=;
 b=j7qLh6IPbWxEFdTtt2o5vW+lK82HYafTu551PC4SxqyhcfTefNF9MOM0evd4jm+ZDw
 CUi315AzLL1Jix61QR4OdUl+I4TUf5pNyH7pldNMEtgl699H68xEyDS+lZYuGIz7tl+H
 QBZ4CSCiXG/vos3uSIDT2igG3LIEoAlZRHqohkQGH68MRvF6dj9jowES5dCYJDsIrfY6
 6rlcNzDCQjxTN1UrXdYxPOPEPC3T1Z5nR8K3nnMhTqAIQ9M3SHnMEwUVa9VQOSa/Yqwt
 kmfHbPIlJz5AjccQBOytzWgfyarCK+5alQAp421liZ/fiFu5UgyobwEyU5NI7ygXdSoG
 pstA==
X-Gm-Message-State: AOJu0YyZR4w4rpOL8XmG/ZoXjNJ7IpEk0feYNZ+aLZm7OLSScF6kppK8
 q3NOW+Lv7Jm2dWfDC+xd7iUnbVzt13bpau41AMd1F/5ZR6qf35yIJXzhieLSRv5Gf4y6pzG2gZF
 3BikD
X-Gm-Gg: AeBDievUCnd2/eFJVkQSVYgFKQrPvx1UlLbHS5oN1XQhi6bhWTvDyjI+7chB7HV3QwE
 YbCl/r6jZEH2xyZLATBN+79IsKF1hJECM86Fosx0N2TA+kElkW9OPxo8Td5mRaL0x4SMVj3qJRO
 Y4MhiieY0EiHRaYVk98ubETReGlJR5/nuvq64uDhyc4ec8z+09EFS6S/2JyKRXfblfK/wTFg3/0
 L57zbR1/bjWtrFRe5vYAlRmGyjfAXrbLlB4p6wozTgfOksyyrQ9Jo8kjqdxksd0RsAFdEaTtRDZ
 aGpOJeR0tA1ixvYnhcSfesfQoOPAmlXvS06/L50JE0xdE8Z1NTrDgi5SAo3X5tnM2RCfcacRKQ9
 EU72wTeayFWozbvjygTTWChaBvKrtqSCoHs4gY2ag8iwzgUm4zjBtz2g9QbAehF5vdVMJ8GO+/M
 jonLTgoFY0f1GlBZlG4fVDgGYLYO2RXsH3wmKAOuuiQuVXwGPs250JbdId
X-Received: by 2002:a05:6830:64c9:b0:7d9:f50f:9691 with SMTP id
 46e09a7af769-7e1dea9d032mr5176488a34.0.1778169950179; 
 Thu, 07 May 2026 09:05:50 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/29] fpu: Return struct from parts{64,128}_scalbn
Date: Thu,  7 May 2026 11:05:15 -0500
Message-ID: <20260507160518.444797-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

At the same time, export.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h |  3 +++
 fpu/softfloat-parts.c.inc     | 14 ++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 9504d0daa0..46618d217e 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -214,4 +214,7 @@ FloatParts128 parts128_round_to_int(const FloatParts128 *a,
 FloatParts64 parts64_round_to_fmt(const FloatParts64 *p, float_status *s,
                                   const FloatFmt *fmt);
 
+FloatParts64 parts64_scalbn(const FloatParts64 *a, int n, float_status *s);
+FloatParts128 parts128_scalbn(const FloatParts128 *a, int n, float_status *s);
+
 #endif
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 2114797aca..3a9c2748cd 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1633,22 +1633,24 @@ FloatRelation partsN(compare)(const FloatPartsN *a, const FloatPartsN *b,
 /*
  * Multiply A by 2 raised to the power N.
  */
-static void partsN(scalbn)(FloatPartsN *a, int n, float_status *s)
+FloatPartsN partsN(scalbn)(const FloatPartsN *a, int n, float_status *s)
 {
     switch (a->cls) {
     case float_class_snan:
     case float_class_qnan:
-        *a = partsN(return_nan)(a, s);
-        break;
+        return partsN(return_nan)(a, s);
     case float_class_zero:
     case float_class_inf:
-        break;
+        return *a;
     case float_class_denormal:
         float_raise(float_flag_input_denormal_used, s);
         /* fall through */
     case float_class_normal:
-        a->exp += MIN(MAX(n, -0x10000), 0x10000);
-        break;
+        {
+            FloatPartsN r = *a;
+            r.exp += MIN(MAX(n, -0x10000), 0x10000);
+            return r;
+        }
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


