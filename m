Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC218C79FAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Coe-0007hc-SH; Wed, 09 Sep 2026 03:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x4Coc-0007hJ-OA
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:33:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1x4Coa-0004SB-S3
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:33:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4858303de5dso6699582f8f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788939231; x=1789544031; darn=nongnu.org;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+Mf04GEji7A/HhsNoBHAi26FGyzSd8Imukxgq0j2pE4=;
 b=Y/HKzuI1aTQaPAc767Moy76Z6AWQxdbq/y8RrO5hW8KafcKcbr20ts34TN6qYU5dYp
 VMn73ylvD3wDrYfNxsoUBCOgrUOxWfY8xVIqr0vkE+fJkt5KK/tKAtyf17BzXg8DeegN
 MLjpN+UZU3BMRsKvyB6DvoPdpI2l9sRIjlJzmcvYOTSagTSV45KHVe7X75a8utXSbg9b
 BzB7465GgKaWBv3Bxmp+NJamLbn3BX+Px3RGVUu45wYoWpdZ0D8vGQRqgM6+4AZz6zUt
 yrDsSLNervE+M2FvPX+dQ0D+Ouit/ofKslJBmcaBQrwqTaisW8JDvfxgtaH+RilZm7tL
 j81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788939231; x=1789544031;
 h=content-type:content-transfer-encoding:mime-version:message-id
 :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Mf04GEji7A/HhsNoBHAi26FGyzSd8Imukxgq0j2pE4=;
 b=JYEfwlrQ72Qv2qADnRSMIPjmqP16ftBnZZGZ5Nwupf7xufgpgM1R/1AQb2gtH3KFhQ
 Ur/7yb9eg31mL/NfomELRtiZjWuWyR7ofqaNHD+M88l62EJVoxO53eHdl4KAxsPGktMd
 IRqvYoqkWLQwGNx5YNtiyil0KpFsUPdiLOoDI9Cnd3NvOp3GV3i2wMuNaPO+bAV9s2eL
 lqG2k4R+jOY71R0WtqmkWqTCEhSj2qo4Sh6Z/oQgCjqqwAl9TtWZnDjSJtfMH0tDadly
 kwRSb76zjc0cIsqa7ol9LvFkES0pp44EOR8rcBTCFfH9XK/Ip1nu48i2TCC/p5IlOC1k
 Eorg==
X-Gm-Message-State: AFuF++mHQyvdjQYr+VN5tHKDulTERF3MvaEt1sylKG+sOXoRaszIGTeg
 TLPaxFMRadfOmldGRNF2UpZgRySCIHT0ccfpGtLWtDeA70aPrcVIO8i2nb9xVDsA548=
X-Gm-Gg: AYBFou1SLUqWnwRc+FqUych/MG+syEwm3NQgUuMfoKuoq31YRwpb0DRMQUBxqsNq9ts
 LWZUu2u11vz+zc75AaGpTNdJ+bKU0SYVNTKvl5TyKWARqgk95zPy1/CHYK/nJ7mFnsalgtfd73K
 GjJvIaj1Pg3jUwy90V7zlWnraOFa+SOB9yWfHrFPFWdBXXM5uqC7OYtHdzekvDWtJCa9SAdSfAy
 s7MQYSQiVf6kd7JM0yRf/XQRo66pEmgFq/4GlCCrv+Cg59RKi9N5MXhJhiznZWNVwnEjfZrNfhE
 NUrXkPc4gXuQtsDqV7gz3JdB9HkMeHk0nf61R0onK4bM5ItC+Stkdbb6lO0mKgVU36MeJbCnuwP
 DVzu7l6En7HHWN/Sjlkq8KOJE4iITFlrIduLOfFUCqxqIgJvle8eQR+cvO/sDYdw5XqZIevF4Iq
 r9lDD2uEhuJ5flbkIPX6+1BRCOv2urlenqpg9TmF45uDeP4mCwosIaEcWkN/Tv2vvAjVPThtXwH
 aVQEbIeTEYmNHsLwlEsZOjwaVvP7kA58xyN4zE6VBLtwb/ZiX0nra2WKLXNO0s9Te/frAIBAzXz
 UuFHSK6ORLP+qQR1moIWbUlXL9MAAmB9oELob7vWaPgA5SG4dvMeyr7U17Nioc9IPXGeDQCv5/k
 uFnLZo8wOrVJZUUeB5qIZpcrUruO4aPJYV6tG
