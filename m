Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0EDD3C907
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTKnU-0006P1-Q8; Wed, 10 Dec 2025 09:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vTKn9-0006HM-CD
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:03:43 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vTKn6-0007Bd-GR
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:03:43 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BAE2tFO028937
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 10 Dec 2025 23:03:11 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=3A4DXdHJmBvqgM829j34cLao+73V+LMP/BCNEzrosy4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:From:Subject:To;
 s=rs20250326; t=1765375391; v=1;
 b=cSKJwypyaP+UsC9aUt4SmfEpD2mgpJoOua1wIAoRuSS0QY3Ss9dWSLUCg0DoFDnV
 IFI0LWSAlA0QLWkAsFEaeTyYdM0DnrE94t3qFUvd5vDDahiLRy/p4FL02yO0bZvR
 nl1lhDJY7Z86yYRg9GOyTqZH1U7kV0Kb/Tz6zGWEiHE9UB1AOXxQvZv83EVclJgO
 7a/Fw/+LLF9aIFDAa0pWKw5KnKn8OSTHsPGYpFigAzPg12Wn3uBvghi7KJKAkDua
 sK9fc/tPHoEVi67hle0Vc08rC/1vxE3ad8opEBRMd6ZyXK7gK+mz/WvEkzDRL5r8
 6GfQjCfBa/EJsbA932W3SQ==
Message-ID: <7cb7db13-4039-4b34-bfc7-79defe425059@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 10 Dec 2025 23:03:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [RFC 03/24] audio/dbus: make "dbus" the default backend when
 using -display dbus
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <20251201112309.4163921-4-marcandre.lureau@redhat.com>
Content-Language: en-US
In-Reply-To: <20251201112309.4163921-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2025/12/01 20:22, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Set "using_dbus_display" during early_dbus_init(), so that we can try to
> create the "dbus" audio backend by default from audio_prio_list.
> 
> This makes dbus audio work by default when using an audio device,
> without having to setup and wire up the -audiodev manually.
> 
> The added FIXME is addressed in the following commits.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.c     |  3 +++
>   audio/dbusaudio.c |  8 +++++++-
>   ui/dbus.c         | 17 +++++++++++++----
>   3 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index 86e674410a..0f992a775c 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -57,6 +57,9 @@
>       that we generate the list.
>   */
>   const char *audio_prio_list[] = {
> +#ifdef CONFIG_GIO
> +    "dbus",
> +#endif
>       "spice",
>       CONFIG_AUDIO_DRIVERS
>       "none",
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index d729a810aa..1fe7c4ed64 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -32,6 +32,7 @@
>   #endif
>   
>   #include "ui/dbus.h"
> +#include "ui/dbus-display.h"
>   #include "ui/dbus-display1.h"
>   
>   #define AUDIO_CAP "dbus"
> @@ -408,8 +409,13 @@ dbus_enable_in(HWVoiceIn *hw, bool enable)
>   static void *
>   dbus_audio_init(Audiodev *dev, Error **errp)
>   {
> -    DBusAudio *da = g_new0(DBusAudio, 1);
> +    DBusAudio *da;
>   
> +    if (!qemu_using_dbus_display(errp)) {
> +        return NULL;
> +    }
> +
> +    da = g_new0(DBusAudio, 1);
>       da->dev = dev;
>       da->out_listeners = g_hash_table_new_full(g_str_hash, g_str_equal,
>                                                   g_free, g_object_unref);
> diff --git a/ui/dbus.c b/ui/dbus.c
> index d2dff33258..45fb3c1aa3 100644
> --- a/ui/dbus.c
> +++ b/ui/dbus.c
> @@ -35,6 +35,7 @@
>   #include "ui/egl-context.h"
>   #endif
>   #include "qemu/audio.h"
> +#include "audio/audio_int.h" /* FIXME: use QOM dynamic cast instead of drv->name */
>   #include "qapi/error.h"
>   #include "trace.h"
>   
> @@ -218,12 +219,20 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
>           return;
>       }
>   
> +    AudioBackend *audio_be = audio_get_default_audio_be(NULL);

Here is a mixed declaration disallowed by docs/devel/style.rst

Regards,
Akihiko Odaki

> +    if (audio_be && !g_str_equal(audio_be->drv->name, "dbus")) {
> +        audio_be = NULL;
> +    }
>       if (dd->audiodev && *dd->audiodev) {
> -        AudioBackend *audio_be = audio_be_by_name(dd->audiodev, errp);
> -        if (!audio_be || !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
> +        audio_be = audio_be_by_name(dd->audiodev, errp);
> +        if (!audio_be) {
>               return;
>           }
>       }
> +    if (audio_be && !audio_be_set_dbus_server(audio_be, dd->server, dd->p2p, errp)) {
> +        return;
> +    }
> +
>   
>       consoles = g_array_new(FALSE, FALSE, sizeof(guint32));
>       for (idx = 0;; idx++) {
> @@ -475,6 +484,8 @@ early_dbus_init(DisplayOptions *opts)
>   #endif
>       }
>   
> +    using_dbus_display = 1;
> +
>       type_register_static(&dbus_vc_type_info);
>   }
>   
> @@ -488,8 +499,6 @@ dbus_init(DisplayState *ds, DisplayOptions *opts)
>           exit(1);
>       }
>   
> -    using_dbus_display = 1;
> -
>       object_new_with_props(TYPE_DBUS_DISPLAY,
>                             object_get_objects_root(),
>                             "dbus-display", &error_fatal,


