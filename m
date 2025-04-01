Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5172AC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tza2t-0002Jp-7J; Tue, 01 Apr 2025 07:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tza2m-0002Gu-41
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:44:36 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tza2h-0003i3-QQ
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:44:35 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22438c356c8so105525575ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 04:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743507870; x=1744112670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+EaAZxew1nTxO+VCpXNprDV9pUEDQL8oSwkWG7MVV4=;
 b=T0o4Ils7SXKpc9B4a4mdjw71TwOcRGYf5vaNN+6LmnzoZ4jBi/tooTtlsj5xaTkX9z
 Q5C6QUiO0MfhGbS3eW4TXW3od8XcnwRzFQJXnxgt3lzxuVkwBTaJokHMy2L/wmpDcJ1Z
 BUp13SCT0Bw20xATy8OGhA7N7HOVQMbtjUth8NVCv8r6o9ynh+UgKLReG9rwG4Kc4bL6
 wuMBZHzL7Ly8ea0yBPY0mQhMYe/i3yKAflAWUZZSqkvqdh3SM7G/PAlD6jlTokN1f5cu
 XaSalBy5si9FUUNPCSTYgXQPlhzYM8FrC+kuvc13Z1cvlKvfb/eYUDH34nYA2AcudqvY
 v3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743507870; x=1744112670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0+EaAZxew1nTxO+VCpXNprDV9pUEDQL8oSwkWG7MVV4=;
 b=LwbjanmrIXEPVJtEilucAQijl1YpBkOSL1J6bZPYrFO3+l4aip4bwIOWYSIdSXokq9
 10uFU74cy9CJKzLO/gSwH8bX6yLcaVVuDcY1J7AwK2mpiUs1CuzMEgRoIKI75PyNELDN
 FTJzSD+j4ihpKZiBojhQBzce8Afbhq9CgGlOZ8xc01CvpVvfpOubwWsIlU18dnmLG/9j
 xASwRq0nOtQGASwjGvTk2e8aUv+6G9+539I89giGSD5DV5ODR03w5adrcCbYhYEWYiT2
 jX5twof+A2htPeU6RUKduYuWyEpJO/e2m17KOswdfMzVQQThKyid4Slgbdewt1fzBLkf
 CazQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWca056+Pmf+1VKfWBNWdRjwU+OxoQSDYgsEXJji6rkv+oCX/DkMQH3OABfkb22AbwKb8VTpXQNpIq6@nongnu.org
X-Gm-Message-State: AOJu0YxMg4lsVvxSF2Pnss+bSZ5GroiYaQE37b1I3wbCOVuzAen4OZV7
 C52X9i4XbCzeMJzJEWfhaJhD0Sj32+Q6JGpKhiFC9jBdljHe4zGlOHslVw==
X-Gm-Gg: ASbGncuknXtJ3w4sy1vG6NT23GP3zTsADrr8U3wV7bl5r8WR41Eh6tXyMGodaq/6kGh
 Pi5FYqobZP7UkdTHL/Cdkxr1w4Y2yRs1uPd4ap0KsWSHhbZIfzWBCdNWPSemqs7T8+0bssqOhFJ
 wp2sx63LLvt7rjsdMTOdVuZMNNAEqC/aXrquSU796mx0rBuAf0gv2eU2qJE6JCwowFrQGGc+Fcw
 L8r3ymBkLdK4UEbxSamtWHYSZPTTyCTXWVOu8nm1zuJKOmC9LhUwFWY6ElPvHNY2Jf0D3nQ/ckW
 aIzOglUqqGwX9zVbN+4AhnXvLR7y55SjfjB48Ag2Vz3JIvm/iBTKefUinwuV
X-Google-Smtp-Source: AGHT+IEtx8aLnyc3hYv3yxf8F83hmALSzm8jYzr9nWWklv7m2W9Rlcks9Ac9GIP+LxsKhY0SX1GTxg==
X-Received: by 2002:a17:903:19f0:b0:224:1e7a:43fe with SMTP id
 d9443c01a7336-2292fa01904mr198497315ad.46.1743507870296; 
 Tue, 01 Apr 2025 04:44:30 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eee11b7sm86408135ad.86.2025.04.01.04.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 04:44:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] ipmi/bmc-sim: add error handling for 'Set BMC Global
 Enables' command
Date: Tue,  1 Apr 2025 21:44:12 +1000
Message-ID: <20250401114412.676636-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401114412.676636-1-npiggin@gmail.com>
References: <20250401114412.676636-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Mask out unsupported bits and return failure if attempting to set
any. This is not required by the IPMI spec, but it does require that
system software not change bits it isn't aware of.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 3cefc69f8a8..794b9ed5b12 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -235,6 +235,7 @@ struct IPMIBmcSim {
 #define IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE_SET(s) \
     (IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE & (s)->msg_flags)
 
+#define IPMI_BMC_GLOBAL_ENABLES_SUPPORTED 0x0f
 #define IPMI_BMC_RCV_MSG_QUEUE_INT_BIT    0
 #define IPMI_BMC_EVBUF_FULL_INT_BIT       1
 #define IPMI_BMC_EVENT_MSG_BUF_BIT        2
@@ -938,7 +939,14 @@ static void set_bmc_global_enables(IPMIBmcSim *ibs,
                                    uint8_t *cmd, unsigned int cmd_len,
                                    RspBuffer *rsp)
 {
-    set_global_enables(ibs, cmd[2]);
+    uint8_t val = cmd[2];
+
+    if (val & ~IPMI_BMC_GLOBAL_ENABLES_SUPPORTED) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    set_global_enables(ibs, val);
 }
 
 static void get_bmc_global_enables(IPMIBmcSim *ibs,
-- 
2.47.1


