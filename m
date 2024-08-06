Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B6BC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJhX-0007oK-GQ; Tue, 06 Aug 2024 08:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhS-0007Lk-Jj
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:03 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJhQ-0000K7-OL
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:54:02 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52fc14d6689so515672e87.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948838; x=1723553638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMipe/hXLqtb3Ef8XbFqx4kLNXFlOJjSHmZuoVlilTA=;
 b=M7lEONhJ7UuMoo/Pk40/xnfDfkIbohUZBK37LDkikZYgrUTgICk9WW9OjaUgbIPuuJ
 DqtJJkkS2nMl6w//T72jOS1AXaMd3jGGpA/z4838SxkL41ytFtAxAH3ukBXDuuneJ0PM
 E17JWlixB8bnGhK/w+7c2yMvYEjz3Sw+sXSjQo7akuLiJrrLqGsbG6i0heSWbRm2DLDg
 iUPO8QrUsYFjBOhWVsd5FCHXrFduF85n5ZPr6ZS5+prXw/JRCa9QFezSSpHwhiEg6Qt9
 UUIH+LGVeTzALzk+oExwIdO9Ad6k+9GEMA3Bx6hSq2PGMFftXguE0PO4ZsyuEdU2mQO4
 d7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948838; x=1723553638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMipe/hXLqtb3Ef8XbFqx4kLNXFlOJjSHmZuoVlilTA=;
 b=p9FI8bzQxHS8aLuvSegv7ybbnBHn9OASF+x8yzzF3SOj3Aq2Zp/oEJ7pNVqkbtlNRQ
 7+iQ0bLwiucKDQGmpJMge1izs2UAIHpBRacc1b4dHzaf49X4ifmqAPA6+gcLa09P1kOX
 Eg0Yo02jzZHXGaARYP894f8n//9rA9eb9jMPNGNzfaPOs3R63IEnGt0ymxlcwuPf8bF9
 EU6wbw8mVlrEU7sBFNDh2+irvv2AbC1idjieLyGo7oq90loMnJz/1q+76I/FHylupty7
 a9osMi9AB/tYin0qPcWm2P+24JeQKQOHKs8LwGbW1jRkTo1EBVvgTSnSq0mz81qzLzfm
 RF0g==
X-Gm-Message-State: AOJu0Yy0MzCjdze1xLCpHTmZBazX9K0SufKz+f8BLlv2+Zg/wa2KdNxb
 zHtOOryO6AHZRy2Xome1bEXB/IQRBit4vN1KgD80ewtnLsQ9cWTkZ1BrEGh9HVuUOuKX5DZiLlQ
 s
X-Google-Smtp-Source: AGHT+IH8G0ZoABRlxKVigalJQip/AR4YTB9XiD8/200FTJozro7KFpdNnKVWQEkmHPtGccX+VtEQeQ==
X-Received: by 2002:a05:6512:ba9:b0:52e:9481:eaa1 with SMTP id
 2adb3069b0e04-530bb37425dmr10667974e87.23.1722948837724; 
 Tue, 06 Aug 2024 05:53:57 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e7fe3csm539363066b.162.2024.08.06.05.53.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:53:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/28] hw/ide/atapi: Be explicit that assigning to s->lcyl
 truncates
Date: Tue,  6 Aug 2024 14:51:47 +0200
Message-ID: <20240806125157.91185-20-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In ide_atapi_cmd_reply_end() we calculate a 16-bit size, and then
assign its two halves to s->lcyl and s->hcyl like this:

           s->lcyl = size;
           s->hcyl = size >> 8;

Coverity warns that the first line here can overflow the
8-bit s->lcyl variable. This is true, and in this case we're
deliberately only after the low 8 bits of the value. The
code is clearer to both humans and Coverity if we're explicit
that we only wanted the low 8 bits, though.

Resolves: Coverity CID 1547621
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240731143617.3391947-5-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/atapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index fcb6cca157..e82959dc2d 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -265,7 +265,7 @@ void ide_atapi_cmd_reply_end(IDEState *s)
                     byte_count_limit--;
                 size = byte_count_limit;
             }
-            s->lcyl = size;
+            s->lcyl = size & 0xff;
             s->hcyl = size >> 8;
             s->elementary_transfer_size = size;
             /* we cannot transmit more than one sector at a time */
-- 
2.45.2


