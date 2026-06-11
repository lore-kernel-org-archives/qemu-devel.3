Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F848CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXaLL-00012F-J3; Thu, 11 Jun 2026 04:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXaL4-00011K-NZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:00:41 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXaL1-0006HP-R3
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:00:34 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65B80FiG065358
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Jun 2026 17:00:15 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=XW1oDzGPXi7G7zwEZfE6ETrCF18nvlfS4AofqaGTE5Q=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781164816; v=1;
 b=fZfv+Be98QTkie0hQjRrFHve1JHedriPXHR2sVGiEqgTU38+KxxPoKVEKYbL/iDY
 UNota/9ED6aUQBNwZBUh22AClG01o8OROgqbj2eBwJCyUlHaG8/uWl8giqp877Kq
 I2LGsCmiTQQfaVqPWvDUVrL+G2Y2ZYMYiaESoSv3W6qHof439cRH3kVkGRA5g2pp
 EFf1VL+c4essOfSL6NYTr4PwNPe46a2gH85dPG0a/ox3A+gIZLFLYEi8GCO2vF2O
 4oABEeIMl14BXX9FbaQBI1dWMmQIqdBcids8aLZAiJV4VzWNRRNwfl3nWPD6hvo8
 l60inXiqdpQ7GlIccSD1Tw==
Message-ID: <bf524c77-f300-4ec3-867a-e3a6882c72e0@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Jun 2026 17:00:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/33] ui/dbus: remove led handler
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
 <20260608-b4-ui-v2-8-9ea6355ea08f@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260608-b4-ui-v2-8-9ea6355ea08f@redhat.com>
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
> Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-console.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> index 0813a08f85e..f784ccbe572 100644
> --- a/ui/dbus-console.c
> +++ b/ui/dbus-console.c
> @@ -53,6 +53,7 @@ struct _DBusDisplayConsole {
>       guint last_x;
>       guint last_y;
>       Notifier mouse_mode_notifier;
> +    QEMUPutLEDEntry *kbd_leds_updated;
>   };
>   
>   G_DEFINE_TYPE(DBusDisplayConsole,
> @@ -152,6 +153,7 @@ dbus_display_console_dispose(GObject *object)
>   
>       qemu_console_unregister_listener(&ddc->dcl);
>       qemu_remove_mouse_mode_change_notifier(&ddc->mouse_mode_notifier);
> +    qemu_remove_led_event_handler(ddc->kbd_leds_updated);

It is better to avoid call qemu_remove_led_event_handler() here because 
GObject.ObjectClass.dispose is documented as it may be run multiple 
times and qemu_remove_led_event_handler() will cause double free if that 
happens.

Regards,
Akihiko Odaki

>       g_clear_object(&ddc->iface_touch);
>       g_clear_object(&ddc->iface_mouse);
>       g_clear_object(&ddc->iface_kbd);
> @@ -578,7 +580,8 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
>   
>       ddc->kbd = qkbd_state_init(con);
>       ddc->iface_kbd = qemu_dbus_display1_keyboard_skeleton_new();
> -    qemu_add_led_event_handler(dbus_kbd_qemu_leds_updated, ddc);
> +    ddc->kbd_leds_updated = qemu_add_led_event_handler(
> +        dbus_kbd_qemu_leds_updated, ddc);
>       g_object_connect(ddc->iface_kbd,
>           "swapped-signal::handle-press", dbus_kbd_press, ddc,
>           "swapped-signal::handle-release", dbus_kbd_release, ddc,
> 


