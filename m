Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B06EC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 15:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX0Be-0001QL-6D; Thu, 25 Jul 2024 11:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sX0Bc-0001Gk-QI
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 11:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sX0Ba-0000Kz-4q
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 11:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721920516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zkWYscz+UxeleRuo1YprKmYtqTFnVOkx36gOcXItkOc=;
 b=aYOKtOrQGuafwz8IFDnc2xiqQEhUJsi3Ie45mYMhXeJXchM25o2mnaV3JKTWqPgWXTRKEC
 gb2xmBpxyxPsqaSNCWgcbNHh3JRM6Vqn/EBFdFXgcNij0inGcKvWs1DgCAkiQDGgFitWaZ
 bdWRfFaxsySZo836QkZdGI+oMtlyfns=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-K8V_gsfKN0qkr21R6tzvEQ-1; Thu, 25 Jul 2024 11:15:13 -0400
X-MC-Unique: K8V_gsfKN0qkr21R6tzvEQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42666ed2d5fso7151925e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 08:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721920512; x=1722525312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkWYscz+UxeleRuo1YprKmYtqTFnVOkx36gOcXItkOc=;
 b=oYAp8GlibteyXAjZkeL6mHvZuITV/1Bj6w05Q+4VenEXFjtyMzcl69Ggvs97v2m81b
 k+mR+sGxZWGojFE3Z9CGd3o5k5cdVBUohFlbP9gupkEzUJ53traBV42WP57ocq93jiJY
 9bvcWz1KCvnU6RpOrqxowGz+T7FrEdCe6rfgDvyXO3M7WR/l/9Vu/C+yA9NDOcguSMe8
 mnCHLuH5TOPBwE0IwWrJHyr+BRDD4d2mJOqhdBNivVfV2KOW4zGQnAjdgnKvWHvYT4mT
 FTsYpsK7bq5Aj1xDk9mIaZpGx7lKSzUvGyszBHI9VjxlLWOpB/8SdbC4KDPbvrBdTJYX
 cXew==
X-Gm-Message-State: AOJu0Yy4WthbQBclslhTW6EFAzP01OH/JkMSuK519QK/LqwT1EbJskBh
 1DS+ZS5blzRFO4dKE0RmgdeBP4VNWmh/KNd8hKxf3fQiBEn4gMct+EPgumRI4Vn7HprFe533eHF
 A7U39RrezqMmzAcDo3Uzntr6kSHPmCnPBYlJOSwXolFvl2suEyorHlHwfqTGd1mk5CNmda4oV2y
 L9iK6+IakeiX7XU0vEG4MWYjuf4GY=
X-Received: by 2002:a05:6000:e0b:b0:368:4bc0:9211 with SMTP id
 ffacd0b85a97d-36b319df352mr2446084f8f.17.1721920512561; 
 Thu, 25 Jul 2024 08:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUnC2apG5zTAAdXSwKQEHKHzW0vQASyGBeR2lEHzGgtCYDb1F5S/snsxc46AwvphcvpuSxsZJGIVP3gnQd40M=
X-Received: by 2002:a05:6000:e0b:b0:368:4bc0:9211 with SMTP id
 ffacd0b85a97d-36b319df352mr2446055f8f.17.1721920512154; Thu, 25 Jul 2024
 08:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
 <h4gxy.dr366knvycy@linaro.org>
 <CABgObfZOqBogWQtzfghjKMsW-J_sp-iL5dt7mmYnvE5eQb9G5w@mail.gmail.com>
 <h61ku.ipxyjqsxu75@linaro.org>
 <CABgObfa-dxDD_oVGu8PrQffVhvP=MFifUUTinC-brzTnqdkK0A@mail.gmail.com>
 <h6cgm.o8scn84hx1ry@linaro.org>
 <CABgObfbyw0qPM_T=SpGyHYD02x2jOdSy5nfwKpOx-WruhkJe9Q@mail.gmail.com>
 <CAAjaMXY3jL=cVs=e+6kiJw_WrfG5vOaqaNFu74BdoK2-bO7ZLQ@mail.gmail.com>
