Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD212C3065B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz8c-0001yT-03; Tue, 25 Jun 2024 01:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8Z-0001tG-UZ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8Y-0001dz-Du
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:39 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4248ea53493so14912805e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294876; x=1719899676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJN6KVZ4KFMiBqbYHgPGiBcO7JIk6P/og2YV9T7n/3A=;
 b=u5Wt2HsQpuXTs4R8DmoC9v0oQst0mwNwc0oj6NTwYKSyBpoNycK+d5ROAbT9pujyLV
 wo/TW6JTcLqvt3hWdFJgVrlmXZojVxSG3e46ewTPzKAXbXN9XiKa2tQg8fCdjpbqD73K
 Fi+6hpvFqPKS1QOa7tE8oKx9lL7kuL2CKo9DVROcwCtAI2ULb11p/vXKujJgTyvpiO1R
 tS6qpiOx8tqUbY8KvJMhPAqveiuiuSrlE7B+FNTrmfPSp+NrNloE5JAXTZPiNlXOLLss
 3PvF8sHTznWobzvX0gw/BWGROrZH+mTHhZ3jieiPxgEFgcs3O8n/B3MdOUDFEJD3LL2A
 hqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294876; x=1719899676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJN6KVZ4KFMiBqbYHgPGiBcO7JIk6P/og2YV9T7n/3A=;
 b=mpVSjSzBCyeGM9MEY6CZa82fcPk+OSut1aexuT4E4apZ4TfM5Pnx/bC9aSahVuhv7r
 dAWpKR1sOZTpRka7O8eywOGf9b+g5uV8GVO68C85FSnWWujHPpNxrEHRffUkwkaWinlh
 OcHBoUtqzFYl+KqHBVynJzdn1g3/ETldupKImVC0zIS2s3fBtsQDSOa5febv1JYFYxsE
 BI5Cb/aEBpIFzXXg9csylMnN0I5vN/oQ7S1Bfa3JkbxUbuMxMYAa3DC1r6fHyR+KRZ7j
 8+p1w2c88I72iUbX33qVDLyfERAC5vSccxRj97E3DxGVQaSR22XKdfkmp7iM66yxiEqA
 gEIw==
X-Gm-Message-State: AOJu0YwqE/sGGxYpDJv/pimZPmDH2lyWwYQXQN4agE6oj/Np6rWeZNJQ
 CxR3gYIGxVI8962BK2dPzuDE3ZtBObjb8ixFzfeoJAD51ZidJJW6BgJZBCgNLWotByANBaXDVNR
 u
X-Google-Smtp-Source: AGHT+IHuxLstUDVxqnxVGRENFW9vyjN6tmlRxuUk5mCLINYKrFbok9v/HmXGaPauWitRJ5X5Rmop2Q==
X-Received: by 2002:a05:600c:4da1:b0:424:8e88:a6a6 with SMTP id
 5b1f17b1804b1-4248e88a753mr53922045e9.8.1719294876771; 
 Mon, 24 Jun 2024 22:54:36 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366383f6355sm11849035f8f.17.2024.06.24.22.54.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:54:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 07/12] hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first
 (ACMD22)
Date: Tue, 25 Jun 2024 07:53:48 +0200
Message-ID: <20240625055354.23273-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
References: <20240625055354.23273-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Per sections 3.6.1 (SD Bus Protocol), 4.3.4 "Data Write"
and 7.3.2 (Responses):

  In the CMD line the Most Significant Bit is transmitted first.

Use the stl_be_p() helper to store the value in big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
RFC because I'm surprised this has been unnoticed for 17 years
(commit a1bb27b1e9 "initial SD card emulation", April 2007).

Cc: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b604b8e71f..0742ba8b38 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1659,8 +1659,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
         switch (sd->state) {
         case sd_transfer_state:
-            *(uint32_t *) sd->data = sd->blk_written;
-
+            stl_be_p(sd->data, sd->blk_written);
             sd->state = sd_sendingdata_state;
             sd->data_start = 0;
             sd->data_offset = 0;
-- 
2.41.0


