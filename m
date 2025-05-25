Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434D0C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 16:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDoK-000201-J9; Sun, 25 May 2025 12:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo9-0001pd-55
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:41 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJDo7-00037P-GW
 for qemu-devel@nongnu.org; Sun, 25 May 2025 12:02:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-442f5b3c710so14753125e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748188958; x=1748793758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQn6nujfDXJziLVy4jFPVSDzZo2UJbaBzGcbgRQnjJU=;
 b=PZPEefaJnr5EdNnxJ8jod2N6nPwHC9eU2NTvMIZu11JNFEC++UC7gdI+Sk6LFXHtBT
 10LJ2ApOgApPXhz9lBt4p1YfWewHBXkfXci1tDsX+cxljPXb027oagIV7h4WOfqP/XEi
 F/8PaewSJpAlEeM5i+74ZJ7tFO2suWG6IY/BiJhbun9G5F7I8Z3NyaWcgitBn43mkHiF
 3RT5l5i3X1j4RlCUGnrobk0Ob0sYwssGmHBpwQ6oScpiO1yfiX7bh3Bzu4AV3+6kHogh
 LwzW9fo/iAkx0FGo9LzgxedtNRLPWOKR88kOIefd3qFXOpP8h0JZVvcqzV9zRY9L1H8P
 jM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748188958; x=1748793758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQn6nujfDXJziLVy4jFPVSDzZo2UJbaBzGcbgRQnjJU=;
 b=wVzQoY9Wpu33Q5wFQolRSXZ8t3s0lbwWFgJvuw4F8sMGxBivlHaXBKFjWmI2bbgc4W
 Hq56uuT1pEJe/ClUb5im/bcPmdqO99rw9bGLktQHt48tWtNBVtlp7vBZWb/cHYpeFntR
 9lhKAX9NEajhctHMIKRsqTzAyzR5gT803VPMEzs6z8awz+gC44XwUTxK8LjK0JcAHdI7
 yXi+1lUWH5LTpSGf9ZbCN1ysS0EAr9kTapQz9iT+9mz85nGvQakWK1EDctR+vgZ6pM/u
 nYLhmPIrOg7PzjAJhO11YHQfPXvWASvJTXrPFudIKLa9B7gEmSP1Dwerp9dhb6zGe8Pl
 FISg==
X-Gm-Message-State: AOJu0YwtPVSirxlfT4NevBUJyTtU4eFFoIIZpQHm6VQjKAZQ9XDEQVOS
 0feI0lnfU7TDBo4Wog7wV5hbysunhDvIpwel3wQnYyyRSkoW5zbpLmB7IQywzOTbrfoYocO4Mob
 xYJDUHR0=
X-Gm-Gg: ASbGncsuTMeW8BYolk+4Ni2QVsGgaJVe/bKWNcex8JACxKKTdxx5cVByJxCK2a8f6M3
 la/3ByBHwHp+g71vxbIs/OG8q8WgxLbTJtjtIY0C9xvPYO722D76Ek/bQ0gQzwN67ayAqWkduyf
 wYSStOJXA4dj4LrxiVsf9AeK0fxWdI9tQ07nrFIaeiDuWHgySKxK28q76JW1KO1IceB1sYBG5vi
 Wv93b5rrBZat+8XnY9c9d2sPyDaWkJe/807kdO6mRrk+5eCsU+NyweaMlBFZP5ykuQm0MHbtfJL
 cFR1iGVCNuksnoWSehv83C1SbGAvq5/RXgn2yplF8G4eZxmFXihNiRZL
X-Google-Smtp-Source: AGHT+IEI2Wnh+hLBuUAu6qaKL4PJLChM+Hzmv8sJreBjs9OuyxU19XJ1mlX9bDQF/axqCeiirjDbkg==
X-Received: by 2002:a05:600c:1d0d:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-44c9160702fmr60834985e9.2.1748188958114; 
 Sun, 25 May 2025 09:02:38 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f73d4a3csm215772545e9.22.2025.05.25.09.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 09:02:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH v2 08/10] target/microblaze: Use TARGET_LONG_BITS == 32 for
 system mode
Date: Sun, 25 May 2025 17:02:18 +0100
Message-ID: <20250525160220.222154-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525160220.222154-1-richard.henderson@linaro.org>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

Now that the extended address instructions are handled separately
from virtual addresses, we can narrow the emulation to 32-bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/microblaze-softmmu.mak   | 4 +---
 configs/targets/microblazeel-softmmu.mak | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
index 23457d0ae6..bab7b498c2 100644
--- a/configs/targets/microblaze-softmmu.mak
+++ b/configs/targets/microblaze-softmmu.mak
@@ -3,6 +3,4 @@ TARGET_BIG_ENDIAN=y
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
-# System mode can address up to 64 bits via lea/sea instructions.
-# TODO: These bypass the mmu, so we could emulate these differently.
-TARGET_LONG_BITS=64
+TARGET_LONG_BITS=32
diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
index c82c509623..8aee7ebc5c 100644
--- a/configs/targets/microblazeel-softmmu.mak
+++ b/configs/targets/microblazeel-softmmu.mak
@@ -2,6 +2,4 @@ TARGET_ARCH=microblaze
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
-# System mode can address up to 64 bits via lea/sea instructions.
-# TODO: These bypass the mmu, so we could emulate these differently.
-TARGET_LONG_BITS=64
+TARGET_LONG_BITS=32
-- 
2.43.0


