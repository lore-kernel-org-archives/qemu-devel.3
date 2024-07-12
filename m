Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DF3C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 16:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJ7U-0004n4-8i; Fri, 12 Jul 2024 12:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ7S-0004jy-2X
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:27:38 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ7Q-0001x7-BN
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:27:37 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4279f48bd94so6160615e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 09:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720801654; x=1721406454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7/Od3GnXnJNmfNQc7GYavEDu253S3N7cdGFHtSU0M4=;
 b=zGFrfDW56y0r2P7qCCFQt5OTAeLe2Xa+hPcGWqkdTICwXwvNJbPpybYnwahMUMOoqm
 tqcpth7mnc/VZoLyZZ54adn9mf3sMQx719MAP/3nm7FGVceV2zkFqoKpActRKW8GADLE
 mvHyHlIRHGQg/5MZyN+keZGjt3d+UKRGyn3lFe6yXNrRF5nu+NIAoX4/1KmOUBrdGw5b
 GSH6xP9Rp1fGKbEwdTTNB2z70xBCcsi9ZGPthzLj1VFn9UkFMdfX4hjtfXtU5lxM+IKz
 vRKzuOOCUeEDGL/5jlt/YZ50eqaio7vW3jnUHD++wmFPTnGPFL15rBTTMUqpRmZpxs91
 QjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720801654; x=1721406454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7/Od3GnXnJNmfNQc7GYavEDu253S3N7cdGFHtSU0M4=;
 b=Mqeb4HL8Tp/bUdGDWlIxjOjx4BBsPg+oVBLiQMY8kLSK1d0fgjdhJFcRRAFrB5Ss/p
 8ZYyAMDmkPNO69eeorQuFvwBL3PNKvyy7tiSTy6Y5IJgpAzqmTVqm7qd+h5xBGzy4ZCM
 G9zYszFOS96Oo1XfqqS0DpclERqdy/UAjtQ0ItSPKPuESMIL58BUdRhSDckxLGHnQDde
 3ZtOh+xeK4ggi5Be+Hq3jwk7xqc6S53q2TJcTmZJEd9oNcOdMDsy4dLbQsA5WxIF/Ku/
 rbX4dhG6782OI/y3DyH2V2RQU0jTK7s5UBhD1dUqVascV+RKNmlGjlZHLDizp7vALj+a
 3hZQ==
X-Gm-Message-State: AOJu0Yz4ndOu+w33hM0qYgeSQmmpf9fs9y5+LkHQKOhnWpKJBspGDMel
 3IH0UZGjtW70KZNhLPEItBloUYghWXlv3mCGRqUSBZpseMtBnX5QZpGOAaDVRu+aMu8+BUrcjxO
 o
X-Google-Smtp-Source: AGHT+IHq4L4ZD52HPn7IcsmGMnMTLVdgL1hI8uU1hV4jpXeQzYiNEmVxALpdTfW7JhLU8wMdrJ+ykg==
X-Received: by 2002:a05:600c:17c7:b0:426:654e:16d0 with SMTP id
 5b1f17b1804b1-4267018b105mr98273645e9.0.1720801654547; 
 Fri, 12 Jul 2024 09:27:34 -0700 (PDT)
Received: from localhost.localdomain
 (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr. [176.184.54.152])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2b97dbsm28067025e9.31.2024.07.12.09.27.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Jul 2024 09:27:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH v49 02/11] hw/sd/sdcard: Register generic command handlers
Date: Fri, 12 Jul 2024 18:27:10 +0200
Message-ID: <20240712162719.88165-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240712162719.88165-1-philmd@linaro.org>
References: <20240712162719.88165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index ea01bf6e28..0093bbab3e 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2442,6 +2442,29 @@ static const SDProto sd_proto_emmc = {
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


