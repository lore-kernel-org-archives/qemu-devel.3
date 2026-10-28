Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC62606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm2 header.b=TYKqIed0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=BFkU0M5i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMD82-0004yJ-5t; Wed, 28 Oct 2026 19:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xMD80-0004yA-V7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:32:21 -0400
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xMD7z-0004ZE-69
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 19:32:20 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 061771D00124
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:32:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 28 Oct 2026 19:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1793230335; x=1793316735; bh=JK
 roMVD4jDzSxYLOmTbLgpwHQLPcFP5kv72YjM/Jhi4=; b=TYKqIed0kXpUq44wA2
 dPWG9bAMiJGUpR3LrdjMt2QmRWYdvzl4KmrOOJH76VSr9EVJZxhG9WJm+KudAzkL
 gSnVmjVzmuW9gS2Ynka1wWwPoMH/qnVMx5oOaX+dMFu8xEq2tjBy2JzQbcYUkrqd
 dOl8cm35V5J7E91uGoFWUywdaIgMKk4Qgma8ES3CaLDpAW8hlzVhF/wfGrZS3dh/
 lp+dmpWRZo9fx4+o9VvVenP3L7hWN6xiw90XJmA+npVujwRxV7w/niglnDoGJI9k
 nvWHcmiSFBJTkPgSv8n2qnCtXgFQm2v2R38u2pUcsm9AdRZS9SOYxxf06Cfdxu9F
 ZXEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1793230335; x=1793316735; bh=JKroMVD4jDzSxYLOmTbLgpwHQLPcFP5kv72
 YjM/Jhi4=; b=BFkU0M5iwzTbjczfbDd5nrbEoA8p2bF//OvJO1dC0/BiO2JqE4B
 tFhaKO9AazRV4R3yMNsc0nwZyPlPDrt7vZLsluXIhdyhsdQ/yiy2PwtMX3n3AiNu
 luGAt5TgsXYJ5Wyms0xoNt2TmXzKRHM5SK5hy02BTxeySUWoJH3LIOp3/adDmpUu
 Lh2wLDmuXsjFLTjLrRX9q9RUci40wasv1zSGEenEh5JEHE0D7MQ4AYFnq2gJjy5N
 m0AX4ZHBHI1JhEJmjxCgVEVipT4PH9bMRs5d1Eu+TdBKRUaPRcnAIcWKZYlO/r3w
 1glCT4nW56QELXip5DJx7QHPUgwfDvWXxcQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793230335; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:YUnZWJkSpF61hC258S4thdxfUIesIwgJ8rw2wuyJrMRzwMv
 iYAehlKPODCvmyoU9zHTzvhnpraqYOyWN43h27wO5G9nrg0WJNmuxuvNdxXpxu3k
 qrkhx6W9zw6vzSZQghLcg0n7TJ+eSjQ26v5KoSW8gMSVvQ1+aksriQkmEQcEjbiR
 sJJU475yfp4JbJFsuh/GCGgeYVfm70Ja1OVpFemDjaH7jadqzJ3sFwK4UtkwLWDp
 mZaz2KPT9LPfwXkCeunI1PLCOKc/2rWhp/Y2bizayjxyVwDY/twRc3UnGuGWIoXK
 vkypq3HLXi4xb0NQ0+eUM+2247dznpLo5wI/uEg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=content-transfer-encoding,content-type,date,feedback-id,from,
 message-id,mime-version,subject,to,user-agent;
Message-Instance: m=1;
 h=sha256:3qGfb0caqiOCIFJYdsg0IhVvJ1rKYME3T8cIOKyLMEk=:JKroMVD4jDzSxYLOmTbLgpwHQLPcFP5kv72YjM/Jhi4=;
X-ME-Sender: <xms:_4XiamvYCGj9eETzoFekYtx8qoyBPF6HeyjivrZZ7Gzr4T1cCP3CYA>
 <xme:_4XiahXZdf08d42bVcxtYru8PPk8k4oJVVjqJB8cklF4YGCu2767cgLHlq3wipr3s
 MMgr9C-o0_f0iCn_8YbKgNAA3iYKTbfjdpWCoyAYBxjBuWl44hcSu-IpA>
