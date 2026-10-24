Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABEA606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=XEuwkegw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKdwW-0007cx-R7; Sat, 24 Oct 2026 11:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xKdwO-0007bK-Tw
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:45:57 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xKdwM-0006Yz-VF
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792856745; x=1793461545; i=deller@gmx.de;
 bh=vPO5zwyByGf6otNVRBN37YdwCBhodJIgBWD96MUNgwQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XEuwkegwe69uD29hHD2tZPz/cw1QMti656IgclsR5L9n5NuzzF8CFS02sOJ6mKWN
 rowEYQxuhTUwAqQd+RNv16yQasISa2JmxW4SSCTvY3kIye+qEEWCL308EhEUxIrvh
 SoUrr0XExI1Xl4P99wrCf91nnNcMA0XcnaLUSzr4PXMZFgR8dC6grjkvzNRTcOTeR
 axQuRYOcQqDyknS5N0va+xK0BU7KxA/KarE9T6BTGW6ZJATHIZ5qxA7Y3Jx1OrX7S
 s3qfHQHKKlNdHfLqkHVnTJ98ryHmAF49emSO8txZ1BFSB+cY0YcZX+5tZ0CTXsw3e
 l3pjUN2fPTTbKsz3Mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1wMDEC0HAj-017t3k; Sat, 24
 Oct 2026 17:45:45 +0200
Message-ID: <77ef6350-0e76-427c-9ba1-3f8bdf6c7e71@gmx.de>
Date: Sat, 24 Oct 2026 17:45:43 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user/i386: reject bad CS/SS selectors on
 rt_sigreturn
To: TAKANO Mitsuhiro <takano32@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261024134118.474313-1-takano32@gmail.com>
 <20261024151303.586126-1-takano32@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20261024151303.586126-1-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iTwQeTfSvq8GL5BQ9kXPlabCK/nRzrtTDAtpikutVhA8g0fd58v
 DFtwC+t8qYX9WnsTP+BA2NKjg1WNJZWy30/0w6UaVGTOSUZXKUpo/a6hMgYXnywazJUpMbX
 txJQHMCuxy6C6J024yyJ92tse//d7MVkA/3tytivCsFjD0jGezJDeB+KtcvXIBF30pJe6ye
 6whPX0e66noomlSwENzLA==
UI-OutboundReport: notjunk:1;M01:P0:npRW2p5na0A=;GEHh67X2OmP7Wm3Mxr/cs2B8tbY
 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
 l1E1zv7og==
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 17:13, TAKANO Mitsuhiro wrote:
> Hi Helge,
>=20
> please drop this patch -- it is not needed on master, and I should have
> checked that before posting.
>=20
> The abort reproduces on 10.2.1, but not on master: since
>=20
>    9097087147 ("linux-user: make syscall emulation interruptible")
>=20
> a #GP raised while a syscall is being emulated no longer longjmps out of
> cpu_exec(), so a frame with zeroed CS/SS already ends up as SIGSEGV in t=
he
> guest and qemu survives.  I checked this on a clean master build
> (8967b2fe1b): the same frame exits 0 with the SIGSEGV handler running,
> while a v10.2.1 build aborts with the cpu =3D=3D current_cpu assertion.
>=20
> The same holds for the v1 of this series -- please disregard both.
>=20
> So the fix for 10.2.x is a backport of 9097087147, not this patch, and f=
or
> master there is nothing to fix.
>=20
> Sorry for the noise, and thanks for catching the name.
Ok, patch dropped now.

Helge