X-Received: by 2002:a05:600c:620e:b0:49c:fc6c:be19 with SMTP id
 5b1f17b1804b1-49cff2078b8mr312130285e9.31.1788939231027; 
 Wed, 09 Sep 2026 00:33:51 -0700 (PDT)
Received: from meli-email.org (athedsl-116222.home.otenet.gr. [85.75.29.157])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5d476esm588714585e9.1.2026.09.09.00.33.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Sep 2026 00:33:50 -0700 (PDT)
Date: Wed, 09 Sep 2026 10:31:37 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Volker R=?UTF-8?B?w7xtZWxpbg==?= <vr_qemu@t-online.de>,
 Marc-Andr=?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 St=?UTF-8?B?w6lwaGFuZQ==?= Graber <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v5 00/10] hw/audio/virtio-sound: basic migration support
User-Agent: meli/0.8.13
References: <20260803081159.91981-1-alexander@mihalicyn.com>
 <CAJqdLrri+kRORx_8cHFhi6cuoVZ1ENup+fprm3XHaVavteHRpQ@mail.gmail.com>
 <CAAjaMXZ80o20S-o7=QbrP+wNKqo==w-9Cc3BfeZGG9DazMTnPA@mail.gmail.com>
 <CAJqdLrqi12b4LdhdBywr9JZ0H=dmEJUy8_-JCV7YRU5UmsiRrQ@mail.gmail.com>
In-Reply-To: <CAJqdLrqi12b4LdhdBywr9JZ0H=dmEJUy8_-JCV7YRU5UmsiRrQ@mail.gmail.com>
Message-ID: <tl36cd.2tad1k4jeakw8@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 31 Aug 2026 10:43, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
>Am Mo., 31. Aug. 2026 um 09:41 Uhr schrieb Manos Pitsidianakis
><manos.pitsidianakis@linaro.org>:
>>
>
>Dear Manos,
>
>> Hi Alexander, so sorry for the massive delay but I'm on PTO for a big
>> part of August and some of September. Your series is on my priorities
>> as soon as I return.
>
>ah, then sorry for bothering you during PTO ;-)
>Have a good time!
>
>Kind regards,
>Alex

I think this series is now fully reviewed, I will rebase against master 
and send a pull request.

Thanks!

