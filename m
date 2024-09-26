Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64377CCF9E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 10:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stlcl-0005Rm-Ff; Thu, 26 Sep 2024 06:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1stlcf-0005ON-GE
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 06:21:22 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1stlce-0000ME-0h
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 06:21:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cba8340beso12190035e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 03:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727346077; x=1727950877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ARgJuVYou0E4VVmswK8zO7oNcaiQjYHO4FNJULuCZqY=;
 b=Bly7Skad2DmbYApu4HjJ1YUXSvE47c+yulK2w+XeSEaqh3KDSbvrgUVt3XCsV+4xAc
 HNQYAdlkbGoH+7/RbxoV00/dXB8Y/9G3SjPN0mT3dLgrZF3f7MOjyPpNcqRvc8zBTsvE
 sWP28AZ1kZPnJ2pMzIvnwXk/pegIDJhkKRNIhuOLyDhH5L/1a8WKHtnwa0oyFt6Bw57W
 bFM0wEMkRyxJp52y67JQbvM0sw/i/AIKUVqcXD7kx+d3Rffzk3hmqdUpJBXFT44H+dq0
 +C1D7dCcP2ASsSVYHTAAfJI7DAHYBcjIqGM8fdB1+8Wiv70sUYtY1m1V4jts/QKuiF8M
 Dn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727346077; x=1727950877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ARgJuVYou0E4VVmswK8zO7oNcaiQjYHO4FNJULuCZqY=;
 b=HyiytIcHcyucJOAkXpu43ZlfIGK4VPMBWcRLHI3g18AgvssuR3iyqPLgKKlLiCAHCq
 LFymG5oqFqFzKklN8RRLmhkvb6yBCqqLRhS0fuZtHUDCuK6qGr2Rpj8hwyAT3hTW5zT8
 dUfDf/ajcQmGMKYHPpKAx1xo/trvwDAyRNMMg7J0frqmkabcjmwEowiGZJv8CBv6rFcy
 /Kq0ZHJYHU+F+HhM1Fcw6/HY2duGVYkss9NAQHXcwH9F8FvlEv7EByHkzunYJT9hoHzu
 LJhZ35tYEhD8y4339+HtGWZaTk6tyWzlFjdLooVYtItkL8CxMg7CP+iv9QdBQm8QYQcf
 W1sA==
X-Gm-Message-State: AOJu0Yw3/5omX634C2apJ9kg8G0l9MKjb9iW9SDZjk4nVx9fsxXeo0x4
 YzJmBJutY9JoOsztA4aXnUjAP3gSTCjbOWnVlHGOB6cWtT8yXocGxHFt4V9c+Ft/MOjNSNsDM/V
 9
X-Google-Smtp-Source: AGHT+IHLxGe33Ku/mE1BNbe3bmPbTA/m1VzdjLq3kcpNCSLVX57xfGFuUtjUZdaSLwOj4PCSLoXqQg==
X-Received: by 2002:a5d:64ae:0:b0:374:c2a3:63cb with SMTP id
 ffacd0b85a97d-37ccda72703mr1930694f8f.0.1727346076656; 
 Thu, 26 Sep 2024 03:21:16 -0700 (PDT)
Received: from localhost.localdomain (120.171.88.92.rev.sfr.net.
 [92.88.171.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ccf3a4716sm1302184f8f.65.2024.09.26.03.21.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Sep 2024 03:21:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/audio/virtio-snd: Remove unnecessary "exec/tswap.h" header
Date: Thu, 26 Sep 2024 12:21:13 +0200
Message-ID: <20240926102113.64890-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We were including the "exec/tswap.h" header to get
target_words_bigendian() declaration, but since commit a276ec8e26
("hw/audio/virtio-snd: Always use little endian audio format")
removed this method call, we don't need this header anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/virtio-snd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 69838181dd..c5581d7b3d 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -20,7 +20,6 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
-#include "exec/tswap.h"
 #include "sysemu/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
-- 
2.45.2


