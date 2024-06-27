Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FADC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrvf-0000cd-Sw; Thu, 27 Jun 2024 12:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrvc-00006j-Df
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:24:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrvY-0001NU-Kx
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:24:56 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-424ad991cbbso18631155e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505491; x=1720110291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JpVotoHspFlZ3BpKrTY/FaOKVvxynyJagKJZJS+6h3k=;
 b=sAD4SVpep7t9QEf0mJp42GPVlhDmfctgRDq9RYjpqQx5fDlAIXk0sPjt6TM6pRX+j9
 jpvqFtw6ih9WH0zbmf7LLgYLYAcJxTvJPaFy+I9pKBKj1yn5EnVocFeuaOkDdc1mNH7n
 wXwX+T6uWYxK5sPP9fZkglyYK2NYeN25xm8+rv6jTU48Yf99i97ZOh1agOZGRcWp2gVc
 hKp67AFftySEtJWW6Vephc7oQGjRhNF6H+fOeLp9J7iTRdAvFBt+5jTaUtFt4Y3Jpv+q
 uIeJkYRCJEyu6YSGBeGUC4CiUjPsm2iX2TeR2BWmXV3A//io6u5eYSl3r40gzjqEMAt4
 ZuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505491; x=1720110291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JpVotoHspFlZ3BpKrTY/FaOKVvxynyJagKJZJS+6h3k=;
 b=JshIPIhX0xCzKKpk3XispGYa/b1NHU8jCg2RZyesbVV4KsfYo1duL0/b1hE4PdfNHk
 pM5U/u3nQ0Lxq8MMYHDegbP7I0qnC/6pyI5iU0f62x4mJ07innYY2Hokb0ARE+La+1ha
 mTvp3H71iGqKlEqTZ7hXDzmd2hObt4zb2CmCS59OzaomliwCDlNrexAOU9KcEVEjvb04
 IeK5+uFBDjvh2bPPPa3PIA18GvHdAhVCdqOVOpH8EeOf1VPJgQpIrR1yWqOj4ZxrFK49
 SCNLk7wYd+jtckIdH9BeqITmhDXJlkwimNrFaCvAV9o07+1wxnUP7A2zmuz/hKcv+BpD
 rzcQ==
X-Gm-Message-State: AOJu0Yy7EY403T9pNH88qVHOEyeP5Z1aVyiGlU4ux1/cFZm8x1aHwRhN
 myJ6XPZmZEwYgCWoL4WveNd/2PxTXPkRKqVk6d6eQocTErbhe/ys8so8FVtGzy+IAY5X5ktzoCU
 2Isc=
X-Google-Smtp-Source: AGHT+IGaHaYaioNHcZq41Nt4IYxvgNJzCq5HK7cxid1nICk/VItxrTF+onqpk2/SC4ANeBmO9jMlZw==
X-Received: by 2002:a05:600c:16d4:b0:424:a406:ad52 with SMTP id
 5b1f17b1804b1-424a406adb7mr55279375e9.19.1719505491050; 
 Thu, 27 Jun 2024 09:24:51 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36743699c0bsm2349553f8f.70.2024.06.27.09.24.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:24:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 10/17] hw/sd/sdcard: Assign SDCardStates enum values
Date: Thu, 27 Jun 2024 18:22:25 +0200
Message-ID: <20240627162232.80428-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

SDCardStates enum values are specified, so assign them
correspondingly. It will be useful later when we add
states from later specs, which might not be continuous.

See CURRENT_STATE bits in section 4.10.1 "Card Status".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sd/sd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 135b7d2e23..fbdfafa3a6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -75,16 +75,16 @@ enum SDCardModes {
 };
 
 enum SDCardStates {
-    sd_inactive_state = -1,
-    sd_idle_state = 0,
-    sd_ready_state,
-    sd_identification_state,
-    sd_standby_state,
-    sd_transfer_state,
-    sd_sendingdata_state,
-    sd_receivingdata_state,
-    sd_programming_state,
-    sd_disconnect_state,
+    sd_inactive_state       = -1,
+    sd_idle_state           = 0,
+    sd_ready_state          = 1,
+    sd_identification_state = 2,
+    sd_standby_state        = 3,
+    sd_transfer_state       = 4,
+    sd_sendingdata_state    = 5,
+    sd_receivingdata_state  = 6,
+    sd_programming_state    = 7,
+    sd_disconnect_state     = 8,
 };
 
 typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
-- 
2.41.0


