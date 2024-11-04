Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10631D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7krN-0006jK-RF; Sun, 03 Nov 2024 19:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krB-0005ZG-He; Sun, 03 Nov 2024 19:22:10 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7krA-0002l4-1o; Sun, 03 Nov 2024 19:22:09 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-720e94d36c8so636653b3a.1; 
 Sun, 03 Nov 2024 16:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679726; x=1731284526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a33taQf2S5Abaj9drpvOgQzbgT3FLJu9qsTxXvnpnIk=;
 b=VDRc55ZNfQVgLmZEjvQ3JnBXW6DJAQZIVlI9jOgbRGBhmmxUUHsBy9coINOUN5vo8L
 90J414KsC3xlMZ90b+D7OFCf9lTnIJTyPHVufw47nVrYM/Yuics6k8eGCg0fJLcydQct
 JOnhH8OAQeftj4RIgpK5sQSDWlhYaYL7CegK223kNqPyXmIJHV18US5zkxdo9goJdZ5j
 PjMAA9PWOslZBAg/WTkySJVYl60utZuHMHXyBDn6a3BTX3XqG6zbYUgxeMxfbpgz35Tb
 po1Wx1pdtNCbsVOtMtXC9b89zQjPXmgcaNtF3FDyCRt2WM99p6Rce3zdw830uPal5Riu
 riwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679726; x=1731284526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a33taQf2S5Abaj9drpvOgQzbgT3FLJu9qsTxXvnpnIk=;
 b=l6dAWS9dZLxMh+2nVCEt9icRAU2q1gf5a27Y1s7uhkwGAo97jW/2gUgage5vSLMZPu
 yvJJEmZLwzEL92c+RT3Uv9RiiLywNfF1E2HbxoVX/Px065zHP3+Zjm28ZytppkHCjsMX
 9LdjsbwayOvSAYG83iL8EQTs6ibJ//J0ceAhzfFlfD04+vZmCEclJcTelA28lMWX8BX+
 RNBHhDm9voAK9rBnC9KWptN9IUr29cu1DMa4HSJ6szc02lYjtd6obpCPdZ0t31NtfF1e
 DczUtSlaqdG7iWgVy9kl309YtZHiUmwuxe8DU4PPwvs1zXPRw7dDD+NHV7SV0cMcEEOX
 3Ahg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+/hb92M9agMEuluRwDC78S5G8TAy4hIQXtx32OK9KEulXPLFvr1pvFQO8HqfJePe+QgNfDjC8SA==@nongnu.org
X-Gm-Message-State: AOJu0YxfeKGaRoWkut2m2H3upXm5g4c6H7Smr0fqxCTMqXFE81a3l+wW
 3J7s19+Z0Ea076q3u1LelwG1uLjba8oYGynUqt8tnT8rSs+KlQ8yg9Hfow==
X-Google-Smtp-Source: AGHT+IHOsQVnfpKXDZnevfTnldQj8crNTwOghntl3THs3zE1O4L5+AVz6wBiICCNBmPH6Ita7ept4w==
X-Received: by 2002:a05:6a21:999f:b0:1d4:f7b7:f20 with SMTP id
 adf61e73a8af0-1dba4232b33mr15017558637.21.1730679725934; 
 Sun, 03 Nov 2024 16:22:05 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:22:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 49/67] pnv/xive2: Define OGEN field in the TIMA
Date: Mon,  4 Nov 2024 10:18:38 +1000
Message-ID: <20241104001900.682660-50-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

The OGEN field at offset 0x1F is a new field for Gen2 TIMA. This
patch defines it.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c             | 4 ++++
 include/hw/ppc/xive_regs.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index dc86a7a3be..0e81678ab3 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -742,6 +742,10 @@ void xive_tctx_reset(XiveTCTX *tctx)
     tctx->regs[TM_QW1_OS + TM_LSMFB] = 0xFF;
     tctx->regs[TM_QW1_OS + TM_ACK_CNT] = 0xFF;
     tctx->regs[TM_QW1_OS + TM_AGE] = 0xFF;
+    if (!(xive_presenter_get_config(tctx->xptr) &
+          XIVE_PRESENTER_GEN1_TIMA_OS)) {
+        tctx->regs[TM_QW1_OS + TM_OGEN] = 2;
+    }
 
     /*
      * Initialize PIPR to 0xFF to avoid phantom interrupts when the
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 9d52d464d9..9062c6abf6 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -79,6 +79,7 @@
 #define TM_INC                  0x5  /*  -   +   -   +  */
 #define TM_AGE                  0x6  /*  -   +   -   +  */
 #define TM_PIPR                 0x7  /*  -   +   -   +  */
+#define TM_OGEN                 0xF  /*  -   +   -   -  */ /* P10 only */
 
 #define TM_WORD0                0x0
 #define TM_WORD1                0x4
-- 
2.45.2


