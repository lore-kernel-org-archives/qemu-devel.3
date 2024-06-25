Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC85C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzNx-000839-1R; Tue, 25 Jun 2024 02:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzNv-00080d-Ij
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:10:31 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzNs-0005af-Fz
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:10:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42499b98d4cso5023205e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719295825; x=1719900625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOp+gWdjMuwGu4rb7U+zCds5Wp19J2oG3xmA1hxsBHQ=;
 b=n630eRWumUcz3g4Lm0UQ7noSKshd8ihucYStq9prsPprgbe4NtxJUzvA7eFKn/SbhZ
 TGtwZ2MuR3ljsBg+iKrIZkrN5c0qBz3ie1fp3QbmY8MEOEpNq+q1QHezPqzusf2y/Cca
 ktiHR8R1wQEJGCw0V5099AL7F/Q4NBVM9RyGuCN1IO400+HTGl9u/tCZtUziZlW1ySJ9
 2sgSN0Xh4O2eQpi9a6d4krivVK7VGxCIgabI+3HFOZBz8qoEdvSNQc0bog1YAngT7zQR
 Yz8Aoawf8ipx5bSFMnd0LqO6DKar1gpm4/AmTnU+p3hxgTcTpGIlFn9pI1uDlPGeqxi7
 kWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295825; x=1719900625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOp+gWdjMuwGu4rb7U+zCds5Wp19J2oG3xmA1hxsBHQ=;
 b=qu8kxhB+SZAGqILo6cYNunSDI9NCG9ZI8lp/JyKNw/qQanKbxI+cBXWEMN5Vy7PBq5
 P9SSh9hNAaBsVLQOJQoeqTmvW2tmQwDUpXfPuB33wZKTYWJO4JsQSaQmOsuECH9FpqWB
 Nz9zPs3yPo/QCxKapynGashxn9QOC2VOjogNvoDJWWEV2Fu2NNgzv1H8r+oeMJaC6Ab3
 WMVoidADWhcdtn3U1Ynk2doI/0r2roPP02BzvaOYdKqDyx4MJPN8c36z4Eq4l5fcWmmS
 8gaCLzxbPzxMNZd7i2fqqiFzFLgAB95LIgbZ5Up4WiCMi88etLTr1rAh9wFBcn3LZdos
 TGqQ==
X-Gm-Message-State: AOJu0YxuvZ8gr93rpZq6SaLwqnJVkFl6fEKVyIO+epsDMVl1BqBQ9VLT
 t66Z+3np0rD32BPx5i7ge1vSgSjDFUDrkQQ85m+FZUgCiP62DUinoqrK1QEV6jtDQmPGhOlAXgy
 0
X-Google-Smtp-Source: AGHT+IFpJAu8q1x9NhRYBKdwXH/f8lsh2EluCQz5UxawJ4d5I7wmkcveBL738Yrh5YqjyCE91IJGSw==
X-Received: by 2002:a7b:cc16:0:b0:424:8e3a:d020 with SMTP id
 5b1f17b1804b1-42498ced472mr16457305e9.29.1719295825612; 
 Mon, 24 Jun 2024 23:10:25 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d208b27sm199003165e9.30.2024.06.24.23.10.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 23:10:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/11] hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and
 sd_generic_read_byte
Date: Tue, 25 Jun 2024 08:10:05 +0200
Message-ID: <20240625061015.24095-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625061015.24095-1-philmd@linaro.org>
References: <20240625061015.24095-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

All commands switching from TRANSFER state to (sending)DATA
do the same: send stream of data on the DAT lines. Instead
of duplicating the same code many times, introduce 2 helpers:
- sd_cmd_to_sendingdata() on the I/O line setup the data to
  be transferred,
- sd_generic_read_byte() on the DAT lines to fetch the data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6685fba4bb..89006ba1b6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -142,8 +142,10 @@ struct SDState {
      */
     bool expecting_acmd;
     uint32_t blk_written;
+
     uint64_t data_start;
     uint32_t data_offset;
+    size_t data_size;
     uint8_t data[512];
     uint8_t vendor_data[512];
 
@@ -1064,6 +1066,28 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+__attribute__((unused))
+static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
+                                           uint64_t start,
+                                           const void *data, size_t size)
+{
+    if (sd->state != sd_transfer_state) {
+        sd_invalid_state_for_cmd(sd, req);
+    }
+
+    sd->state = sd_sendingdata_state;
+    sd->data_start = start;
+    sd->data_offset = 0;
+    if (data) {
+        assert(size);
+        memcpy(sd->data, data, size);
+    }
+    if (size) {
+        sd->data_size = size;
+    }
+    return sd_r1;
+}
+
 /* CMD0 */
 static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
 {
@@ -1898,6 +1922,20 @@ send_response:
     return rsplen;
 }
 
+__attribute__((unused))
+/* Return true when buffer consumed */
+static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
+{
+    *value = sd->data[sd->data_offset];
+
+    if (++sd->data_offset >= sd->data_size) {
+        sd->state = sd_transfer_state;
+        return true;
+    }
+
+    return false;
+}
+
 void sd_write_byte(SDState *sd, uint8_t value)
 {
     int i;
-- 
2.41.0


