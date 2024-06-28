Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FC6C30659
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5kn-0001jy-O1; Fri, 28 Jun 2024 03:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kk-0001gI-TB
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5kj-0004oi-3y
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:10:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42564a0d3ceso2332935e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558635; x=1720163435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/hWIFWqzHiq8lN1HtcaO+N2xCOE2TizGkz4ySULbbEQ=;
 b=qxvvD6OGb/JnLANXV1CdeJKSrpamTn96sQribsoSgJDS4FyUXip7bJ20y6G0J9aAuE
 TJaBdGtMbBlnmmQyOhYcEn3DqSjYmoizg37Dly4KABLEYSgOzvFJNfPsfiuwC4BT5tDF
 G9d3EUOMsH1s+BsmD+RRuryV4MFYUkqJvYlc9TT/Qsu3zJUTRY3wEcKQBFR6bzTtVtII
 kGuPQXrg7Q3y7hxCjPeGUPRKuipucW8S71qTqss7xLGOq80pE/Fe4rD4txuj+yGsI1+5
 o+fdNhTY+9KkzXCYM5HPE4TQoU28wj85RGokCnwNv3s0OMDwqPggPHJLW870EtEG1w++
 CgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558635; x=1720163435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/hWIFWqzHiq8lN1HtcaO+N2xCOE2TizGkz4ySULbbEQ=;
 b=wyVoqMyoGCTA3KWHfIJ3Yk2CgfpE5z9LMRaL8wI2D4crEIYPg9RnpJyCY0ohN6P27x
 jd629oALTHlz0Dv8QZMt0dN5uwgj2T+Eon+79HD63MXD6A7YufTbUdAggmg15n9cJ59D
 vJolHnEyeS4XGzOZy4hv381CRQcRtpcOEMd51hMa1xtZ3exQjEOxZZTxuE/NZRkfPj6z
 xLUbJTcRqRbzo75hkrmnHf+23UJ5n89Q9gYexqe74nRUBph741qGUCcXh6NZMLRqqs1h
 zbo8G3j/cJfYR1j1T4gG1vb+0mGKzCPbvA8dsxCZKlmpzAzTDoV2B/fvlxmx0b9RcOPh
 0dfQ==
X-Gm-Message-State: AOJu0Yy7lucr1FyArUSpfKbQArLQwsT+TFx+pfwRaheaL0UPATeTOkkM
 qzxfY8T2uoPyK9B5y8gIfwleHB5Bup9IjWCsRvwVR8Xf2758B50rwl+P6RONsF9U3io3xVca5Fa
 S4a4=
X-Google-Smtp-Source: AGHT+IHYoMIf1M0wMPm42T23TDj9y+r90Gus0btDCwHMi49JsFjMetn+A3CsiQa2cAyINmj0Z9SWqw==
X-Received: by 2002:a05:600c:4f4b:b0:421:1dde:cb5a with SMTP id
 5b1f17b1804b1-4248cc66ad1mr99631135e9.35.1719558635518; 
 Fri, 28 Jun 2024 00:10:35 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09aa32sm21717835e9.34.2024.06.28.00.10.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:10:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 85/98] hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR()
 handler
Date: Fri, 28 Jun 2024 09:02:01 +0200
Message-ID: <20240628070216.92609-86-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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

From: Cédric Le Goater <clg@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9a2bfeaab6..c6e5c93acb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1220,6 +1220,20 @@ static sd_rsp_type_t sd_cmd_SEND_RELATIVE_ADDR(SDState *sd, SDRequest req)
     }
 }
 
+static sd_rsp_type_t emmc_cmd_SET_RELATIVE_ADDR(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_identification_state:
+    case sd_standby_state:
+        sd->state = sd_standby_state;
+        sd_set_rca(sd, req.arg >> 16);
+        return sd_r1;
+
+    default:
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+}
+
 /* CMD6 */
 static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
 {
@@ -2385,6 +2399,7 @@ static const SDProto sd_proto_emmc = {
     .cmd = {
         [0]  = {0,  sd_bc,   "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
         [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
+        [3]  = {0,  sd_ac,   "SET_RELATIVE_ADDR", emmc_cmd_SET_RELATIVE_ADDR},
         [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
         [7]  = {0,  sd_ac,   "(DE)SELECT_CARD", sd_cmd_DE_SELECT_CARD},
         [9]  = {0,  sd_ac,   "SEND_CSD", sd_cmd_SEND_CSD},
-- 
2.41.0


