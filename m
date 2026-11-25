Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12594606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ngMcrnrc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWBCW-0001Br-OB; Wed, 25 Nov 2026 06:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWBCT-00019g-TE
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:30:09 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWBCS-0000m6-6H
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:30:09 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-67921b515a7so6031287d50.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:30:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795606207; cv=none;
 d=google.com; s=arc-20260327;
 b=ORJUXOJ3lWjFyR/hQzMtyI3qNiMbefG4e8JLNYcko8IV9MsfvtINspkuxtwm4YqnFM
 KtGaPWxzhC38zC/6SvBexb+ybjM9xjZSsVf2RaZxQRL8MFwPG94RJaU4/DQCWr/2jNjR
 goJg/Zy0rblujK7gjM8BKGqKmEJDavyiwQLDVtlr3qPlMpFrZ4PJyVoA2bP1524A6Yu+
 oEeSmQRilIW0VREWSyEmisOZ5miJKjr5QQyyplhf2PiLmYkDHy+r0IsaqNRWuYcnW4JJ
 xSi605Z/mbesCS3CrWlPhGF+rQp3I/Ry/mkdhpjmfJAtyQeGM8TDThTv/MU1b/5lzX+x
 rfZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BQ5pvnHVxd6cvoHetzlAnlRx74grMcRfjgI1WQG0jN4=;
 fh=j/IDpQ8riROGNSZ9aaAC3mmbmTeh/TiSK0NXsjHRLf0=;
 b=cvDlPbqj4y/YtfwKCyShaOGJ7sBY5AA9w9HYEJZHucHpTnVIlyVWfO/05KBaqbxax0
 wYXp7JV3odY1afNS8ULCaw1XXYdPQ2mTDojzqGu1GDk1r/tG/GPjMhCWE0J+t5gAE9aS
 es9OV1iasK25A8a6eUHAEkQGiG568UPOL2YVp9UzZXu3b/jUaEQF4j+PtGu1X1A0TZB9
 s0XCl4jrpzS5+Cg6h9pvUWR/hOtd2vn/IMXpSYLW3wPeZCaPjKvGt0Bc9eeiWd4CYopP
 qhGYYfZrGhFhLtfcy2pGuq+EbH9Bbm3dmJ331LlrUuXLrhetC6inoTX+pegK4fVmWDfW
 etFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795606207; x=1796211007; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BQ5pvnHVxd6cvoHetzlAnlRx74grMcRfjgI1WQG0jN4=;
 b=ngMcrnrcT22ZYaMDpesSPcE7I7nGEPEgUwuQWDQtIR1cCfd/27iYLMntsSmbgvMQl9
 FnLD+7C9oPs6mb/O895QRTZ7aQq6kRH83bpo0T36qesEkT6I6ZTbBHXBpwxygboG/UqO
 8BzVHWiXiWyqa4aL3VDdcdMV+q6HOoJca2u9MfHKDXpJGtwrHOKAU5TTCKu5FUv/Frx0
 BtHb3Y8fWBKQUaIif3OTfQQQNM68Pro8AnuIS0n02qPuJc71sU7+3ekVh4H2TOs9SV0E
 9tHKoGX5a5PXvreVVhFY3bnu7hvHZkuAsRusfikyGs/yKaE5Iqi4zGn1lUBNlvzkbksD
 XRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606207; x=1796211007;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BQ5pvnHVxd6cvoHetzlAnlRx74grMcRfjgI1WQG0jN4=;
 b=PT8fJNVdxPk52kUP2pVb+h39COBQ8226PHEPc1H3/nz8GodsKwKpxZVDPfG7XVKjnK
 VXusjCkh2OzbikKeh2UI4b04Bi2xKtiWlWPGydw0a3W+Ep2k5YcUEec52p70gOeE0J7m
 3DHDoUR08bvY6sNJG1LDk31tg0EE6Xu+bzczzjU7nAmXYtmdt1nJWSgSK16xP7wNNHRM
 Mzx66kLZoABySpIZFiJNOfbEnj5DlTObQiOOVFqTbW3Mn4re2bEXpGOQfpZWnC9S5A5/
 frxGJBdGZHyjyiPUcgwrfyzjva8v0ccG+Xj7CJEANv9A8lrXfIwQ7xSA547iwUAOiMlj
 fu9Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHIGQk7Qxl46PXern1sMWe5XNwS+pKvVgVFMkVH8jvfKzVYjBRYCFqilCj796mkXnB3Af/o1Dszr/cl@nongnu.org
