Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E677CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 10:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqU4H-00028m-Cn; Mon, 25 Aug 2025 06:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uqU4F-00028Z-VB
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:04:47 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uqU49-00033U-60
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1756116278; x=1756721078; i=deller@gmx.de;
 bh=493JMWKh9QqnToNex+/Y/fRUwkwWL3/oyxNwrByKQNg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qFQz3b7DzblbZMJPNxiCfzpnadKnvmIiSqqEgPjGc6cAnEgUeQjDM8WTGwrNs7LD
 ZDMaOx7OJJ6974DFp/lnnAQeUAcBoYzeLDfiiVxTVRWoaH86Hlp3Eg0i5dHO3a36r
 bJU5kGTG3tLVQz5egkBf5wRkgRaksUyc+BtHAGd8O7HYPewSjOlJ60LhSa42TshT6
 1gwKnTZ5YYm/eO3lDTM0szRzpgy/bWCk5pdrN5avn93+TcbqgA06vbuYRAyZmF+xX
 551qsPQZvVkZJSCl5saHtkV5Y2Ris0kUlhc9e+dU0vmS8lvx2mphFVW1Q4jAbTLdi
 +8n291j7u9W69zYsgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([83.135.217.92]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2nK-1uDWbM1W54-00aREi; Mon, 25
 Aug 2025 12:04:38 +0200
Message-ID: <164d0e23-8015-4e6d-b75f-395f2629e2c0@gmx.de>
Date: Mon, 25 Aug 2025 12:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-user + binfmt Credential flag, again
To: Michael Tokarev <mjt@tls.msk.ru>, QEMU Development <qemu-devel@nongnu.org>
References: <f1a22d84-142e-4bc6-8ef0-c05156dcc20a@tls.msk.ru>
 <50e6ca70-5144-45ed-9afc-f15d45274a7b@gmx.de>
 <c70e4ae2-09a6-4287-bd0c-fc8c3ae97180@tls.msk.ru>
 <b76abf1c-7a9e-4236-ac7f-bc200646fbd0@gmx.de>
 <0ca1b15b-911d-44e1-a327-4c72f2274154@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <0ca1b15b-911d-44e1-a327-4c72f2274154@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Co0Uj33yizxzcUghmaaoME1oFTcD9SYphHXJalvNtKxXE3Hhgbh
 oC4Bk/GVefxWzXDz4e7e9U6ER9Vw71l4Ynr4RQiiYdT621C9oJc0X9bigf/3rB53N2cR3Hu
 tLOpaJnMZimgcgHsoiP7C3ittrEXNjX2BBpnbTLTHqg+3y/yF3k2eWciIjbT3SYTghFQho0
 gcPWw1QXJEdQbq++5ywFA==
UI-OutboundReport: notjunk:1;M01:P0:gnbZU23gSdE=;fpUSJBZBTaHjXywK43pEt/lyovq
 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
 MUdj9qQ=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/25/25 11:26, Michael Tokarev wrote:
> On 25.08.2025 11:42, Helge Deller wrote:
>> On 8/24/25 13:54, Michael Tokarev wrote:
>>> On 24.08.2025 13:59, Helge Deller wrote:
>>>
>>>> In general, just if someone can shoot himself into the foot you shoul=
d
>>>> not remove features.
>>>> Instead, disabling it by default, and adding a big fat warning if peo=
ple
>>>> enable it is a good way forward.
>>>
>>> It is not "someone can shoot himself into the foot".
>>>
>>> We don't ship a configuration option to make /bin/sh suid root.
>>> This would make a lot of use cases to work, this will simplify a lot
>>> of stuff, etc.=C2=A0 But we don't have such option.=C2=A0 This is done=
 for a
>>> reason, - it breaks whole system security concept, entirely.=C2=A0 You
>>> can chmod u+s /bin/sh on any of your system, but this "configuration
>>> item" is not even described in any official docs.
>>>
>>> Unfortunately, qemu's C flag is of this same theme.=C2=A0 It requires =
a
>>> tiny effort to get root, compared with `chmod u+s /bin/sh`, but it's
>>> a trivial way still, just one extra step.=C2=A0 In short, qemu-user C =
flag
>>> breaks whole system security concept.
>>
>> I think we all are clear why there is a potential security issue.
>=20
> It is not potential.=C2=A0 It is right there, very much real, -- that's =
the
> whole difference.
>=20
> We've, for example, wireshark which is a big complex GUI app often
> installed suid-root to be able to watch network traffic.=C2=A0 There's a=
lso
> a huge difference between wireshark and qemu, -- while wireshark is
> complex and all, and sure has bugs, it *tries* to be as careful as
> possible, and drops privs once network sockets are open, etc.
>=20
> Qemu, on the other hand, has never been designed to be run in suid
> mode, and does not perform even minimal input sanitizing, it blindly
> follows what the user specified.=C2=A0 Before suid mode can *ever* be
> enabled, we should at least try some minimum to filter env. vars and
> whatnot, so that it is not trivial to own whole system just by running
> a foreign binary.
>=20
> Until this is done, option to run it with suid binaries should not
> exist.
>=20
> BTW, I think we can do a bit better here when I thought.
>=20
> qemu-linux-user can detect if it's running a suid binary, and if yes,
> *and* if any option/environment is specified, just *refuse* to run
> (or drop privs back to euid/egid), instead of trying to sanitize them.
>=20
> With that, we can *try* to enable credentials flag with binfmt, with
> a big fat warning.. maybe.=C2=A0 At least we can think about the possibi=
lity.
>=20
> But not before.=C2=A0 I think.
>=20
> ...
>=20
>> As you know, for those need Qemu's credential flag,
>> the "chmod u+s /bin/sh" generates many more implications than Qemu's fl=
ag,
>> so they would prefer the qemu credential flag.
>=20
> It doesn't matter how good or useful this flag is in qemu-user context.
> Right now, qemu is not prepared to handle it in any sensible way.=C2=A0 =
And
> with that, it doesn't matter how important or useful these use cases
> are: we just don't have what people want, it simply doesn't exist...
>=20
> Maybe a better comparison is not having /bin/sh suid-root, but having
> a *copy* of /bin/sh, say, /bin/suid-sh, which is suid-root.=C2=A0 This i=
s
> what qemu-user currently is - it is not usual system interpreter, it
> is an "alternative" system interpreter, ready to be used when "needed" -
> by anyone, including any evil person.
>=20
> This is not the beginning of this discussion, - first was similar
> arguments on debian mailing lists, following the debian security
> announce of qemu-user dropping the credentials flag.=C2=A0 People also
> started suggesting (or demanding) to have an option to return this
> flag back on.=C2=A0 No, this wont be done, this is not discussable - unt=
il
> qemu has at least minimal input sanitizing, such mode simply does not
> exist, so there's nothing to enable.
>=20
> I'm really surprised, even shocked, why people don't understand such
> simple things.

I'm pretty sure most people here understand this.
And, that you disabled it by default is absolutely right.
Keep it this way!
This saves everyone to run into a disaster by default.

But please keep in mind, that many machines are being used
solely by their owner. No remote login or such. Just being used for develo=
pment.
And on such machines people may need to use qemu being able to
run suid programs.
By hiding/disabling this possibility you patronise those people and
prevent them from using a needed feature in their known & safe environment=
.

Helge

