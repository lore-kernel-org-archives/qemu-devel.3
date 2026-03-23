Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3834F483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iXI-00045i-PK; Mon, 23 Mar 2026 12:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXA-0003qE-EJ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:47 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iX8-0000Zb-Or
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:53:44 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439bc14dcf4so3723972f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284821; x=1774889621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ytl/Lf/ir6hv7oQtfO3hAVuKT+Xlc63h9VpXwPWBR6I=;
 b=dROAP88us0XhtPpOy4hh2WksFFjUUc1tKb0eKYZfl8MJvAA5SlzgQzBVVlw7+dNkGN
 6Wg3gk4B0wsz+HZnCHIMm78TW2LVDL/HO+uODvQoxikOstY3EEtYw9w2jk2GUyqSNVbm
 RKvien3XJNoffmRyEES9iRkATVF6r6y7f83NjT45i3emkOxwyIVus3iXtry/0mj3dBJ2
 F80D/tw4vR/qD6QJAzvivROfB1TPZEWjYokaOdVi0VjZgJboP3L90bV0zq4NIRZaa2/l
 hbxiD1JV9kJxMNcKvxRwFB1R3bhHBqKr9zGvBUoeNbpakmy6Nwzf0GDt+OUlJV3BiHuv
 kTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284821; x=1774889621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ytl/Lf/ir6hv7oQtfO3hAVuKT+Xlc63h9VpXwPWBR6I=;
 b=jhb7Uh1NiCbE5lc/HZX6XPeXNqf3Wgejs0z0QbIty/7qLxpdjgrXRAXWkOmpOSK2Qm
 SihsMBfYwsk6r8AUW/wT6p3yxECu8AF7gkZzDTAAL0SCA0cXODSWWGv7GGxxWA2Ugrnr
 JrXB4IdzlWDVPEQz6EyKhszfENbkWJdi6J075XE4zeTXP1HB8SHZppZz9a35fySkenTI
 Cm9d6hxoSxtH+VRnFzBoMQpcc2UMtrkxI3lHLL95fbMzTJcB96twUfjJKLR8lGBddkos
 P0Q2/Tf/FLoNNzwqd7MrL5BVFTTUnKUZ9J7buO8cfXOiMtWgkthWrilj1S91xA3oSoN/
 /yvw==
X-Gm-Message-State: AOJu0Yz3UK6M4zFB9pUUU9OWfmbfJ+fOhpFSb/8ApxdTqX+kFa0Hc7+Q
 X1UDcNGwMFJJ0FqdHDze0/xSMdk48aOt6f/jXCCCsfghSvbp1DzryoRAp/gi7XGJv7d9baomeIT
 XZsSpMY0=
X-Gm-Gg: ATEYQzw9dsHjbi+cNQBrfQaIGEuD9Z55vsQkz4EQhV6dE7MPIc+IevFcdW9VeZVjEYY
 1klLKBu8gzykFxNBusadll6D2ex1eTAbkhQLnZeC5yoDEU35om+8Ry6Fwrrshh7fJ+6NqPJ7T7t
 dgxkaAJg1BOkWE49SMlAkGuRs9fcUC5fEpH6SfxkVwhMImQPKEaYAd1DuTPUENJyO0ez3y9nc0u
 cRdtC3HLn6b3M2VSHKtBJYejf4XenibdlYPl5xpMeEPXAg4mZl8KBaxFKD5Sp8X8lJPyB3y9uog
 ml/USyIB97UEbr48lYSfRxOy+k5+/Oqbw45dO0As94rp/bDz/PTU7AFz610Dk5hPC3a0wipyrAb
 Sws1Y99QyShbbLVwedxzQh32ipBcET8zKK39DSbcH62hx/16ppa/83y/yAi3wEkh9oXXAdg8bYX
 L18UiAW5MZpMU1bTwx+YW3ZxO8d/UvxEh+qmC/h31FvQ3CnPGCyNhDueR1fjw0A8qRU6rKw31o
X-Received: by 2002:adf:e19c:0:b0:43b:4166:b855 with SMTP id
 ffacd0b85a97d-43b805923d0mr482603f8f.14.1774284820702; 
 Mon, 23 Mar 2026 09:53:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64715539sm31339390f8f.33.2026.03.23.09.53.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:53:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/27] hw/cxl: Exclude Discovery from Media Operation Discovery
 output
Date: Mon, 23 Mar 2026 17:52:03 +0100
Message-ID: <20260323165218.96607-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Davidlohr Bueso <dave@stgolabs.net>

Per CXL 4.0 Table 8-331, the Discovery operation "returns a list of
all Media Operations that the device supports, with the exception of
the Discovery operation (Class=0, Subclass=0)."

Filter out Discovery entries when building the output list and adjust
total_supported_operations accordingly.

Fixes: 77a8e9fe0ecb ("hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery commands cxl r3.2 (8.2.10.9.5.3)")
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Message-ID: <20260319184256.3762391-3-dave@stgolabs.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cxl/cxl-mailbox-utils.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a5b70cd01c0..d8ba7e86252 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2675,7 +2675,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
     struct media_op_discovery_out_pl *media_out_pl =
         (struct media_op_discovery_out_pl *)payload_out;
-    int total = ARRAY_SIZE(media_op_matrix);
+    int total = ARRAY_SIZE(media_op_matrix) - 1; /* exclude Discovery */
     int num_ops, start_index, i;
     int count = 0;
 
@@ -2701,10 +2701,12 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
 
     num_ops = MIN(num_ops, total - start_index);
     for (i = 0; i < num_ops; i++) {
+        int idx = start_index + i + 1; /* skip Discovery (first entry) */
+
         media_out_pl->entry[count].media_op_class =
-                media_op_matrix[start_index + i].media_op_class;
+                media_op_matrix[idx].media_op_class;
         media_out_pl->entry[count].media_op_subclass =
-                media_op_matrix[start_index + i].media_op_subclass;
+                media_op_matrix[idx].media_op_subclass;
         count++;
     }
 
-- 
2.53.0


