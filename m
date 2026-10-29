Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D40F606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm2 header.b=cVdhOyhs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ysbuc1Xg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZTw-0000wP-21; Thu, 29 Oct 2026 19:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xMZTi-0000vm-Fb
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:24:16 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xMZTf-0005xD-Ub
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:24:14 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id BCF9B7A0155
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:24:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 29 Oct 2026 19:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1793316250; x=1793402650; bh=ddcOPUVTAFU7FDot91p0nWmD6l2Gfo0i
 UJtvIz8vDkQ=; b=cVdhOyhsWtmRQ+HfETEgCCtilelcQGKbhcrL0rPEJITWfabe
 R9Hu3V6YzA3V7WMQuf0BmHDdivZ4DGRiiRbe0eNyyV76KK5ZiALWLBTPjA9QMVaN
 EKPMAcycLjE+SqYj9I4BKkex9892t56LY1AJgTEcDGNgK8GOKL/8/KxcwAb+2KbW
 J3PCyRdp5YzJK6pXKveEqGFc5dOnrq7mt/+q80GT1i+l7XaLbgzIWSJCKGaRhYlx
 zj9o5JAYnyaTx5q5X4DIxUnetc8VICPzDQkDzC6AB6aZ+Zbctqsefi6y5YX3o7ym
 xlJDu63ExSeOO03s1Ab4kEN8vuXtudGZxa6fuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793316250; x=
 1793402650; bh=ddcOPUVTAFU7FDot91p0nWmD6l2Gfo0iUJtvIz8vDkQ=; b=Y
 sbuc1XgSCjSJeDjSVqqsnQ9eBg01u6IrLsEYm7oq8EvhKnzRgxlr7s4UnycoKK3X
 dHVVhRoLtSKznWwrNyA9t40UxbHQxNxwQBQCAJWfton/oLC1HwgRioj1ZWh/nNrv
 O1a9RJtwBJZaQHwiLeyGHg2FmM0o46TucmelkWSunNvjVaoTA3wGjqm+CYUTgT+4
 S2Sp8ot5RAiDUPjQCudJilXzLiVrk3VnLHzkLjAd34SLLAdL5IVCgvnmlgNjpwGb
 +mA93M8wH7/14x4fUXjtppWuOuTgDkx5yK/cnBrBcaVHJ0WxWabgDysHoVm3h5tm
 OCkKGkT/CKuRttJwcCxvw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793316250; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:l96H93ZGiuF305sJ/CTCalNCGZQ1cgtITLC2qkOFf6Goinq
 p6u4fBWe8vP3tlsxLFmEsgHqHoykcCuJ5x71ty378jzp6e+XkvoxltOjot1PIpyg
 Fm6QcBViAsS7TsEhksZfvq6hH4s33p5u0BGa5tc5zpI9VXuCoHMfkiVm8mYc1vET
 1/rFbdtiYGXIIWJfr4sH0UtlzhMuMkKjw659jbv66VGMtbsoBh+x+gETi5xHCBLJ
 100mKTP3eQ0hjxmlkrM2Lj760vOXYU36FapLtxonrR52NafVgh2Wt98z2CsUxCHx
 jyTOTUJFs1wHFQrtuhIVEzMIpqdYyBoDV0eWjgA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:c6DhYvvLO86otWbwfpr0i8oT30BJKQ3pfApRf5zdw5M=:ddcOPUVTAFU7FDot91p0nWmD6l2Gfo0iUJtvIz8vDkQ=;
X-ME-Sender: <xms:mtXjaveNfZTYCMxrWVPHkkJPruEMS1T3XZvdT9INIv4g8pZjZAFHig>
 <xme:mtXjaphHTbbHbFCx0uLb4_xLBos0cIWkeWQuf2GXWDL9R2llPQk0J7tQ304htJvQR
 AVhvkCkmBPeWaPEHB7rZHkUOm73x7n3_2oSehSVIRDFkwYKncZ50OvI>
X-ME-Received: <xmr:mtXjanq-7rgAJbnchfrA_BFDIsC9h0inpfqgug6N997OmZQx0WX4pDQKvKQKwcvxptZQTxdLpDAYiH0YgEhJvsncSl0>
X-ME-Proxy-Cause: dmFkZTFtYQ6x9rp/l08lGhXsJJQK/USMLYmxTPsrdkaZuSRqz1OzimB1PhDJ4lw/q3l1oj
 q98Jv5k+qKUbAxUhbyMS1cZb2TZKj7+WHywiMgLzHsR/YuBNVDY4WEi03C6bRlyO2s2IiS
 ZW1NtsAq/JI/FMClXCZQSLrkxYwMN0o9A8SBJrCUGMh7Kpi6n7e9bwd7Ncqqlb6iBwgs2H
 cg42At3zZApuy+rkiMlJCq56ZEPQQ0H/34bJyqXEvz/vkj/U5Kzq2MMVgm22aZW00GQ94Q
 E7p2vkgeoWmcfLuARggpFkQamZ8jEp/B5cM5GIuEhdjNWKCJ21YXdO2dtrF1jzkiw67nW7
 0N/JrjAiYm9qc4DTTYJdQpp692cztF4p5Ev9GmLZiMyLYoQpHqA7eF17fIVs7Vt382nema
 IJCdGV6S/hNxkCF6NjZJ4mtDqXpt+oPhcXJHJ+lraELMUoMsCWY98pK18lg2yBQYVj3geR
 /QvWXuycZpyznUVitEOF0OUbC7+GAA7SyYObhkP1zW5dI54AFtummxCaLa+hFvlkBSrNcg
 Am64rs7nsY2FlmSY2fPbaZuAWv7hzEqLKJfvp6RDneYoWoynODyVwZm1A4IZLfk7b8yIeA
 TDes5Io8WIqhLrRdA04BFtsBtOTOmFVUp05voPRsJvtmC1FjiC43jnJucPRg
