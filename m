Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87A6C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twxCY-0008WL-4r; Tue, 25 Mar 2025 01:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twxCP-0008VU-Uy
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 01:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twxCO-0003fX-3i
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 01:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742881899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rYHVphcPswy+yHCUUrELuvkL2rHql27SWXLqA9a8458=;
 b=E/Wr1FBUOp2b2+R4chiGRKXmSFKVPUt53U8mQWlYRVscRk1KIrZOrZtawOYqinJSCmXwqv
 kx8IqA9YfwHhMcOWqxDFOxX1/AW7M0s6Igm74z4ngwqcRXeOrCaZtlD8WA6dCKAKfiTFrx
 oFRIh67z3KnLqAq16VlC4FvmFyvUwDI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-UgQGEXYPP-G4V4Dw5vkPxQ-1; Tue,
 25 Mar 2025 01:51:30 -0400
X-MC-Unique: UgQGEXYPP-G4V4Dw5vkPxQ-1
X-Mimecast-MFC-AGG-ID: UgQGEXYPP-G4V4Dw5vkPxQ_1742881889
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E037180AB1C; Tue, 25 Mar 2025 05:51:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.60])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D0EE19560AB; Tue, 25 Mar 2025 05:51:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] meson.build: Put the D-Bus summary into the UI section
Date: Tue, 25 Mar 2025 06:51:25 +0100
Message-ID: <20250325055125.253669-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

We've got a dedicated section for UI options nowadays, so the
D-Bus display should get reported here, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 41f68d38069..205fb43bf7b 100644
--- a/meson.build
+++ b/meson.build
@@ -4559,7 +4559,6 @@ summary_info += {'Trace backends':    ','.join(get_option('trace_backends'))}
 if 'simple' in get_option('trace_backends')
   summary_info += {'Trace output file': get_option('trace_file') + '-<pid>'}
 endif
-summary_info += {'D-Bus display':     dbus_display}
 summary_info += {'QOM debugging':     get_option('qom_cast_debug')}
 summary_info += {'Relocatable install': get_option('relocatable')}
 summary_info += {'vhost-kernel support': have_vhost_kernel}
@@ -4742,6 +4741,7 @@ summary_info = {}
 if host_os == 'darwin'
   summary_info += {'Cocoa support':           cocoa}
 endif
+summary_info += {'D-Bus display':     dbus_display}
 summary_info += {'SDL support':       sdl}
 summary_info += {'SDL image support': sdl_image}
 summary_info += {'GTK support':       gtk}
-- 
2.49.0


