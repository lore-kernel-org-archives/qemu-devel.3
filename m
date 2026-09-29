Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9339BCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUef-0006wn-8W; Tue, 29 Sep 2026 06:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUec-0006w2-7r
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:43 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUea-00087d-4Z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:41 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843796e373so2268872f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676098; x=1791280898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PbS0rq7b9rCLJ7O0Ftzh16fkbjXLyAaDk8OmpQ6DoKo=;
 b=eoRmYPr0T9N5BoOumBdxizaWxjl7aV6eDo7U9iDbvNzi4UuBjya2CDeh5CWwfHHkPz
 Re6PMkAkVk0Ot1fbk1W7z/ZPI4+C6AUXDSmp+G9ZCH4/X6yvgMuxtdDp+IZiv12fjNEE
 TRrpX3NURlvdnMT6YGH0gyB3i0LMy8b4eMGz8TyLfu9RG6io4jTlenNqQgRI7qHSeEge
 HIctyfS40bLcMI0OzaQR6rU2CYWME/8h3jZkke0v6hvI6t+0SEglea2HOdveeXjR35zV
 e4a41YkhzwWDPhJ2Tu25x7wGssmbTo5ssgDPAwM7Tx9hwXqQaIzEyq6tCAHTaEKUS+Fk
 Lviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676098; x=1791280898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PbS0rq7b9rCLJ7O0Ftzh16fkbjXLyAaDk8OmpQ6DoKo=;
 b=lVhwItuqhaWffyDNqRnX+J5UDtiSZPB/y23eQY/614iHwclO7BUzVzXTgmeMzIhTs4
 4iyi7WlK2iXrqFVtPP3EYYYPS0hsRa0eHqM3iq29PNSvFwUtl/OXIZ0uC6YRyXSkXiY9
 FSBcmLDf8ivNblFk86dVfPhD/hq8LvPXR6C+TbSAyw7mLxiF5hY3lvlMATfx+v5tqjvh
 sHSFWjUxmUmTr/WzAYMvrWtceeVhREiXsT7d/YpuULtWCAi1FtiosGYVJmkWy7kbq47c
 QsSP18N/3VG/kfPGzysp6YsX+kzPPEX9TX4KbpBXXPxLRGo+4AKd9NEm1abID1QwK6/a
 2IXA==
X-Gm-Message-State: AFq9FYL1x5J03ddmKMsAFNZ7jqt4M1QA+MdZh7KHjlikKWR4nVGp0kbn
 Kf1ttARxzqoKe1Hpg7EUQt9uE0sVpgQf8XU79+ae9VRKDzHtO+cNTDOD9ywlsB4yHaN3uyVH2s8
 /xB70
X-Gm-Gg: AYBFou18CRcLOxi6yze5CYTF7Wvy+4oGv0IAmeIppBcpR0mpPSZ3MpElnB6gAgjm4JY
 BnSL2STw4VgzfO0haJqv4YdNDZn2o/9ReuX20RFqll0T3ZjJ5bJd0PGvXShpV5ISpM2uRAvxU8c
 ZMx8/+95NydqpP1pBbd7qqUV81/qE4Wj/w9fHykf9fF0opO7hfzq5gqs4djSmC99DCl0RX7qpcV
 zZlTrPSk3pBv5DaTcagJL73yl+NfQPATINpy0FYpF7rjBxsjYf9ZWdRpQvKdNUc+ChQ4ggooBjD
 cLKcaiAzm5SKhAwKOLZi/ln+NeX9T0lvYTAefhbmvKFCY33zXwyQhaJmfPRbr9rx7+f5Vstg4+X
 MEmCCsNcdvdiagX67KgRLCFvU+rz/U/3CvnWCGjiZ2zqrIv0wbRD0wYGlB16eQF/qsb3rgS3Qr2
 otzdXtZn3A3T7/d1dswLSW8PaQs6XIxGINJvgl6F82NR2e0dPy4SLS7FT4iXWy+zRDWClB/U9Qs
 QSUzGxuPgTEaMG4Ua9J5gjF5QUC/UE3RTwsvyuod70RW9ZvQ7mNdKX+prY+sWDPUnC2NqfN6JlQ
 VdY=
X-Received: by 2002:a05:6000:4910:b0:488:8b16:ab33 with SMTP id
 ffacd0b85a97d-4888b16ae2amr13512859f8f.10.1790676098478; 
 Tue, 29 Sep 2026 03:01:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/37] whpx: arm64: check for physical address width after WHPX
 availability
Date: Tue, 29 Sep 2026 11:00:56 +0100
Message-ID: <20260929100133.2598676-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

In the case where WHPX isn't supported on the platform, makes the
intended error appear instead of failing at getting the IPA width.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-id: 20260916224454.91924-1-mohamed@unpredictable.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/whpx/whpx-all.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index d106400686f..46f0b9524e0 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -879,14 +879,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (mc->get_physical_address_range) {
-        pa_range = mc->get_physical_address_range(ms,
-            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
-        if (pa_range < 0) {
-            return -EINVAL;
-        }
-    }
-
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
@@ -914,6 +906,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    if (mc->get_physical_address_range) {
+        pa_range = mc->get_physical_address_range(ms,
+            whpx_arm_get_ipa_bit_size(), whpx_arm_get_ipa_bit_size());
+        if (pa_range < 0) {
+            return -EINVAL;
+        }
+    }
+
     hr = whp_dispatch.WHvCreatePartition(&whpx->partition);
     if (FAILED(hr)) {
         error_report("WHPX: Failed to create partition, hr=%08lx", hr);
-- 
2.43.0


