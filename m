Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39260FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDMM-0003Do-Cs; Wed, 29 Apr 2026 18:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMK-00031m-Tb
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:20 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDMJ-0005J8-88
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:20 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35f9ab079bdso151356a91.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501578; x=1778106378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJ1do9xAZzfPr/mA/oklSBCs4qcpkKXJzAzKJ9HmEZ0=;
 b=ek1jnIUM5iYZ3u1ewmxXbb8NgRCU2b3v/aDlHSZh/GOZdqMwPUbL2WyaPMFn3dhWQE
 6HUt+XAAcyqaBA5H3d94jOCFgvOMjNQfse1rgKJfQzfLCMTzaXQko3a08iKGkZe0d4aZ
 0bfeQe8KuwTbouAl6N3Wn2DhZMbPbTQDOamH0g22Brzv9R0NyN/qinkdhOU+P7B7gtOT
 F6jNJaDC5PHBptFMIyFMZYgJdoPfHB58tnw9i5tQnoQ89uwdeTOYk94q5nrLbtaoWQab
 i9ILsdVrPh1vgg96/EYcJef9JYMVHN7DxFkdMi/fmlbe+wPPyTuh8Sthkm+hy7uFhFo6
 P7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501578; x=1778106378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uJ1do9xAZzfPr/mA/oklSBCs4qcpkKXJzAzKJ9HmEZ0=;
 b=O9eHJOQZCcRg38qb6Mt3Gvz6Y0fJcKNIF6gF4FDF8F0oS0YQxykil1hltECka7zDbY
 ZhyqOockiYH6ekIH7G0v1tf/6ehYLIPQJb+3f4XgtJ7gesGiNpjIR0gWC1cY/ysict0l
 SEG54+KYPMU1oX9/KTHesImqLyVctmtj6TX+9k+bDf9v8X1t4t3raTzTkqK8LIFcOLuy
 5uzK2rV6YAO/PGWYO0iD5Lk+4yviUGJGCYXEOb86Z86IncdSDAX6/iZ9U/p/lbDnw1Ew
 4fWotRYRoYQgTchwMNb5BhqZr99Wq/we1nX6nKv+GC6AoMWXkofoGSRZeEplLb7OQEZ+
 /0KQ==
X-Gm-Message-State: AOJu0YxqDJlDowTziirgiUQtUgo+HXpts6MARs4iFHOC1C3hCIRDK/K7
 TM1N1fzJIKn/vdeDLvsXN2IYNDi4+HBEpMdvxUYtJW74ivzT3ii4b9+wEOy+MTQXwoBEeRUoudj
 kT5GT02E=
X-Gm-Gg: AeBDieu3M4MqRG3EX3IosuG5WYJXem6WHrKT4vPJ8xGYq7ZHcdSTDt7ez/1+hNIPesO
 JDgRVxkiS9wP++Z/DugT8oPCVxqy3hK4OktQ4hz+mfAwEtWwGKkzjgmw/C9IrH8apYClsLvY826
 aPjvZZAQkFANhcPZva5rxLW2xpSzduU5BBK0isxQeB0macn6BvQ32ahxf+sz4tGbcJSGl8Edrh/
 rO2nntj3ubgClR4NHSqeeyE083jTmpXxMt0OCucp9Xu20p7lzVIXDN/kIfIY7WI0NVeHOyIEfYb
 FKQHHO6v1aafSX3u6gDICeEZNZTSlhw1CUWuy5QcDjcRwxLbxT9G9XQq9/pXJjHM4aToANDZtG4
 qcS4iDNa7F6l2Ii/TAVyHyzOFKsDNsdevY5sOVW0gu7i/klBA2YO/iyjZZXZKpIspqzZWMkMWBH
 KsMqnMsvbtq6VF/7huQvjJzdwJNJrRsmksAY9+ivvI
X-Received: by 2002:a17:90b:2e42:b0:35f:b9ea:8fa5 with SMTP id
 98e67ed59e1d1-364c30e2dc9mr161346a91.20.1777501577871; 
 Wed, 29 Apr 2026 15:26:17 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:26:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/48] fpu: Return struct from float8_e4m3_unpack_canonical
Date: Thu, 30 Apr 2026 08:24:31 +1000
Message-ID: <20260429222445.26301-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Inline float8_e4m3_unpack_raw at the same time.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c1d0140484..c1b03f30ab 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -646,11 +646,6 @@ static FloatParts64 unpack_raw64(const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static void QEMU_FLATTEN float8_e4m3_unpack_raw(FloatParts64 *p, float8_e4m3 f)
-{
-    *p = unpack_raw64(&float8_e4m3_params, f);
-}
-
 static void QEMU_FLATTEN float8_e5m2_unpack_raw(FloatParts64 *p, float8_e5m2 f)
 {
     *p = unpack_raw64(&float8_e5m2_params, f);
@@ -1475,11 +1470,11 @@ static FloatParts64 float4_e2m1_unpack_canonical(float4_e2m1 f, float_status *s)
     return p;
 }
 
-static void float8_e4m3_unpack_canonical(FloatParts64 *p, float8_e4m3 f,
-                                         float_status *s)
+static FloatParts64 float8_e4m3_unpack_canonical(float8_e4m3 f, float_status *s)
 {
-    float8_e4m3_unpack_raw(p, f);
-    parts64_canonicalize(p, s, &float8_e4m3_params);
+    FloatParts64 p = unpack_raw64(&float8_e4m3_params, f);
+    parts64_canonicalize(&p, s, &float8_e4m3_params);
+    return p;
 }
 
 static void float8_e5m2_unpack_canonical(FloatParts64 *p, float8_e5m2 f,
@@ -2701,9 +2696,7 @@ float8_e4m3 float4_e2m1_to_float8_e4m3(float4_e2m1 a, float_status *s)
 
 bfloat16 float8_e4m3_to_bfloat16(float8_e4m3 a, float_status *s)
 {
-    FloatParts64 p;
-
-    float8_e4m3_unpack_canonical(&p, a, s);
+    FloatParts64 p = float8_e4m3_unpack_canonical(a, s);
     parts64_float_to_float(&p, s);
     return bfloat16_round_pack_canonical(&p, s);
 }
-- 
2.43.0


