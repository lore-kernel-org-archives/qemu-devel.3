Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCA8F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquf-0007vL-CO; Thu, 23 Apr 2026 06:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu9-0006Zh-Pt
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu7-0002Pc-OP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:29 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso4439658f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938606; x=1777543406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x7v+y/r7ud8TkOZ5YHxxZT1br3uJMt6yufYYxuHRJwA=;
 b=hDXbW1+hZG/A9PO0z6Ybf5iGITdb0zkGIS4io+AurZxjAfF+YIGEQe2s+2iNumEO9c
 PNGUelAdQ5y0PVF4Q0VyJQrRqki2kfsEyfu0cOw68qcAXwx/rc7ZvvVqrdXXubeSAlWC
 WxwYIGO/3y2vqx7ghtFJ4mzNUIfeOalZ6NrehibUt9S6NECBe/+tfKUSuJZS89vtGXqV
 ZUCcnntg+dScin/xNoJr/4FI0V+xjLeR45SgU7llDoB/Iz7nRnyOadLMDMTfp7rs8jaF
 QtV36GVOAjoPQf5+EstB5wTV/QJBHC5gf8cNpXpXZHx/tt2ir888zHif92HWApyQ9hID
 LxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938606; x=1777543406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x7v+y/r7ud8TkOZ5YHxxZT1br3uJMt6yufYYxuHRJwA=;
 b=fIJGN0sLq0RmrxcJhtWUf/h8pClL3scAf9M61wGOatRKqsU+F4vyN2O2jxA4sLZePX
 GgHS61z0yRcMX7yChG1xhYRhQB1GVU1m+RX5p8Y5dTgOtHsjA9QaTiAqxV1FkroAt2FW
 5OAf7Seku3w62+sHARFotg34w72m3W1wQk4F9V6d4LoQ9zf9iSp1/p3EnV+5S5HyicGt
 4t8HXYh6RK5crNzZad4ilFmyo2V5EHiap/mygtLYMFlOJgNbXbnX4nl+aWKY3kAE2tIF
 qriFaCrLS5MK8BilELY28ejDEEOhc1hwQzgR3tV3if56YO+jC+GD2PlllTuJeI2j3A30
 DzAw==
X-Gm-Message-State: AOJu0YwJfnoq/3d4vuUpGbfQL35ZTDjfgI+IPWkkqdZf6+adoX9XhauR
 OIJXDCPD2idmN88j8DhLcWq+YDue9VTAXZEYoFmggs/81KXcTmqLJ6hTBs9z0mCveuoHNMuzs5r
 goqdX
X-Gm-Gg: AeBDievcwFTkxSfih3LgeJt/HaXaBiFtafOuL43Fz8k73Cvkr9GE52aBaeEoUjNJM0b
 o6WQWKm49piU4B61bysfSiu8e3s3hIFKZYPL0kKZfd8KQY4KMhg9BPwk7jR4fuLayMH7h/sC5+p
 DYddcO2W350TXCJ16st1+gyJy1xXCt8/F0+ILtEOlQdjBEJ4sGD46CLBYWoKDVNAOTuJ/hcG5Lq
 afJg1beW2dNHzHKDskd3pgrUK0ZWJf9YuH72QTe4j1vubUpu6U1/n/afp/Mq5/hUYARRlEDgLPp
 1YdPFg+BpBn0SOrBnpDC7qM9ABEORBqYq8l8LIUuvC9POKankBhJXr0xm/MYapRmdZR3kfKvD65
 ut+Hu6AjdW4I2/ab7vqNtA1tgQTeNRo2UuyNEMcclKeLhvQ+jm2uEHu/EDB3PdcdrGPRxG3Tmli
 Ogv/w01H8wvO0tXogyxSb9cIqk2OE1XZtE+9rloaJPa4uqPNhPoKKevqwBq4DjnQSf89Kjxm6qV
 I5PuG7W0Ms3shCEtymqXRcq8NBBmQtlD8JYWgJlDA==
X-Received: by 2002:a05:6000:2c01:b0:43d:7af0:3a8a with SMTP id
 ffacd0b85a97d-43fe3e20a0fmr41039561f8f.46.1776938606130; 
 Thu, 23 Apr 2026 03:03:26 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/59] MAINTAINERS: Remove Luigi Rizzo
Date: Thu, 23 Apr 2026 11:02:20 +0100
Message-ID: <20260423100229.2941820-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Luigi Rizzo has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-20-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index abe7b5f920..c1537b0db2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3413,7 +3413,6 @@ T: git https://github.com/jasowang/qemu.git net
 F: qapi/net.json
 
 Netmap network backend
-M: Luigi Rizzo <rizzo@iet.unipi.it>
 M: Giuseppe Lettieri <g.lettieri@iet.unipi.it>
 M: Vincenzo Maffione <v.maffione@gmail.com>
 W: http://info.iet.unipi.it/~luigi/netmap/
-- 
2.43.0


