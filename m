Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD21C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0hb-0004W1-Fm; Tue, 25 Jun 2024 03:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0hZ-0004Sx-GY
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:34:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0hX-0003kM-TZ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:34:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4248ff53f04so13660965e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719300890; x=1719905690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wcx7yYRM3PiZ4d5mUpewwCNROsxhQ8qYk6qnzFU22vI=;
 b=VIVVz+6tah2WqfeqZ2rlKCJZf85jNV5owBvqisWraic+RVlJg1sfSp3v2y8NAw42VR
 BNSX8aqvL4CLAxnQW2jPzTE3K7hThUdZClksvgN/OhOFevVdPS2KAkmqarNtGcMlrWQi
 x1C9A+MzPSzGSNfxs3wohWKSWtrplF4jcj8BIigDUHwrH6l9UJKCUcmV4Gk0AGXDd2Ii
 +1krkDEEEB99JhJtIedTBYaF56TWrRNOeEwdSo1MXGVTP1O3I+kz1ewmFxqWkr0OFVOq
 RmUuCmxNwLBLIl+G6vIZVcioxTot1uMU6gPOSEf36HrsQc2+KohZW2QmYIvwN2kb5EdK
 2MLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719300890; x=1719905690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcx7yYRM3PiZ4d5mUpewwCNROsxhQ8qYk6qnzFU22vI=;
 b=ffNvHdRhGmX72tuLka8cluQ+kRAe+eTyaHrE0uz/dvc30zfPD3bKt6GnWNxiByuR7I
 bgeuPaPhspNgJnP4mh9xV1idP7JWwQrl0uIsBlarR5WVTef62fheNNn3BnNBt7bnVLPd
 36b5WX3XbZ/feVfbw7TreGvK4bLtkoHh57+m4XoAY6avzRpyDpE+xf7fVseAX4NpyqwE
 QrKFW7GTT2zFpz59pIjE3RxqU7ygCmQZ9krm8F1f55Flf/t9KaN82MAB2Tlrmj2vviPf
 xS9q5z6ffdcYD6uZr+2gI0O13rt6RoMQQmj2lMTzegMfPoaFppDU663drW3AFsrp9IZK
 2qhw==
X-Gm-Message-State: AOJu0YyaOOFWv+PWQaU+r2l/Takxz6bmeoIx6oPfW6HaImQ4oDnUo8Xh
 CBYcicWxzo0CcfB8jjuO8WlqnI1hwTlrflryd41TujySonpp+Adbt2pI9cmmS5uznwC+Qgrjaio
 +
X-Google-Smtp-Source: AGHT+IFZ3RQujMgIOcd1i/ugunHPeymXsSTsdekah51oceNQtA9OZZ+w6h5Ni5ONggNX2e9MNd17FQ==
X-Received: by 2002:a1c:7711:0:b0:424:816e:872d with SMTP id
 5b1f17b1804b1-4248b95c94emr50128615e9.9.1719300889916; 
 Tue, 25 Jun 2024 00:34:49 -0700 (PDT)
Received: from m1x-phil.lan (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d208b3dsm204176865e9.34.2024.06.25.00.34.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jun 2024 00:34:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/7] hw/sd/sdcard: Introduce sd_cmd_to_receivingdata /
 sd_generic_write_byte
Date: Tue, 25 Jun 2024 09:34:35 +0200
Message-ID: <20240625073441.34203-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625073441.34203-1-philmd@linaro.org>
References: <20240625073441.34203-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

All commands switching from TRANSFER state to (receiving)DATA
do the same: receive stream of data from the DAT lines. Instead
of duplicating the same code many times, introduce 2 helpers:
- sd_cmd_to_receivingdata() on the I/O line setup the data to
  be received on the data[] buffer,
- sd_generic_write_byte() on the DAT lines to push the data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2df3c28cb7..7fea0afb62 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1081,6 +1081,21 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
     return sd_illegal;
 }
 
+__attribute__((unused))
+static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
+                                             uint64_t start, size_t size)
+{
+    if (sd->state != sd_transfer_state) {
+        return sd_invalid_state_for_cmd(sd, req);
+    }
+    sd->state = sd_receivingdata_state;
+    sd->data_start = start;
+    sd->data_offset = 0;
+    /* sd->data[] used as receive buffer */
+    sd->data_size = size ?: sizeof(sd->data);
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_cmd_to_sendingdata(SDState *sd, SDRequest req,
                                            uint64_t start,
                                            const void *data, size_t size)
@@ -1930,6 +1945,19 @@ send_response:
     return rsplen;
 }
 
+/* Return true when buffer consumed */
+__attribute__((unused))
+static bool sd_generic_write_byte(SDState *sd, uint8_t value)
+{
+    sd->data[sd->data_offset] = value;
+
+    if (++sd->data_offset >= sd->data_size) {
+        sd->state = sd_transfer_state;
+        return true;
+    }
+    return false;
+}
+
 /* Return true when buffer consumed */
 static bool sd_generic_read_byte(SDState *sd, uint8_t *value)
 {
-- 
2.41.0