X-ME-Received: <xmr:_4Xias0YQyouo_NGn5c-4Q7CB2rBkdKJMUpygzHn7XsBF4oMLPicHeOSiFuTF0wGXBcz49_Iu2ifigv387XBjp_F7dY>
X-ME-Proxy-Cause: dmFkZTEuYjEP7u7/0vPAc3W3VgRmF7NwwIdDBD7aSYvQbNamtK3HsC8GnDebS2GZ0wJV3E
 5/aN+URhQqbMctlZ9Lhlduqlx5IjkLa2phcXCpaECuqoM+UIv0bcH7Gk1l6wyWbGWEi7hY
 hSHrNeo8btSOK3LW/LABOuEXN30LfzGo1NHqRaTQEiHpUw83FGjIssjQt22/6Mb6CE/me5
 km8QLO1OIGZS+vJUk/fr+fUb/+LV5Wv9xqn/D6zkhlZ+Zg8CNGjYlkqCE4XX9IVwuRg398
 l3D71mPvqloRJkl9MAWWq11dNJEvtuRNSOvb9FxhBbJMYQuSQEY/jVNOjKpI/vZ09lrKnA
 0JHQ/UniWLhqvlQbayH0FysdTpsgumNO6a4ggd8sTJj3AFqkxrNF1PO8kFfqrAElW9E8eV
 Z4rtqYPtGPa02aTu3HYuM2DPk1f3dYqLnmAGiYR3oNa8XjuTBwCZAke0DUsS1S2SgYcXsg
 NOpctwmvHhvz9FbI2dRg2iI64z1UqKrFII9HrQ/vfFPRblUNdksPVC0wNRlXvtlfbhKheQ
 JnL9W4KxQy2RTzwMHlntMmtpLHtr/+2eicf5Dfr+KaoQhdq3NnunDfTltTYOZuWDjwycil
 UEkepQ6L5zqWo3D4tvZVlehsJBKqyqkdbbcbUCAkXahnHvo2rJNAreUufCOQ
X-ME-Proxy: <xmx:_4XiauDRdZBbYIkjBhJwlpCb3sYjvKVIYW9l_FMBlS28V7OKke6_RQ>
 <xmx:_4XiaqgHXJPj-FXnRoJ_z3E5l78K12ssjvxRpLZ_KqDhZaXFfwfxXw>
 <xmx:_4Xiaq-zZZRWRmT9_-e28hyzYe4DiczQZBzggLTAtoB-WH4c9WE1Yg>
 <xmx:_4Xiau-wNZerEvvTU9RF8yQ3xasejIXTQ08I8r5hGr5wzao4IMyMBA>
 <xmx:_4XiarNIzipWCnAptFpkK1fAn7-hzYn91dXQ4ZYPXi1JoQHopnTjImtP>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:32:14 -0400 (EDT)
Message-ID: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
Subject: QEMU Sashiko
From: Alistair <alistair@alistair23.me>
To: qemu-devel@nongnu.org
Date: Thu, 29 Oct 2026 09:32:12 +1000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.147;
 envelope-from=alistair@alistair23.me; helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey,

Sashiko just merged initial support for QEMU [1].

For those who don't know, Sashiko is a LLM powered review bot used for
the Linux kernel. When people send patches to LKML Sashiko reviews the
patches and responds to the mailing list with any issue that it finds.

Like all LLM tools, it is both useful, but also verbose, prone to
hallucinations and misses things (like humans do to though). The
general consensus in the kernel community is that it's a useful and
valuable tool.

Sashiko is just a Rust application and prompts, it doesn't include a
LLM and you can use a range of different LLM backends.

Google sponsors the development and runs a Linux instance. So you can
see the hosted Linux instance here: https://sashiko.dev/ and it uses
Gemini for the LLM which Google pays for. It seems like there is also a
GCC one starting up.

The cool thing about Sashiko though is you can run it locally as well,
so you can use it to test your patches before sending them to LKML, as
long as you have a LLM backend you can use.

So, now that Sashiko also supports QEMU there are two exciting use
cases:

1. Developers can run it locally to review their patches before sending
them to the list. This can catch issues before sending patches

2. Maintainers can run an instance to review patches. How you set this
up depends on the maintainer and how many tokens you have. Pointing it
at the list directly and running it for all patches might be too much,
but some combination of manually triggering it for certain patches
seems to work well. The Settings.toml file can be setup based on what
you want to do.

The hope with this is to save maintainers time as Sashiko can catch
issues without requiring much time from a maintainer.

QEMU support in Sashiko is very new, so it will take some tweaking to
improve things, but it is at least a good starting place.

1:
https://github.com/sashiko-dev/sashiko/commit/e432036bba7ab10d4517385916e6c=
834d8176f70

Alistair

