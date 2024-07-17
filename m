Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CEAC3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 20:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUAzu-0000Xu-8A; Wed, 17 Jul 2024 16:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1sUAzs-0000XR-JT
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 16:11:32 -0400
Received: from mailout04.t-online.de ([194.25.134.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1sUAzq-0008CP-I9
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 16:11:32 -0400
Received: from fwd83.aul.t-online.de (fwd83.aul.t-online.de [10.223.144.109])
 by mailout04.t-online.de (Postfix) with SMTP id 3E909237BB;
 Wed, 17 Jul 2024 22:11:26 +0200 (CEST)
Received: from linpower.localnet ([79.208.28.154]) by fwd83.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1sUAzj-0UUEBl0; Wed, 17 Jul 2024 22:11:23 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 7E8DA20024B; Wed, 17 Jul 2024 22:11:23 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] docs: fix the html docs search function
Date: Wed, 17 Jul 2024 22:11:23 +0200
Message-Id: <20240717201123.9742-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1721247083-C67F6839-317F690F/0/0 CLEAN NORMAL
X-TOI-MSGID: f7a00e3d-dbc5-4c4f-9b1c-16b2278cb475
Received-SPF: pass client-ip=194.25.134.18;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout04.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fix the search function in Sphinx generated html docs when built
with Sphinx >= 6.0.0.

Quote from the Sphinx blog at
https://blog.readthedocs.com/sphinx6-upgrade

Sphinx 6 is out and has important breaking changes

Bundled jQuery is removed. The JavaScript asset is easily added
back using the new extension sphinxcontrib-jquery. It is included
automatically by sphinx-rtd-theme, so if you are using our theme,
you will also continue to have jQuery available in your
documentation.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 docs/conf.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/docs/conf.py b/docs/conf.py
index 876f676881..2aedd407a0 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -62,6 +62,9 @@
 # ones.
 extensions = ['kerneldoc', 'qmp_lexer', 'hxtool', 'depfile', 'qapidoc']
 
+if sphinx.version_info[:3] >= (6, 0, 0):
+    extensions += ['sphinxcontrib.jquery']
+
 if sphinx.version_info[:3] > (4, 0, 0):
     tags.add('sphinx4')
     extensions += ['dbusdoc']
-- 
2.35.3


