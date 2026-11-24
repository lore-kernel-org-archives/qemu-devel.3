Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4822606A33B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RLDX/s+K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVnHF-0001Y4-9S; Tue, 24 Nov 2026 04:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnHD-0001Va-Md
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:57:27 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVnHC-0007sg-3m
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:57:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so30961755e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 01:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795514244; x=1796119044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cUq+tBJuWvYbYB87vR6bmhejStGnV5GUaHvT/ZdmaWE=;
 b=RLDX/s+KiYjfYyw3mMSEH4TrBFRcH4fwonD+3Jnujy+LPAWSujJy+PkxN9DtD4i6Br
 EAI6tBsmpk1AIck4DskQkXUqxGH4rTEuFsA6Liuu6rpCFLq5kuCOfClsdWd4qa6Pch7g
 ytciqcXu5amK5KrIgFju4oKOozr1JzGsGyJpeSNvrPRHswYwCHEByvVU5J+vwSAFi1i3
 GBNCwUgrSFfDbgHWvcyuywbZgXcBhTEfaOMqRDdmhdHjRCkR2EFrJ7WXMBApvdwI0mjO
 b9ETEDA+XqImGCStif3K9ebmzZ4wKqvRjv5hG8RgOgtxDN4djRy4yJ8C+ggM2awJFhiQ
 qqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795514244; x=1796119044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cUq+tBJuWvYbYB87vR6bmhejStGnV5GUaHvT/ZdmaWE=;
 b=MUpJhNlKPH2WNDn4BCd2d47DVFlEpq7X7VzlcVX4Ci4PYsvgClPMWMATxbopxvQ8hw
 O9dNOCFoEGaEiphslOIw5Uh+iVHvRcKZF8QZ9j4a6agmFR2GQJU3lLI41VFVCFSneTcX
 O5raKLacTM9fxmyygpU5pg08+dS3OXdUCYs/XaEbv6EUpSPht4SMZkxBWyrxXXjP7aF4
 cvBIidYwt/GebjA2uRCaIyFS6M8YPjOgFxbcDJ1veIBfyjZCPfuiID6GL//5z3L7N0m8
 VfP5qqqwrw6UuVQc+h+51xAImnKBNL9ELGfWNM3aJC+PNAZ3oQN/O67kR9MMlVNLhwJE
 BnNA==
X-Gm-Message-State: APuU4Z+kLGxP3QhxQ0qZOL8q5Y8UUy8ty6+Owe656r5fpGMhbMNYz0AM
 8VRH+kIXmmDWpx9nDMszX5tZjhV7Z7GwLW6FtBpKTvol/QFFn46Sc5s8jta8hS06vPO8uH5WWFz
 k7day
X-Gm-Gg: AZFdTZcQIqWRKfST9OMHziJk16Jea1W8+TsNVIJkwM5FiBIv8hmL4yNEy8LTN9Cl2Sv
 DejbNqPck6ZAlBvUHi4tr1yTqtSP6Q5WjOXy3MjZOjyunB8w8jaStwC8LMz8gC6a1pK6BaO7sqc
 ABToWjeLISOhVvO7h45nB5rjj6RjZB5hI9FRlXJoP0/vXvzQTJe9TPurr3XVPTyCXkmFoFy/QJ2
 peXI97LfIm/eeSm/i0bglhXVcJujCBBBx7bkKHy5A9UGHBOwwx0BAB9OOEO+sY9et7cZvJ0UZ7P
 xygxeXJVhjla1y7Lg8iFxPYVpLC1RTguFsSZoQg5HLclP2PglQ8qLhbe50DOqxZNl2NMmDGpts9
 ocv3kOg9OnU8Qau+tqxVZsNjcqou+slT2wRBYEmoO+WA9vizrigRLynsIu1mxsAnvt/bW8NXhgx
 7KCvOo/wQzk5go2wlIlJMoG3qkC8PtBgzdZKoaIqissU0DRVqpQKWPUXCZH5S3upGCCYBN5l9MF
 xcky1vOEc+AKVWc2jSk+JnGTwH95zXlweVxAdziCVUOFq1shoi+KVCeAyMu0CmbSbbB/82kI3Aj
 Urh98YZryTeO8ywDsDNVlqZ2iqgg2+UB8SnISOz3SEmtyGJC2hiBNQUVdFDItQqm2UpxsM6Js1H
 FMHViQucEv3RdEBEJmgoTvQQVQqFXDL2rFUb96aOh021dCcUeIEcXGrI=
X-Received: by 2002:a05:600c:1d09:b0:4bb:73d5:ab33 with SMTP id
 5b1f17b1804b1-4bb88816acemr309754535e9.22.1795514244649; 
 Tue, 24 Nov 2026 01:57:24 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm783591885e9.4.2026.11.24.01.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:57:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH for-11.2 4/4] hw/display/vmware-vga: Check incoming migration
 width and height
Date: Tue, 24 Nov 2026 09:57:19 +0000
Message-ID: <20261124095719.4126146-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124095719.4126146-1-peter.maydell@linaro.org>
References: <20261124095719.4126146-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The vmware-vga code sanitizes the screen width and height when the
guest tries to set them.  Apply similar checks on the incoming
migration data.  This prevents a manipulated migration stream from
being able to cause us to create a surface that exceeds the size of
vram.

Since we already put in a check against creating a surface that
is too large, the checks here are for:
 * ruling out a negative width and height
 * catching the issue and failing migration rather than letting
   it pass and then coping with the out-of-range values later

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3870
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Ideally I'd change new_width and new_height to uint32_t as they are
never negative, but I'm not sure how to do that without awkward
contortions to retain migration compatibility.
---
 hw/display/vmware_vga.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 263a08c9000..7f6cc70a0da 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1211,6 +1211,11 @@ static int vmsvga_post_load(void *opaque, int version_id)
 {
     struct vmsvga_state_s *s = opaque;
 
+    if (s->new_width < 0 || s->new_width > SVGA_MAX_WIDTH ||
+        s->new_height < 0 || s->new_height > SVGA_MAX_HEIGHT) {
+        return -1;
+    }
+
     s->invalidated = 1;
     if (s->config) {
         s->fifo = (uint32_t *) s->fifo_ptr;
-- 
2.43.0


