Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A7EC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKYN-0001e0-6t; Tue, 06 May 2025 11:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uCKY0-0001a2-CA
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uCKXy-0004nX-Gr
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746546568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bkngm4xPW0h1Rul1XmIN8IYWuu6SW3zE+68bt6TipHg=;
 b=W/YARlgpbdKxt+AIu1M3H29+YWcdoaocchAZG/1t9xn5mxlez8Up9Y0urkz/4T/r6xijUz
 94G8FSqjQlJ0vr8MuZjTaCDlhYKe0iu2fVTNzygdKFs1pg8L5bL2DKVemerZ76ZvoBdV7D
 LptWDv9Fso79fc2sIzw9qQfSGg44Ows=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-I6j3BEQBMKKfzYPGJ2DMNw-1; Tue, 06 May 2025 11:49:27 -0400
X-MC-Unique: I6j3BEQBMKKfzYPGJ2DMNw-1
X-Mimecast-MFC-AGG-ID: I6j3BEQBMKKfzYPGJ2DMNw_1746546566
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39ac9b0cb6aso2434472f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746546566; x=1747151366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkngm4xPW0h1Rul1XmIN8IYWuu6SW3zE+68bt6TipHg=;
 b=Qo1mwvVhxSs9Mk22mvrpg2ugYEY4joFKU0m2CT779ptdT4mmguf05KRhM6FAF3+kpa
 2RFMezd17NtJ2C/qd9T3nM/RiYVkrCc0ksJNwCWAzurcacP2TgY8EXaiz5SqK4v1JC+k
 o7XoZXxWFA5YAh9H8O0tYNwf+1J1V2Q4x7BaddouYmAn++DsyAvDrkenB5t1sVJhRIAi
 38GTr6nYtJRIKV3BiQp3YGnLUFgINtLdXI2Zl3it0qRDVvblYD+lHJuN1Vl8eTZAIGf7
 bxlU7iJ/pph014DgqHjcAEd3sC9DMOWOdh9J6dcP5Dzk+xiP8mzk7TblKKwtVaAoPOb/
 Ss6A==
X-Gm-Message-State: AOJu0YypyHIkLcgHoTHt+Y+9pJra08jUa06z2cpD708JeBCTSJPXEfEW
 CPzHu0ZguatZU6UM4wo7kE/M22grZ16+AID5A4DHmsGtNgbXQEOKjO/zru1fkRbhgaGQ3g0/Fjv
 XKZew786niHGaPzWaJ+p2Zp4FBraiITYvrH3yCa6JXOsWJ+FG/Q0O
X-Gm-Gg: ASbGncs3693NfLYXFYpTk5fV9Bqp1EnJQIrvy3Q10ZqmuzmiPsQavrov8c/bWz/mScK
 dSb5e9YcW4DAyWvfC6cbU4fPzobDMUynYM8AFDw3mo4kwzFk3JM2ZDQYvC5ro+KNFtw6IKJjY8J
 y77zMFmhivziSdH7lLkUCkauF8N0B2mJX4LJahWqYhnn+cfiJ6+FFmLqKQ6QgfEZqoaH0KM7dl4
 Plj3YV1ldouFt6RY80mK2nI8khdZtFOmYcul5MKA54DCOunjHojF80IRyjSden4eNsvDymxzVmd
 TM53UZYDQMhIaNTwDGaIJx1rQ1phGSFY
X-Received: by 2002:a05:6000:178f:b0:39c:d05:3779 with SMTP id
 ffacd0b85a97d-3a0ac3eb17cmr2824051f8f.49.1746546566291; 
 Tue, 06 May 2025 08:49:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUj74RFkjOoqcOq/gKjPK5QyKCPHVWxdIDd1/VNcSsrdTvrR4Dao1DMLULuuawVwr1AmpEyg==
X-Received: by 2002:a05:6000:178f:b0:39c:d05:3779 with SMTP id
 ffacd0b85a97d-3a0ac3eb17cmr2824028f8f.49.1746546565814; 
 Tue, 06 May 2025 08:49:25 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b172b3sm14264980f8f.90.2025.05.06.08.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:49:25 -0700 (PDT)
Date: Tue, 6 May 2025 17:49:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>, Udo
 Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones
 <ajones@ventanamicro.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>
Subject: Re: [PATCH-for-10.0? v2 13/14] hw/arm/virt-acpi: Do not advertise
 disabled GIC ITS
Message-ID: <20250506174923.4fce914c@imammedo.users.ipa.redhat.com>
In-Reply-To: <6b64af93-f542-4a0e-8e55-5bb235f42c83@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-14-philmd@linaro.org>
 <20250404124110.59c59dc3@imammedo.users.ipa.redhat.com>
 <6b64af93-f542-4a0e-8e55-5bb235f42c83@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 4 Apr 2025 14:49:45 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> On 4/4/25 12:41, Igor Mammedov wrote:
> > On Thu,  3 Apr 2025 17:18:28 +0200
> > Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
> >  =20
> >> GIC ITS can be disabled at runtime using '-M its=3Doff',
> >> which sets VirtMachineState::its =3D false. Check this
> >> field to avoid advertising the ITS in the MADT table.
> >>
> >> Reported-by: Udo Steinberg <udo@hypervisor.org>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2886
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> >> ---
> >>   hw/arm/virt-acpi-build.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> >> index e7e27951cb9..38a9e6fe0c5 100644
> >> --- a/hw/arm/virt-acpi-build.c
> >> +++ b/hw/arm/virt-acpi-build.c
> >> @@ -212,7 +212,7 @@ static bool its_enabled(VirtMachineState *vms)
> >>   {
> >>       VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
> >>  =20
> >> -    return !vmc->no_its;
> >> +    return !vmc->no_its && vms->its; =20
> >=20
> > It's confusing have both no_its and its,
> > it would be better to lean this mess up (i.e dedup or rename if somethi=
ng is poorly named) =20
>=20
> What about:
>=20
> class: s/no_its/!its_createable/ or !its_usable
> state: s/its/its_created/ or its_used or its_in_use

looking at the code what we are essentially doing with variables in class,
is selecting its device type. And then playing scattered if/then game to de=
cide
which 'its' to create or not create.
can we make something like this instead:

 machine_foo_class_init_vX():
  vmc->its_type =3D NULL;

 machine_foo_class_init_vX+1():
  vmc->its_type =3D accel_get_its_type()
=20
and then elsewhere:

if(vmc->its_type && vms->its_enabled)
    create_its(vmc->its_type)



