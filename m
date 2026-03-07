Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78FBFC9EC0
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 04:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyj0p-00035S-HD; Fri, 06 Mar 2026 23:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyj0j-00035E-0m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:11:29 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vyj0f-0000Zn-KL
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:11:27 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6274AM4N043990
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 7 Mar 2026 13:11:02 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=DRfM3tVXd5Q1z1GYW13AOxfLtmlHHt4E1OcHEFzbKAQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1772856663; v=1;
 b=GB1nLhG6a/raEya9q50DDG/Ku85UznEa/tBkc4Pae0BL0hbqKKyOkg/PMcNHJD2c
 WAOpaDZMKhOrTzByilOAYY+8V608yjtdTaptgIdE4ZRMzeUhjeDPaNFrqSkd8iH/
 WqJDbPaUJlZmL0nhhZNZHfEDAEx/gpan93D08CNNmlhzRXdNjlEGa2CU1Ojc+XQw
 W1OyHLcPWeku3KdBrxgRkRaOD996+i1MCduUGKCs7BaG30BCLfT2Wj9DQzoKEs+M
 YjZ9GJSozsnFsWdMwTf4vsFtT31fVgf7IngwTn9fmyLaJEmIPddndHZubuULNnah
 rzqaMxkFpiEiTU3WA8cwuA==
Message-ID: <e18e2371-4866-4158-b2c8-dfa159a0b587@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 7 Mar 2026 13:10:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/6] coreaudio: Commit the result of init in the end
To: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-4-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <2042987.yKVeVyVuyW@weasel>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <2042987.yKVeVyVuyW@weasel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/03/04 20:56, Christian Schoenebeck wrote:
> On Wednesday, 4 March 2026 07:16:57 CET Akihiko Odaki wrote:
>> init_out_device may only commit some part of the result and leave the
>> state inconsistent when it encounters a fatal error or the device gets
>> unplugged during the operation, which is expressed by
>> kAudioHardwareBadObjectError or kAudioHardwareBadDeviceError. Commit the
>> result in the end of the function so that it commits the result iff it
>> sees no fatal error and the device remains plugged.
>>
>> With this change, handle_voice_change can rely on core->outputDeviceID
>> to know whether the output device is initialized after calling
>> init_out_device.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   audio/coreaudio.m | 47 ++++++++++++++++++++++++++---------------------
>>   1 file changed, 26 insertions(+), 21 deletions(-)
>>
>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
>> index 736227eb2b7a..23c3d1f80ac5 100644
>> --- a/audio/coreaudio.m
>> +++ b/audio/coreaudio.m
>> @@ -357,8 +357,11 @@ static OSStatus out_device_ioproc(
>>
>>   static OSStatus init_out_device(CoreaudioVoiceOut *core)
>>   {
>> +    AudioDeviceID device_id;
>> +    AudioDeviceIOProcID ioprocid;
>>       AudioValueRange value_range;
>>       OSStatus status;
>> +    UInt32 device_frame_size;
> 
> Shouldn't then be this here at the beginning?
> 
>    core->device_id = kAudioDeviceUnknown;
>    core->ioprocid = NULL;
>    ...

Setting device members is done in correspondence with actual device 
operations. Concretely, fini_out_device() sets kAudioDeviceUnknown to 
device_id to express it finalized the device. This function initializes 
the device or does nothing if an error happens, so it sets device 
members or does not touch otherwise.

> 
> [...]
>>       if (status != kAudioHardwareNoError) {
>>           coreaudio_playback_logerr(status,
>>                                     "Could not set device buffer frame size %" PRIu32,
>> -                                  (uint32_t)core->device_frame_size);
>> +                                  (uint32_t)device_frame_size);
>>           return status;
>>       }
> 
> Why the cast here? device_frame_size is declared as UInt32.

The definition of uint32_t is not literally identical with UInt32, so 
the compiler complains it is different from what the format string 
(PRIu32) expects. I think I'm going to use uint32_t for the variable to 
avoid this.

Regards,
Akihiko Odaki

