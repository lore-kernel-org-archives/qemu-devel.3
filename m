Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16001C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjXr-0002c4-SH; Mon, 24 Jun 2024 09:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXf-0002Tp-Ua
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXe-0005LN-9P
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-421cd1e5f93so32928525e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234927; x=1719839727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqlOEyj+8xJJtMHox3KeLzXAnw9eaudtpJH6jXIsYOM=;
 b=w0e55R1jxQgPIHzVaV8IuY/CBhxuRl9AU+O7IwifzRNR3XHo2LxmK2r3qx103Ot2Ez
 J6jMXIlUSP0OZKyTy5fEXo69zPdklwb8jni5l/7DNffh3sQ1lH3F5f0w0a6IYk71c6Vs
 kBDXhRrTEdgprWDipP7WXgL2v2CIyZVBcYOl1ZyPTfpgwleiFHWVBd3aE/NwyB7rxQE9
 TomomL3lxNLukEC1OI179MXjhDnVWM+fd3BkR4c1+iTEttYnhhDyZgk1aZN+5LoL3rVH
 Z7yNuZqV1jIGQFQkXHobCB5+gQdK1XcAhAsKzoAHEHI4LvNL1MCbqDxwYGWuz7THobNd
 olEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234927; x=1719839727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqlOEyj+8xJJtMHox3KeLzXAnw9eaudtpJH6jXIsYOM=;
 b=f5gtK1oSxYfsY/AymIVXtNieF7tPqworGcz3lXYYLJOJ0UTqqpF7xBXUV1uTgStTXc
 Bp84Xiz+tGN/89qLLxnXtg396mdyhtqRJHucZdCuNs38AgGOjLiURXfpZsWo6QAXmDZB
 9EJI/WxSWFO7SU5opjbbaGWtIzkDMzsbSNbGnst/OPs5KuDH5yljJyakGAQ366F/HAzL
 2AOUseYN2wZTbKoeLMkcf27SfYrlzFB8FuLenbMdFwbNDMRZex7xJ9uCCXRdSrDG/CMx
 vhYPshall2xMudRnu6k8U+JSJPpRMryCFpvQ4XE6S4SbQQsYSr/0au22aMdHpJPEeJ8M
 KlHg==
X-Gm-Message-State: AOJu0YyAXDNQuHi0hjsSQsG7lpsRblonjrooae/eRsVsh6u9gJplGHjq
 AosDWwd7J/7o2lhpV46pleEKAbPRqEMLjrpm9srmPuOh6Aifo7Jt2As7I03HE1CtSEoQnk//1RV
 g
X-Google-Smtp-Source: AGHT+IFsGfWXVlKYx1jXjut4nYsav94FY1kOlHlNu6rHSUcoaGHmH89Sv1fd8lDZH79ER3hC9L0ijg==
X-Received: by 2002:a05:600c:354a:b0:420:ffe3:8536 with SMTP id
 5b1f17b1804b1-4248cc66a8emr36771655e9.37.1719234927498; 
 Mon, 24 Jun 2024 06:15:27 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248191c5adsm133571485e9.39.2024.06.24.06.15.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:15:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/19] hw/sd/sdcard: Use Load/Store API to fill some CID/CSD
 registers
Date: Mon, 24 Jun 2024 15:14:29 +0200
Message-ID: <20240624131440.81111-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

The ld/st API helps noticing CID or CSD bytes refer
to the same field. Multi-bytes fields are stored MSB
first in CID / CSD.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-7-philmd@linaro.org>
---
 hw/sd/sd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 64270dec0f..6e346e28ca 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -393,10 +393,7 @@ static void sd_set_cid(SDState *sd)
     sd->cid[6] = PNM[3];
     sd->cid[7] = PNM[4];
     sd->cid[8] = PRV;       /* Fake product revision (PRV) */
-    sd->cid[9] = 0xde;      /* Fake serial number (PSN) */
-    sd->cid[10] = 0xad;
-    sd->cid[11] = 0xbe;
-    sd->cid[12] = 0xef;
+    stl_be_p(&sd->cid[9], 0xdeadbeef); /* Fake serial number (PSN) */
     sd->cid[13] = 0x00 |    /* Manufacture date (MDT) */
         ((MDT_YR - 2000) / 10);
     sd->cid[14] = ((MDT_YR % 10) << 4) | MDT_MON;
@@ -462,9 +459,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
         sd->csd[4] = 0x5b;
         sd->csd[5] = 0x59;
         sd->csd[6] = 0x00;
-        sd->csd[7] = (size >> 16) & 0xff;
-        sd->csd[8] = (size >> 8) & 0xff;
-        sd->csd[9] = (size & 0xff);
+        st24_be_p(&sd->csd[7], size);
         sd->csd[10] = 0x7f;
         sd->csd[11] = 0x80;
         sd->csd[12] = 0x0a;
-- 
2.41.0


