Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7DFC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8II-0002se-8G; Thu, 25 Jul 2024 19:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IH-0002qE-KZ; Thu, 25 Jul 2024 19:54:45 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IG-0000Yq-3d; Thu, 25 Jul 2024 19:54:45 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cd34c8c588so277117a91.0; 
 Thu, 25 Jul 2024 16:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951682; x=1722556482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4zNsjcWJq28+WrSLK5/Hy2TlcS4xaCyv6HCQHTDD64=;
 b=bjh6eDMYIvHMT/rJzcEvHmHKTE9RSo3rWvw4SuZwDR6pUhpyiNN1DNBVE1y3Diu9uh
 vekqYIAvHk2BoNS2/dWmVwZBSmVlHuzS+K4OVI+Oj1fZTaFG0S6TyZTj4Tg06bAihhNx
 wASN3DoCCPV+hly1XjNif0RPEWjcf+q/Ivr7IGgg5lYDZn0gsgvMc9oUuuKeLNbjHPnz
 6yc3rHb97jkuooisy31yIsyVm1GOyivKWE9UyGBupRtULbsfkqMmQycibKVEXIKgJBii
 9h/HFK4OPM5pKNivBd47Md0hF5lEHU05Xa6RBh8ASrKdLE+vtaCu5sl6rwCe+BWXX+XS
 6IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951682; x=1722556482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4zNsjcWJq28+WrSLK5/Hy2TlcS4xaCyv6HCQHTDD64=;
 b=UL3ClgLuVFTvmv7BAD8FypZ04v/8UrCo2RYqipmgCAwvKPy7SK9jBRdK1ZbehUdkNM
 Rreyv6GWiDm2a8BRHp4K0RBLD2EgRihk0F9MAZJwks000CthbCsUsZaolH4h0iIcl84z
 RWJhqkgnB2WTCxVPzW20o39j9xX5x20U2sTa835/NIglIlfeBwFVAOTVQy39BwWaoBgv
 D6C2hVPjdSzp5XmSGlTV9QgGsR25GvvNEDF0QsOhgwIQUDM4R/WdFErH/cAxdByaNI/0
 e+o1mzVOZHzs0lcKubVLCHwW2mIyCffccAKoMD3+jyoxQytIhlCvDY4QgbrVKt/3P46t
 4BeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViZYqwyFiD2sDeUrzpBLK9gtiPDa3GeviBdSk2d7Se4FMRP4NvgnVfbGhH1Z3s4mnjKxP/MKeDgZNJkY6vT33AXgkG
X-Gm-Message-State: AOJu0YzVLo1SyO0eZu8M+RXXgwOTY2SneDyByWEM4Y9/WoS98p4biEOj
 lGpBTWYx92HCqgh6OKc4DykYo+cVi4jAiQwBHU+L1o33kw9ke9Raka5r6Q==
X-Google-Smtp-Source: AGHT+IF7eK5GD0wdXLm4pX5ZLHUOkhHhe4YFO1odfOi++RV7EtdAYGAzycgIeMsNLLZmRcnyQbul+A==
X-Received: by 2002:a17:90b:4acf:b0:2c8:6793:456 with SMTP id
 98e67ed59e1d1-2cf2e5abd38mr3895696a91.0.1721951681972; 
 Thu, 25 Jul 2024 16:54:41 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:54:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 03/96] spapr: Free stdout path
Date: Fri, 26 Jul 2024 09:52:36 +1000
Message-ID: <20240725235410.451624-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This fixes LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_vof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_vof.c b/hw/ppc/spapr_vof.c
index 09f29be0b9..c02eaacfed 100644
--- a/hw/ppc/spapr_vof.c
+++ b/hw/ppc/spapr_vof.c
@@ -28,7 +28,7 @@ target_ulong spapr_h_vof_client(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
 void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt)
 {
-    char *stdout_path = spapr_vio_stdout_path(spapr->vio_bus);
+    g_autofree char *stdout_path = spapr_vio_stdout_path(spapr->vio_bus);
 
     vof_build_dt(fdt, spapr->vof);
 
-- 
2.45.2


