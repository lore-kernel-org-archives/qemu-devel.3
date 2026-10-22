Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1134606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=quante.one header.i=@quante.one header.a=rsa-sha256 header.s=cloudpit header.b=zAgdrfpv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJlTQ-00040L-Pc; Thu, 22 Oct 2026 01:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xJlTM-0003zc-T8
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 01:36:16 -0400
Received: from nx230.node01.secure-mailgate.com ([89.22.108.230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xJlTK-0005mb-8u
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 01:36:16 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xJlTC-007ALj-TJ; Thu, 22 Oct 2026 07:36:08 +0200
Received: from Zeuss.fritz.box (p57b2f06c.dip0.t-ipconnect.de [87.178.240.108])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id D0DDB2823DF;
 Thu, 22 Oct 2026 07:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792647366;
 bh=pJXIbSCSCY1cQvosN7UGD1dqe/P7vXOxD27sVtH2nMQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=zAgdrfpvwPLs4fdqTw6ZVvThv+DgmjH3zTyX7MlmO+K+PIuB09PrswGAxhRigSx/t
 fqu+d0yZtDjGf+8OhxlQKY/N55PqBWcP3JoF2N3xDK+Ep/vLzZqOdi58jHcBoL/JAF
 qaoimAbCjMmWTT2MqCiIisZPOD+Z9aktjkXHvAhU=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/2] ui/dbus: send a Scanout before the first Update of a new
 surface
Date: Thu, 22 Oct 2026 07:35:32 +0200
Message-ID: <20261022053535.38791-2-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022053535.38791-1-christian@quante.one>
References: <20261022053535.38791-1-christian@quante.one>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179264736641.2629149.8862951297327352690@web279.dogado.net>
X-PPP-Vhost: quante.one
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuU0SH3+V0M92M6TPX6XoZfPUyRPtK4rQ3m4
 cnxjBe65HCu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4YTEWDxl06PHqgMTgL9HpwYS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgnsj5xBssn0tIIHA3aH
 QzCq60l8YRpcxCjc2gcMa3Btw+OTpzU5Yy8oe2B0dJEHaEkiihVil/4PKs38NtnG3PEGvDsoH6Px
 tvFZEJq1ao2KN5EH/A/z83UAaQnqiAWuQHxGFdQa/R6nd5VFHne4SM1RwKLZ/phrV9Me8fSKrw4f
 A+4kDqBeCn8nwBijhCUNJGyCvsB/S6lahvN4tMy6dkx+prdNNcr2SN8Roi9WwIkFNxqXSHvjdU6k
 o1j7gyOKOKFtV1w91ummwAJgSfp95IB5KumLerNJaitFnP2ausrj+xM74OqDymuB/totiLbH5Lhy
 EYUeNDqrX3Sju+Zod+VznaUXiPoTcHWs9ZbziSvcjAfILneBruSXVJFMTtbeU7O5tXIuaHlw6sj8
 kI/kwqmxDmhcGtkR8y9z81B5Ndl6ntj2X71nPVUIlgpagBYLgrI+1t0jgRpAgh7HGohm5hY9yspj
 qXTq7JACOyfgEMD59X5gezmDaQSeK6PbrzEZPBeLBDMrD7q/cJogwbqzsuokJcC8qx+Rmq5bU2ck
 JaKp5ix9QX0oe/06fQ8//V2TSnQfjKdzTmoKYEjQFpxaoYG3IMDGHYM62P/O4OV8g7wZZhzxetL+
 zsw5uITiww0HzQO5A4HOIDb6HJquMBeQaPknUrEcH960Yb6MpiL+285bIYk5bXpb/yeR3Q3u2oYl
 JoJDLxC5XEDzNnn+IWGxqYpiBiFMXZsNOH+1R01VtZLf6H6YFrhxVw5i30CZMe0+JKqWmKu/Exva
 /4bO4tpXcmDOLBLnx328rZUKBRO/9xuL1l/1awwGVhCMt0tTKiHWpRk=
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=89.22.108.230; envelope-from=christian@quante.one;
 helo=nx230.node01.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Without OpenGL and without shared memory, the D-Bus listener sends a
Scanout only for an update that covers the whole surface, and
dbus_gfx_switch() only records the new surface. So when a device draws
a new surface in parts, the client gets Updates for a size that no
Scanout has given it. VGA text mode is such a device: vga_draw_text()
sends one update per row of characters, so a text mode that changes its
size does not send a Scanout. According to ui/dbus-display1.xml, Update
is only called after a Scanout call, and Scanout is the call that
resizes the display.

The client can learn the new size only from the Width and Height
properties of the Console. They come on a different connection, and
the generated skeleton sends PropertiesChanged from an idle callback,
after the redraw. A client that sets up a new buffer when this signal
comes loses the rows that came before it. VGA text mode does not send
them again: it redraws only the characters that change, and all of
them only after changes such as a new font or palette, or with blinking
enabled.

The Windows NT 4.0 setup shows this. With blinking off, it changes the
character height from 16 to 12 lines (720x400 to 720x396), and in a
D-Bus client large parts of its blue background stayed black.

With shared memory, dbus_scanout_map() already sends ScanoutMap with the
new size at the first update after a surface switch. Do the same without
shared memory: the first update after a switch sends a Scanout of the
whole surface.

Signed-off-by: Christian Quante <christian@quante.one>
---
 ui/dbus-listener.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 624d0fb71d..d25132fe7e 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -71,6 +71,8 @@ struct _DBusDisplayListener {
     DisplayChangeListener dcl;
     DisplaySurface *ds;
     enum share_kind ds_share;
+    /* true until a Scanout of ds has been sent */
+    bool ds_scanout_pending;
 
     bool ds_mapped;
     bool can_share_map;
@@ -844,6 +846,7 @@ static void ddl_scanout(DBusDisplayListener *ddl)
         ddl->proxy, surface_width(ddl->ds), surface_height(ddl->ds),
         surface_stride(ddl->ds), surface_format(ddl->ds), v_data,
         G_DBUS_CALL_FLAGS_NONE, DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
+    ddl->ds_scanout_pending = false;
 }
 
 static void dbus_gfx_update(DisplayChangeListener *dcl,
@@ -872,7 +875,9 @@ static void dbus_gfx_update(DisplayChangeListener *dcl,
         return;
     }
 
-    if (x == 0 && y == 0 && w == surface_width(ddl->ds) && h == surface_height(ddl->ds)) {
+    if (ddl->ds_scanout_pending ||
+        (x == 0 && y == 0 &&
+         w == surface_width(ddl->ds) && h == surface_height(ddl->ds))) {
         return ddl_scanout(ddl);
     }
 
@@ -907,6 +912,7 @@ static void dbus_gfx_switch(DisplayChangeListener *dcl,
 
     ddl->ds = new_surface;
     ddl->ds_share = SHARE_KIND_NONE;
+    ddl->ds_scanout_pending = true;
 }
 
 static void dbus_mouse_set(DisplayChangeListener *dcl,
-- 
2.53.0


