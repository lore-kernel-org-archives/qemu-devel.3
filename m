Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84743109B495
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 04:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7n45-0003l0-Dr; Wed, 01 Apr 2026 00:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w7n44-0003kq-DH
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:20:24 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w7n41-00034L-TE
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:20:24 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 23692C0232;
 Wed, 01 Apr 2026 07:20:18 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:72f::1:2a])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GKS3ZH0AqKo0-Cxb2utsS; Wed, 01 Apr 2026 07:20:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1775017217;
 bh=2Lt0zh/z//pd5PLZzv6WozSolMHZ//E35zm+B59xdjQ=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-Id:From;
 b=OLsNCkoMSlWP096j1TshxBr0/5sqGU+RpH7kboA0DVUNG8wI1uP86kL988ZjiKrAr
 Ohr8ExnxQpRIwQwvo8UqAHZ5QSvPMFiUGngN0ASPmqUGyzSmrE1+YM5q73w0h06MPl
 55CTJBE3XX2c9pxrere85/H55CqOm0vzeXsFhe8U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 09:20:15 +0500
Message-Id: <DHHJ37V0JNBW.JENSG5ZXL7Z1@yandex-team.com>
Cc: <qemu-devel@nongnu.org>, "Eric Blake" <eblake@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Fabiano Rosas" <farosas@suse.de>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, "Yanan Wang" <wangyanan55@huawei.com>,
 "Zhao Liu" <zhao1.liu@intel.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Dr. David Alan Gilbert"
 <dave@treblig.org>, "Thomas Huth" <thuth@redhat.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Laurent
 Vivier" <lvivier@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>
Subject: Re: [PATCH v3 09/11] audio: do not build audio-related sources with
 --disable-audio
From: "Sergei Heifetz" <heifetz@yandex-team.com>
To: "Markus Armbruster" <armbru@redhat.com>
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
X-Mailer: aerc 0.20.1-262-gc2819a603771-dirty
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-10-heifetz@yandex-team.com>
 <87fr5wcj14.fsf@pond.sub.org>
In-Reply-To: <87fr5wcj14.fsf@pond.sub.org>
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu Mar 19, 2026 at 1:36 PM +05, Markus Armbruster wrote:
> [...]
>> index 2df87b97101..28fda7c8ac3 100644
>> --- a/qapi/audio.json
>> +++ b/qapi/audio.json
>> @@ -540,4 +540,5 @@
>>  # Since: 8.0
>>  ##
>>  { 'command': 'query-audiodevs',
>> -  'returns': ['Audiodev'] }
>> +  'returns': ['Audiodev'],
>> +  'if': 'CONFIG_AUDIO' }
>
> Could we disable all the audio stuff here?
>
> I tried, patch appended.  What do you think?

For some reason, I thought it was undesirable to alter the header files.
That's what I had in mind while working on the series.

In particular, when you previously suggested emptying out audio.json,
I used that idea to find other parts of the source code we can compile
out, but I thought that was it, and that there is no real reason to
actually remove the QAPI definitions.

I don't have any strong arguments against it. If we are okay with
changing the headers, what you suggest makes perfect sense.

>> [...]
>>
>> +#include "qemu/osdep.h"
>> +#include "system/replay.h"
>> +
>> +void replay_audio_in_start(size_t *nsamples)
>> +{
>> +}
>> +void replay_audio_in_sample_lr(uint64_t *left, uint64_t *right)
>> +{
>> +}
>> +void replay_audio_in_finish(void)
>> +{
>> +}
>> +void replay_audio_out(size_t *played)
>> +{
>> +}
>
> Should this go into stubs/ instead?  Genuine question!  I can't tell
> when we use stubs/foo*.c and when we use foo/*stub.c.

I don't think we should move this to stubs/ unless we also move=20
replay/stubs-system.c there. I put the new file in replay/ because=20
that's where these stubs originally came from.

Also, here is a quote from stubs/meson.build: 'If possible, add new
files to other directories, by using "if_false"'.

> [...]

P.S. Thank you for the review and for your suggestions. I'm really
grateful for them. I'm still interested in working on this, and I'm very
sorry it took so long to respond.=20

