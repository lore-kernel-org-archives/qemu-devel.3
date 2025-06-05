Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381FAC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6bX-0005n4-9a; Thu, 05 Jun 2025 05:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uN6bT-0005mm-6Z
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uN6bR-0006yl-F0
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749114575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vd0QeYnHOALaYoA1gjpXNQ+h+NBgVf2zg7/YA3j8XC4=;
 b=Q6Dst4MpMaVegxhcUT3u+vKmubACyachY7IZDz6G+T1JgXKI2eyJwhNXjEkTrpmi9VhNxf
 MMLLOKvy4Yqdu2UC4KQWNdss/X6e0pgM4RBvc/kr1qXl7uqH57gKIiTS/vdYMR5NbOQrkN
 insR0XUGlgpJcG3qnKzmLZYtvD/GEmg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-Kycm2LemMyi_eP3kmQs5Nw-1; Thu, 05 Jun 2025 05:09:34 -0400
X-MC-Unique: Kycm2LemMyi_eP3kmQs5Nw-1
X-Mimecast-MFC-AGG-ID: Kycm2LemMyi_eP3kmQs5Nw_1749114573
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d886b9d5so2473815e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 02:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749114573; x=1749719373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vd0QeYnHOALaYoA1gjpXNQ+h+NBgVf2zg7/YA3j8XC4=;
 b=DKcqxVwDg6o2Cx1AGWduKedeD9yYiTGeIrxVEcImwPVkpQbTF15MdB21bTQqP+Tqtr
 pfvr9FVx+PpjBjRw6sKtLMsbhk+jVXICDnjF0Dg5+1o8fyGsvcc9KdtgmGq1I0KP7lCR
 970omlkCjHkGdbZO6HYxn+IgeoNjT6GgD4NOBk1zI5dVoOPTJxqQ8u58J/BCFAUmlpql
 YOcexD3uoSdbRg82RFNc0R4KJ0hsR3OHmpSklfJ0s1/3nsajMVy1QO04i+sQk1hQC13K
 fXZ56q/OYQxLlC8sinxjss1U9QR9nwmeqCmtx5wPTIxS1CDeDQTy5vQ5smyeJ7A9Vzxf
 9mbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFcW9e8Z2+VUlcQ61zZGc5wt+AdvRmxoxikFNrZVwmOoZZw90HzDxl5+nMkRC3xOZLxO7fRgeRUDDS@nongnu.org
X-Gm-Message-State: AOJu0Yx5WG808xZbD7pTX4NYm8RsLOEPippmoxwKifXaL6k1GlRj8yMJ
 JkjwzBG6kG/cXDDGPWNKS+tzhjt0LbiTVkCQxZFnBVIPHDvWXBazwSRJCoeKvA+e/nyMKDHdT1c
 Rda3g9GON0eFSST2Cr8b5wr4INs3/sajdjLrVgCoUnsLAadmbsZoMg/ku
X-Gm-Gg: ASbGnctyMRiK0fwna9OZhc2KCn7e8nsvx37fSMxlhH85JghH8ntfCpGNHrIoj1w0d03
 MS5MmJbNEKdQWHvOl1na5ueoNhZvQ5sRMX2LjSfL62WjSFFVNld8r8tVxjr5Lw8S/XxLLi+BnsA
 YCVW9PerW25ZavfGSMTwxxAJZsl8WLooCJZ4XnnMKacX9/DpXXKFjEKjEaIa3awhpXL38ihYLls
 aV+abKr18+PhZkTFKwoq1bju/nQPAWyFJHppMU/8hAFwqNECdbZIySAIZcWF1L3iy7uEhU7aR1t
 haFP/Xy2uCru6KGM0uRAYxYYERHh50Jj
X-Received: by 2002:a05:600c:1c0b:b0:43c:f81d:34 with SMTP id
 5b1f17b1804b1-451f0f2cf85mr59708865e9.9.1749114572995; 
 Thu, 05 Jun 2025 02:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBLggd5edrGRUFlcZGYz/xOL07jXRe9T5RSKpFq4O15Vol9eJqkISYQyHF32JFYS+mf7r0EA==
X-Received: by 2002:a05:600c:1c0b:b0:43c:f81d:34 with SMTP id
 5b1f17b1804b1-451f0f2cf85mr59708495e9.9.1749114572552; 
 Thu, 05 Jun 2025 02:09:32 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f97f772csm18393715e9.5.2025.06.05.02.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 02:09:32 -0700 (PDT)
