Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12640D42BBA
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvMV-000542-E1; Tue, 12 Nov 2024 13:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMO-00051W-BZ
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:29 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMJ-0001ua-Cr
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:25 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so52779805e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435080; x=1732039880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qd9qxHlovWjmh8ObGWU7tF9VLM9MT0KfWhMQvBKNL6I=;
 b=Kt84ReZ/6DIX+8ABwBG38Mtlg/aIFM274wqIVOEhwPPgKY6fPLUglZBkSGPyGeq7D0
 rMvtWHHDhsifmPb578v7lbQRaTbVOhgZ2YOiMC1MtBdkA8zF5qK/ZyexieYvPiSqU7gw
 SUavSVUDizQ+lR4Ok2bKU08lAXYD0ggXLKp3xPsgbIgJvlMx9SzeEGu1Fg8+MuY/TAFU
 hWzOYPL2IfGvIMBBbeLbZ811wIsrs2SETFXfYU1YM8kFZshPDRBVPrAnXIx2An44O4k9
 +wt7+YTApTZyCj8zJjStwFxJkM3TvmVOOA/ny/1GzahgYpbuAjnT+3LpdCrdzqWPlrlf
 AEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435080; x=1732039880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qd9qxHlovWjmh8ObGWU7tF9VLM9MT0KfWhMQvBKNL6I=;
 b=gq0dTcUU4ucTWHiV0fYBAKpexj9gz/q//Dk/7VAZE19yHppd+lTbh4jVfNv0CGQQ9W
 dPewJaybhqkXzrZB9JkwpeX/1R8IN89jQh1sfMjKb0buTBmvHq67bCPLYQruM9atpZN6
 iU9rdQ6RWC7w2xo7VG+LWJnnWrD5SPV++HsAv/s44BHPTay2FtOf8oGA0MI38x45d9f7
 IwFc7zPlCE01IC4DxZ100KnFMrfiQSZjVOI6P6hxWupQwRP/0ogz+hG+4Gw4QP+vSdLa
 FLF80Cx1HUPo/CFyDOSL8OOoQzeFArEj7wEPXidwIydyPFPyuNrbwxo7QSroEOCkSDPh
 RxYQ==
X-Gm-Message-State: AOJu0YzwmMRFrIzBCEWkE5BgRS8dDCkvQfw+mleSXWXko1w96f2E4coT
 wx4mP09M0NQX0wz1Dj2yFVKaZJ/8UAZZvTF0VZuvzYANZQfyqY9U7DypYRtI36zFE+AWE9O8WvQ
 m
X-Google-Smtp-Source: AGHT+IHQZlg5SFriemGlfj7YjAGdzfrrI6cHbHPA3UvTD7AFZQTkfBKAGW4h5qAf185PTItlxISwzA==
X-Received: by 2002:a05:600c:3d05:b0:431:7c78:b885 with SMTP id
 5b1f17b1804b1-432d4aaa11emr816505e9.4.1731435079902; 
 Tue, 12 Nov 2024 10:11:19 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05e5f82sm222757955e9.42.2024.11.12.10.11.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:11:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/20] hw/net/xilinx_ethlite: Correct maximum RX buffer size
Date: Tue, 12 Nov 2024 19:10:29 +0100
Message-ID: <20241112181044.92193-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
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

The current max RX bufsize is set to 0x800. This is
invalid, since it contains the MMIO registers region.
Add the correct definition and use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 0f59811c78..e6f6179fce 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -46,6 +46,8 @@
 #define R_RX_CTRL1    (0x1ffc / 4)
 #define R_MAX         (0x2000 / 4)
 
+#define RX_BUFSZ_MAX  0x07e0
+
 #define GIE_GIE    0x80000000
 
 #define CTRL_I     0x8
@@ -195,7 +197,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
         return -1;
     }
 
-    if (size > (R_MAX - R_RX_BUF0 - rxbase) * 4) {
+    if (size > RX_BUFSZ_MAX) {
         trace_ethlite_pkt_size_too_big(size);
         return -1;
     }
-- 
2.45.2


