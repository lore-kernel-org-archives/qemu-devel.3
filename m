Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D89EC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteXa-0005gZ-2v; Tue, 11 Aug 2026 00:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXI-0005UO-0l
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:24 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteXG-0002oC-Gf
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:23 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso596634a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424181; x=1787028981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bZchNLH3GseYoB40fgIW2RSmOs/MQT+bMsmniUtWRck=;
 b=zZlfiosu0ZZ6v32GPUADl43plf+5W8DcBFCYaaen2utLmvumZKTdiSU3oc7PPgOS2W
 Q3Yj+CCR2cHTNde2igjebX6L8cw1Zv/Fnf37BXTRCQlOAYssachk5l9pNZFuitMqYzra
 0VjBdYtlQjA5febGD0hsALSbp9aUnnHUUGqiYWbzek3vRTnsBbsJ2gQCjARupO/+Ij80
 gUHEA3VCW7dgs3gkcRdujwGOFLu8LIobYjaIZiUly0M7I/SztlGxI9w12J+UFqNh2vqH
 8y1hlYbydjl93UbNX9LQfGjkppPNIJui887s64J+W3WYNKETrvhQz31EeFfpgHXvQ4sm
 mcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424181; x=1787028981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bZchNLH3GseYoB40fgIW2RSmOs/MQT+bMsmniUtWRck=;
 b=ok3P9DipPGfQ/ptKE6vuvudSx3ULmLLDjvgz+zbvQV3DRzaBhLtvrgRhSsgDvKQUIO
 UfYUET7qMCVfD1FtQ/8R8+ONC8hjvTlGRrKgzM03cYGI3ar5QXbTAG9U7jXak8TuAGKQ
 47qC6jBRLmSNnNh0mrmU7ho6HNrTF5qj6ve7J5fhAY7Io54ZL0bHU1TxFvLbmJ5pgcn7
 t72g+Omaa0wO8g4dXcpL7ZZy8jsPouGRwzPZVz/MxoouOQbQrsg1TwHIF2hAuV4zdAqm
 /GylBf7rvm9qTOlDMQ4IFR2u0eZFVbBBvw9wEUBkRLjg9WdCPCW7tYErOJ1Wb8PLObi6
 nOXg==
X-Gm-Message-State: AOJu0YzKkyrFMqUvOQNHdpVre58bDDcgKh9owhJMdO7w366wFPy0piz3
 fBnaobc2cUPHIY9Y3cdBGiW659PTAxPdFjK6WkNUbh1RZKa1cwfb1jGliTpYcCZDgzoiq4680d7
 xH/Q1
X-Gm-Gg: AR+sD105cC82bQEszq+yjGxfMO3i5odp21vn3IsmoRsBPxCby+4UmuNrcGeBJCXCOQd
 QWc2JpXYNPAOKcN8WtU4mVaOY2ri/s40BDpz1n0oca3SAdbZAsxXRmJD3D4s4JD0NMER/kNoCDJ
 2hNgjtWQP0mtekmQiAc9/T1jzvbIJMIAqUD6IWqtabQRa/Q0eNqSkGlPmOkq+4bKisb7eIiRXQm
 gS1Rj2sA0YRI9HLlQMmO5jx3VIZkWEYF3y50PBttWs4u6JIGofGS3x4OzuLxMiItGB1xUIzH0Ak
 M0vOO3mbEGLigSMfoSEmp5xQVKPsNIGARq7d3kce01NjWl2U00CKJOM+zc5ej0ucsUu+lm6SVEv
 7H6FKbs05amjTHg4/QDIvmmBZ8RRmvMSnEWbJZYsXdjs5g0KQmZn862eKL0VxM0rw6GVe3QtsD3
 wJcJaJ6IaYtNEryR3wbMTSVC2EH7G/o6S7JhpOYeJCF22np+8+8rytlE1Av2sqNRdcm7gIXC/ct
 WnDOXsS4B2d6JLqWXDj
X-Received: by 2002:a17:90b:57ec:b0:38e:7297:a92e with SMTP id
 98e67ed59e1d1-392eda54a71mr143483a91.9.1786424181090; 
 Mon, 10 Aug 2026 21:56:21 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/16] tests/tcg/loongarch64: Add bitrev smoke tests
Date: Mon, 10 Aug 2026 21:56:05 -0700
Message-ID: <20260811045605.1246543-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/loongarch64/test_bit.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/tcg/loongarch64/test_bit.c b/tests/tcg/loongarch64/test_bit.c
index 69b2eaac78..65cd6598c9 100644
--- a/tests/tcg/loongarch64/test_bit.c
+++ b/tests/tcg/loongarch64/test_bit.c
@@ -19,6 +19,10 @@ TEST(cto_w, "cto.w")
 TEST(cto_d, "cto.d")
 TEST(ctz_w, "ctz.w")
 TEST(ctz_d, "ctz.d")
+TEST(bitrev_4b, "bitrev.4b")
+TEST(bitrev_8b, "bitrev.8b")
+TEST(bitrev_w, "bitrev.w")
+TEST(bitrev_d, "bitrev.d")
 
 struct vector {
     uint64_t (*func)(uint64_t);
@@ -35,6 +39,10 @@ static struct vector vectors[] = {
     {test_cto_d, 0xabd28a64000000, 0},
     {test_ctz_w, 0xfaffff42392476ab, 0},
     {test_ctz_d, 0xabd28a64000000, 26},
+    {test_bitrev_4b, 0xdeadbeef11223344, 0xffffffff8844cc22},
+    {test_bitrev_8b, 0x1122334455667788, 0x8844cc22aa66ee11},
+    {test_bitrev_w,  0xdeadbeef89abcdef, 0xfffffffff7b3d591},
+    {test_bitrev_d,  0x0123456789abcdef, 0xf7b3d591e6a2c480},
 };
 
 int main()
-- 
2.43.0


