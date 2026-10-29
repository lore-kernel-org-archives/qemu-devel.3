Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622260A2612
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm2 header.b=AQP313Mh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=YTw0nNSz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZY6-0001ov-M0; Thu, 29 Oct 2026 19:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xMZY4-0001l1-77
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:28:44 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xMZY2-0006Hs-Il
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:28:43 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 923CF1D00125
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:28:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 29 Oct 2026 19:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1793316521; x=1793402921; bh=KvwjSUEpIeDs5fvoviAZ2i/wZb2B7j6w
 qPs2AC0R8N8=; b=AQP313MhCWfIUs2+ENBeQkGJ1rEeU56ApTvsl2w5RUQ1L+EQ
 xVTAzdcoiC2fkHm50EZrMbp984+Axtnus+sej/5qwKiZJsX5jwl1z+9AJLYrUxtc
 8VpdcOfu4CQixV1zRVV3mT/VJ5oEzVb6feLGNCBenQuNpKVVJDOhuo8upKSBaePb
 nc3XXcpORegcgAjIGmQdAX9+R5hnm9LBDIMQOBi8jRFr6sPFANTORAS2LxdOR1L9
 175bAQN6y+mgtDl6EyclTmdNUfGVQjt+KbPqcCgcxtiCJBmUk8+iHHPDXOfX1K5q
 H3Qg2TdwA+KQQ2mdh6oZoXutNeytBYHsKNGWrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793316521; x=
 1793402921; bh=KvwjSUEpIeDs5fvoviAZ2i/wZb2B7j6wqPs2AC0R8N8=; b=Y
 Tw0nNSz5OA1s+ujWN2pSezEN218XXoo1HwPnpjjbhW8pRlRlfeko8WHN+8SB3giT
 7MJkXV4hpWbiliR3BfQceKggSxdbHmvghaHOiViwSvj5JMKmc+yyyPyWS0SH7cJw
 U70lJsZJC1Ra7+ySuJfDmiU4VVwwVJDgL/K3YyJUDxBFszud7KXf8KK8dQefUPte
 j6vFk4UksueM2rCkhXYHmJD98DRhjuxhKhmX6kNvPne90WDkeCy4+X1UeAgYzQX+
 on7LEwahXc5ss5HsALKhQK89MczciqbWvFvpVcuGGY0ivci8tOo9zriBtpSCPpEu
 uSRgHbi3DSzoeoHuNvOkg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793316521; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:ZvM6rclWx9vQxCRYxJfu/24Bo7Jd+706GzCcFHW9GEsOSJe
 KRdbGXvNQXO6u3taiA9V4uNFyDYKrTvZnJjdnCf/0TusfTbj1WTz3wBBipleUwd4
 gWNh3mANgVItqKXdPHpwTp7EqucyQb/qdWNmfN84mIAmKOGAae1dXZ8yX+RFXNDw
 ta1oyAUil1sP/OQJQOybEj6xQX4rE0gLcADl8lDbsyEAxGPzWS9ZP6667F1qL5Lq
 G/McKAzQMyFmo0St/ylfLelY/eWfjmL3YuPy+owndWzWdaN2bcdZsrriMsPoNjJs
 zeduidS/jD1BCcxGRCcoWOjzqrXk05VS9en4UfQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:MqpcGVUkqM7sbneAIcNVbJJmgHpb+Pw/g3GYNe6/hIg=:KvwjSUEpIeDs5fvoviAZ2i/wZb2B7j6wqPs2AC0R8N8=;
X-ME-Sender: <xms:qdbjaiS5NaSflgTVvRaR69U6mPoJyPqYkkvXjNAp1VKEbNBHlXhO6A>
 <xme:qdbjakEZEdaI8CraDoufM_OpdMo3-H4YGMxfsbCKs5ety_dP0oLviomx7r67hB7sD
 xDnQKPlS7HEtsdarpwZhljQl80IPPMDcweN5oPjUVEqDjKVhUUTwJg>
