Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD50C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVmr-0004Ja-Ql; Thu, 15 May 2025 06:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmp-0004HJ-9w
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:25:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmn-000872-Jv
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:25:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so8367755e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304756; x=1747909556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bObN/GZFYIPXswmzQmBrFY+KFYsdoS+icAznneCd2Ck=;
 b=XK+ppCmRVs3Q+RVjZ7bil6PE3H2GC1u6wK3pfVA4qak0y6KX74s99DEnjEohuul1wi
 +l8oJs2tSC80sfMfrFs+sKL3VPj1rudrTIEuamrldFxaLMjk8406/hfIfArkQfMqcAby
 yFr/V3GNgZqJ6bIDJJCm60Lv8iTuz60hHE1XPpciI6XeP2omcEVweh6DUa9gKHIyqy17
 Bhl7RXDED1urw6yXUyUBLx6bY3CKzzZbM1nEZPd0VeI/kucJJYtNVssD8Q8fClrYn2Zf
 lB7HM4QrCmaRQCtAovh6Xj9wBDtOkYU68Ol6YbJaYxbIzndQCcORhWkH0iTfZHn+AQew
 0i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304756; x=1747909556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bObN/GZFYIPXswmzQmBrFY+KFYsdoS+icAznneCd2Ck=;
 b=J3dYYv/ENL9IBfu0KDPGiw6Tkh1U5CUhNRJ0FVjXftEDeKjYErzTlkD3oMm5i3VwMk
 u3ZxXg/1pNWSzYpoPrU6igQ1A+uZrYpKEPLBsisAhAqHSLLu/bMZU84QuPZwW8SNfYx4
 +byqN5UFLuLdpbmC2gMjBAS5YUtVr2SUs5KJpwTrTNH5L9aWSsFEcqn/GGMWIs+WIRjI
 5kugVabbZ7LHnx6GcRFjiRyfHFTtXzktS0/FXSV2w8nZBsqZRMiaIPDxH5cOp7KLk97j
 wUgzTWUP6bsJnXB2sscHXe9TLhX4Bw3WVxWUBZQQffQ9PWd9oSwSYtU5+vumQm8Nqnyc
 pa+w==
X-Gm-Message-State: AOJu0YzQ1iY5RczHcLPJVR7H1idP+31/oSNrSc8ncNqDjmabxFiJu8XN
 uWSUMN+3IFeNNlj5RNDwEwidu/9mSK/uOLBz4uO/wOLjNhyzr2nzewhuZYvyI19PJlFkDQ9ubUp
 Fv7I=
X-Gm-Gg: ASbGnct6kqyROTzTpaLagu2azTiHFzq3KEv33MN5ymq+pUoQeHwM68ywK5eqzYvGgzr
 5wjNed8Ba+mMj7DjdzGAX6h5Vuvut6dJ5/QFW0eAGzj0c+qyv6RlyQN36dn7+VgjUzLQrn+frok
 JPqIPwrHoD9m/sNEFVfQmOQnyTDKlUE0M98e+QhTuWnVBya5CGVjUo1Vx+5w92Arg4pi/St+Nls
 aw/htTv7rdRgOZcWpznKMOXL5dlVH1yqUQucPb5n0F0TmEWtN2oj+5hR2U+oW6Jj+sV9aNwKQHy
 M5wy9lY+Ch1XenspBvu50GDJJEq7dKxgJRfIfP9qdK4P2jPk8CoegT4vLQ==
X-Google-Smtp-Source: AGHT+IFjpRYfpelDs03kn3IXJIUEZ74FQp6xhHfY+3vJl2G2FuerLWetFl1gTD/s8JOln/C9qDkITQ==
X-Received: by 2002:a05:600c:1e02:b0:43c:ea36:9840 with SMTP id
 5b1f17b1804b1-442f970a8dcmr15027585e9.22.1747304755959; 
 Thu, 15 May 2025 03:25:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.25.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:25:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/58] target/arm: Present AArch64 gdbstub based on
 ARM_FEATURE_AARCH64
Date: Thu, 15 May 2025 11:24:52 +0100
Message-ID: <20250515102546.2149601-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Currently we provide an AArch64 gdbstub for CPUs which are
TYPE_AARCH64_CPU, and an AArch32 gdbstub for those which are only
TYPE_ARM_CPU.  This mostly does the right thing, except in the
corner case of KVM with -cpu host,aarch64=off.  That produces a CPU
which is TYPE_AARCH64_CPU but which has ARM_FEATURE_AARCH64 removed
and which to the guest is in AArch32 mode.

Now we have moved all the handling of AArch64-vs-AArch32 gdbstub
behaviour into TYPE_ARM_CPU we can change the condition we use for
whether to select the AArch64 gdbstub to look at ARM_FEATURE_AARCH64.
This will mean that we now correctly provide an AArch32 gdbstub for
aarch64=off CPUs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250429132200.605611-5-peter.maydell@linaro.org
---
 target/arm/internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 660d3a88e07..a396c0be3b7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1833,7 +1833,7 @@ void aarch64_add_sme_properties(Object *obj);
 /* Return true if the gdbstub is presenting an AArch64 CPU */
 static inline bool arm_gdbstub_is_aarch64(ARMCPU *cpu)
 {
-    return object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU);
+    return arm_feature(&cpu->env, ARM_FEATURE_AARCH64);
 }
 
 /* Read the CONTROL register as the MRS instruction would. */
-- 
2.43.0


