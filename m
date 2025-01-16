Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F1EC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 10:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYN9w-00033b-UE; Thu, 16 Jan 2025 05:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tYN9v-00033E-C7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:31:31 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tYN9t-0003ix-0J
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=F+WNhE54aT+BQfZhVcCvmAA+7syndUt813Sr4JwrtJ4=; b=FQ7Cd7qtgpRxqifmi+aCXDTm/u
 Zq1cHst7cigrrOXaWKBJx2UWVVfPlBbrtn0V2yM4rHyXEe2TV4ltHMwQe8AZdjzgs4/x2cSLr/LGT
 uIZu/QVyRzwgBMf5GysJiIkk1JwdtViMXIQdY1bzkb+Fis+v/1SvEEjwOuhBuZF33HUD/v9gJGnps
 Adj39Zh4UUmNWAGv3704XYcUU8PCLD2wt6YMvMX9LzmRx0F+nAHMjbSPNk1RN7A5cDTSqf0qq6Cmy
 fl3Ous7BujTGjsUxEOMhUYIlLYZIUosNn/GPUlnFMY4hm8qg3h1muXZhThvBcQIr06HR6E7TsQmI8
 mIbyenaK88WTCKwEdTiRY5ocd+pRpvwk2b61WLVH7uQcJaLezdpVVFWiZ4DkzLna15ILjMLz1Jn71
 gly4JES+Hk/FArbgmqNUr9GmhQk4Qwknib6irYwqP+32Vjzox6sWjKzFbUEFGYtXLpkZ47ZyOWoSy
 KtWJw1dHHPAMSLbJ1EIIn9+jitu2nEVC3stySTbPSVvNAePnGK9LeggP7DF2XD0WauGKT8MKQcH3D
 zKmwduTul8pd3oL1/Q7jiUGcZgUqAyEHDtcCOogG5nnZE48Q+StVas3JLQ9T8tz/H9gSG6n5gsKIp
 V6OUZz0pug3azoph2vboobwWo5yYAn06rk5T39U0Y=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v3 1/2] coreaudio: Commit the result of init in the end
Date: Thu, 16 Jan 2025 11:31:24 +0100
Message-ID: <3819111.rtVrN0WL8X@silver>
In-Reply-To: <7f183c25-2e70-4bc7-b3bb-0f488743f13e@daynix.com>
References: <20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com>
 <7790509.UIITUpbOhM@silver>
 <7f183c25-2e70-4bc7-b3bb-0f488743f13e@daynix.com>
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

