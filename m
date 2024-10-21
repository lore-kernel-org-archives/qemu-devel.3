Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A12D0E6C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 07:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2n1c-0005Wq-Um; Mon, 21 Oct 2024 03:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t2n1O-0005VI-PI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:40:10 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t2n1M-0007Ia-Ik
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:40:10 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539e8607c2aso4324291e87.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729496402; x=1730101202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ut6tdXFoieCwDzjCk3rSVYe/V5H9QVhV/RCoAHnEImI=;
 b=iW3GQep4V8Ov0ny7TNe75RvegPFArq5KGy0oU6G4eLhCO2eBEvI5mKxRG28MQ5Eu1e
 PIzC5P6QH0xqdBkQSG+One20GqldJoZ90LUnDy7ME05FecVj62Sldv4NCtWE7JSERBAf
 6MntwacXThA5Pv36GOq1A+ZkXaHd0oYodwV8J5+Pffhg6+jRM9kqfpJQYCc3/2pNUhlO
 pXgECMeKEjDBqTc12IFTeDF98szI5qSMMgbJ3jzuM0GZOAPGaAuQfJcpqxuno4YF4sa4
 RuXS7nlVu8iBex7uli70zcCccOJZfv3uX0u9uEn8lBmSJalnHhkTNGK08nEKXvVxSl2e
 Qm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729496402; x=1730101202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ut6tdXFoieCwDzjCk3rSVYe/V5H9QVhV/RCoAHnEImI=;
 b=HdCM1NBpPesXkv39Wj/VeLocuMleLfas+lwNfKjde7PklBJdDOvCtPWmgsRgTnOKgS
 SZ/nYMUsLYHLHBJpNeuqoFB7XdAPQM7RCM7ya63mSGdeifAN6yS5drEt1i3fGHygQUIL
 Hd4qwLqdbcja9JVMp5vEt8c5ae/PiF2ORGErcTFgozbMiAZ+vJ5paemNwCkYiPCDKV/k
 k68MrUuhw1KyNdSG1vumXeu9eeGNBRDPMQ8SI+ejEX/1dkkTgsilSescAkrSLpClASCn
 HNXQKqHAsqjI3s9Zymb6o7khbnTutt3BhPMbfZwMlVACRVaFtVwWs1UEXVEPxoqvCDrt
 izpg==
X-Gm-Message-State: AOJu0YwRfyoaoM27eYZro4LNOf98v5ftLEaEq3Op2ke228pm2b7Vqjzp
 XZdGtFmEQYUwpbrjgNV4lK0KMA9VOS7sWdzl6JlRyE/35U1ugdz44W0WX7hE
X-Google-Smtp-Source: AGHT+IHQciL+iTlfAU599XwSCdWoMZD5RsI/tADgn8OXsviefzQLziznjymiXZ5JCWF6gR0gAzu4Hg==
X-Received: by 2002:a05:6512:3a95:b0:539:ee0d:2bb4 with SMTP id
 2adb3069b0e04-53a154b2cb6mr5122358e87.45.1729496402045; 
 Mon, 21 Oct 2024 00:40:02 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53a22456503sm411931e87.306.2024.10.21.00.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 00:40:00 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL v1 1/1] hw/xen: Avoid use of uninitialized bufioreq_evtchn
Date: Mon, 21 Oct 2024 09:39:57 +0200
Message-ID: <20241021073957.1851500-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021073957.1851500-1-edgar.iglesias@gmail.com>
References: <20241021073957.1851500-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x130.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Avoid use of uninitialized bufioreq_evtchn. It should only
be used if buffered IOREQs are enabled.

Resolves: Coverity CID 1563383
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-hvm-common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 7d2b72853b..7ffbbfea23 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -752,9 +752,10 @@ static int xen_map_ioreq_server(XenIOState *state)
         return -1;
     }
 
-    trace_xen_map_ioreq_server_buffered_io_evtchn(bufioreq_evtchn);
-
-    state->bufioreq_remote_port = bufioreq_evtchn;
+    if (state->has_bufioreq) {
+        trace_xen_map_ioreq_server_buffered_io_evtchn(bufioreq_evtchn);
+        state->bufioreq_remote_port = bufioreq_evtchn;
+    }
 
     return 0;
 }
-- 
2.43.0


