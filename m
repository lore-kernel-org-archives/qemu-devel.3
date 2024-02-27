Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8A6C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ret2Y-0002z7-2G; Tue, 27 Feb 2024 03:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2V-0002br-7q
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:15 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ret2E-0008HF-O3
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:42:14 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5640fef9fa6so5196965a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709023317; x=1709628117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Yy5kHw7b+fXUkeiiZUfupvxhJnRIRkwmG0B4GAOIY0=;
 b=GonaCAdQfNf93rro4lzApaXfoma/f/Yw5A4oyNEFDtWcKpAYkgK1ZINyAygZOSLhAZ
 plj/dBbovFwz6yN1BDVm8Hh7FmWkXSnOVa1g4De5RvDF4Ocbr1y/EQRUfb5sy6qchCoS
 isQTtEVGygvvkgH983UOdTCFuUdVK9F02tJYJWBlYCdxv3xIfsgIx3oNqJoozeCRKSWF
 K6We8GpnFciPV4N7tvgCxoOmkQ8lvSF7AwHQZvFIos8EPWbfdCK2fqfZfLUNwb++/fPa
 2buf+JyDtK9LgLciI6WRWO389/16lYDGGntEnGQUFrfU/s90vrdd1UpMXExTPAoW4m5E
 ck3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709023317; x=1709628117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Yy5kHw7b+fXUkeiiZUfupvxhJnRIRkwmG0B4GAOIY0=;
 b=HjeuYAYo0BkirMLgrplC/MPSTRi3WPtNWZcLFus1DhwNVcrUXEC1Bq2sinDbSHkPv8
 U/kjYqY8iG187RV+ANn4SD7LmH/oOTZCH+nNDFOu44NNDKLi8tXv4qfWSIRiHYUnNH6U
 MlUXPPPMxFC1pwuUJ5B7GWITr933RL+54HD8tFB55Ki7Jixh6FLUaPm5I4Ig/aGzMfLn
 0GSJQLkJHCU9CQn/juj5Y7KsKlEMGCTGYd5gxuvLtSlixNi1NY+kalgLDHmwnCFBz4u0
 MUpepTUU5pgayrc1BqaNtzXSsQH3ILO+CW9UyJIDZn5sspvC0I6LOvGpN+fqjHYirxFP
 jFzg==
X-Gm-Message-State: AOJu0YwjninTE4/hEU1cY0d5i2qjFLBOYBW3ZX+8zTUPslh674ZpRzJZ
 jBJMnv4mlByeKnsoFeO8YI7N0P42tiE2D9StgsQ8q8Y1JxOYqLv+UDtryC+4e8a4G2DyK+6TCi/
 6
X-Google-Smtp-Source: AGHT+IHHc8tKw27KX8go56zhStviVqM7V4J8HDd3+0hvKaXP5YUBIaBeMMaEzZLMBiaFlruDU2OX4w==
X-Received: by 2002:a05:6402:b14:b0:565:63d6:40d7 with SMTP id
 bm20-20020a0564020b1400b0056563d640d7mr7121911edb.5.1709023316976; 
 Tue, 27 Feb 2024 00:41:56 -0800 (PST)
Received: from m1x-phil.lan (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 u11-20020aa7db8b000000b005653f390f77sm541381edt.10.2024.02.27.00.41.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Feb 2024 00:41:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Kevin Wolf <kwolf@redhat.com>,
 Minwoo Im <minwoo.im@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Subject: [PULL 20/30] hw/nvme: fix invalid endian conversion
Date: Tue, 27 Feb 2024 09:39:36 +0100
Message-ID: <20240227083948.5427-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240227083948.5427-1-philmd@linaro.org>
References: <20240227083948.5427-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

numcntl is one byte and so is max_vfs. Using cpu_to_le16 on big endian
hosts results in numcntl being set to 0.

Fix by dropping the endian conversion.

Fixes: 99f48ae7ae ("hw/nvme: Add support for Secondary Controller List")
Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
Message-ID: <20240222-fix-sriov-numcntl-v1-1-d60bea5e72d0@samsung.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e..76fe039704 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7924,7 +7924,7 @@ static void nvme_init_state(NvmeCtrl *n)
     n->aer_reqs = g_new0(NvmeRequest *, n->params.aerl + 1);
     QTAILQ_INIT(&n->aer_queue);
 
-    list->numcntl = cpu_to_le16(max_vfs);
+    list->numcntl = max_vfs;
     for (i = 0; i < max_vfs; i++) {
         sctrl = &list->sec[i];
         sctrl->pcid = cpu_to_le16(n->cntlid);
-- 
2.41.0


