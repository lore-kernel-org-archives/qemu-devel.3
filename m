Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAD1C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY56M-0005Nm-2K; Wed, 15 Jan 2025 10:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tY56K-0005NN-Is
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:14:36 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tY56I-0005JL-Ej
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 10:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=osPShDJHl54wivdfAoq47oc9wtdA59pNSnEF/cqYRC0=; b=TQjgH2jZzF7jSIsO5Q7c4ZAKCv
 QVHvvsZtyLP0zZ/YjmrLVOCF1j11sxqi35wFP9UCrNIret5J7fgqFPsUEzSQv9pDEDc/Jjk33c2SE
 XKTOcc5H2LOURA8k/wnTNCXPVKTmB21wUa/fD4GU1jLTvJTsJSjtDZH/Dtv8QTIh5Gm/ZlZxxB9gt
 no2eJc3d/WgINULCYr3RdcJLB395TIF67rk1EUnlaxDIh/2UkhEEa/vltmCUhs8S8s1eoaLcfbkcO
 tklA7eW2Pn/GvfK9BWdq0A6ou13/LXhyNZBi4zAokPseL9X9ClIWechxREyVktD6nnpG8p8KaEIm+
 dPmsIY69efhx95cS2hUGWjox7eFsaU7UHBLAyHX5mhE7+lDcSY5wsMt5L+TTmJd/GNGpLBXp4psy5
 pYuxyZjWwCaltMjkMGP5/ydC/zCoz9CGdnSqfN2bTfVd7MZW0jPBfHRKz9SaRff2WG2g2GXKECLTw
 io9c35F/MyxcQFJ3V4qPk2B0/lY3ugqXDiw+suQroz1lyMzCQ8YMGi2X8RSsDQQXQeRGbXgfFqYXR
 fIVFcAb+gUehyvietWUWrZBXQQnymxebeUlFmS74ma537ljP9IEv70bJ/4feJqKrAKz65eIgHbD7t
 Y64xD1bEqLSYaHiTyeu2/JFZ0iwGn4woNoUZ4wKsQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v3 1/2] coreaudio: Commit the result of init in the end
Date: Wed, 15 Jan 2025 16:14:28 +0100
Message-ID: <2489919.FfEH3XSh6J@silver>
In-Reply-To: <20250115-coreaudio-v3-1-bdb6bcb5bf9f@daynix.com>
References: <20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com>
 <20250115-coreaudio-v3-1-bdb6bcb5bf9f@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wednesday, January 15, 2025 1:06:55 PM CET Akihiko Odaki wrote:
> init_out_device may only commit some part of the result and leave the
> state inconsistent when it encounters an error. Commit the result in
> the end of the function so that it commits the result iff it sees no

Typo "if".

> error.
> 
> With this change, handle_voice_change can rely on core->outputDeviceID
> to know whether the output device is initialized after calling
> init_out_device.
> 
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

I would probably preserve the name 'outputDeviceID' to make it more clear that
it's for output.

>      AudioValueRange frameRange;
> +    UInt32 audioDevicePropertyBufferFrameSize;
> +    AudioDeviceIOProcID ioprocid;
>  
>      AudioStreamBasicDescription streamBasicDescription = {
>          .mBitsPerChannel = core->hw.info.bits,
> @@ -368,20 +371,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>          .mSampleRate = core->hw.info.freq
>      };
>  
> -    status = coreaudio_get_voice(&core->outputDeviceID);
> +    status = coreaudio_get_voice(&deviceID);
>      if (status != kAudioHardwareNoError) {
>          coreaudio_playback_logerr (status,
>                                     "Could not get default output Device\n");
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
>      }
> @@ -392,31 +394,31 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>      }
>  
>      if (frameRange.mMinimum > core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
> +        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
>          dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
>      } else if (frameRange.mMaximum < core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
> +        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
>          dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
>      } else {
> -        core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
> +        audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
>      }
>  
>      /* set Buffer Frame Size */
> -    status = coreaudio_set_framesize(core->outputDeviceID,
> -                                     &core->audioDevicePropertyBufferFrameSize);
> +    status = coreaudio_set_framesize(deviceID,
> +                                     &audioDevicePropertyBufferFrameSize);
>      if (status == kAudioHardwareBadObjectError) {
>          return 0;
>      }
>      if (status != kAudioHardwareNoError) {
>          coreaudio_playback_logerr (status,
>                                      "Could not set device buffer frame size %" PRIu32 "\n",
> -                                    (uint32_t)core->audioDevicePropertyBufferFrameSize);
> +                                    (uint32_t)audioDevicePropertyBufferFrameSize);

'audioDevicePropertyBufferFrameSize' is declared as UInt32, so I guess the
cast can be dropped.

>          return status;
>      }
>  
>      /* get Buffer Frame Size */
> -    status = coreaudio_get_framesize(core->outputDeviceID,
> -                                     &core->audioDevicePropertyBufferFrameSize);
> +    status = coreaudio_get_framesize(deviceID,
> +                                     &audioDevicePropertyBufferFrameSize);
>      if (status == kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -425,11 +427,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>                                      "Could not get device buffer frame size\n");
>          return status;
>      }
> -    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;

Are you sure this should be deferred to the end of the function?

>  
>      /* set Samplerate */
> -    status = coreaudio_set_streamformat(core->outputDeviceID,
> -                                        &streamBasicDescription);
> +    status = coreaudio_set_streamformat(deviceID, &streamBasicDescription);
>      if (status == kAudioHardwareBadObjectError) {
>          return 0;
>      }
> @@ -437,7 +437,6 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>          coreaudio_playback_logerr (status,
>                                     "Could not set samplerate %lf\n",
>                                     streamBasicDescription.mSampleRate);
> -        core->outputDeviceID = kAudioDeviceUnknown;
>          return status;
>      }
>  
> @@ -451,20 +450,24 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>       * Therefore, the specified callback must be designed to avoid a deadlock
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
> +    core->audioDevicePropertyBufferFrameSize = audioDevicePropertyBufferFrameSize;
> +    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
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
> 



