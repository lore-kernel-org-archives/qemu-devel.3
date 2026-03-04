Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA53EB7EB2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxiUE-0005gz-Qd; Wed, 04 Mar 2026 04:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxiUD-0005gQ-89
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:25:45 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxiUA-0002Nd-M6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=775MdwDlMvVNPBxKzld/J85JuDS2V4LqVTcOtYWPlAk=; b=MbUJpTFSgiqzm52KkETDwrlHOI
 /Hpxmjosj3OQuzHGF2mRBBQaHKtS+tg+T3uodNdZHsv1nEScH8ymzD+cOKxoZsItMzjqCbCFY7KbP
 2Q/ndO2FT5BGVEBJndQ3VbaWoMFiGCY1O3OEH0PneM+DbVBd6eovyoxaPN7W0ZO2BfiTYdxWvgq4J
 bppSFCQ8QlGUuWJdu76aRzrG5mDAOOC5sDCRc6Zhsg5Ftq12/83Z5i++fs1bkNJPZE6TCVmiTbjeJ
 tWeOD1PlvMFVtizMqQq054Z6g7PlT4ghkTr/pRATYmT4kvi2ldxo1Cm6WvYP3wz7yJQG1peaqLt34
 cn6Qnrqyc8EOX3zb33VhTkC6aHjcc4JhIlq/VDKZudw0Y+Nb8JStDpfQYN5JRpmHbbHr77cVGUUQX
 llMRAof/59Rlik19SgFbGU/3wUBB5uKSGvmVXoYOGJAufPnzJCuAV+LH1LDUPsbK4vajPxcszcTsb
 b18WhjIIlGLQbENO1BpXpVM0BaizepDtR7PHvlsKTFihPwKEiZS6Y1pa82avE4jovPEYHstBnFV/A
 vO8YT+pZ5fpFFkxqev8UWicSAAKw7EymxH3EXMrowQNrvj069cRFKzRqxqyxzLGIDv2GXEvtED365
 /VD3eXGX+G0Pa6ZNbrKEJkCPc13QnYPKvtl8x4L/4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v8 3/6] coreaudio: Improve naming
Date: Wed, 04 Mar 2026 10:25:37 +0100
Message-ID: <3933555.kQq0lBPeGt@weasel>
In-Reply-To: <20260304-coreaudio-v8-3-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-3-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wednesday, 4 March 2026 07:16:56 CET Akihiko Odaki wrote:
> coreaudio had names that are not conforming to QEMU codding style.

coding

