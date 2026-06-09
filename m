Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550A9CD98CA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1wc-00066r-LW; Tue, 09 Jun 2026 15:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wY-00063L-AL
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:59 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wV-0006Qj-4m
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490b4e1ade7so64267355e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781032613; x=1781637413; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UddDIjGWqVzUF3+xkE4iOnIhAz8+dhzDkVGO8DGPO8I=;
 b=jjegZnrfRczzX5fwZzhD+/a1xgQMJcn+6xnq43kUjBF2xhb7sLNK3b15+xFQ/sM6Uw
 qfGEiyDWhJ/WjM71IdQykm0WL5vE7nxW0WShavNXY++YeytTc3Lv+MMJboFZsOPq5x+n
 Evw22FRytu07vxiOlpqPrM/RV8or3kxqeHsVpJU8N/MkY8bJTBZCvOLycL/WenGa8m7D
 p+vTYXZPe/KepU960jtCrV9oC5oiC3u6W9v43iiWSGmDfDG0uhJxDwQil80/RIVJLJ9x
 zPNsE/TpUBGLL9B5IoDq6huDiYftRT4f/C5iAQ6NPNC+NuqXb1JlHikHys46MJIqguN1
 minA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032613; x=1781637413;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UddDIjGWqVzUF3+xkE4iOnIhAz8+dhzDkVGO8DGPO8I=;
 b=AV/9cgbv2sFsWik5DeRd+qGtEgSPVhzyoFkuMG0n1/6qg0jDWjE+dOQYB7jEI+nHtJ
 k9meKPvEofr8Y7DWh94EJRlMDEm7f5oxlq851rgiOYD7gHH6hn6hgNteq3/y+mfuu9PW
 zG6xInKGhyaj3Cm1YJn9kG7wV+BCt+COAxKK7lURynG5JXxzMVaduBHvuVpTLPZCqg4v
 uACcHcMiibmbTMpJACIpRgwiOQgpgs/IWWfG0ygeUzjEAJUR4Gz8FIyqbWH95HVxspKP
 b8M5DIgTfXoFFyErfUMub9649qh7SCjRff7HR8dY8nYtLrPHeVHM5CgyjdPx6i8Q6JtO
 yyNA==
X-Gm-Message-State: AOJu0Yx873IjeV0ulBlDLEIKa67fNvWQ2lezTPx3nSmQhtTfupw/WM8/
 cgKmMH9JBCCqk7S4ywtAVIjP51Q8eR/BW/v8XaBJB6XN0bjUFXd9QBOi
X-Gm-Gg: Acq92OFE0whtj+ubmEcr4t75OxYSgz9A/TlsKNA7rmbsWZekFvxbtT0OqhwqEWFAxpi
 jL0wHjOJzEXtrSoef+feVb0GFkhmyK/Z+e7skAm16GMQRku6bn0sxFpwAh9lsZ6cDbdSR2GfFFI
 2TDr2DQX2ydTbW7zOJGA1loyb5PK1wMErfXT2KoENaQlj1P/YlJa5QQxNiqTZgYmyGk8ryR4QS5
 +tnK5F7OVMYLIG93qkm9w0j5RBb2k23aUYlwQebg8ZhNUpyLxJ5WqPPYEIDNoBn1GL1IBgkvtDW
 TeDfZxMhR3zRj5Llb/23WwgvymRxZduN6qu1vYeqCw1NO8lGe+IGcFWTwcfDKRN8mF8npDnMajo
 n/Dj4Rby6/hpUcxG03VucZOanszoLqZbpRl3mBUPsOCWPFctLZ3FetpytW4EsDcF4Kw+NPc+x7U
 L60WBejh/ppMZj/P0K6c05ku0IdG3dBr0toMnzfSUhcq4haD1MZmhcQppVdjnB3Q+hEu1G6Kukf
 g==
X-Received: by 2002:a05:600c:4ec6:b0:490:9d1b:201f with SMTP id
 5b1f17b1804b1-490c2629be6mr339149865e9.32.1781032612791; 
 Tue, 09 Jun 2026 12:16:52 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d5d2b4sm336349425e9.2.2026.06.09.12.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:16:52 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 09 Jun 2026 21:16:18 +0200
Subject: [PATCH v7 08/12] ui/console-vc: forward text console size to vc
 chardev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-console-resize-v7-8-0c550fdcec15@gmail.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
In-Reply-To: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781032602; l=1615;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=DHc+lJ6sK+uKzZxifFYM+/fKtfP51y1qRwbMH3sWjuQ=;
 b=Uamv0PlvqH/Zoc5qN/eqL0LbwDD2esEXdjObD1u5t2QANV7j7ot+kDomAfY/tPk9IBlfakGiX
 hrgwO0U+JaXCBvJzvbmXKuwI1fF9GQI/WyFCGyyssikSPov6p+y4rkd
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x336.google.com
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

Update the vc chardev size when initializing the console and after
changing the surface image.

NOTE: There seems to be a bug in the code where the dpy_text_resize
      callback is not called when the size changes due to changing the
      surface image. (Though it doesn't cause any problem in practice
      because the callback is only used by ui/ncurses for fixed
      consoles, whose size never changes.)

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 ui/console-vc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 828e78c41e..d28dc4cdb7 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -115,12 +115,19 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return vt100_input(&s->vt, buf, len);
 }
 
+static void text_console_chr_resize(QemuTextConsole *s)
+{
+    qemu_chr_resize(s->chr, s->vt.width, s->vt.height);
+}
+
 static void text_console_invalidate(void *opaque)
 {
     QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
 
     if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
         vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
+        text_console_chr_resize(s);
+        /* XXX Shouldn't qemu_text_console_update_size() also be called here? */
     }
     vt100_refresh(&s->vt);
 }
@@ -254,6 +261,7 @@ static bool vc_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         s->vt.t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     }
 
+    text_console_chr_resize(s);
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     return true;
 }

-- 
2.54.0


