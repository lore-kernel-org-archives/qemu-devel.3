Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEF6C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 16:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp9Tu-0004N4-1m; Tue, 26 Mar 2024 12:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rp9Ti-0004MA-7T
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rp9Tf-0000Ap-0X
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711469801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnQKVzfYYxTezxn36Vo34iP57wRBhKpC6E5adiwHo0I=;
 b=AcZhaDy680ddJ9rAE54jc2WtQkjEnVSDGxPYG2DcU1e2V6ATJX0+VrTA2SYMDTj7akXtkx
 v26wL3jEemNvXO9EbiSNacPtkUdeFhajrfRWSgKo/uFlYbV8ZevjrBGtdR0Pe9KsX/kUF/
 H27ybdHk8WouzFtqELwV73r2SyGM6mo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-1uOCrRj_OeCOwEqf7vCJPw-1; Tue, 26 Mar 2024 12:16:38 -0400
X-MC-Unique: 1uOCrRj_OeCOwEqf7vCJPw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d49fa5dfadso48125391fa.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 09:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711469794; x=1712074594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnQKVzfYYxTezxn36Vo34iP57wRBhKpC6E5adiwHo0I=;
 b=jKUgoT2mJseCe96bGRfXb43lsOFTOEv7IsnK382wxkaYvLGayYIOmiZo68ZLNANsyT
 kssxsZzb5ANJg4ynQByUqxBPb1GMUrkA2l4T8QxiDIXuzzF/5Y53WCDQqxk8KKd/ymRC
 cv8Zwo2DErOjA/Inexqz+MyMuqqWesQgeaJqdvKASZz/NTujSCHwf6TLiL66eQPTo6qu
 xkMyNmNzRC5Ec5BOm2lKlKPK4iLEC3McM6oksqh/C6Y+sdr2pQUR+kdPYZpVlM3ECACL
 +jKq8tc97qLwVSlVmSU+7uvLJIPdSu5W3zCgd5bgLKtZMy9ity+nCmCSYEeQiMuNgxFS
 SuHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+eW0PnEUEJGP40VPLFvmOolEPdnfiYNYs/52JXfo4HsGm3wEih0HXLJ7r7w3jVSqTUcEv0YrZdUsIbvTujqYCJ5hhPHs=
X-Gm-Message-State: AOJu0Yz1TeabPc3hk0DigohjtLMsVIEV5nN4PVJ/ww9iqIzKwsL3qDQb
 OajKFLXK9pOqBk22UeYavVi8es/X3y3G1y5cD2+P/a/0QWsH1VX+Mz1uTYr7UJETWbqV2/twjeK
 CmJQqvIHknq4NijYqVNoxolF3xKxbMraMRANe2zHREUv5g4l3Zv6P
X-Received: by 2002:a2e:a172:0:b0:2d6:9d74:f553 with SMTP id
 u18-20020a2ea172000000b002d69d74f553mr88042ljl.5.1711469794606; 
 Tue, 26 Mar 2024 09:16:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9CZMqCC/Rahki7VLSbkdQGNeK/yvBLEb3bQRDs9J6IlM5ki0x9CwZkk7dkoRhzGLUGDi0oA==
X-Received: by 2002:a2e:a172:0:b0:2d6:9d74:f553 with SMTP id
 u18-20020a2ea172000000b002d69d74f553mr88026ljl.5.1711469794142; 
 Tue, 26 Mar 2024 09:16:34 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c351400b0041477f95cf6sm11987176wmq.13.2024.03.26.09.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 09:16:33 -0700 (PDT)
Date: Tue, 26 Mar 2024 17:16:32 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Bernhard Beschow
 <shentey@gmail.com>, pbonzini@redhat.com, devel@lists.libvirt.org,
 richard.henderson@linaro.org, mst@redhat.com, qemu-trivial@nongnu.org
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
Message-ID: <20240326171632.3cc7533d@imammedo.users.ipa.redhat.com>
In-Reply-To: <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
References: <20240326125104.90103-1-imammedo@redhat.com>
 <a4a0bb13-d6a0-4665-810d-ecd9a9fb89b1@redhat.com>
 <8dbba6ae-5910-4a62-9a08-a56e20dfb480@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 26 Mar 2024 14:29:58 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Hi Igor,
