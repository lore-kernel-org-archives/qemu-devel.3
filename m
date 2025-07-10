Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060D6C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 18:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZvvs-0001P1-NA; Thu, 10 Jul 2025 14:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZvIj-0000oM-Kj
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:43:25 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZvIh-0000CF-Uw
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:43:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so898113f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752169394; x=1752774194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6q4CPzNSFHkl+W3MMlVl+w4aksqgE/U7SNmb7FH1q2I=;
 b=BCpraWfojXPBS0AW+Jilqx8KBYTHh9JUvXoUCsvRZvT00SmPSSPyQnZ64xuHeBnViz
 gA55nrWNXpL1PZgCN8246ATG3EdbvSY6AzgPtfd4F6jBty9NIOkveF5nEXY2J2nIv1LB
 DDMyPJjbAoP9FKSKKbgE6phGLHC9c2UlB8k61fnV0gH7Myd0AHjRVyL94cH9ZdNui6PW
 A6sqsfhj7l/T6n3qDYVmR4FAIfPYSVaLqvGzXBCl7HYUY/y+QweOV1AD4wrow2u6U9yD
 Uc0JJAW0GhN7a/OSJ2j65PnpG0+3g6xH/1Zw7BQ+lVoZGEVKFBQm+uxYpna0t7DvEesE
 +GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752169394; x=1752774194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6q4CPzNSFHkl+W3MMlVl+w4aksqgE/U7SNmb7FH1q2I=;
 b=oBKM+lpI+lk9wtW+Upbi6Vnz81y2cTdvYI6NAmlz5ttFgSO6ujD7oiviur5gz+HMcB
 /VhfULuVSyRSlUmtfuXwNx1pVbJBLkbhw9c+QDohq6nFvqz8JsxUu8CuW0/U/OiwIIS+
 YzOB5psSb1rQEY2WB1udBk7THpsqjj4lqOBOGY2F2TTjilZ3goKaY8souT3rITb7lIgR
 q27lZYER7GGtaRyve+XDIca8OOBxY/JwVZi+qjE9HCFws0llIQFZGH2ihvTDIGnIwSd0
 PaCwNt83GXA4Bh8P1Arlf3Fvz6R5cYUipIo+fDn3JI0+0K1Pll4ix/ejYsR7YXdvpcuZ
 uSUw==
X-Gm-Message-State: AOJu0YzVozjaiFujNnTI11udKGjSDD3NwsM0UzVqrU+0BTI6SCeUUCVo
 9D82FaRaeYKHK2PJeYKcYulf43sZW7J3b7Q3r57cRdrxBiTDzfmYgClr/IJq04lTD0V3EPLfe71
 f9gf5
X-Gm-Gg: ASbGnct/1oUj5bI/3o9cvSetCxT6cfdUKMeAYgVUS8sLGeykGT5Nar/Liu6P0s0bQ+b
 4KEhh/DQsEKVYR87Mi/YSh2hX0L3E9REUUzhYLPFQrkNh0yLh4Bs/9mZ7rbwb7rdMF7H8iToEXK
 uTyvXfF9SItPtI2F1WPeprr8lUhmSFVOe3UnGiAstTvIb5IauG0HUzxpWHXAJGflk6FsNcnlf9f
 ASAUxDisxm5deauoTFspUErZx5Nw8EpE/Cemor6UyhJJ1ZgH72ihApryJ6PMYuafe7LSqaDfu8p
 T7yI7PfAUtgQ6rd3XJ5BkUy0nXs0GPhNuOqE9rUckwoyFxaXp6BrDdx4vhHf+D/hS1kU
X-Google-Smtp-Source: AGHT+IFtl4IKDY7MuYQYNSgDBslWzZxGPAvfiXiQP784ocNiNftXe0k4ZbTTg2zWG/pp+86ChW7sbQ==
X-Received: by 2002:adf:f089:0:b0:3a5:39be:c926 with SMTP id
 ffacd0b85a97d-3b5f18cec74mr348870f8f.32.1752169394198; 
 Thu, 10 Jul 2025 10:43:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1924sm2462541f8f.16.2025.07.10.10.43.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 10:43:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/display/framebuffer: Add cast to force 64x64 multiply
Date: Thu, 10 Jul 2025 18:43:12 +0100
Message-ID: <20250710174312.1313177-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
---
This is one of those ones where I'm on the fence about sticking
in the cast vs just marking it a false-positive.
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


