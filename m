Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C78C3065A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5kI-0000iq-Pk; Fri, 28 Jun 2024 03:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5k5-0008RF-Tf
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5k4-0004ZX-2M
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so1537735e9.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558594; x=1720163394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qw+zxMHTEIwsFcpzBJxdUQmKFi6OrynqizbQoSQ84sA=;
 b=QOvRiwjroRJuE1a8fsquD0KLYEyflOD1M1UKk6Oc5v9r53viVXQvsee/s84goIPl8H
 muqBxx3PbuMHO0/y4Gu1bCvsV7SgLQsQfrmHlZKjDou137e2hhXZ+7G+bTVwNSZ7gpej
 Tc0gDLZIv7mkDurc6xB5AThxPAfwx30S52AVqoYvMVe+ANL7hT5YRCQq8gSfg16GrCFM
 vTPQbL4jknbkMuSV7ewDWh7f1czo/58F/od2yGxw0CfWC0ARshkgRyDo6c4rYFRMKAfr
 IBNVekDdBn4ccBpMkvU+X1jBbtODpukm0Vndf3TSmqCo5T5naEUTadUYUbLxs16bRsW1
 7f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558594; x=1720163394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qw+zxMHTEIwsFcpzBJxdUQmKFi6OrynqizbQoSQ84sA=;
 b=TfxX+aPA+Rq7YqPUf/rKd92MoG2Xzm+AI5cexKf4HVpK5PzyzF//DB3lTFvF2Cjfz/
 JUT4z/lQQGRipbE9oRg8O/7E6KdMFtnthwd7awVZkT7vozcPzaepTqmj61Q8MGGMlwma
 DT/f4UI1Bc/cu04z4Fqxn7Hme9j3kTkjEXB64LSAKSWP20d4OhN6rbEbTWuXziz3C7ly
 Zm286rJRQCU74biW77nvbt8vJHMEjfKgEzjNx67I3uigrzPrnT/qM7KHIDJHSjQZiKiM
 c5KYUsiBSHtD4x7+iA223wVizBHff1zyHnZGc+m5kUwQBTaWGYUnfuTWd5EsJ51miKvM
 Tj/w==
X-Gm-Message-State: AOJu0Ywtwz2X51lSiylCQ8MunWG2UVy0/TY0OjG7rmQ8tLeNf0Zsu7Py
 A1aeYHdrAmP4awi7iJn4VVof/BtPGtQrvp/sUY96eTChfao2DQRwwyxjABW2VgbD/AeaZ/itslK
 D5R4=
X-Google-Smtp-Source: AGHT+IHG0z6Hj+/ibEQCoHP8RF+lQQ6yBvBZ9ia/+0xI0ckpQRKDXxlNrseTKy0RW7VOVWj9Kgfnmw==
X-Received: by 2002:a05:600c:4509:b0:425:61cf:947a with SMTP id
 5b1f17b1804b1-4256d50efefmr5351985e9.12.1719558594316; 
 Fri, 28 Jun 2024 00:09:54 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5901dsm21620825e9.14.2024.06.28.00.09.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:09:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 77/98] hw/sd/sdcard: Remove noise from sd_cmd_name()
Date: Fri, 28 Jun 2024 09:01:53 +0200
Message-ID: <20240628070216.92609-78-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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

These CMD names weren't really useful, "UNKNOWN_CMD" is simpler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 19322c558f..0a7b422b2c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -241,12 +241,7 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
         [18]    = "READ_MULTIPLE_BLOCK",
-                                            [21]    = "DPS_spec",
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
-        [26]    = "MANUF_RSVD",
-        [40]    = "DPS_spec",
-        [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
-        [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
     };
     const SDProto *sdp = sd->proto;
 
-- 
2.41.0


