Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17CEC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp5t7-0001pa-5E; Tue, 26 Mar 2024 08:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rp5t3-0001oy-V2
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rp5t2-0006zQ-7A
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711455998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jz8PWpI1IuNnh6LtWXjgSr2RQfXSnKpaJzhP2OUz2bs=;
 b=cltYzshxL4/KNbySyZfclO+27VpJw8omDYgdtsSn2UrfiE1u2+tIyZF1lhchjxHlOPHFM+
 gsBE3TOAIn1QA8FINwP9+Wb+mhDsekPksikiCO0+VyEH+udcVpR4gdYHPioPqsKXgDW8eB
 3n7arTTOYPT5JdTu90cxL6hTS4vZTWo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-SxgEV9AENn2o0V80UuTYPw-1; Tue, 26 Mar 2024 08:26:35 -0400
X-MC-Unique: SxgEV9AENn2o0V80UuTYPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 835AA101CC70;
 Tue, 26 Mar 2024 12:26:34 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 745E42166B35;
 Tue, 26 Mar 2024 12:26:32 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: anisinha@redhat.com, mst@redhat.com, laurent@vivier.eu,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH trivial for-9.0] smbios: add stub for smbios_get_table_legacy()
Date: Tue, 26 Mar 2024 13:26:30 +0100
Message-ID: <20240326122630.85989-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QEMU build fails with
  hw/i386/fw_cfg.c:74: undefined reference to `smbios_get_table_legacy'
when it's built with only 'microvm' enabled i.e. with config patch
   +++ b/configs/devices/i386-softmmu/default.mak
   @@ -26,7 +26,7 @@

   # Boards:
   #
   -CONFIG_ISAPC=y
   -CONFIG_I440FX=y
   -CONFIG_Q35=y
   +CONFIG_ISAPC=n
   +CONFIG_I440FX=n
   +CONFIG_Q35=n

it happens because I've fogotten/lost smbios_get_table_legacy() stub.

Fix it by adding missing stub as Philippe suggested.

Fixes: b42b0e4daaa5 "smbios: build legacy mode code only for 'pc' machine"
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Singned-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
Compile tested only.

While it's fixing bug for off-tree usecase with non-upstream config,
it's trivial enough to go into 9.0 if time frame allows.
Benefit of it going into 9.0 is that folks who play with minimal builds
won't have to carry the patch in their tree.


 hw/smbios/smbios_legacy_stub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/smbios/smbios_legacy_stub.c b/hw/smbios/smbios_legacy_stub.c
index f29b15316c..7d593dca98 100644
--- a/hw/smbios/smbios_legacy_stub.c
+++ b/hw/smbios/smbios_legacy_stub.c
@@ -13,3 +13,8 @@
 void smbios_add_usr_blob_size(size_t size)
 {
 }
+
+uint8_t *smbios_get_table_legacy(size_t *length, Error **errp)
+{
+    g_assert_not_reached();
+}
-- 
2.43.0


