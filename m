Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09595E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdTd-0000rP-NL; Wed, 18 Feb 2026 04:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdTc-0000r2-B4
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:04:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdTa-0008UP-T6
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xylTBKBAhBBCEFQDa1PQFtrPBq4ip0t0I/XcTSk6BaU=;
 b=WyBAD0pK79iKC1EpF25+fiqKbTGGFlxbuV90Tt9INiwiqtWyToS6qUScLVh2j8NkGiqun/
 M2N/nbbIGYBe6k0bksUDjS1d0T+VSo3bOsMlYEbIi61cfDh40z4MNrbZoT4oZYY6w7ayBe
 HriBr1MT9t57jV8sTuhbdMAV334CT2U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-7WZsw2tXOrO1OxMV8KcAbw-1; Wed,
 18 Feb 2026 04:04:03 -0500
X-MC-Unique: 7WZsw2tXOrO1OxMV8KcAbw-1
X-Mimecast-MFC-AGG-ID: 7WZsw2tXOrO1OxMV8KcAbw_1771405442
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D244018001FB; Wed, 18 Feb 2026 09:04:02 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29E3A19560AD; Wed, 18 Feb 2026 09:04:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 10/85] scripts/modinfo: add type annotations
Date: Wed, 18 Feb 2026 10:02:10 +0100
Message-ID: <20260218090330.1476169-11-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Type annotations allow easier code reading, refactoring, checking etc.

Reviewed-by: Yodel Eldar <yodel.eldar@yodel.dev>
Tested-by: Yodel Eldar <yodel.eldar@yodel.dev>
Acked-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/modinfo-generate.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
index aaf23544c46..5a8abcae5d3 100644
--- a/scripts/modinfo-generate.py
+++ b/scripts/modinfo-generate.py
@@ -2,14 +2,16 @@
 
 import os
 import sys
+from typing import Optional
 
-def print_array(name, values):
+
+def print_array(name: str, values: list[str]) -> None:
     if len(values) == 0:
         return
     list = ", ".join(values)
     print("    .%s = ((const char*[]){ %s, NULL })," % (name, list))
 
-def parse_line(line):
+def parse_line(line: str) -> tuple[str, str]:
     kind = ""
     data = ""
     get_kind = False
@@ -31,7 +33,7 @@ def parse_line(line):
             continue
     return (kind, data)
 
-def generate(name, lines, enabled):
+def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str]]:
     arch = ""
     objs = []
     deps = []
@@ -68,17 +70,17 @@ def generate(name, lines, enabled):
     print("},{")
     return {dep.strip('" ') for dep in deps}
 
-def print_pre():
+def print_pre() -> None:
     print("/* generated by scripts/modinfo-generate.py */")
     print("#include \"qemu/osdep.h\"")
     print("#include \"qemu/module.h\"")
     print("const QemuModinfo qemu_modinfo[] = {{")
 
-def print_post():
+def print_post() -> None:
     print("    /* end of list */")
     print("}};")
 
-def main(args):
+def main(args: list[str]) -> None:
     if len(args) < 3 or args[0] != '--devices':
         print('Expected: modinfo-generate.py --devices '
               'config-device.mak [modinfo files]', file=sys.stderr)
-- 
2.53.0


