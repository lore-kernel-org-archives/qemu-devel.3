Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0D5C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27k-0002p2-1w; Tue, 10 Jun 2025 12:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uP1ZB-00033Q-GS
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uP1Z5-0001eu-QL
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749571862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lw4KCgn5AuZvkE6iDhSORyprWcfTe4OMDLQGuKVdJ68=;
 b=K/JPED1DWreLh6dNLi1Ky/KwB86/2PlF5N0I/zKkUZNOTtwG1XKB7dyZRuRLrMMu5K1qCR
 DRFNjaXSrONTHGbIDzuMovjEkYku4/oljRmjNzSjqnijojmdGNndqDjY2KKYpjdN+IAzBa
 cxXIlfdRmP2xYnN8JBUTpxUac1MTvlM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-_TOcaThQOzCPbBoPH1Cn6Q-1; Tue, 10 Jun 2025 12:11:00 -0400
X-MC-Unique: _TOcaThQOzCPbBoPH1Cn6Q-1
X-Mimecast-MFC-AGG-ID: _TOcaThQOzCPbBoPH1Cn6Q_1749571859
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a50049f8eeso2558901f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 09:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749571859; x=1750176659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lw4KCgn5AuZvkE6iDhSORyprWcfTe4OMDLQGuKVdJ68=;
 b=ZosxGoMOjKNuKkOjMs5y4B4ml+OvVt92p9ZSRxtgKI2xucZH96QRJBmOuTzr29YOzm
 QlKIJ8bRsDoF7lytzPcIJLlWLEpJ82GRRp2s7gKhHJobk/rjk1iDogIN33F2i6ihf8Qr
 jEGv9Dp735Yexb+GJMBrAahXEr6e+UbdyN+2ZSxYCM2kM9Du8gIC/XYBM9JfVhVEbz1n
 jtaIkCDn8ZLkRry7dOKIVCHI9p/YH/C4v28UN9NvGdARVlp6tRcjD77xSsSqP7alRgx+
 qfTpGBpx3LmF66zIn9B/c5YfeNgHjB2Eqw4lixJm7kwn1K3YEEyjxMsAj/cR1teU7Kg/
 69+A==
X-Gm-Message-State: AOJu0YwTmBMNBBiTT20+pk/FLVv+5TPgfZPI+P9BwZh6gVcco+6X4jzn
 Nx5atZ5AWJJY17DPyeH76RK7C1XsT5qNk78FLuNKcK7YOQjMO65cPfHzIj8FFJQrzPrDsfinPaz
 OH2zSW6z9tCsuxfKiZAUfDNG7hmoIExJSFKvSVryAGgLrwdzS2Id+aXmbNVI6SnyVZnAOyWWrIS
 dlm5tgAtMeTW7vb+x+kLJwvypuMAvj7aE=
X-Gm-Gg: ASbGncticym5frAPbPvFkueO+ZqRWYVZKICDD+dKfqiO62bcNLyqaeVBUGsG2uqEc71
 ZapxBop2icIvS5qBSNzvZgnmH+mjZ+6wn6uvlb4bCRl9uDKs3Q7kQbFNX6ZcZkzH9hblqgi/B/a
 brfQ==
X-Received: by 2002:adf:f58c:0:b0:3a5:39d7:3f17 with SMTP id
 ffacd0b85a97d-3a539d73f90mr9783997f8f.47.1749571859468; 
 Tue, 10 Jun 2025 09:10:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8rvEMsKyQJ+gIF14zjTJ0VBycm1tLlvb9Fi2AQvxcIw7deQAd1I27kyWkq0ZOiMcEThd5tumYH8vB1D0U1VQ=
X-Received: by 2002:adf:f58c:0:b0:3a5:39d7:3f17 with SMTP id
 ffacd0b85a97d-3a539d73f90mr9783966f8f.47.1749571859026; Tue, 10 Jun 2025
 09:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250605101124.367270-1-pbonzini@redhat.com>
 <CAMxuvazN2OMc1VANJVMgj0nQ1KCCop46A151uAUe0mdATrQjCg@mail.gmail.com>
In-Reply-To: <CAMxuvazN2OMc1VANJVMgj0nQ1KCCop46A151uAUe0mdATrQjCg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 10 Jun 2025 18:10:47 +0200
X-Gm-Features: AX0GCFsdiMxgV9drCac9melcjaVIHtck4Y6vTQFlL7mrYgE6AYChETUHOZm5-z8
Message-ID: <CABgObfYt=Gg=R6cekCTbYhmF+2P-9DoOCSeaaWHHGbMmew2ZyQ@mail.gmail.com>
Subject: Re: [PATCH preview 0/3] reviving minimal QAPI generation from 2021
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, armbru@redhat.com, 
 mkletzan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jun 10, 2025 at 3:53=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> On Thu, Jun 5, 2025 at 2:11=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>> This is just an extremely minimal extraction from the patches at
>> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redha=
t.com/,
>> limited to generating structs and enums from the QAPI schema.
>> It does not include them in any crate and does not compile them.
>
> Do you keep an up to date branch for those patches?

I can add them to my rust-next branch but they can in theory just be
applied to upstream/master.

> I fail to understand the advantage of going through Serde to deserialize/=
serialize from C when you can have C types in Rust - having less generated =
code?

It's indeed trading generated Rust code for generic serializers and
deserializers + #[derive(Serializer, Deserializer)]. It's not the
primary reason but the size of your code generator patches was a bit
scary indeed and I don't want to inflict too much review effort on
QAPI maintainers.

But also, I'm not sure that the C types are needed at all for
implementing QAPI commands. The QAPI command generator could have a
directive like 'rust': 'qga::qmp'" directive (or maybe just
'language': 'rust', I don't know) that would generate Rust
marshaling/unmarshaling functions:

pub extern "C" fn qmp_guest_get_host_name(
        args: *mut QDict,
        ret: *mut *mut QObject,
        errp: *mut *mut bindings::Error) {
    let args =3D unsafe { from_qobject::<()>(args) };
    match ::qga::qmp::guest_get_host_name(args) {
        Ok(ref v) =3D> unsafe { *ret =3D to_qobject::<GuestHostName>(v); },
        Err(err) =3D> unsafe { err.propagate(errp); }
    }
}

and this (more specifically from_qobject/to_qobject) could also use
serde, this time to go directly from QObject to Rust and back. A
QObject serializer/deserializer should be easier to write (and very
similar to existing code in serde_json for
https://docs.rs/serde_json/latest/serde_json/enum.Value.html), so you
could reach the stage of your old posting with qapi-gen changes that
are little more than these two patches.

> I also do not fully understand how that would work.

To be honest neither do I entirely. But what I understood is that
Serde is based on a visitor API that is very similar to what we have
in QEMU. See the above serde_json link where it implements Serializer
and Deserializer, and the blog post at
https://ohadravid.github.io/posts/2025-05-serde-reflect/ should be a
good introduction too.

That said: the *possibility* of using Serde is why I started from the
native structs. I'm not wed to it and generating/converting the C
types remains a possibility as well.

Paolo


