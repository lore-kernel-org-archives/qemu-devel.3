Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4CFC79F99
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3geP-00011Q-2L; Mon, 07 Sep 2026 17:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rtvernam@gmail.com>)
 id 1x3geN-00011H-6l
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 17:13:11 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rtvernam@gmail.com>)
 id 1x3geL-0008Vl-8z
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 17:13:10 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-5303557a6dbso44819791cf.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 14:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788815586; x=1789420386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tPuyrwYs58gFSY8f7O4WqnBgYxkGUXmT5WcIUT3ocWs=;
 b=OjUhlF88bBrgIWsdwV+sHunTLqvVYv/SD49rSaZthg9fjI0z7fCv/wFyEgZwQlOMhG
 46E61WgaX97TQcl7etNbl0bnVqROVgr37Dbcy20GkogVWQ1wnbdUPuJr24QI1drY+WRj
 NuI7RaRiKm1B5OeFALfhCClYteZGP5d+TSVN76JKkV5D2m7AkiLXWm85Gvr+plQNkouU
 ve2/JZl66xgM21LINH5EZLMl508jlytd/07MadUtF8rHCjfLyyLK7uJqJ2MEg6zdFyig
 pp3EKv1l3Qj8ZeGTHyIdJukZb01TmTKlihEr0E10U+XAzIhIMf94Uv9FGQixJmoZ56qV
 DiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788815586; x=1789420386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tPuyrwYs58gFSY8f7O4WqnBgYxkGUXmT5WcIUT3ocWs=;
 b=J4c8iEG0rivET9RdSqAjHaI9L6QKYD1ul9w0dqIWFaZKfdiRU1aLdSO5azgolnII/F
 rFNa1SaGrSUQCcqLHBfL0P6Fy3ywSFOpz4eaWfJ3ZUKgfqD4BfEyX4/ttsC0+quQJbk0
 MY7kBLw40NSWnj3RIVhj30dFfFrAuOID0Tajji1zMpsZk8t0Sw/Nezchv1b/iI8+XDMz
 WOkKBWxoQnKf12cLanJ4SEut0GB9Ce59smcEJXln42H2eGDFeosnw6KrXasKCZkRZvol
 YJGAeW1XpKeEaPfaSYJXq9G/jRQB2vFCgMwvJwrdz5/byPl24C/94891lefi6sprNhMN
 h20A==
X-Gm-Message-State: AFuF++mt3hwcKLsHO/fOHsKGF0yR+RcVWpCAixYVCxDYmAjboW7WK4wi
 PIOcIODTZQUTTc+wsOi2LX96qP9+4S6zS7X8+YbmzgC6t7FpPOrQpdnv7jkHenyRZ68=
X-Gm-Gg: AYBFou3ghgTpgJIQX8rk2Ug0h9dNCCVZ+ql/4nqj8T6AF7f2BdiHA/6hHvGUoNcBhnS
 HzgQ7J25QvTIM1qPTmA0wRIByPF37swGY2btntVQ4+8hDNVM6aX0jkRXqyxIIFNC9m+WXZ2I0tI
 lH0+EeBcg7tbxyBLe+j/0Mh6LuTDOuBC0NjEwN1CBDfTomNkbNBdgdj5oazgsy4gv6uUH+pgE0i
 /pwDMnEZNh4vXl6M0WdPavhS7AsBGNVEZ5RzQHN4hCJXEa0H+zfwff4doclR/ATlJRqWFoYZsgx
 ryWLVjLif4L0uVuGX3PTULDKfkVfn+NUCkomQzFz7h9GkJV52dmppSXSS0B8PegfIX1W3HbaNoG
 i6lpTbOoNFnkPa3vRZaWtenKTewusrJMz73HPmDOklGTtuUcK51Ii/LVDpf2KgciKnjaLLv3gRo
 7kLZfrmywG2LfvZSkEtlAc2AA0W4A7XKK9URNe55Na+Is/wfMlhJ0wbo4wXmT0o01R4o21BVtM8
 NIqjY9OzS5v4gbg7N4HbJZTU81+pbj1gaaERWhx6OUzDKa7BA==
X-Received: by 2002:a05:622a:310:b0:530:596:f70d with SMTP id
 d75a77b69052e-530549a3497mr275559821cf.34.1788815586464; 
 Mon, 07 Sep 2026 14:13:06 -0700 (PDT)
Received: from rick.vernam.net
 (1393128-v117.1221-static.oswgilaa.metronetinc.net. [69.174.143.208])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530541eab6csm101023471cf.26.2026.09.07.14.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:13:05 -0700 (PDT)
From: Rick Vernam <rtvernam@gmail.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
	rtvernam@gmail.com
Subject: [PATCH] ui/dbus: forward guest clipboard grabs that lack a serial
Date: Mon,  7 Sep 2026 16:12:33 -0500
Message-ID: <20260907211233.501672-1-rtvernam@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=rtvernam@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

dbus_clipboard_update_info() drops any incoming grab whose
QemuClipboardInfo has no serial number:

    if (self_update || !info->has_serial) {
        return;
    }

For grabs coming from ui/vdagent.c, has_serial is only set when the
guest's vdagent client has negotiated VD_AGENT_CAP_CLIPBOARD_GRAB_SERIAL
(see vdagent_clipboard_recv_grab()). When the guest doesn't negotiate
it, the grab is silently dropped here and never forwarded to the
D-Bus display client via Clipboard.Grab.

It seems other protocols (ui/gtk-clipboard.c, ui/vnc-clipboard.c) do not
incorporate a validation on has_serial, so this patch matches their
behavior.

Signed-off-by: Rick Vernam <rtvernam@gmail.com>
---
 ui/dbus-clipboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
index 90318384ee..1389ec0edc 100644
--- a/ui/dbus-clipboard.c
+++ b/ui/dbus-clipboard.c
@@ -72,7 +72,7 @@ dbus_clipboard_update_info(DBusDisplay *dpy, QemuClipboardInfo *info)
         return;
     }
 
-    if (self_update || !info->has_serial) {
+    if (self_update) {
         return;
     }
 
-- 
2.55.0


