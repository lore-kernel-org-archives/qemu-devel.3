Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2E9C3064D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjYg-0004Qw-TO; Mon, 24 Jun 2024 09:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjYI-0004Fs-FJ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:16:10 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjYG-0005Zo-53
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:16:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42172ed3597so25439175e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234965; x=1719839765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o15lljW0J8mLU8KoPH/cOET32R/ivJ529Ef9M/rh/b8=;
 b=BfLxruUA5uyuhB7xUoaomyYBhg1tNFjGtXTgn9K38tSe9K/6civ/LiBRgUTC1+YS+p
 SVL8WNo3OlyX2z2pin8YdzrDpH6+IfMQawSZpeRZNm404k7GIcG3hb7wXHY9A06OTEWW
 +IN2fG53ZR+hwLU+WbRYq2cCLwfSF03uwziUIQNbRSfeS7OkYOoDpV6F6LUrB7HIHVct
 P1por0bpwHIorpSqgZorWLyTGm+dBUl0prrDYMdxKYNVg+rbvygoicz3QpYJpttzz+Ql
 PwRVQr6Zy+pjS3WumIUYV2S/zaq+blRHRwrmfl3X93lfm6vVnMxvRLjfVA+WK0Yoozp6
 GNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234965; x=1719839765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o15lljW0J8mLU8KoPH/cOET32R/ivJ529Ef9M/rh/b8=;
 b=rqFtB6Qz43CPg81B4Od51Q/rz0rPccU8ZHzP2Dfop/Qk9NGGrD8LcPhTKxfuUqRmpi
 9D3g2RywEj84EubqaCOWffrvWbuezpQ/YN1dejthkaxUk2OCXFopuQR86AnAZwPc0QVi
 362fOy6fU6AIJSr8Cg/M6zBMKN2csn8qpYdGS3AzB9KKr9h4YTkl1Yn9LvHJ8rDAD6hy
 AJwFdgwvwJt8wPRcnQt7P5VwQCStvbmcLMAotizV6P2XblLWiCO3WiGvv0OWAqdy9LaK
 MLAE90c1vGF5Xdw82408rOCs4xrOfuMs2EhNOd5pRgYngBWFHQux0/tj+EnVj3fw7Z6M
 tLNg==
X-Gm-Message-State: AOJu0YxVVybwXfUB24RFItgh4Qzn28ooEwHIAogj9jI6Y9+FcqZ/PM+u
 qQIHMfmiXrN8ssjXRkwllha501PTgvNs5ibCpjSFeWBnyP696yp5p75b3xSIwe2z1t0Wv/5MtxL
 G
X-Google-Smtp-Source: AGHT+IGSCkTeNsKh7FoLWWpmHwlKURccYcY5MFn5ioNd47UTcfbI82HgT/ynqnx2SmthgSnDr85/zg==
X-Received: by 2002:a05:600c:3b28:b0:421:347a:f0a6 with SMTP id
 5b1f17b1804b1-424893dfbadmr44229715e9.3.1719234964807; 
 Mon, 24 Jun 2024 06:16:04 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248179d506sm132267055e9.6.2024.06.24.06.16.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:16:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/19] hw/sd/sdcard: Factor sd_req_get_address() method out
Date: Mon, 24 Jun 2024 15:14:36 +0200
Message-ID: <20240624131440.81111-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Extract sd_cmd_get_address() so we can re-use it
in various SDProto handlers. Use CARD_CAPACITY and
HWBLOCK_SHIFT definitions instead of magic values.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-17-philmd@linaro.org>
---
 hw/sd/sd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 912b2f8984..51ab7cd003 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -582,6 +582,14 @@ static void sd_response_r7_make(SDState *sd, uint8_t *response)
     stl_be_p(response, sd->vhs);
 }
 
+static uint64_t sd_req_get_address(SDState *sd, SDRequest req)
+{
+    if (FIELD_EX32(sd->ocr, OCR, CARD_CAPACITY)) {
+        return (uint64_t) req.arg << HWBLOCK_SHIFT;
+    }
+    return req.arg;
+}
+
 static inline uint64_t sd_addr_to_wpnum(uint64_t addr)
 {
     return addr >> (HWBLOCK_SHIFT + SECTOR_SHIFT + WPGROUP_SHIFT);
@@ -1106,7 +1114,7 @@ static sd_rsp_type_t sd_cmd_SET_BLOCK_COUNT(SDState *sd, SDRequest req)
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
     uint16_t rca;
-    uint64_t addr = (sd->ocr & (1 << 30)) ? (uint64_t) req.arg << 9 : req.arg;
+    uint64_t addr = sd_req_get_address(sd, req);
 
     /* CMD55 precedes an ACMD, so we are not interested in tracing it.
      * However there is no ACMD55, so we want to trace this particular case.
-- 
2.41.0


