Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C5BC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6uu-0007cL-D9; Wed, 15 Jan 2025 12:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tY6us-0007b0-P7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:54 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tY6uq-0006b3-JM
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=HxYPVI0db+zJBEPZe30z7M0BE1l32v4jduW8lkTA9HQ=; b=jp/F3ey/0Ilzki/zFo41GbNZXK
 VlijkZ9HOSeDdVqQ6cLM2P1pt9esr/44HYNa4E9pdp4v+RCgQx6pNNbPpDChZ/Pfi6I9B0VqubUMp
 QzqEtMD+7k9z9QeZHxLyXbwZd0NDlKDi5nKh87QM3hhtrFyemjby7LqXogbw7fCoBVtIzEpi1O5sF
 +Cjnjx7VqHI/iPC/8oyv/bNIk9r5hCsRUunWNBnZSql5eFoPHWwllBXoCa+/Ek16VsBHI04D6Lfq6
 YDMCwyCWy5shbeze1ns6aPxbCczbozDfLe0KtRxJNQPk6Xr3+2asZK/2VDh+g3TDu1btqTN9UKZVv
 yS2YLh2bHb08FhBJUT+/b5sBWAunCsr4ogqO67xHc5nog5+Je4B9KKivg5LsVc+ASop2JA8UmxyXj
 gFtRwxi85G6FNLQWUAsiX52UdWG44Kf9Aj5ERT375r4m4QlyTqXf0hFMphX27uTwQK0Emuq8jjjY5
 7HeyE/cdb77Bpm6zm3iED2u0OdpHnq8qYGryusC1jGxOYX3kOtBN76KCCRTvM8zobrywmxlAtA8gL
 9bVg2lJXy+L6PGpJLMRrEuK5f7NT7XWtGK7fYj92udJ17pMEo0rqs7VE5RQM7T4a4Z5Cl5lY4TN7V
 K6+D1AtOLKn9jWcOwVeW3XFPRJ7t7OuISlDU1Tx1U=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v3 1/2] coreaudio: Commit the result of init in the end
Date: Wed, 15 Jan 2025 18:10:47 +0100
Message-ID: <7790509.UIITUpbOhM@silver>
In-Reply-To: <6383b75b-2dae-4777-a794-644d87b604fc@daynix.com>
References: <20250115-coreaudio-v3-0-bdb6bcb5bf9f@daynix.com>
 <2489919.FfEH3XSh6J@silver>
 <6383b75b-2dae-4777-a794-644d87b604fc@daynix.com>
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

