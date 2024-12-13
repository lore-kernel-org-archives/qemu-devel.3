Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD633E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB9F-0001R8-BV; Fri, 13 Dec 2024 14:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7I-0007Ch-4w
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:25 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7F-0007aW-Gl
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:23 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3eb3c143727so1593571b6e.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117259; x=1734722059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlJ8lLrTcNh+UZLr82oClr/Y1XecHyMEI7eMV+zr7zU=;
 b=YPyKohRcQb6yFCDymjolJRAY0t47UEBIjp18xo/aYqMfAKy9U33nEW4jmBjxFu6KKI
 suwlNJF8P19lUJQnkh+nwOT6nyK6vT9o3tgxvAbkRSIQf57RLvsmjyAdUGXad06tzWDF
 +psi24uoIloQUpz2AU3xBJSV2ZODwIVXuPYDm5p3+slnspkAzBncDAZRURJcIo+LjB4n
 Q7rojLDfWHVTmdT4YGXTvzZZSoukCDfRMTs7y6inP7m79t8DcQPURGI/PDZxzKYQ2OIs
 DLap8B2yNH7pzUUskZZzXOJATxJcvz4cVKcp9XnAb0ZTeC/HFcjexsx9QaiFaWhTcAWQ
 hYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117259; x=1734722059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlJ8lLrTcNh+UZLr82oClr/Y1XecHyMEI7eMV+zr7zU=;
 b=S9l4+TwPzHT9f+6GlvwZVtA5ceO/vbjbH53/WII/IejxZ/Igh3N/3lVRQ9ZtefnD0U
 FdD0pMl0BAfcmz3ZXHsgLTYNb0V7nRAKP29YXOhObJbUfFgS4hQSStZ3x9HeFQm1Yy4D
 fnmb6CIkSS+SHkjBwL2jOkoDw7yNX2vwX5raBBT60UbWPR0x02GX8+GsXTErx7OTtg2K
 1P/38Ul9+Ko7roLHENgeCuCZZmbePwjFQCFrQcapJurO60zscXRLZnQmId1BayAk/VLy
 GmdgN4U0JC7L8jTj5J3E/9UusIx4P90b2fAawdCMjs4tnTcq/0eH5TJAealXQi0rXvPD
 maYQ==
X-Gm-Message-State: AOJu0Ywv9Do02tN0L41+1BtCZdfQq0xUEXlZoPnKeiBpyab/NKQRjHVP
 g22GirDw/xGQDZnq7yS5WrtdrQrhovpctdSsP1f3Keb6g+uhq/mp1MbdRimvARW8wn03p+QKpki
 MQ41AtBUE
X-Gm-Gg: ASbGnctXQzKSECzXpOPGL1MA2r9wkTKJ7DFZe7j9qi8TPFvDnRaAs2mIHb2AXLTWNF/
 CV1hw4VHNt8i7pEp2EM7PaCDhFa7DdVLBKqOQPfNcWtvlrGiRpw9eOS0RDiHOrdnXapLKbTmeRY
 Tk1WhPBza9Va9hQSNguBShg2tnrTxFYKac3ciB+MUX5RZq7rnHEsSqhcnDr9+o/xBi5X8XP1pjv
 38XKMB6sdEAcXAJ7WYfBOhOObnVrTARK9zEs9zZ6eUKQYyHw6oqjRcv37Ix+xtT
X-Google-Smtp-Source: AGHT+IGLg72yAFeqa6ZJCCz13GwcpmvYSp17uW58cxsfPdIjPeNpUKcvFQZoTvNf+oXd1Q7bN58e+Q==
X-Received: by 2002:a05:6808:250b:b0:3eb:8236:d17 with SMTP id
 5614622812f47-3eb94ef2aa5mr4271856b6e.11.1734117258843; 
 Fri, 13 Dec 2024 11:14:18 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 53/71] hw/rx: Constify all Property
Date: Fri, 13 Dec 2024 13:07:27 -0600
Message-ID: <20241213190750.2513964-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/rx/rx62n.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 560f53a58a..dfa27bc94e 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -257,7 +257,7 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
     register_sci(s, 0);
 }
 
-static Property rx62n_properties[] = {
+static const Property rx62n_properties[] = {
     DEFINE_PROP_LINK("main-bus", RX62NState, sysmem, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_BOOL("load-kernel", RX62NState, kernel, false),
-- 
2.43.0


