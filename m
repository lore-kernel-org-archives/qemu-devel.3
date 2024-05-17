Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D8CC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 12:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7x4G-0002Hy-ON; Fri, 17 May 2024 08:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hburaylee@gmail.com>)
 id 1s7rns-0004g6-Oe
 for qemu-devel@nongnu.org; Fri, 17 May 2024 03:14:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hburaylee@gmail.com>)
 id 1s7rnq-0005rO-Pl
 for qemu-devel@nongnu.org; Fri, 17 May 2024 03:14:56 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ec41d82b8bso3388025ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 00:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715930090; x=1716534890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SOHkXSWvHgA3/1fNfAvKV3xIPtBkGnRPeqH31mGkXAs=;
 b=fzCts46uLUsz1xZJTn9pYe2ArAw9iZbkcXESiypGJUzAfXe7ZIOFe1aqK5gi5fnI86
 ks6NhqjfFoK1AdUloXqCsZ07grz7r7J0DxGEucAfx6eVL15cL8YRVWtLNF8tMdaMb7W2
 SrCKLCdofOH0vn4NsNvquFJ1O/kmq1zv0fEG2KinZIdgcpD9ta4SwglRL+d4V82mMePb
 gxrEJndQP9UmNorDM8HZYS2yyOobvxStGnwy12dyxnlGsAPvCTEIIOy/QAHVjJ1zBw2V
 fgVpmXQGG4Eoj8Ntajbo5cHCYcMdLjewu3TBqlAIBf5kl4TVyU0jwvYqjFBENPwfYO0g
 xnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715930090; x=1716534890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SOHkXSWvHgA3/1fNfAvKV3xIPtBkGnRPeqH31mGkXAs=;
 b=RT5EsIOIFn3WxeJXM1b8o9V+l+gkzAvhFR8+R2dtO15HMS4x6W6vsA47ILT8uYmBo2
 kL6mu/CEhWHcFidzuQjg3vMCmdihATNUhU5Cdk3xx0cC1n8F8m2RnSgdW1IdYCm1sPod
 qg07nQ3XFAKWzrHmLDZtzS2LyLAHaG76BmVe3gvi/aGewqJp0jTsmnWuOc4GRH1vf8Xo
 to5CP+PnA8sid0oM0Az+qJWkVtL/tX4dq8VlGzXLlQvSlZkJWOHYYaBOr3Ql2GaljvqA
 Xpx7c6pdjSsTAgIb9YLVVcRKYk2Nuyb6Qa1uiurSvqFx8d35/uggzh/wfbOT6qV+/sgH
 vjpw==
X-Gm-Message-State: AOJu0YxUWHeymcq3MLLo6B3r9nL7BUMp1eWiIcMfLDDGbNaTNxGMcq1G
 2tEfafcLogRkHKdjPsU6Eqh4O2jOBlRV6+NCeiO77vc1j3GLGmXNtbLjhsS1
X-Google-Smtp-Source: AGHT+IEUaVJIG8GSv76CU6/vyvwOAkrG0rHDDg4jYsluO49px9gCwPN9Pit/YAeGPh2st1g/BvuTqA==
X-Received: by 2002:a17:902:a50a:b0:1e0:b62c:460d with SMTP id
 d9443c01a7336-1ef43e2659emr206996545ad.38.1715930090090; 
 Fri, 17 May 2024 00:14:50 -0700 (PDT)
Received: from localhost.localdomain ([8.141.6.128])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c134c13sm150494475ad.238.2024.05.17.00.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 00:14:49 -0700 (PDT)
From: Ray Lee <hburaylee@gmail.com>
To: qemu-devel@nongnu.org
Cc: hbuxiaofei@gmail.com,
	Ray Lee <hburaylee@gmail.com>
Subject: [PATCH 1/1] scsi-bus: Remove unused parameter state from
 scsi_dma_restart_cb
Date: Fri, 17 May 2024 15:14:45 +0800
Message-Id: <20240517071445.149364-1-hburaylee@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=hburaylee@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 17 May 2024 08:52:09 -0400
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

Signed-off-by: Ray Lee <hburaylee@gmail.com>
---
 hw/scsi/scsi-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 9e40b0c920..7c3df9b31a 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -255,7 +255,7 @@ static void scsi_dma_restart_req(SCSIRequest *req, void *opaque)
     scsi_req_unref(req);
 }
 
-static void scsi_dma_restart_cb(void *opaque, bool running, RunState state)
+static void scsi_dma_restart_cb(void *opaque, bool running)
 {
     SCSIDevice *s = opaque;
 
-- 
2.39.3