On Wednesday, January 15, 2025 4:37:28 PM CET Akihiko Odaki wrote:
> On 2025/01/16 0:14, Christian Schoenebeck wrote:
> > On Wednesday, January 15, 2025 1:06:55 PM CET Akihiko Odaki wrote:
> >> init_out_device may only commit some part of the result and leave the
> >> state inconsistent when it encounters an error. Commit the result in
> >> the end of the function so that it commits the result iff it sees no
> > 
> > Typo "if".
> 
> I meant if and only if.
> 
> > 
> >> error.
> >>
> >> With this change, handle_voice_change can rely on core->outputDeviceID
> >> to know whether the output device is initialized after calling
> >> init_out_device.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   audio/coreaudio.m | 49 +++++++++++++++++++++++++++----------------------
> >>   1 file changed, 27 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> >> index cadd729d5053..b9e1a952ed37 100644
> >> --- a/audio/coreaudio.m
> >> +++ b/audio/coreaudio.m
> >> @@ -355,7 +355,10 @@ static OSStatus audioDeviceIOProc(
> >>   static OSStatus init_out_device(coreaudioVoiceOut *core)
> >>   {
> >>       OSStatus status;
> >> +    AudioDeviceID deviceID;
> > 
> > I would probably preserve the name 'outputDeviceID' to make it more clear that
> > it's for output.
> 
> I omitted output because this function is for the output device; every 
> variable in this function is for output and prefixing them with output 
> makes the code verbose.

Disagree. When you review audio driver code there are many 'devices', so it is
helpful to see the context straight away. Especially on large functions like
this one.

> > 
> >>       AudioValueRange frameRange;
> >> +    UInt32 audioDevicePropertyBufferFrameSize;
> >> +    AudioDeviceIOProcID ioprocid;
> >>   
> >>       AudioStreamBasicDescription streamBasicDescription = {
> >>           .mBitsPerChannel = core->hw.info.bits,
> >> @@ -368,20 +371,19 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
> >>           .mSampleRate = core->hw.info.freq
> >>       };
> >>   
> >> -    status = coreaudio_get_voice(&core->outputDeviceID);
> >> +    status = coreaudio_get_voice(&deviceID);
> >>       if (status != kAudioHardwareNoError) {
> >>           coreaudio_playback_logerr (status,
> >>                                      "Could not get default output Device\n");
> >>           return status;
> >>       }
> >> -    if (core->outputDeviceID == kAudioDeviceUnknown) {
> >> +    if (deviceID == kAudioDeviceUnknown) {
> >>           dolog ("Could not initialize playback - Unknown Audiodevice\n");
> >>           return status;
> >>       }
> >>   
> >>       /* get minimum and maximum buffer frame sizes */
> >> -    status = coreaudio_get_framesizerange(core->outputDeviceID,
> >> -                                          &frameRange);
> >> +    status = coreaudio_get_framesizerange(deviceID, &frameRange);
> >>       if (status == kAudioHardwareBadObjectError) {
> >>           return 0;
> >>       }
> >> @@ -392,31 +394,31 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
> >>       }
> >>   
> >>       if (frameRange.mMinimum > core->frameSizeSetting) {
> >> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
> >> +        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMinimum;
> >>           dolog ("warning: Upsizing Buffer Frames to %f\n", frameRange.mMinimum);
> >>       } else if (frameRange.mMaximum < core->frameSizeSetting) {
> >> -        core->audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
> >> +        audioDevicePropertyBufferFrameSize = (UInt32) frameRange.mMaximum;
> >>           dolog ("warning: Downsizing Buffer Frames to %f\n", frameRange.mMaximum);
> >>       } else {
> >> -        core->audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
> >> +        audioDevicePropertyBufferFrameSize = core->frameSizeSetting;
> >>       }
> >>   
> >>       /* set Buffer Frame Size */
> >> -    status = coreaudio_set_framesize(core->outputDeviceID,
> >> -                                     &core->audioDevicePropertyBufferFrameSize);
> >> +    status = coreaudio_set_framesize(deviceID,
> >> +                                     &audioDevicePropertyBufferFrameSize);
> >>       if (status == kAudioHardwareBadObjectError) {
> >>           return 0;
> >>       }
> >>       if (status != kAudioHardwareNoError) {
> >>           coreaudio_playback_logerr (status,
> >>                                       "Could not set device buffer frame size %" PRIu32 "\n",
> >> -                                    (uint32_t)core->audioDevicePropertyBufferFrameSize);
> >> +                                    (uint32_t)audioDevicePropertyBufferFrameSize);
> > 
> > 'audioDevicePropertyBufferFrameSize' is declared as UInt32, so I guess the
> > cast can be dropped.
> 
> It had a cast even though core->audioDevicePropertyBufferFrameSize is 
> also UInt32. I suspect there are some cases where uint32_t and UInt32 
> are defined as different types and the compiler complains for "wrong" 
> print format.

This was introduced by cbc36cb05. While changing the format specifier made
sense, the cast was unnecessary, but ... never mind.

> > 
> >>           return status;
> >>       }
> >>   
> >>       /* get Buffer Frame Size */
> >> -    status = coreaudio_get_framesize(core->outputDeviceID,
> >> -                                     &core->audioDevicePropertyBufferFrameSize);
> >> +    status = coreaudio_get_framesize(deviceID,
> >> +                                     &audioDevicePropertyBufferFrameSize);
> >>       if (status == kAudioHardwareBadObjectError) {
> >>           return 0;
> >>       }
> >> @@ -425,11 +427,9 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
> >>                                       "Could not get device buffer frame size\n");
> >>           return status;
> >>       }
> >> -    core->hw.samples = core->bufferCount * core->audioDevicePropertyBufferFrameSize;
> > 
> > Are you sure this should be deferred to the end of the function?
> 
> Yes. Setting core->hw.samples only makes sense after 
> AudioDeviceCreateIOProcID() succeeds, which starts generating samples 
> according to the set value.

OK, I just reviewed the pathes in this function that return zero, and realized
that these were added by you (3ba6e3f6), however I don't see any comment on
why you have treated them as returning as non-error cases there.

In general I highly recommend to be more verbose on your changes. For instance
for this patch here it would have helped to see a comment which error path
exactly you encountered. Because it makes it more easy for other people to
understand what you are trying to fix exactly.

/Christian



