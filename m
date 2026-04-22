Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D66F9EDC8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXE3-0001FO-CK; Wed, 22 Apr 2026 09:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDx-00017U-AZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDv-000190-Kh
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so43413155e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862954; x=1777467754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yq/bGIVh38nrtfwG2BReGAMOSU3dNrWCtccK7bpObt0=;
 b=zLSSKlPLbkPXphKKvIJG9JEobL0FT4X7JeITCTnKZ254Uq+EaHtQlkb5iCxy/flBv3
 UEQe7JUYFIPrTTOgsqcBHPT370TIvEdd8TQTFJ4YW0B0pt0FjfdrvQUh0H3BvtPrhSJ/
 JSTya62e/gNJx8EfbZQED4cBi40/Np0K1Fm83HVpkY67mBh8Ry/jxGY5AfeSN1r4SQYy
 JowkDZqRdp1eBsqdXrWVxFy15ru+zrR+hPXjPvGJD2XeZv+CXr5O34vHoZvT1h9k2Yyf
 A9iR3YPzjIJyBTZ485VcyUxBb/Enu8KF3eadTX2RC0dZln1ZiMGnmycRSS2MoWgLX5vB
 Q2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862954; x=1777467754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yq/bGIVh38nrtfwG2BReGAMOSU3dNrWCtccK7bpObt0=;
 b=kmzq0CvUtQuwg6kEO+C1LPsD7S5IKlw/TjcS6QYpWIk5K8QTIRh5mHc3skrbHpQbir
 5UoNGZtl1Xoakv/eSNZ2n7wiAuHEUYWRvqQgw19MH36TRcZ2XZZckJUl3UVrKhkwxwzK
 Q2Jxf5cATJmrY+EemP+uYsBEThb0q2z5+sZMUWSb72kpTLAavD4zp7g8RAXCRkss4mLf
 oJo+8CsrevXQ00FCbPGCzK6EMPIIk9PU7gveQHxfFiqkmvuW/DhFN8pN9jlAsfNC6ee+
 buZ2S+LjOOiUOSSSnFQSnq5nsFqxbZ3QQ/Zo+sVXHhafj0TSvf197s0WcBhDNBHzbHeJ
 6wqg==
X-Gm-Message-State: AOJu0Yx2SRvgnE9t5rkCxQlXgn6pKXMHZ4FfHLzkQPLjbd/15qD/ACEy
 jGx3acksWHp4kiYxUe46IOktp9czhxFkX1qNYpliW4Q7uIbBof2JREHrbGYUcIs+gsg=
X-Gm-Gg: AeBDieuwwK2Ass4S5hyWRxwfzTRv/PypXkx/feAjkhQuKIzWI8Ah5r6+lUCC6znoiHB
 kUOVLiJ8MR5X8v9qpCWuKkszz/i6fgzLMFBpi0sJusVfpiYgLcS4ykKmCb7Sr+xqMp2siFZ4Ms8
 5PodMUgxYGkn/zuCSev1lRpeQ2xhFO9KkdykovnRdIcd8mHyUd8R9n+KldVL7FaJboDe3D5gunX
 kZdKqSzFJLpquqOQ65SOe+k5rB7B0j1BtwVXtEx1G3fun9Xf09hEUdLPUrz2qnIsRK46eGWTvXF
 iO938UlgAgjK0rhmALk4sUrgc8KtUA1gvgWAZ7TUixK2hO7Kxe0o7w7YyXI34UnY1XMa1lgoRnQ
 ATAdwszaQbwonlmVmJfYcSq+bbtjaHlTahEnvV/LV2zys+MQJI78Y3tzpCMqxrKwJFrUzTpH+4c
 CGr9V/VhQbTltlB7FxvMMSHl5A9eduGQQm75DxXWtPs5SM
X-Received: by 2002:a05:600c:1da1:b0:488:d376:42cd with SMTP id
 5b1f17b1804b1-488fb785901mr358408635e9.22.1776862952412; 
 Wed, 22 Apr 2026 06:02:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm230894695e9.2.2026.04.22.06.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 78333611CD;
 Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 19/32] target/arm: make hvf use syndrome helpers for decode
Date: Wed, 22 Apr 2026 13:52:36 +0100
Message-ID: <20260422125250.1303100-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Rather than open coding a bunch of shifts and masks we can use the
syndrome definitions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/hvf/hvf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd9..1c1c31f0b15 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2123,14 +2123,14 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     }
     case EC_DATAABORT: {
-        bool isv = syndrome & ARM_EL_ISV;
-        bool iswrite = (syndrome >> 6) & 1;
-        bool s1ptw = (syndrome >> 7) & 1;
-        bool sse = (syndrome >> 21) & 1;
-        uint32_t sas = (syndrome >> 22) & 3;
+        bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
+        bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
+        bool s1ptw = FIELD_EX32(syndrome, DABORT_ISS, S1PTW);
+        bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
+        uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
         uint32_t len = 1 << sas;
-        uint32_t srt = (syndrome >> 16) & 0x1f;
-        uint32_t cm = (syndrome >> 8) & 0x1;
+        uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
+        uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
         uint64_t val = 0;
         uint64_t ipa = excp->physical_address;
         AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
-- 
2.47.3


