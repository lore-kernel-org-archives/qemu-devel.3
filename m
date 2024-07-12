Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC62C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 16:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJ7g-00053W-Bi; Fri, 12 Jul 2024 12:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ7Y-0004xv-GS
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:27:44 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ7W-0001z2-6v
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:27:43 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42797289c8bso16155055e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720801660; x=1721406460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebPss3HetnUGp7ZOFtBIyU5z7Qqo1tTAoW4e3fLcmFs=;
 b=SbWBirSBRc9yYNMMjiL6pcpgu/b5UN48oB1XLhPveUj4O51Fdghdo8rTuhQ1VKxJZ0
 y9QkDLSs3dBejiew4mREkhM5ILuWEErx57NldKFFm1yJTELdBpfGKzPWtu3yt6EUmhRe
 6PxEO3xKCPuTwa/uA5ZqyBcI14HAkPqde1qC04WyL5gYWFrRxzsDML7imx1hgUDpX113
 F5GW07QblpE935XE6e2pZM7HWE3aO1zcK17FRSdSEANqfpyWuje9xpY5rLcsAw3dtkA3
 ma7dZAj0HPYSJFYOYkXsVcQVf+1FOdZSNpq7Y8FoVfaN++57IgShJMFW4676LxOmMD9I
 Zg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720801660; x=1721406460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebPss3HetnUGp7ZOFtBIyU5z7Qqo1tTAoW4e3fLcmFs=;
 b=I+94VhU00SCzWoQ4PrZMS3RMAtAcVdH2yPI53Q3+xmCj9sZZ+cwal5MsdkZPge04eq
 xufJAul64TZ/SPA0msj1QH0IMAl6L0DTFzI6057HbyRTsNCd4bHLZl41ubLub0Oi+I7Y
 TcE1O3KKXdb1ecWRyKEr5rk7UnHjhiJrnKQIdUOjDS9TvRezT4YI8hYLKQQr2BM0WsaH
 qEbqTxBpESmC2NL9+vYFKsSJeWN43gkrKwzsPNydw0tTmdpnpHUhUz7jB0EljtKrrHuJ
 38bsRG7KO9GkDtnOcOGgF7zpTW8a90iqLe1vwNoqtRErDA3FXiZEIusiBsDXg7b3oq6T
 jcTA==
X-Gm-Message-State: AOJu0Yxn3gy7EJxVPcvH1CsXYC8UYNr84MZb18BDldv4FWy+PjC4ZkjE
 SpU6JLtz3LizeXu8rftepQXjFF6OLsuWamYjbvFdOu154SverNkbgCBhg2pOtTXfln4o2WXYt5z
 D
X-Google-Smtp-Source: AGHT+IEFxvPlPv9cX6ACDAp1gNKbJ2F5G5HHcMU0Zy/EoPcsg/oalSD3mA0RaSCiEfLcSmkqewc2eQ==
X-Received: by 2002:a05:600c:21a:b0:426:59fe:ac2e with SMTP id
 5b1f17b1804b1-426707f812dmr83658065e9.29.1720801660296; 
 Fri, 12 Jul 2024 09:27:40 -0700 (PDT)
Received: from localhost.localdomain
 (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr. [176.184.54.152])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfb2327sm10573226f8f.116.2024.07.12.09.27.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Jul 2024 09:27:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH v49 03/11] hw/sd/sdcard: Register unimplemented command
 handlers
Date: Fri, 12 Jul 2024 18:27:11 +0200
Message-ID: <20240712162719.88165-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240712162719.88165-1-philmd@linaro.org>
References: <20240712162719.88165-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Per the spec v4.3 these commands are mandatory,
but we don't implement them.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0093bbab3e..8a23e9eb23 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2445,24 +2445,33 @@ static const SDProto sd_proto_emmc = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [1]  = {0,  sd_bcr,  "SEND_OP_COND", sd_cmd_SEND_OP_COND},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
         [10] = {0,  sd_ac,   "SEND_CID", sd_cmd_SEND_CID},
+        [11] = {1,  sd_adtc, "READ_DAT_UNTIL_STOP", sd_cmd_unimplemented},
         [12] = {0,  sd_ac,   "STOP_TRANSMISSION", sd_cmd_STOP_TRANSMISSION},
         [13] = {0,  sd_ac,   "SEND_STATUS", sd_cmd_SEND_STATUS},
+        [14] = {0,  sd_adtc, "BUSTEST_R", sd_cmd_unimplemented},
         [15] = {0,  sd_ac,   "GO_INACTIVE_STATE", sd_cmd_GO_INACTIVE_STATE},
         [16] = {2,  sd_ac,   "SET_BLOCKLEN", sd_cmd_SET_BLOCKLEN},
         [17] = {2,  sd_adtc, "READ_SINGLE_BLOCK", sd_cmd_READ_SINGLE_BLOCK},
+        [19] = {0,  sd_adtc, "BUSTEST_W", sd_cmd_unimplemented},
+        [20] = {3,  sd_adtc, "WRITE_DAT_UNTIL_STOP", sd_cmd_unimplemented},
         [23] = {2,  sd_ac,   "SET_BLOCK_COUNT", sd_cmd_SET_BLOCK_COUNT},
         [24] = {4,  sd_adtc, "WRITE_SINGLE_BLOCK", sd_cmd_WRITE_SINGLE_BLOCK},
         [27] = {4,  sd_adtc, "PROGRAM_CSD", sd_cmd_PROGRAM_CSD},
         [28] = {6,  sd_ac,   "SET_WRITE_PROT", sd_cmd_SET_WRITE_PROT},
         [29] = {6,  sd_ac,   "CLR_WRITE_PROT", sd_cmd_CLR_WRITE_PROT},
         [30] = {6,  sd_adtc, "SEND_WRITE_PROT", sd_cmd_SEND_WRITE_PROT},
+        [31] = {6,  sd_adtc, "SEND_WRITE_PROT_TYPE", sd_cmd_unimplemented},
         [35] = {5,  sd_ac,   "ERASE_WR_BLK_START", sd_cmd_ERASE_WR_BLK_START},
         [36] = {5,  sd_ac,   "ERASE_WR_BLK_END", sd_cmd_ERASE_WR_BLK_END},
         [38] = {5,  sd_ac,   "ERASE", sd_cmd_ERASE},
+        [39] = {9,  sd_ac,   "FAST_IO", sd_cmd_unimplemented},
+        [40] = {9,  sd_bcr,  "GO_IRQ_STATE", sd_cmd_unimplemented},
         [42] = {7,  sd_adtc, "LOCK_UNLOCK", sd_cmd_LOCK_UNLOCK},
+        [49] = {0,  sd_adtc, "SET_TIME", sd_cmd_unimplemented},
         [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
         [56] = {8,  sd_adtc, "GEN_CMD", sd_cmd_GEN_CMD},
     },
-- 
2.41.0


