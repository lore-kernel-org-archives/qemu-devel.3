Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F1CC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjki-0007Ki-0V; Fri, 17 Jan 2025 05:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tYjkf-0007K5-Ma
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:38:57 -0500
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tYjkc-0006If-7h
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:38:57 -0500
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-467a1ee7ff2so17921401cf.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 02:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1737110332; x=1737715132;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=swiXWho5QAXQvhlv2krTu7TFuplimhFFonyGQaJEzqo=;
 b=khWhloRmm6xXi941PBYA8CwN8xQ5/C74BBcTKXd7CJ9pmWe3XHy7laXB0w8ljzXo/q
 2kklLkJLkYFiGGXPlXyjA8o5cMvp1j6QxfmdUOd8e1oe4DRtQ/MxJJzy18Ebsj+PTKsI
 xbf2A18QPe5M1nbvHeBx/ZWLSYOriakJkLaLLTOs9SEm/ji2IZwlvV/4d6NJ313vgADv
 HlP8MM9ZB4+Vg8+qtDQ1ee0YHbH4CnWxbvYutYjPUyi+boMs3Ais4xKPZYq2LMjM6c13
 ONzs4/xAYUunWqE6je7H2lt5PO6WA/rydJie6iKbRMZlKWV+iMAXBcir4PrEkrOCsYvN
 Cr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737110332; x=1737715132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=swiXWho5QAXQvhlv2krTu7TFuplimhFFonyGQaJEzqo=;
 b=dgyD8Hn7zcws+lb/FdbdOrAMAt/G4FZeKUr6rany53UWKNoxMW9NeP+Zy/QgzBPeSy
 2Sn6TZXTpXLCeOgcXiuHhSHlCignt78hKKaJsRQpq0cHhE4dDR0B4sXISUaqMS9DXKzZ
 /gjP2WpCwiH6cXX8IH/CCe1+hqX0oCO6z5SoBcDxPxjMDI6eZXAlyngE93S8GLkkk+3n
 iJ3erUCiElyLi+BnKAEED00FiXAQlnf55lEy+r5r4XF8x+3KdeUkeETZimq76kJI3cec
 ipwhW8d629wf0g8I9tAFYoEv8sTV2fz3YMB8F1h1l1mb/nZPo/rgL+r84MATqgHu4JlY
 P5MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUds9L4wMRS0AoZPhkf6CxLhnWoerKOV+dpl4MVIpChClltgKUk3pSrZ+pJ8TPRFkAlDia3T9NYiEB@nongnu.org
X-Gm-Message-State: AOJu0YzpNukKR6jwDo0F5I5rnUo+byT1hjocSEdB7Sgkd/NMBt+grBQ7
 akdzVoeBvreXvMrfVT1izzmq7nCl6CguGIo0Izn2z8dng1NeYtxNct+Tmy42yOnV21bNADb+yyZ
 53sqfGR+OqHBudDK+QlYLF9knMFluWalkSHm7Tbxp8QFmi4l/0w==
X-Gm-Gg: ASbGnctkixwHbr3yFh3aalD4sw8MRWK1eawClZ1ARnjP8ecoTzBFRdy88O5vh2cmYTn
 y4HQa3J1GdaYg+LVIUJjAK8JgVhuDbgP4MnWJZw==
X-Google-Smtp-Source: AGHT+IHdnlS+RX/kbEgGVTuSOsfA4sbYs3S5NqRnKV8u5mNqnsWPlkuI76KeVE4ctIQKAqrNAudiFCyVkKaQ1NzBQac=
X-Received: by 2002:a17:90b:5201:b0:2ee:d797:40a4 with SMTP id
 98e67ed59e1d1-2f782c70204mr3032036a91.8.1737110322053; Fri, 17 Jan 2025
 02:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20250117-coreaudio-v4-0-f8d4fa4cb5f4@daynix.com>
 <20250117-coreaudio-v4-1-f8d4fa4cb5f4@daynix.com>
