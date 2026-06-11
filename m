Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B8CCD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXaH5-0007Zx-4f; Thu, 11 Jun 2026 03:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXaH3-0007Z8-Sh
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 03:56:25 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXaH2-0004K6-1L
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 03:56:25 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65B7uARf063713
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Jun 2026 16:56:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=bRIQvu8nvfrQyv85hqgel75sgyXN3tH+ywLO/kw4iro=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781164571; v=1;
 b=Pe1qUDTlj3UQoN7zitU5fKp+Wy4t3bbCgjsAMFynhovTOugVP7ek1e2k+Ni0i0hf
 tcb7NIRWTCC17CMiTrLC2cPPT6lBuBBlHdjJ9K2ibOgemYWq+nnOSCLgycy/Wr5B
 vp8g2iqdgsb/Zh/0IB6fmhN3hOqikTz8MLr8PnA9A5dpfdcOGPLDt7QueCa+Yxrh
 VPjHcUx6Us4PPKbNADu5Jeyu5FHxhPqfxEvLMj9NBbaIX3BZxMlkW4lnkMNFGqsc
 QVPPGNGiDrUF+ShNZ6SYMWv/fk04vjGU/Dp9EuFBuLu1qTUfiDDEHp6vonsElz/j
 psDaCbcOcUnQtYpI7BYoHA==
Message-ID: <a75178b2-de9d-4c63-89c6-74938ea13fa4@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Jun 2026 16:56:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/33] ui/gtk: implement display cleanup
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
 <20260608-b4-ui-v2-21-9ea6355ea08f@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260608-b4-ui-v2-21-9ea6355ea08f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/08 16:16, Marc-André Lureau wrote:
> Add gtk_display_cleanup() to properly tear down GTK display state:
> remove console and mouse notifiers, unregister clipboard peer,
> destroy the main window and virtual consoles.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/gtk.h   |  1 +
>   ui/gtk-clipboard.c | 15 +++++++++++++++
>   ui/gtk.c           | 18 ++++++++++++++++++
>   3 files changed, 34 insertions(+)
> 
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> index 3e6ce3cb48c..5156a049509 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -225,6 +225,7 @@ int gd_gl_area_make_current(DisplayGLCtx *dgc,
>   
>   /* gtk-clipboard.c */
>   void gd_clipboard_init(GtkDisplayState *gd);
> +void gd_clipboard_cleanup(GtkDisplayState *gd);
>   
>   void gd_update_scale(VirtualConsole *vc, int ww, int wh, int fbw, int fbh);
>   
> diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
> index ea9444be70f..476e6b8303c 100644
> --- a/ui/gtk-clipboard.c
> +++ b/ui/gtk-clipboard.c
> @@ -235,3 +235,18 @@ void gd_clipboard_init(GtkDisplayState *gd)
>       g_signal_connect(gd->gtkcb[QEMU_CLIPBOARD_SELECTION_SECONDARY],
>                        "owner-change", G_CALLBACK(gd_owner_change), gd);
>   }
> +
> +void gd_clipboard_cleanup(GtkDisplayState *gd)
> +{
> +    if (!gd->cbpeer.name) {
> +        return;
> +    }
> +    qemu_clipboard_peer_unregister(&gd->cbpeer);
> +    g_signal_handlers_disconnect_by_data(
> +        gd->gtkcb[QEMU_CLIPBOARD_SELECTION_CLIPBOARD], gd);
> +    g_signal_handlers_disconnect_by_data(
> +        gd->gtkcb[QEMU_CLIPBOARD_SELECTION_PRIMARY], gd);
> +    g_signal_handlers_disconnect_by_data(
> +        gd->gtkcb[QEMU_CLIPBOARD_SELECTION_SECONDARY], gd);
> +    gd->cbpeer.name = NULL;
> +}
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 2ee826b56fb..c26dc83ac3e 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -2505,6 +2505,7 @@ static void gd_create_menus(GtkDisplayState *s, DisplayOptions *opts)
>   }
>   
>   
> +static GtkDisplayState *gtk_display_state;
>   static gboolean gtkinit;
>   
>   static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
> @@ -2523,6 +2524,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
>       }
>       assert(opts->type == DISPLAY_TYPE_GTK);
>       s = g_malloc0(sizeof(*s));
> +    gtk_display_state = s;
>       s->opts = opts;
>   
>       theme = gtk_icon_theme_get_default();
> @@ -2681,10 +2683,26 @@ static void early_gtk_display_init(DisplayOptions *opts)
>   #endif
>   }
>   
> +static void gtk_display_cleanup(void)
> +{
> +    GtkDisplayState *s = gtk_display_state;
> +
> +    if (!s) {
> +        return;
> +    }
> +
> +    qemu_remove_mouse_mode_change_notifier(&s->mouse_mode_notifier);

qemu_del_vm_change_state_handler() should be called too.

Regards,
Akihiko Odaki

> +    gd_clipboard_cleanup(s);
> +    g_clear_pointer(&s->window, gtk_widget_destroy);
> +    g_clear_object(&s->null_cursor);
> +    g_clear_pointer(&gtk_display_state, g_free);
> +}
> +
>   static QemuDisplay qemu_display_gtk = {
>       .type       = DISPLAY_TYPE_GTK,
>       .early_init = early_gtk_display_init,
>       .init       = gtk_display_init,
> +    .cleanup    = gtk_display_cleanup,
>       .vc         = "vc",
>   };
>   
> 

