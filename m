Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFF5D15DAB
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 16:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQpVr-0004I2-Jp; Wed, 03 Dec 2025 11:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVp-0004Ha-HZ
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:29 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQpVo-0006b1-2N
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 11:15:29 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3ec41466a30so961648fac.0
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 08:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764778527; x=1765383327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvyaXobpOlD4VPPpsmzEzKqRWugPD95os5lX5hk+NkE=;
 b=JRqychwrFCyXXkQGqBvOe9MrxuCnZX5Rnd1l5KDcLXXzs+3eem78D3zxm9luJra96T
 rlYaSB4+BEcm3dULkfIAjUJO1r36EDCeOhI1TeBypcgF9nZqrjzW7K1R/K020Txnohdg
 FD2Tp1qSgtkdRoOqjhoqeRkZ8wkAFtoo6B+QLYFYoGZX3mXPUBN3fkRVQEJzQZ4Bp6l2
 BM8GMLqYDsQtkShGdx5/y6l+WnI74sp7MmzE2uJtegYX+5haGR3jYU/rnuhZVaCOT8Mu
 zSmaUhEQ0TfApZWCYPlJUvEgfSz8CJgeHwIS8vaosi76nK4/YFMOHhkBLspwnj2y2RyG
 g4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764778527; x=1765383327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YvyaXobpOlD4VPPpsmzEzKqRWugPD95os5lX5hk+NkE=;
 b=a/MuBXT9w/qf7K/6b4NfHfO9i44r6qqaOAC6opLmmq5ptU0KiO+PT9MQ3zkV9WIXzt
 X0ZWeYaLYKIE2DIHuYZeKgRNQMvBG1NdEXRUnoRbFDfgXJLJd/wohsZvvleWRxFNaGBA
 B3iOm3MJdi/MocHl+qJr4uT5PXmHjDm2+2w4CtEoY0TSkLrItkWsOizUU0nfMEc3r/5A
 +p4gA30Ykmzm04wyWxIYhV7q28NI0HEEG378JO1UdUhyK7AfX38AbWjf+IbVbzYPk7i9
 PPMasiAYlBtGbB7PeqlLPHEjp/HFOGEO29FMGY1E+5J3hA7vBrqTtrIeLsIlqS4G4FPc
 OE3A==
X-Gm-Message-State: AOJu0YwZ8tq7AOvhkePsPdRmxSRyFo7GzSV1HXpuX3Q3p5UiU3gIVO92
 AFkzPn+t00FwLOAIbrXlksOAQOpH0rnsQXbYlKlQ/OcubU+Qq/0Bu0plHua83GYNMAn9Odxl8BT
 OOZisLDc=
X-Gm-Gg: ASbGncsN4nYcUnEOd1XbF4rU7huyNegazD3cTi0RvUhEWtyt1WsvMfjexs8b7C+OsUD
 480TyKk2ZaYvOIgnZT6KNynWqZocQS786CHNcEpU55ESrWQGNqu1fLKEmkaUOr6H8GHaRO7WJSM
 uY8et9Ft79QIJm3Lr8s15qFIBWxwqguzPUrnp84LR95lViWlAbUAj2BPjRolRk+E+WGY00HXEbf
 JgzPrQAjpiOmxgJ0NfP+HP7XlrePQuAUcwmayZ+BAc0j8Bok5uZ6cRUy27l02tCBM2Qqj6x0WPm
 cvpVR38BGfs+vhMFqFn1Mgq1HoAmZHmK1AK2gjpMcSJHhMe3CkeVhoWce89hXYFMZgkb1Flk0v3
 XyRIMRXslvvIIeGwJoiuexMSka3y0PrEBxgGUjnKHrEH2MXzZ/sr+LiW8DQJ84n4qhg0hr/eMlq
 i8kDDj/JmMbMqg764m8w==
X-Google-Smtp-Source: AGHT+IFDrRm6yKEj+7k60YOBMefIUVNVnSXFcBfwOqLJu8OCdkSdcL91EHvuqD8SJNQDE2kHr7o2Xg==
X-Received: by 2002:a05:687c:2e10:b0:3ec:2fc8:979a with SMTP id
 586e51a60fabf-3f16830a631mr1343021fac.19.1764778507433; 
 Wed, 03 Dec 2025 08:15:07 -0800 (PST)
Received: from stoup.. ([187.210.107.189]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca40d4dsm10141625fac.9.2025.12.03.08.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 08:15:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v3 6/6] include/aarch64/host: Fix atomic16_fetch_{and,or}
Date: Wed,  3 Dec 2025 08:14:59 -0800
Message-ID: <20251203161500.501084-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203161500.501084-1-richard.henderson@linaro.org>
References: <20251203161500.501084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

The tmp[lh] variables were defined as inputs to the
asm rather than outputs, which meant that the compiler
rightly diagnosed uninitialized inputs.

Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/atomic128-cas.h.inc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/host/include/aarch64/host/atomic128-cas.h.inc b/host/include/aarch64/host/atomic128-cas.h.inc
index aec27df182..52e98a0bdd 100644
--- a/host/include/aarch64/host/atomic128-cas.h.inc
+++ b/host/include/aarch64/host/atomic128-cas.h.inc
@@ -67,9 +67,9 @@ static inline Int128 atomic16_fetch_and(Int128 *ptr, Int128 new)
         "stlxp %w[tmp], %[tmpl], %[tmph], %[mem]\n\t"
         "cbnz %w[tmp], 0b"
         : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
-          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
-        : [newl] "r"(newl), [newh] "r"(newh),
-          [tmpl] "r"(tmpl), [tmph] "r"(tmph)
+          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh),
+          [tmpl] "=&r"(tmpl), [tmph] "=&r"(tmph)
+        : [newl] "r"(newl), [newh] "r"(newh)
         : "memory");
 
     return int128_make128(oldl, oldh);
@@ -87,9 +87,9 @@ static inline Int128 atomic16_fetch_or(Int128 *ptr, Int128 new)
         "stlxp %w[tmp], %[tmpl], %[tmph], %[mem]\n\t"
         "cbnz %w[tmp], 0b"
         : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
-          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
-        : [newl] "r"(newl), [newh] "r"(newh),
-          [tmpl] "r"(tmpl), [tmph] "r"(tmph)
+          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh),
+          [tmpl] "=&r"(tmpl), [tmph] "=&r"(tmph)
+        : [newl] "r"(newl), [newh] "r"(newh)
         : "memory");
 
     return int128_make128(oldl, oldh);
-- 
2.43.0