X-ME-Proxy: <xmx:mtXjapGtElO52Xegdm5lzPTN5LS947CeYAjFun9WxxsQOcoDZ01K9Q>
 <xmx:mtXjahk1DhvsX3BjH37IZpUcRl2cLlHhy7L5WDt480-uUjW45zGVww>
 <xmx:mtXjakmVl9IN5gvEEZ0SvUPRn7zsa3kJjhhN8w5QvDIr_ow3O9_opw>
 <xmx:mtXjaquhVzKu7-NHMR7HPLT3_2WGyV-voqkm7Cp40RM6U7AfI6RKlQ>
 <xmx:mtXjaug2_0ulpvH6BRVywyaTXxU0r11plET4CxNPChbZXgvpW1vfZTtt>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 19:24:08 -0400 (EDT)
Message-ID: <bc9dbd37a2e9302e785d53e278e6b21a6097b882.camel@alistair23.me>
Subject: Re: QEMU Sashiko
From: Alistair <alistair@alistair23.me>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ben Copeland <ben.copeland@linaro.org>
Date: Fri, 30 Oct 2026 09:24:06 +1000
In-Reply-To: <87ecd8acww.fsf@draig.linaro.org>
References: <bfacc761620e29347af03f3b613c6c877b4c1862.camel@alistair23.me>
 <87ecd8acww.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.155;
 envelope-from=alistair@alistair23.me; helo=fhigh-b4-smtp.messagingengine.com
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

On Thu, 2026-10-29 at 12:50 +0000, Alex Benn=C3=A9e wrote:
> Alistair <alistair@alistair23.me> writes:
>=20
> > Hey,
> >=20
> > Sashiko just merged initial support for QEMU [1].
> >=20
> > For those who don't know, Sashiko is a LLM powered review bot used
> > for
> > the Linux kernel. When people send patches to LKML Sashiko reviews
> > the
> > patches and responds to the mailing list with any issue that it
> > finds.
> >=20
> > Like all LLM tools, it is both useful, but also verbose, prone to
> > hallucinations and misses things (like humans do to though). The
> > general consensus in the kernel community is that it's a useful and
> > valuable tool.
>=20
> Linaro has been experimenting with AI reviews as well with our
> patchpilot tool. You can see an example of its output here:
>=20
> =C2=A0 https://patchpilot.linaro.org/run/2749c6de82c1-2#stage=3Dreview=C2=
=A0=20

Oh cool!

>=20
> > Sashiko is just a Rust application and prompts, it doesn't include
> > a
> > LLM and you can use a range of different LLM backends.
> >=20
> > Google sponsors the development and runs a Linux instance. So you
> > can
> > see the hosted Linux instance here: https://sashiko.dev/=C2=A0and it
> > uses
> > Gemini for the LLM which Google pays for. It seems like there is
> > also a
> > GCC one starting up.
>=20
> I don't suppose anyone is interested in sponsoring the token cost?

For a project in general, that's tricky.

I have had luck reviewing patches I'm interested in and haven't hit any
cost limits yet. A small-ish local LLM also works which is mostly free
at that point.

> The
> main reason we haven't deployed it beyond our engineers is the cost
> implications. I assume the reason Google can afford to run it is a
> vested interest in the kernel and owning their own inference
> infrastructure.

I suspect so as well.

It looks like Google is now running Linux and GCC reviews, so maybe
QEMU is next?

>=20
> > The cool thing about Sashiko though is you can run it locally as
> > well,
> > so you can use it to test your patches before sending them to LKML,
> > as
> > long as you have a LLM backend you can use.
> >=20
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
>=20
> Be warned if you enable with an expensive model like Claude a
> moderate
> patch review can very quickly add up to $20-$50 of tokens.=20

Yeah, but there are cheaper cloud models that are almost as good, or
local models that are probably good enough.

>=20
> > The hope with this is to save maintainers time as Sashiko can catch
> > issues without requiring much time from a maintainer.
>=20
> It depends. Some times you end up reading quite a big wall of model
> reasoning text and you end up none the wiser to what it actually
> found
> wrong. On the other hand given engineers are expensive you don't need

That's true.

The Kernel Sashiko sends the results to the original contributor (and
some others), so it puts the burden on the contributor to decipher the
text.

That obviously has a cost, but doesn't add much to a maintainer.

> to
> save much of their time to make the token cost worthwhile.
>=20
> That said I personally feel one under explored area is using cheaper
> models and a common code smells skill that could be useful in
> identifying the obvious nits and mistakes that often come up in the
> first pass review. That would leave maintainers free to spend more
> time
> thinking about the actual logic and design of a patch.

Exactly!

From my experience with Linux and Sashiko I don't even think the latest
and greatest frontier models provide useful input on the design of a
patch.

It's good at catching bugs and issues that humans aren't good at.
Saving maintainers time there, while leaving them to think about the
actual design.

I don't have any hard numbers, but I do suspect a local model could
work fine for this

>=20
> If it was embedded in skills we could hopefully get contributors to
> run
> reviews locally with their own agents before posting a series and
> avoiding the normal RFC feedback of nits and fixes. It would be
> effectively a slightly smarter checkpatch.

Exactly! That's a big part of my hope.

Alistair

>=20
> >=20
> > QEMU support in Sashiko is very new, so it will take some tweaking
> > to
> > improve things, but it is at least a good starting place.
> >=20
> > 1:
> > https://github.com/sashiko-dev/sashiko/commit/e432036bba7ab10d451738591=
6e6c834d8176f70
> >=20
> > Alistair

