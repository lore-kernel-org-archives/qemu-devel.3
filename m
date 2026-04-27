Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECF2FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUP-0007IM-P0; Mon, 27 Apr 2026 08:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNw-00087F-QZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:31 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNq-0005hZ-NP
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso107050295e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294095; x=1777898895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A6daU2nmrlZ4Sa/74iSVs+RucwjBTPr7uTOaBH+QKpw=;
 b=iCdMYgObo3xF0lZpDBP//5SL40cNVWkV6tDq9ljLTIL5NxL0WucDYUpkfsVovrUltx
 dU14fk8Oak9G3KgrhOb+nX3gI3gslL6PItu6bB6QkCkFCYLGYKaDESNbw9ntWKrjDeOC
 kyefeNm1az1f6XHmqJI0LSj97wxPbXuw6Yrdpg8XeWkvq6s65mgY7VdkQgTxY61XK5PW
 AO7oLqbpqTfPF4hACyAKmW9YCkNyvJvEPtnJtT8mgu/fm3pBYSAx6TMDrL3O2160wkMD
 1eTyaSo2wEHn/QqE64rZqnR8kmV0tCjUt+WYqSfjfigdMQU3oQfzYbVFW8jwqRAJ4YR6
 VcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294095; x=1777898895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A6daU2nmrlZ4Sa/74iSVs+RucwjBTPr7uTOaBH+QKpw=;
 b=H5e5GmNgf8SyWfIuv5qHHz7F3B8CVWdRQ7U1vMKwiaGMupWYDM4VJ8QIvacEr+ngfB
 NxAj7oBVnUfwMm9FyPsJ/KwuBY7Edet+gAE1TgekQoK70Je09v4Kjv85RUq4d3rJtM7G
 m18HfEO8gxF71fILQS3fhv84awdyNppBSGF2S7Bm07lE0e8P6gNpbtJbzZN7GlJDbBzb
 +dQU3N0nM0nsl9flD+hmlgF5VRvEBJPUlntgJuKyf/PZF9c0eSfcb4ks5fyBfvugR+bg
 vMZPpzZZzTsEYgPhhwSJWe2Iu5SwUZwy8mVEXu0kHxlOyZCh8qTc8LRHigAtkyasCOHQ
 MnhA==
X-Gm-Message-State: AOJu0YxQ9/bse8MsJdKHZhk1rDOMQLW1jN2fcVd01ZCKOgkQ7f6yVwn9
 iTr5z7RFVH8NQCiFKpk4UYy3PPnM9+ajXK+9nD9mNhGbey77jDd9aXtHzMYylVkEBx40cuE1rf+
 6kK8I
X-Gm-Gg: AeBDieucu0MxJAhxDeRj8DqhYR7Ce1SnRQ/B9WpbCf+PE/9/U/KjiDI6n5swx/efH9f
 LBJBRCVHlm6napB4LNtFxowshV0B42BhcT4X0MF28rI604EFJIZJdtCyh3F5bTrFH/xDLgkURro
 bSgnngwSATXGInwlIKRr8ULGM+Eudbrfbklv+wuZ7ZnfwGMfUT6Ry1Y2xyzRP7mltgtZem2TH6i
 gbQs2KC+/mtcYkj2iiwoIoPS87c9r8g00zni1KUMrqyYz39MFwSJnDirYwmuDAYrvkcg+MYXEYC
 3uOla8AWnJWZaSAzOk6k4KxUo4Q9GVU6mchNUgJzpfRWr1EQnl9kk+W2HFJGKfY1aQOgSHpNvEZ
 6VBedWJNpAsd8mhxS0HZbJ72+Q/S8wps6njU48+ts6RbIkoNYULkmCnQsXwGzII2ENXorswCsEP
 C8N7MGTnqWersIYKaejuCn1Qdo+fdmKwyGOPBHf2Z5d1nZlpahQ5FmtTrwGq1KnzXHs92Pj+Sep
 f/f1Jvc9QhtHRdIiPrU7BDnW/L8P4mWg8DM2mZQoA==
X-Received: by 2002:a05:600c:4e4f:b0:488:ab37:b442 with SMTP id
 5b1f17b1804b1-488fb793c6bmr620329115e9.28.1777294095029; 
 Mon, 27 Apr 2026 05:48:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/63] hw/arm/raspi4b: NOP all DTB nodes when removing
 unimplemented devices
Date: Mon, 27 Apr 2026 13:47:12 +0100
Message-ID: <20260427124738.966578-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Osama Abdelkader <osama.abdelkader@gmail.com>

fdt_node_offset_by_compatible(fdt, -1, compat) only finds the first match.
If the blob has more than one node with the same compatible string, extra
nodes will remain active. Remove all the matching nodes, using the same
loop as imx8mp-evk.c does for this purpose.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Message-id: 20260420162114.308519-1-osama.abdelkader@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi4b.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 3eeb8f447e..06aeb8db01 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -72,12 +72,14 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
         const char *dev_str = nodes_to_remove[i];
+        int offset;
 
-        int offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
-        if (offset >= 0) {
-            if (!fdt_nop_node(fdt, offset)) {
-                warn_report("bcm2711 dtc: %s has been disabled!", dev_str);
+        offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
+        while (offset >= 0) {
+            if (fdt_nop_node(fdt, offset) == 0) {
+                warn_report("bcm2711 dtb: %s has been disabled!", dev_str);
             }
+            offset = fdt_node_offset_by_compatible(fdt, offset, dev_str);
         }
     }
 
-- 
2.43.0


