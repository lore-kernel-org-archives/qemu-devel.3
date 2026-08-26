Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098CAC61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLNc-0001eS-Px; Wed, 26 Aug 2026 17:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces-494710918-1902512630@hb.d.sender-sib.com>)
 id 1wzKMs-00033D-Qs
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 16:37:07 -0400
Received: from hb.d.sender-sib.com ([77.32.148.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounces-494710918-1902512630@hb.d.sender-sib.com>)
 id 1wzKMr-0001FT-4n
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 16:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=11981705.brevosend.com;
 q=dns/txt; s=mail; bh=AZWMdcqUiK9+9SQJziXOCwz9QCLxqQ8mdDHLai8eO1c=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
 b=ZXJp6iLbbJLIeCXG8pOihOGu+u80LFhaEJuf2Fl8tYFQ8Z3zDr/F19+sA5i+sUrWsF7gt360aCG8
 yU/YqhBsBpJrTouqwGKz8G7hfPIF8M1B7MRhLZTZwXS8KXL5Y+GcFpK1/OHnv7XE9m5LCWuaqwGg
 C+aZ9xjbIwTm2PKfDnU=
X-Mailin-EID: NDk0NzEwOTE4fnFlbXUtZGV2ZWxAbm9uZ251Lm9yZ348MjAyNjA4MjYyMDM3MDAuMzkwNTctMS1kdWRlQGFuZ3J5Z29vc2UuZGV2Pn5oYi5kLnNlbmRlci1zaWIuY29t
Date: Wed, 26 Aug 2026 16:37:00 -0400
Subject: [PATCH] Update to a cleaner build path on macOS 27.
 ParavirtualizationGraphics.framework API has changed significantly.
Cc: <pbonzini@redhat.com>, <marcandre.lureau@redhat.com>, <berrange@redhat.com>,
 <philmd@mailo.com>, <pierrick.bouvier@oss.qualcomm.com>, <dude@angrygoose.dev>
Origin-messageId: <20260826203700.39057-1-dude@angrygoose.dev>
From: "DB Holder" <dude@angrygoose.dev>
X-CSA-Complaints: csa-complaints@eco.de
To: <qemu-devel@nongnu.org>
X-sib-id: XgJKQZA04SMv_fxwc3QnfYRA7RTnz6zf-bibwnFck3DfmgAFkFTf5mWxXeKANLMUq66zdNBhdopCQk7z7bFRG2H1IJQuMfYxwFVqSynEoAUJ-EO-qfr5lkt06Wz4LY6NrOvbYHgBzs7nFwVYpeIZ102T4tmqLRAUEqo96HrtXdBxMMzu
Message-Id: <20260826203700.39057-1-dude@angrygoose.dev>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.28:11981705_-1:11981705:Sendinblue
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Received-SPF: pass client-ip=77.32.148.28;
 envelope-from=bounces-494710918-1902512630@hb.d.sender-sib.com;
 helo=hb.d.sender-sib.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Aug 2026 17:41:54 -0400
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


 API marked obsolete in xcrun --show-sdk-path + /System/Library/Frameworks/=
ParavirtualizedGraphics.framework/Headers/PGDevice.h

Signed-off-by: DB Holder <dude@angrygoose.dev>
---
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index 6dcfdceb50..a6b11cb009 100644
--- a/meson.build
+++ b/meson.build
@@ -852,6 +852,14 @@ elif host_os =3D=3D 'darwin'
   host_dsosuf =3D '.dylib'
   pvg =3D dependency('appleframeworks', modules: ['ParavirtualizedGraphics=
', 'Metal'],
                    required: get_option('pvg'))
+  if pvg.found() and not objc.has_type('PGTask_t',
+                          prefix: '#import <ParavirtualizedGraphics/Paravi=
rtualizedGraphics.h>',
+                          dependencies: pvg)
+    if get_option('pvg').enabled()
+      error('ParavirtualizedGraphics framework found, but the API lacks PG=
Task_t')
+    endif
+    pvg =3D not_found
+  endif
 elif host_os =3D=3D 'sunos'
   socket =3D [cc.find_library('socket'),
             cc.find_library('nsl'),
--=20
2.54.0 (Apple Git-157)




