Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A6DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 21:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s30D8-0002kV-5m; Fri, 03 May 2024 17:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincentfu@gmail.com>)
 id 1s2x3Y-0002Np-EE
 for qemu-devel@nongnu.org; Fri, 03 May 2024 13:50:48 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vincentfu@gmail.com>)
 id 1s2x3W-0004oK-VZ
 for qemu-devel@nongnu.org; Fri, 03 May 2024 13:50:48 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-69b59c10720so26312236d6.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714758645; x=1715363445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lVuuV9v1jEHj2WcjhJ+jnZIzcrJ8UTzMw4Q4ey8divY=;
 b=XyXGCMfjcdvIlIP7ayU0rhlIyP+YFza6hybdQfrIdgqj0mx6WcuAhHy9AKju+RzZPt
 v8qAHnss1UrFFClavVF8JUNPZ6Ww6YuFgFaTgViJ82xeyzVusV6h5VPX6PfuC/Kw0rHb
 DFfNJfphZySubogYZG7dcB1qqZshNWVlHuAqrZNk4egs//BLNcw6fmQMn5dKPRLIPsZM
 qs2pZ6ANcBLNw0kK9Erlth0eSUBA4+3vId3CGidJsnRaQ1bOE5BouzcMWL8608JESw+z
 zhUKfK8FddPGoerpHjERibQyba1XNOkCDVCCdvAICFQyY5QDFALhhHfaB24ALUIbr8+E
 O5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714758645; x=1715363445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lVuuV9v1jEHj2WcjhJ+jnZIzcrJ8UTzMw4Q4ey8divY=;
 b=NbvwTNgI3iE4afOVffpLn+hu4IUhxx6XntjekLKBws4MXB6T+63pa1wFYqN8LIzK17
 sqCXwry/h+f7shp+5V8XzEG6x++ztfudZaSDsHA5KBqyqfOqgBRs0HqliUMLSGtcG0sh
 symyxuQeR9Nlx23TCCvXAM33kT6DzQT9T3SqJLMiRxRUGPtgwVmfqF9UEMQCrdayW7N6
 wd+UzeUJgYKrVpzaUl5k+a+HSXvzoCjoMmX0EXC3lfKBto5zu39ILHomYGKFSyvqe1wE
 5CSFLYmiVUKUo12i8JyKNAc6av43uuchhCETaL/+JbAKy/yKu5oZ1r7S98c8XCI02E2k
 Bzsg==
X-Gm-Message-State: AOJu0Yy3izjS9DIZmvNTxEkNCgtSzOnDnWvnpBZyv3238yer7t7B5cIS
 FKwykYnHA0ifDqkowYFkAHeFwNj2Ateynxqi8HsOcsONBsR0gSwsLXDFUA==
X-Google-Smtp-Source: AGHT+IEfMRC8D9yLwAhzLqpOStM2QMxv9NqHgbYpFegTSLPoeWyzDgmXp+8POsabLSBfHJ1B+P199g==
X-Received: by 2002:a05:6214:2aa1:b0:69b:5889:8eff with SMTP id
 js1-20020a0562142aa100b0069b58898effmr3823917qvb.43.1714758644705; 
 Fri, 03 May 2024 10:50:44 -0700 (PDT)
Received: from fio-dev.vincentfu.org.
 (pool-173-79-40-147.washdc.fios.verizon.net. [173.79.40.147])
 by smtp.googlemail.com with ESMTPSA id
 q6-20020ad44346000000b006a0cd146a5fsm1379500qvs.21.2024.05.03.10.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 10:50:44 -0700 (PDT)
From: Vincent Fu <vincentfu@gmail.com>
X-Google-Original-From: Vincent Fu <vincent.fu@samsung.com>
To: qemu-devel@nongnu.org,
	its@irrelevant.dk,
	k.jensen@samsung.com
Cc: vincentfu@gmail.com,
	Vincent Fu <vincent.fu@samsung.com>
Subject: [PATCH] hw/nvme: fix number of PIDs for FDP RUH update
Date: Fri,  3 May 2024 13:50:04 -0400
Message-ID: <20240503175004.1573-1-vincent.fu@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=vincentfu@gmail.com; helo=mail-qv1-xf35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 03 May 2024 17:12:52 -0400
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

The number of PIDs is in the upper 16 bits of cdw10. So we need to
right-shift by 16 bits instead of only a single bit.

Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..e89f9f7808 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4352,7 +4352,7 @@ static uint16_t nvme_io_mgmt_send_ruh_update(NvmeCtrl *n, NvmeRequest *req)
     NvmeNamespace *ns = req->ns;
     uint32_t cdw10 = le32_to_cpu(cmd->cdw10);
     uint16_t ret = NVME_SUCCESS;
-    uint32_t npid = (cdw10 >> 1) + 1;
+    uint32_t npid = (cdw10 >> 16) + 1;
     unsigned int i = 0;
     g_autofree uint16_t *pids = NULL;
     uint32_t maxnpid;
-- 
2.43.0


