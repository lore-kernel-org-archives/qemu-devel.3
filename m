Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A36E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSx-0002A6-2Y; Wed, 11 Dec 2024 11:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSo-0001Si-JP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:26 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSm-0007uq-LX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:26 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434e69857d9so5486795e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934083; x=1734538883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=doRTkzLWp9CB3fDTzYDP5bn9+hyyRKBZGVgyCVKSal4=;
 b=sBH+xyer+4c0o2Dv1L66d4LSbAgPDGqhduB1yQiyLB2U5HwXBL8Xxp81JGIju5qk8/
 gRky1G2woe/gVFMeXpj521j1hA3RoHD14Xh4VHfxUsOKd3d4r0qycblnVjFqtSq+iGv8
 +STAuEAHVSBHj6gmFAEkQgmBgrcO+clC6Jc3IUjtargYm1U856w9l30yUVnhGzH1Qru6
 VEb1NRMJkWQpg+BPJu8COm6lePsKV/d3aMZKuBi3702Tc8u9yoONvIpJ0Hppv44qsj6s
 3PLXOWAv0Skt8RQEtaJMiGLJxnQH44I5TikiG+336IfwI6X56/sPSGtjapNdUb5PNhnt
 YISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934083; x=1734538883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doRTkzLWp9CB3fDTzYDP5bn9+hyyRKBZGVgyCVKSal4=;
 b=iPCc7M3VxV+EUVisBGj6/rZI63YJUETOX2LbISY0A5fz2T4q2thJlQafpaVU80qnof
 A0KKHrAzeN0Dp0Br5zByxhBB8x2d4PHHMmqrqqSz4vsVgjALXfDcM6smrzpnEqgsakVI
 rqoUdevRdsjeATrHzYgD+Ktlh/hdB0dZFk+w1D2fiNVpPnyMRbuFYCDIS6NXLa1EHV+u
 veyO/z0AOkZAObep20AbXCnrt8rOwVtnPiEQs+WSHl/G5iEHkBJRvlla8kgwvuDwzBKC
 /HvvsFBfugNONc1gmdZiVwVDDM+OrnwfqpRHA1WkCdDcwiKOt8HmET7XvTdWzU83LXds
 uIcw==
X-Gm-Message-State: AOJu0YyfFg3IHN4Vvgv9QsLict1f1gh8i1o1kOOs6gkKoZuXypTe9acR
 RkiJ4/kzwUpq/j9Paid3sNZj/XwNayaH4WVWEZCwP1yG1as/9QsIhSCzmFoq/lYiw9WQJYdG1BU
 B
X-Gm-Gg: ASbGncupf38z8khJ+bCp2KAku9EMZouyRSK9rm2QVgPHdKcgMooAhZYuKxZQVU845f+
 X2VGLduwwYVF/FQLQ5laNkUyHoojxN2PzpdBk9EG4B/UEpj2z7VyHuOeU3R2SknjLruBId/GPys
 jNWt9Vj9o6F1/6lrQg2M+T0daabfimva0yFQILg5TJ7mwEddcGHyk27UGGbxVr7S8mnXPbPDf2D
 ouN+K2w30dK1RRVmXBrbrlxn559o0hZ2Z/TCNojTZK/n2+eLyVc5x0goGb4
X-Google-Smtp-Source: AGHT+IGZk0AK0IjKsvlbFKBNy84R/VVcxn9ZjMkUpngAEIQcm5aH6bJ+cITVGoddelnqsozCJmqZ/Q==
X-Received: by 2002:a05:600c:c8a:b0:434:fddf:5c06 with SMTP id
 5b1f17b1804b1-4361c5b8720mr25750205e9.1.1733934083222; 
 Wed, 11 Dec 2024 08:21:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 69/72] softfloat: Sink frac_cmp in parts_pick_nan until needed
Date: Wed, 11 Dec 2024 16:20:01 +0000
Message-Id: <20241211162004.2795499-70-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Move the fractional comparison to the end of the
float_2nan_prop_x87 case.  This is not required for
any other 2nan propagation rule.  Reorganize the
x87 case itself to break out of the switch when the
fractional comparison is not required.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20241203203949.483774-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-parts.c.inc | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 3c77dcbb154..abe24aeaa00 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -52,11 +52,6 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
         return a;
     }
 
-    cmp = frac_cmp(a, b);
-    if (cmp == 0) {
-        cmp = a->sign < b->sign;
-    }
-
     switch (s->float_2nan_prop_rule) {
     case float_2nan_prop_s_ab:
         if (have_snan) {
@@ -89,20 +84,24 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
          * return the NaN with the positive sign bit (if any).
          */
         if (is_snan(a->cls)) {
-            if (is_snan(b->cls)) {
-                which = cmp > 0 ? 0 : 1;
-            } else {
+            if (!is_snan(b->cls)) {
                 which = is_qnan(b->cls) ? 1 : 0;
+                break;
             }
         } else if (is_qnan(a->cls)) {
             if (is_snan(b->cls) || !is_qnan(b->cls)) {
                 which = 0;
-            } else {
-                which = cmp > 0 ? 0 : 1;
+                break;
             }
         } else {
             which = 1;
+            break;
         }
+        cmp = frac_cmp(a, b);
+        if (cmp == 0) {
+            cmp = a->sign < b->sign;
+        }
+        which = cmp > 0 ? 0 : 1;
         break;
     default:
         g_assert_not_reached();
-- 
2.34.1


