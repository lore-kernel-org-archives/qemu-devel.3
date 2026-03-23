Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6491F46139
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4h5y-0005LO-FA; Mon, 23 Mar 2026 11:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4h5u-0005L1-TV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:21:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4h5t-0002Xc-7w
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:21:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso2527545e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774279286; x=1774884086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xwSg4574/35tZ7ThVUYhoIp0tLBiIgRYgkQ3PdO9EJY=;
 b=H2LJSvriCNZzu3QtecOvMK0nFMV5bMsGTrNyGVjOKmpF6Qk9wuw+KzZFXFv4SMKdle
 hNqPCY+ZnAynZ8Cmzc6/z8m8xm73xepTjRAqijLHaPlQilHAh58IcySHT2jjHMdqnkfO
 azM5kX2gi2rq28Cgzi6Cl/0jgJpncdQaSCFGC5d+MXkMDnBIoX7ekKKQ5cEaEWXmcgCE
 +X32mrShY2qYCICy8rJY6N5HKYSgRkktDMyB14r2teWHJaILi5HZwebZOAiR9G/rmIdj
 ocQMb/HuBJ7AltBkw1+/tOP+Pa5FPaXLCXiIwIImfGetWZMt8kV2tLVp777jUf1YJ+/O
 xaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774279286; x=1774884086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwSg4574/35tZ7ThVUYhoIp0tLBiIgRYgkQ3PdO9EJY=;
 b=mADkbObd4dRtnZxjaU5EIqZa82j7EHsa8EbGXRjlx0fTWYbv8Yz86v9/SLZMbe6DyD
 2v5oYcFgis95Sy9VS1vigv4qljY2jDVYbs3woxqTqtmQK/iOidJXrpikiBZrjGonBefL
 JdoSfCsXlYi3Lq/da8OqMpnZhdSmvSTfYJ5fWgs1h20G9cJZbzPZBgU/ZlFcG6Zq4anL
 RngJZEp9cx/xzkOW/xzxKzDmIcM+EExPAcDxcuAZW/xCZH+yH+6jQd9GJs18gTFAxihP
 jn7m33++ygUYzTeP/Zsq1Qv60XljLNOVKlCMN9mMzDusuLM/gR8Z6iL7H18c7BLcEEpC
 KDwA==
X-Gm-Message-State: AOJu0YyyhVI13hy7dCrmVtZR/S9GW0Ayp1/vFzFL7KnA08emim9FhauD
 RfD1ev3ygvzEK91kJQr8yN11Jv8y21BLiMdvkiR6gvIbq+o9wr7Hw7zBxjV8WLl7hjR8FAVpVWf
 ZJd7paxQ=
X-Gm-Gg: ATEYQzyxwQ0aljhPnRhJ6QwhxxTNRPDd7EjALKFscMvzsO4MgLtOxGjmb4myhMViD3b
 Uo+wnmvi+hbUCuZmAoD5qygINEiSOUs9G8qhAoGqogMApHlCiuz5LtPhBZmlFOHNCy1Xoo6zOIN
 +u7Bh/wu/tYB/88aCrnfKggvIAUb9EexyvWUU7m7ZthahUjXnRlOcm3+tiuVy1cR6xBiviAOSRH
 uea4CPaFbJ/vQm6xfTlHPrEAlfbbIgGKL+2DTM9T48VaBTP1XlUlkSAFXZ0NnMVBCq5BS/mH7Sb
 Yu0Ta1kljQCdlahB2bYB0BJryrJaoDJ8hpOiR2KdQCwWIdWUYvwDels1b046hqDoxuWVovhjUzu
 pMd3OaPnnJR5aQ4KSItlkhFJHB2UDCE2KMOJEJq240kZ2acTthMLRDbo0f3p/XwzuZm1rEUb2xS
 /6jCnnjVkaTzygbz+8Oe0pMC309ImmZmmwQJpwlwCmujgPkTA3EO+mxW1nhbT/c/eODYPHw3iQd
 tMyQjLhYZA=
X-Received: by 2002:a05:600c:3f1b:b0:487:59c:2bb8 with SMTP id
 5b1f17b1804b1-487059c2eb3mr92067465e9.27.1774279286256; 
 Mon, 23 Mar 2026 08:21:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe032a55sm551025315e9.7.2026.03.23.08.21.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 08:21:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Roth <michael.roth@amd.com>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0] qapi: Remove deprecated SchemaInfoEnumMember::values
 field
Date: Mon, 23 Mar 2026 16:21:24 +0100
Message-ID: <20260323152124.93051-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SchemaInfoEnumMember::values field has been deprecated for
more than 5 years (see commit 75ecee72625 "qapi: Enable enum
member introspection to show more than name"), it should be
safe enough to remove.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       |  6 ------
 docs/about/removed-features.rst |  7 +++++++
 qapi/introspect.json            | 12 +-----------
 scripts/qapi/introspect.py      |  3 +--
 4 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index a6d6a713265..afb0d383c27 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -101,12 +101,6 @@ Use the more generic commands ``block-export-add`` and ``block-export-del``
 instead.  As part of this deprecation, where ``nbd-server-add`` used a
 single ``bitmap``, the new ``block-export-add`` uses a list of ``bitmaps``.
 
-``query-qmp-schema`` return value member ``values`` (since 6.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Member ``values`` in return value elements with meta-type ``enum`` is
-deprecated.  Use ``members`` instead.
-
 ``drive-backup`` (since 6.2)
 ''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index e75db084108..9eb4ef67ff4 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -787,6 +787,13 @@ $VM,debug-threads=on`` instead.
 
 This argument has always been ignored.
 
+``query-qmp-schema`` return value member ``values`` (removed in 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Member ``values`` in return value elements with meta-type ``enum`` has
+been replaced by ``members`` instead.
+
+
 QEMU Machine Protocol (QMP) events
 ----------------------------------
 
diff --git a/qapi/introspect.json b/qapi/introspect.json
index c8432c8ed8e..71b10baabaf 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -159,22 +159,12 @@
 # @members: the enum type's members, in no particular order.
 #     (since 6.2)
 #
-# @values: the enumeration type's member names, in no particular
-#     order.  Redundant with @members.  Just for backward
-#     compatibility.
-#
-# Features:
-#
-# @deprecated: Member @values is deprecated.  Use @members instead.
-#
 # Values of this type are JSON string on the wire.
 #
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoEnum',
-  'data': { 'members': [ 'SchemaInfoEnumMember' ],
-            'values': { 'type': [ 'str' ],
-                        'features': [ 'deprecated' ] } } }
+  'data': { 'members': [ 'SchemaInfoEnumMember' ] } }
 
 ##
 # @SchemaInfoEnumMember:
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 7e28de2279a..daeb3d77b23 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -318,8 +318,7 @@ def visit_enum_type(self, name: str, info: Optional[QAPISourceInfo],
                         prefix: Optional[str]) -> None:
         self._gen_tree(
             name, 'enum',
-            {'members': [self._gen_enum_member(m) for m in members],
-             'values': [Annotated(m.name, m.ifcond) for m in members]},
+            {'members': [self._gen_enum_member(m) for m in members]},
             ifcond, features
         )
 
-- 
2.53.0


