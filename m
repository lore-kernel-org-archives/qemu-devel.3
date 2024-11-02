Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C73DE6780F
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 20:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7LB7-0006yk-PM; Sat, 02 Nov 2024 16:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1t7LB6-0006yb-Oq
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 16:57:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1t7LB4-00083p-Pk
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 16:57:00 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7206304f93aso2867130b3a.0
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 13:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wshooper-org.20230601.gappssmtp.com; s=20230601; t=1730581016; x=1731185816;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWiSh8qhBF5hdQNW3uEFIh3fsWF3IYhFSQHrFmKnx9s=;
 b=Pk4nQVE++pGCoaY1Is6prdAnx7LWimjFCxmVDa/zzNTRkQfQfStmNzYwYXCj+rib+/
 c8UPdDoMxjX4aBlzwYl2MjI7XjnDFi7PEY2/yVHVJ3KG8Y9AGthctrhwtiUN8uRQD+P1
 Gv+7tFTFb5CcKrdoygrx9rN8If9twfUOrq8rkAK3FvW6VuFhgJ0kngNJqXrpAvEjqNlC
 cPbtqBui640Tcqg8UZCL/RtauVIqei9l3iLMAFGbpHMbqvQ9k8Shp86qDXf989zh29oZ
 1+5HclBrUPRZQK0zWeQ1ybShRv+T28KWWAFGJBl4glbXbxsLx5aMdFX5Ew3piwUz0NCt
 +Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730581016; x=1731185816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YWiSh8qhBF5hdQNW3uEFIh3fsWF3IYhFSQHrFmKnx9s=;
 b=L+KYmbtsQLYcY4aV8pja4yXAWPrLs4R++nX4RxAC6EidQmVQ7lEjHgjqlDq0Ny8m78
 sKLte2y2kCcnxTaiQPNQOyKdjUGNLP8lzpK9HVpwDJTd62vNz+fXAhhsfqtrRYWO15Vz
 mCHJX6eUTYUj8vJN3Ujgxy8hZE5TvGEI2x5XZ/9PcJ2ngzOq5jJ0bn3vMKcFyu0wN6P4
 S5zWp/zl0PASQQUdHnLORNxr00scr6hsQfVl9vBNJH1uWZQet7ja8Tuuq7rjgsu/mMCm
 DTORWNnDIALosxcu+8olgDWBta9pSKCE10o7NlQiGFma6UQUDzYujspmfz6yi013jgJZ
 xfSA==
X-Gm-Message-State: AOJu0YxKU8OKGuAzlvZH+Q4376hnHqNIfJYCUWztvVoclRtoOoK13rzD
 SuV3VjLauBTrdfPvhA7n1HzUlfSCl8ZRinNFOBIamKXQuAGHnKxp0uY0HCF3+mA91hI4ObitJu0
 LLno=
X-Google-Smtp-Source: AGHT+IH8ovnYlsPjwWHd1V4Ij/cgrrTi6x9vaqhkqkLB0VoV5minrhJ4lSy8BuN0EreNsPky6b0zHQ==
X-Received: by 2002:a05:6a00:3d51:b0:71e:cd0:cc99 with SMTP id
 d2e1a72fcca58-720c98a1bfamr12661172b3a.4.1730581016227; 
 Sat, 02 Nov 2024 13:56:56 -0700 (PDT)
Received: from localhost.localdomain (syn-076-081-243-074.biz.spectrum.com.
 [76.81.243.74]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45298a89sm4243132a12.16.2024.11.02.13.56.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 02 Nov 2024 13:56:55 -0700 (PDT)
From: William Hooper <wsh@wshooper.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>
Subject: [PATCH v3] net/vmnet: Pad short Ethernet frames
Date: Sat,  2 Nov 2024 13:56:53 -0700
Message-Id: <20241102205653.30476-1-wsh@wshooper.org>
In-Reply-To: <CAGCz3vsusRSsT8-Fi3a2Z4aeQMtxCzDZ73D8ZgefxVZvm=qY6Q@mail.gmail.com>
References: <CAGCz3vsusRSsT8-Fi3a2Z4aeQMtxCzDZ73D8ZgefxVZvm=qY6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=wsh@wshooper.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

At least on macOS 12.7.2, vmnet doesn't pad Ethernet frames, such as the
host's ARP replies, to the minimum size (60 bytes before the frame check
sequence) defined in IEEE Std 802.3-2022, so guests' Ethernet device
drivers may drop them with "frame too short" errors.

This patch calls eth_pad_short_frame() to add padding, as in net/tap.c
and net/slirp.c. Thanks to Bin Meng, Philippe Mathieu-Daudé, and Phil
Dennis-Jordan for reviewing earlier versions.

Signed-off-by: William Hooper <wsh@wshooper.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2058
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 net/vmnet-common.m | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/vmnet-common.m b/net/vmnet-common.m
index 30c4e53c13..4b7e330c05 100644
--- a/net/vmnet-common.m
+++ b/net/vmnet-common.m
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "sysemu/runstate.h"
+#include "net/eth.h"
 
 #include <vmnet/vmnet.h>
 #include <dispatch/dispatch.h>
@@ -147,10 +148,26 @@ static int vmnet_read_packets(VmnetState *s)
  */
 static void vmnet_write_packets_to_qemu(VmnetState *s)
 {
+    uint8_t *pkt;
+    size_t pktsz;
+    uint8_t min_pkt[ETH_ZLEN];
+    size_t min_pktsz;
+    ssize_t size;
+
     while (s->packets_send_current_pos < s->packets_send_end_pos) {
-        ssize_t size = qemu_send_packet_async(&s->nc,
-                                      s->iov_buf[s->packets_send_current_pos].iov_base,
-                                      s->packets_buf[s->packets_send_current_pos].vm_pkt_size,
+        pkt = s->iov_buf[s->packets_send_current_pos].iov_base;
+        pktsz = s->packets_buf[s->packets_send_current_pos].vm_pkt_size;
+
+        if (net_peer_needs_padding(&s->nc)) {
+            min_pktsz = sizeof(min_pkt);
+
+            if (eth_pad_short_frame(min_pkt, &min_pktsz, pkt, pktsz)) {
+                pkt = min_pkt;
+                pktsz = min_pktsz;
+            }
+        }
+
+        size = qemu_send_packet_async(&s->nc, pkt, pktsz,
                                       vmnet_send_completed);
 
         if (size == 0) {

