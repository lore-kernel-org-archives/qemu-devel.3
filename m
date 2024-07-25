Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4539C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 11:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWwVo-0008Qr-0C; Thu, 25 Jul 2024 07:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWwVn-0008QF-0A
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWwVk-0002hm-K0
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 07:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721906390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bHE0suzOgVJ4VVXqlkK337VRdBbbDv13WLL+YcRUsCM=;
 b=XR8JA9SNDIp5zcBTLVvSUNruHQcaJSM+9eLPxr5ilq/UHv7rVwZXH//NcGdJ2zqPpdGeNs
 UKR6NSi3FpBIEx5YxkmTF4ckpehlY2CaZQl1+K/AfJxItIPtipx5u5zakpNN4Uk7+ny80n
 WbbZa/cYd1IubtPcaPFqjL90+nRYU7g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-QyNctCJwNYWRZW8sRthC1Q-1; Thu, 25 Jul 2024 07:19:48 -0400
X-MC-Unique: QyNctCJwNYWRZW8sRthC1Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-427b57e3c6fso6146785e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 04:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721906387; x=1722511187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bHE0suzOgVJ4VVXqlkK337VRdBbbDv13WLL+YcRUsCM=;
 b=Dl+IyLO3fmI7C5OVApp2YAfNojJ7ABiuSa1fi7WYDdmQyUlNAc8CHUgaNxbv633ffX
 p13XZGVewlRO4Ja1eHx5Io3UlXEot4C4AiPsf5S/s2VVXYV2+JCjC1W/RDjyfObvQzjW
 EEAjwhDOL80h1Le5T2/eZrPuzOiXW7CLGrjD4d8zzshg4aPiymzrDSYMs0oH03CBNbIz
 XbcvDiVmcQopN5hQEkkinb/SQw1Zvz9UcJei4RMdXsBx7p3xTiHXFIPIg/FLV91lehRV
 rQ56MZVsdcwEYjh6/+TGoTqzexbzSSf+EKglUzEERcNyov3QZOuv7oAKw9yMDV7OW5bx
 /wFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCiSd6KdM7RJ2Oo4W4VFPH9G9soavUxi35XJ3VOaCIP/I5luryvD94V76gFpE2KPQOm94p9LYN9+R1v69vGt0qnW22xus=
X-Gm-Message-State: AOJu0Yyp9C8P+zHRyahUdCNvCwfpsvFKDg4dZKUvv1swS75zAKE65r0f
 e6QGQA97nAVczNlU35h9Z1a1aUSGh2pGakpP3en5Y/ikBdNx0EO4918ao2wwxzSy9dgm0tc/nI1
 mh2HB8HaLB+JAb8ftpsDhAYbG5vadoGd2akQzFNoeWg65VRFcXoqHkoYIbah/cwQ1R0Eb1PgyBE
 xsrPIfgwVruB3kQ+S9Aox4wNM1vrg=
X-Received: by 2002:a05:600c:a4b:b0:426:54c9:dfe5 with SMTP id
 5b1f17b1804b1-42806b82ed6mr13762765e9.10.1721906387526; 
 Thu, 25 Jul 2024 04:19:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKQbc0fIoNgRHg+IjcatcgW82Rg5bxAfH7vHwq+UFlfspazktSMBrtVM44VIeOe4OzV9W/Wpr6GLD2/gbnxug=
X-Received: by 2002:a05:600c:a4b:b0:426:54c9:dfe5 with SMTP id
 5b1f17b1804b1-42806b82ed6mr13762515e9.10.1721906387065; Thu, 25 Jul 2024
 04:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
 <h4gxy.dr366knvycy@linaro.org>
 <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
 <h61ku.ipxyjqsxu75@linaro.org>
 <CABgObfa-dxDD_oVGu8PrQffVhvP=MFifUUTinC-brzTnqdkK0A@mail.gmail.com>
 <h6cgm.o8scn84hx1ry@linaro.org>
In-Reply-To: <h6cgm.o8scn84hx1ry@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Jul 2024 13:19:34 +0200
Message-ID: <CABgObfbyw0qPM_T=SpGyHYD02x2jOdSy5nfwKpOx-WruhkJe9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qeemu-devel@nongnu.org, qemu-devel <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Thu, Jul 25, 2024 at 12:14=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> >Unfortunately that's a *mut, not a &mut. A &mut must be unique, so the c=
ast
> >in pl011_read() is undefined behavior.
>
> Actually it's:
>
>   unsafe { qemu_chr_fe_accept_input(&mut self.char_backend) };
>
> And you can ensure there's no disjoint borrowing by making a wrapper
> function that mutably borrows self, e.g.
>
> fn accept_input(&mut self) {
>   unsafe { qemu_chr_fe_accept_input(&mut self.char_backend) };
> }
>
> This is not undefined behavior, since the cast in pl011_read creates a
> mutable reference that does not outlive the same call to pl011_read.

pl011_receive (called by qemu_chr_fe_accept_input) creates a mutable
reference that *overlaps* the lifetime of the outer reference created
by pl011_read. This is undefined behavior. You're effectively writing:

fn main() {
    let mut foo =3D String::from("foo");
    let x =3D &mut foo;
    let y =3D &mut foo;
    print!("{}", y);
    print!("{}", x);       // does not compile
}

And even if you're hiding it like this:

fn main() {
    let mut foo =3D String::from("foo");
    let x =3D &mut foo;
    let x_ptr: *mut String =3D x as *mut _;
    let y =3D &mut foo;
    print!("{}", y);
    print!("{}", unsafe { &mut *x_ptr });
}

It's still wrong. Quoting the docs:

https://doc.rust-lang.org/nightly/nomicon/references.html
-> "A mutable reference cannot be aliased"

https://doc.rust-lang.org/nightly/nomicon/aliasing.html
-> "variables and pointers alias if they refer to overlapping regions
of memory."

https://doc.rust-lang.org/reference/behavior-considered-undefined.html
-> "Rust programs must never cause undefined behavior. It is the
programmer's responsibility when writing unsafe code to ensure that
any safe code interacting with the unsafe code cannot trigger these
behaviors."

The QEMU code has even more layers hiding the problem but it's the
same thing: there are two &mut that are alive at the same time, and
refer to the same region of memory.

> Please demonstrate a scenario where said problem shows up, otherwise
> it's just hand-waving on a undefined (pun intended ;) ) hypothetical.

Again: there's no "scenario where the problem shows up", you just
can't do that; the code is wrong.

I'm not saying you should fix it now, because it's complicated to fix
it and in particular to fix it the right way. But I think it is a
requirement for merging Rust code that the community understands the
extra complexity introduced by writing Rust code that interacts with C
APIs, and does not hand wave it away as not a problem.

> >> Do you perhaps agree with adding a FIXME comment to replace the linker
> >> attributes with ctor when we get the cargo dependency story in meson
> >> sorted out?
> >
> >Yes, that's fine.
>
> Thanks! We also have to keep in mind we would like Debian to be able to
> package this, so we should be very conservative on what dependencies we
> use.

If we add Rust dependencies, Debian will have to figure out how to
package them in order to build QEMU. But I agree that it's a good idea
to add them slowly.

Paolo


