Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B01CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnN-0005Yi-3L; Tue, 23 Apr 2024 11:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmg-0004NJ-Vd
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmc-000057-Bl
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ne8m0qr+YkU2QhH9qzSBx3LCWqWLyReRad8Mw2vZv4M=;
 b=HG8Na+qF1TDERZ+xpdh7uOf9em3+rcblzoiFU0d0PoVuHTdJsad96TlEzcVbhgugXJqHqq
 VMWIahFCA9+KGqCPC27QwCsFMAE+quUpNF1m/yGdYL85MnDh3ha0yeoM3iBcr2FDOHQ4Tb
 Ly6YEFuqngKRd6CUvrKrzywrxSqUVqw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-dni42PV2N3-oxZeni0uW4Q-1; Tue,
 23 Apr 2024 11:10:05 -0400
X-MC-Unique: dni42PV2N3-oxZeni0uW4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC3BF1C0C64F;
 Tue, 23 Apr 2024 15:10:04 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05ACB200E290;
 Tue, 23 Apr 2024 15:10:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/63] hw/usb: move stubs out of stubs/
Date: Tue, 23 Apr 2024 17:08:58 +0200
Message-ID: <20240423150951.41600-11-pbonzini@redhat.com>
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

Since the USB stubs are needed exactly when the Kconfig symbols are not
enabled, they can be placed in hw/usb/ and conditionalized on CONFIG_USB.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240408155330.522792-11-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/usb-dev-stub.c => hw/usb/bus-stub.c | 0
 hw/usb/meson.build                        | 2 +-
 stubs/meson.build                         | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename stubs/usb-dev-stub.c => hw/usb/bus-stub.c (100%)

diff --git a/stubs/usb-dev-stub.c b/hw/usb/bus-stub.c
similarity index 100%
rename from stubs/usb-dev-stub.c
rename to hw/usb/bus-stub.c
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index aac3bb35f27..23f7f7acb50 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -9,7 +9,7 @@ system_ss.add(when: 'CONFIG_USB', if_true: files(
   'desc-msos.c',
   'libhw.c',
   'pcap.c',
-))
+), if_false: files('bus-stub.c'))
 
 # usb host adapters
 system_ss.add(when: 'CONFIG_USB_UHCI', if_true: files('hcd-uhci.c'))
diff --git a/stubs/meson.build b/stubs/meson.build
index aa7120f7110..45616afbfaa 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -56,7 +56,6 @@ endif
 if have_system
   stub_ss.add(files('fw_cfg.c'))
   stub_ss.add(files('semihost.c'))
-  stub_ss.add(files('usb-dev-stub.c'))
   stub_ss.add(files('xen-hw-stub.c'))
   stub_ss.add(files('virtio-md-pci.c'))
 else
-- 
2.44.0



