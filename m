Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B415606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XYHJf3n4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIq8E-0007dK-EA; Mon, 19 Oct 2026 12:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq8B-0007ap-DM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:22:35 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIq89-00010V-GP
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:22:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1e1dade31so10299075e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 09:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792426952; x=1793031752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pZLtA2h0wZBQwTqX3pZWTJnQIrYGZbHc9AyenCmoNFk=;
 b=XYHJf3n4j5aeRIRu8AgolMlWwnA/Lb9nPOTpN9/Lo58gRWzGtl3xaioibWwQJpAreL
 Fz0ZOPgidILNKHWZZjDjUM1v/K0upplAVbB9n5dyMXoqaUwvOSbIXJ8ZVFyVG87tFHq5
 wN0GTXjf7WHec3RRiBOmkpvy6DvufbloVrgvAdKfSELpNmHWKAu7HmwQ4EFUOSjhMzbL
 AAL05teySVLC6NL8/clALrBYvTSPPdyJLKe6lQQvkqSUPsrHVZZclOETmeCtU5DVgU96
 Kxc2k8f4ZBThTdcWXKI4yVk2WjfKV12hkku8fuujoQzywAsxdzpevyZeoEajYKKf/W0T
 ykYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792426952; x=1793031752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pZLtA2h0wZBQwTqX3pZWTJnQIrYGZbHc9AyenCmoNFk=;
 b=DpSRrlcEmxPqIj1L2ggpUTKeMh4LaSPCsoj+42LFMLErgn1ilLsbv2uiDurnsPf/ng
 Nu6o1pn+6IsidM+mTowQqFDLcnMRTLgLZwkSZ2+UpDgB+IJ7fE7VHPBp6utYWLpgTLZR
 43gGEwIWoameVUVEa4m02pOvF5ZJSU8bJHLe79601nQr0L7+wPFZ8M+IKTtS0UHr431+
 Ou7WflYIv66i6K34GkBUfI7fmIUWPOQVMwjCGNCTNrNO8qfR21uFOq6D2y6NpalWFqJj
 KIv7HELh1FPufsrYqF9f3B2/EcNC6vSKhW/3v/rXBpbP3rM87A7lRR4TwOi0yCIpbV96
 PMPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8NxedKLyrEFnPKqeUuYocIvk4JgZPH4q9+5bUHzd3pdzUZGmmR0U4+5JeFxutNQonXePreKDa5IVX@nongnu.org
X-Gm-Message-State: AFq9FYK6ZAn+NymIir3/20kx0PenegpGaJ7s3stGI/oTFYTNHriBpMeD
 g/6vxaDRw0HCagvRB4jT7oGPY7daJ4lrHtbtvd1Un+H7ZGu7ZtFSTVQHp5V2nvQlvj0=
X-Gm-Gg: AYBFou2wvT3gYofnRLmX7dgFLYcQHHzM+stqIkoep3fcbC0hf9R2e9vhevVSU2Sn8xb
 eUgHaPFo6nAa4z+rj3j0Vc7BV8YHmwTZ4E7af13uTbtVcuT8CUjhdFk6gGfzcu6eaECjd0hJZUZ
 X0t+ah8kZlvvLcMVAO/B3A+Sa/nIktU+mmVE03Bl5Ld93bgM9YyX+Gxtq4D+yGHMkggJhbeeNId
 x2CM4ouJU2MUfGXJdetACREfemVjwkASBXIz3Zvld9t314gnaGyZJbleyT+9M/WA9j4qKpfHSvI
 tPHp0Q1u8m4DiE1iPPqGM3BTwv0DHw1SvFP2NucvWyHQsx89D4vzN7jG+Z1ejw3GPPdWAf5R0r7
 xavBYFt9zhBSAlYwsq1UA4jY+yT3WkUBu6NDlbaCFCefnQMe3GH04NJixamPOdcwsYfzRNAVSTh
 5kcYkEmzhHiUptAazigRFsD53lCZ4flLKXDCGMzfeK+tkwu2kQrj1n/t3ZLXI4veeiYGxqHlXLn
 JseSldHaNQJTRCeUcQ4e/lffd0W92hI8mkyw2IVrjzZojHd60vcigo/zsvxBM6/cnCX604ZrDxH
 EFX1
X-Received: by 2002:a05:600c:19d2:b0:4a1:d10c:7170 with SMTP id
 5b1f17b1804b1-4a1d76262e1mr170915605e9.31.1792426952072; 
 Mon, 19 Oct 2026 09:22:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cdc342sm3100095e9.13.2026.10.19.09.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:22:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/intc/exynos4210_combiner: Clean up reg_set[] bounds
 checks
Date: Mon, 19 Oct 2026 17:22:15 +0100
Message-ID: <20261019162217.3272337-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019162217.3272337-1-peter.maydell@linaro.org>
References: <20261019162217.3272337-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the exynos420_combiner read and write functions, we check whether
offset >> 2 is too large for the s->reg_set[] array we're about to
access.  This is written to log a guest error if it happens, but in
fact the condition can't be true unless there's a QEMU bug:

 * we have already dealt with and returned early for registers
   beyond the "sets of 4" range, by checking grp_quad_base_n;
   this accounts for all offsets 0x100 and above
 * this means offset >> 2 is at most 0x3F
 * IIC_REGSET_SIZE is 0x41, which is in fact one larger than it
   needs to be, but in any case the offset can't be out of range

Use assert() checking against ARRAY_SIZE for this sanity check, as
failing it would be a QEMU bug, not a guest bug.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/exynos4210_combiner.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index 4f079fedaff..2bdb9a0152c 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -119,12 +119,7 @@ exynos4210_combiner_read(void *opaque, hwaddr offset, unsigned size)
                 s->group[grp_quad_base_n + 3].src_pending) << 24;
         break;
     default:
-        if (offset >> 2 >= IIC_REGSET_SIZE) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "exynos4210.combiner: overflow of reg_set by 0x"
-                          HWADDR_FMT_plx "offset\n", offset);
-            return 0;
-        }
+        assert((offset >> 2) < ARRAY_SIZE(s->reg_set));
         val = s->reg_set[offset >> 2];
     }
     return val;
@@ -199,12 +194,7 @@ static void exynos4210_combiner_write(void *opaque, hwaddr offset,
         return;
     }
 
-    if (offset >> 2 >= IIC_REGSET_SIZE) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "exynos4210.combiner: overflow of reg_set by 0x"
-                      HWADDR_FMT_plx "offset\n", offset);
-        return;
-    }
+    assert((offset >> 2) < ARRAY_SIZE(s->reg_set));
     s->reg_set[offset >> 2] = val;
 
     switch (reg_n) {
-- 
2.43.0


