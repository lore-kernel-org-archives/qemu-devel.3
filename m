Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD82C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRCjT-0003FO-P5; Tue, 09 Jul 2024 11:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCjS-00039L-9f
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRCjQ-0006Cc-Lm
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:26:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42671a676c7so7886415e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720538774; x=1721143574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whoLRb2gVbD8Sem/KoA+COzzbDt33IZ9HQp6/Mjesmw=;
 b=gb9+az7O6MAMpfAK5CrC0wEO54m7yN5+/H/rixrwkIpzA6bQ0GgOVBVa01zxlI6B2i
 T8tc6zc7ACuDN+9zVpx1Gxvbuj1+UgndVDRD5byTk/4PQCv32ajjngnPp4wrVFnltAiT
 4xDbJnXG3bxSaX5fAun/foTVpNmIX4bQQDKjc/UWn9mIIKfMk71TYDN1gN5Z+XakrmT+
 aJlSUBt75EjzKeiARwEaMkfTzDEMXN12XGRpEXllYsOYZCc7AEA31Xol7oq2JHXvKeei
 pRyRhIgcuNAFXf9JXbKFYPeslYQAMMJ3UZBsnz8TGocG7fLBU2/2l7nhcmCzwG4GfiJ4
 9JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720538774; x=1721143574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whoLRb2gVbD8Sem/KoA+COzzbDt33IZ9HQp6/Mjesmw=;
 b=JwZSerhlqHHg9JrZkeri8JsPXNeQULQ2CJRL5MsvmoYnnRguXaMzFUjMwWr2THzoUS
 wlMNW86kjEQVZbtCrgDNbfTrv39oSTN/7J/VUgCHgeqAezr5+GwXkOERF6lfkZQqTTkZ
 +yx8tonFGazDsMigHtg0aJwkFoFEJy+gryrNYPVJyIbbF/fLk4WzkUQ9j93sfLBzdr/S
 wi2qFIzbrX3S3IN6LgMleXxEJ7kTmFnCC1son8aPOQpe5j/Gljc7yCGtkqoWnMbqJGme
 76eyI+wSSum/Ky5zVQHt5TwnvkpmtS55Ageqo2REJJfCGzmA18G5SJ0NsbpoKN8PdIj6
 YWow==
X-Gm-Message-State: AOJu0Yyk+YjRey+qFQ4B9Pq6sdME7FqTgtd/zBrvouYhMd+YQsnhcOgQ
 T/hvTLjOGS1Tl/iv2tITvDo26DSchwi0biv5OqFWYFKhp4MhukgBBCWZZzvSH193MO9wKqjgewG
 +
X-Google-Smtp-Source: AGHT+IFKJEd2i8HNpV9JdOGTSoND9xvmTUdVzfcFcWxzllSuTn4ZkzRPWdSdwGv/y0tqnPsZGXDPXA==
X-Received: by 2002:a05:600c:6541:b0:426:6364:c2c4 with SMTP id
 5b1f17b1804b1-426707cf9c4mr18535505e9.14.1720538774580; 
 Tue, 09 Jul 2024 08:26:14 -0700 (PDT)
Received: from m1x-phil.lan (vau06-h02-176-184-43-20.dsl.sta.abo.bbox.fr.
 [176.184.43.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa065bsm2855862f8f.72.2024.07.09.08.26.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jul 2024 08:26:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v47 02/19] hw/sd/sdcard: Register generic command handlers
Date: Tue,  9 Jul 2024 17:25:39 +0200
Message-ID: <20240709152556.52896-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240709152556.52896-1-philmd@linaro.org>
References: <20240709152556.52896-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240628070216.92609-84-philmd@linaro.org>
---
 hw/sd/sd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 91a73aea8d..eb50862adb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2387,6 +2387,29 @@ static const SDProto sd_proto_emmc = {
     /* Only v4.3 is supported */
     .name = "eMMC",
     .cmd = {
+        [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
+        [1]  = {0,  sd_bcr,  "SEND_OP_COND", sd_cmd_SEND_OP_COND},
+        [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
+        [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
+        [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
+        [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
+        [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
+        [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
+        [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
+        [17] = {2,  sd_adtc, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
+        [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
+        [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
+        [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
+        [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
+        [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
+        [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
+        [35] = {5,  sd_ac,   "ERASE_WR_BLK_START", sd_cmd_ERASE_WR_BLK_START},
+        [36] = {5,  sd_ac,   "ERASE_WR_BLK_END", sd_cmd_ERASE_WR_BLK_END},
+        [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
+        [42] = {7,  sd_adtc, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
+        [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
+        [56] = {8,  sd_adtc, "GEN_CMD", sd_cmd_GEN_CMD},
     },
 };
 
-- 
2.41.0


