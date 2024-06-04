Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4DFC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQvt-0003j1-Id; Tue, 04 Jun 2024 05:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvr-0003U6-Qo
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvp-0002JR-Vd
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-421338c4c3bso8559625e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495096; x=1718099896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UMNBQrBvKQfv4Dl+hKP/TPgBc1DhyAHhW2w6Yei3CGk=;
 b=qGm3eQ+frIAk25ighZiIiPxdPwjGeOO55nOBu8D/Imyhe5V5uH7XQU0XtAojxRFvGj
 FBNQ+WzE4nlIwLR2TnLm9Ec0FzhMINvwESuGi1U5a3cS4GjSjG6P/Sovl8UD4s8BLx4u
 jOadOL2nLHHlPxCgwqsgz+bhpUAVO1aATwSYqpx9CW4T/080oIEDtw9bSKTXS9U5/cYX
 TEJXHWKbAiTZKhPIWHvewbZFf6Fi4N7NeW6Hq6GUD65MpvU/4Gg8IXbnQ4F2gjRydBb3
 F89UUMKIEuB1N5yJiaDOS3p4VWJESqFIwc3/fsaab+8qCYXfKiT75/OUedlwKoz8K8oT
 iWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495096; x=1718099896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UMNBQrBvKQfv4Dl+hKP/TPgBc1DhyAHhW2w6Yei3CGk=;
 b=oDjxC4BdvwuZ1l7O+kQ+lyozAyO6KdZvh8/fkEppte4O/JBKiaZfFea2GuoN9i+/c/
 IgDwxgBybmmzuakzxZW0OVc6s5ON0goupVMxM8ZtTtaECUoqUcZOVPGU04slj1/DKpkZ
 /LeaSl9k6A5A6RcDGLmkinG65R6EKhpNOSp0bZpK4cWzrXePnXQGtZw39Of2fpUHeQz6
 K617eaDwJlzd2eOVK8F9YJFeEAeRx+IfJKkKovEekFubULw1HyTpTGZxcRyPGP7kN6AJ
 /0z9m7+5fYDDs/5K5jseX0CcleKBvVW5iNjR41vGal4pNYmic/Z07rM2eU2EnjB+hKZ8
 H2GQ==
X-Gm-Message-State: AOJu0YynXb7De9qTTbxHDEgftWTzOxCwPLxkI2EVW1QQGPAGO4CvymFM
 X61a6hfZEZ2wU0IuOWDFpatg0g1qZRWuKMajEGkMPOk7OGQdjZvY/DTMx4qiXZq7RDkflnf2WD6
 r
X-Google-Smtp-Source: AGHT+IHGdggg5ewx0/2n3Lu8hrxRYSTHdGkSS5iyyrnz+QbRSHoncf7/+uzqUAg7gR3BPYSgZQK9OA==
X-Received: by 2002:a05:600c:35d5:b0:419:f3f9:8ed6 with SMTP id
 5b1f17b1804b1-4212e044bffmr110122735e9.4.1717495096202; 
 Tue, 04 Jun 2024 02:58:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42135c9dc18sm112972305e9.1.2024.06.04.02.58.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:58:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>
Subject: [PULL 23/32] hw/xen: Constify XenLegacyDevice::XenDevOps
Date: Tue,  4 Jun 2024 11:55:59 +0200
Message-ID: <20240604095609.12285-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
Message-Id: <20240510104908.76908-3-philmd@linaro.org>
---
 include/hw/xen/xen_pvdev.h  | 2 +-
 hw/xen/xen-legacy-backend.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
index fdf84f47af..0c98444047 100644
--- a/include/hw/xen/xen_pvdev.h
+++ b/include/hw/xen/xen_pvdev.h
@@ -52,7 +52,7 @@ struct XenLegacyDevice {
     xenevtchn_handle   *evtchndev;
     xengnttab_handle   *gnttabdev;
 
-    struct XenDevOps   *ops;
+    const struct XenDevOps *ops;
     QTAILQ_ENTRY(XenLegacyDevice) next;
 };
 
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 6f0b300a42..33620fe42e 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -170,7 +170,7 @@ int xen_be_copy_grant_refs(struct XenLegacyDevice *xendev,
  */
 static struct XenLegacyDevice *xen_be_get_xendev(const char *type, int dom,
                                                  int dev,
-                                                 struct XenDevOps *ops)
+                                                 const struct XenDevOps *ops)
 {
     struct XenLegacyDevice *xendev;
 
-- 
2.41.0


