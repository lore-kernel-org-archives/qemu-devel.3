Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BE8C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 14:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYRVJ-0002Vg-Rx; Fri, 09 Feb 2024 09:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVH-0002US-Si
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rYRVG-0004AG-BB
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 09:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707487517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QrmA6V0m313XVNqtlIfHrcER3272CRptO62/TAmPoA=;
 b=FBcoX3VXOCIUvEuqGcw8XiBX+N8+xzOSCj3faXdVthqBScd1ZW6rMP2ZA2HikZ4NYHlGD9
 ctq7+BTBtqJ3BisFkpLGMJagCLxUAYUg2MBSTkRqDq23JeEXH/tBRK4MqrrjmJeps6VEMN
 8RrHShZ5sVpsglYarXKQJ7mnG14VuAA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-6d3WBiF3NBCMtgFuMUBrZA-1; Fri, 09 Feb 2024 09:05:12 -0500
X-MC-Unique: 6d3WBiF3NBCMtgFuMUBrZA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C60598F920C;
 Fri,  9 Feb 2024 14:05:11 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96E8D112A1;
 Fri,  9 Feb 2024 14:05:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Stefan Weil <sw@weilnetz.de>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 01/17] meson: sort C warning flags alphabetically
Date: Fri,  9 Feb 2024 14:04:49 +0000
Message-ID: <20240209140505.2536635-2-berrange@redhat.com>
In-Reply-To: <20240209140505.2536635-1-berrange@redhat.com>
References: <20240209140505.2536635-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When scanning the list of warning flags to see if one is present, it is
helpful if they are in alphabetical order. It is further helpful to
separate out the 'no-' prefixed warnings.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/meson.build b/meson.build
index e5d6f2d057..74d3aa0b12 100644
--- a/meson.build
+++ b/meson.build
@@ -571,36 +571,38 @@ qemu_common_flags += cc.get_supported_arguments(hardening_flags)
 add_global_arguments(qemu_common_flags, native: false, language: all_languages)
 add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
 
-# Collect warnings that we want to enable
-
+# Collect warning flags we want to set, sorted alphabetically
 warn_flags = [
-  '-Wundef',
-  '-Wwrite-strings',
-  '-Wmissing-prototypes',
-  '-Wstrict-prototypes',
-  '-Wredundant-decls',
-  '-Wold-style-declaration',
-  '-Wold-style-definition',
-  '-Wtype-limits',
-  '-Wformat-security',
-  '-Wformat-y2k',
-  '-Winit-self',
-  '-Wignored-qualifiers',
+  # First enable interesting warnings
   '-Wempty-body',
-  '-Wnested-externs',
   '-Wendif-labels',
   '-Wexpansion-to-defined',
+  '-Wformat-security',
+  '-Wformat-y2k',
+  '-Wignored-qualifiers',
   '-Wimplicit-fallthrough=2',
+  '-Winit-self',
   '-Wmissing-format-attribute',
+  '-Wmissing-prototypes',
+  '-Wnested-externs',
+  '-Wold-style-declaration',
+  '-Wold-style-definition',
+  '-Wredundant-decls',
+  '-Wshadow=local',
+  '-Wstrict-prototypes',
+  '-Wtype-limits',
+  '-Wundef',
+  '-Wwrite-strings',
+
+  # Then disable some undesirable warnings
+  '-Wno-gnu-variable-sized-type-not-at-end',
   '-Wno-initializer-overrides',
   '-Wno-missing-include-dirs',
+  '-Wno-psabi',
   '-Wno-shift-negative-value',
   '-Wno-string-plus-int',
-  '-Wno-typedef-redefinition',
   '-Wno-tautological-type-limit-compare',
-  '-Wno-psabi',
-  '-Wno-gnu-variable-sized-type-not-at-end',
-  '-Wshadow=local',
+  '-Wno-typedef-redefinition',
 ]
 
 if host_os != 'darwin'
-- 
2.43.0