In-Reply-To: <20250117-coreaudio-v4-1-f8d4fa4cb5f4@daynix.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Fri, 17 Jan 2025 11:38:31 +0100
X-Gm-Features: AbW1kvb8NAfRtWmKZBrUc05IVDYE29T65OCqGguLCUljkCPGrIr_fffhHl3S-fI
Message-ID: <CAGCz3vutSY8=EDik3mH+m4Ek7v+2Lh=9=+Xjh5cgT04mgcCn2w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] coreaudio: Commit the result of init in the end
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 devel@daynix.com
Content-Type: multipart/alternative; boundary="000000000000aea29a062be483be"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::836;
 envelope-from=lists@philjordan.eu; helo=mail-qt1-x836.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000aea29a062be483be
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jan 2025 at 07:48, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> init_out_device may only commit some part of the result and leave the
> state inconsistent when it encounters a fatal error or the device gets
> unplugged during the operation, which is expressed by
> kAudioHardwareBadObjectError or kAudioHardwareBadDeviceError. Commit the
> result in the end of the function so that it commits the result iff it
> sees no fatal error and the device remains plugged.
>
> With this change, handle_voice_change can rely on core->outputDeviceID
> to know whether the output device is initialized after calling
> init_out_device.
>

Apologies if this is a basic question, but I'm seeing this code for the
first time: What if init_out_device() is called from handle_voice_change()
because the system audio device changed though, will outputDeviceID be
valid on those error conditions? I assume those
kAudioHardwareBadObjectError checks are defending against the case where
the device disappears after coreaudio_get_voice() returned a valid audio
device.

So for example, we start out with the audio device being one of two devices
exposed by a compound device. The compound device is unplugged, but the
system audio sub-device appears to the system to be removed first, so the
second sub-device briefly becomes the system audio device. We get the
handle_voice_change() call, handle_voice_change() returns the second
sub-device, but then that one disappears too before we reach the end of
init_out_device(). We error out, but in this case outputDeviceID would
remain the same as the original device which has actually disappeared.

Or have I misunderstood?



> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  audio/coreaudio.m | 49 +++++++++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
>
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index cadd729d5053..b9e1a952ed37 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -355,7 +355,10 @@ static OSStatus audioDeviceIOProc(
>  static OSStatus init_out_device(coreaudioVoiceOut *core)
>  {
>      OSStatus status;
> +    AudioDeviceID deviceID;
>      AudioValueRange frameRange;
> +    UInt32 audioDevicePropertyBufferFrameSize;
> +    AudioDeviceIOProcID ioprocid;
>
>      AudioStreamBasicDescription streamBasicDescription = {
>          .mBitsPerChannel = core->hw.info.bits,
> @@ -368,20 +371,19 @@ static OSStatus init_out_device(coreaudioVoiceOut
> *core)
>          .mSampleRate = core->hw.info.freq
>      };
>
> -    status = coreaudio_get_voice(&core->outputDeviceID);
> +    status = coreaudio_get_voice(&deviceID);
>      if (status != kAudioHardwareNoError) {
>          coreaudio_playback_logerr (status,
>                                     "Could not get default output
> Device\n");
>          return status;
>      }
> -    if (core->outputDeviceID == kAudioDeviceUnknown) {
> +    if (deviceID == kAudioDeviceUnknown) {
>          dolog ("Could not initialize playback - Unknown Audiodevice\n");
>          return status;
>      }
>
>      /* get minimum and maximum buffer frame sizes */
> -    status = coreaudio_get_framesizerange(core->outputDeviceID,
> -                                          &frameRange);
> +    status = coreaudio_get_framesizerange(deviceID, &frameRange);
>      if (status == kAudioHardwareBadObjectError) {
>          return 0;
>
     }
> @@ -392,31 +394,31 @@ static OSStatus init_out_device(coreaudioVoiceOut
> *core)
>      }
>
>      if (frameRange.mMinimum > core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize = (UInt32)
> frameRange.mMinimum;
> +        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
>          dolog ("warning: Upsizing Buffer Frames to %f\n",
> frameRange.mMinimum);
>      } else if (frameRange.mMaximum < core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize = (UInt32)
> frameRange.mMaximum;
> +        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
>          dolog ("warning: Downsizing Buffer Frames to %f\n",
> frameRange.mMaximum);
>      } else {
> -        core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
> +        audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
>      }
>
>      /* set Buffer Frame Size */
> -    status = coreaudio_set_framesize(core->outputDeviceID,
> -
>  &core->audioDevicePropertyBufferFrameSize);
> +    status = coreaudio_set_framesize(deviceID,
> +                                     &audioDevicePropertyBufferFrameSize);
>      if (status == kAudioHardwareBadObjectError) {
>          return 0;
>      }
>      if (status != kAudioHardwareNoError) {
>          coreaudio_playback_logerr (status,
>                                      "Could not set device buffer frame
> size %" PRIu32 "\n",
> -
> (uint32_t)core->audioDevicePropertyBufferFrameSize);
> +
> (uint32_t)audioDevicePropertyBufferFrameSize);
>          return status;
>      }
>
>      /* get Buffer Frame Size */
> -    status = coreaudio_get_framesize(core->outputDeviceID,
> -
>  &core->audioDevicePropertyBufferFrameSize);
> +    status = coreaudio_get_framesize(deviceID,
> +                                     &audioDevicePropertyBufferFrameSize);
>      if (status == kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -425,11 +427,9 @@ static OSStatus init_out_device(coreaudioVoiceOut
> *core)
>                                      "Could not get device buffer frame
> size\n");
>          return status;
>      }
> -    core->hw.samples = core->bufferCount *
> core->audioDevicePropertyBufferFrameSize;
>
>      /* set Samplerate */
> -    status = coreaudio_set_streamformat(core->outputDeviceID,
> -                                        &streamBasicDescription);
> +    status = coreaudio_set_streamformat(deviceID,
> &streamBasicDescription);
>      if (status == kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -437,7 +437,6 @@ static OSStatus init_out_device(coreaudioVoiceOut
> *core)
>          coreaudio_playback_logerr (status,
>                                     "Could not set samplerate %lf\n",
>                                     streamBasicDescription.mSampleRate);
> -        core->outputDeviceID = kAudioDeviceUnknown;
>          return status;
>      }
>
> @@ -451,20 +450,24 @@ static OSStatus init_out_device(coreaudioVoiceOut
> *core)
>       * Therefore, the specified callback must be designed to avoid a
> deadlock
>       * with the callers of AudioObjectGetPropertyData.
>       */
> -    core->ioprocid = NULL;
> -    status = AudioDeviceCreateIOProcID(core->outputDeviceID,
> +    ioprocid = NULL;
> +    status = AudioDeviceCreateIOProcID(deviceID,
>                                         audioDeviceIOProc,
>                                         &core->hw,
> -                                       &core->ioprocid);
> +                                       &ioprocid);
>      if (status == kAudioHardwareBadDeviceError) {
>          return 0;
>      }
> -    if (status != kAudioHardwareNoError || core->ioprocid == NULL) {
> +    if (status != kAudioHardwareNoError || ioprocid == NULL) {
>          coreaudio_playback_logerr (status, "Could not set IOProc\n");
> -        core->outputDeviceID = kAudioDeviceUnknown;
>          return status;
>      }
>
> +    core->outputDeviceID = deviceID;
> +    core->audioDevicePropertyBufferFrameSize =
> audioDevicePropertyBufferFrameSize;
> +    core->hw.samples = core->bufferCount *
> core->audioDevicePropertyBufferFrameSize;
> +    core->ioprocid = ioprocid;
> +
>      return 0;
>  }
>
> @@ -548,7 +551,9 @@ static OSStatus handle_voice_change(
>          fini_out_device(core);
>      }
>
> -    if (!init_out_device(core)) {
> +    init_out_device(core);
> +
> +    if (core->outputDeviceID) {
>          update_device_playback_state(core);
>      }
>
>
> --
> 2.47.1
>
>
>

--000000000000aea29a062be483be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 17 Jan =
2025 at 07:48, Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
">akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">init_out_device may only commit some part of the =
result and leave the<br>
state inconsistent when it encounters a fatal error or the device gets<br>
unplugged during the operation, which is expressed by<br>
kAudioHardwareBadObjectError or kAudioHardwareBadDeviceError. Commit the<br=
>
result in the end of the function so that it commits the result iff it<br>
sees no fatal error and the device remains plugged.<br>
<br>
With this change, handle_voice_change can rely on core-&gt;outputDeviceID<b=
r>
to know whether the output device is initialized after calling<br>
init_out_device.<br></blockquote><div><br></div><div>Apologies if this is a=
 basic question, but I&#39;m seeing this code for the first time: What if i=
nit_out_device() is called from handle_voice_change() because the system au=
dio device changed though, will outputDeviceID be valid on those error cond=
itions? I assume those kAudioHardwareBadObjectError checks are defending ag=
ainst the case where the device disappears after coreaudio_get_voice() retu=
rned a valid audio device.</div><div><br></div><div>So for example, we star=
t out with the audio device being one of two devices exposed by a compound =
device. The compound device is unplugged, but the system audio sub-device a=
ppears to the system to be removed first, so the second sub-device briefly =
becomes the system audio device. We get the handle_voice_change() call, han=
dle_voice_change() returns the second sub-device, but then that one disappe=
ars too before we reach the end of init_out_device(). We error out, but in =
this case outputDeviceID would remain the same as the original device which=
 has actually disappeared.</div><div><br></div><div>Or have I misunderstood=
?<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
---<br>
=C2=A0audio/coreaudio.m | 49 +++++++++++++++++++++++++++-------------------=
---<br>
=C2=A01 file changed, 27 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/audio/coreaudio.m b/audio/coreaudio.m<br>
index cadd729d5053..b9e1a952ed37 100644<br>
--- a/audio/coreaudio.m<br>
+++ b/audio/coreaudio.m<br>
@@ -355,7 +355,10 @@ static OSStatus audioDeviceIOProc(<br>
=C2=A0static OSStatus init_out_device(coreaudioVoiceOut *core)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0OSStatus status;<br>
+=C2=A0 =C2=A0 AudioDeviceID deviceID;<br>
=C2=A0 =C2=A0 =C2=A0AudioValueRange frameRange;<br>
+=C2=A0 =C2=A0 UInt32 audioDevicePropertyBufferFrameSize;<br>
+=C2=A0 =C2=A0 AudioDeviceIOProcID ioprocid;<br>
<br>
=C2=A0 =C2=A0 =C2=A0AudioStreamBasicDescription streamBasicDescription =3D =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.mBitsPerChannel =3D core-&gt;hw.info.bit=
s,<br>
@@ -368,20 +371,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *co=
re)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.mSampleRate =3D core-&gt;hw.info.freq<br=
>
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
-=C2=A0 =C2=A0 status =3D coreaudio_get_voice(&amp;core-&gt;outputDeviceID)=
;<br>
+=C2=A0 =C2=A0 status =3D coreaudio_get_voice(&amp;deviceID);<br>
=C2=A0 =C2=A0 =C2=A0if (status !=3D kAudioHardwareNoError) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0coreaudio_playback_logerr (status,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Could not get de=
fault output Device\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (core-&gt;outputDeviceID =3D=3D kAudioDeviceUnknown) {<br=
>
+=C2=A0 =C2=A0 if (deviceID =3D=3D kAudioDeviceUnknown) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dolog (&quot;Could not initialize playbac=
k - Unknown Audiodevice\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* get minimum and maximum buffer frame sizes */<br>
-=C2=A0 =C2=A0 status =3D coreaudio_get_framesizerange(core-&gt;outputDevic=
eID,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
amp;frameRange);<br>
+=C2=A0 =C2=A0 status =3D coreaudio_get_framesizerange(deviceID, &amp;frame=
Range);<br>
=C2=A0 =C2=A0 =C2=A0if (status =3D=3D kAudioHardwareBadObjectError) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 =C2=
=A0 =C2=A0}<br>
@@ -392,31 +394,31 @@ static OSStatus init_out_device(coreaudioVoiceOut *co=
re)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (frameRange.mMinimum &gt; core-&gt;frameSizeSetting)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 core-&gt;audioDevicePropertyBufferFrameSize =
=3D (UInt32) frameRange.mMinimum;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 audioDevicePropertyBufferFrameSize =3D (UInt32=
) frameRange.mMinimum;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dolog (&quot;warning: Upsizing Buffer Fra=
mes to %f\n&quot;, frameRange.mMinimum);<br>
=C2=A0 =C2=A0 =C2=A0} else if (frameRange.mMaximum &lt; core-&gt;frameSizeS=
etting) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 core-&gt;audioDevicePropertyBufferFrameSize =
=3D (UInt32) frameRange.mMaximum;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 audioDevicePropertyBufferFrameSize =3D (UInt32=
) frameRange.mMaximum;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dolog (&quot;warning: Downsizing Buffer F=
rames to %f\n&quot;, frameRange.mMaximum);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 core-&gt;audioDevicePropertyBufferFrameSize =
=3D core-&gt;frameSizeSetting;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 audioDevicePropertyBufferFrameSize =3D core-&g=
t;frameSizeSetting;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* set Buffer Frame Size */<br>
-=C2=A0 =C2=A0 status =3D coreaudio_set_framesize(core-&gt;outputDeviceID,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;core-&gt;au=
dioDevicePropertyBufferFrameSize);<br>
+=C2=A0 =C2=A0 status =3D coreaudio_set_framesize(deviceID,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;audioDevice=
PropertyBufferFrameSize);<br>
=C2=A0 =C2=A0 =C2=A0if (status =3D=3D kAudioHardwareBadObjectError) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (status !=3D kAudioHardwareNoError) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0coreaudio_playback_logerr (status,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Could not =
set device buffer frame size %&quot; PRIu32 &quot;\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint32_t)core-&gt;aud=
ioDevicePropertyBufferFrameSize);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (uint32_t)audioDeviceP=
ropertyBufferFrameSize);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* get Buffer Frame Size */<br>
-=C2=A0 =C2=A0 status =3D coreaudio_get_framesize(core-&gt;outputDeviceID,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;core-&gt;au=
dioDevicePropertyBufferFrameSize);<br>
+=C2=A0 =C2=A0 status =3D coreaudio_get_framesize(deviceID,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;audioDevice=
PropertyBufferFrameSize);<br>
=C2=A0 =C2=A0 =C2=A0if (status =3D=3D kAudioHardwareBadObjectError) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -425,11 +427,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *cor=
e)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Could not =
get device buffer frame size\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 core-&gt;hw.samples =3D core-&gt;bufferCount * core-&gt;audi=
oDevicePropertyBufferFrameSize;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* set Samplerate */<br>
-=C2=A0 =C2=A0 status =3D coreaudio_set_streamformat(core-&gt;outputDeviceI=
D,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;str=
eamBasicDescription);<br>
+=C2=A0 =C2=A0 status =3D coreaudio_set_streamformat(deviceID, &amp;streamB=
asicDescription);<br>
=C2=A0 =C2=A0 =C2=A0if (status =3D=3D kAudioHardwareBadObjectError) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -437,7 +437,6 @@ static OSStatus init_out_device(coreaudioVoiceOut *core=
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0coreaudio_playback_logerr (status,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Could not set sa=
mplerate %lf\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 streamBasicDescription=
.mSampleRate);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 core-&gt;outputDeviceID =3D kAudioDeviceUnknow=
n;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -451,20 +450,24 @@ static OSStatus init_out_device(coreaudioVoiceOut *co=
re)<br>
=C2=A0 =C2=A0 =C2=A0 * Therefore, the specified callback must be designed t=
o avoid a deadlock<br>
=C2=A0 =C2=A0 =C2=A0 * with the callers of AudioObjectGetPropertyData.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 core-&gt;ioprocid =3D NULL;<br>
-=C2=A0 =C2=A0 status =3D AudioDeviceCreateIOProcID(core-&gt;outputDeviceID=
,<br>
+=C2=A0 =C2=A0 ioprocid =3D NULL;<br>
+=C2=A0 =C2=A0 status =3D AudioDeviceCreateIOProcID(deviceID,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 audioDev=
iceIOProc,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cor=
e-&gt;hw,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;core=
-&gt;ioprocid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;iopr=
ocid);<br>
=C2=A0 =C2=A0 =C2=A0if (status =3D=3D kAudioHardwareBadDeviceError) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (status !=3D kAudioHardwareNoError || core-&gt;ioprocid =
=3D=3D NULL) {<br>
+=C2=A0 =C2=A0 if (status !=3D kAudioHardwareNoError || ioprocid =3D=3D NUL=
L) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0coreaudio_playback_logerr (status, &quot;=
Could not set IOProc\n&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 core-&gt;outputDeviceID =3D kAudioDeviceUnknow=
n;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 core-&gt;outputDeviceID =3D deviceID;<br>
+=C2=A0 =C2=A0 core-&gt;audioDevicePropertyBufferFrameSize =3D audioDeviceP=
ropertyBufferFrameSize;<br>
+=C2=A0 =C2=A0 core-&gt;hw.samples =3D core-&gt;bufferCount * core-&gt;audi=
oDevicePropertyBufferFrameSize;<br>
+=C2=A0 =C2=A0 core-&gt;ioprocid =3D ioprocid;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
@@ -548,7 +551,9 @@ static OSStatus handle_voice_change(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fini_out_device(core);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!init_out_device(core)) {<br>
+=C2=A0 =C2=A0 init_out_device(core);<br>
+<br>
+=C2=A0 =C2=A0 if (core-&gt;outputDeviceID) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0update_device_playback_state(core);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
<br>
-- <br>
2.47.1<br>
<br>
<br>
</blockquote></div></div>

--000000000000aea29a062be483be--

