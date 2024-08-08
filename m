Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E03C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 10:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc05d-0002hb-KZ; Thu, 08 Aug 2024 06:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sc05c-0002h7-1T
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:09:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sc05W-0001r3-IF
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723111780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0x5a3xy4i1LCTUj+etGBLc9ML2yg6A3Oq0y6AgwAno=;
 b=i90n0ZMlx6ig5ThlymRvvcX9oKyVeUY78vNXjRC7JrFyd1F7qfB+Y897rm/PCEX6nqGGNC
 wZUITjaZjTghIvWqulw4fOUrCkcRFkp2+u5Wiu85GTXAPpZofNOqV2cvWkifh+SZ/CiLeU
 ZBAHWAETTRm1yLUwtxyePm+0j6cXaZs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-pIvTg2MRNvOLbSwk_hs8Yw-1; Thu, 08 Aug 2024 06:09:35 -0400
X-MC-Unique: pIvTg2MRNvOLbSwk_hs8Yw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4281f8994adso6381625e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 03:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723111774; x=1723716574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U0x5a3xy4i1LCTUj+etGBLc9ML2yg6A3Oq0y6AgwAno=;
 b=S2tUDBXL1+8E0YvTd3MkkrqItti0bT+DXKdBjJcAgyJjZjV2PVfjMfd0bsG+CtjLBs
 lUh9f2bjOO1GDpI5x+7YzslRnKhWtiuKJzg057XFsuw+EVQ579MLwxywKtM0WzFcyFR6
 BU2xiDzp3IFBOZFYPUwF3Ko6EWoa06cfyNtSPsJVMiI9J9QRqgexBzaNffAbS0N2YTIj
 +aAe+D9G3qrGeO6/tGXFwg96cZhO55OHqD+x1pgZuPLL8HmZvWG1zElMqHbsxs5ibqKG
 VP+VTKr1mZidMXWPabbixXqEQ+maX4QeSIsp9Icbf1gIlPs5Tk+PiJ/tiOEKp2crcGJa
 PJSQ==
X-Gm-Message-State: AOJu0YyD3pGCcy4LFumO6PGoHpGVJh18DQ31zwp7NCMFOnIdN0MBvqjV
 BImJiA0KpcgyHdXbA5ZhPIuNN3mUU9zDGdIIaU05sErsm9RlYZRjbZFIrxqSk018plHFpDC+vx4
 R+R5ktQdu1OSPN76H2aJ0noDfXAAmr6lrNJm0h+8IOYS4b1o2yEWsdT7gIQHs8ItyyBY2UKHbwK
 URurVpW+pYXxAz7ZU9+goj4EcQGi8=
X-Received: by 2002:a5d:640b:0:b0:368:4b3a:2022 with SMTP id
 ffacd0b85a97d-36d273cfe4emr1298154f8f.6.1723111773788; 
 Thu, 08 Aug 2024 03:09:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2ZOYWiCGR/ZTX4H9+iq0s0hvB620PBaEnFw99Op1wgzHO8NJgwXLcuHqe9J3RyUOd5cbT7RoNykCNQVAK4Bo=
X-Received: by 2002:a5d:640b:0:b0:368:4b3a:2022 with SMTP id
 ffacd0b85a97d-36d273cfe4emr1298122f8f.6.1723111773246; Thu, 08 Aug 2024
 03:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
 <f989d834-706a-4708-be81-f6447237425e@redhat.com>
 <hw3gw.4cxgt9epvs2@linaro.org>
In-Reply-To: <hw3gw.4cxgt9epvs2@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 8 Aug 2024 12:09:18 +0200
Message-ID: <CABgObfbMdqCGU4Xhkv=tuo=wR_Pqo3e7zxYs6_5LLSv_e7haQg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 0/5] rust-pl011-rfc-v6
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
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

On Thu, Aug 8, 2024 at 9:58=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Thu, 08 Aug 2024 09:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >On 8/4/24 23:04, Manos Pitsidianakis wrote:
> >> Changes
> >> =3D=3D=3D=3D=3D=3D=3D
> >>
> >> - Setting MSRV to 1.77.0:
> >>    * cstr crate MSRV is 1.64, which is more recent than Debian bookwor=
m
> >>      (1.63.0) <https://github.com/upsuper/cstr/blob/master/Cargo.toml>
> >>
> >>    * pl011's dependencies (mostly proc-macro2) don't support 1.63.0
> >
> >proc-macro2 is listed as supporting 1.56.0, and in general I don't see
> >particularly high MSRVs for any of your dependencies.
>
> The issue was with transitive deps, proc-macro-error crates etc stopped
> compiling when lowering the version, which means we'd have to patch the
> dependency's dependency to see if that'd work; otherwise, yes!

Ah, I see now - you have to set the right cfg for proc-macro2 to
compile with 1.63.0. Normally (including with "method =3D cargo") they
are detected by build.rs:

    if rustc < 66 {
        println!("cargo:rustc-cfg=3Dno_source_text");
    }

    if rustc < 79 {
        println!("cargo:rustc-cfg=3Dno_literal_byte_character");
        println!("cargo:rustc-cfg=3Dno_literal_c_string");
    }

(Meson's support for build.rs is very limited, but it does handle some
simple cases and parses rustc-cfg from the output).

And bilge-impl uses let...else; we can patch it locally via the .wrap
file's "diff_files" entry. Not great, but it's good that we can do it
and that we have an example for similar issues in the future.

I updated my rust-for-manos branch with these discoveries. Of course
it doesn't compile with 1.63.0 but it does at least configure
successfully with

../configure --rustc=3D$(rustup +1.63.0 which rustc) --enable-rust

and build the subprojects' rlibs.

> >The automatic Cargo.toml support in Meson is promising [...]
> >My suggestion is to name our manually-managed subprojects with
> >the same convention that is used by "method =3D cargo" in Meson 1.5.0+,
> >i.e. name-APIVER-rs:
>
> Yes that makes sense!

Good!

> >- for patch 2, the only issue is that you are specifying
> >--no-include-path-detection and that breaks for me on Fedora.  I have
> >not finished testing but it seems that it's enough to remove that line.
>
> I had added that when trying to debug bindgen failing to find headers
> when dependencies were added (e.g. linux io_uring) or when compiling on
> macos, let's test again to see if it's indeed unnecessary!

Ok, crossing fingers.

Paolo


