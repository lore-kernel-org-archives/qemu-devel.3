Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DA0E7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwdI-0007il-UO; Mon, 16 Feb 2026 06:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaS-00054L-JX
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaK-0007MO-PL
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBqAgB7LrCGMYNH0r4X9ORm6NR49Rz7X+bLJoA4G3bU=;
 b=Tb88MYYbiu5sOG+aNp4g+te7fC8dKBVdLHumbseXX0D8oCAxJ/d6Rt/5zppRFzmnSTwEuj
 Sk7lZE7wl1b0CA3GyBGU4SoW3T86lnrhYWm0CaC1PVaNHxgfGI+w/2Kj0bcODuWvtM5pEL
 lCmZubbqiO9pCDztZM5Y3+jivoZ3XwM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-FI5tjmhYPm2FTWcH6gP5Tw-1; Mon,
 16 Feb 2026 06:16:07 -0500
X-MC-Unique: FI5tjmhYPm2FTWcH6gP5Tw-1
X-Mimecast-MFC-AGG-ID: FI5tjmhYPm2FTWcH6gP5Tw_1771240565
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44FBF1956054; Mon, 16 Feb 2026 11:16:05 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82D1630001A5; Mon, 16 Feb 2026 11:16:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:14:59 +0100
Subject: [PATCH 10/85] scripts/modinfo: add type annotations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-10-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Yodel Eldar <yodel.eldar@yodel.dev>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2026;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5Hl18YRrW30PKleJRGv7L/P5HPSsWojpXhI13YBVZFo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxOFBO2DEy9DCiSBBH6JrWUKzQ19rtPlAW3q
 hh/vhJqxwaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TgAKCRDa6OEJdZac
 5TZFD/9OCmMWgXkQimmIu/VBagVrLlsqgce+i7mwDLu0NTXbuxuz57WTKX5X+q83E6w5JPI2TCU
 BEJxkB0YSE80BeeGVy0QqvZR++vRrzEIeiyhWbdJX88tZUPjjcOPbvU4tgzfZDJDJC4hjs+QIBE
 puLgCdYBH9JtPh+DKiyuMdovU5z+/XC+DffkvP8QhK817O0TAoAB66QXqxTVBP0q7dchPtOr1Jw
 k1H88MZ8jPKqDlHrAuRuv6hN1BEEKQKe+X/BzlNIJSdPcztUq2rhQeZshF9SPbhn+TIJlzh3vks
 bWUhyEU+rGE9NSG8cCKKGrrcFn46bm1gn/9YplwHTiSOW4xukT8y1ZYKEBSuvS9edOZa7uJR0EM
 Y2gthMqsMJes6VHq2AwpL8XGo+tAKQ/U6xKklOPEBIMbO+7Fd2Evp1tkTpYqmkXs30NEqXxMUFs
 D72sB+rFYmDG1zC+GGi27dyseDLpBggyO56E1ngyTykQQSNDnHGg9jBY9S4ZqzPtwYrEKvd51O4
 6YefmW0KeiBnks3blymmVVz3yH3tO3ReMYdpWhi0tSG/kFstjYH3S3gTYlwPwDYBWAtGkDOhx1C
 2vDTiw6dTIPGkyAPcIE+mC2nwRVENdlKIgnHDTbQDdNPvyfL9Gm27iDykgq8WpFyiJSXjh8ZL82
 5ds0Z6g+Qq524Aw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Type annotations allow easier code reading, refactoring, checking etc.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Yodel Eldar <yodel.eldar@yodel.dev>
Tested-by: Yodel Eldar <yodel.eldar@yodel.dev>
Acked-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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


