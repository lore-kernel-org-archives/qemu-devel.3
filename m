Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9D3F357DB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 07:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9Ic-0001wf-Qu; Wed, 25 Feb 2026 02:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vv9IW-0001wN-Hx
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:27:05 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vv9IS-0003xJ-SD
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 02:27:03 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id CF6E680D2D;
 Wed, 25 Feb 2026 10:26:53 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:55b::1:1] (unknown [2a02:6bf:8080:55b::1:1])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oQbbn77AjqM0-XPtnSQt2; Wed, 25 Feb 2026 10:26:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1772004413;
 bh=LqOGOmjGi8dms2zjSSLd62KSCUTgBWa+JXrkynfUUqE=;
 h=In-Reply-To:Cc:Date:References:To:Subject:From:Message-ID;
 b=arioxiKyG3YkY2lVfK1ZhtFSQIxoSoGI74XmQ7sTAo6nICs5XrGkOnN8qijd98buS
 3ufaFiBR0jV1W0WGp8pL+b6uK+KQLZ91rAS7ZMjCYJMqAeHUFb/1DOuAbNywLxS0JC
 UGCUrJ+OQGdVenISdUqTxdWEUfZjOPt2SH2uoomI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Message-ID: <db7e4629-c00e-4fd6-bd3d-85f6a2eae835@yandex-team.com>
Date: Wed, 25 Feb 2026 12:26:50 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergei Heifetz <heifetz@yandex-team.com>
Subject: Re: [PATCH v2 02/10] ui/vnc: disable audio feature when configured
 with --disable-audio
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-3-heifetz@yandex-team.com>
 <CAJ+F1CJGk_ejDAd066KE1Q_WHn3tjyw2d9xpcCJE1SZL2oA9sw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJ+F1CJGk_ejDAd066KE1Q_WHn3tjyw2d9xpcCJE1SZL2oA9sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi, Marc-André.

On 2/24/26 16:05, Marc-André Lureau wrote:
> Hi
>
> On Mon, Feb 23, 2026 at 9:26 PM Sergei Heifetz<heifetz@yandex-team.com> wrote:
>> Disable the audio feature in VNC when QEMU is configured with
>> `--disable-audio`. Do not compile the corresponding audio-related
>> code.
> Users will have to call query-command-line-options to figure out if
> audio support was disabled. Since this is an optional build option, I
> don't know if we treat it as a breaking change.

1. I don’t think it makes sense to treat this as a breaking change, 
because it’s impossible that anything would break after an update unless 
QEMU has been deliberately reconfigured with `--disable-audio`. If it 
has, then the consequences are expected.

2. More importantly, I think it should be assumed that a client can 
handle the situation where QEMU does not support the audio feature.

See this excerpt from Section 6 of the RFB protocol specification (RFC 
6143):

"A server that does not support the extension will simply ignore the 
pseudo-encoding. Note that this means the client must assume that the 
server does not support the extension until it gets some 
extension-specific confirmation from the server."

In QEMU, use of the audio feature is requested by the client by adding 
VNC_ENCODING_AUDIO to a SetEncodings message. For confirmation, there is 
a send_ext_audio_ack function that sends a FrameBufferUpdate message to 
the client with VNC_ENCODING_AUDIO. The VNCDoTool (0.8.0) documentation, 
for example, explicitly says that this is used as confirmation for the 
relevant custom feature (see 1.7.4.12, "QEMU Client Message"):

"This message may only be sent if the client has previously received a 
FrameBufferUpdate that confirms support for the intended submessage-type 
[...]" (where the submessage type is "Audio" in our case).

With this patch, the audio feature is disabled in a way that makes a 
QEMU server behave like a non-QEMU server (as far as audio is 
concerned). The client sends the audio pseudo-encoding, but the server 
does not respond with confirmation, because send_ext_audio_ack is now 
behind an #ifdef. A well-behaved client should handle this accordingly 
and continue using VNC without sending any audio-related messages to the 
server. If a client misbehaves and sends VNC_MSG_CLIENT_QEMU_AUDIO while 
the audio feature is disabled, the server will close the connection with 
an error.

Also note that the behaviour described above is already present when 
there is no audiodev (`vs->vd->audio_be` is NULL).

