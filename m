Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5D8C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnN-0005YS-3D; Tue, 23 Apr 2024 11:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmg-0004NI-VZ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmc-000058-JU
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCI8G6AGfryz/wVyTdfzVO73x/SIX8rjk25RIz7ksKo=;
 b=aOZjXsmx8N+gPSC03UAQhr3JJwbCacIHG5JedrxLSuMzitG/TckH43CQvdOTCyvXZqId9L
 QtSN3x0/ghdAhcCrV71WMxIZji/0CS3MmGk9QPYOnyCHlOLPT2L4WH+VBfZvkmCYZVmEmA
 wEhCevtapMu1f1OiZWviepaQo3sMknc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-FmH_wf9BP_OvZY7ERDx8rg-1; Tue, 23 Apr 2024 11:10:06 -0400
X-MC-Unique: FmH_wf9BP_OvZY7ERDx8rg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DCF28107BD;
 Tue, 23 Apr 2024 15:10:06 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC6B5200AFA2;
 Tue, 23 Apr 2024 15:10:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/63] hw/virtio: move stubs out of stubs/
Date: Tue, 23 Apr 2024 17:08:59 +0200
Message-ID: <20240423150951.41600-12-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since the virtio memory device stubs are needed exactly when the
Kconfig symbol is not enabled, they can be placed in hw/virtio/ and
conditionalized on CONFIG_VIRTIO_MD.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240408155330.522792-12-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c | 0
 hw/virtio/meson.build                                | 2 ++
 stubs/meson.build                                    | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c (100%)

diff --git a/stubs/virtio-md-pci.c b/hw/virtio/virtio-md-stubs.c
similarity index 100%
rename from stubs/virtio-md-pci.c
rename to hw/virtio/virtio-md-stubs.c
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index d7f18c96e60..621fc65454c 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -87,6 +87,8 @@ specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
+system_ss.add(when: 'CONFIG_VIRTIO_MD', if_false: files('virtio-md-stubs.c'))
+
 system_ss.add(files('virtio-hmp-cmds.c'))
 
 specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
diff --git a/stubs/meson.build b/stubs/meson.build
index 45616afbfaa..60e32d363fa 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -57,7 +57,6 @@ if have_system
   stub_ss.add(files('fw_cfg.c'))
   stub_ss.add(files('semihost.c'))
   stub_ss.add(files('xen-hw-stub.c'))
-  stub_ss.add(files('virtio-md-pci.c'))
 else
   stub_ss.add(files('qdev.c'))
 endif
-- 
2.44.0



