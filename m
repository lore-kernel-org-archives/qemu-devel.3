Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A0AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8ID-0002VB-39; Thu, 25 Jul 2024 19:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IC-0002SN-C7; Thu, 25 Jul 2024 19:54:40 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8IA-0000YQ-RW; Thu, 25 Jul 2024 19:54:40 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2cd2f89825fso305920a91.1; 
 Thu, 25 Jul 2024 16:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951677; x=1722556477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y3fKxE/JSYFaIUtvkbmpMB5skLlbL3x9sbgOJyDe/wQ=;
 b=Bw8gSt+UWLJcJqmfFhre04Hl5I7u7IvW7eJ6mtpkFmGnh8FjHYkisFWs6BSO3KhLnL
 psM8XAW+LC2L/o0hZciZGW/DbAo5sJ68ci1mOckBMBQU8NIF/cVNVqIRUsYx8D+2Pk+y
 i1NPopvyp9UCgkUgFBh6Nlo8Er5cNtnD0pGWlX5UfF0GRtPMzvi14YIky9nwWYu8OUsq
 0DpECDinr2q7BGogrQSceMyNI3fUXzxr+2SyPycI5FYEnlnCwciNV+xETjg7WGVlqfnn
 5klbGL3LbCNHMse+4OeyjW5FKVhrbInoxafbk1CpJsCMEmIX013MNitBzcXgRdY3Vosz
 17mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951677; x=1722556477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y3fKxE/JSYFaIUtvkbmpMB5skLlbL3x9sbgOJyDe/wQ=;
 b=cky9R9q68Gi4n2mNd0lxfs7Ljm97ECJZm/BmkeKdj/zpL0JEZqb4Ced+vzmMtcJe2g
 iJ3ZUGa3Q7/Mlsn/Z1i2vne3mWv/YoJeMHPa1yiFP9bUx0eaDUQS1iGwtR7IjfyogNdj
 IBRIFwHhT5U888TlkNCjFfcO756YFmis9B0jhdr+MQbOEAFOS8VR6+mW1CgAhDvD0jTV
 YcWpnTuw71lh5BP+HX0X7PEtgL/lmLOvvflgexRrBoIkqE9I0N015NJ63oimPe2FeSD2
 MWMq/oQLLY5zIiEhTtVkHXhYL6ofBQ8dmYjlaqvi2BpxUB+2eeeYoSjQRkqhux5VokKS
 EVHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlBIi2py7AeJ/U06QFxt967yruYpcFxPHgILvzugjsXNj2NMupSRBiTNwnoPtsXYC0gwt0YiTo87Bga9VqXOWyHLK2eYahawUELqr3mSTM611nxof4kocQMaY/
X-Gm-Message-State: AOJu0Yx7fuG3qr+PFG9AXAHwDUHJmerZi0/YUhYzDwC/ZxqLNMjqd7jv
 Ysur5RiykfaU6FYBIqKr4S9XBGEXromfG0MC1PiE4dzRVjKqkuTtOWbHsg==
X-Google-Smtp-Source: AGHT+IEs8m12NMr6jV/THaKEcU/Pwb9g/s946bziTGWVb+9soccl3RgEoHOmU4bB6ImGoyDOs7fI2Q==
X-Received: by 2002:a17:90b:2247:b0:2c9:98bb:b9fb with SMTP id
 98e67ed59e1d1-2cf2e9dce55mr3903136a91.10.1721951671323; 
 Thu, 25 Jul 2024 16:54:31 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:54:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-stable@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/96] spapr: Migrate ail-mode-3 spapr cap
Date: Fri, 26 Jul 2024 09:52:35 +1000
Message-ID: <20240725235410.451624-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
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

This cap did not add the migration code when it was introduced. This
results in migration failure when changing the default using the
command line.

Cc: qemu-stable@nongnu.org
Fixes: ccc5a4c5e10 ("spapr: Add SPAPR_CAP_AIL_MODE_3 for AIL mode 3 support for H_SET_MODE hcall")
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c         | 1 +
 hw/ppc/spapr_caps.c    | 1 +
 include/hw/ppc/spapr.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 98fa3aa6a8..370d7c35d3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2195,6 +2195,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_fwnmi,
         &vmstate_spapr_fwnmi,
         &vmstate_spapr_cap_rpt_invalidate,
+        &vmstate_spapr_cap_ail_mode_3,
         &vmstate_spapr_cap_nested_papr,
         NULL
     }
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 0a15415a1d..2f74923560 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -974,6 +974,7 @@ SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
 SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
 SPAPR_CAP_MIG_STATE(rpt_invalidate, SPAPR_CAP_RPT_INVALIDATE);
+SPAPR_CAP_MIG_STATE(ail_mode_3, SPAPR_CAP_AIL_MODE_3);
 
 void spapr_caps_init(SpaprMachineState *spapr)
 {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 4aaf23d28f..f6de3e9972 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -1004,6 +1004,7 @@ extern const VMStateDescription vmstate_spapr_cap_large_decr;
 extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
 extern const VMStateDescription vmstate_spapr_cap_fwnmi;
 extern const VMStateDescription vmstate_spapr_cap_rpt_invalidate;
+extern const VMStateDescription vmstate_spapr_cap_ail_mode_3;
 extern const VMStateDescription vmstate_spapr_wdt;
 
 static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
-- 
2.45.2


