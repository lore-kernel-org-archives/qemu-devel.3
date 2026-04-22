Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B018FA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdmi-0005sD-Lv; Wed, 22 Apr 2026 16:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdme-0005GP-CL
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdmc-0003eL-9o
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:02:51 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso65393915e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888167; x=1777492967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AzwG6LlXbqN4uYPpa/yvese2++HqjXKnD1CRZRqX1bY=;
 b=wHclXI/2p3KvEZg8jz9CZvIgO7IOtDPL3zDd6ZD8J31er4/b/u3kn3sZRJYm/qnL/k
 AIGFU+0w8UC8657UIbmb60e2JN145z3THLnwAQJwimz2yxgnd9mcllgXWMFXHDXvqgrX
 hLPgQe+qWoXo0Q53bgzSueNxLck+DeEVjJP+eVmUz3/TqSXmrWoU0rNAteaytzylci5V
 LnQX5Kf/R8pBGHj/rfJuy97jHnOfCkkAaH3elvHwQq7zvYYHRc/g5ToYC1zh852H/rRd
 Hkr6hMLrQQl/MQrhPCgjE+QXZF5rRXTqE865kwhz0HAO071RMLASz2wv8vxERfSBZDUz
 KVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888167; x=1777492967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AzwG6LlXbqN4uYPpa/yvese2++HqjXKnD1CRZRqX1bY=;
 b=ItHscfLdlx/x8MtOjRGx4qAl64m2tgHq2+KnrbvxH1hjggZv2ai9L0D6UEjkgZKWPF
 OeVE1j8t85F2yoS97AhQPE776pHoEHuLNbDKOUNsvHE1a8d27r2A224FLMlT6tQrhBE0
 OcIA5Q/Lb56KQo/CXoonBXKhwKWIayXMX3c9nePwrECGpzNw9c+BvU3irgFNaTkdI54i
 WdYrRC7tTnlUbgNbNCHcv7J9yrqsQctnNL05+U3v5KseNQ5KVWcVELuP+3fuPnMQ547S
 KcYoOeIS4kfzX0XWTX5fW3kfApiNdL38Ql3H6TT9ZXpWPPTMD2X9HsWOeE4diHN16wyR
 1pnw==
X-Gm-Message-State: AOJu0YyZ4SyGw1NmfTk1RWQG106/pOBidzpMvYeu+W6QepZV7UEVU3yI
 FtfNXmW4kjZHueSXgpAo8QCHg2SAdhNBcQ6SH8tK8xXfhjkCSxfBVR+NltbBl8j39mfPM8eGs+u
 tbE5AuDI=
X-Gm-Gg: AeBDievcuswWxNREXR9R4fxWpMAcoPkdOFOGjW3Vp6eCVP+Vpr2/fm7f4KVg7MDfNho
 aTRnycxM1SpsGXdMq1SLgS8LDoDc5jd330Zkf+UkhHUwb/SHoEQHqRHQRMkc3FdQ7bb++Gc91nw
 v0Mqg9DT8JbPnip4NIJOh5lCAIKrhnSdzScqyPYUFzK3XHOExBCQxGKZkZPC3ppAHhB38cMM7uf
 nXH2vYpA9v1dpGIVORfYwCH1sKVFTxGwG0m2p59qOxxyngXX94sS7/i8l05DdTgvnjHLjqDEU2B
 TojTJkKHmn80BIJ4PQrtUGZ8Td5bZ/ltN/lpSgniOpjbajxhFRcq86zjscTym+c2VhzKh9jP9kH
 Y2fLZDsYMDgpZMvRacbSX3s1wxPJf5i9YsVVPVELQPz/oXAPS1GUujr5jb898tKwN5yQmi8zkG/
 2HGDjiynPQNA2bEc1aW0BNcTU2/jFcm4spxAzvRhkqpsgyukthb56luUExxlLmGJS8S5VxmhPiy
 QKMYvB39Ps=
X-Received: by 2002:a05:600c:3513:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-488fb77a3a7mr348198115e9.16.1776888167491; 
 Wed, 22 Apr 2026 13:02:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c0354sm439083005e9.11.2026.04.22.13.02.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:02:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/48] hw/ppc/amigaone: remove duplicate include
Date: Wed, 22 Apr 2026 21:57:40 +0200
Message-ID: <20260422195746.88865-43-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

hw/ppc/ppc.h is included twice

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260420164058.335872-1-osama.abdelkader@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/amigaone.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 8074713fbe9..9fba5ca03a6 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -20,7 +20,6 @@
 #include "hw/isa/vt82c686.h"
 #include "hw/ide/pci.h"
 #include "hw/i2c/smbus_eeprom.h"
-#include "hw/ppc/ppc.h"
 #include "exec/cpu-common.h"
 #include "system/block-backend.h"
 #include "system/qtest.h"
-- 
2.53.0