>=20
> On 26/3/24 14:08, Thomas Huth wrote:
> >=20
> > s/iaspc/isapc/ in the subject
> >=20
> > On 26/03/2024 13.51, Igor Mammedov wrote: =20
> >> ISAPC machine was introduced 25 years ago and it's a lot of time since
> >> such machine was around with real ISA only PC hardware practically=20
> >> defunct.
> >> Also it's slowly bit-rots (for example: I was able to boot RHEL6 on=20
> >> RHEL9 host
> >> in only TCG mode, while in KVM mode it hung in the middle of boot) =20
>=20
> I'm quite opposed to this patch. QEMU models various very-old /
> defunct hardware. I'm pretty sure Bernhard and myself are OK to
> keep maintaining it, besides we are working in separating it from
> the i440fx+piix machine. Also, this machine is particularly
> interesting for my single-binary experiments.

it would not be fair to ask you or Bernard to deal with every
case where ISAPC related code gets in a way, nor it's fair to
ask other contributors to ensure that their patches don't break
semi-working ISAPC or refactor code that relates to it.=20

[
for example I'd like to refactor smbios parts in the image
ACPI table builder, but the I'd have to do it for legacy
part as well without means to verify that. Sure it can be
done but at cost of extra time spent to rewrite something
that would never be used and to find test env to verify
touched code.
]

However I look at it, isapc is burden at this point=20
and it gets into a way of evolving.

[downstream hat]
while both of you do a wonderful job of separating some parts
of the mess we have, it's a lot of churn which is not ideal when it
comes to backporting patches.

[emotional hat]
Nowadays with modern containers tooling it's very easy to
spawn old qemu environment to play with removed machines/features.
quick few minutes example that lets me run isapc on old ubuntu
without need to read how to build containers in 100 different ways:

 toolbox create --distro ubuntu --release 22.04
 toolbox enter ubuntu-toolbox-22.04
 toolbox enter ubuntu-toolbox-22.04
[user@toolbox ~]$ sudo apt update
[user@toolbox ~]$ sudo apt install qemu-system-x86
[user@toolbox ~]$ qemu-system-i386 -M isapc -vnc :0 my_toy.qcow2


PS:
I haven't had high hopes of this getting accepted,
but I had to try.
Though recent trend was that upstream
QEMU were deprecating/dropping old machines/devices
(even ones that kernel folks were using for testing)
and it hasn't caused the end of universe (old qemu(s)
sill exists and can be used for those cases).=20

> Where I agree is we should stop reporting "KVM on ISA/PC machine"
> as supported.
>=20
> Regards,
>=20
> Phil.
>=20
> >> Rather than spending time on fixing 'the oldest' no longer tested=20
> >> machine type,
> >> deprecate it so we can clean up QEMU code from legacy fixups and=20
> >> hopefully
> >> make it easier to follow.
> >>
> >> Folks who have to use ancient guest that requires ISAPC can still
> >> use older QEMU to play with it.
> >>
> >> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >> ---
> >> =C2=A0 docs/about/deprecated.rst | 7 +++++++
> >> =C2=A0 hw/i386/pc_piix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 1 +
> >> =C2=A0 2 files changed, 8 insertions(+)
> >>
> >> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> >> index 7b548519b5..5708296991 100644
> >> --- a/docs/about/deprecated.rst
> >> +++ b/docs/about/deprecated.rst
> >> @@ -226,6 +226,13 @@ These old machine types are quite neglected=20
> >> nowadays and thus might have
> >> =C2=A0 various pitfalls with regards to live migration. Use a newer ma=
chine=20
> >> type
> >> =C2=A0 instead.
> >> +``isapc`` (since 9.0)
> >> +'''''''''''''''''''''''''''''''''''''''''''''''''''''
> >> +
> >> +These old machine type are quite neglected nowadays and thus might ha=
ve =20
> >=20
> > "This old machine type is ..." ?
> >  =20
> >> +various pitfalls with regards to live migration. Use a newer machine=
=20
> >> type
> >> +instead. =20
> >=20
> > I doubt that isapc could ever be used reliably for live migration, sinc=
e=20
> > it's an unversioned machine type, so I think it would be better to not=
=20
> > mention live migration here.
> >=20
> >  =C2=A0Thomas
> >=20
> >  =20
>=20


