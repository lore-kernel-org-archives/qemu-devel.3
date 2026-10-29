Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C17606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y/opi1mh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMLNZ-0007gp-D8; Thu, 29 Oct 2026 04:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xMLNY-0007gV-Dj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:20:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xMLNW-0007A6-SZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 04:20:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so14956715e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 01:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793262053; x=1793866853; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9UCTxJCqqA5MYAthVU4M5ES312L3tEWaOw9MGztoN58=;
 b=Y/opi1mhd682WYLUiN9RyodOWwvTrZeGW6fVfjumMeeDPp2ac+nz61pO98JxoffEFI
 0XVO7r+BwEdXzLUs29XwibzwktKOFP1DabVtitJSteoqw2JztXF9Oo+zQMCLnGHeZNUr
 OR/3H1ssH0re+1w7JLkv9SZZJa2j48dC/x0wNHVTq5II4GNAjUu+Bose5j110DObDDkq
 5sF/2zYRnzyhOUEiwUV6DckOU9YXPRZZzzaIF6GXmTFt8E7IiVXOT0G2SrAG3fpbbb2l
 o1IStgMAcswq8jE4chH9KttfRBersDfVaaQe9cp7TxiRALpqPxBQ5BvA6G+EA4edFJ4a
 zFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793262053; x=1793866853;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9UCTxJCqqA5MYAthVU4M5ES312L3tEWaOw9MGztoN58=;
 b=M0ViObJMUonxVGOt2onmcoMIX2iuXM0/VknAKWbfaaWThnBn0mSj01zxYa6yjF0q0S
 3UX2PKVvVKjo32C93sNU4pp216iA9KbfmwWyh6TGvBPHRDtiuGPHmf/yWPoWfDKtCng9
 C1BgkfjaZDKPuFcF6ZX3xkOjkA+ufW7S2eucHJ0Sbnfrmv3s0PJqgft/4K0DygbVhCcT
 /pLu3VGvPpDR5+5JVs5p2o9epg5vOD6Sd7AUPjRnMeMDIaDiahfnKPYjIc9giknJlTpg
 bvpB8Uqy3I5X0u9MIwrIYnDpkbEIb0em8YpN5UaCQM+ud9BPBKuQfTZkpMMis5J0mb2X
 psIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRTVnDhgI/Yh31KEm7MVdFyU0pj/vMgjnTAKe4K9hJRFO47GhuvLjo0C6GLS5gWLYv07lwNM3Baxxe@nongnu.org
X-Gm-Message-State: AFq9FYIqJOw7q+OSS3Xa6EiAlK4/S1MJZk2YXYfkEYbk2vGl08xwVVSd
 DpFvbm+Fq2bmiRjIDbwTh0LCpLfVL7WF0DJew+hN7YFUpyxZHqhY3oVK
X-Gm-Gg: AYBFou2gDOfGDjeymsMngT/b40knrJzMee04cdC1WrWmRKGm0ybeMtrkKBK5vKFrC9F
 1v8VH1jjYyecKQVilZkRJOUpc+Lt3yVxZxHNjuBvCSoxRsyIf/g3pYuFFUONwdFiWH2m/yN6vjL
 Tgynu0+AN93nGRVDYc35ihWlc/aFCVpKCC1DOdtpoy1sQLG++/nwM125EH2RQFrSU+q5accbGng
 gzYx0qBWdzjfbAEkQM75JGlkwQkD2QhMveIfEpO97nmkTqeQpV8Re5AX8m5oG654T+2c8xrSweb
 oF3mHYg6dfhhtaaYXGYC3cA6tMVc4IKpAk5xPKOmILUZEJUEow9yAjQRirjuEXcNSvsZT8aanG9
 VKTWFZOvWurnr7o3OHeol94tOlo9yy4Lxlv6eJbZN54Uf0A5NQ2R9zfpkKkEoth2HIQYOHk+5Dm
 +YwOOKGeUvzJsbgoun23WfNSlIKEGaPSLOm1d7gj8lP5oDpOEtPjdG4RSuLCYsF5l2i2aBvksA4
 yOH4JojBydwgMOStZEO7pr03VrwUOsQqxfT1lXoA2/4U9hZ+j3d6KURWwWRpueNZPv5bUjMEvdX
 5m7nTCun9FldtZVuDb+kp/7nqZknhvoVFD6L6EnpkK6JBBpLATi1sMMJnSL3+c3sLaE=
X-Received: by 2002:a05:600c:4692:b0:4a2:167a:c939 with SMTP id
 5b1f17b1804b1-4a9667756c9mr102884825e9.21.1793262053061; 
 Thu, 29 Oct 2026 01:20:53 -0700 (PDT)
Received: from [192.168.1.89] (95-24-99-141.broadband.corbina.ru.
 [95.24.99.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a969e61f9bsm72040585e9.2.2026.10.29.01.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 01:20:52 -0700 (PDT)
Message-ID: <c850cbe681b0328cf3c3f93140132f8363e253e2.camel@gmail.com>
Subject: Re: [PATCH v2 1/6] hw/i2c: add dummy device
From: Timur Maksimov <gessingate@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jamin Lin	 <jamin_lin@aspeedtech.com>, Kane
 Chen <kane_chen@aspeedtech.com>, 	qemu-arm@nongnu.org, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier	 <lvivier@redhat.com>, Corey Minyard
 <cminyard@mvista.com>
Date: Thu, 29 Oct 2026 11:20:49 +0300
In-Reply-To: <87pkwtezsz.fsf@pond.sub.org>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-1-07deed1dff60@gmail.com>
 <2629ee8a-e817-4764-a1e3-72e0ccbb978b@kaod.org>
 <874ie6ku2u.fsf@pond.sub.org>
 <5d219f231fb1f97c6d90cbef4068e82dff803a18.camel@gmail.com>
 <87pkwtezsz.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=gessingate@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi, Markus

On Thu, 2026-10-29 at 08:22 +0100, Markus Armbruster wrote:
> Timur Maksimov <gessingate@gmail.com> writes:
>=20
> > Hi, thanks for the review.=C2=A0
> >=20
> > It was my decision to use such API, I thought it would be okay for
> > a
> > test device. I don't think there is a way to expose integer array
> > as a
> > single QOM property.
>=20
> There are ways, but I need to know what you're trying to accomplish
> to
> be able to provide guidance.

We need to access the transfer buffer array with QOM. Actually, I have
a few ideas on how to do this without cluttering the QOM with
properties, such as using a FIFO interface.
>=20
> > Actually, we can go without this model. I suppose I will rewrite
> > tests
> > so they don't use it.
>=20
> You haven't answered my question on code-provenance.rst.
>=20
> > On Wed, 2026-10-28 at 11:17 +0100, Markus Armbruster wrote:
> > > C=C3=A9dric Le Goater <clg@kaod.org> writes:
> > >=20
> > > > + Corey for I2C feed back.
> > > >=20
> > > > + Markus for QOM
> > > >=20
> > > > The brute-force solution to expose the contents of the device
> > > > array
> > > > with 128 properties has a slight AI smell. I find it ugly but I
> > > > am
> > > > human :)
> > >=20
> > > Timur, have you read docs/devel/code-provenance.rst section "Use
> > > of
> > > AI-generated content"?
> > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 That said I don't =
know if there are better
> > > > alternatives.
>=20
> [...]

Sorry. Yes, I have read it. This is solely my work, no AI was used to
write it.

I also have a question about MAINTAINERS file. If we keep this device,
where should I put this file?

