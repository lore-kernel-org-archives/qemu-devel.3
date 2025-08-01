Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876F1C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtWd-0005ft-G3; Fri, 01 Aug 2025 13:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3H-0002ha-W3
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:12 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3G-0000yf-9W
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45629702e52so4359035e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754063528; x=1754668328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VA9zLG3hIwrKZfYHg8vSBI/hR1razhF0Nu/W6W/sq9U=;
 b=OKpm7Dezbi8Ey8zWiGRnfASzz+lap2Az7cgkDfvtCZc1Cr9w7x8kvoMnddxIUCpwHP
 tiGcSQrLNGKpBm1TXNEfEiBMPETvsj3yja+GXoNp5mNnOPkZMgRIMGNUlIr8fgWwXTiL
 GCFgAYEdr8kUKbvR17j4KopQNAsEck7K1YXL4GhhHDVoY3L0nNO2jvKdtYIqEMm2Cxie
 9gBry/hrJEWeVDrRjSbDr2ZEfNxJOUBzH+V1uR5x2aZbzRvAXYE+LPyO1iKlh995O664
 H+l787JjKqUcJgqsWLyl+S1uEF8u+c6ZrP07YhvI9Tx/uJrZDglwutg0wIcTXGK0UnYv
 35pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754063528; x=1754668328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VA9zLG3hIwrKZfYHg8vSBI/hR1razhF0Nu/W6W/sq9U=;
 b=mwH4gW9KP+Q2sKriENVhhW/uri/t64iTJ5a+2JbYUJABrzDGnyEuuRwPS8BUqOd/f9
 Q0mWEB2iF0WD4jITPVIMg7OiF3KV+o4Xu9B4qUw0tOPWshk+DwQ3zKrAyQ8jMLhi3U83
 HpDnbD76U1xEbcrjpAAJkXNKM84AQWciTU7K6AdTOOrIp0A9wsEidXrFPtTvcW5EFQzM
 g5qMgDe8wfVXdeyP67x5QA0+cVeJCWn/crNfm7XZzfGH1+mBBMD80PZSd9F8FQo2WbTL
 pQf5fwoah68wI4u4AD1yaHGaj3iHzvNt43z/7Vw7+GgPUPN/NMrgWkeShuiomR18ysGL
 8znA==
X-Gm-Message-State: AOJu0Yxhd9+tl8qJZl5I8EhaDq7N8VepvUqaZH9p2FQRSIbrjo+Ql5FY
 +XVh92WSVgRvuvanELrY+ED7VOSPvkRubVPDN8lSMV66C6j5fIusIIf7Y2Su37sHOyH36XTzje4
 BqNwp
X-Gm-Gg: ASbGncvouQXcWfGK/MNPTNdaJc9pFnvj0qxLq9Wki5itpcz8+uVIKt6QSUdE4YZjD4J
 b0kmBwOnzhyjm//WtRFnQl9/56VTPmIhbRq2pKrVdW/tHqZeRUHGSzc3j3+px+T1vFsWANWBooW
 4zo5nCfLRFfCE9bS6VWk+sYVSIvgDnY1aekWEgii3ib5kmfAVHaK16VZpO321PDRYISbELae9Vy
 A5ySLSFYsaecW5TOKGA/yMM2NAj+juKSvGJxbGD0w3cPDGNjHiulWSWTLjENS02Xd1AKN5U+jFN
 vryfg/S5whsvO6+PvWXp4iRsO0LF6Jgt51QzAZIKKkTuqx2+xW2ZMkufvrUS1Yx9GLVsTX3Qj76
 b8ev6RjuTLjgKfcBhkI/rxnRNNthUXJr4WbBKvHw=
X-Google-Smtp-Source: AGHT+IE2aMGX0ZZVL2udJYMuwCPwJC29lrNO+BJWY0e33zLCxbyA95h5aNcLqaZ28oLmfNkTthzE8w==
X-Received: by 2002:a05:6000:40c9:b0:3b8:d138:41d3 with SMTP id
 ffacd0b85a97d-3b8d94d01c0mr241931f8f.56.1754063528459; 
 Fri, 01 Aug 2025 08:52:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2f03sm6176670f8f.72.2025.08.01.08.52.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 08:52:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] hw/display/framebuffer: Add cast to force 64x64 multiply
Date: Fri,  1 Aug 2025 16:51:55 +0100
Message-ID: <20250801155159.400947-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801155159.400947-1-peter.maydell@linaro.org>
References: <20250801155159.400947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

In framebuffer_update_display(), Coverity complains because we
multiply two values of type 'int' (which will be done as a 32x32
multiply and so in theory might overflow) and then add the result to
a ram_addr_t, which can be 64 bits.

4GB framebuffers are not plausible anyway, but keep Coverity happy
by adding casts which force these multiplies to be done as 64x64.

Coverity: CID 1487248
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20250710174312.1313177-1-peter.maydell@linaro.org
---
 hw/display/framebuffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/framebuffer.c b/hw/display/framebuffer.c
index 4485aa335bb..b4296e8a33e 100644
--- a/hw/display/framebuffer.c
+++ b/hw/display/framebuffer.c
@@ -95,9 +95,9 @@ void framebuffer_update_display(
     }
     first = -1;
 
-    addr += i * src_width;
-    src += i * src_width;
-    dest += i * dest_row_pitch;
+    addr += (uint64_t)i * src_width;
+    src += (uint64_t)i * src_width;
+    dest += (uint64_t)i * dest_row_pitch;
 
     snap = memory_region_snapshot_and_clear_dirty(mem, addr, src_width * rows,
                                                   DIRTY_MEMORY_VGA);
-- 
2.43.0


