Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B00C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP26r-0001pJ-3L; Tue, 10 Jun 2025 12:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uP02K-00021Y-6w
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uP02H-0005zx-TR
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749565988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRSeCwj+dMHoZjmVPyY8OrzDtBJno4nhvUzRPDwlTJ4=;
 b=dZ2RJeEmcoQtmtXv7jV1ZTDvbLrj07BXIA7xFO7Ah+ro4CjwnP9vbcOgEMRp+eaDpn6TvX
 eRXMvvPuCHlBAzOv5WHWAhi1sNNZBqBykNYOtuPygL+vZffH1IdUY7nfx40ga2WdGmqrU6
 NFCxFmY/g60KP6+iUT/iaqG6r4lddT0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-APleBND4M0eo1An14_w_Gg-1; Tue,
 10 Jun 2025 10:33:06 -0400
X-MC-Unique: APleBND4M0eo1An14_w_Gg-1
X-Mimecast-MFC-AGG-ID: APleBND4M0eo1An14_w_Gg_1749565986
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F371D180034E
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 14:33:05 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-216.str.redhat.com
 [10.33.192.216])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0E9819560B0; Tue, 10 Jun 2025 14:33:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 1/2] watchdog: CONFIG_WDT_IB6300ESB -> CONFIG_WDT_I6300ESB
Date: Tue, 10 Jun 2025 16:32:58 +0200
Message-ID: <20250610143259.1056400-2-cohuck@redhat.com>
In-Reply-To: <20250610143259.1056400-1-cohuck@redhat.com>
References: <20250610143259.1056400-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There's no ib6300esb device; let's correct the typo in the config option.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/watchdog/Kconfig     | 2 +-
 hw/watchdog/meson.build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 861fd003341d..1003939e1f33 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -2,7 +2,7 @@ config CMSDK_APB_WATCHDOG
     bool
     select PTIMER
 
-config WDT_IB6300ESB
+config WDT_I6300ESB
     bool
     default y if PCI_DEVICES
     depends on PCI
diff --git a/hw/watchdog/meson.build b/hw/watchdog/meson.build
index 15370565bd4d..dafb85dfffc3 100644
--- a/hw/watchdog/meson.build
+++ b/hw/watchdog/meson.build
@@ -1,7 +1,7 @@
 system_ss.add(files('watchdog.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_WDT', if_true: files('allwinner-wdt.c'))
 system_ss.add(when: 'CONFIG_CMSDK_APB_WATCHDOG', if_true: files('cmsdk-apb-watchdog.c'))
-system_ss.add(when: 'CONFIG_WDT_IB6300ESB', if_true: files('wdt_i6300esb.c'))
+system_ss.add(when: 'CONFIG_WDT_I6300ESB', if_true: files('wdt_i6300esb.c'))
 system_ss.add(when: 'CONFIG_WDT_IB700', if_true: files('wdt_ib700.c'))
 system_ss.add(when: 'CONFIG_WDT_DIAG288', if_true: files('wdt_diag288.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('wdt_aspeed.c'))
-- 
2.49.0


