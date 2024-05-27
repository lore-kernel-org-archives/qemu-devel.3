Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332F7C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUWh-0005H5-JT; Mon, 27 May 2024 03:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBUWa-00056L-Fo; Mon, 27 May 2024 03:12:04 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBUWY-0003bE-GB; Mon, 27 May 2024 03:12:04 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-681a4427816so2203126a12.3; 
 Mon, 27 May 2024 00:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716793920; x=1717398720; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xcPXDt1IIr0L6J8Lr6Ks0hJ2mvxtTwgEMt3GLruiSyE=;
 b=IofJtuwHm0iBMJW9WwJ8IkXPVGH76jUc8WuQgAfKhYGCGInMMIi7sTusMRsW0VDTLE
 0YiLhViOZk7/8KP+iuoRY/R/Nq82MnomywhHCJcl0UWW+sbfdgoNzxrQNm9qwJdXKnbE
 xz1othBv0XMPYXgiq33ciDftNL6hJzkixsHYrvGGqBgQeKxSQKbNLetkRt24stFC3qOE
 zuqcEPV0ZQnA3GnsVm2m5OrV5ogaLaDVBJlDM3I6kjCXwKv3U69v0P8VQfbRwKA85C8f
 ND/mt3I0/4AXfMx4be/XXme2+Ya6ylXtRxP2iTyTwuRgKcP72eAF4D/Ivt1Hj79jI3Pm
 uKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716793920; x=1717398720;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xcPXDt1IIr0L6J8Lr6Ks0hJ2mvxtTwgEMt3GLruiSyE=;
 b=MM+pKvaZ1p+RnULAbfk09rwJxSiogPJgyF3FX3EWI1Lb4TQTgB/M8msWLXcwh8vFjY
 lX7d/xIip2lAk+Cacb12wbdNML+39V4evkmwld3L8bU6+sG3/nbDTc80nj1XYG9Vd9An
 izUDCa9BXmk3vYXdwKlyNMAwCRkQ7OAmLHIDL1N73i2t7Jvg9q0P/B6hyKzQfqgCciCT
 Bykayn8JHl9HQDLnDYC9M3b5K+u1kxv/6BxBDwwUMaQL3UfDler2V9fuVWcajxlsL6UA
 4fPqBJ3/cxjvDZ/PjadWLUJogdercXXIHHZZDbUYcgi4QOXbd5VArCijakZLQeNCWIPw
 IYcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWP/Xu4yyXJWZmPnxKmoJpp9JxeSafTDI1pKhHWtjFcP9R97WH6+s7/+4zDPlvSjjO5AYWjYEI0n631410t7YgWPSy2MFbW+VBzM5ELac7tn5cJyl+U6w+Q3/gOQ==
X-Gm-Message-State: AOJu0YyMS80XA0xGhvxIXKnTRCO/kBDX/mOSBZeJSZO2uR0BbjuZZqgk
 aMFifzrL9pIianytrps3A3MpDYotkgNNBNAbJ8hw+x1aYQEBBwyF2+fXKrbu
X-Google-Smtp-Source: AGHT+IFXCSkPaBM6RMQj5mW/HWFBC4CDt/Fas9cry7oYwaRrzgu9lDjsV3bOVmkr5i30A2S00pm55A==
X-Received: by 2002:a17:90a:1fc9:b0:2bd:f45e:6105 with SMTP id
 98e67ed59e1d1-2bf5ee1be4cmr7417746a91.22.1716793920351; 
 Mon, 27 May 2024 00:12:00 -0700 (PDT)
Received: from localhost ([1.146.73.168]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f987248sm5068992a91.44.2024.05.27.00.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 00:12:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 May 2024 17:11:52 +1000
Message-Id: <D1K8NFHIMZHH.3BK3UEC8IV6YF@gmail.com>
Cc: "Halil Pasic" <pasic@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Peter Xu" <peterx@redhat.com>, "Fabiano
 Rosas" <farosas@suse.de>, "Laurent Vivier" <lvivier@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 1/3] hw/intc/s390_flic: Migrate pending state
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, "David Hildenbrand"
 <david@redhat.com>, "Richard Henderson" <richard.henderson@linaro.org>,
 <qemu-s390x@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240525131241.378473-1-npiggin@gmail.com>
 <20240525131241.378473-2-npiggin@gmail.com>
 <3bf1025b-021a-42fa-a4cc-d3cd9ea90676@redhat.com>
 <10e876de-b973-4016-9155-960383d46297@linaro.org>
 <22e05fc7-6256-41b3-9f0d-f983f169b08c@redhat.com>
 <88f79ea3-8b83-45c2-bd15-cdf16ffeac9a@redhat.com>
In-Reply-To: <88f79ea3-8b83-45c2-bd15-cdf16ffeac9a@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon May 27, 2024 at 3:51 PM AEST, Thomas Huth wrote:
> On 26/05/2024 22.33, David Hildenbrand wrote:
> > Am 26.05.24 um 21:44 schrieb Richard Henderson:
> >> On 5/26/24 08:53, David Hildenbrand wrote:
> >>> Am 25.05.24 um 15:12 schrieb Nicholas Piggin:
> >>>> The flic pending state is not migrated, so if the machine is migrate=
d
> >>>> while an interrupt is pending, it can be lost. This shows up in
> >>>> qtest migration test, an extint is pending (due to console writes?)
> >>>> and the CPU waits via s390_cpu_set_psw and expects the interrupt to
> >>>> wake it. However when the flic pending state is lost, s390_cpu_has_i=
nt
> >>>> returns false, so s390_cpu_exec_interrupt falls through to halting
> >>>> again.
> >>>>
> >>>> Fix this by migrating pending. This prevents the qtest from hanging.
> >>>> Does service_param need to be migrated? Or the IO lists?
> >>>>
> >>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>>> ---
> >>>> =C2=A0 hw/intc/s390_flic.c | 1 +
> >>>> =C2=A0 1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> >>>> index 6771645699..b70cf2295a 100644
> >>>> --- a/hw/intc/s390_flic.c
> >>>> +++ b/hw/intc/s390_flic.c
> >>>> @@ -369,6 +369,7 @@ static const VMStateDescription=20
> >>>> qemu_s390_flic_vmstate =3D {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fields =3D (const VMStateField[]) {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8=
(simm, QEMUS390FLICState),
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT8=
(nimm, QEMUS390FLICState),
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT32(pending, =
QEMUS390FLICState),
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_O=
F_LIST()
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0 };
> >>>
> >>> Likely you have to handle this using QEMU compat machines.
> >>
> >> Well, since existing migration is broken, I don't think you have to pr=
eserve=20
> >=20
> > Migration is broken only in some case "while an interrupt is pending, i=
t can=20
> > be lost".
> >=20
> >> compatibility.=C2=A0 But you do have to bump the version number.
> >=20
> > Looking at it, this is TCG only, so likely we don't care that much abou=
t=20
> > migration compatibility. But I have no idea what level of compatibility=
 we=20
> > want to support there.
>
> Yes, this seems to only affect the TCG-only flic device, where migration =
has=20
> never been working very reliably. So I think we don't really need the who=
le=20
> compat-machine dance here. But I think we should at least bump the=20
> version_id to 2 now and then use
>
>     VMSTATE_UINT32_V(pending, QEMUS390FLICState, 2);
>
> for the new field. That way we would at least support forward migrations=
=20
> without too much hassle.

Well if you could rebuild this state by checking sources or something
it might be possible to avoid. Or if you could always mark pending and
software can tolerate superflous. But that also seems like a lot of
headache for something that was always flaky.

Thanks,
Nick

