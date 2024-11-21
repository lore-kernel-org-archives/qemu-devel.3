Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0D5E6400B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECkx-0006Ot-Hk; Thu, 21 Nov 2024 14:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECks-0006LH-F6
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkq-0002Wh-ML
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kkrNtEOYB9vQPtXuGEIbWtqzeqn9cY991precDyec5c=;
 b=AxTBonpeMb8bgS7hKbeQadlUpR2Yx+OjL6lT9Nj3WOHRo7a0226zYUJjydd+cQBa5eYoCX
 c2YbkUeMnfRdkKXX4Zg4lXrk4umPF1BqwoHSablDz8ynrXkJJIR5rTmTe38q8Cdq25Otc7
 n0XaJTxwqUCdV5XE1iPPcFd3Fox57XQ=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-pzMR_R0IMcqpwjzS2prpTw-1; Thu, 21 Nov 2024 14:22:14 -0500
X-MC-Unique: pzMR_R0IMcqpwjzS2prpTw-1
X-Mimecast-MFC-AGG-ID: pzMR_R0IMcqpwjzS2prpTw
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-83ab434c629so136219339f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216933; x=1732821733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkrNtEOYB9vQPtXuGEIbWtqzeqn9cY991precDyec5c=;
 b=rJNHwpla9lgdfun5v4MdKU1QODoapnmNsxsGEnl/m1A0Hy9iR6u2YU/tD5HTUt76t3
 U8VnkJh/QdAUQjKReuJC20tqSW/NspOv/op4ZqO1J8RcvrwzLd2UawqZ9M0St0GJGN41
 Dt8EBxoulP/coGuuXnygBUTzHXbCphbueQrmZK4CC+HjWzPh9qROYK5CHaNXp4sbLVXi
 TMhAxMdAhWBmwThJdK1r03A7t7wpBwv90190D7ZzyFFq3gesnpriAqTXMElmZEE/OoE1
 K9tkG1iBMH+oQDMNy2cj7tE78DATy8NMGHCt8pUQny4gRHVHEKxkPMaYXfXojcHIpQC4
 YKgw==
X-Gm-Message-State: AOJu0YxxwzqdZWX0hPQ+sTbjts5sMPYMTsYjGTQ8AA4rgjp0SxwbDoMX
 t48UVbTUxUUEdD7RnH6dMAruIIsRDAEw0knC6ni2pTB+EJYiP8Qj/Kqv9vUOzZ/IMt4oSJ+o6Jx
 esj+2vdtzNBanA5iML0sH/Vv134m8RJWdJ746HywJNapTscYl+TiLQg5Zhl0cHoCfPlJ4B/IPRy
 oOSco0kEfK5gvmRnGz9MkA9FswHLeIXfyI6A==
X-Gm-Gg: ASbGncv4t9joMeCSwN5KUbWU3vVXS/dgoQFhCh1KUupV2gl7TI+hkuMdXALAZNn7ZZH
 ucYAFwrMHk/EdxYxy4gnsBDp5lVxrxK0L+UW7v5F6g3qKvSg/Ps2Hhk2KayKfl5/J5r8LUG3OCF
 rk0fXcNNPjm1lFkjZ9UV9dEmptvY2+5AQI4Z5fuiwPKKKU94CTRyHAIioDgrBtNqyvQUXq7iy9S
 5HxnIVbPUNzMIPFVEa+QRyELKo79ykUQFad1cEB/3xD3fGf/96KPRdCLi9TB/zixNBHZiBzLYtm
 c+c2a6scDzHx1uJuJ/WDf+5P6A==
X-Received: by 2002:a05:6602:3c6:b0:83b:47:8d5 with SMTP id
 ca18e2360f4ac-83ecdc538d9mr11787039f.3.1732216933385; 
 Thu, 21 Nov 2024 11:22:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjMykOUz9PAzhQC1OwN48Ig7nFDis8CFFPoMKffuWBhPNdlUn4KwZScK+t0ejysBafrnKkXQ==
X-Received: by 2002:a05:6602:3c6:b0:83b:47:8d5 with SMTP id
 ca18e2360f4ac-83ecdc538d9mr11783739f.3.1732216932957; 
 Thu, 21 Nov 2024 11:22:12 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:12 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Bharat Bhushan <r65777@freescale.com>, qemu-ppc@nongnu.org
Subject: [PATCH v2 05/13] ppc/e500: Avoid abuse of container_get()
Date: Thu, 21 Nov 2024 14:21:54 -0500
Message-ID: <20241121192202.4155849-6-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241121192202.4155849-1-peterx@redhat.com>
References: <20241121192202.4155849-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

container_get() is going to become strict on not allowing to return a
non-container.

Switch the e500 user to use object_resolve_path_component() explicitly.

Cc: Bharat Bhushan <r65777@freescale.com>
Cc: qemu-ppc@nongnu.org
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/pci-host/ppce500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index b70631045a..65233b9e3f 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -418,8 +418,8 @@ static const VMStateDescription vmstate_ppce500_pci = {
 static void e500_pcihost_bridge_realize(PCIDevice *d, Error **errp)
 {
     PPCE500PCIBridgeState *b = PPC_E500_PCI_BRIDGE(d);
-    PPCE500CCSRState *ccsr = CCSR(container_get(qdev_get_machine(),
-                                  "/e500-ccsr"));
+    PPCE500CCSRState *ccsr = CCSR(
+        object_resolve_path_component(qdev_get_machine(), "e500-ccsr"));
 
     memory_region_init_alias(&b->bar0, OBJECT(ccsr), "e500-pci-bar0", &ccsr->ccsr_space,
                              0, int128_get64(ccsr->ccsr_space.size));
-- 
2.45.0


