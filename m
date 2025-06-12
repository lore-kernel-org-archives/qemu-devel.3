Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7A4C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 09:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPduu-000602-RN; Thu, 12 Jun 2025 05:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPdus-0005zX-06
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 05:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPduq-00014h-83
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 05:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749719287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zbcMrrIPcCkuUx3QPLQAk4IfNXL0oqnM7npn3lylVjw=;
 b=XRCTFXoMZEiZQMU+BlY881vpjpb9x3tFQZHUuq2UHga2vAdzxu0OS2sirjZNC0Ao5yrHys
 ppvOOT5i/mpxqfSl8wSxzy5xfmSC/DYMhE68AiggRPxTOip7lw/ijcYsWJUCXNj6Ee9HNA
 hetcMlMWF+Q7kbMIGPml9JBypReJ7As=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-rzv5tpQ4Nt-Gdj-ElT0E9w-1; Thu, 12 Jun 2025 05:08:05 -0400
X-MC-Unique: rzv5tpQ4Nt-Gdj-ElT0E9w-1
X-Mimecast-MFC-AGG-ID: rzv5tpQ4Nt-Gdj-ElT0E9w_1749719284
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1847so266776f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 02:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749719283; x=1750324083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbcMrrIPcCkuUx3QPLQAk4IfNXL0oqnM7npn3lylVjw=;
 b=Ic+tgbY4RjrQwi2K1dhFFBUbCw9KVxEQ4mUHQhrypbq6mSrWC7uZHQLXZvc7BLWQXE
 m4LCelxfTh8diZi9mn19S+cl9E95DB1pxjjmMUp0p7/E1NV9DqnCJKZprxUtQZ3s70Ux
 N81TF9OhEQPuhrhBD3hL13p/t+GIEtAJru1kxQqcenX8uHVPxGJEDT/JNXQwcwPdTcxh
 fHGRQQ7Zmpzk3kLD7/kR+95OWMSo2xTyTHpDXYNBNPHIln8XjujCP1O6QJAy46PDAKyT
 J4odrgtMbl/ORnxLunOmtX7sso6fkWPmgR+DZlrkbGqxTApD8+e/xQTwVHe6Vthsltcr
 RgQg==
X-Gm-Message-State: AOJu0YzxArM6kcfv7nzDYiP0ZZpmRmCWDtmQTEeTXHm+cOAA8NxpNJOL
 4JCE7J0tsh121GzNs5arlJ/Ucd+6/WZ9PonlW8a1t1nezQc7eRHgX57Nb1NiPH2+9trTUFM66tJ
 H/0WBCWGNrCJVZqaUkRFrnxu7N3uFGOggKOYnAoAUwJ/JPZl2bLYZBGKrTf6NJG0COFYE3XUESF
 L/YNsC/zIjvdWKw/+7PTYiha7CYA+KR4EQo+fsZ0LJyw==
X-Gm-Gg: ASbGncsUGy/w+2iIMxJ259QPtBhy5+TDzcJLdaaf1mk03EnPg4U5lK1nhgwKDHpIGT9
 7DwAESnFWWMWDqyWyMH50KtKcJgFrK8dndkd2p7NPqqALeqrvqIInriEDDnMVjVgmlrVwtqBS+8
 UyWh4=
X-Received: by 2002:a05:6000:1a8b:b0:3a4:f8e9:cee0 with SMTP id
 ffacd0b85a97d-3a5586dfe01mr5205014f8f.40.1749719283497; 
 Thu, 12 Jun 2025 02:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2fh/xY/0jl8G3zBet1JSkGC7kU+gMY+uEx0ZKa2UrXhIgqlXKsfP3G/VkOd+eUVzEMVDXUfge7qY2tc+yZX8=
X-Received: by 2002:a05:6000:1a8b:b0:3a4:f8e9:cee0 with SMTP id
 ffacd0b85a97d-3a5586dfe01mr5204980f8f.40.1749719283112; Thu, 12 Jun 2025
 02:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250609154423.706056-1-pbonzini@redhat.com>
 <20250609154423.706056-5-pbonzini@redhat.com>
 <aEqcGiGmZiMoIhY5@intel.com>
In-Reply-To: <aEqcGiGmZiMoIhY5@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Jun 2025 11:07:51 +0200
X-Gm-Features: AX0GCFv6QVVNJhmqAdTb5KqbCbq6FYLTVpEMbhlGyDhcwIdHbY6CTrrdmHvbqsU
Message-ID: <CABgObfb8CWy5zthqHRJrKqjP4xmBC=Zh3FrDjcK2Z6wsZJu-ew@mail.gmail.com>
Subject: Re: [PATCH 4/5] rust: qom: make ParentInit lifetime-invariant
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
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

On Thu, Jun 12, 2025 at 11:00=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
> > +/// It's impossible to escape the `Jail`; `token1` cannot be moved out=
 of the
> > +/// closure:
> > +///
> > +/// ```ignore
> > +/// let x =3D 42;
> > +/// let escape =3D Jail::with(&x, |token1| {
> > +///     println!("{}", token1.get());
> > +///     token1
>
> This line will fail to compile (the below comment "// fails to compile" s=
eems
> to indicate that println! will fail):
>
> error: lifetime may not live long enough
>   --> src/main.rs:22:9
>    |
> 20 |     let escape =3D Jail::with(x, |token1| {
>    |                                 ------- return type of closure is Ja=
il<'2, i32>
>    |                                 |
>    |                                 has type `Jail<'1, i32>`
> 21 |         println!("{}", token1.get());
> 22 |         token1
>    |         ^^^^^^ returning this value requires that `'1` must outlive =
`'2`

Right, I put it there because '2 lives until the second println!. The
problem is not so much that it's returning token1, it's that the
println uses it.

I can see that it's confusing, maybe:

    // Because "escape" is used after the closure has returned, the
    // compiler cannot find a type for the "let escape" assignment.

Paolo


