Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6CDCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGMO3-0000B5-5U; Mon, 12 Oct 2026 16:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGMNz-0000AX-Qu
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:12:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGMNy-0000NF-1r
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:12:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso26352045e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791835956; x=1792440756; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KZzmfEh0THfqc2OZ4slyGfRtpeDV3ZiGmTU/BtZA84I=;
 b=JY4rKItv8c3GnMvBWNcOqqREQoa00HZO+UkPj2qnGG1csWSdOLEbfcidmCD0KRM4Kb
 XltkF5D69lzsuBy03RR6x7fKJ9Mli1+vz8oWR7lOJ2v6N5Bnf4llSoab6taEc7uu25Kj
 KXibYherYd2hDXhDMQKDUX9B5/zGsJqquSBz/bwrdIO3axmZKaG/Su6jL2ncPbQvQVco
 L2Fd9i0nGaYTafQLXOuIGxEReg60tk7g/1ldTG3qlQ4+g3EUSUUt3qZG8x9cNxReh0rQ
 c3pnQwkVrg36N2TkmwWOvTL8q2rkohBTkmwzatdhjwdPvatM7Jt5J1UgJwRfJjDiHMPJ
 Ps0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791835956; x=1792440756;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KZzmfEh0THfqc2OZ4slyGfRtpeDV3ZiGmTU/BtZA84I=;
 b=SuzYM00s25pGtuizB8j3jtFQO0On03QxLNtYyv2xEzsur6tCRIHBS3egJfD53tv8UG
 JroRN71UMWTCuREqaIy6vpdPrrPuGrh+flms6mps2L0mqKNjIoBhhhoTpAh5D9gFqYK/
 SrYpH7kaPLd7uopgVahUEhqA1UD2u2dmGOg3yU+aKZqMBTcJ+zaR8t0cKirwJcg+VQjk
 YrEVzLh/CBwpp+z+KGGoquk95EJA4gA+8nMrSmc0syfACUzialwHdoK7MDLc7bhWiYzK
 DiWvNYFFpuo+I1LFv0FnA5yzfxKtcFRWxbRuJg6Ip2XYGxbE//FmbFK1A3gCKVyR68zK
 MgOg==
X-Gm-Message-State: AFq9FYJUlCxDVD31luCtmB8zYXo8Y2EEjPvKFlZfDLT0r/HBFvoVQK19
 bNHoIs6d6Lwd3GjWQk2+wpN0SbY6GxABQbCoDkHv8kAfi6med9xhdEjm
X-Gm-Gg: AYBFou07J/ouT+Tk296/zz6ArFcEQmDIzYblJWr/cqRkEkD4isIAzuKN/0voyOsVri7
 DzveTbYNyu7oV6uxOFxunEHeu2X7jMaG8GflnwoEdyTcgCOB6eSSuyVu/CW3KOn4Yiq1gsoa76T
 cYejbT87MxQw8uACAoYIRga7iPmw0wy235l18KE/nsJb1SxyKBQOhB9C0D4ffA8klTe+d6TPgnC
 DqjYYFcaoWYpqVHuQ9zU4L0309scR8VkJmoe6FKyQR1yyTODOFymuEIrNW3EerY/A8trzatpCec
 YlcFs3OSVuPHuPx3n50avQFm90TWgNNOC2FdZOySl+NFvcp1sXpRz6A6/Msa7+rCSDZ4KDdP30Z
 nyrC/WfcsVlnJXuVIclIrCCQu2PkJESUUyWlXuZ7rF491IQAmQAlFBz//m/YfNNeQjgI1cNiYMP
 YGVkYNNvVIrCwj3eERgXMVUm+sE96cOHRqHpIEypR5nTqVEel3GxQnj2W2E1EsKfYMM8do1ERl+
 YNeBcAZudwApWl1Pv28pySi/8QtJxZ+GLMPYwvEcnE=
X-Received: by 2002:a05:600c:4ecb:b0:4a1:6916:798 with SMTP id
 5b1f17b1804b1-4a18e4a3f69mr199760305e9.14.1791835956267; 
 Mon, 12 Oct 2026 13:12:36 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac3970sm1090981f8f.37.2026.10.12.13.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:12:35 -0700 (PDT)
Message-ID: <90fe897aa35405fbada7a440c3fab848d81ea2b0.camel@gmail.com>
Subject: Re: [PATCH TRIVIAL] treewide: use qemu_dup() instead of dup()
From: Filip Hejsek <filip.hejsek@gmail.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel
 P." =?ISO-8859-1?Q?Berrang=E9?=	 <berrange@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Michael Tokarev	 <mjt@tls.msk.ru>, Laurent Vivier
 <laurent@vivier.eu>, qemu-trivial@nongnu.org
Date: Mon, 12 Oct 2026 22:12:34 +0200
In-Reply-To: <CAMxuvazc5iHk=GDysFHVFN0xtf-g75AobhoKdPXaR6_Qz=dDNg@mail.gmail.com>
References: <20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com>
 <CAMxuvazc5iHk=GDysFHVFN0xtf-g75AobhoKdPXaR6_Qz=dDNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

On Mon, 2026-10-12 at 23:54 +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Oct 12, 2026 at 11:44=E2=80=AFPM Filip Hejsek <filip.hejsek@gmail=
.com> wrote:
> >=20
> > Make the use of qemu_dup() more consistent and eliminate the possibilit=
y
> > of accidentally creating non-cloexec fds.
> >=20
>=20
> Not so trivial, in my humble opinion, as there might have been some
> reason it was avoided.
>=20

You're right, I shouldn't have tagged this as TRIVIAL.

I've actually intentionally left some dup()s unchanged for exactly this
reason. They are the ones in qemu-nbd.c, migration/cpr-exec.c, and
under linux-user/ and bsd-user/. I also didn't touch the tests, as I
didn't consider evaluating them to be worth the effort.

I should have put this info in the commit message...

> > [...]
>=20
> After review I think these changes are valid. These changes shouldn't
> impact the exec() code paths in qemu.
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20

Thanks for reviewing this.

Filip

