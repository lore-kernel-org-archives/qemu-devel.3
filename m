Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D35C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 18:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcTR8-0003q7-DN; Mon, 27 Jan 2025 13:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tcTR2-0003n2-Ft
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 13:02:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tcTR0-00015H-Ut
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 13:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738000924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bhpu9MchmNdHUpPQcmJVMSueXNvXyJXq3iNa/M1CVyc=;
 b=G0Bshx9vOjL8hKNz3qZ1F71i5pYbXdBtDyk7u9DJD13e1YfiaAblrCPG25C9EPHjt0Q5UY
 MnehX9Lh7vV7MhzVACe8aiOTpznW5amcl4pXKxb43TfOZ5KsORQxE20bZU59mOVpJ7H6MV
 HkCFybtUbYG5FPVuqm4D4wMcw++JEw0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-yTn41w-lPWubzjPw5-4Rlw-1; Mon, 27 Jan 2025 13:02:02 -0500
X-MC-Unique: yTn41w-lPWubzjPw5-4Rlw-1
X-Mimecast-MFC-AGG-ID: yTn41w-lPWubzjPw5-4Rlw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3860bc1d4f1so2952819f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 10:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738000921; x=1738605721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bhpu9MchmNdHUpPQcmJVMSueXNvXyJXq3iNa/M1CVyc=;
 b=dBLfvBPuZvv3ZNfJ5lZv1eolcow6LqEZsuM3zyg4kqgHd6JHd6/AJ2IGm7he0qvSPt
 HfugEo4uBQFH7AWAsYrtTSOT+4cgKGOoMknEktwjScSbsWp8bn2tDtfTrZ6E52WQhkgT
 yyE+sdc/E+U3iWmQwuuLtehFdI4wrIAUkYXktbyel98wTPXbdd5EI5NzAw49xKMjKV+p
 Jz9TrI8twFKzgJ7Y44uaMg2oCgUH8gk+/BVi/OueHA9CXsFkKPs6zyktsvaAKzVYicze
 uGx9PJ2SzO6HXYO/mSn51s+RTa8HtSvRfa31rH9ceQ4OIYcF85nXVztHO/0QLQieh4o7
 TkwQ==
X-Gm-Message-State: AOJu0Yzk+IoHLXJ05XVQSnkkxoyUCG7+/ASEhXxCqIjCH1xSuCSx2eE1
 4LVAmFhNMtxRQi/gZGAd4F8qJae2WttUO1coMla0HAo5O11O7T0Hk8C/h/MuTJY3WyX+aq6XtWp
 BGDg6egumhErkei8zuGrCa6Our++H0I2lGwb3KUz7yXCEUmyMrbvZrgPBzRIDN4/m3YmReZSEJE
 97sDI0G4zq4n5fjJWfu6b2HY5pFos=
X-Gm-Gg: ASbGncsZYm21TMducZ2+l9wANJygZUC5hpGZ4BfAb4i6FB2dPWdiec7AHgQaQy0QUSQ
 XXLxoIfmK1N6NN94sW0WmbQ1qT7S9Tr0KEvQtfP4u7Gg6IkLF61GX/JW+MPBm7Q==
X-Received: by 2002:adf:ab11:0:b0:38a:4b8a:e477 with SMTP id
 ffacd0b85a97d-38bf579259bmr26493765f8f.22.1738000921428; 
 Mon, 27 Jan 2025 10:02:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkOV+tC24FCp1D7NxFscj0H8TuVNXXO+42jCviW1GTHkLlpQg6CM1IE22RJeFIG9iSHYvi1DegMMEmcE00GFQ=
X-Received: by 2002:adf:ab11:0:b0:38a:4b8a:e477 with SMTP id
 ffacd0b85a97d-38bf579259bmr26493708f8f.22.1738000920683; Mon, 27 Jan 2025
 10:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-9-pbonzini@redhat.com>
 <Z5dgn5MQNGEa5lry@intel.com>
In-Reply-To: <Z5dgn5MQNGEa5lry@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Jan 2025 19:01:49 +0100
X-Gm-Features: AWEUYZmql0qa-1YKNBOtXnM4JApCCPsUM4pjW2tMt4xiKi87W6B9k-m9lEteIvg
Message-ID: <CABgObfY1LqB=9KOH0NOxdu+2gF4K+Xg9JqHWLfS9jpnN6Hp6wQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] rust: qdev: switch from legacy reset to Resettable
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 27, 2025 at 11:12=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
> > +    /// If not None, this is called when the object for entry into res=
et, once
> > +    /// every object in the system which is being reset has had its
> > +    /// @phases.enter method called. At this point devices can do acti=
ons
>
> Maybe s/@phases.enter/ResettablePhasesImpl::ENTER/?

Yes.

> This constraint requires each device to explicitly implement ResettablePh=
asesImpl,
> even the device doesn't want to do anything for reset.

Yes, that's true but it's just a line of code. Almost all devices
*will* want to do
something with reset.

> So what about the following changes:
>  * Define 3-Phases methods in DeviceImpl.
>  * Implement ResettablePhasesImpl for all devices by passing their 3-Phas=
es
>    methods to ResettablePhasesImpl's.
>
> +impl<T> ResettablePhasesImpl for T
> +where T: DeviceImpl
> +{
> +    const ENTER: Option<fn(&Self, ResetType)> =3D T::RESET_ENTER;
> +    const HOLD: Option<fn(&Self, ResetType)> =3D T::RESET_HOLD;
> +    const EXIT: Option<fn(&Self, ResetType)> =3D T::RESET_EXIT;
>  }
>
>  /// # Safety
>
> ---
>
> Then device doesn't need to implement this reset trait if unnecessary.
> Though this way add duplicate methods, it reduces the burden on the
> device developer.

For now I prefer to make things homogeneous... this way if someone has
to copy the code into a wrapper for a new interface they don't have to
wonder about small differences.

(This by the way will also be a reason to use function pointers for
character devices as well, instead of the trait approach that I used
in https://lists.nongnu.org/archive/html/qemu-rust/2024-12/msg00006.html).

Paolo


