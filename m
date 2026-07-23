Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDC0C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnRT-00023F-PF; Thu, 23 Jul 2026 03:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRF-0001xM-Dq
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmnRD-00042X-JM
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 03:01:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49555a0e68bso1202805e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784790106; x=1785394906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=njXFzolhxF9m8wpOePYV3zpTWlWb14dNREPPOWvkdSc=;
 b=BpXX51Tx+bluDBUbmRtFq5NM1VLCj8k3bC3GnRyHNvPiQbrG+CBDWsEh1rTnFcPH7q
 IyD91dcVeP36HZodjQxKSYcou0PK0wIz9PTF64P98+rpEwIVI83MSsX/pzth3YrQaFT1
 NfSsgVzcw9CKysH2q4zHy55naBRZorDOmBHW8xWBp1O1BwD6iYAl3n0hHf4DB+dYmsdL
 OBP01BIJiClp6OQsf1AlyR0KIZI3Qg3Kz6RdKO7BcKwbe7GeWzKqRNIBZGyf+8KDQMuc
 EeHATBGZD4BlzFH/VuP2f33BU8pQ2HTIqbXrTreYAjgOeNvs5qvTMRZ7x4LVSS7hbxGC
 jGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784790106; x=1785394906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=njXFzolhxF9m8wpOePYV3zpTWlWb14dNREPPOWvkdSc=;
 b=m9XDzYA1aziBYqYRSYZZVeXOld99j0FaxnLIpzrgTv0PVso+Qh0mWTCi6VKmLCWhF1
 rR5TfQCLV68XMSIKbQroPdhqU2WChMPCtDtBM2AyqUHDyiDwsQAQsWsoFEdzMQYWYteE
 LSUhMgn3YG61nzbZfKmTmZQYcvXfSnehfgt576lRaN3Tu4uZtkwOU/Ai/kkQTOHKstht
 TPMz5v56vM3kLv+ScwcYoj5v4nyJIJBbtThqiw1F0csPFIcsYXqgXwzNP8R9ETYGOw0A
 5S5Vg68FzTfXspXsXQ0UEPby6m3H2SUP/xyukjaO+NP0i0wv9YQBi7di4d/+5tGicdID
 bKvw==
X-Gm-Message-State: AOJu0YxuxTq7OXkzqoxwQqW4A8NQrfE3ICgpWrFUotDPjZePT0Eo4M72
 5b7D6wXLbjUXv4SkUsp85FA5p+yoIrl+ou82ayJb4/zYruuf+s9HTt38s4GUvg==
X-Gm-Gg: AR+sD13YvvOsSZsJqtt5j0uq4BP3TMiAYbrvTRlJzncHJeELnWr8mkpx+JafPCTBKbY
 vRHYtKhPFNz3RJYKEeJuzijIo+VnA5Cg6B8ekjho84xFQizTE5/IzfyBa8D7usKqAawOtVagFxh
 dITqdO0ltKKLekTs95KvzvpAcpJHd3EiZXJwP8g/L3e0wk9Xfwro+cuFfVS6NDQYzXg9JDHO6VO
 4XxNJfkeDoym7lsTPn6PbqdOuJy2SV5QOyhFg0Clm/3quS2dPIkfgzlj2BLwBY+nbUbmnfUMbUE
 X3FScOvFNe+POhWa/bp0D/TysRlDE4AtsdvGxFpBu86rMOh4/SI4WoE6VRKDJ8Q3nfTAJNPTROT
 5Qgvm1e0fVHRYyx61wOzxOGdBH9oCY1+BX7tP1tKZ4z76wd0NXfL7lpKUSUhCGs5/iM/NbA2TTu
 HW4qYis1I1ZH0SznhZ4tp7uNZyV19Vyt5Pu5C4u0lrPesSUCkP6UbwhUr3lGGDX7oE0NB4gBzRb
 ZEUylgfHxdMsJ/62Fko5G5ZWg==
X-Received: by 2002:a05:600c:1f8f:b0:493:e365:ace9 with SMTP id
 5b1f17b1804b1-49573c9af36mr15807695e9.11.1784790105841; 
 Thu, 23 Jul 2026 00:01:45 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-29ed-6000-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:29ed:6000:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm13293923f8f.33.2026.07.23.00.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 00:01:45 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/9] hw/net/can/flexcan: Fix out-of-bounds access in
 flexcan_mx_rx()
Date: Thu, 23 Jul 2026 09:00:53 +0200
Message-ID: <20260723070059.6332-4-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723070059.6332-1-shentey@gmail.com>
References: <20260723070059.6332-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Require `last_not_free_to_receive_mbid >= 0` before indexing `mbs[]`.
This prevents a possible `-1` array index and fixes Coverity CID
1662790.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/net/can/flexcan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 3a97edf7a4..dd92a38337 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -1075,7 +1075,7 @@ static enum FlexcanRx flexcan_mb_rx(FlexcanState *s, const qemu_can_frame *buf)
         }
     }
 
-    if (last_not_free_to_receive_mbid >= -1) {
+    if (last_not_free_to_receive_mbid >= 0) {
         if (last_not_free_to_receive_locked) {
             /*
              * copy to temporary mailbox (SMB)
-- 
2.55.0