X-ME-Received: <xmr:qdbjaikw4zaVjpHpC7UGvOFaZIphaGLuapZbbniGeSkm1hFkjS3q6e-5h9eESAsmfCJ0fGCOAvqR2rv3KSWuS2zBdHQ>
X-ME-Proxy-Cause: dmFkZTEReskjwqYta4X2aMwhRAtp6ZTd1Rc6dvSweg8lq7ogoKQxINDydvRyicGp+zRz5+
 hDv2n5orHP1m9SL7+vp3SAzXCfe2Yq0EN8YczkH5wmQtsSnHT8nZmAahyzZseBheT/E4Hs
 AF0TjzvdtjqB2tnxrOvUymt7e50J3aTSmbGHIc0tdyBBG8XJLUbqmsbAJEA5G9rkH76Jo4
 DEECPzP8bifaFi7UMVqFo+E6tuLgbOsZCazr64+K8lrnNh4RId6Wsx3J58nGUcov8oiNJ4
 /Q3POdlDALu2CGjvOehqG9idfc01vNPJLkBBcxHGFW6mTR6lNfbx0rLhbcrWpFeF692Md/
 VNIASkn8icuh6dmLA3STr2vw6iLBIFyA2BJTHVZCdn3cKwSOl+VRZEwh6dgAOYPcvjKV2O
 s7aSUW9+GXfpt4cnLcDLQ8NIfFGI9Q1kUMuZYRf1T2Xsj0IMdRp3Prf9tR+bjummztSheb
 uSDhHaEzePYdVzBdiylWlf3eblwaDKDCJBShh9Q8BIl/gVtHS1oRPFHxQecyI6hs8E/r0x
 yQybEsy+szUbBhcJWP33ml0vgm31GLYhtJ58k84VofxG8cNNNIo+nza5i/pRGuqipizbbN
 F7p6tsJOHDrY+94NlAgxQz4SzRo+mX965JuTvSZyNUIlwYHQntrVdxhX2l4w
X-ME-Proxy: <xmx:qdbjav32X0jHjA29fITq-5K2d0rDYuMf8vmhyKE3Mvmi3bimhnpRug>
 <xmx:qdbjauRtSFTvfsEr38zs8r5DOZgfuFAQB8KSSk0Q5gLzCcuqZj2IJQ>
 <xmx:qdbjahvrmyNES8Ys5KwXRM1O7_7-d7CTO734vj5GvAmVDP9K3JQt9Q>
 <xmx:qdbjajbaR0_eYvbINCvBJHEvqQ1cOAW3bjgGaZIyf3Z2qTrG9K4OiA>
 <xmx:qdbjaqEIjUD57P2AN8KlL-sod01VOfwOZpRdXFqhzHAMRphansKCSe2U>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 19:28:40 -0400 (EDT)
Message-ID: <8e623c8a15f76c57b294268c628f0fb696db3351.camel@alistair23.me>
Subject: Re: QEMU Sashiko
From: Alistair <alistair@alistair23.me>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Date: Fri, 30 Oct 2026 09:28:37 +1000
In-Reply-To: <auNC9VZJrkHwH4Tm@redhat.com>
References: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
 <auNC9VZJrkHwH4Tm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.146;
 envelope-from=alistair@alistair23.me; helo=fout-b3-smtp.messagingengine.com
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

On Thu, 2026-10-29 at 12:58 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Oct 29, 2026 at 09:32:12AM +1000, Alistair wrote:
> > Hey,
> >=20
> > Sashiko just merged initial support for QEMU [1].
>=20
> snip
>=20
> > So, now that Sashiko also supports QEMU there are two exciting use
> > cases:
> >=20
> > 1. Developers can run it locally to review their patches before
> > sending
> > them to the list. This can catch issues before sending patches
> >=20
> > 2. Maintainers can run an instance to review patches. How you set
> > this
> > up depends on the maintainer and how many tokens you have. Pointing
> > it
> > at the list directly and running it for all patches might be too
> > much,
> > but some combination of manually triggering it for certain patches
> > seems to work well. The Settings.toml file can be setup based on
> > what
> > you want to do.
> >=20
> > The hope with this is to save maintainers time as Sashiko can catch
> > issues without requiring much time from a maintainer.
> >=20
> > QEMU support in Sashiko is very new, so it will take some tweaking
> > to
> > improve things, but it is at least a good starting place.
> >=20
> > 1:
> > https://github.com/sashiko-dev/sashiko/commit/e432036bba7ab10d451738591=
6e6c834d8176f70
>=20
> This has added a large set of documents about QEMU's internals to a
> 3rd party repository. Is there not a way to have Sashiko acquire
> all the review policies from qemu.git directly ?

Sashiko has access to the QEMU tree. Otherwise Sashiko won't go out
onto the internet and access things.

So in theory we can point it at docs or anything else in the QEMU repo.

>=20
> IMHO, the QEMU project/maintauners really ought to own & update
> review
> guidelines directly in our repo, especially as we're already
> intending
> to add lots of relevant information to qemu.git for AI usage in
> general.

That should generally be workable, if we have those guidelines

Alistair

>=20
>=20
> With regards,
> Daniel

