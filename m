Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7F1E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 12:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsh5P-0005A2-Dz; Wed, 18 Feb 2026 07:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsh5L-00059V-Pv
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 07:55:19 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsh5J-00059t-6G
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 07:55:19 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6BC2BC057C;
 Wed, 18 Feb 2026 15:55:11 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:53d::1:1b] (unknown
 [2a02:6bf:8080:53d::1:1b])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9tZQLl3Af4Y0-qfFxqomB; Wed, 18 Feb 2026 15:55:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771419310;
 bh=G8VebO2XDlnCmoPGJpsn+Uv5rVG3nxJWif3juMCwFLs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dKUP6dvlrmZ8wiOJpOylATWEplTPQTzhUjsFkGTV2U5An4bkYL53foiSO9xP21wAJ
 pu387jovdXqfNz7ICXFrTevM+Kt8nLKeVh6fdO1k4/zBPhn+Y6ZZHIEuxqAw8GlZhA
 kI228vU19RCCbg1jVjaLc1ZHTE0HxFwqYrrYoNro=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d8ee4d25-3abe-4e72-b39f-88a1a584d901@yandex-team.ru>
Date: Wed, 18 Feb 2026 15:55:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] audio: add `audio` build option for meson and Kconfig
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sergei Heifetz <heifetz@yandex-team.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <20260217052740.114117-2-heifetz@yandex-team.com>
 <CAFEAcA9y-QEaiRZMrYadQWJ1KgnHxT8Fkqt1uS0PkbY0Sb-_3Q@mail.gmail.com>
 <d09950dc-dd3e-45ca-b54a-cbdff9f71e0d@redhat.com>
 <CAFEAcA_Q78GwXS0Uia1fFdPoDwkofD4Wr080EkG01gGD-d8Pgg@mail.gmail.com>
 <aZQ_bo7SvivJb7Sd@redhat.com>
 <8b4373d7-f065-4f66-ab81-bc83f970d5f7@yandex-team.com>
 <aZWZa8j8dPQG6BGM@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aZWZa8j8dPQG6BGM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 18.02.26 13:50, Daniel P. Berrangé wrote:
> On Wed, Feb 18, 2026 at 01:52:06PM +0500, Sergei Heifetz wrote:
>> On 2/17/26 15:14, Daniel P. Berrangé wrote:
>>> On Tue, Feb 17, 2026 at 10:06:19AM +0000, Peter Maydell wrote:
>>>> On Tue, 17 Feb 2026 at 09:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>> On 2/17/26 10:31, Peter Maydell wrote:
>>>>>> On Tue, 17 Feb 2026 at 05:29, Sergei Heifetz <heifetz@yandex-team.com> wrote:
>>>>>>> This patch adds the `audio` option to meson_options.txt. It is
>>>>>>> propagated into Kconfig as AUDIO. It is enabled by default.
>>>>>>> The corresponding `--disable-audio` and `--enable-audio` options
>>>>>>> for `configure` are also added.
>>>>>>>
>>>>>>> For now, this option does nothing. In subsequent patches, it will
>>>>>>> gradually disable audio in different places. The final goal is to stop
>>>>>>> building sources from `audio/` and `hw/audio/` and other audio-related
>>>>>>> files (except for some stubs). Note that this intent is different from
>>>>>>> `-audio none`, which mutes audio but still compiles the audio subsystem.
>>>>>> Not building audio/ code makes sense, but do we really want to
>>>>>> stop building hw/audio code ? That's the guest facing audio
>>>>>> devices, and if for instance a machine type has an embedded
>>>>>> sound device that would require us to stop compiling that
>>>>>> machine. I think it would be very confusing for users if
>>>>>> --disable-audio meant "we will silently not build half the
>>>>>> Arm boards that have a pl041 in them".
>>>>>>
>>>>>> Maybe it would be better if "--disable-audio" meant "don't build
>>>>>> the audio backends, and everything behaves as if the user
>>>>>> passed -audio none" ?
>>>>> The problem is that "-audio none" uses a silent backend but still keeps
>>>>> all the audio/ code around.  If you prefer to keep the Arm boards
>>>>> around, the solution would be to disable the audio code in the
>>>>> individual pl041 devices with "#ifdef CONFIG_AUDIO", so that the
>>>>> "depends on AUDIO" for pl041 can be removed too.
>>>> This seems weird, though -- why would we put in a lot of ifdefs
>>>> in every single audio device, when we could instead say "if you
>>>> disable audio at build time what you get is something that presents
>>>> the same API as the existing audio backends but does nothing" ?
>>>>
>>>> Also, I think we should be consistent here, not put ifdefs in
>>>> some devices we think are "important" but skip it in others.
>>> If we consider our security boundary guidance, none of these boards
>>> with on-board audio frontends would be considered in scope for
>>> security.
>>>
>>> On arm, only the "virt" board is providing a secure deployment, and
>>> that does not require this --disable-audio functionality.
>>>
>>> The same applies broadly to other arch targets too, with perhaps the
>>> only exception being the "PC speaker" on x86, and a "none" audio
>>> backend should be sufficient there IMHO.
>>>
>>> With regards,
>>> Daniel
>> In some production environments, static analysers are used as part of
>> broader security measures. If such an analyser reports a problem in an
>> unused part of the code, you can’t simply ignore it because it’s unused: you
>> either fix the issue (which is a strange thing to do for unused code) or
>> remove the unused part. This is a general point about why such functionality
>> may be useful for some users.
> 
> IMHO "static analysers complain" is way too weak a justification
> for taking on this work. Code analysers are always incredibly noisy
> and reporting complaints about things that are not worth the cost
> of addressing.
> 

Still we consider such complains as a good reason to drop extra code from
our production build. If we have to spend some time handling Coverity
complains, why not just drop extra parts we don't use, so that static
analyzers will never disturb us about these parts since removal?

Regardless static analyzers, I think it's always good to have a possibility
to not build for production the code which you don't need and don't want to
understand and support.

-- 
Best regards,
Vladimir

