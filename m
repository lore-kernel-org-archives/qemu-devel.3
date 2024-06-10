Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF62C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 18:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjgH-0000X7-Bx; Mon, 10 Jun 2024 14:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGjgE-0000Vl-Fs
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:23:42 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGjgC-0006EM-3t
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:23:42 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2e724bc466fso2684351fa.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 11:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718043818; x=1718648618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySCgik+LBiFClMJnnOBIpi9kKmck863oPvAUWXJIWbk=;
 b=Ep+B+E65wi2cHhlIMbmuMKBws9f/jh1j1hLe3TaJlgQ+3Ap1S52x4Esea72pDNPxfU
 g2klUXfDX5MepZKbAPSwIJvlJ7ARBTd5zdkndD6bpIm2UUT5cFlL6zgfe3vDstJeBck1
 rTtTuy7PmtT+I78ODxbBUOOWFzkRRvGoXC31tu5RY4UtjrqVSDWltge6oEfopREZuX45
 5CXTq/BF17xTX/V6mrI0a5xlzU3eU49zt1d4/LVZGD4krUqlZ2liMDK1tQodkUdw0qvS
 Xxj4q9SfDycGzK5v4P6YMH+2MHMk8kUlVtPzPcd89hyGgNVA8A3EVUp8ydClEdySqo7U
 ATPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718043818; x=1718648618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ySCgik+LBiFClMJnnOBIpi9kKmck863oPvAUWXJIWbk=;
 b=h3HvIxNs4J8mAGd+7nZUWDzzJSq/1zTASqlikADt8qWHGRFT4w///6pmZqR9KGY8WG
 YON+6rlfxy1uQ0DdrVURhcgc83/Fqcf2vTL5N/1NEtE4ev2t6mFkBMNTuoWSlavr+NDs
 ELV3ntoP6+L/rw3LPRZuYrrve1nnEPLps4cJs2bPgTopdNJQVlQaoqAWvUPG173FrLbf
 KdEzd89PgGbsRbbwTjislPkrSbxla6BUvS2kSoZk6Zz5jeBQA2cqpaETrGSedICuCdY5
 BGU17QLl8Vkkdkwlpq2W0j0jHKqHFFWweqc98IMVX/e+w096LPdE5NQ+W9XlDsb+hBxT
 +jzA==
X-Gm-Message-State: AOJu0Yy5yRfG1L8UC0pqUSu6RWmHlNMrTuQBSgM/mcgoHL+Y4Ev1kPVq
 zwaDkV38ui99vsgx2Y3bWmGHUlkqaCfb5d+FBh7GA4N0a5k2MACKXNsD4dBKlqHfJ6cFc3ve1Tw
 BV/U=
X-Google-Smtp-Source: AGHT+IFNBKuk/z+DZg4RS8PmG4cxfZZONBe7Kf+ler9pThCBIX0O/h3fUNcPgeTtowcw5JRg5I80aw==
X-Received: by 2002:a05:651c:1031:b0:2ea:e592:5bfc with SMTP id
 38308e7fff4ca-2eae5925cccmr63519711fa.42.1718043817958; 
 Mon, 10 Jun 2024 11:23:37 -0700 (PDT)
Received: from localhost.localdomain (adsl-33.37.6.162.tellas.gr.
 [37.6.162.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42161147811sm135487395e9.18.2024.06.10.11.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 11:23:37 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org
Subject: [RFC PATCH v1 4/6] DO NOT MERGE: replace TYPE_PL011 with x-pl011-rust
 in arm virt machine
Date: Mon, 10 Jun 2024 21:22:39 +0300
Message-ID: <cf690592ff727cc18e4c9b49827f7b8268fb515f.1718040303.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3c93c0c0a6..153be0f42d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -912,7 +912,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     int irq = vms->irqmap[uart];
     const char compat[] = "arm,pl011\0arm,primecell";
     const char clocknames[] = "uartclk\0apb_pclk";
-    DeviceState *dev = qdev_new(TYPE_PL011);
+    DeviceState *dev = qdev_new("x-pl011-rust");
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     MachineState *ms = MACHINE(vms);
 
-- 
γαῖα πυρί μιχθήτω


