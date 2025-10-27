Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790A7CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMmS-0002Kk-E0; Mon, 27 Oct 2025 08:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.parlant@parhuet.fr>)
 id 1vDLe5-0005kk-Ui
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:44:21 -0400
Received: from lnsph.fr ([45.13.104.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.parlant@parhuet.fr>)
 id 1vDLe1-0005yT-7B
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:44:17 -0400
From: Nicolas PARLANT <nicolas.parlant@parhuet.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parhuet.fr; s=dkim;
 t=1761565441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/ZkYEPhMYnXLtQUB2AyxC107i5sz1bUsO07DPCuqMeE=;
 b=AGKLUnIGTx9PgJkWnUHbL1Wu5BWp2B++1L2eF+AUsenLzxI63BFOtzFSjftdu2Bw2tlSQU
 6/yNL8DRP1yxkyWpQZ+knJmsNTpwPB3x5cJsl5EenB3ccHa8C+8dA4I879MT2On7e2vmpU
 WvtT4zx4/TpKh7/jSJhKS3oC/OLOL8pFRh6iLfQqUHxe3d7qagN1uPthctR5zo6xFllvXV
 6McDkAb9BKPlJT/Myqb5H8DeTa0eaZE0uoUSQQ58UI0ckT78/Q6RkX+NQFBNlK/U+zFHHh
 CVi/rKXYn8++1pnhRLlzdc9yEQAlYn3j54uiDYatd6Rzv1ojYNcP+l+yD10w0A==
Authentication-Results: lnsph.fr;
 auth=pass smtp.auth=ppn smtp.mailfrom=nicolas.parlant@parhuet.fr
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	Nicolas PARLANT <nicolas.parlant@parhuet.fr>
Subject: [PATCH] make gdbus-codegen optional, not required by passt
Date: Mon, 27 Oct 2025 12:39:11 +0100
Message-ID: <20251027113910.25379-2-nicolas.parlant@parhuet.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C7CE46000642
X-Spamd-Result: default: False [-1.44 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.10)[]; R_MISSING_CHARSET(0.55)[];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_ZERO(0.00)[0];
 DKIM_SIGNED(0.00)[parhuet.fr:s=dkim]; FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lnsph.fr
Received-SPF: pass client-ip=45.13.104.99;
 envelope-from=nicolas.parlant@parhuet.fr; helo=lnsph.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Oct 2025 08:56:51 -0400
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

passt needs gio but not gdbus-codegen. Make gdbus-codegen optional,
dbus_display which requires it will still fail as expected.

Signed-off-by: Nicolas PARLANT <nicolas.parlant@parhuet.fr>
---
 meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index c5710a6a47..3f7c973127 100644
--- a/meson.build
+++ b/meson.build
@@ -1126,8 +1126,7 @@ if not get_option('gio').auto() or have_system
     gio = not_found
   endif
   if gio.found()
-    gdbus_codegen = find_program('gdbus-codegen',
-                                 required: get_option('gio'))
+    gdbus_codegen = find_program('gdbus-codegen', required: false)
     gio_unix = dependency('gio-unix-2.0', required: get_option('gio'),
                           method: 'pkg-config')
     gio = declare_dependency(dependencies: [gio, gio_unix],
-- 
2.51.0


