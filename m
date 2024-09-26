Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB2ECCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 11:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stmmq-0002su-Sk; Thu, 26 Sep 2024 07:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1stmmp-0002mr-Cr
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:35:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1stmmn-0004jz-PI
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 07:35:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso10547375e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 04:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727350552; x=1727955352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bv/83AMKyF4owiura6pFp0WrCkZvXqKtoQfcxxozU+A=;
 b=j2c19njE6uMgjcab588oKP7KprUg6mv4fsZc0JTtyzOmfyUpKI7mqTutre75qTcBtp
 4B+D/+XuyNff5y/Tlcylx51mho82MdwVaVnL0VfnHwpHkDKbECa1dBpJKTNfOhSC5io7
 OFGJpLOJcW0pQA9SNq4tz2xEdpNiVTYZZKjEnIDINWpxit7v4BRK4HGVfm27HmPUDm3e
 v1xp+GIgofRNui0PadxWEBC0/DP0N94TJVubSpxD0KVYIFwEozGXmlD+JeMxx8DbiPnt
 aDm+KSQ3HS+6QsHa0THOiaiww6YlF5eWYWm4UheLDwY7irPsj0tEF1quiY5DFDgkrEX7
 YOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727350552; x=1727955352;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bv/83AMKyF4owiura6pFp0WrCkZvXqKtoQfcxxozU+A=;
 b=tyzbP3EfZwcMOX3ncHzkV39gmep+cEwZ8tTZESx1hRx3FrhNgFV6qckXpGyRKwpZdl
 DImf5m1hlh6kLEDrWekmxvmmbrt9ErWVDoNmkKuuG0tRHhcBbIpk5YWj65BgDtPFdJ9j
 /CjfqEoWOFFnO6B4bpbgKFVLopQwJ7lStoSIGNVwPecSWmygxd5U5+cAli2qxhLOpXjI
 e/Ox099Il0xFrMoAtab153Is9YuomIU5CODkRUwBISItzFzEUeLG8K3mJZ70+jlKxQZC
 r7qh8Hp4kBjPtqIK+Adwa7PvmzrrMirdeyUKf1eLiY4HBq0uYdXuTrOHYaBb0ydWvMhb
 nrLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUe2stQme8Px2673sF2ggiYc/khCDm+dxup2FtUggNB4vfswvwmzzY4Ua6lkTPsXYweeOS9OSXZiML@nongnu.org
X-Gm-Message-State: AOJu0Yz+p6mxW4MDdFCw/gJ+Ebo6fD8WVONhgI0mfTw2RPr6GgTZ3/3N
 TuEipD/ccEVhHM51g9WL1zWdbkkc6dUHEnJQPgvOV5EwQw4ZIPqHpERvlfqARZc=
X-Google-Smtp-Source: AGHT+IGBMEaO6vmfwOkH9roFaNgsuFdkp47MUil497wEWWi4RU3NmZGOKKger0acfXazCYrawMgrRw==
X-Received: by 2002:a5d:5d86:0:b0:37c:c4a0:418a with SMTP id
 ffacd0b85a97d-37cc4a042c8mr4540059f8f.59.1727350551577; 
 Thu, 26 Sep 2024 04:35:51 -0700 (PDT)
Received: from meli-email.org (adsl-13.37.6.161.tellas.gr. [37.6.161.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ccd8ff16asm2041743f8f.54.2024.09.26.04.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 04:35:51 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:35:10 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael S. Tsirkin <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH] hw/audio/virtio-snd: Remove unnecessary "exec/tswap.h"
 header
User-Agent: meli 0.8.7
References: <20240926102113.64890-1-philmd@linaro.org>
In-Reply-To: <20240926102113.64890-1-philmd@linaro.org>
Message-ID: <kf47q.xtqbzbv0rng0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 26 Sep 2024 13:21, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>We were including the "exec/tswap.h" header to get
>target_words_bigendian() declaration, but since commit a276ec8e26
>("hw/audio/virtio-snd: Always use little endian audio format")
>removed this method call, we don't need this header anymore.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/audio/virtio-snd.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index 69838181dd..c5581d7b3d 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -20,7 +20,6 @@
> #include "qemu/log.h"
> #include "qemu/error-report.h"
> #include "qemu/lockable.h"
>-#include "exec/tswap.h"
> #include "sysemu/runstate.h"
> #include "trace.h"
> #include "qapi/error.h"
>-- 
>2.45.2
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

