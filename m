Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1138CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1EJ-0004V8-0J; Thu, 07 May 2026 12:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EI-0004Ur-1y
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:38 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1E4-0006kC-Q5
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:26 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d1872504cbso987031a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169923; x=1778774723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KddSzfu6h2SYxUnVyJmdaPI//25dV/tGyPD+hJSdvk=;
 b=jz0jLjlyE7G1Wv/8XunwRQRP4JMpDLF/Gja2cL9l5yeKBrMqEySR6CK0nSDQvboq2a
 Y8XM9UBvpJM/8wtcP1r1omQ2Iicl3/lvMhVGkAIdajBMOFp6zqaTB5yDymZlD6uNO//l
 gBkyn5HgjKSjiK1O+I+9UpFkyIYQ2NU5HxW1TDdvmINY3tTdZuL4R0k4Pr9OJh093qpy
 Acpa4HWHkgnsnpiv/AHy3WfPLuTBhR20KBjHV9suZRe3hr2XEwy4wYvIr+RAcijZiexY
 sG0GPnhYYh/jqFgUtnmt8Hw65RavVq9IjB4iCmV2lDUFFAbulzOLZ0vw42UQx8+P4T2o
 ZiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169923; x=1778774723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8KddSzfu6h2SYxUnVyJmdaPI//25dV/tGyPD+hJSdvk=;
 b=bV00Wf7M1R9l5MuOGbqM7wzAkw9Es0lYANMLjEl6rbLrsZcoQ1Lz2StmN079tmjbZ9
 RNOSFsqej/ULGvjkp4l/68h9pCPZkPWpjFSPLxuf9ZQzm8+VOxKOaZ8b2gfe5VSGaO9d
 fbe3SLxR4+aAZrlBGuun5J6K/MwBjNCx2y+C23dVVfkqbx9DFdrQJmkkcK9U8/5sV10f
 wQ0e6sy3MtMjeYiBiy4tzORguKoiFmukiDut08q+JjqX2g/f40VQiWe5oSMyj9EXdnAw
 9FVvifIlsAu+pXar2K9EmmK5lAO7RSsw8X1N86w2SCZrNF/gCNNkQnE2y7X5QtVTq70V
 zptA==
X-Gm-Message-State: AOJu0YySTfryBao6vJzgkdve3jN/tdyfiWmK5Sv2l7gWO0VNu1nV4t6q
 8emI8Jk1l3JZFtp1H6EFWpchcQ6ZvUz0PfVtwZ+xMN768I9MKMuZ4phDClCP5A1kPc2NbpAsgiL
 hxGih
X-Gm-Gg: AeBDievK8CIlsFgDuamavnqDNoh2JB9xQyeJpmZaFmfaRUail7j1bq4/2Hk++gXoDtR
 BKc7TjPoLUfzMLGon6MMCIqlTs4fQ0O0dm8xnmMm/GdCRsQEqEQMOsZlD0DyWFCzyaVh8bfdP6f
 5ntfILGUWnod6qgMry8wie8vxFlrsP8J3GFtdQrDgMo1XcygA+VWtMCWBxG2R8JZMeuurs3RJej
 bUUM1VXxOotx87OnpDWqEUSvDLdNGq6/fU/C8z6ABqFyjpeMEsEXiiK5dkpJ9lcETYIKr5ejZ2c
 UuIagGCZ12gunDvlBCM6nrE3JExaHM8FYVcMzpZO9FIV6H8EP1Vpv++Y/jUv44wpUkEww6Oa1Ey
 dpiw08tXbYhjek2zZQEwHYncQlnm2L1a3qxTrMHN6RS4xZOFc8d/fY4Ln6q6qJJIbPRhfiFtSv1
 nlDvb94uu4mmYMNIXhz34PDtweJ/VAAi8RGszjl5rE9uddIA==
X-Received: by 2002:a05:6830:7103:b0:7d7:e3d7:e200 with SMTP id
 46e09a7af769-7e1fd052194mr1875661a34.6.1778169922987; 
 Thu, 07 May 2026 09:05:22 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/29] fpu: Inline float8_e5m2_pack_raw into single caller
Date: Thu,  7 May 2026 11:04:50 -0500
Message-ID: <20260507160518.444797-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 18f2ca900f..5269e5f977 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static float8_e5m2 QEMU_FLATTEN float8_e5m2_pack_raw(const FloatParts64 *p)
-{
-    return pack_raw64(p, &float8_e5m2_params);
-}
-
 static float16 QEMU_FLATTEN float16_pack_raw(const FloatParts64 *p)
 {
     return make_float16(pack_raw64(p, &float16_params));
@@ -1477,7 +1472,7 @@ static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
                                                     bool saturate)
 {
     parts64_uncanon(p, s, &float8_e5m2_params, saturate);
-    return float8_e5m2_pack_raw(p);
+    return pack_raw64(p, &float8_e5m2_params);
 }
 
 static float16 float16a_round_pack_canonical(FloatParts64 *p,
-- 
2.43.0