On Thursday, January 16, 2025 6:17:46 AM CET Akihiko Odaki wrote:
> On 2025/01/16 2:10, Christian Schoenebeck wrote:
> > On Wednesday, January 15, 2025 4:37:28 PM CET Akihiko Odaki wrote:
> >> On 2025/01/16 0:14, Christian Schoenebeck wrote:
> >>> On Wednesday, January 15, 2025 1:06:55 PM CET Akihiko Odaki wrote:
> >>>> init_out_device may only commit some part of the result and leave the
> >>>> state inconsistent when it encounters an error. Commit the result in
> >>>> the end of the function so that it commits the result iff it sees no
> >>>
> >>> Typo "if".
> >>
> >> I meant if and only if.
> >>
> >>>
> >>>> error.
> >>>>
> >>>> With this change, handle_voice_change can rely on core->outputDeviceID
> >>>> to know whether the output device is initialized after calling
> >>>> init_out_device.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> ---
> >>>>    audio/coreaudio.m | 49 ++++++++++++++++++++++++++
+----------------------
> >>>>    1 file changed, 27 insertions(+), 22 deletions(-)
> >>>>
> >>>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> >>>> index cadd729d5053..b9e1a952ed37 100644
> >>>> --- a/audio/coreaudio.m
> >>>> +++ b/audio/coreaudio.m
> >>>> @@ -355,7 +355,10 @@ static OSStatus audioDeviceIOProc(
> >>>>    static OSStatus init_out_device(coreaudioVoiceOut *core)
> >>>>    {
> >>>>        OSStatus status;
> >>>> +    AudioDeviceID deviceID;
> >>>
> >>> I would probably preserve the name 'outputDeviceID' to make it more 
clear that
> >>> it's for output.
> >>
> >> I omitted output because this function is for the output device; every
> >> variable in this function is for output and prefixing them with output
> >> makes the code verbose.
> > 
> > Disagree. When you review audio driver code there are many 'devices', so 
it is
> > helpful to see the context straight away. Especially on large functions 
like
> > this one.
> 
> It is not special to the device ID. Other variables like frameRange, 
> audioDevicePropertyBufferFrameSize, and ioprocid are bound to this 
> output device. In theory we could have similar corresponding variables 
> for the input device so they should be prefixed with "output" if it 
> matters. Prefixing only this variable is inconsistent.
> 
> > 
> >>>
> >>>>        AudioValueRange frameRange;
> >>>> +    UInt32 audioDevicePropertyBufferFrameSize;
> >>>> +    AudioDeviceIOProcID ioprocid;
> >>>>    
> >>>>        AudioStreamBasicDescription streamBasicDescription = {
> >>>>            .mBitsPerChannel = core->hw.info.bits,
> >>>> @@ -368,20 +371,19 @@ static OSStatus init_out_device(coreaudioVoiceOut 
*core)
> >>>>            .mSampleRate = core->hw.info.freq
> >>>>        };
> >>>>    
> >>>> -    status = coreaudio_get_voice(&core->outputDeviceID);
> >>>> +    status = coreaudio_get_voice(&deviceID);
> >>>>        if (status != kAudioHardwareNoError) {
> >>>>            coreaudio_playback_logerr (status,
> >>>>                                       "Could not get default output 
Device\n");
> >>>>            return status;
> >>>>        }
> >>>> -    if (core->outputDeviceID == kAudioDeviceUnknown) {
> >>>> +    if (deviceID == kAudioDeviceUnknown) {
> >>>>            dolog ("Could not initialize playback - Unknown 
Audiodevice\n");
> >>>>            return status;
> >>>>        }
> >>>>    
> >>>>        /* get minimum and maximum buffer frame sizes */
> >>>> -    status = coreaudio_get_framesizerange(core->outputDeviceID,
> >>>> -                                          &frameRange);
> >>>> +    status = coreaudio_get_framesizerange(deviceID, &frameRange);
> >>>>        if (status == kAudioHardwareBadObjectError) {
> >>>>            return 0;
> >>>>        }
> >>>> @@ -392,31 +394,31 @@ static OSStatus init_out_device(coreaudioVoiceOut 
*core)
> >>>>        }
> >>>>    
> >>>>        if (frameRange.mMinimum > core->frameSizeSetting) {
> >>>> -        core->audioDevicePropertyBufferFrameSize = (UInt32) 
frameRange.mMinimum;
> >>>> +        audioDevicePropertyBufferFrameSize = (UInt32) 
frameRange.mMinimum;
> >>>>            dolog ("warning: Upsizing Buffer Frames to %f\n", 
frameRange.mMinimum);
> >>>>        } else if (frameRange.mMaximum < core->frameSizeSetting) {
> >>>> -        core->audioDevicePropertyBufferFrameSize = (UInt32) 
frameRange.mMaximum;
> >>>> +        audioDevicePropertyBufferFrameSize = (UInt32) 
frameRange.mMaximum;
> >>>>            dolog ("warning: Downsizing Buffer Frames to %f\n", 
frameRange.mMaximum);
> >>>>        } else {
> >>>> -        core->audioDevicePropertyBufferFrameSize = core-
>frameSizeSetting;
> >>>> +        audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
> >>>>        }
> >>>>    
> >>>>        /* set Buffer Frame Size */
> >>>> -    status = coreaudio_set_framesize(core->outputDeviceID,
> >>>> -                                     &core-
>audioDevicePropertyBufferFrameSize);
> >>>> +    status = coreaudio_set_framesize(deviceID,
> >>>> +                                     
&audioDevicePropertyBufferFrameSize);
> >>>>        if (status == kAudioHardwareBadObjectError) {
> >>>>            return 0;
> >>>>        }
> >>>>        if (status != kAudioHardwareNoError) {
> >>>>            coreaudio_playback_logerr (status,
> >>>>                                        "Could not set device buffer 
frame size %" PRIu32 "\n",
> >>>> -                                    (uint32_t)core-
>audioDevicePropertyBufferFrameSize);
> >>>> +                                    
(uint32_t)audioDevicePropertyBufferFrameSize);
> >>>
> >>> 'audioDevicePropertyBufferFrameSize' is declared as UInt32, so I guess 
the
> >>> cast can be dropped.
> >>
> >> It had a cast even though core->audioDevicePropertyBufferFrameSize is
> >> also UInt32. I suspect there are some cases where uint32_t and UInt32
> >> are defined as different types and the compiler complains for "wrong"
> >> print format.
> > 
> > This was introduced by cbc36cb05. While changing the format specifier made
> > sense, the cast was unnecessary, but ... never mind.
> > 
> >>>
> >>>>            return status;
> >>>>        }
> >>>>    
> >>>>        /* get Buffer Frame Size */
> >>>> -    status = coreaudio_get_framesize(core->outputDeviceID,
> >>>> -                                     &core-
>audioDevicePropertyBufferFrameSize);
> >>>> +    status = coreaudio_get_framesize(deviceID,
> >>>> +                                     
&audioDevicePropertyBufferFrameSize);
> >>>>        if (status == kAudioHardwareBadObjectError) {
> >>>>            return 0;
> >>>>        }
> >>>> @@ -425,11 +427,9 @@ static OSStatus init_out_device(coreaudioVoiceOut 
*core)
> >>>>                                        "Could not get device buffer 
frame size\n");
> >>>>            return status;
> >>>>        }
> >>>> -    core->hw.samples = core->bufferCount * core-
>audioDevicePropertyBufferFrameSize;
> >>>
> >>> Are you sure this should be deferred to the end of the function?
> >>
> >> Yes. Setting core->hw.samples only makes sense after
> >> AudioDeviceCreateIOProcID() succeeds, which starts generating samples
> >> according to the set value.
> > 
> > OK, I just reviewed the pathes in this function that return zero, and 
realized
> > that these were added by you (3ba6e3f6), however I don't see any comment 
on
> > why you have treated them as returning as non-error cases there.
> 
> kAudioHardwareBadObjectError and kAudioHardwareBadDeviceError imply the 
> device was unplugged. They are not fatal as eventually we will get 
> another active device with the handle_voice_change callback.

It would "imply" a device been unplugged if either two of the constants were 
documented by Apple exactly that way, which is not the case.

What happened instead is that you noticed that this error was returned by the 
CoreAudio API after you unplugged an audio device. That's called "observed".

And that's exactly my point why I think you should be more verbose on your 
changes in general, so that other people can also understand your changes, 
without having to ask you. They are definitely not clear enough for other 
readers.

> > In general I highly recommend to be more verbose on your changes. For 
instance
> > for this patch here it would have helped to see a comment which error path
> > exactly you encountered. Because it makes it more easy for other people to
> > understand what you are trying to fix exactly.
> > 
> > /Christian
> > 
> > 
> 
> 
> 



