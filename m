Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C250E7BDA9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 12:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrxVx-0002xG-Jq; Mon, 16 Feb 2026 07:15:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrxVp-0002wF-I6; Mon, 16 Feb 2026 07:15:37 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrxVm-0005eP-8y; Mon, 16 Feb 2026 07:15:37 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E6A25596A0A;
 Mon, 16 Feb 2026 13:15:28 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id ZBtLe7_lWQxm; Mon, 16 Feb 2026 13:15:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CA3F55969FF; Mon, 16 Feb 2026 13:15:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C79D55969F6;
 Mon, 16 Feb 2026 13:15:26 +0100 (CET)
Date: Mon, 16 Feb 2026 13:15:26 +0100 (CET)
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
In-Reply-To: <20260216-audio-v1-42-e676662e4514@redhat.com>
Message-ID: <ed0bd069-0660-b195-b639-b0ce7717ea36@eik.bme.hu>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
 <20260216-audio-v1-42-e676662e4514@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1233897087-1771244126=:82144"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-1233897087-1771244126=:82144
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 16 Feb 2026, Marc-André Lureau wrote:
> Migrate the D-Bus audio backend from the legacy driver init/fini
> callbacks to proper QOM realize and finalize methods.
>
> The DBusAudio struct fields are now embedded directly in the AudioDbus
> QOM object instead of being allocated separately as drv_opaque. This
> allows accessing the backend state through proper QOM type casting
> with AUDIO_DBUS() rather than casting drv_opaque pointers.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
> audio/dbusaudio.c | 76 ++++++++++++++++++++++++++++---------------------------
> 1 file changed, 39 insertions(+), 37 deletions(-)
>
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index 269db7877b6..fb059815de9 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -48,21 +48,20 @@
> #define TYPE_AUDIO_DBUS "audio-dbus"
> OBJECT_DECLARE_SIMPLE_TYPE(AudioDbus, AUDIO_DBUS)
>
> +static AudioBackendClass *audio_dbus_parent_class;
> +
> struct AudioDbus {
>     AudioMixengBackend parent_obj;
> -};
> -
> -static struct audio_driver dbus_audio_driver;
>
> -typedef struct DBusAudio {
> -    Audiodev *dev;
>     GDBusObjectManagerServer *server;
>     bool p2p;
>     GDBusObjectSkeleton *audio;
>     QemuDBusDisplay1Audio *iface;
>     GHashTable *out_listeners;
>     GHashTable *in_listeners;
> -} DBusAudio;
> +};
> +
> +static struct audio_driver dbus_audio_driver;
>
> typedef struct DBusVoiceOut {
>     HWVoiceOut hw;
> @@ -105,7 +104,7 @@ static void *dbus_get_buffer_out(HWVoiceOut *hw, size_t *size)
>
> static size_t dbus_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
> {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>     DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>     GHashTableIter iter;
>     QemuDBusDisplay1AudioOutListener *listener = NULL;
> @@ -162,9 +161,9 @@ dbus_init_out_listener(QemuDBusDisplay1AudioOutListener *listener,
> }
>
> static guint
> -dbus_audio_get_nsamples(DBusAudio *da)
> +dbus_audio_get_nsamples(AudioDbus *da)
> {
> -    AudiodevDBusOptions *opts = &da->dev->u.dbus;
> +    AudiodevDBusOptions *opts = &AUDIO_MIXENG_BACKEND(da)->dev->u.dbus;
>
>     if (opts->has_nsamples && opts->nsamples) {
>         return opts->nsamples;
> @@ -176,7 +175,7 @@ dbus_audio_get_nsamples(DBusAudio *da)
> static int
> dbus_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
> {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>     DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>     GHashTableIter iter;
>     QemuDBusDisplay1AudioOutListener *listener = NULL;
> @@ -195,7 +194,7 @@ dbus_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
> static void
> dbus_fini_out(HWVoiceOut *hw)
> {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>     DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>     GHashTableIter iter;
>     QemuDBusDisplay1AudioOutListener *listener = NULL;
> @@ -214,7 +213,7 @@ dbus_fini_out(HWVoiceOut *hw)
> static void
> dbus_enable_out(HWVoiceOut *hw, bool enable)
> {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>     DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>     GHashTableIter iter;
>     QemuDBusDisplay1AudioOutListener *listener = NULL;
> @@ -256,7 +255,7 @@ dbus_volume_out_listener(HWVoiceOut *hw,
> static void
> dbus_volume_out(HWVoiceOut *hw, Volume *vol)
> {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>     DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
>     GHashTableIter iter;
>     QemuDBusDisplay1AudioOutListener *listener = NULL;
> @@ -290,7 +289,7 @@ dbus_init_in_listener(QemuDBusDisplay1AudioInListener *listener, HWVoiceIn *hw)
> static int
> dbus_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
> {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>     DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw);
>     GHashTableIter iter;
>     QemuDBusDisplay1AudioInListener *listener = NULL;
> @@ -309,7 +308,7 @@ dbus_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
> static void
> dbus_fini_in(HWVoiceIn *hw)
> {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>     GHashTableIter iter;
>     QemuDBusDisplay1AudioInListener *listener = NULL;
>
> @@ -346,7 +345,7 @@ dbus_volume_in_listener(HWVoiceIn *hw,
> static void
> dbus_volume_in(HWVoiceIn *hw, Volume *vol)
> {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>     DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw);
>     GHashTableIter iter;
>     QemuDBusDisplay1AudioInListener *listener = NULL;
> @@ -363,7 +362,7 @@ dbus_volume_in(HWVoiceIn *hw, Volume *vol)
> static size_t
> dbus_read(HWVoiceIn *hw, void *buf, size_t size)
> {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);
>     /* DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw); */
>     GHashTableIter iter;
>     QemuDBusDisplay1AudioInListener *listener = NULL;
> @@ -398,7 +397,7 @@ dbus_read(HWVoiceIn *hw, void *buf, size_t size)
> static void
> dbus_enable_in(HWVoiceIn *hw, bool enable)
> {
> -    DBusAudio *da = (DBusAudio *)hw->s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(hw->s);

Are you sure we need a QOM cast in all these potentially frequently called 
functions? The QOM cast is kind of expensive so only needed if it can get 
other objects than the expected. If the object is already checked in 
realize with a QOM cast it may not be needed to check it again every time 
it's accessed.

Regards,
BALATON Zoltan

>     DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw);
>     GHashTableIter iter;
>     QemuDBusDisplay1AudioInListener *listener = NULL;
> @@ -416,28 +415,31 @@ dbus_enable_in(HWVoiceIn *hw, bool enable)
>     }
> }
>
> -static void *
> -dbus_audio_init(Audiodev *dev, Error **errp)
> +static bool
> +audio_dbus_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
> {
> -    DBusAudio *da;
> +    AudioDbus *da = AUDIO_DBUS(abe);
>
>     if (!qemu_using_dbus_display(errp)) {
> -        return NULL;
> +        qapi_free_Audiodev(dev);
> +        return false;
> +    }
> +
> +    if (!audio_dbus_parent_class->realize(abe, dev, errp)) {
> +        return false;
>     }
>
> -    da = g_new0(DBusAudio, 1);
> -    da->dev = dev;
>     da->out_listeners = g_hash_table_new_full(g_str_hash, g_str_equal,
> -                                                g_free, g_object_unref);
> +                                              g_free, g_object_unref);
>     da->in_listeners = g_hash_table_new_full(g_str_hash, g_str_equal,
> -                                               g_free, g_object_unref);
> -    return da;
> +                                             g_free, g_object_unref);
> +    return true;
> }
>
> static void
> -dbus_audio_fini(void *opaque)
> +audio_dbus_finalize(Object *obj)
> {
> -    DBusAudio *da = opaque;
> +    AudioDbus *da = AUDIO_DBUS(obj);
>
>     if (da->server) {
>         g_dbus_object_manager_server_unexport(da->server,
> @@ -448,14 +450,13 @@ dbus_audio_fini(void *opaque)
>     g_clear_pointer(&da->in_listeners, g_hash_table_unref);
>     g_clear_pointer(&da->out_listeners, g_hash_table_unref);
>     g_clear_object(&da->server);
> -    g_free(da);
> }
>
> static void
> listener_out_vanished_cb(GDBusConnection *connection,
>                          gboolean remote_peer_vanished,
>                          GError *error,
> -                         DBusAudio *da)
> +                         AudioDbus *da)
> {
>     char *name = g_object_get_data(G_OBJECT(connection), "name");
>
> @@ -466,7 +467,7 @@ static void
> listener_in_vanished_cb(GDBusConnection *connection,
>                         gboolean remote_peer_vanished,
>                         GError *error,
> -                        DBusAudio *da)
> +                        AudioDbus *da)
> {
>     char *name = g_object_get_data(G_OBJECT(connection), "name");
>
> @@ -482,7 +483,7 @@ dbus_audio_register_listener(AudioMixengBackend *s,
>                              GVariant *arg_listener,
>                              bool out)
> {
> -    DBusAudio *da = s->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(s);
>     const char *sender =
>         da->p2p ? "p2p" : g_dbus_method_invocation_get_sender(invocation);
>     g_autoptr(GDBusConnection) listener_conn = NULL;
> @@ -667,9 +668,8 @@ dbus_audio_set_server(AudioBackend *s,
>                       bool p2p,
>                       Error **errp)
> {
> -    DBusAudio *da = AUDIO_MIXENG_BACKEND(s)->drv_opaque;
> +    AudioDbus *da = AUDIO_DBUS(s);
>
> -    g_assert(da);
>     g_assert(!da->server);
>
>     da->server = g_object_ref(server);
> @@ -711,8 +711,6 @@ static struct audio_pcm_ops dbus_pcm_ops = {
>
> static struct audio_driver dbus_audio_driver = {
>     .name            = "dbus",
> -    .init            = dbus_audio_init,
> -    .fini            = dbus_audio_fini,
>     .pcm_ops         = &dbus_pcm_ops,
>     .max_voices_out  = INT_MAX,
>     .max_voices_in   = INT_MAX,
> @@ -725,6 +723,9 @@ static void audio_dbus_class_init(ObjectClass *klass, const void *data)
>     AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
>     AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
>
> +    audio_dbus_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
> +
> +    b->realize = audio_dbus_realize;
>     b->set_dbus_server = dbus_audio_set_server;
>     k->driver = &dbus_audio_driver;
> }
> @@ -734,6 +735,7 @@ static const TypeInfo audio_types[] = {
>         .name = TYPE_AUDIO_DBUS,
>         .parent = TYPE_AUDIO_MIXENG_BACKEND,
>         .instance_size = sizeof(AudioDbus),
> +        .instance_finalize = audio_dbus_finalize,
>         .class_init = audio_dbus_class_init,
>     },
> };
>
>
--3866299591-1233897087-1771244126=:82144--

