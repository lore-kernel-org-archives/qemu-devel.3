Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484B5E81A2C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 14:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrzhp-0000wu-GP; Mon, 16 Feb 2026 09:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrzhn-0000wN-Jq; Mon, 16 Feb 2026 09:36:07 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrzhi-0000p7-1c; Mon, 16 Feb 2026 09:36:07 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 001985969FF;
 Mon, 16 Feb 2026 15:35:55 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ml2rD5Ez90TX; Mon, 16 Feb 2026 15:35:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C8D735969F1; Mon, 16 Feb 2026 15:35:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C42525969FD;
 Mon, 16 Feb 2026 15:35:53 +0100 (CET)
Date: Mon, 16 Feb 2026 15:35:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH 42/85] audio/dbus: convert to QOM lifecycle methods
In-Reply-To: <CAMxuvawVZm60+KE5bOAphvYPSTZcKuEgYd_r1jt6J0oPvTSqdw@mail.gmail.com>
Message-ID: <0a30b17a-e5ef-8e42-66b2-614fcdaf5c0c@eik.bme.hu>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
 <20260216-audio-v1-42-e676662e4514@redhat.com>
 <ed0bd069-0660-b195-b639-b0ce7717ea36@eik.bme.hu>
 <CAMxuvawVZm60+KE5bOAphvYPSTZcKuEgYd_r1jt6J0oPvTSqdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1276271257-1771252553=:34635"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1276271257-1771252553=:34635
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 16 Feb 2026, Marc-André Lureau wrote:
> On Mon, Feb 16, 2026 at 1:15 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Mon, 16 Feb 2026, Marc-André Lureau wrote:
>>> Migrate the D-Bus audio backend from the legacy driver init/fini
>>> callbacks to proper QOM realize and finalize methods.
>>>
>>> The DBusAudio struct fields are now embedded directly in the AudioDbus
>>> QOM object instead of being allocated separately as drv_opaque. This
>>> allows accessing the backend state through proper QOM type casting
>>> with AUDIO_DBUS() rather than casting drv_opaque pointers.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>> ---
>>> audio/dbusaudio.c | 76 ++++++++++++++++++++++++++++---------------------------
>>> 1 file changed, 39 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
>>> index 269db7877b6..fb059815de9 100644
>>> --- a/audio/dbusaudio.c
>>> +++ b/audio/dbusaudio.c
>>> @@ -48,21 +48,20 @@
>>> #define TYPE_AUDIO_DBUS "audio-dbus"
>>> OBJECT_DECLARE_SIMPLE_TYPE(AudioDbus, AUDIO_DBUS)
>>>
>>> +static AudioBackendClass *audio_dbus_parent_class;
>>> +
>>> struct AudioDbus {
>>>     AudioMixengBackend parent_obj;
>>> -};
>>> -
>>> -static struct audio_driver dbus_audio_driver;
>>>
>>> -typedef struct DBusAudio {
>>> -    Audiodev *dev;
>>>     GDBusObjectManagerServer *server;
>>>     bool p2p;
>>>     GDBusObjectSkeleton *audio;
>>>     QemuDBusDisplay1Audio *iface;
>>>     GHashTable *out_listeners;
>>>     GHashTable *in_listeners;
>>> -} DBusAudio;
>>> +};
>>> +
>>> +static struct audio_driver dbus_audio_driver;
>>>
>>> typedef struct DBusVoiceOut {
>>>     HWVoiceOut hw;
>>> @@ -105,7 +104,7 @@ static void *dbus_get_buffer_out(HWVoiceOut *hw, size_t *size)
>>>
>>> static size_t dbus_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
>>> {
>>> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
>>> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>>>     DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>>>     GHashTableIter iter;
>>>     QemuDBusDisplay1AudioOutListener *listener = NULL;
>>> @@ -162,9 +161,9 @@ dbus_init_out_listener(QemuDBusDisplay1AudioOutListener *listener,
>>> }
>>>
>>> static guint
>>> -dbus_audio_get_nsamples(DBusAudio *da)
>>> +dbus_audio_get_nsamples(AudioDbus *da)
>>> {
>>> -    AudiodevDBusOptions *opts = &da->dev->u.dbus;
>>> +    AudiodevDBusOptions *opts = &AUDIO_MIXENG_BACKEND(da)->dev->u.dbus;
>>>
>>>     if (opts->has_nsamples && opts->nsamples) {
>>>         return opts->nsamples;
>>> @@ -176,7 +175,7 @@ dbus_audio_get_nsamples(DBusAudio *da)
>>> static int
>>> dbus_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
>>> {
>>> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
>>> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>>>     DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>>>     GHashTableIter iter;
>>>     QemuDBusDisplay1AudioOutListener *listener = NULL;
>>> @@ -195,7 +194,7 @@ dbus_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
>>> static void
>>> dbus_fini_out(HWVoiceOut *hw)
>>> {
>>> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
>>> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>>>     DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>>>     GHashTableIter iter;
>>>     QemuDBusDisplay1AudioOutListener *listener = NULL;
>>> @@ -214,7 +213,7 @@ dbus_fini_out(HWVoiceOut *hw)
>>> static void
>>> dbus_enable_out(HWVoiceOut *hw, bool enable)
>>> {
>>> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
>>> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>>>     DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>>>     GHashTableIter iter;
>>>     QemuDBusDisplay1AudioOutListener *listener = NULL;
>>> @@ -256,7 +255,7 @@ dbus_volume_out_listener(HWVoiceOut *hw,
>>> static void
>>> dbus_volume_out(HWVoiceOut *hw, Volume *vol)
>>> {
>>> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
>>> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>>>     DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>>>     GHashTableIter iter;
>>>     QemuDBusDisplay1AudioOutListener *listener = NULL;
>>> @@ -290,7 +289,7 @@ dbus_init_in_listener(QemuDBusDisplay1AudioInListener *listener, HWVoiceIn *hw)
>>> static int
>>> dbus_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>>> {
>>> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
>>> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>>>     DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw);
>>>     GHashTableIter iter;
>>>     QemuDBusDisplay1AudioInListener *listener = NULL;
>>> @@ -309,7 +308,7 @@ dbus_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>>> static void
>>> dbus_fini_in(HWVoiceIn *hw)
>>> {
>>> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
>>> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>>>     GHashTableIter iter;
>>>     QemuDBusDisplay1AudioInListener *listener = NULL;
>>>
>>> @@ -346,7 +345,7 @@ dbus_volume_in_listener(HWVoiceIn *hw,
>>> static void
>>> dbus_volume_in(HWVoiceIn *hw, Volume *vol)
>>> {
>>> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
>>> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>>>     DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw);
>>>     GHashTableIter iter;
>>>     QemuDBusDisplay1AudioInListener *listener = NULL;
>>> @@ -363,7 +362,7 @@ dbus_volume_in(HWVoiceIn *hw, Volume *vol)
>>> static size_t
>>> dbus_read(HWVoiceIn *hw, void *buf, size_t size)
>>> {
>>> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
>>> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>>>     /* DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw); */
>>>     GHashTableIter iter;
>>>     QemuDBusDisplay1AudioInListener *listener = NULL;
>>> @@ -398,7 +397,7 @@ dbus_read(HWVoiceIn *hw, void *buf, size_t size)
>>> static void
>>> dbus_enable_in(HWVoiceIn *hw, bool enable)
>>> {
>>> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
>>> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>>
>> Are you sure we need a QOM cast in all these potentially frequently called
>> functions? The QOM cast is kind of expensive so only needed if it can get
>> other objects than the expected. If the object is already checked in
>> realize with a QOM cast it may not be needed to check it again every time
>> it's accessed.
>
> I would not be concerned if the check is done every 20ms or even 5ms.
> (and with --disable-qom-cast-debug it should also help).
>
> If you want, I can look at providing some perf data, but I am afraid
> it will be just noise difference.

Since --disable-qom-cast-debug is not the default this does not help as 
likely nobody will have it disabled. I don't use dbus and other audio 
backends don't seem to have this so I don't care too much but this is like 
using unnecessary QOM casts in iomem callbacks that take an already 
checked parameter so a C cast should be OK here too (iomem callbacks have 
void *opaque so those don't need an explicit cast). But dbus audio is your 
area so whatever you prefer.

Regards,
BALATON Zoltan
--3866299591-1276271257-1771252553=:34635--

