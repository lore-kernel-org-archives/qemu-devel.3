Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDACC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnvt-0003VC-Ij; Mon, 06 Jul 2026 14:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnvq-0003US-LB
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 14:20:38 -0400
Received: from mail-wm2-x01.google.com ([2a00:1450:4864:31::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnvp-0001Rq-1f
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 14:20:38 -0400
Received: by mail-wm2-x01.google.com with SMTP id
 5b1f17b1804b1-4924661d0adso3091625e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 11:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783362035; x=1783966835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kkYL7LVEShEH+WcyUPe3cPVMKy4CoSLlt4ZFseDbXw4=;
 b=bUuHr8u4M+5bTw2N9sId1yxBIFlKM7cPyKh35DmQq6CVprSlvVBJjnrpUdZbWAvQaF
 nABFvjHAMkq7kOM8jg/n/ZIwhI2t9xQ4U8b8HMj3Xo1n55+qIodx70KMYN7s/mDFU1gT
 DD6kRSVZttNdGw6fAplAVYMpwtIoczBiX3XuTpTtdqgUClf/1XpHAcc72iJ1LTcpln2L
 hY4YlsmU/+5p+Vjj4hKs5NMigQlWCYHj8HVnHWDD5EIm6/kZYn7BV8VwXsgsjHaoZhTx
 pV2XkZ42RZZ1Y70HUcFXxJGEjFkVDntLRYVLAu4/Q06p1xf4KrJcBhWK181BwIQho2ws
 2a/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783362035; x=1783966835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkYL7LVEShEH+WcyUPe3cPVMKy4CoSLlt4ZFseDbXw4=;
 b=pUu4WJLLHdJFC9t9BjFBQokL4VIqkIdBCykqMu8lDLPUqa9EvRC62i0WYR3LyqyHbC
 6dKB02tzQgZyJUPhD0pwScmO1aPDd0pR7e9zTZz6kmkpYscrOEFHP0EqnJGX7YYnbj1l
 e6ivOsyASPJEXLleYu07OMmZMsh6N8XqJaT1URG4LaoTTr3+tUjS665Baibq7ba87FTd
 RHe9CBl0tvOd/BEADuBzzJ5uNeyhXBXZHGNpK2HNFeoqFEsp6lTE4O3IgUCz4AFN6RKn
 FPCPsjucgtRjsw3Tf3/R4AcShhBXH4QvVECak//3pt92wqd8aVSSNsn9LSQ6Dup0RCyZ
 g9Mg==
X-Gm-Message-State: AOJu0Yxc8gAPEomJWl3LgxA2g2EnWjjwj622ZivCkeddCjkGNL37GKyv
 faSILlPjc3cO5nhRof4bdZC2dE8mN/Qdd6VXawnf+ULaR2ejc/Q2p/QExjCvf2kqEZDkOhjYx6/
 boyZdAOQBtydu
X-Gm-Gg: AfdE7cmDCAPUGa/DJ5nwQrQ8D19261FP9GHrMmEBrjfAGprpNkiOeg8fxw2OgFsvhK2
 kB0ifDaiNtAg42Tn0nJIf+01+r0eQqiqZ+aV0hLUXlQ9V6xSTGJ27SebfgwqPQdM+PD/b2mH1QV
 aSe4qhlV5joSVTvfkSE1TOng5sFD6XGXHZWyKG+xF2R5cQpC3PDgeEguD8faX0jDeehcqP+gP2I
 0JhtVCXByNTyTDMWdrDu8Vw41rHnojuJ/uVCAMM+XN7IqVdzktVRZjZ2EBoxEhFYmQxGUr8WG04
 fpjFJ5M8CJb1wLisKUvNyOgHVT5aAuqxg8fIh1sId0lRwQzL3vvDtoVYwHqdsm2UTXpY78EwgVg
 N4nwVbmYDCiMm1qBCwur+lStQ3q68aI2dkyHP8jMn1vGb0taiiz04DHAvJ4Mh0RexaLfH9q7alZ
 HV3gkTl6DQqD75+QfNLPnGp+uQ0ILUoti8A82f3Rvgo5WWtjhnY8lv15lm6jyPFTqrCMeAW/IMm
 KFRgU9JfzlRBPeU7pLTKg==
X-Received: by 2002:a05:600c:6387:b0:492:6eff:7d02 with SMTP id
 5b1f17b1804b1-493df09a22fmr18149355e9.30.1783362035192; 
 Mon, 06 Jul 2026 11:20:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e00795c2sm3183475e9.1.2026.07.06.11.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 11:20:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] hw/usb/dev-wacom: Don't write off end of buffer
Date: Mon,  6 Jul 2026 19:20:33 +0100
Message-ID: <20260706182034.1003176-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::1;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x01.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In usb_wacom_handle_data() we allocate a buffer with a size
determined by the transfer size requested by the guest.  We then fill
it in by calling either usb_mouse_poll() or usb_wacom_poll(), both of
which functions take a length and return an actual length, which we
pass to usb_packet_copy().  However, usb_mouse_poll() doesn't check
the buffer size as it fills in the buffer, so if the guest passes an
overly short transfer size then it will write off the end of the
allocated buffer.

Check the length is at least big enough for the minimum 3 byte
packet and return nothing if it is not, as usb_wacom_poll() does.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3672
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/dev-wacom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index c69e247f7b..895edcc17e 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -285,6 +285,10 @@ static int usb_mouse_poll(USBWacomState *s, uint8_t *buf, int len)
         b |= 0x04;
     }
 
+    if (len < 3) {
+        return 0;
+    }
+
     buf[0] = b;
     buf[1] = dx;
     buf[2] = dy;
-- 
2.43.0


