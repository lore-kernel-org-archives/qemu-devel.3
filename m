Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7266C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 10:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGVb-00082X-DE; Fri, 24 Jan 2025 05:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tbGVZ-00081Y-9C
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:01:49 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tbGVW-0005x6-AJ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 05:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Jqq/A/enDG12Jkd1jP7uQGE8zLclAMX1Qz7fOp1gaOk=; b=m+EZ0PlQK4uKuV78JciCu8aaUc
 GXGPZJAiSVikw27LIjdmRKV8fCZ9nvKxCgaQTr4PjTCO279hwFLM1n6AmEFnV+Ro7SVOmIP6srF1Q
 AMoqgW7P2lc0Re9w6KPnIAcqrSTdNWWa3u03ZFe6OZBK670qRewe+fLLJO3oX8bh/L6uQh7jcKYyN
 F6bNWSNeESqpBOlxfYRly/VOyNOOn/Sb0FQwa1ktHhi6MeMyL+1kvnANNwQdF2jiYQilmecYyJwwn
 WVXBWAje+OzZ5z0nXax1Whx53My59tPDbsmrWOZrxitg8LZzMFcz4LRrU1RamNnUNaG3pLaBCg2wd
 Soiy//akoFOkTJS9TnZwOposG0FQ+BuuhQSvhzgDM0KL5++Cqd5lpIAsrQjB8Td8PTPhsBOjGIZvJ
 3jxEvcY1rSvk8nXZdIa4luDzWSizutjSX8/qB4Mbw5pn0HI8+WjyeopvWsIsh+WWUQcdyKcz3LdsR
 Y4jcbMYWb0vg4lbtWqO0NB0O8CD+T431tb4kZsTmcrM6rD/kAz1ZPpI978w+TxEBI9RKuMsA4xspL
 N8fkyH8OlOazw9bCivVyJDR3w0lpWIah9urTa52+bYqasPR6sazR/5BwmsusdnF0SfVzNfABZe80E
 qzeFc15PmWkn/2yJ8qapwdkdYzUDqDe5sgBeP2B6w=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v7 3/6] coreaudio: Improve naming
Date: Fri, 24 Jan 2025 11:01:41 +0100
Message-ID: <5972999.ShRvV13zmH@silver>
In-Reply-To: <20250124-coreaudio-v7-3-9d9a4d91db37@daynix.com>
References: <20250124-coreaudio-v7-0-9d9a4d91db37@daynix.com>
 <20250124-coreaudio-v7-3-9d9a4d91db37@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, January 24, 2025 6:12:06 AM CET Akihiko Odaki wrote:
> coreaudio had names that are not conforming to QEMU codding style.
> coreaudioVoiceOut also had some members that are prefixed with redundant
> words like "output" or "audio".
> Global names included "out" to tell they are specific to output devices,
> but this rule was not completely enforced.
> The frame size had three different names "frameSize", "bufferFrameSize",
> and "frameCount".
>=20
> Replace identifiers to fix these problems.
>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
>  audio/coreaudio.m | 193 +++++++++++++++++++++++++++---------------------=
=2D-----
>  1 file changed, 98 insertions(+), 95 deletions(-)
>=20
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 04e8ac59f4572c1e5fb7dc4f04f5e21520507ab5..6f170a909983b2a5c6abd6fc0=
4c6c3f32828c10c 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -33,37 +33,37 @@
>  #define AUDIO_CAP "coreaudio"
>  #include "audio_int.h"
> =20
> -typedef struct coreaudioVoiceOut {
> +typedef struct CoreaudioVoiceOut {
>      HWVoiceOut hw;
>      pthread_mutex_t buf_mutex;
> -    AudioDeviceID outputDeviceID;
> -    int frameSizeSetting;
> -    uint32_t bufferCount;
> -    UInt32 audioDevicePropertyBufferFrameSize;
> +    AudioDeviceID device_id;
> +    int frame_size_setting;
> +    uint32_t buffer_count;
> +    UInt32 device_frame_size;

Actually weird that there are two frame size variables here. AFAICS the
device_frame_size member could be dropped and turned into a local variable.

Not really an issue for this patch, just saying.

>      AudioDeviceIOProcID ioprocid;
>      bool enabled;
> -} coreaudioVoiceOut;
> +} CoreaudioVoiceOut;

Ah, there's the upper case change. :)

