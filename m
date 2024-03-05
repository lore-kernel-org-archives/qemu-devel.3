Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3756EC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhUnN-0001UZ-4f; Tue, 05 Mar 2024 08:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rhUnF-0001MG-H4
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:25:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rhUnC-0000IR-3w
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709645113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T79oVyRg7XNKTAqVdhgKpl0H0wRy/jlYtV8yLhmXE5c=;
 b=fuPzyQhSuS/MgtNtZtFfyDKI7BAc6jQxiFdhCg66G0Rl9JReZ/HcZyvxddEKH5A2W2shRx
 RlMnfFslojPJqsJ+o8fYmwjK+d5ysz2vUBEeCx8raVXNktQ9K8M9JSAyfY6Xv1Cuiq8cW2
 6lJrKqXCVRv8NNf/97QjOtgZUDkyL4c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-6zP2TYT0N5mzugjDBz5KAQ-1; Tue, 05 Mar 2024 08:25:11 -0500
X-MC-Unique: 6zP2TYT0N5mzugjDBz5KAQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-412e51c20fdso12001395e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645110; x=1710249910;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T79oVyRg7XNKTAqVdhgKpl0H0wRy/jlYtV8yLhmXE5c=;
 b=U7w0dZX4lhlHmPKChC12pokFBn/y+t/6GW3XrZfiKqmVhG4tk4gLYYlXFrJWB5pSkN
 TAW33J9Yqj9r1j10tADRdOxDWk86eFCoBtqXwjXV4V/0Spjt80m2ZKjLP/Fx33pu5x82
 IifKOjkfJPZm4lMFif3d339WcoPtsNPdIF+NGGaBm1jdZ4OpElBSKYezomMqEWxKOs5D
 BeD8/fPTSUZdh78TnsK1GauKbcKiQ/EH5fls/Z75noNu+q/0wts2g7GjTXwuU7LUWWUx
 Oa8aJPjJsTtabsojd1NT5M2QvfiuXjH46S8dAzA5EzduONNB+OWspjsqZj4Y3h77OgqJ
 HfOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu2eMVH/ZVQ1EHGfvr8QztUm/v2rd7J3lcCW6A8Js8ZD691PzakyV27cpDYdNnC+hXhOsc6GvnAL6UCNwViSIisN1GJLs=
X-Gm-Message-State: AOJu0YzDWcpKbBc3J0Rfe3BNvfyaOwLSM46z3N0PwN4KFPnN25gwKUps
 WJhp0I7Yb+MHmg9YfXQw7nFN2kK/RQagaR0MEtbVz7OkMyXrdgUjSRNh3lRPe25Z04kfaJFeHGN
 FO2Bys61xN1Ko66TdD5qEYPqJr/mCk+Q+Dm4vvUWuTESdGbVFc1R0
X-Received: by 2002:a05:600c:4504:b0:412:b42c:8ff1 with SMTP id
 t4-20020a05600c450400b00412b42c8ff1mr10684179wmo.21.1709645110619; 
 Tue, 05 Mar 2024 05:25:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3q9RiTK82INQT11px/g7VIRLAj70Wti28vSUgsmf6eyI91e6IAGPZF2EIGY65Wv97eXWB3w==
X-Received: by 2002:a05:600c:4504:b0:412:b42c:8ff1 with SMTP id
 t4-20020a05600c450400b00412b42c8ff1mr10684160wmo.21.1709645110217; 
 Tue, 05 Mar 2024 05:25:10 -0800 (PST)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a05600c451000b00412e13bb942sm7280397wmo.19.2024.03.05.05.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 05:25:09 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 14:25:09 +0100
Message-Id: <CZLUM0L9G5U3.1UOBP5UFKY1AA@fedora>
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
X-Mailer: aerc/0.15.2-111-g39195000e213
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com> <Zbi9vjPCsia58LG4@redhat.com>
 <CZL1LKPLC005.2WG9X653U6H6D@fedora> <ZeXfPdp-Ul3vxlxL@redhat.com>
In-Reply-To: <ZeXfPdp-Ul3vxlxL@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Daniel P. Berrang=C3=A9, Mar 04, 2024 at 15:48:
> On Mon, Mar 04, 2024 at 03:41:02PM +0100, Anthony Harivel wrote:
> >=20
> > Hi Daniel,
> >=20
> > > > +        if (s->msr_energy.enable =3D=3D true) {
> > >
> > > This looks to be where we need to check that both the host CPU
> > > vendor is intel, and the guest CPU vendor is intel, and that
> > > the host CPU has the RAPL feature we're using.
> >
> > Checking for the host cpu and RAPL enable is fine and done.=20
> >=20
> > But checking for guest CPU is confusing me.=20
> > The RAPL feature is enable only with KVM enable.=20
> > This means "-cpu" can only be "host" or its derivative that essentially=
=20
> > copy the host CPU definition, no?
>
> KVM can use any named CPU.
>
> > That means if we are already checking the host cpu we don't need to do=
=20
> > anything for the guest, do we ?
>
> When I first wrote this I though it would be as simple as checknig a
> CPUID feature flag. That appears to not be the case, however, as Linux
> is just checking for various CPU models directly. With that in mind
> perhaps we should just check of the guest CPU model vendor
> =3D=3D CPUID_VENDOR_INTEL and leave it at that.
>
> eg, create an error if running an AMD CPU such as $QEMU -cpu EPYC

The idea looks good to me. Now the hiccups of this solution is that=20
I cannot find a way to reach CPUArchState at this level of code (i.e=20
kvm_arch_init() ) with only the MachineState or the KVMState.=20
I can only reach the topology with x86_possible_cpu_arch_ids().

CPUArchState struct is holding the cpuid_vendor variables where we can=20
use IS_INTEL_CPU() for checking.

Maybe you know the trick that I miss ?=20

Regards,
Anthony

>
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|


