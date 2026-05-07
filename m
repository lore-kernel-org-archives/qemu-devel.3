Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C85CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1JK-0002VK-Sm; Thu, 07 May 2026 12:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Ie-0001gQ-79
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:11 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1Ic-00086S-I3
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:10:07 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso925289a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778170205; x=1778775005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MQ1ojMgoomCJTz2WUmM2Kg1zoPKv7tCL+iMiboWdMVw=;
 b=dv1gRtVB5AJlxf/P6kORDFQYhYzuKuq3NSgeb6l9TenjKuKW4i5+HY492JMTLBMcHs
 4TnZiFVPNILedOGqsdffBQY0SCdGp4GtJ48LcA+0BVfC89DmTdDY6oxS7wx9uR75gxzz
 tRZ6WxNsBFncgxqKQBy3IWYV3sYjy7ztcQndwI1pamGO7c5meUyviNAkyiJI+mMS4ss7
 iE6ZplpAXvz3iAZ0kgkcKYNMXwChI6Lob1ZHyGWw+p1HO6EdadGUlAnxcWuvGyq5X1Ex
 NMh9E7966u9FxIK0zW8mvy5MLpGl0E7wPUdbwQ28Dy/NnJOzOZf/KvDJU0/hJwla1mKx
 lVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778170205; x=1778775005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MQ1ojMgoomCJTz2WUmM2Kg1zoPKv7tCL+iMiboWdMVw=;
 b=aPHPBFBXPxHBWDRxtZKeoHJSZJkV0v11ibSvaHcZ7iLMj9e/ZE9fqCJvassr9ZWKOD
 Fgj7DUf+0vupzrsekTRq+69Od4mrYiiKnq0AB3uzYYZaf4FWfOlH04hOYw++q43GXUg2
 ICJ/g8SFVFXR4BVUuUed11ToDNAoNml0Pp1jqWbgk/9BgNZa9jfhN226LaE/Tql66Flj
 1zSJl4ULVBDeDPogf/CdLPclTmx8Qg/T/jEZhG8Jwc9e9m9m8EhBBAm0UjXn0/5WEr3Q
 +A8q6jP2PVItvWqZLDtmUa0B7dELVxNKygc6s3ks2zJTrp5mvdFxzeEK3urFSFrMbsSa
 exGw==
X-Gm-Message-State: AOJu0YyAVbcBwxv2+hbxPEXops0VOHybyB6I3LWKnaLdYfxv4kYHjV48
 OC/VMsB0t49W6NDGNMb9GjVFCX9DqEJzpT9PPzs79aSJzjT6XCluqiRW3dmCzNM3YiMWsUwlBPl
 edXKh
X-Gm-Gg: AeBDiesl2FvAC2oAN9cY2o6CXpuySmqo6TgQxm+78oIru27p6XOYQEPP786TGbHwFVR
 GxzmsBcYxnSwoNoFdV604UtyspyAWfsk/sxBFkdEct9eNOnUiRpUNGbn6P0N4F7Iabf9zKWFeyf
 ZXC7cKkjEvSq6tlPVodilV39ggpAQs47T9i/32L3ctfZSrsZeRKg2sISdNTc0INOZNrlBCyYv2Q
 gwdfxSbAWxsNiDxoXiEcth70vTjwSEEylvBSYjZ72z+DV9Zes3i2BuGAS3G+zOlhju3WSkD/rLl
 dcRGbAQxVfmsnxcMlPjjRPzpSt5iQB7HpxnRqCUOV1OLcul5BMtOww3AOtBshWv2zALpnSMa/iu
 dPNUVUu07UgjEGMFSZ1Ac+totOk3XFhsxHvQ//KS8mdugBXpQ/NFJzqDuIGzw5Ne7AUw7l8eWdr
 +6/dF/zu/VAWtdnPn2MMdryxVHCIl9jGyiIcKrUhIN2103fw==
X-Received: by 2002:a05:6830:378e:b0:7de:49c0:a752 with SMTP id
 46e09a7af769-7e1df26c2d2mr5164347a34.27.1778170205228; 
 Thu, 07 May 2026 09:10:05 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e302462fb1sm16415a34.11.2026.05.07.09.10.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:10:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/11] fpu: Simplify 0 +/- N case in parts_addsub
Date: Thu,  7 May 2026 11:09:52 -0500
Message-ID: <20260507160959.449170-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160959.449170-1-richard.henderson@linaro.org>
References: <20260507160959.449170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

Consolidate the tests for zero and anynorm.
Add comments for a few cases.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 20cb739c75..6df98eb5fb 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -556,6 +556,7 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
         }
 
         if (ab_mask == float_cmask_zero) {
+            /* 0 - 0 */
             a.sign = s->float_rounding_mode == float_round_down;
             return a;
         }
@@ -581,23 +582,20 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
         }
 
         if (ab_mask == float_cmask_zero) {
+            /* 0 + 0 */
             return a;
         }
 
         if (ab_mask & float_cmask_inf) {
+            /* N + Inf or Inf + N */
             a.cls = float_class_inf;
             return a;
         }
     }
 
-    if (b.cls == float_class_zero) {
-        g_assert(is_anynorm(a.cls));
-        return a;
-    }
-
-    g_assert(a.cls == float_class_zero);
-    g_assert(is_anynorm(b.cls));
-    return b;
+    /* 0 +/- N or N +/- 0 */
+    assert((ab_mask & float_cmask_zero) && (ab_mask & float_cmask_anynorm));
+    return b.cls == float_class_zero ? a : b;
 }
 
 /*
-- 
2.43.0


