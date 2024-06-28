Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E604DC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5g4-0006od-AL; Fri, 28 Jun 2024 03:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fo-0006Dc-Ne
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5fn-0001un-1N
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:05:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-424ad289912so2323675e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558325; x=1720163125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3vBMoM//nVZe9CjYveKRdhPX/dFzNyrTxzPZ8neKDDk=;
 b=YduicTprbv7khCd6BPiWu4JgWdy68LuMiQM3x+4D+vXsroRobVuQRPlxhMVBnUaLQc
 mRDOexQ7gBSx+q2czexA2Vh760O6UtFoiffpQfsoFmEgURYXMAY3pr4Jvr4Qbu9EVPJQ
 jpj5AqibxNwe63f762J3ggAI1cVthMAXXiOWt2MS8Udsvc2waSWeZGecowgOddmT7DFd
 s2vmxvdcyqs3dgL1TtgU7v0hKqV3kzboItGhsJiapwidIhthMAOHtbmfDLTrwnT6/wdQ
 yIec5XISojC/TluvsOsxGhMcYT8YUZzGch2eGXmGavncllz9eMI1zv/lN9Q8LrgDUkse
 T9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558325; x=1720163125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vBMoM//nVZe9CjYveKRdhPX/dFzNyrTxzPZ8neKDDk=;
 b=Mhg/MnE/7+5mdh9+JEqyx4db38gpgu5dXYAJgL+VKYM8NnFXpK92ylkRwJDRS5QMn4
 Iopibwe5gxz5hWyAzWIc6ipkBQBnAVovYiFnFgztWTSCN1MVvnJlfnsZNkTFs3ZCr5Xg
 /SrZBjkckPh3ohIIVndIAM/+LJ6YVlPIrKI9FlAg5e/abTBX57J85ibNG/7bDopG/5NV
 I6arrEfwWmgArT5LuAlR1Vn22KKdHtCAl+segNrH89erOHTXyE0UhTGSsDIsBHoDFy34
 s+VtRJ1Sq30yiA5g7s33p8suL9Kqu1rOAKrF9US7obusnBJadEVP0IKp4/jhszmjD+k+
 lMiQ==
X-Gm-Message-State: AOJu0Yxf4x8sNpY2KS2Vjq7pR7PYU5cSMB0alOLLTl6IvZbJxAMdVzpG
 nO9A6/mES1AuUmxNlfSMVc8LDhJWeAOSPWl1jKEZjzR8N+R0lhQKbZGmMxqgsx+0SGllVEVuqvu
 5cFY=
X-Google-Smtp-Source: AGHT+IE5524OYy7bBPCxcCuvNEhaOAWSQzdjltGFXgMxYQ361BhNJW7IBaKu08YhcieZxHSnmWN5qg==
X-Received: by 2002:a7b:c84d:0:b0:424:ad7c:273b with SMTP id
 5b1f17b1804b1-424ad7c281emr49665125e9.32.1719558325555; 
 Fri, 28 Jun 2024 00:05:25 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c0fbesm20427305e9.43.2024.06.28.00.05.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:05:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 30/98] hw/sd/sdcard: Duplicate WRITE_SINGLE_BLOCK /
 WRITE_MULTIPLE_BLOCK cases
Date: Fri, 28 Jun 2024 09:01:06 +0200
Message-ID: <20240628070216.92609-31-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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

In order to modify the WRITE_SINGLE_BLOCK case in the
next commit, duplicate it first.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 690a3f275e..5dbfc8000b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1461,6 +1461,35 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 
     /* Block write commands (Class 4) */
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
+        addr = sd_req_get_address(sd, req);
+        switch (sd->state) {
+        case sd_transfer_state:
+
+            if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr,
+                                  sd->blk_len)) {
+                return sd_r1;
+            }
+
+            sd->state = sd_receivingdata_state;
+            sd->data_start = addr;
+            sd->data_offset = 0;
+
+            if (sd->size <= SDSC_MAX_CAPACITY) {
+                if (sd_wp_addr(sd, sd->data_start)) {
+                    sd->card_status |= WP_VIOLATION;
+                }
+            }
+            if (sd->csd[14] & 0x30) {
+                sd->card_status |= WP_VIOLATION;
+            }
+            sd->blk_written = 0;
+            return sd_r1;
+
+        default:
+            break;
+        }
+        break;
+
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
         addr = sd_req_get_address(sd, req);
         switch (sd->state) {
-- 
2.41.0


