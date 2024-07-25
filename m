Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11C4C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Kw-0001Lk-78; Thu, 25 Jul 2024 19:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Km-00011P-G7; Thu, 25 Jul 2024 19:57:20 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Kk-0001LU-Nr; Thu, 25 Jul 2024 19:57:20 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2cb5e0b020eso314719a91.2; 
 Thu, 25 Jul 2024 16:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951837; x=1722556637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+tHFqJ7gV+K/VWjbHPPaHW8XLoGgWDdiXZ96smvE3M=;
 b=Oer1+1Me+TlQwRzdLH9qoSrwLHccVOc3KiGLKrZcZNeAY7Vsa8aOZm2g3T5xz3siEu
 iqvGFESd0nc24eCaJGo399Ct3A9X7m2mFMw/ySnwaLJmEugVS+Hnr2mtvo+eEifxHv/g
 mRCJKm/rbwrC9EkO1e6HaikI1sOfEt4flm4wdklYzYFqUUMCLDhCYQIqNslJIdxNSv/Z
 zZsleR47IJWABJSiF4hWoEUFQfOe+jId01zJrwGSDMoiy3bsS8N0xZlOHRiFb5gLwmqC
 juecThJHejR1GRfSqFPN+ibIdsvd/5teI+GN8NVw32UXufDmerR24xoth3KyTMlbjgND
 vwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951837; x=1722556637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+tHFqJ7gV+K/VWjbHPPaHW8XLoGgWDdiXZ96smvE3M=;
 b=alfgoWJwe+NO7YoSSWkI8KVbXp/CU9OLuBRbwsLQ2P2GBK5+AaiJew/D6WiHZPrueH
 ZHOsVsnbBMM1TEPZpVFl3fLbHWf3XMrx+/eg1iwz/evSmVmNdAaB8aUmCY8L5uiJ8+Rk
 PhFDThIhdnO8LXNJsWMM2Su1H/CYektmht5Wj11hTNZUzNOj0EnxB8uU38logMVcu2Pq
 /fGTQQH8/xPXW9ifBnLgB43rrRCiH9d4nMRn78qZVy6VBm1Ro0xMawtbRtUtyTOrG+B4
 oJtlVMww9mImemvn2fMadFlXzAio6vKm5oJqbWiOaC5h5OAoN6Q5YPAVrhUjqbn4Brlm
 h5kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL0hPlzpU/J+4M3SkVFNoYm1dJmG9USo9OwW3j0cKPYNCA+K12Qw5ryXbQrHhih0/qks6q+yjc0Hg0sLjZMF8188AF
X-Gm-Message-State: AOJu0YwG/Y6GVdIijpu9PmRUefMeP7k4eyZjFvrsqgOFJxkCNNz42NrL
 fyTv9CL63jLLXhcCe3ases9FmvpbTSjCD9GGCiJBZ0THI8R4XfvfZB6Q8g==
X-Google-Smtp-Source: AGHT+IGO5D+HrcYki0Cj6qT6D6+SqEA4BALj7tbXKCVUt4CIp3fkpMhfh5PEx43Hhjl28ZvdC+Mdmg==
X-Received: by 2002:a17:90a:2c4c:b0:2c9:758b:a278 with SMTP id
 98e67ed59e1d1-2cf2ec03929mr4109325a91.35.1721951836765; 
 Thu, 25 Jul 2024 16:57:16 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:57:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 48/96] pnv/xive2: Set Translation Table for the NVC port space
Date: Fri, 26 Jul 2024 09:53:21 +1000
Message-ID: <20240725235410.451624-49-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Set Translation Table for the NVC port space is missing.  The xive model
doesn't take into account the remapping of IO operations via the Set
Translation Table but firmware is allowed to define it for the Notify
Virtual Crowd (NVC), like it's already done for the other VST tables.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index c3b5bfe61f..08b9166a09 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -722,6 +722,7 @@ static int pnv_xive2_stt_set_data(PnvXive2 *xive, uint64_t val)
     case CQ_TAR_NVPG:
     case CQ_TAR_ESB:
     case CQ_TAR_END:
+    case CQ_TAR_NVC:
         xive->tables[tsel][entry] = val;
         break;
     default:
-- 
2.45.2


