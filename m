Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B26AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 09:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCyO-0000Vn-4A; Mon, 01 Jul 2024 05:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sOCuu-00079d-UT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:01:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sOCut-0002jO-9T
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 05:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719824501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oEBDYAQdGZzD+ww+OiJTTgxS9CQV9GMVKaDk3lRKAtA=;
 b=Tw5kr+c6IKCbajkaRabg5Zqqj1+OvYMfEw7OsUR2MXEUSp33KOwkSal4LzP8HiixFnQndF
 LheJfsr+An03k2ogUJ3EnCe5JPixh7faXJHC49n7k6gJpwtV2n7UYB8RkyKQPNCsOQu7RS
 bFy46x95A3wJLxQ6Zxkf7PkVIdDhUv4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-VkSo6UMFP8-j-1OJW6FAKQ-1; Mon, 01 Jul 2024 05:01:40 -0400
X-MC-Unique: VkSo6UMFP8-j-1OJW6FAKQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4210d151c5bso19924395e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 02:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719824499; x=1720429299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEBDYAQdGZzD+ww+OiJTTgxS9CQV9GMVKaDk3lRKAtA=;
 b=hJ02rfVL7+kOpRPqUEjh7JjY4i+uBRgv3LYQwZGyiL3XWfERFJnfYG9TW4gnwSvqcB
 5acjPTuHeiWVeqYEI+Wwxnjj5b1a4E2yeqws8wQyN4Prcfd3g1DakZupswf+F4E8UxSt
 a+92KQ7R1VPBqhLzKdfg4oqRtvjLxDLOCB12DkfQtZMX9tkErxNeAGoSrtQgM7loC0+J
 8zTQApH8Xe1C1inItIK5Gq6uEXrm3JDCPZSNji/YeK7LBVSVtiqFI8/k09ww2AhEkjdI
 +wo3nhtznw0u5ys9om78kliH3FX7y3jktLXrQxzi30o+IXIRXyjsbo5xfPYbOcELstTO
 Oc2A==
X-Gm-Message-State: AOJu0YxGpNgtl/k6+24R7ygmQoAkK3/GSNieC7SxXeK8Pk0e9ZZ8uSmE
 y/DOL3Zw8iHhe7nbZvlsAQz2/+hb13pUsm24WPJy1L7CN6lJQ4aHPKv25NMA3ZSfEDY9q3UsL1/
 QT4KxTXr887UGsbBS+a3N/R7lh3FOP2q1P4QINpoQ1KGQd5P0HO52
X-Received: by 2002:a7b:c458:0:b0:424:a655:c8b with SMTP id
 5b1f17b1804b1-4257a010ab5mr32799845e9.19.1719824498992; 
 Mon, 01 Jul 2024 02:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGek2GHD933LRneG78XPG7FHYSOuQtjZWToFudFgCXQ+YjfCag1kHhC5nBK77W/OehMizIE5A==
X-Received: by 2002:a7b:c458:0:b0:424:a655:c8b with SMTP id
 5b1f17b1804b1-4257a010ab5mr32799715e9.19.1719824498651; 
 Mon, 01 Jul 2024 02:01:38 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4258014f8b7sm47322965e9.41.2024.07.01.02.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 02:01:38 -0700 (PDT)
Date: Mon, 1 Jul 2024 11:01:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Beraldo
 Leal <bleal@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org, Peter Xu
 <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Alexandre
 Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH 02/23] target/i386: fix gen_prepare_size_nz condition
Message-ID: <20240701110136.6829422c@imammedo.users.ipa.redhat.com>
In-Reply-To: <87ikxtnnjh.fsf@draig.linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
 <20240628124258.832466-3-alex.bennee@linaro.org>
 <87ikxtnnjh.fsf@draig.linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, 28 Jun 2024 15:34:58 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>=20
> > Incorrect brace positions causes an unintended overflow on 32 bit
> > builds and shenanigans result.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2413
> > Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org> =20
>=20
> This seems to trigger regressions in:
>=20
>   qtest-x86_64/bios-tables-test
>   qtest-x86_64/pxe-test
>   qtest-x86_64/vmgenid-test
>=20
> Could that be down to generated test data?

Without context, I'd guess, that
guest doesn't boot/get to randevu point that tests are waiting for
and then it just timeouts =3D> fails.

>=20
> > ---
> >  target/i386/tcg/translate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> > index ad1819815a..94f13541c3 100644
> > --- a/target/i386/tcg/translate.c
> > +++ b/target/i386/tcg/translate.c
> > @@ -877,7 +877,7 @@ static CCPrepare gen_prepare_sign_nz(TCGv src, MemO=
p size)
> >          return (CCPrepare) { .cond =3D TCG_COND_LT, .reg =3D src };
> >      } else {
> >          return (CCPrepare) { .cond =3D TCG_COND_TSTNE, .reg =3D src,
> > -                             .imm =3D 1ull << ((8 << size) - 1) };
> > +                             .imm =3D (1ull << (8 << size)) - 1 };
> >      }
> >  } =20
>=20


