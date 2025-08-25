Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186A5CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 08:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqSmX-0008IY-4r; Mon, 25 Aug 2025 04:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uqSmU-0008I4-2l
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 04:42:22 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uqSmR-0002mQ-5G
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 04:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1756111327; x=1756716127; i=deller@gmx.de;
 bh=TgyjpGt7wdr1VbnK7U1bKpTIdW6jGS/hLsQQe4svRBk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GUF4XatWF7ginM1PAm6tpUXQy2DF3FT31hMEaJ/ZXzWKbPb3IHtzrma+Zaj6cvuN
 Uk/s6AHXMTzrWDtucNsJY4TsQqEsLa9bo/Ri+73ZeH4Xm5GfCYBl5A41aFHrtV8hl
 Df2smooMoSeHKewHP2ZtxadOU7QPC6kJRG0WnnVxhiVcEAG2fDINhUN7f19k0EJZS
 DYiNCmHrPkTUZ/qY8O8/PpNyeqk7j+D0HTz9ywS4ApM64ZcbARNhoqvya8MMCRNjm
 hIIxyqlZ0Wnb/lm2fRqaSTm4uXxFpIvHc6ddrSEsz5VJqciJYDan/f+b6pQkUlBEF
 zNBbeK20wNBV0qdSIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([83.135.217.92]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mplbx-1u9yM614yj-00fiS6; Mon, 25
 Aug 2025 10:42:07 +0200
Message-ID: <b76abf1c-7a9e-4236-ac7f-bc200646fbd0@gmx.de>
Date: Mon, 25 Aug 2025 10:42:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-user + binfmt Credential flag, again
To: Michael Tokarev <mjt@tls.msk.ru>, QEMU Development <qemu-devel@nongnu.org>
References: <f1a22d84-142e-4bc6-8ef0-c05156dcc20a@tls.msk.ru>
 <50e6ca70-5144-45ed-9afc-f15d45274a7b@gmx.de>
 <c70e4ae2-09a6-4287-bd0c-fc8c3ae97180@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <c70e4ae2-09a6-4287-bd0c-fc8c3ae97180@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U0d5Vd3nKNxN0hOti7xbZ8o1uy/ICxNEQ/qufQsz2JMbr7lPPAE
 Fp3pik+AlzheMc7e2xo6mOZ7bFoxlNuqypTQuC5WtfI9tE58CaIG6DHzx2OmPU63Gv1gV2o
 BRIzbKpbXyFTyWwAPKhhIXq5JOHnA6XXJf+y4clP1PUcOrfux9YvFaS2IP3gpY4RD0z1l/6
 Xs4Qu+gg3atM/6gzyKcWQ==
UI-OutboundReport: notjunk:1;M01:P0:/PRSJF0WyeM=;WOh3370AnluVXstbemqvnjGaSqZ
 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
 T0E/xhI=
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

On 8/24/25 13:54, Michael Tokarev wrote:
> On 24.08.2025 13:59, Helge Deller wrote:
>=20
>> In general, just if someone can shoot himself into the foot you should
>> not remove features.
>> Instead, disabling it by default, and adding a big fat warning if peopl=
e
>> enable it is a good way forward.
>=20
> It is not "someone can shoot himself into the foot".
>=20
> We don't ship a configuration option to make /bin/sh suid root.
> This would make a lot of use cases to work, this will simplify a lot
> of stuff, etc.=C2=A0 But we don't have such option.=C2=A0 This is done f=
or a
> reason, - it breaks whole system security concept, entirely.=C2=A0 You
> can chmod u+s /bin/sh on any of your system, but this "configuration
> item" is not even described in any official docs.
>=20
> Unfortunately, qemu's C flag is of this same theme.=C2=A0 It requires a
> tiny effort to get root, compared with `chmod u+s /bin/sh`, but it's
> a trivial way still, just one extra step.=C2=A0 In short, qemu-user C fl=
ag
> breaks whole system security concept.

I think we all are clear why there is a potential security issue.

> This is why it not only shouldn't be on by default but it should not
> exist, at all. =20

And here we disagree.
Based on your argument you should drop the "chmod" command
from debian as well. It's dangerous, so it shouldn't exist
at all! It shouldn't even be documented!
This is a wrong mindset IMHO.

I agree with disabling it by default.
I agree that it should print a fat warning too.
But you should keep it possible for those (few) users to enable
it if they need to use it. In the same manner, that "chmod" still
exists too.

> And if some system is willing to do chmod u+s their /bin/sh, they're
> free to do so, it's not a rocket science or requires a recompile or
> something.
As you know, for those need Qemu's credential flag,
the "chmod u+s /bin/sh" generates many more implications than Qemu's flag,
so they would prefer the qemu credential flag.

Helge

