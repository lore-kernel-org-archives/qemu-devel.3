Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA71710FCAE4
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 21:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w82m7-0001QS-A8; Wed, 01 Apr 2026 17:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w82m0-0001PQ-P6
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:06:49 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w82lx-0000pK-CS
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:06:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 663C9C023B;
 Thu, 02 Apr 2026 00:06:40 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:42a::1:b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id b6jTN50LM8c0-Fe294m7R; Thu, 02 Apr 2026 00:06:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1775077599;
 bh=6/MHch6aTHSJZz3ip172PPoHoVD/wG8bxGmp+PJ14YA=;
 h=In-Reply-To:Subject:Cc:Message-Id:Date:References:To:From;
 b=uWhzBvA3n8C5oAaZUkhMNYHShgbq7uSHxODLeiSQjSojSuKDqIBWpDA1u0tn2/AW2
 //ZNjEwIXZI3jyq6DKkYrKoH9l5CDnDd1kjqXYdna66FpmYRjRcbTaJ41zFP7upDV+
 abS7H0L27TRnWwLkBUub65ZfTR4M1iERAKNP61Dg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Apr 2026 02:06:37 +0500
Message-Id: <DHI4HQQ1QT30.25XTP3J19CV42@yandex-team.com>
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
X-Mailer: aerc 0.20.1-262-gc2819a603771-dirty
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-8-heifetz@yandex-team.com>
 <87ms04cksj.fsf@pond.sub.org> <DHHIZYXA11Y7.2Z6AXFKNESH3W@yandex-team.com>
 <87cy0j2c61.fsf@pond.sub.org>
In-Reply-To: <87cy0j2c61.fsf@pond.sub.org>
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

On Wed Apr 1, 2026 at 3:43 PM +05, Markus Armbruster wrote:
> "Sergei Heifetz" <heifetz@yandex-team.com> writes:
>
>> On Thu Mar 19, 2026 at 12:58 PM +05, Markus Armbruster wrote:
>>> Sergei Heifetz <heifetz@yandex-team.com> writes:
>>>
>>>> D-Bus display can be used even when QEMU is configured with
>>>> `--disable-audio`. In that case, audio interface will not be available
>>>> on `/org/qemu/Display1/Audio`.
>>>>
>>>> (The current handling of the situation when audio is enabled but
>>>> no D-Bus-compatible audio backend is available is different and
>>>> hasn=E2=80=99t been changed.)
>>>>
>>>> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
>>>> ---
>>>>  qapi/ui.json    | 2 +-
>>>>  qemu-options.hx | 4 ++++
>>>>  ui/dbus.c       | 8 ++++++++
>>>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/qapi/ui.json b/qapi/ui.json
>>>> index e3da77632a8..62eb05c6091 100644
>>>> --- a/qapi/ui.json
>>>> +++ b/qapi/ui.json
>>>> @@ -1385,7 +1385,7 @@
>>>>    'data'    : { '*rendernode' : 'str',
>>>>                  '*addr': 'str',
>>>>                  '*p2p': 'bool',
>>>> -                '*audiodev': 'str' } }
>>>> +                '*audiodev': { 'type': 'str', 'if': 'CONFIG_AUDIO' } =
} }
>>>
>>> Is this a compatibility break?
>>>
>>> DisplayDBus is only used in DisplayOptions, which is only used as retur=
n
>>> type of query-display-options in the QAPI schema.  However, vl.c also
>>> uses it to parse -display.
>>>
>>> Removing parameter @audiodev from -display is technically a
>>> compatibility break.  However, we're removing an optional paramater tha=
t
>>> would always be rejected when present: it has no valid value, because
>>> there are no audiodevs.
>>>
>>> Removal from query-display-options is similar: it could not be present.
>>>
>>> Removal affects introspection, which could conceivably confuse client.
>>> I don't expect such trouble here, because @audiodev always existed, i.e=
.
>>> there's no real reason to look for it in introspection.
>>>
>>> I think we're okay.  I'm cc'ing the libvirt list just in case.
>>
>> These are questions I would like to know the answers to as well. From my
>> perspective, disabling compilation of the audio subsystem is worth it,
>> but you should expect to potentially tweak a few audio-related things to
>> make it work. I agree that technically makes it a compatibility break.
>> But preserving meaningless parameters (like audiodev in the total
>> absence of audio) certainly makes less sense to me.=20
>>
>>> Do we need a release note?
>>>
>>> Do we need an entry in docs/about/removed-features.rst?  Feels a bit
>>> odd; we're not removing a feature, we're adding one, namely "can compil=
e
>>> out audio".
>>>
>>
>> Maybe we should add something like, "If you compile out audio, be
>> careful with these things: [list of changes]".=20
>>
>> But honestly, I don't know. I'd be happy to add whatever is needed.
>
> I guess a brief release note should suffice.  As long as the affected
> interfaces are obviously audio-related, enumerating them seems
> unnecessary.

Understood, thank you.

>>>> +        (If audio is disabled at compile time via the ``--disable-aud=
io`` option,
>>>> +        no audio backend is used, and none of the audio-related D-Bus=
 interfaces
>>>> +        are exported.)
>>>> [...]
>>>
>>> Well, audio is either compiled in or it isn't.
>>>
>>> If it's compiled in, then why tell the user how things behave when it's
>>> not?
>>>
>>> If it's not compiled in, then why document stuff that doesn't work?  Ho=
w
>>> much of -audiodev still works then?  -audiodev none?  Anything else?
>>
>> I agree it's weird, but I don't see a clear way around it. Simple
>> ifdef'ing isn't possible in a reStructuredText section (at least I
>> couldn't get it to work).
>
> Context: this is in an SRST...ERST section of qemu-options.hx.
>
> As far as I can tell, we simply ignore the possibility of the thing
> being compiled out when we document a thing there.
>
> Drop the patch hunk?

OK.

>>> [...]