In-Reply-To: <CAAjaMXY3jL=cVs=e+6kiJw_WrfG5vOaqaNFu74BdoK2-bO7ZLQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Jul 2024 17:15:00 +0200
Message-ID: <CABgObfb27wbwgErFsMdsuSo1BxQVBoRfbrUmK2k-x5Ya3ez0TA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 25, 2024 at 4:48=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> > pl011_receive (called by qemu_chr_fe_accept_input) creates a mutable
> > reference that *overlaps* the lifetime of the outer reference created
> > by pl011_read. This is undefined behavior. You're effectively writing:
>
> There is no overlap there, sorry. Once qemu_chr_fe_accept_input
> returns, any references it created do not exist anymore.

read     |-------------|
receive      |-----|

That's the overlap. Maybe you're thinking that the outer &mut "goes to
sleep" and is reborn when qemu_chr_fe_accept_input() returns, but
there's no such thing in the language.

You can do it within a function:

fn main() {
  let mut x =3D 42u32;
  let a =3D &mut x;
  let b =3D &mut *a;
  *b =3D 0;
  *a =3D 43;
  // *b =3D 42;
}

But that's because the compiler _knows_ the provenance of b. So it
says "ok, 'b' is basically the same as 'a' and 'a' won't be accessed
while 'b' is live". This doesn't happen in any other case. In fact
miri points out that, the moment you create a &mut in pl011_read, the
chardev's opaque becomes effectively unusable[1]. In other words,
you're not even allowed to turn it from a *mut into a &mut!

Again: it's exactly the same as the example above

fn main() {
    let mut foo =3D String::from("foo");
    let x =3D &mut foo;                         // pl011_read has a referen=
ce
    let x_ptr: *mut String =3D x as *mut _;     // pl011_receive starts
    let y =3D &mut foo;                         // pl011_receive creates
a reference

    // at this point, x becomes invalid
    print!("{}", y);
    // pl011_receive returns

    // this is undefined behavior (shown by miri)
    print!("{}", unsafe { &mut *x_ptr });
}

Honestly I don't see how I can provide a proof or explanation that is
more definitive than miri. If some specific documentation or
discussions gives you the perception that there is no undefined
behavior, I'm happy to check them out and provide an explanation in
that context. But otherwise, I don't think it's useful to keep
debating *whether* it is undefined behavior.

Paolo

[1] this is the other example I gave a few hours ago, which I'll copy
here for reference:

// MIRIFLAGS=3D-Zmiri-ignore-leaks  cargo +nightly miri run
use std::mem::MaybeUninit;

struct S {
    me: *mut S,
    them: *mut S
}

impl S {
    pub fn chardev_receive(&mut self) {
        println!("in chardev_receive with &mut");
    }

    pub fn memory_write_good(&mut self) {
        println!("in memory_write_good, calling qemu_chr_fe_accept_input()"=
);
        qemu_chr_fe_accept_input_good(self);
    }

    pub fn memory_write_bad(&mut self) {
        println!("in memory_write_bad, calling qemu_chr_fe_accept_input()")=
;
        qemu_chr_fe_accept_input_bad(self);
    }
}

fn qemu_chr_fe_accept_input_good(c: &S) {
    // you can still go from *mut to &mut in _another_ instance of struct S
    (unsafe { &mut *c.them }).chardev_receive();
}

fn qemu_chr_fe_accept_input_bad(c: &S) {
    // you cannot go from *mut to &mut when it points to _this_ instance;
    // creating the &mut that is passed to memory_write_bad() has
    // effectively made that *mut unusable!
    (unsafe { &mut *c.me }).chardev_receive();
}

fn main() {
    let p: &mut MaybeUninit<S> =3D Box::leak(Box::new(MaybeUninit::uninit()=
));
    let q: &mut MaybeUninit<S> =3D Box::leak(Box::new(MaybeUninit::uninit()=
));

    unsafe {
        let p_mut_ptr =3D p.as_mut_ptr();
        let q_mut_ptr =3D q.as_mut_ptr();
        *(&mut *p_mut_ptr) =3D S { me: p_mut_ptr, them: q_mut_ptr };
        (&mut *p_mut_ptr).memory_write_bad();
        (&mut *p_mut_ptr).memory_write_good();
   }
}


