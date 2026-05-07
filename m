Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C846ACD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1EP-0004Yb-Ew; Thu, 07 May 2026 12:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EM-0004Wk-VW
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:42 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EH-0006mB-TH
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:42 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dcd89701acso972723a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169930; x=1778774730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f55KUaIRsxkMoSdrRt8aTn7E5OTKI+taBESlBWBCL0g=;
 b=pbLX9+Rm133VGqUqiCL9lGS+vQ6oUL8/BRwQ67h4FYmZPGthoLG/wQjU+q4JY0v/OW
 2yY2wOuEpmBqJ0HZxqXUFY+744wPUdg8ILnubVkBvSbWbT9rPA3yO/hSQ1Q8BgA1LChc
 kIfQkc0AqFdvB4j6CDdx8O/T5V2ayqDSm2AxAh9C4ZjFsU86VjtgVRetpmLcqAi+ocmM
 HVudEoMgphkBSPV6UD77bSKpe4NCkLKA9roWolxsjm/YGKNhgeshM0xPbz8GjbL3WytX
 OMBONv6Dt+1x5c/REiHhfZ6f0ZQw1qwhb6uNv9otjTNsGPZZpYSaViFJARLqxuC7uhq3
 G7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169930; x=1778774730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f55KUaIRsxkMoSdrRt8aTn7E5OTKI+taBESlBWBCL0g=;
 b=pqC21nskhJZbgBHXcM3R542Pas275x3uETEmViVB2VoYk5jwpsxD0BwlYqIxPxdaPf
 yC9Pzkd3RB0HTA4+kSSPsh1uMlISH6XarY+BfzYvXDrsXtkGLAMAlTmE7c74gPyJV5tD
 mo9mMnqZXvlJbmBpMwDIIht7RI162ynrGfMPZ2pp9meZZQzSH6ryPvL9dvUav2p9z3+y
 +LfkUn2WdFDi0ipsarsV7/RstvMNwWmLUAfXOxNJC6rmvAeyl3enPtmZ+NGIk9I4dTB7
 Z1TtpTt7P7n2aCBoKPJxfMwMG+WfZpYe9e12n/2t0rDQcCjr0btrTgqi1yvplEECWBVM
 xU0g==
X-Gm-Message-State: AOJu0Yz4b7Dggn6DoKzz8ALtIoRiZci/NNgogLsxUMNZNJL88uvWGNTn
 ecPbswRfEkuJT3p0lfTH4U+to+fKdJsuzNfBZM4hXK15R9rJNIwOMot+SxaD4JxfyJf2ucHpxOy
 WtjgM
X-Gm-Gg: AeBDies75ctvsOYKhzMJcU3t2JKJuMO8hutGzBxIEiTOnoPzaJtWOjK3JumlKVXdodF
 j0vT/nwLpY2Oex77ARSxEur3bNbt/g5aI7UDlhZsYqZwGfkD/LoopyAW9H9yD5l4sYkVkcwx76a
 AKLTi3xop/uP4r/43fbh2WFyzvj95MtnqBqsd2XpLHdYzrPVv/0Mz9/n89UtWA5m2f/ddXAs30p
 6j0upk/K6pKw096DfFoXnX+1IAwFgfWdNTHcLHZnM+b0V4Tq+FfBAb8mXopCPHNHAO26cgN3HhL
 JOLgFCulvrHgPNMjjqa1OnaC3vuwtkAqm8Jlk2/nrIhCqU89/svQZkEeExOgNttq+qTva0+lqyP
 /4iU0szNKQR2fEDJExDDDtVRFCB5DGzWSR6izRYawaMlL0Krio18kWTeU3MfftJj9XW72OPQF2l
 5qZ0WUGIHWLgxjZcTKvlAiwMILJ88bPUVNOTailt3C5B/KYQ==
X-Received: by 2002:a05:6830:6018:b0:7dc:d7e8:cb30 with SMTP id
 46e09a7af769-7e1df137ec9mr5316612a34.26.1778169929847; 
 Thu, 07 May 2026 09:05:29 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/29] fpu: Mark pack_raw64 QEMU_ALWAYS_INLINE
Date: Thu,  7 May 2026 11:04:56 -0500
Message-ID: <20260507160518.444797-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

This is almost always used with a constant FloatFmt,
so inlining pulls the constants into the shifts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 63697ab3db..8c4263bfe6 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -662,7 +662,8 @@ static FloatParts128 float128_unpack_raw(float128 f)
 }
 
 /* Pack a float from parts, but do not canonicalize.  */
-static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
+static inline uint64_t QEMU_ALWAYS_INLINE
+pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
 {
     const int f_size = fmt->frac_size;
     const int e_size = fmt->exp_size;
-- 
2.43.0


