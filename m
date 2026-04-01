Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D15910F9305
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 04:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7n07-0002Hp-2h; Wed, 01 Apr 2026 00:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w7n02-0002He-Fb
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:16:14 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w7mzy-00026g-87
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:16:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id EB25880780;
 Wed, 01 Apr 2026 07:16:03 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:72f::1:2a])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1GSPSF0AjOs0-KqQt0tvg; Wed, 01 Apr 2026 07:16:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1775016963;
 bh=cSu6JV98OLWkrwVVheR+NvcpdFsLV2ZfyebGW+kmluo=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-Id:From;
 b=cUOwEaAMHU1qOKyfIDuNnJJGrCh8OXNmmcoDtfoNCvM9LqMC9qYYJXgL9kbe0Trkx
 HzqYLq6HwrH+At07WB1K9kGax0sMk9w52tqAgnV9n1nAxoCi3RIbTbasA2twkXicTo
 m91KWzOUEJRU8EQWCnPpB/XJ/52CHYRAX7e/e30Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 09:16:01 +0500
Message-Id: <DHHIZYXA11Y7.2Z6AXFKNESH3W@yandex-team.com>
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
 Vivier" <lvivier@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>,
 <devel@lists.libvirt.org>
Subject: Re: [PATCH v3 07/11] ui/dbus: run without Audio interface when
 audio is disabled
From: "Sergei Heifetz" <heifetz@yandex-team.com>
To: "Markus Armbruster" <armbru@redhat.com>
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
X-Mailer: aerc 0.20.1-262-gc2819a603771-dirty
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-8-heifetz@yandex-team.com>
 <87ms04cksj.fsf@pond.sub.org>
In-Reply-To: <87ms04cksj.fsf@pond.sub.org>
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu Mar 19, 2026 at 12:58 PM +05, Markus Armbruster wrote:
> Sergei Heifetz <heifetz@yandex-team.com> writes:
>
>> D-Bus display can be used even when QEMU is configured with
>> `--disable-audio`. In that case, audio interface will not be available
>> on `/org/qemu/Display1/Audio`.
>>
>> (The current handling of the situation when audio is enabled but
>> no D-Bus-compatible audio backend is available is different and
>> hasn=E2=80=99t been changed.)
>>
>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>> ---
>>  qapi/ui.json    | 2 +-
>>  qemu-options.hx | 4 ++++
>>  ui/dbus.c       | 8 ++++++++
>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/ui.json b/qapi/ui.json
>> index e3da77632a8..62eb05c6091 100644
>> --- a/qapi/ui.json
>> +++ b/qapi/ui.json
>> @@ -1385,7 +1385,7 @@
>>    'data'    : { '*rendernode' : 'str',
>>                  '*addr': 'str',
>>                  '*p2p': 'bool',
>> -                '*audiodev': 'str' } }
>> +                '*audiodev': { 'type': 'str', 'if': 'CONFIG_AUDIO' } } =
}
>
> Is this a compatibility break?
>
> DisplayDBus is only used in DisplayOptions, which is only used as return
> type of query-display-options in the QAPI schema.  However, vl.c also
> uses it to parse -display.
>
> Removing parameter @audiodev from -display is technically a
> compatibility break.  However, we're removing an optional paramater that
> would always be rejected when present: it has no valid value, because
> there are no audiodevs.
>
> Removal from query-display-options is similar: it could not be present.
>
> Removal affects introspection, which could conceivably confuse client.
> I don't expect such trouble here, because @audiodev always existed, i.e.
> there's no real reason to look for it in introspection.
>
> I think we're okay.  I'm cc'ing the libvirt list just in case.

These are questions I would like to know the answers to as well. From my
perspective, disabling compilation of the audio subsystem is worth it,
but you should expect to potentially tweak a few audio-related things to
make it work. I agree that technically makes it a compatibility break.
But preserving meaningless parameters (like audiodev in the total
absence of audio) certainly makes less sense to me.=20

> Do we need a release note?
>
> Do we need an entry in docs/about/removed-features.rst?  Feels a bit
> odd; we're not removing a feature, we're adding one, namely "can compile
> out audio".
>

Maybe we should add something like, "If you compile out audio, be
careful with these things: [list of changes]".=20

But honestly, I don't know. I'd be happy to add whatever is needed.

>> +        (If audio is disabled at compile time via the ``--disable-audio=
`` option,
>> +        no audio backend is used, and none of the audio-related D-Bus i=
nterfaces
>> +        are exported.)
>> [...]
>
> Well, audio is either compiled in or it isn't.
>
> If it's compiled in, then why tell the user how things behave when it's
> not?
>
> If it's not compiled in, then why document stuff that doesn't work?  How
> much of -audiodev still works then?  -audiodev none?  Anything else?

I agree it's weird, but I don't see a clear way around it. Simple
ifdef'ing isn't possible in a reStructuredText section (at least I
couldn't get it to work).

> [...]

