Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A4BEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 04:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snsQt-0002J6-0z; Tue, 10 Sep 2024 00:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1snsQr-0002Ia-Ku
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 00:24:49 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1snsQp-0000HI-8t
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 00:24:49 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2055f630934so2812465ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 21:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1725942286; x=1726547086;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KAbDjVp1Qggo+5s3MomGv6/yycwyItBlD9tpI24DWhY=;
 b=EOVsXuWoiphPqlJl7ITGizjYUDkJdL60LqhObF8KYFJtFMljk2vTPcXtsYgn4g+V75
 fOVSbeHq3Ke2TrWICji9awTpqNdN64V5dUdP5weQvXRUj0cBJBv+xIfw5qsObq/2p6q7
 3+OaX2AyBwdblYMqqRIl3VRrJDS++SuIB3spfRz+HLp+I/f88jDIYXWFDtlbjlnKvT3n
 PKELPOMXjCht0YerhhLNwsWN4v2VoqbNeLFwypd8cnSZQP7qDJKLORWy88UDuUMtsNn6
 AIn8Ya7mWl4Elte3n+/Fmqy6yLA5oXC7OW4VTJzg0fJ4ph1lJvtRbUCmoqNGfSKxb273
 VAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725942286; x=1726547086;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KAbDjVp1Qggo+5s3MomGv6/yycwyItBlD9tpI24DWhY=;
 b=bCyuD05jbgMYtwk0TeYadbJd9nbIO/zANnm6EU45DmmEI2ikhbo6VZ8Kf1m9L/VZmM
 wyiIzk0eltuGvJz9U/1Ema6N3M/uYqO8TozjyLiTljEAdFILSjBJlTj3cGO9RYUz27q3
 QALtY6wuIAMFaXdktlRuEqdxH3El3n4c8TIw3labNe7EF2S6LTH65bfDCFNzSe2SXR72
 s6RGlpVaA1VSCBRzmIHJ4OW4CJLA22+rUaOLuMW6hteQfzQ45lW8k5p0Bxl/L3wm9F1a
 KhHyWutNR3F6VMl36BFPV2gFM49wwNGZsAxKVEu+Y6k5K9oLsxEd9/hZxMvtV1USaQh6
 DYzA==
X-Gm-Message-State: AOJu0YwC9mD9fIgMyLx1RrZt0NmU0Xscmn+qPwmBbQJw1aRI925mhPp2
 5+1EP3BTP93rpnsxPyYE+8xOjPpvGLKjLiTfd60TBzdXG2DKCx8ZgitCxNc9J2c=
X-Google-Smtp-Source: AGHT+IFKQV+BC7YjgQBbSSKfo0TwTeDPuTVwyXUSe0n/4ZLAOVZ5OmnrrbI8OmzOcr9PfocjNn3+VQ==
X-Received: by 2002:a17:903:230f:b0:205:9112:efea with SMTP id
 d9443c01a7336-2070a578bdemr98893135ad.35.1725942285525; 
 Mon, 09 Sep 2024 21:24:45 -0700 (PDT)