> -static const AudioObjectPropertyAddress voice_addr =3D {
> +static const AudioObjectPropertyAddress voice_out_addr =3D {
>      kAudioHardwarePropertyDefaultOutputDevice,
>      kAudioObjectPropertyScopeGlobal,
>      kAudioObjectPropertyElementMain
>  };
> =20
> -static OSStatus coreaudio_get_voice(AudioDeviceID *id)
> +static OSStatus coreaudio_get_voice_out(AudioDeviceID *id)
>  {
>      UInt32 size =3D sizeof(*id);
> =20
>      return AudioObjectGetPropertyData(kAudioObjectSystemObject,
> -                                      &voice_addr,
> +                                      &voice_out_addr,
>                                        0,
>                                        NULL,
>                                        &size,
>                                        id);
>  }
> =20
> -static OSStatus coreaudio_get_framesizerange(AudioDeviceID id,
> -                                             AudioValueRange *framerange)
> +static OSStatus coreaudio_get_out_framesizerange(AudioDeviceID id,
> +                                                 AudioValueRange *framer=
ange)
>  {
>      UInt32 size =3D sizeof(*framerange);
>      AudioObjectPropertyAddress addr =3D {
> @@ -80,7 +80,7 @@ static OSStatus coreaudio_get_framesizerange(AudioDevic=
eID id,
>                                        framerange);
>  }
> =20
> -static OSStatus coreaudio_get_framesize(AudioDeviceID id, UInt32 *frames=
ize)
> +static OSStatus coreaudio_get_out_framesize(AudioDeviceID id, UInt32 *fr=
amesize)
>  {
>      UInt32 size =3D sizeof(*framesize);
>      AudioObjectPropertyAddress addr =3D {
> @@ -97,7 +97,7 @@ static OSStatus coreaudio_get_framesize(AudioDeviceID i=
d, UInt32 *framesize)
>                                        framesize);
>  }
> =20
> -static OSStatus coreaudio_set_framesize(AudioDeviceID id, UInt32 *frames=
ize)
> +static OSStatus coreaudio_set_out_framesize(AudioDeviceID id, UInt32 *fr=
amesize)
>  {
>      UInt32 size =3D sizeof(*framesize);
>      AudioObjectPropertyAddress addr =3D {
> @@ -114,8 +114,8 @@ static OSStatus coreaudio_set_framesize(AudioDeviceID=
 id, UInt32 *framesize)
>                                        framesize);
>  }
> =20
> -static OSStatus coreaudio_set_streamformat(AudioDeviceID id,
> -                                           AudioStreamBasicDescription *=
d)
> +static OSStatus coreaudio_set_out_streamformat(AudioDeviceID id,
> +                                               AudioStreamBasicDescripti=
on *d)
>  {
>      UInt32 size =3D sizeof(*d);
>      AudioObjectPropertyAddress addr =3D {
> @@ -132,7 +132,7 @@ static OSStatus coreaudio_set_streamformat(AudioDevic=
eID id,
>                                        d);
>  }
> =20
> -static OSStatus coreaudio_get_isrunning(AudioDeviceID id, UInt32 *result)
> +static OSStatus coreaudio_get_out_isrunning(AudioDeviceID id, UInt32 *re=
sult)
>  {
>      UInt32 size =3D sizeof(*result);
>      AudioObjectPropertyAddress addr =3D {
> @@ -242,7 +242,8 @@ static void G_GNUC_PRINTF(3, 4) coreaudio_logerr2(
>  #define coreaudio_playback_logerr(status, ...) \
>      coreaudio_logerr2(status, "playback", __VA_ARGS__)
> =20
> -static int coreaudio_buf_lock(coreaudioVoiceOut *core, const char *fn_na=
me)
> +static int coreaudio_voice_out_buf_lock(CoreaudioVoiceOut *core,
> +                                        const char *fn_name)
>  {
>      int err;
> =20
> @@ -255,7 +256,8 @@ static int coreaudio_buf_lock(coreaudioVoiceOut *core=
, const char *fn_name)
>      return 0;
>  }
> =20
> -static int coreaudio_buf_unlock(coreaudioVoiceOut *core, const char *fn_=
name)
> +static int coreaudio_voice_out_buf_unlock(CoreaudioVoiceOut *core,
> +                                          const char *fn_name)
>  {
>      int err;
> =20
> @@ -268,20 +270,20 @@ static int coreaudio_buf_unlock(coreaudioVoiceOut *=
core, const char *fn_name)
>      return 0;
>  }
> =20
> -#define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args) \
> -    static ret_type glue(coreaudio_, name)args_decl             \
> -    {                                                           \
> -        coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;      \
> -        ret_type ret;                                           \
> -                                                                \
> -        if (coreaudio_buf_lock(core, "coreaudio_" #name)) {         \
> -            return 0;                                           \
> -        }                                                       \
> -                                                                \
> -        ret =3D glue(audio_generic_, name)args;                   \
> -                                                                \
> -        coreaudio_buf_unlock(core, "coreaudio_" #name);             \
> -        return ret;                                             \
> +#define COREAUDIO_WRAPPER_FUNC(name, ret_type, args_decl, args)       \
> +    static ret_type glue(coreaudio_, name)args_decl                   \
> +    {                                                                 \
> +        CoreaudioVoiceOut *core =3D (CoreaudioVoiceOut *)hw;            \
> +        ret_type ret;                                                 \
> +                                                                      \
> +        if (coreaudio_voice_out_buf_lock(core, "coreaudio_" #name)) { \
> +            return 0;                                                 \
> +        }                                                             \
> +                                                                      \
> +        ret =3D glue(audio_generic_, name)args;                         \
> +                                                                      \
> +        coreaudio_voice_out_buf_unlock(core, "coreaudio_" #name);     \
> +        return ret;                                                   \

That doesn't really belong into this patch, but OK.

>      }
>  COREAUDIO_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
>  COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t *=
size),
> @@ -297,7 +299,7 @@ static ret_type glue(coreaudio_, name)args_decl      =
       \
>   * callback to feed audiooutput buffer. called without BQL.
>   * allowed to lock "buf_mutex", but disallowed to have any other locks.
>   */
> -static OSStatus audioDeviceIOProc(
> +static OSStatus out_device_ioproc(
>      AudioDeviceID inDevice,
>      const AudioTimeStamp *inNow,
>      const AudioBufferList *inInputData,
> @@ -306,33 +308,33 @@ static OSStatus audioDeviceIOProc(
>      const AudioTimeStamp *inOutputTime,
>      void *hwptr)
>  {
> -    UInt32 frameCount, pending_frames;
> +    UInt32 frame_size, pending_frames;
>      void *out =3D outOutputData->mBuffers[0].mData;
>      HWVoiceOut *hw =3D hwptr;
> -    coreaudioVoiceOut *core =3D hwptr;
> +    CoreaudioVoiceOut *core =3D hwptr;
>      size_t len;
> =20
> -    if (coreaudio_buf_lock(core, "audioDeviceIOProc")) {
> +    if (coreaudio_voice_out_buf_lock(core, "out_device_ioproc")) {
>          inInputTime =3D 0;
>          return 0;
>      }
> =20
> -    if (inDevice !=3D core->outputDeviceID) {
> -        coreaudio_buf_unlock(core, "audioDeviceIOProc(old device)");
> +    if (inDevice !=3D core->device_id) {
> +        coreaudio_voice_out_buf_unlock(core, "out_device_ioproc(old devi=
ce)");
>          return 0;
>      }
> =20
> -    frameCount =3D core->audioDevicePropertyBufferFrameSize;
> +    frame_size =3D core->device_frame_size;
>      pending_frames =3D hw->pending_emul / hw->info.bytes_per_frame;
> =20
>      /* if there are not enough samples, set signal and return */
> -    if (pending_frames < frameCount) {
> +    if (pending_frames < frame_size) {
>          inInputTime =3D 0;
> -        coreaudio_buf_unlock(core, "audioDeviceIOProc(empty)");
> +        coreaudio_voice_out_buf_unlock(core, "out_device_ioproc(empty)");
>          return 0;
>      }
> =20
> -    len =3D frameCount * hw->info.bytes_per_frame;
> +    len =3D frame_size * hw->info.bytes_per_frame;
>      while (len) {
>          size_t write_len, start;
> =20
> @@ -348,16 +350,16 @@ static OSStatus audioDeviceIOProc(
>          out +=3D write_len;
>      }
> =20
> -    coreaudio_buf_unlock(core, "audioDeviceIOProc");
> +    coreaudio_voice_out_buf_unlock(core, "out_device_ioproc");
>      return 0;
>  }
> =20
> -static OSStatus init_out_device(coreaudioVoiceOut *core)
> +static OSStatus init_out_device(CoreaudioVoiceOut *core)
>  {
>      OSStatus status;
> -    AudioValueRange frameRange;
> +    AudioValueRange framerange;
> =20
> -    AudioStreamBasicDescription streamBasicDescription =3D {
> +    AudioStreamBasicDescription stream_basic_description =3D {
>          .mBitsPerChannel =3D core->hw.info.bits,
>          .mBytesPerFrame =3D core->hw.info.bytes_per_frame,
>          .mBytesPerPacket =3D core->hw.info.bytes_per_frame,
> @@ -368,20 +370,20 @@ static OSStatus init_out_device(coreaudioVoiceOut *=
core)
>          .mSampleRate =3D core->hw.info.freq
>      };
> =20
> -    status =3D coreaudio_get_voice(&core->outputDeviceID);
> +    status =3D coreaudio_get_voice_out(&core->device_id);

As can be seen here, I still think "*out*_device_id" is useful for review
purposes. Except of that:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

/Christian

>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_playback_logerr(status,
>                                    "Could not get default output Device\n=
");
>          return status;
>      }
> -    if (core->outputDeviceID =3D=3D kAudioDeviceUnknown) {
> +    if (core->device_id =3D=3D kAudioDeviceUnknown) {
>          dolog("Could not initialize playback - Unknown Audiodevice\n");
>          return status;
>      }
> =20
>      /* get minimum and maximum buffer frame sizes */
> -    status =3D coreaudio_get_framesizerange(core->outputDeviceID,
> -                                          &frameRange);
> +    status =3D coreaudio_get_out_framesizerange(core->device_id,
> +                                              &framerange);
>      if (status =3D=3D kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -391,32 +393,32 @@ static OSStatus init_out_device(coreaudioVoiceOut *=
core)
>          return status;
>      }
> =20
> -    if (frameRange.mMinimum > core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize =3D frameRange.mMinimum;
> -        dolog("warning: Upsizing Buffer Frames to %f\n", frameRange.mMin=
imum);
> -    } else if (frameRange.mMaximum < core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize =3D frameRange.mMaximum;
> -        dolog("warning: Downsizing Buffer Frames to %f\n", frameRange.mM=
aximum);
> +    if (framerange.mMinimum > core->frame_size_setting) {
> +        core->device_frame_size =3D framerange.mMinimum;
> +        dolog("warning: Upsizing Buffer Frames to %f\n", framerange.mMin=
imum);
> +    } else if (framerange.mMaximum < core->frame_size_setting) {
> +        core->device_frame_size =3D framerange.mMaximum;
> +        dolog("warning: Downsizing Buffer Frames to %f\n", framerange.mM=
aximum);
>      } else {
> -        core->audioDevicePropertyBufferFrameSize =3D core->frameSizeSett=
ing;
> +        core->device_frame_size =3D core->frame_size_setting;
>      }
> =20
>      /* set Buffer Frame Size */
> -    status =3D coreaudio_set_framesize(core->outputDeviceID,
> -                                     &core->audioDevicePropertyBufferFra=
meSize);
> +    status =3D coreaudio_set_out_framesize(core->device_id,
> +                                         &core->device_frame_size);
>      if (status =3D=3D kAudioHardwareBadObjectError) {
>          return 0;
>      }
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_playback_logerr(status,
>                                    "Could not set device buffer frame siz=
e %" PRIu32 "\n",
> -                                  (uint32_t)core->audioDevicePropertyBuf=
ferFrameSize);
> +                                  (uint32_t)core->device_frame_size);
>          return status;
>      }
> =20
>      /* get Buffer Frame Size */
> -    status =3D coreaudio_get_framesize(core->outputDeviceID,
> -                                     &core->audioDevicePropertyBufferFra=
meSize);
> +    status =3D coreaudio_get_out_framesize(core->device_id,
> +                                         &core->device_frame_size);
>      if (status =3D=3D kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -425,19 +427,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *=
core)
>                                    "Could not get device buffer frame siz=
e\n");
>          return status;
>      }
> -    core->hw.samples =3D core->bufferCount * core->audioDevicePropertyBu=
fferFrameSize;
> +    core->hw.samples =3D core->buffer_count * core->device_frame_size;
> =20
>      /* set Samplerate */
> -    status =3D coreaudio_set_streamformat(core->outputDeviceID,
> -                                        &streamBasicDescription);
> +    status =3D coreaudio_set_out_streamformat(core->device_id,
> +                                            &stream_basic_description);
>      if (status =3D=3D kAudioHardwareBadObjectError) {
>          return 0;
>      }
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_playback_logerr(status,
>                                    "Could not set samplerate %lf\n",
> -                                  streamBasicDescription.mSampleRate);
> -        core->outputDeviceID =3D kAudioDeviceUnknown;
> +                                  stream_basic_description.mSampleRate);
> +        core->device_id =3D kAudioDeviceUnknown;
>          return status;
>      }
> =20
> @@ -452,8 +454,8 @@ static OSStatus init_out_device(coreaudioVoiceOut *co=
re)
>       * with the callers of AudioObjectGetPropertyData.
>       */
>      core->ioprocid =3D NULL;
> -    status =3D AudioDeviceCreateIOProcID(core->outputDeviceID,
> -                                       audioDeviceIOProc,
> +    status =3D AudioDeviceCreateIOProcID(core->device_id,
> +                                       out_device_ioproc,
>                                         &core->hw,
>                                         &core->ioprocid);
>      if (status =3D=3D kAudioHardwareBadDeviceError) {
> @@ -461,20 +463,20 @@ static OSStatus init_out_device(coreaudioVoiceOut *=
core)
>      }
>      if (status !=3D kAudioHardwareNoError || core->ioprocid =3D=3D NULL)=
 {
>          coreaudio_playback_logerr(status, "Could not set IOProc\n");
> -        core->outputDeviceID =3D kAudioDeviceUnknown;
> +        core->device_id =3D kAudioDeviceUnknown;
>          return status;
>      }
> =20
>      return 0;
>  }
> =20
> -static void fini_out_device(coreaudioVoiceOut *core)
> +static void fini_out_device(CoreaudioVoiceOut *core)
>  {
>      OSStatus status;
>      UInt32 isrunning;
> =20
>      /* stop playback */
> -    status =3D coreaudio_get_isrunning(core->outputDeviceID, &isrunning);
> +    status =3D coreaudio_get_out_isrunning(core->device_id, &isrunning);
>      if (status !=3D kAudioHardwareBadObjectError) {
>          if (status !=3D kAudioHardwareNoError) {
>              coreaudio_logerr(status,
> @@ -482,7 +484,7 @@ static void fini_out_device(coreaudioVoiceOut *core)
>          }
> =20
>          if (isrunning) {
> -            status =3D AudioDeviceStop(core->outputDeviceID, core->iopro=
cid);
> +            status =3D AudioDeviceStop(core->device_id, core->ioprocid);
>              if (status !=3D kAudioHardwareBadDeviceError && status !=3D =
kAudioHardwareNoError) {
>                  coreaudio_logerr(status, "Could not stop playback\n");
>              }
> @@ -490,20 +492,20 @@ static void fini_out_device(coreaudioVoiceOut *core)
>      }
> =20
>      /* remove callback */
> -    status =3D AudioDeviceDestroyIOProcID(core->outputDeviceID,
> +    status =3D AudioDeviceDestroyIOProcID(core->device_id,
>                                          core->ioprocid);
>      if (status !=3D kAudioHardwareBadDeviceError && status !=3D kAudioHa=
rdwareNoError) {
>          coreaudio_logerr(status, "Could not remove IOProc\n");
>      }
> -    core->outputDeviceID =3D kAudioDeviceUnknown;
> +    core->device_id =3D kAudioDeviceUnknown;
>  }
> =20
> -static void update_device_playback_state(coreaudioVoiceOut *core)
> +static void update_out_device_playback_state(CoreaudioVoiceOut *core)
>  {
>      OSStatus status;
>      UInt32 isrunning;
> =20
> -    status =3D coreaudio_get_isrunning(core->outputDeviceID, &isrunning);
> +    status =3D coreaudio_get_out_isrunning(core->device_id, &isrunning);
>      if (status !=3D kAudioHardwareNoError) {
>          if (status !=3D kAudioHardwareBadObjectError) {
>              coreaudio_logerr(status,
> @@ -516,7 +518,7 @@ static void update_device_playback_state(coreaudioVoi=
ceOut *core)
>      if (core->enabled) {
>          /* start playback */
>          if (!isrunning) {
> -            status =3D AudioDeviceStart(core->outputDeviceID, core->iopr=
ocid);
> +            status =3D AudioDeviceStart(core->device_id, core->ioprocid);
>              if (status !=3D kAudioHardwareBadDeviceError && status !=3D =
kAudioHardwareNoError) {
>                  coreaudio_logerr(status, "Could not resume playback\n");
>              }
> @@ -524,7 +526,7 @@ static void update_device_playback_state(coreaudioVoi=
ceOut *core)
>      } else {
>          /* stop playback */
>          if (isrunning) {
> -            status =3D AudioDeviceStop(core->outputDeviceID,
> +            status =3D AudioDeviceStop(core->device_id,
>                                       core->ioprocid);
>              if (status !=3D kAudioHardwareBadDeviceError && status !=3D =
kAudioHardwareNoError) {
>                  coreaudio_logerr(status, "Could not pause playback\n");
> @@ -534,22 +536,22 @@ static void update_device_playback_state(coreaudioV=
oiceOut *core)
>  }
> =20
>  /* called without BQL. */
> -static OSStatus handle_voice_change(
> +static OSStatus handle_voice_out_change(
>      AudioObjectID in_object_id,
>      UInt32 in_number_addresses,
>      const AudioObjectPropertyAddress *in_addresses,
>      void *in_client_data)
>  {
> -    coreaudioVoiceOut *core =3D in_client_data;
> +    CoreaudioVoiceOut *core =3D in_client_data;
> =20
>      bql_lock();
> =20
> -    if (core->outputDeviceID) {
> +    if (core->device_id) {
>          fini_out_device(core);
>      }
> =20
>      if (!init_out_device(core)) {
> -        update_device_playback_state(core);
> +        update_out_device_playback_state(core);
>      }
> =20
>      bql_unlock();
> @@ -560,7 +562,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct =
audsettings *as,
>                                void *drv_opaque)
>  {
>      OSStatus status;
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;
> +    CoreaudioVoiceOut *core =3D (CoreaudioVoiceOut *)hw;
>      int err;
>      Audiodev *dev =3D drv_opaque;
>      AudiodevCoreaudioPerDirectionOptions *cpdo =3D dev->u.coreaudio.out;
> @@ -578,13 +580,14 @@ static int coreaudio_init_out(HWVoiceOut *hw, struc=
t audsettings *as,
>      as->fmt =3D AUDIO_FORMAT_F32;
>      audio_pcm_init_info(&hw->info, as);
> =20
> -    core->frameSizeSetting =3D audio_buffer_frames(
> +    core->frame_size_setting =3D audio_buffer_frames(
>          qapi_AudiodevCoreaudioPerDirectionOptions_base(cpdo), as, 11610);
> =20
> -    core->bufferCount =3D cpdo->has_buffer_count ? cpdo->buffer_count : =
4;
> +    core->buffer_count =3D cpdo->has_buffer_count ? cpdo->buffer_count :=
 4;
> =20
>      status =3D AudioObjectAddPropertyListener(kAudioObjectSystemObject,
> -                                            &voice_addr, handle_voice_ch=
ange,
> +                                            &voice_out_addr,
> +                                            handle_voice_out_change,
>                                              core);
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_playback_logerr(status,
> @@ -594,8 +597,8 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct =
audsettings *as,
> =20
>      if (init_out_device(core)) {
>          status =3D AudioObjectRemovePropertyListener(kAudioObjectSystemO=
bject,
> -                                                   &voice_addr,
> -                                                   handle_voice_change,
> +                                                   &voice_out_addr,
> +                                                   handle_voice_out_chan=
ge,
>                                                     core);
>          if (status !=3D kAudioHardwareNoError) {
>              coreaudio_playback_logerr(status,
> @@ -612,11 +615,11 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
>  {
>      OSStatus status;
>      int err;
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;
> +    CoreaudioVoiceOut *core =3D (CoreaudioVoiceOut *)hw;
> =20
>      status =3D AudioObjectRemovePropertyListener(kAudioObjectSystemObjec=
t,
> -                                               &voice_addr,
> -                                               handle_voice_change,
> +                                               &voice_out_addr,
> +                                               handle_voice_out_change,
>                                                 core);
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_logerr(status, "Could not remove voice property change=
 listener\n");
> @@ -633,10 +636,10 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
> =20
>  static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
>  {
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;
> +    CoreaudioVoiceOut *core =3D (CoreaudioVoiceOut *)hw;
> =20
>      core->enabled =3D enable;
> -    update_device_playback_state(core);
> +    update_out_device_playback_state(core);
>  }
> =20
>  static void *coreaudio_audio_init(Audiodev *dev, Error **errp)
> @@ -670,7 +673,7 @@ static void coreaudio_audio_fini(void *opaque)
>      .pcm_ops        =3D &coreaudio_pcm_ops,
>      .max_voices_out =3D 1,
>      .max_voices_in  =3D 0,
> -    .voice_size_out =3D sizeof(coreaudioVoiceOut),
> +    .voice_size_out =3D sizeof(CoreaudioVoiceOut),
>      .voice_size_in  =3D 0
>  };
> =20
>=20
>=20