>
>>
>> On Mon, Aug 31, 2026 at 10:27 AM Alexander Mikhalitsyn
>> <alexander@mihalicyn.com> wrote:
>> >
>> > Am Mo., 3. Aug. 2026 um 10:12 Uhr schrieb Alexander Mikhalitsyn
>> > <alexander@mihalicyn.com>:
>> > >
>> > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>> > >
>> > > Dear friends,
>> > >
>> > > This patchset is aimed to support virtio-sound live migration and based on
>> > > pre-existing Volker Rümelin's patches from qemu-devel lists [1]. I tried
>> > > to ask (https://lore.kernel.org/qemu-devel/9d7ea128c711c201688a4716f53b8a335fc53569.camel@mihalicyn.com/)
>> > > if Volker is going to continue his work on this, but received no reply so I
>> > > just decided to go forward: take his patches, rebase and resend. Of course,
>> > > I kept all authorship/tags so I hope that it is fine.
>> > >
>> > > Testing.
>> > >
>> > > I manually validated this with Ubuntu 24.04 Desktop VM and found no issues.
>> > > Also, it was validated with CI (https://gitlab.com/mihalicyn/qemu/-/pipelines/2626702088).
>> > >
>> > > Original patchset:
>> > > https://lore.kernel.org/qemu-devel/a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de [1]
>> > >
>> > > Git tree:
>> > > https://gitlab.com/mihalicyn/qemu/-/commits/virtio-sound-migration
>> > >
>> > > Changelog for version 5:
>> > > - rebased
>> > > - added RWB tags
>> > >
>> > > Changelog for version 4:
>> > > - addressed review feedback from Marc-André Lureau
>> > > - and from Manos Pitsidianakis
>> > > *there is a detailed changelog under each commit message*
>> > >
>> > > Changelog for version 3:
>> > > - addressed review feedback from Marc-André Lureau:
>> > >         - drop VirtIOSoundPCMStream's id field (unused)
>> > >         - resurrected error_report(..) in virtio_snd_pcm_start_stop()
>> > >         - fixes in "hw/audio/virtio-sound: add stream state variable"
>> > >           [ please, look in commit message for details ]
>> > >         - added "hw/audio/virtio-sound: remove channel positions field
>> > >           from VirtIOSoundPCMStream"
>> > >         - fixes in "hw/audio/virtio-sound: add missing vmstate fields"
>> > >           [ details in commit message ]
>> > >
>> > > Changelog for version 2:
>> > > - no code changes (only commit messages)
>> > >   followed suggestions from Daniel P. Berrangé (thanks, Daniel!)
>> > >   https://lore.kernel.org/qemu-devel/ajzoxZr4g0Xsr_4p@redhat.com/
>> > >   and added some extra details about what I did with the original
>> > >   patches during rebase (for some of them it was simpler and less error
>> > >   prone to just drop changes and reimplement them by following the idea
>> > >   of the patch, cause base code has changed significantly).
>> > >
>> > > Changelog relative to the original Volker Rümelin's submission:
>> > > - rebased:
>> > >         - "hw/audio/virtio-sound: return correct command response size"
>> > >                 was dropped as it was already merged
>> > >         - "hw/audio/virtio-sound: fix segmentation fault in tx/rx xfer handler"
>> > >                 was dropped as it seems to be replaced with another fix
>> > >                 https://github.com/qemu/qemu/commit/731655f87f319fd06f27282c6cafbc2467ac8045
>> > >         - I had to drop all pre-existing Reviewed-by tags cause it was 2 years since
>> > >           this patchset was sent and reviewed and I did a quite significant code changes
>> > >           during rebase
>> > >
>> > > Kind regards,
>> > > Alex
>> > >
>> > > Alexander Mikhalitsyn (2):
>> > >   hw/audio/virtio-sound: remove channel positions field from
>> > >     VirtIOSoundPCMStream
>> > >   hw/audio/virtio-sound: drop unused struct
>> > >     VirtIOSoundPCMStream.flushing field
>> > >
>> > > Volker Rümelin (8):
>> > >   hw/audio/virtio-sound: remove command and stream mutexes
>> > >   hw/audio/virtio-sound: allocate an array of streams
>> > >   hw/audio/virtio-sound: free all stream buffers on reset
>> > >   hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
>> > >   hw/audio/virtio-sound: add stream state variable
>> > >   hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
>> > >   hw/audio/virtio-sound: introduce virtio_snd_set_active()
>> > >   hw/audio/virtio-sound: add missing vmstate fields
>> > >
>> > >  hw/audio/virtio-snd.c         | 696 ++++++++++++++++++++--------------
>> > >  include/hw/audio/virtio-snd.h |  26 +-
>> > >  2 files changed, 414 insertions(+), 308 deletions(-)
>> > >
>> > > --
>> > > 2.47.3
>> > >
>> >
>> > Gentle ping.
>>
>> --
>> Manos Pitsidianakis
>> Emulation and Virtualization Engineer at Linaro Ltd