Received: from [157.82.204.48] ([157.82.204.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f1f4a3sm40711395ad.221.2024.09.09.21.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 21:24:45 -0700 (PDT)
Message-ID: <bd5eb810-cddd-418e-828e-efc8b0fe01ec@daynix.com>
Date: Tue, 10 Sep 2024 13:24:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: support locking on change medium
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20240909015847.40377-1-j@getutm.app>
 <dab54af1-cf9d-401c-a11f-657334b52d5a@daynix.com>
 <CA+E+eSAu1T_juXxyu9VZMmNtbcais3GJX_vomk5MFOLjCCKo3Q@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CA+E+eSAu1T_juXxyu9VZMmNtbcais3GJX_vomk5MFOLjCCKo3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2024/09/09 23:18, Joelle van Dyne wrote:
> On Mon, Sep 9, 2024 at 12:36 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/09/09 10:58, Joelle van Dyne wrote:
>>> New optional argument for 'blockdev-change-medium' QAPI command to allow
>>> the caller to specify if they wish to enable file locking.
>>>
>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>>> ---
>>>    qapi/block.json                | 23 ++++++++++++++++++++++-
>>>    block/monitor/block-hmp-cmds.c |  2 +-
>>>    block/qapi-sysemu.c            | 22 ++++++++++++++++++++++
>>>    ui/cocoa.m                     |  1 +
>>>    4 files changed, 46 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/qapi/block.json b/qapi/block.json
>>> index e66666f5c6..35e8e2e191 100644
>>> --- a/qapi/block.json
>>> +++ b/qapi/block.json
>>> @@ -309,6 +309,23 @@
>>>    { 'enum': 'BlockdevChangeReadOnlyMode',
>>>      'data': ['retain', 'read-only', 'read-write'] }
>>>
>>> +##
>>> +# @BlockdevChangeFileLockingMode:
>>> +#
>>> +# Specifies the new locking mode of a file image passed to the
>>> +# @blockdev-change-medium command.
>>> +#
>>> +# @auto: Use locking if API is available
>>> +#
>>> +# @off: Disable file image locking
>>> +#
>>> +# @on: Enable file image locking
>>> +#
>>> +# Since: 9.2
>>> +##
>>> +{ 'enum': 'BlockdevChangeFileLockingMode',
>>> +  'data': ['auto', 'off', 'on'] }
>>
>> You can use OnOffAuto type instead of defining your own.
> 
> This can be done. I had thought that defining a new type makes the
> argument more explicit about the meaning.

Speaking of semantics, it would be better to use OnOffAuto to match 
BlockdevOptionsFile's locking property.

We could also argue that having a dedicated type would make this 
consistent with the read-only-mode property, which has such a type, but 
there are other properties that use existing types like str and bool so 
I think it is fine to use an existing type here too.

> 
>>
>>> +
>>>    ##
>>>    # @blockdev-change-medium:
>>>    #
>>> @@ -330,6 +347,9 @@
>>>    # @read-only-mode: change the read-only mode of the device; defaults
>>>    #     to 'retain'
>>>    #
>>> +# @file-locking-mode: change the locking mode of the file image; defaults
>>> +#     to 'auto' (since: 9.2)
>>> +#
>>>    # @force: if false (the default), an eject request through
>>>    #     blockdev-open-tray will be sent to the guest if it has locked
>>>    #     the tray (and the tray will not be opened immediately); if true,
>>> @@ -378,7 +398,8 @@
>>>                'filename': 'str',
>>>                '*format': 'str',
>>>                '*force': 'bool',
>>> -            '*read-only-mode': 'BlockdevChangeReadOnlyMode' } }
>>> +            '*read-only-mode': 'BlockdevChangeReadOnlyMode',
>>> +            '*file-locking-mode': 'BlockdevChangeFileLockingMode' } }
>>>
>>>    ##
>>>    # @DEVICE_TRAY_MOVED:
>>> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
>>> index bdf2eb50b6..ff64020a80 100644
>>> --- a/block/monitor/block-hmp-cmds.c
>>> +++ b/block/monitor/block-hmp-cmds.c
>>> @@ -1007,5 +1007,5 @@ void hmp_change_medium(Monitor *mon, const char *device, const char *target,
>>>        }
>>>
>>>        qmp_blockdev_change_medium(device, NULL, target, arg, true, force,
>>> -                               !!read_only, read_only_mode, errp);
>>> +                               !!read_only, read_only_mode, false, 0, errp);
>>>    }
>>> diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
>>> index e4282631d2..8064bdfb3a 100644
>>> --- a/block/qapi-sysemu.c
>>> +++ b/block/qapi-sysemu.c
>>> @@ -311,6 +311,8 @@ void qmp_blockdev_change_medium(const char *device,
>>>                                    bool has_force, bool force,
>>>                                    bool has_read_only,
>>>                                    BlockdevChangeReadOnlyMode read_only,
>>> +                                bool has_file_locking_mode,
>>> +                                BlockdevChangeFileLockingMode file_locking_mode,
>>>                                    Error **errp)
>>>    {
>>>        BlockBackend *blk;
>>> @@ -362,6 +364,26 @@ void qmp_blockdev_change_medium(const char *device,
>>>            qdict_put_str(options, "driver", format);
>>>        }
>>>
>>> +    if (!has_file_locking_mode) {
>>> +        file_locking_mode = BLOCKDEV_CHANGE_FILE_LOCKING_MODE_AUTO;
>>> +    }
>>> +
>>> +    switch (file_locking_mode) {
>>> +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_AUTO:
>>> +        break;
>>> +
>>> +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_OFF:
>>> +        qdict_put_str(options, "file.locking", "off");
>>> +        break;
>>> +
>>> +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_ON:
>>> +        qdict_put_str(options, "file.locking", "on");
>>> +        break;
>>> +
>>> +    default:
>>> +        abort();
>>> +    }
>>> +
>>>        medium_bs = bdrv_open(filename, NULL, options, bdrv_flags, errp);
>>>
>>>        if (!medium_bs) {
>>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>>> index 4c2dd33532..6e73c6e13e 100644
>>> --- a/ui/cocoa.m
>>> +++ b/ui/cocoa.m
>>> @@ -1611,6 +1611,7 @@ - (void)changeDeviceMedia:(id)sender
>>>                                           "raw",
>>>                                           true, false,
>>>                                           false, 0,
>>> +                                       false, 0,
>>
>> This change is irrelevant.
> 
> This change is needed otherwise QEMU will not compile.

I misread the code. I thought of it is a whitespace change for an 
existing line but it is adding a line. This change in cocoa.m is fine.

Regards,
Akihiko Odaki

