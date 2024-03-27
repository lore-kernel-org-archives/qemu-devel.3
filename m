Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8943AC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 08:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpP2M-0000IH-2C; Wed, 27 Mar 2024 04:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rpP2G-0000Bd-3s
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rpP2D-0004nl-T8
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711529604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cf4cCnC+qe5Ypk9TgMBbXSUglge44MnVLQOMvYgo2s=;
 b=Fhefc0EMWXrynZQjdjGMXs/Sn9Ph+GfePbr7o2hzlJUcGabLEJA0hJyur+3NcjaFU6sptF
 3z01zOimqKGK2xH+qtHnOvOc+l/Q3UuiCpP8zTJtz5cokOJS61PnSlu4bosMrZYFP00TIz
 bZUz/5SuEAPSkN9/P+xKqWRfdhe9XZg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-FCwRYvs7NZuL2wOUJ4Lsuw-1; Wed, 27 Mar 2024 04:53:21 -0400
X-MC-Unique: FCwRYvs7NZuL2wOUJ4Lsuw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41481ad9364so27979555e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 01:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711529600; x=1712134400;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6cf4cCnC+qe5Ypk9TgMBbXSUglge44MnVLQOMvYgo2s=;
 b=EiKhiyKpTFEFgcr3r1vUyP2ofaeNN76z0tbC+bvkfdLXBToc5m9okCL0s5ElERW4VA
 2ZVfhbtC9tL7cBZMByugeGKgxZ7tpr18O7/f62taBY+4VPgfQD/GXSZX13vBrPHvUQqw
 RYR5ZRmUkc656R0t/8HjNcNZinSuRUiR87xvqhZUxXcD1P3q75TCp0rf71IVq2/2g34j
 AqbKW1VDfiN/36MAY8KOIaJcecOcUk87Y1yE2PmJi4xODsw3rAwvQNb0lSGfTQTf45gN
 ZDdXpCxgp5pQgaajPF9EbxuerEEFbN6M4dx8bHdcneTEwkC8NUJYxFnvhwz5DQoxAhej
 Otsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcvUvv1eh6jufkmZCW/gMXQYAOYsxikeytByhDf+tfhXpJuueyBwVvWlEWAiH+cupL43KD5L2Y1jCtTSmpxQtX9WrBP3M=
X-Gm-Message-State: AOJu0YxobBRlb0iGCRe/jnU5R3OjRUwvvWe+LuR7aEvrX2JEHNSAGshY
 Rs++Q4/s4f+lIet7k79XD5NxCiCvmRal2GVi0XV/VvDvm0zXSX+W2/KC40SVYUi6dQGYycScYnP
 X/qcGZ2dl6Y4ARw0TE+Fie6uKkPk/9J8FtHk+kqLHCjViidXEWLXyQNmnvEjm2U3nmQP049zU5u
 URFs4eHBk71cGetWjndeTbMRCkAos=
X-Received: by 2002:a05:600c:314c:b0:413:2873:937 with SMTP id
 h12-20020a05600c314c00b0041328730937mr1618757wmo.35.1711529600222; 
 Wed, 27 Mar 2024 01:53:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2L75qsx6232S4O6zkODYRiFhAacXms15IMaam2sxmCRP+hNFo9OXoiwvyuX8V+YgKxAvXF7hp/iZ0qLkDXnc=
X-Received: by 2002:a05:600c:314c:b0:413:2873:937 with SMTP id
 h12-20020a05600c314c00b0041328730937mr1618749wmo.35.1711529599914; Wed, 27
 Mar 2024 01:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240318155336.156197-1-kraxel@redhat.com>
 <20240318155336.156197-2-kraxel@redhat.com>
 <54e8b518-2bea-4a5b-a75a-4fd45535c6fa@intel.com>
In-Reply-To: <54e8b518-2bea-4a5b-a75a-4fd45535c6fa@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 Mar 2024 09:53:07 +0100
Message-ID: <CABgObfZ5GpnoFwfbMNbPoWceifO0hiqu7LePvZFWLNOwCRvC1Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kvm: add support for guest physical bits
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 Tom Lendacky <thomas.lendacky@amd.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 20, 2024 at 3:45=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
> If users pass configuration like "-cpu
> qemu64,phys-bits=3D52,host-phys-bits-limit=3D45", the cpu->guest_phys_bit=
s
> will be set to 45. I think this is not what we want, though the usage
> seems insane.
>
> We can guard it as
>
>   if (cpu->host_phys_bits && cpu->host_phys_bits_limit &&
>       cpu->guest_phys_bits > cpu->host_phys_bits_limt)
> {
> }

> Simpler, we can guard with cpu->phys_bits like below, because
> cpu->host_phys_bits_limit is used to guard cpu->phys_bits in
> host_cpu_realizefn()
>
>   if (cpu->guest_phys_bits > cpu->phys_bits) {
>         cpu->guest_phys_bits =3D cpu->phys_bits;
> }
>
>
> with this resolved,
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

[oops sorry - I noticed now that this email was never sent, so I am
sending it for archival]

There are more issues:

1) for compatibility with older machine types, the GuestPhysAddrSize
should remain 0. One possibility is to have "-1" as "accelerator
default" and "0" as "show it as zero in CPUID".

2) a "guest-phys-bits is not user-configurable in 32 bit" error is
probably a good idea just like it does for cpu->phys_bits

3) I think the order of the patches makes more sense if the property
is added first and KVM is adjusted second.

I'll post a v5 myself (mostly because it has to include the creation
of 9.1 machine types).

Paolo

> > +    }
> > +}
> > +
> >   static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
> >   {
> >       X86CPU *cpu =3D X86_CPU(cs);
> >       CPUX86State *env =3D &cpu->env;
> > +    bool ret;
> >
> >       /*
> >        * The realize order is important, since x86_cpu_realize() checks=
 if
> > @@ -50,7 +73,13 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **=
errp)
> >                                                      MSR_IA32_UCODE_REV=
);
> >           }
> >       }
> > -    return host_cpu_realizefn(cs, errp);
> > +    ret =3D host_cpu_realizefn(cs, errp);
> > +    if (!ret) {
> > +        return ret;
> > +    }
> > +
> > +    kvm_set_guest_phys_bits(cs);
> > +    return true;
> >   }
> >
> >   static bool lmce_supported(void)
>Ther


