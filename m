Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAF2C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnG-00053d-Uj; Tue, 23 Apr 2024 11:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmk-0004Nd-FG
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmg-00006I-Pb
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJx1+mH5xrS6gQ0A7UKGWw/5qSH1qjy1pdG+3DFjz6o=;
 b=Zgg2BEr7/p6rvz+oWl+f4/HlmS+e8LdiQ6ul0rNZEO2tK4aeq60SHa4d2CXy95uCpSg1h6
 u3sb05eFTbFQq3EFhQDsPIsvdFpjGkoDHQoBHX0gk6OKCOU2ZjxBEnHxTn7Bigxh2Zc9bS
 rXr56GIlmi1Zr+kM1Z7IlbwoJIUlGOY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-WbLS_Jb7O-2r7K6EJw0yeA-1; Tue, 23 Apr 2024 11:10:08 -0400
X-MC-Unique: WbLS_Jb7O-2r7K6EJw0yeA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32F3A803505;
 Tue, 23 Apr 2024 15:10:08 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7883620296D2;
 Tue, 23 Apr 2024 15:10:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/63] ramfb: move stubs out of stubs/
Date: Tue, 23 Apr 2024 17:09:01 +0200
Message-ID: <20240423150951.41600-14-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Since the ramfb stubs are needed exactly when the Kconfig symbols are not
needed, move them to hw/display/ and compile them when ramfb.c is absent.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240408155330.522792-14-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/ramfb.c => hw/display/ramfb-stubs.c | 0
 hw/display/meson.build                    | 2 +-
 stubs/meson.build                         | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename stubs/ramfb.c => hw/display/ramfb-stubs.c (100%)

diff --git a/stubs/ramfb.c b/hw/display/ramfb-stubs.c
similarity index 100%
rename from stubs/ramfb.c
rename to hw/display/ramfb-stubs.c
diff --git a/hw/display/meson.build b/hw/display/meson.build
index f93a69f70f4..4751aab3ba9 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -3,7 +3,7 @@ hw_display_modules = {}
 system_ss.add(when: 'CONFIG_DDC', if_true: files('i2c-ddc.c'))
 system_ss.add(when: 'CONFIG_EDID', if_true: files('edid-generate.c', 'edid-region.c'))
 
-system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb.c'))
+system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb.c'), if_false: files('ramfb-stubs.c'))
 system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('ramfb-standalone.c'))
 
 system_ss.add(when: 'CONFIG_VGA_CIRRUS', if_true: files('cirrus_vga.c'))
diff --git a/stubs/meson.build b/stubs/meson.build
index 84ecaa4daa1..92887660e41 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -36,7 +36,6 @@ stub_ss.add(files('qmp-command-available.c'))
 stub_ss.add(files('qmp-quit.c'))
 stub_ss.add(files('qtest.c'))
 stub_ss.add(files('ram-block.c'))
-stub_ss.add(files('ramfb.c'))
 stub_ss.add(files('replay.c'))
 stub_ss.add(files('runstate-check.c'))
 stub_ss.add(files('sysbus.c'))
-- 
2.44.0



