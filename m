Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97D5CED242
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxv6Z-0008FP-P4; Mon, 07 Oct 2024 17:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sxv65-0007td-90
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:16:53 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sxv63-00011d-Qm
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:16:53 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53995380bb3so5905934e87.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728335809; x=1728940609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOZFp0KYwy2xarbmigXeGI5Kh1b1KEGSJbQb+7v41UY=;
 b=gQAzmsg9g7LZDrkrbd2hE6BiC1GJj1HOt87LQMUrMh5eKb0o/KMA4PKIIdkfSfYqCn
 +gqnnpou39Rkvn/Ow4C/O5o5iUkZhTGrA1Tdxe+l6kVZcD3Ghiv5xaTOX++BAlcAOvAU
 goj4xxwgWLNtJgV6vgz8ETzd+E1i7x6z3K3x3OCrDIMRQdCuI2+mS5UulEsc4ea35N2O
 E/UPD0mpviWDk3v8sOYh5zyYlJ0cqu05oxcsVzhgRfLlrtRhaYAeiwtg1VeVDgIRbQyU
 SktJMv+SG5mhJH0R1EvetHLUEm/s3GB/x1+54FWGDNuxYyU1y0u/Uf7Uul4xCdNYfler
 VzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728335809; x=1728940609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nOZFp0KYwy2xarbmigXeGI5Kh1b1KEGSJbQb+7v41UY=;
 b=R99oIoMZYMP4dyLgCphRxq/ySQPem2VC1Tq3qT9HRPNzex0/y3ksnNSLvVKeM1CoUT
 avUef8Zvylk0Qe96Zl8dAeIsDhJv3OaMtoVTgVKXFt5eOQ8SrFh9cruNwuoYXRPv86Mn
 4ek69R4WwCLi8fHchfiyY9KNSSIkb1KGmiGWxTolcphbPY+6V7Q+VjhK5snD7l+HJMLJ
 TW+hh3GP/1bWEvugrz6xB9pq3YEnjKXDYy6X+8hFTHr33h3GfvoxuG9uPEL2WKgTVPAh
 /E84Jdo5LSlTh386a8rzTE6tgWSRhmzoksyhsQgm2N4MwTch+ZvMchul0MY8wmwp/b4a
 ibFA==
X-Gm-Message-State: AOJu0YzC38bu7Tj3jUMdpsGMKL3IwCcCRaaq1dVaDXtoze6yYR/9ygPc
 8OqOpvlFbh3OS0apZb/5uWGk+PUo1MBcv+0n8wXSaiKFSgj9UgQLbr9/2Ith
X-Google-Smtp-Source: AGHT+IEDn3064h8cU2IDaRl8of4yOaXKWQsj91WD4UsSn5HTEcpmp2TwGmNka3Rpk/B+XuSHazDZAQ==
X-Received: by 2002:a05:6512:304b:b0:539:93b2:1383 with SMTP id
 2adb3069b0e04-539ab9e1738mr6600333e87.46.1728335808875; 
 Mon, 07 Oct 2024 14:16:48 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539aff1d214sm945051e87.132.2024.10.07.14.16.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 14:16:47 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v1 1/1] hw/xen: Avoid use of uninitialized bufioreq_evtchn
Date: Mon,  7 Oct 2024 23:16:42 +0200
Message-ID: <20241007211643.1572271-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007211643.1572271-1-edgar.iglesias@gmail.com>
References: <20241007211643.1572271-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12b.google.com
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


