Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1230C2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjXR-00021y-Bd; Mon, 24 Jun 2024 09:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXP-0001oB-Nr
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:15 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXM-0005DP-VJ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:14 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42179dafd6bso31523655e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234911; x=1719839711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oLr6VQ/1L7wjwJ5K6EJixR6ZpMPokOVueWHu3KJVNLE=;
 b=Gd+IDBeEtCwFpt9748UgNVgPz215uNbMBHMrHDi2B3isOvIODAQZthQtsE0N2M6gV+
 xaa9CICJdCvUHlGFlrKR82WJKk8Hjx7FwsyfMznVuH8vrM4X09sinG18IW5eAwRuSt8Z
 aGtW+qVT1f550pFVIzkWkiYiWVzU+frBS+x24wZW6f+NNP3WLwOGxJiUzbPLqhYCcWAL
 vj9DxCwGzscnpaSM/peUbTmtMlEmljm0IMh7Nx4ar07/enkPgUrAsL2rci/QTyuU+Xd6
 0M+NxwXlwOGW9TjYel2IPI2utHbdhhjFrS3bhr1IbgrVV1+7d09K9RhLKUegVV7hOnEO
 cCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234911; x=1719839711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLr6VQ/1L7wjwJ5K6EJixR6ZpMPokOVueWHu3KJVNLE=;
 b=u2E8g4JUIz29300zW6+YxCfAGArtw5nt16OkZN9e4ERtAhUasm40+wR/mxVejjIJ7T
 pDyM6AgcQycYy6o7IpmvsIkQA6Qe5zYVfttmfmiHQY12/Vr+S5JcxtKJbvCb+oPbVBuJ
 HS1AbQfXKm3bKW5npiYfhYTQ89Wb4iQpNyZf6iPDZ8t9AxpSff8XEUfWpXB3vzN7HIMo
 aJZaXCWcSGGaNirDF59AgaiVAZy+0gkU+bdLj17UYY7+eJ9PKtleePSnSNhapxALTgKQ
 6k0wtGTU6IEEZ3FFlkD2f6D+QWy0KffqfoGaRjZQoPa4IXJwGvVmy5nrb/AniEb+jncB
 m9hw==
X-Gm-Message-State: AOJu0Yznc3cN+L6amQ8cBzreRBYRbZPk4UXMegke9ooHWBdJDrPyXf9W
 9YpUzPvV/lK4e0ooVpi3eBaavHhI7g5fxFHpUBySAKzl9F4re2I4lWp05TWxAtMs3QRuYhnAjQv
 B
X-Google-Smtp-Source: AGHT+IF6YrxTnqSQiDWLmkLqvS4Q3W5r7PSkOZFQU0JP8gIcUjGvTQsHzYo29Kd93+VosrBug1hXWA==
X-Received: by 2002:a05:600c:138e:b0:421:805f:ab3c with SMTP id
 5b1f17b1804b1-42489533effmr55383735e9.14.1719234911131; 
 Mon, 24 Jun 2024 06:15:11 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248191c5adsm133562855e9.39.2024.06.24.06.15.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:15:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/19] hw/sd/sdcard: Fix typo in SEND_OP_COND command name
Date: Mon, 24 Jun 2024 15:14:26 +0200
Message-ID: <20240624131440.81111-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
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

There is no SEND_OP_CMD but SEND_OP_COND.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-4-philmd@linaro.org>
---
 hw/sd/sd.c             | 6 +++---
 hw/sd/sdmmc-internal.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 46388a140a..72d71259d3 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1035,7 +1035,7 @@ static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
     return sd_is_spi(sd) ? sd_r1 : sd_r0;
 }
 
-static sd_rsp_type_t sd_cmd_SEND_OP_CMD(SDState *sd, SDRequest req)
+static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
 {
     sd->state = sd_transfer_state;
 
@@ -2150,7 +2150,7 @@ static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
         [0]         = sd_cmd_GO_IDLE_STATE,
-        [1]         = sd_cmd_SEND_OP_CMD,
+        [1]         = spi_cmd_SEND_OP_COND,
         [2 ... 4]   = sd_cmd_illegal,
         [5]         = sd_cmd_illegal,
         [7]         = sd_cmd_illegal,
@@ -2160,7 +2160,7 @@ static const SDProto sd_proto_spi = {
     },
     .acmd = {
         [6]         = sd_cmd_unimplemented,
-        [41]        = sd_cmd_SEND_OP_CMD,
+        [41]        = spi_cmd_SEND_OP_COND,
     },
 };
 
diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
index 8648a7808d..c1d5508ae6 100644
--- a/hw/sd/sdmmc-internal.c
+++ b/hw/sd/sdmmc-internal.c
@@ -14,7 +14,7 @@
 const char *sd_cmd_name(uint8_t cmd)
 {
     static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
-         [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_CMD",
+         [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_COND",
          [2]    = "ALL_SEND_CID",            [3]    = "SEND_RELATIVE_ADDR",
          [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
          [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
-- 
2.41.0