>> Signed-off-by: Sergei Heifetz<heifetz@yandex-team.com>
>> ---
>>   ui/vnc.c | 31 ++++++++++++++++++++++++++++---
>>   1 file changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index daf5b01d34..e6b6a9f4f9 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -1072,6 +1072,7 @@ static void vnc_update_throttle_offset(VncState *vs)
>>       size_t offset =
>>           vs->client_width * vs->client_height * vs->client_pf.bytes_per_pixel;
>>
>> +#ifdef CONFIG_AUDIO
>>       if (vs->audio_cap) {
>>           int bps;
>>           switch (vs->as.fmt) {
>> @@ -1091,6 +1092,7 @@ static void vnc_update_throttle_offset(VncState *vs)
>>           }
>>           offset += vs->as.freq * bps * vs->as.nchannels;
>>       }
>> +#endif
>>
>>       /* Put a floor of 1MB on offset, so that if we have a large pending
>>        * buffer and the display is resized to a small size & back again
>> @@ -1214,6 +1216,7 @@ static int vnc_update_client(VncState *vs, int has_dirty)
>>       return n;
>>   }
>>
>> +#ifdef CONFIG_AUDIO
>>   /* audio */
>>   static void audio_capture_notify(void *opaque, audcnotification_e cmd)
>>   {
>> @@ -1293,6 +1296,7 @@ static void audio_del(VncState *vs)
>>           vs->audio_cap = NULL;
>>       }
>>   }
>> +#endif
>>
>>   static void vnc_disconnect_start(VncState *vs)
>>   {
>> @@ -1332,7 +1336,9 @@ void vnc_disconnect_finish(VncState *vs)
>>   #ifdef CONFIG_VNC_SASL
>>       vnc_sasl_client_cleanup(vs);
>>   #endif /* CONFIG_VNC_SASL */
>> +#ifdef CONFIG_AUDIO
>>       audio_del(vs);
>> +#endif
>>       qkbd_state_lift_all_keys(vs->vd->kbd);
>>
>>       if (vs->mouse_mode_notifier.notify != NULL) {
>> @@ -2097,6 +2103,7 @@ static void send_ext_key_event_ack(VncState *vs)
>>       vnc_flush(vs);
>>   }
>>
>> +#ifdef CONFIG_AUDIO
>>   static void send_ext_audio_ack(VncState *vs)
>>   {
>>       vnc_lock_output(vs);
>> @@ -2110,6 +2117,7 @@ static void send_ext_audio_ack(VncState *vs)
>>       vnc_unlock_output(vs);
>>       vnc_flush(vs);
>>   }
>> +#endif
>>
>>   static void send_xvp_message(VncState *vs, int code)
>>   {
>> @@ -2197,10 +2205,15 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
>>               send_ext_key_event_ack(vs);
>>               break;
>>           case VNC_ENCODING_AUDIO:
>> +#ifdef CONFIG_AUDIO
>>               if (vs->vd->audio_be) {
>>                   vnc_set_feature(vs, VNC_FEATURE_AUDIO);
>>                   send_ext_audio_ack(vs);
>>               }
>> +#else
>> +            VNC_DEBUG("Audio encoding received with audio subsystem "
>> +                      "disabled\n");
>> +#endif
>>               break;
>>           case VNC_ENCODING_WMVi:
>>               vnc_set_feature(vs, VNC_FEATURE_WMVI);
>> @@ -2394,7 +2407,9 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
>>   {
>>       int i;
>>       uint16_t limit;
>> -    uint32_t freq;
>> +    #ifdef CONFIG_AUDIO
>> +        uint32_t freq;
>> +    #endif
> Indentation is off
Oh. I'll fix it.
>>       VncDisplay *vd = vs->vd;
>>
>>       if (data[0] > 3) {
>> @@ -2571,7 +2586,9 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
>>                   vnc_client_error(vs);
>>                   break;
>>               }
>> -
>> +#ifndef CONFIG_AUDIO
>> +            abort();
> I'd keep the if AUDIO case first, for consistency
Sure.
>> +#else
>>               if (len == 2)
>>                   return 4;
>>
>> @@ -2626,7 +2643,7 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
>>                   break;
>>               }
>>               break;
>> -
>> +#endif
>>           default:
>>               VNC_DEBUG("Msg: %d\n", read_u16(data, 0));
>>               vnc_client_error(vs);
>> @@ -3369,10 +3386,12 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
>>       vs->last_x = -1;
>>       vs->last_y = -1;
>>
>> +#ifdef CONFIG_AUDIO
>>       vs->as.freq = 44100;
>>       vs->as.nchannels = 2;
>>       vs->as.fmt = AUDIO_FORMAT_S16;
>>       vs->as.big_endian = false;
>> +#endif
>>
>>       qemu_mutex_init(&vs->output_mutex);
>>       vs->bh = qemu_bh_new(vnc_jobs_bh, vs);
>> @@ -3645,9 +3664,11 @@ static QemuOptsList qemu_vnc_opts = {
>>           },{
>>               .name = "non-adaptive",
>>               .type = QEMU_OPT_BOOL,
>> +#ifdef CONFIG_AUDIO
>>           },{
>>               .name = "audiodev",
>>               .type = QEMU_OPT_STRING,
>> +#endif
>>           },{
>>               .name = "power-control",
>>               .type = QEMU_OPT_BOOL,
>> @@ -4080,7 +4101,9 @@ void vnc_display_open(const char *id, Error **errp)
>>       const char *saslauthz;
>>       int lock_key_sync = 1;
>>       int key_delay_ms;
>> +#ifdef CONFIG_AUDIO
>>       const char *audiodev;
>> +#endif
>>       const char *passwordSecret;
>>
>>       if (!vd) {
>> @@ -4238,6 +4261,7 @@ void vnc_display_open(const char *id, Error **errp)
>>       }
>>       vd->ledstate = 0;
>>
>> +#ifdef CONFIG_AUDIO
>>       audiodev = qemu_opt_get(opts, "audiodev");
>>       if (audiodev) {
>>           vd->audio_be = audio_be_by_name(audiodev, errp);
>> @@ -4247,6 +4271,7 @@ void vnc_display_open(const char *id, Error **errp)
>>       } else {
>>           vd->audio_be = audio_get_default_audio_be(NULL);
>>       }
>> +#endif
>>
>>       device_id = qemu_opt_get(opts, "display");
>>       if (device_id) {
>> --
>> 2.34.1
>>
>>
> --
> Marc-André Lureau