> coreaudioVoiceOut also had some members that are prefixed with redundant
> words like "output" or "audio".
> Global names included "out" to tell they are specific to output devices,
> but this rule was not completely enforced.
> The frame size had three different names "frameSize", "bufferFrameSize",
> and "frameCount".
>=20
> Replace identifiers to fix these problems.
>=20
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  audio/coreaudio.m | 188
> +++++++++++++++++++++++++++--------------------------- 1 file changed, 95
> insertions(+), 93 deletions(-)
>=20
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index bc9ab7477b68..736227eb2b7a 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -43,34 +43,34 @@
>  typedef struct coreaudioVoiceOut {

Leaving this lower case?

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
>      AudioDeviceIOProcID ioprocid;
>      bool enabled;
> -} coreaudioVoiceOut;
> +} CoreaudioVoiceOut;
>=20
> -static const AudioObjectPropertyAddress voice_addr =3D {
> +static const AudioObjectPropertyAddress voice_out_addr =3D {
>      kAudioHardwarePropertyDefaultOutputDevice,
>      kAudioObjectPropertyScopeGlobal,
>      kAudioObjectPropertyElementMain
>  };
>=20
> -static OSStatus coreaudio_get_voice(AudioDeviceID *id)
> +static OSStatus coreaudio_get_voice_out(AudioDeviceID *id)
>  {
>      UInt32 size =3D sizeof(*id);
>=20
>      return AudioObjectGetPropertyData(kAudioObjectSystemObject,
> -                                      &voice_addr,
> +                                      &voice_out_addr,
>                                        0,
>                                        NULL,
>                                        &size,
>                                        id);
>  }
>=20
> -static OSStatus coreaudio_get_framesizerange(AudioDeviceID id,
> -                                             AudioValueRange *framerange)
> +static OSStatus coreaudio_get_out_framesizerange(AudioDeviceID id,
> +                                                 AudioValueRange
> *framerange) {
>      UInt32 size =3D sizeof(*framerange);
>      AudioObjectPropertyAddress addr =3D {
> @@ -87,7 +87,7 @@ static OSStatus coreaudio_get_framesizerange(AudioDevic=
eID
> id, framerange);
>  }

So here it is "framerange" and not "frame_range".

> -static OSStatus coreaudio_get_framesize(AudioDeviceID id, UInt32
> *framesize) +static OSStatus coreaudio_get_out_framesize(AudioDeviceID id,
> UInt32 *framesize) {
>      UInt32 size =3D sizeof(*framesize);
>      AudioObjectPropertyAddress addr =3D {
> @@ -104,7 +104,7 @@ static OSStatus coreaudio_get_framesize(AudioDeviceID
> id, UInt32 *framesize) framesize);
>  }

Here it is "framesize" and not "frame_size".

> -static OSStatus coreaudio_set_framesize(AudioDeviceID id, UInt32
> *framesize) +static OSStatus coreaudio_set_out_framesize(AudioDeviceID id,
> UInt32 *framesize) {
>      UInt32 size =3D sizeof(*framesize);
>      AudioObjectPropertyAddress addr =3D {
> @@ -121,8 +121,8 @@ static OSStatus coreaudio_set_framesize(AudioDeviceID
> id, UInt32 *framesize) framesize);
>  }
>=20
> -static OSStatus coreaudio_set_streamformat(AudioDeviceID id,
> -                                           AudioStreamBasicDescription *=
d)
> +static OSStatus coreaudio_set_out_streamformat(AudioDeviceID id,
> +                                               AudioStreamBasicDescripti=
on
> *d) {
>      UInt32 size =3D sizeof(*d);
>      AudioObjectPropertyAddress addr =3D {
> @@ -139,7 +139,7 @@ static OSStatus coreaudio_set_streamformat(AudioDevic=
eID
> id, d);
>  }
>=20
> -static OSStatus coreaudio_get_isrunning(AudioDeviceID id, UInt32 *result)
> +static OSStatus coreaudio_get_out_isrunning(AudioDeviceID id, UInt32
> *result) {
>      UInt32 size =3D sizeof(*result);
>      AudioObjectPropertyAddress addr =3D {
> @@ -243,7 +243,8 @@ static void G_GNUC_PRINTF(3, 4)
> coreaudio_logerr2(OSStatus status, #define
> coreaudio_playback_logerr(status, ...) \
>      coreaudio_logerr2(status, "playback", __VA_ARGS__)
>=20
> -static int coreaudio_buf_lock(coreaudioVoiceOut *core, const char *fn_na=
me)
> +static int coreaudio_voice_out_buf_lock(CoreaudioVoiceOut *core,
> +                                        const char *fn_name)
>  {
>      int err;
>=20
> @@ -256,7 +257,8 @@ static int coreaudio_buf_lock(coreaudioVoiceOut *core,
> const char *fn_name) return 0;
>  }
>=20
> -static int coreaudio_buf_unlock(coreaudioVoiceOut *core, const char
> *fn_name) +static int coreaudio_voice_out_buf_unlock(CoreaudioVoiceOut
> *core, +                                          const char *fn_name)
>  {
>      int err;
>=20
> @@ -269,20 +271,20 @@ static int coreaudio_buf_unlock(coreaudioVoiceOut
> *core, const char *fn_name) return 0;
>  }
>=20
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
>      }
>  COREAUDIO_WRAPPER_FUNC(buffer_get_free, size_t, (HWVoiceOut *hw), (hw))
>  COREAUDIO_WRAPPER_FUNC(get_buffer_out, void *, (HWVoiceOut *hw, size_t
> *size), @@ -298,7 +300,7 @@ static ret_type glue(coreaudio_, name)args_de=
cl
>             \ * callback to feed audiooutput buffer. called without BQL.
>   * allowed to lock "buf_mutex", but disallowed to have any other locks.
>   */
> -static OSStatus audioDeviceIOProc(
> +static OSStatus out_device_ioproc(
>      AudioDeviceID inDevice,
>      const AudioTimeStamp *inNow,
>      const AudioBufferList *inInputData,
> @@ -307,33 +309,33 @@ static OSStatus audioDeviceIOProc(
>      const AudioTimeStamp *inOutputTime,
>      void *hwptr)
>  {
> -    UInt32 frameCount, pending_frames;
> +    UInt32 frame_size, pending_frames;

And here it is "frame_size".

That's why I try to avoid looking at such kind of refactoring patches. Never
ending white noise added to the universe.

>      void *out =3D outOutputData->mBuffers[0].mData;
>      HWVoiceOut *hw =3D hwptr;
> -    coreaudioVoiceOut *core =3D hwptr;
> +    CoreaudioVoiceOut *core =3D hwptr;
>      size_t len;
>=20
> -    if (coreaudio_buf_lock(core, "audioDeviceIOProc")) {
> +    if (coreaudio_voice_out_buf_lock(core, "out_device_ioproc")) {
>          inInputTime =3D 0;
>          return 0;
>      }
>=20
> -    if (inDevice !=3D core->outputDeviceID) {
> -        coreaudio_buf_unlock(core, "audioDeviceIOProc(old device)");
> +    if (inDevice !=3D core->device_id) {
> +        coreaudio_voice_out_buf_unlock(core, "out_device_ioproc(old
> device)"); return 0;
>      }
>=20
> -    frameCount =3D core->audioDevicePropertyBufferFrameSize;
> +    frame_size =3D core->device_frame_size;
>      pending_frames =3D hw->pending_emul / hw->info.bytes_per_frame;
>=20
>      /* if there are not enough samples, set signal and return */
> -    if (pending_frames < frameCount) {
> +    if (pending_frames < frame_size) {
>          inInputTime =3D 0;
> -        coreaudio_buf_unlock(core, "audioDeviceIOProc(empty)");
> +        coreaudio_voice_out_buf_unlock(core, "out_device_ioproc(empty)");
>          return 0;
>      }
>=20
> -    len =3D frameCount * hw->info.bytes_per_frame;
> +    len =3D frame_size * hw->info.bytes_per_frame;
>      while (len) {
>          size_t write_len, start;
>=20
> @@ -349,16 +351,16 @@ static OSStatus audioDeviceIOProc(
>          out +=3D write_len;
>      }
>=20
> -    coreaudio_buf_unlock(core, "audioDeviceIOProc");
> +    coreaudio_voice_out_buf_unlock(core, "out_device_ioproc");

Behaviour change. Not pure refactoring. Should be split into a separate pat=
ch.

>      return 0;
>  }
>=20
> -static OSStatus init_out_device(coreaudioVoiceOut *core)
> +static OSStatus init_out_device(CoreaudioVoiceOut *core)
>  {
> +    AudioValueRange value_range;
>      OSStatus status;
> -    AudioValueRange frameRange;
>=20
> -    AudioStreamBasicDescription streamBasicDescription =3D {
> +    AudioStreamBasicDescription stream_basic_description =3D {
>          .mBitsPerChannel =3D audio_format_bits(core->hw.info.af),
>          .mBytesPerFrame =3D core->hw.info.bytes_per_frame,
>          .mBytesPerPacket =3D core->hw.info.bytes_per_frame,
> @@ -369,21 +371,20 @@ static OSStatus init_out_device(coreaudioVoiceOut
> *core) .mSampleRate =3D core->hw.info.freq
>      };
>=20
> -    status =3D coreaudio_get_voice(&core->outputDeviceID);
> +    status =3D coreaudio_get_voice_out(&core->device_id);
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_playback_logerr(status,
>                                    "Could not get default output device");
>          return status;
>      }
> -    if (core->outputDeviceID =3D=3D kAudioDeviceUnknown) {
> +    if (core->device_id =3D=3D kAudioDeviceUnknown) {
>          error_report("coreaudio: Could not initialize playback: "
>                       "Unknown audio device");
>          return status;
>      }
>=20
>      /* get minimum and maximum buffer frame sizes */
> -    status =3D coreaudio_get_framesizerange(core->outputDeviceID,
> -                                          &frameRange);
> +    status =3D coreaudio_get_out_framesizerange(core->device_id,
> &value_range); if (status =3D=3D kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -393,34 +394,34 @@ static OSStatus init_out_device(coreaudioVoiceOut
> *core) return status;
>      }
>=20
> -    if (frameRange.mMinimum > core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize =3D frameRange.mMinimum;
> +    if (value_range.mMinimum > core->frame_size_setting) {
> +        core->device_frame_size =3D value_range.mMinimum;
>          warn_report("coreaudio: Upsizing buffer frames to %f",
> -                    frameRange.mMinimum);
> -    } else if (frameRange.mMaximum < core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize =3D frameRange.mMaximum;
> +                    value_range.mMinimum);
> +    } else if (value_range.mMaximum < core->frame_size_setting) {
> +        core->device_frame_size =3D value_range.mMaximum;
>          warn_report("coreaudio: Downsizing buffer frames to %f",
> -                    frameRange.mMaximum);
> +                    value_range.mMaximum);
>      } else {
> -        core->audioDevicePropertyBufferFrameSize =3D core->frameSizeSett=
ing;
> +        core->device_frame_size =3D core->frame_size_setting;
>      }
>=20
>      /* set Buffer Frame Size */
> -    status =3D coreaudio_set_framesize(core->outputDeviceID,
> -                                   =20
> &core->audioDevicePropertyBufferFrameSize); +    status =3D
> coreaudio_set_out_framesize(core->device_id,
> +                                         &core->device_frame_size);
>      if (status =3D=3D kAudioHardwareBadObjectError) {
>          return 0;
>      }
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_playback_logerr(status,
>                                    "Could not set device buffer frame size
> %" PRIu32, -                                =20
> (uint32_t)core->audioDevicePropertyBufferFrameSize); +                   =
 =20
>             (uint32_t)core->device_frame_size); return status;
>      }
>=20
>      /* get Buffer Frame Size */
> -    status =3D coreaudio_get_framesize(core->outputDeviceID,
> -                                   =20
> &core->audioDevicePropertyBufferFrameSize); +    status =3D
> coreaudio_get_out_framesize(core->device_id,
> +                                         &core->device_frame_size);
>      if (status =3D=3D kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -429,19 +430,19 @@ static OSStatus init_out_device(coreaudioVoiceOut
> *core) "Could not get device buffer frame size"); return status;
>      }
> -    core->hw.samples =3D core->bufferCount *
> core->audioDevicePropertyBufferFrameSize; +    core->hw.samples =3D
> core->buffer_count * core->device_frame_size;
>=20
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
>                                    "Could not set samplerate %lf",
> -                                  streamBasicDescription.mSampleRate);
> -        core->outputDeviceID =3D kAudioDeviceUnknown;
> +                                  stream_basic_description.mSampleRate);
> +        core->device_id =3D kAudioDeviceUnknown;
>          return status;
>      }
>=20
> @@ -456,8 +457,8 @@ static OSStatus init_out_device(coreaudioVoiceOut *co=
re)
> * with the callers of AudioObjectGetPropertyData.
>       */
>      core->ioprocid =3D NULL;
> -    status =3D AudioDeviceCreateIOProcID(core->outputDeviceID,
> -                                       audioDeviceIOProc,
> +    status =3D AudioDeviceCreateIOProcID(core->device_id,
> +                                       out_device_ioproc,
>                                         &core->hw,
>                                         &core->ioprocid);
>      if (status =3D=3D kAudioHardwareBadDeviceError) {
> @@ -465,20 +466,20 @@ static OSStatus init_out_device(coreaudioVoiceOut
> *core) }
>      if (status !=3D kAudioHardwareNoError || core->ioprocid =3D=3D NULL)=
 {
>          coreaudio_playback_logerr(status, "Could not set IOProc");
> -        core->outputDeviceID =3D kAudioDeviceUnknown;
> +        core->device_id =3D kAudioDeviceUnknown;
>          return status;
>      }
>=20
>      return 0;
>  }
>=20
> -static void fini_out_device(coreaudioVoiceOut *core)
> +static void fini_out_device(CoreaudioVoiceOut *core)
>  {
>      OSStatus status;
>      UInt32 isrunning;
>=20
>      /* stop playback */
> -    status =3D coreaudio_get_isrunning(core->outputDeviceID, &isrunning);
> +    status =3D coreaudio_get_out_isrunning(core->device_id, &isrunning);
>      if (status !=3D kAudioHardwareBadObjectError) {
>          if (status !=3D kAudioHardwareNoError) {
>              coreaudio_logerr(status,
> @@ -486,7 +487,7 @@ static void fini_out_device(coreaudioVoiceOut *core)
>          }
>=20
>          if (isrunning) {
> -            status =3D AudioDeviceStop(core->outputDeviceID, core->iopro=
cid);
> +            status =3D AudioDeviceStop(core->device_id, core->ioprocid);=
 if
> (status !=3D kAudioHardwareBadDeviceError && status !=3D kAudioHardwareNo=
Error)
> { coreaudio_logerr(status, "Could not stop playback"); }
> @@ -494,20 +495,20 @@ static void fini_out_device(coreaudioVoiceOut *core)
>      }
>=20
>      /* remove callback */
> -    status =3D AudioDeviceDestroyIOProcID(core->outputDeviceID,
> +    status =3D AudioDeviceDestroyIOProcID(core->device_id,
>                                          core->ioprocid);
>      if (status !=3D kAudioHardwareBadDeviceError && status !=3D
> kAudioHardwareNoError) { coreaudio_logerr(status, "Could not remove
> IOProc");
>      }
> -    core->outputDeviceID =3D kAudioDeviceUnknown;
> +    core->device_id =3D kAudioDeviceUnknown;
>  }
>=20
> -static void update_device_playback_state(coreaudioVoiceOut *core)
> +static void update_out_device_playback_state(CoreaudioVoiceOut *core)
>  {
>      OSStatus status;
>      UInt32 isrunning;
>=20
> -    status =3D coreaudio_get_isrunning(core->outputDeviceID, &isrunning);
> +    status =3D coreaudio_get_out_isrunning(core->device_id, &isrunning);
>      if (status !=3D kAudioHardwareNoError) {
>          if (status !=3D kAudioHardwareBadObjectError) {
>              coreaudio_logerr(status,
> @@ -520,7 +521,7 @@ static void
> update_device_playback_state(coreaudioVoiceOut *core) if (core->enabled) {
>          /* start playback */
>          if (!isrunning) {
> -            status =3D AudioDeviceStart(core->outputDeviceID,
> core->ioprocid); +            status =3D AudioDeviceStart(core->device_id,
> core->ioprocid); if (status !=3D kAudioHardwareBadDeviceError && status !=
=3D
> kAudioHardwareNoError) { coreaudio_logerr(status, "Could not resume
> playback"); }
> @@ -528,7 +529,7 @@ static void
> update_device_playback_state(coreaudioVoiceOut *core) } else {
>          /* stop playback */
>          if (isrunning) {
> -            status =3D AudioDeviceStop(core->outputDeviceID,
> +            status =3D AudioDeviceStop(core->device_id,
>                                       core->ioprocid);
>              if (status !=3D kAudioHardwareBadDeviceError && status !=3D
> kAudioHardwareNoError) { coreaudio_logerr(status, "Could not pause
> playback"); @@ -538,22 +539,22 @@ static void
> update_device_playback_state(coreaudioVoiceOut *core) }
>=20
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
>=20
>      bql_lock();
>=20
> -    if (core->outputDeviceID) {
> +    if (core->device_id) {
>          fini_out_device(core);
>      }
>=20
>      if (!init_out_device(core)) {
> -        update_device_playback_state(core);
> +        update_out_device_playback_state(core);
>      }
>=20
>      bql_unlock();
> @@ -563,7 +564,7 @@ static OSStatus handle_voice_change(
>  static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
>  {
>      OSStatus status;
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;
> +    CoreaudioVoiceOut *core =3D (CoreaudioVoiceOut *)hw;
>      int err;
>      Audiodev *dev =3D hw->s->dev;
>      AudiodevCoreaudioPerDirectionOptions *cpdo =3D dev->u.coreaudio.out;
> @@ -581,13 +582,14 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct
> audsettings *as) as->fmt =3D AUDIO_FORMAT_F32;
>      audio_pcm_init_info(&hw->info, as);
>=20
> -    core->frameSizeSetting =3D audio_buffer_frames(
> +    core->frame_size_setting =3D audio_buffer_frames(
>          qapi_AudiodevCoreaudioPerDirectionOptions_base(cpdo), as, 11610);
>=20
> -    core->bufferCount =3D cpdo->has_buffer_count ? cpdo->buffer_count : =
4;
> +    core->buffer_count =3D cpdo->has_buffer_count ? cpdo->buffer_count :=
 4;
>=20
>      status =3D AudioObjectAddPropertyListener(kAudioObjectSystemObject,
> -                                            &voice_addr,
> handle_voice_change, +                                          =20
> &voice_out_addr,
> +                                            handle_voice_out_change,
>                                              core);
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_playback_logerr(status,
> @@ -597,8 +599,8 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct
> audsettings *as)
>=20
>      if (init_out_device(core)) {
>          status =3D
> AudioObjectRemovePropertyListener(kAudioObjectSystemObject, -            =
 =20
>                                     &voice_addr,
> -                                                   handle_voice_change,
> +                                                   &voice_out_addr,
> +                                                   handle_voice_out_chan=
ge,
> core);
>          if (status !=3D kAudioHardwareNoError) {
>              coreaudio_playback_logerr(status,
> @@ -615,11 +617,11 @@ static void coreaudio_fini_out (HWVoiceOut *hw)
>  {
>      OSStatus status;
>      int err;
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;
> +    CoreaudioVoiceOut *core =3D (CoreaudioVoiceOut *)hw;
>=20
>      status =3D AudioObjectRemovePropertyListener(kAudioObjectSystemObjec=
t,
> -                                               &voice_addr,
> -                                               handle_voice_change,
> +                                               &voice_out_addr,
> +                                               handle_voice_out_change,
>                                                 core);
>      if (status !=3D kAudioHardwareNoError) {
>          coreaudio_logerr(status, "Could not remove voice property change
> listener"); @@ -636,10 +638,10 @@ static void coreaudio_fini_out
> (HWVoiceOut *hw)
>=20
>  static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
>  {
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *)hw;
> +    CoreaudioVoiceOut *core =3D (CoreaudioVoiceOut *)hw;
>=20
>      core->enabled =3D enable;
> -    update_device_playback_state(core);
> +    update_out_device_playback_state(core);
>  }
>=20
>  static void audio_coreaudio_class_init(ObjectClass *klass, const void
> *data)





