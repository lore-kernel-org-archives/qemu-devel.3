Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFFED60CE7
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 22:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDA0J-0002dS-6o; Mon, 18 Nov 2024 17:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDA08-0002ak-42
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 17:13:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDA06-0006aL-Qv
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 17:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731968021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2EHmLep7AvvNAIAY6Sg1hRRUPZ6LsfZnIsPCnbrbppo=;
 b=FeEa4n4cyIoLTlhVZMm+uGBHtv95Szn1yjD0FH6O6ZZDMbewhTmgPIZM7WiMHafPmXicdO
 NltOUNW7SaHe3er4fNB2ac8lcAyzo4Wq4SYFMA48qd0mLlnzcoQPfX1rXX0cniSA0pqiq3
 QHpiKXS0nCOrFiEVSUIT19ixSxbct/Q=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-YqvWvPcaMYGmrd26rwB2Pw-1; Mon, 18 Nov 2024 17:13:38 -0500
X-MC-Unique: YqvWvPcaMYGmrd26rwB2Pw-1
X-Mimecast-MFC-AGG-ID: YqvWvPcaMYGmrd26rwB2Pw
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83aac7e7fd7so35179039f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 14:13:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731968017; x=1732572817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EHmLep7AvvNAIAY6Sg1hRRUPZ6LsfZnIsPCnbrbppo=;
 b=XYLiqSaXpUvdhOEfqIZrFfQnc+ju5hxJra2wyInHeqSp8VPY5pp9+yv/LBoBkb8UNZ
 vP2nfD8SkBQNTbIWLIChBDUhrBhxxx9AUMyD4MG+vcHuDzyS0IzpFSyU52MWDW1bTg4S
 F/t1L8GvZLwDzHWdFHHe0EHkhQ0oHEOCWolRMP/7TOC6TmKCCfK/y7SMZeB7V7v7n4zr
 rlR/175cqw/ypdRRASDMwdNujg5Z74HYvxkEL1zfTclEZ8Z7hBjzo6FV3vyyBIRXHzR4
 zsSRJWHrDWOMrsr8IUsrHEM/2RIdmXbUz77ZufsooZNvY/MrmY9Q+ybtYvl83mVCr6by
 OqAA==
X-Gm-Message-State: AOJu0Yy0goDCkG9I28dufIiP/pha1ncRijjJuzTiWag/l4vBbxs+n1+B
 mJL+JeFpcrbj23Ji8pJk4PqAOgq2AiE0ctM8Eknvig8X9KhICnuVVg0CHCTOe84rLWP933Nfmx+
 F00KngwlxA1kRiBOtn+UE5ZrzIKm0vmtfxUPgmJ7nKV9Re6LxywO7dtKmp1AbVSARlP5xZRPyWG
 ohi52puxbU9d1UW9pSaLrqZqTucB05YnUbNQ==
X-Received: by 2002:a05:6602:1614:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-83e6c315b31mr1564262139f.14.1731968016941; 
 Mon, 18 Nov 2024 14:13:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERO8LOitZwbeG1gxaBWkXVlM5XNlNIDQQQlXAdQAhUOCkwaoHaHeYqeMVK80KGuSFvCKB+Gw==
X-Received: by 2002:a05:6602:1614:b0:83a:7a19:1de0 with SMTP id
 ca18e2360f4ac-83e6c315b31mr1564258939f.14.1731968016637; 
 Mon, 18 Nov 2024 14:13:36 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d6e7fd9sm2298599173.9.2024.11.18.14.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 14:13:36 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bharat Bhushan <r65777@freescale.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH 2/5] ppc/e500: Avoid abuse of container_get()
Date: Mon, 18 Nov 2024 17:13:27 -0500
Message-ID: <20241118221330.3480246-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241118221330.3480246-1-peterx@redhat.com>
References: <20241118221330.3480246-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


