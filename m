Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37FD60A5BDA
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=quante.one header.i=@quante.one header.a=rsa-sha256 header.s=cloudpit header.b=u9iJfAcI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt5W-0005SA-1B; Thu, 22 Oct 2026 09:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xJt5T-0005RY-Gc
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:44:07 -0400
Received: from nx233.node01.secure-mailgate.com ([89.22.108.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xJt5R-0004YW-B7
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:44:07 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xJt5M-008gLc-QY; Thu, 22 Oct 2026 15:44:02 +0200
Received: from Zeuss.fritz.box (p57b2f06c.dip0.t-ipconnect.de [87.178.240.108])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 06C9A2808AE;
 Thu, 22 Oct 2026 15:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792676640;
 bh=6ja1WQ32PBzrBRoDzSTkVXS5hdj5jskCGw304i/anU4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u9iJfAcIXSV3f+SX/3Da9b6lgQdClq1DG+PYddzOycy/mtyfLErbL0e5JWspONm4a
 DeeXt/HZrVE+4aYF1KXYWvNu8+rLbcoOJWiuy32y5LjDr/FqSiWgZxzHXyNXvRVduc
 GC9Vlk+Ht5XsMoiL7Nfq5RM5RqFWvrX2I8w91C4w=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] ui/dbus: send a Scanout before the first Update of a
 new surface
Date: Thu, 22 Oct 2026 15:43:32 +0200
Message-ID: <20261022134335.12241-2-christian@quante.one>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022134335.12241-1-christian@quante.one>
References: <20261022134335.12241-1-christian@quante.one>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179267664051.1250690.8197730579438019933@web279.dogado.net>
X-PPP-Vhost: quante.one
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.00627735341472)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuWs1zXd1Ec5oxGqjhYw8bjRdeqUVtxDfpTk
 HBd/69NvrSu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4anFFRVwuHEEuCw/NAbcayAS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS+owFPr4kjXuZPwOU47Z9+sTkIyyXTS8VYEqgliTsM5joQI1u/kR19C5IhkvqbTy
 GsfR/qM1xcrzZXCdLvDNYUL7Nx2KMWdgPAi++APAaUY2cFCBi+CnLjlTLZenhrEW9bnSYHqLeOHt
 2MdG2gILvLgi94PWRqqg5f2zj0Czwt/24XdQQ9W+OVoe9sHR20A4zMJATnq4izMHC9hVf+BNvOPT
 Esk3n0wm6EnWJyExE0ewASJFC/49WOPBr5nlEUI4xN5+JHTQUPjco6i83mpro7FPxa76uBJogGrx
 ftb074ShQCbCj9LKtsZtyrbbjZsnezM+5ly4EqnfEs3lsfc1QHHyucDjZQKHTfIF/c7b2Fbyfday
 zbIhmWzRD5lR5XTkXmwMnk6kZqPMr7Lqqe7ZNGbH3jkGLXsNuD1Se4l+eKHp92PNDpgLsd6Ddd/s
 7VM53kXwgq+dJEq2XrEAl/8Xgp6KgYnDwVj9AJ0/uoGeEasaz6X+WraWTQaj9RGIOyWlXz053gVz
 HEBMLWovRbw1Va6bEN8AS4X48yy5NsQGHgkOWjkyv6wdxnNATvt2iCm/wvUf9oDBqtClgM5jH/om
 1Q6vnKrWgldgJy7s2QKVxGAzg95Rxl42mCUt901ywiJbhL6P7W8ZBEJJJOn/KfKpUV8al0h743VO
 pKNY+4Mjijih1TdBphqYc7PW6V3n6hA0Kwo2w5US6doM8xAVRHdGR3XxnWX8toxo5WwaR4zGdOgD
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=89.22.108.233; envelope-from=christian@quante.one;
 helo=nx233.node01.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 624d0fb71d..26ed84d700 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -71,6 +71,8 @@ struct _DBusDisplayListener {
     DisplayChangeListener dcl;
     DisplaySurface *ds;
     enum share_kind ds_share;
+    /* true until a Scanout or ScanoutMap of ds has been sent */
+    bool ds_scanout_pending;
 
     bool ds_mapped;
     bool can_share_map;
@@ -480,6 +482,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
     }
 
     ddl->ds_share = SHARE_KIND_MAPPED;
+    ddl->ds_scanout_pending = false;
 
     return true;
 }
@@ -591,6 +594,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
     }
 
     ddl->ds_share = SHARE_KIND_MAPPED;
+    ddl->ds_scanout_pending = false;
 
     return true;
 }
@@ -844,6 +848,7 @@ static void ddl_scanout(DBusDisplayListener *ddl)
         ddl->proxy, surface_width(ddl->ds), surface_height(ddl->ds),
         surface_stride(ddl->ds), surface_format(ddl->ds), v_data,
         G_DBUS_CALL_FLAGS_NONE, DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
+    ddl->ds_scanout_pending = false;
 }
 
 static void dbus_gfx_update(DisplayChangeListener *dcl,
@@ -872,7 +877,9 @@ static void dbus_gfx_update(DisplayChangeListener *dcl,
         return;
     }
 
-    if (x == 0 && y == 0 && w == surface_width(ddl->ds) && h == surface_height(ddl->ds)) {
+    if (ddl->ds_scanout_pending ||
+        (x == 0 && y == 0 &&
+         w == surface_width(ddl->ds) && h == surface_height(ddl->ds))) {
         return ddl_scanout(ddl);
     }
 
@@ -907,6 +914,7 @@ static void dbus_gfx_switch(DisplayChangeListener *dcl,
 
     ddl->ds = new_surface;
     ddl->ds_share = SHARE_KIND_NONE;
+    ddl->ds_scanout_pending = true;
 }
 
 static void dbus_mouse_set(DisplayChangeListener *dcl,
-- 
2.53.0