Date: Thu, 5 Jun 2025 11:09:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@linaro.org>, qemu-devel@nongnu.org, Yanan Wang
 <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org, Fabiano Rosas
 <farosas@suse.de>, Fam Zheng <fam@euphon.net>, Jason Wang
 <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>, John Snow
 <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>
Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_cpuid field
Message-ID: <20250605110930.7659fa39@imammedo.users.ipa.redhat.com>
In-Reply-To: <973e1fb8-e138-44bd-be73-9d53d9bed75c@intel.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-5-philmd@linaro.org>
 <ccf78c07-fc08-493f-85d8-5058cccbe82e@intel.com>
 <aDad5elq0bgZ/tvp@intel.com>
 <20250603170238.75a0f1de@imammedo.users.ipa.redhat.com>
 <973e1fb8-e138-44bd-be73-9d53d9bed75c@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 3 Jun 2025 23:54:19 +0800
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> On 6/3/2025 11:02 PM, Igor Mammedov wrote:
> > On Wed, 28 May 2025 13:23:49 +0800
> > Zhao Liu <zhao1.liu@intel.com> wrote:
> >  =20
> >> On Wed, May 28, 2025 at 10:09:56AM +0800, Xiaoyao Li wrote: =20
> >>> Date: Wed, 28 May 2025 10:09:56 +0800
> >>> From: Xiaoyao Li <xiaoyao.li@intel.com>
> >>> Subject: Re: [PATCH v4 04/19] target/i386/cpu: Remove X86CPU::check_c=
puid
> >>>   field
> >>>
> >>> On 5/12/2025 4:39 PM, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>>> The X86CPU::check_cpuid boolean was only set in the
> >>>> pc_compat_2_4[] array, via the 'check=3Doff' property.
> >>>> We removed all machines using that array, lets remove
> >>>> that CPU property and simplify x86_cpu_realizefn(). =20
> >>>
> >>> No.
> >>>
> >>> We cannot do this. Because it changes the behavior of QEMU.
> >>>
> >>> 'check_cpuid' is true by default while 'enforce_cpuid' is false. So t=
hat
> >>> QEMU emits warnings in x86_cpu_filter_features() by default when user
> >>> requests unsupported CPU features. If remove "check" property and the
> >>> internal 'check_cpuid', QEMU will not do it unless user sets enforce_=
cpuid
> >>> explicitly. =20
> >>
> >> One option would be to have x86_cpu_filter_features() unconditionally
> >> turn on verbose and print warnings, but some people might want to turn
> >> off these warning prints, I don't know if anyone would, but it would be
> >> possible.
> >>
> >> The other option is still to keep the =E2=80=9Ccheck=E2=80=9D property.
> >>
> >> IMO, the latter option is the better way to reduce Philippe's burden. =
=20
> >=20
> > we essentially loose warnings by default when some features aren't avai=
lable,
> > qemu still continues to run though.
> >=20
> > Given that Daniel acked it from libvirt side, libvirt doesn't care abou=
t warnings
> > (it does its has its own cpu model calculation). Likely other mgmt do n=
ot care
> > about it either, and if they do they probably doing something wrong and
> > should use QMP to get that data.
> > That leaves us with human users, for that case I'd say one should use
> > enforce_cpuid if feature availability matters. =20
>=20
> But with "check", it allows the VM to continue running with the=20
> unsupported bits cleared and warnings to inform users. This is really=20
> friendly.

it's friendly for human users (mostly developers), but for upper layers
is doesn't make a difference, since it's noise in logs nobody reads until
qemu somehow works.

the 1st category can and should use enforce flag instead to get what they a=
sk for
if they care about it.
If missing feature bits do not matter then it warnings shouldn't matter eit=
her.
What I'm advocating for is being more strict/deterministic on QEMU side,
  1. you get what you asked for with enforce or fix you CLI explicitly
     to be clear on what you are missing out.
  2. you don't care if some features are missing, but then you don't really=
 care
     about warnings either. (I'd still get missing features filtered out th=
ough,
     just silently). If one cares about missing features, one can use #1

I admit, It's a tiny bit of code but removing it, cleans up code a little b=
it
and helps readability/in reviews. Doing such small cleanups here and there
have a cumulative effect on the codebase.

Anyways it's not something I'd fight for, so if you insist on keeping it
it's ok as well.

> > so +1 to removal
> >    =20
> >>
> >> Regards,
> >> Zhao
> >>
> >> =20
> >  =20
>=20


