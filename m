Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B89CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU2F-00061j-Um; Wed, 10 Apr 2024 05:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU2E-00060x-3Q
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:26 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU2C-0005dl-3h
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:14:25 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e6e08d328so2399419a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740460; x=1713345260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NK+7czDYVa9QOo+2RkWIhoABk19wFDSzwvVIKg/yarM=;
 b=QqHzX0eSMVGle2Vne1102PVTNSEuW7OfBUYaaUuNiapT/Vc2eMkP70Rz8SXjwshd7C
 BhWVhImd3uyeCGqvAEGpAk6O+HtjMkUAWSUaF3j/555J3xevghDvVdl8KI1gOisRPHHD
 u1zMnYZftAc5r+Q8N8FB4xKzuy3Iw0oMvtDWpjhUs63DFHRY8NKzyTkHRPJ77p071FAq
 Q1jPkLgtbRomOo7ecF0frbO05REN1bzJLTHhYxzqmnoGKOZImEVz6EZrqF4/0pIoY2jD
 ITYENjl5VcZiTXXYIVLMMUvnz/HFP8L/RcJBavVqcWfLMqDf1lOSad5mQ00tFwsMNRhY
 XiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740460; x=1713345260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NK+7czDYVa9QOo+2RkWIhoABk19wFDSzwvVIKg/yarM=;
 b=pguMNc/wFWcwGUXrOrfLeSrk0TO5S6c2MeWEb6b/rWJNPx8XjqvPTaee5D0FAyQN/Y
 hpgZ7alSPQgbUWJ1Gf+/lRv3TDm2fbUsOXI7KtydneA3XSTMNXoB21CMz2J3oubhw8XE
 IMTleHHUkCK2dJfTw40VGIaGZ7l2UVwWtx/aC34/em2wN/Jf/DeqcmvwOCtuwerIDanQ
 rkeFofJhyQutBokBZput0jq/Uv2QnoJVVZxmG9/TDYkplDRKEVUl99OlbOQitHt4d6l9
 W8+6hkL3PdZMOUjPzcJ851V8cs0nDAPBbsIvcJy65iasALmI1rfNT8kC4/SnB+iIuRz5
 B/LQ==
X-Gm-Message-State: AOJu0Yz6SVmQSu802z1hbq6/uqxY6e+D4NxW0M5VrBZBVEBTx1B5s3WD
 Lq0LOmJuSXYtyxq8OHW1Oj7RsiV4oVXzz3EHY7qWId7N8vfpNpLy4LkeYdvkH5YV1aQMvGNkNvh
 d
X-Google-Smtp-Source: AGHT+IEDjv4MMB+eWWHs9xCbE0zOKZx2tJgHctqMfuQy0v9UBrYLs6dCwdmoGYOYsHtQxYVARHtDlA==
X-Received: by 2002:a50:ab16:0:b0:56c:5ab5:5fb7 with SMTP id
 s22-20020a50ab16000000b0056c5ab55fb7mr1111707edc.30.1712740460284; 
 Wed, 10 Apr 2024 02:14:20 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 bc23-20020a056402205700b0056e064a6d2dsm6235097edb.2.2024.04.10.02.14.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:14:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/16] hw/misc/applesmc: Fix memory leak in reset() handler
Date: Wed, 10 Apr 2024 11:13:09 +0200
Message-ID: <20240410091315.57241-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

AppleSMCData is allocated with g_new0() in applesmc_add_key():
release it with g_free().

Leaked since commit 1ddda5cd36 ("AppleSMC device emulation").

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2272
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240408095217.57239-3-philmd@linaro.org>
---
 hw/misc/applesmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 8e65816da6..14e3ef667d 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -274,6 +274,7 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
     /* Remove existing entries */
     QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
         QLIST_REMOVE(d, node);
+        g_free(d);
     }
     s->status = 0x00;
     s->status_1e = 0x00;
-- 
2.41.0


