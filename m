Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C71C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 05:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSsiW-0003I5-0m; Thu, 25 Jan 2024 00:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsiT-0003HG-L9
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:55:57 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSsiS-00016q-3I
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 00:55:57 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40eb033c1b0so44445895e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 21:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706162153; x=1706766953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gkow43WWl5V6H8QLUuDhGBGmx/UArXnxCzhocw6DFQw=;
 b=MSXfe48SzhIzxgIUwQuWi1PlbtR4vLrLSb5TL45jPhm1AZ4ruhZ9UexPQmPgu+W03s
 MB4fxp+ZNe2DxfK62LkxQmdtERTeaxJPc25c8wf4u8avuxT4gccBN3KmMriXuDa0Gs9v
 VsU2RXu7mD7mmoDrTDMArdSzFGnCpDXAPniDHSfcpUt4LvWGz4/OO4XTtAQMSXc45TQh
 TenmjMeXXDqNlyqMKC1xiC2jxecWQj5HeLzyCJ8ivdqCRiBL0UM3PoiGtMTC/iSh+1dR
 2JshvHTADl+cJlwSzeEdmxU/RY8duAlv2IzydHy3BsduM3HogecxKH8dJIf6fqLJXQq3
 pz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706162153; x=1706766953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gkow43WWl5V6H8QLUuDhGBGmx/UArXnxCzhocw6DFQw=;
 b=buBS0cj2/yzbxNVIPUbyNOQUBDBOlpFXwdlQR5q8vMBb6I4HhQ+o8cBK6hWdo5B9v0
 pfXoThTFtQ/bFHHnrSGkorhJ0/OjdXvZfpu9NP7gPlgyiqEr79guN3DguZ9QLG7RbzgG
 HfNTD2r5+XajCqJjMe7daAb2L4WvPIuPPMCCHXWdgRciAkr9LUPp7bnwJ6wvMC/u1L80
 EJ3FDtar0uUkRfSEuw+ZZK5oZFtIOjjDtNgPRZE3a+TIL1Vpj1N6a/1xs1DUYLrAuXil
 FUG5IWTe8K1nUY93C5enGIzAP3QlxuJsn2Xgyj/Nli97E0JaQ5IVUXaJPDkytSy+J2Ng
 6JpA==
X-Gm-Message-State: AOJu0Ywf0aH3Ji37XXaKbn1bflhg24BaVyonzMyU0EfKZcWhwn/zOun6
 cDhlssyVli3E/xX7eTopSF3SKBkayJje76ysc6VPbxzazZ3l07il9zuxU4rkdTJtALQNq95RVhk
 K
X-Google-Smtp-Source: AGHT+IFe5t/MdXZXHR+Of8UGTWKbVarNAppkn/KAXXOoHLEafoCVOZvGvhP2Alb+8hZHsfbsIC7O9g==
X-Received: by 2002:a05:600c:34ce:b0:40e:5bb8:7fb1 with SMTP id
 d14-20020a05600c34ce00b0040e5bb87fb1mr175548wmq.47.1706162153220; 
 Wed, 24 Jan 2024 21:55:53 -0800 (PST)
Received: from m1x-phil.lan (lec62-h02-176-184-19-125.dsl.sta.abo.bbox.fr.
 [176.184.19.125]) by smtp.gmail.com with ESMTPSA id
 he7-20020a05600c540700b0040ead97f70dsm1228336wmb.24.2024.01.24.21.55.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jan 2024 21:55:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>
Subject: [PATCH v3 1/5] hw/arm/aspeed: Remove dead code
Date: Thu, 25 Jan 2024 06:55:40 +0100
Message-ID: <20240125055544.79405-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125055544.79405-1-philmd@linaro.org>
References: <20240125055544.79405-1-philmd@linaro.org>
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

Remove copy/paste typo from commit 6c323aba40 ("hw/arm/aspeed:
Adding new machine Tiogapass in QEMU").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
---
 hw/arm/aspeed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index cc59176563..4bc292ff84 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1301,7 +1301,6 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size       = 1 * GiB;
     mc->default_cpus = mc->min_cpus = mc->max_cpus =
         aspeed_soc_num_cpus(amc->soc_name);
-        aspeed_soc_num_cpus(amc->soc_name);
 };
 
 static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
-- 
2.41.0


