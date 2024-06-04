Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF86C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQvy-0004nK-Sc; Tue, 04 Jun 2024 05:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvx-0004aC-9o
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvv-0002Jk-G5
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:24 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-421392b8156so8492835e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495101; x=1718099901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWEiLSLjPrxtWwEuDW5HmfeuH1N7C8mHb/ZvIjGfjz4=;
 b=Lzrg3/QZ7NNp6WK00x5y/n2tK8OOCalAoxhHZGkVV5p0bkXwKx2DORImveSx2h4z2I
 3MAvFKogOfA9AHNBUT3VV63t9A1D54RYTGe9emSHM3xInHIhpo+xpcbUZEkCZVDy4UOe
 WqGSm+HeGvTJGkSgkRrfPrUD55i2jmZFj0MACwsjpteNFniLj1/15dNGhzTrlvfOzEhx
 /hWCQ1wM4vtTEmixxpCRNnDYR5yymI24omoe7z09zyL/uuES4qcTiJ/ByeHbZZ4QUiXg
 SW2mXAiIX9u/wBBd6hODw2pv2f5YjuwghdvK9NPe+4jcQpqZwRl97t5KSleYb75XIB6C
 Enaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495101; x=1718099901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWEiLSLjPrxtWwEuDW5HmfeuH1N7C8mHb/ZvIjGfjz4=;
 b=cOlsV36jdqr++7ift2uypVD7RqHcCP3aBiIDDVkcx57+W6vhhMTa36LdohqrTpG4U4
 qdNhiP3ZOzwIJukLY1VEJgLjWs6GAjizbue3LN7E9BqSnGIjU+oCk7WJPEbKLzOJC8Lu
 pSjm27ylcyMG1Fg861DSOkaPaYbADOZhICgMIXvJNSlGXZ4jlbjf70p0J/gKGXejf2K6
 keu4Eu6mnaf0I0mLXM+PT2Wlk1iDToAptWYaOOhDgGcVkFzePjB7sgmvTTFTA/upN9CD
 uhbY5Mhy18gMLUa12s1+FzWv5bDpjMxXIJ0bI4LEOdcNA0+7x4sj4ywhBM1WmJyqtzQd
 DCLA==
X-Gm-Message-State: AOJu0YxNPwzDkMnBYNe/4TQMiDauombdzv5Xc42L13SwvKkwRFl8woD2
 7alOFyKaupbrHC4P0zdcTxoFR/bSUwmvNZtFi6s75DDDjbtyp17tQ0bZXRXK5Z7PBInjWjdOmFo
 T
X-Google-Smtp-Source: AGHT+IF4t3Ptbt+sQoQi7/KPrImQE6KI2L2BTH13Sordg4RJXSyTY5Whek96aSR7UiPNBQn/BhIXcg==
X-Received: by 2002:a05:600c:3b0d:b0:41b:fc3a:f1ef with SMTP id
 5b1f17b1804b1-4212e0b08f7mr98344425e9.33.1717495101344; 
 Tue, 04 Jun 2024 02:58:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b83d469sm147380125e9.9.2024.06.04.02.58.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:58:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>
Subject: [PULL 24/32] hw/xen: Constify xenstore_be::XenDevOps
Date: Tue,  4 Jun 2024 11:56:00 +0200
Message-ID: <20240604095609.12285-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

XenDevOps @ops is not updated, mark it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20240510104908.76908-4-philmd@linaro.org>
---
 include/hw/xen/xen-legacy-backend.h | 2 +-
 hw/xen/xen-legacy-backend.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index 979c4ea04c..62623ecb30 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -40,7 +40,7 @@ void xen_be_check_state(struct XenLegacyDevice *xendev);
 
 /* xen backend driver bits */
 void xen_be_init(void);
-int xen_be_register(const char *type, struct XenDevOps *ops);
+int xen_be_register(const char *type, const struct XenDevOps *ops);
 int xen_be_set_state(struct XenLegacyDevice *xendev, enum xenbus_state state);
 int xen_be_bind_evtchn(struct XenLegacyDevice *xendev);
 void xen_be_set_max_grant_refs(struct XenLegacyDevice *xendev,
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 33620fe42e..5514184f9c 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -520,7 +520,7 @@ void xen_be_check_state(struct XenLegacyDevice *xendev)
 struct xenstore_be {
     const char *type;
     int dom;
-    struct XenDevOps *ops;
+    const struct XenDevOps *ops;
 };
 
 static void xenstore_update_be(void *opaque, const char *watch)
@@ -557,7 +557,7 @@ static void xenstore_update_be(void *opaque, const char *watch)
     }
 }
 
-static int xenstore_scan(const char *type, int dom, struct XenDevOps *ops)
+static int xenstore_scan(const char *type, int dom, const struct XenDevOps *ops)
 {
     struct XenLegacyDevice *xendev;
     char path[XEN_BUFSIZE];
@@ -624,7 +624,7 @@ void xen_be_init(void)
     xen_set_dynamic_sysbus();
 }
 
-int xen_be_register(const char *type, struct XenDevOps *ops)
+int xen_be_register(const char *type, const struct XenDevOps *ops)
 {
     char path[50];
 
-- 
2.41.0