X-Gm-Message-State: APuU4Z+XMzcTGXK2xylHxvYIQ6En9Tp1NB/lFyEAu6MLuUzVfDMJ4UbP
 ajAggKLYDntTEEzt3u/ICVHVtSOVJQCDfYjUWM8UGF7EbjL828SP9FwulIIYx7cSyCiZDFNRhm2
 uNjhUJUf1KxWJGKGakR2mFPCu6TWczmyh3F7mEUB12g==
X-Gm-Gg: AZFdTZeqhGsqaga+r+jFuhwoE16FemOxx/nG/euwYHSM1vlj4CkLdKyUaM5Dq+QOIWa
 7phOc9k/67MqQk8UyqjXZeCTH5QPHjYAnnidluUb3qrFpl54OT9h0027JHPkYLzd4h3MgpBLNtd
 IYwjxedY8lw2da1Mjiu0ZP6jZzXly52WOJ+/5Sxt7v4whkKWIiw8Zu50h8eva7M/eb57yKKAnQ5
 RIXMZgcs2h1AcC5c+hVEt843tNb+XFVH9nDokTZs/6rOhw8hNQprONsR1DjK1LGHWfLQc+Xdw0Q
 D9cYbN5zEZN5kGS+F+KPRRM+zgJuARUTxF7Md2mON4wGbUpG2kuk02CSKILrCGZGS7W5shJZph2
 6SMkjAKaik0wMBhGY8Zmiqc6VnkkqsynVZYj8+p/k6/oLv8sgZW1Q7EYTXcacrMbqr32ZpEQvg1
 9RFO9Za3hSYGWWZVaD3am8m83doO7cX8chBWD/WsXmJg==
X-Received: by 2002:a05:690e:1185:b0:67d:e36c:6beb with SMTP id
 956f58d0204a3-67e03d05eebmr6002832d50.96.1795606206450; Wed, 25 Nov 2026
 03:30:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <6f8a8cb816482599f4644bba33ffcb08d1ce63c9.camel@wdc.com>
In-Reply-To: <6f8a8cb816482599f4644bba33ffcb08d1ce63c9.camel@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Nov 2026 11:29:53 +0000
X-Gm-Features: Aa3M54oWnCWCVYxXT-95XZWum0N4S36_1AEp4w04G_43zBTWX4gm-3qGXvrDaw0
Message-ID: <CAFEAcA-H0CrrJU1f4adQBeWzoiOuUghYrYbGNK7vKCkjne5K9w@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "balaton@eik.bme.hu" <balaton@eik.bme.hu>, "mst@redhat.com" <mst@redhat.com>, 
 "farosas@suse.de" <farosas@suse.de>,
 "berrange@redhat.com" <berrange@redhat.com>, "imp@bsdimp.com" <imp@bsdimp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 at 05:33, Alistair Francis <Alistair.Francis@wdc.com> w=
rote:
>
> On Wed, 2026-09-30 at 10:54 +0200, Paolo Bonzini wrote:


> > +Prohibited use of AI
> > +''''''''''''''''''''
> > +
> > +The QEMU community is a collaboration between humans, not AI agent
> > +fa=C3=A7ades. The following items MUST be written by humans [1]_:
> > +
> > +- cover letters and commit messages
> > +
> > +- responses to reviewer comments
> > +
> > +- issue descriptions or comments
> > +
> > +Light copy editing of human-written text with an AI is allowed.

> > +.. [1] Official project agents may be exempted from one or more of
> > these
> > +       rules, at the discretion of the QEMU project maintainer(s).
>
> Where does this put LLM review tools (like Sashiko for example)?

I don't think they're covered here at all, because Sashiko is
not writing cover letters, commit messages, responses to
reviewers, issue descriptions or comments. But that makes
me wonder if the list above ought to have an entry for
"replies to mailing list emails".

> I have been using Sashiko a bit for catching issues in RISC-V patches
> and was planning on trying to see if we could get an official instance.
> What would it take to have that exempted as part of this?

I agree with Paolo that mostly it's "ask, and get some agreement
that it's useful rather than harmful, and be prepared to adjust
based on feedback". Making tooling opt-in rather than opt-out is
also important. A Sachiko instance that's just the web UI, for
instance, would be completely fine whether official or unofficial
because it wouldn't be doing anything forbidden by these rules.
One that's sending its review comments to the mailing list is
definitely something that I think we'd want to have discussion
about in advance before turning it on (and you can see from e.g.
the varying responses to that in Linux development that it's not
an obvious "just do it").

thanks
-- PMM

