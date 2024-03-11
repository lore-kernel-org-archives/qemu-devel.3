Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E52FC54E60
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 13:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjfiI-0004uC-Js; Mon, 11 Mar 2024 09:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rjfi3-0004tG-7c
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rjfi0-0005u6-TU
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710163731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrOWhWrfjQsd9LIq/h6+YYfsw9AMsXC8hG+IAKQuQIE=;
 b=H125Q1AuY7yEQAIgQ+9hVeccuSU17EmSwWFZWQQEWjj7qr3UOw1uTx9ja5vFSD697mMK/Q
 nuS+p4iKb4J1jyFe23jZb+jfo/nWqmUOcCu6We3VKsQDZKqE6avLTidpHx3I82XrgvDbDo
 3i3YKP5uRAZxch2LoDy0xr4eKhZevSc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-2gR3eWwMM9uYIGEzliTf3w-1; Mon, 11 Mar 2024 09:28:50 -0400
X-MC-Unique: 2gR3eWwMM9uYIGEzliTf3w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40d62d3ae0cso15561645e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 06:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710163728; x=1710768528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrOWhWrfjQsd9LIq/h6+YYfsw9AMsXC8hG+IAKQuQIE=;
 b=RwNr67buI6rsaAXSUip+cl2uMptrh0nvQf5Ozo+zyJqOolfV6P7iA2ovjvZlt5fL8n
 4HyEigWEVjZookE+J6I72IHKn9UmUyr55zhqtH2oOJy/+2pCA1H7L5H0x4wO8+XyOS/m
 qzC/Y0Z1C6ZkAnzgJPZrm8DCaKp3Rry7ER7We8dI8DIqRbkFLh7Op5LY4hw/XzSNXhQo
 cv3E4NLcmX+P8etAFpEP3pZN/UCqBsbb1WsKnYph85PRG147wesDy8AZMGiFJRo7Xiq1
 NAYfDLTQrSckXaZNJXgP5EOO2C5TP6iJ+46UUuwqOk6hnCUJ4SD50+Bl59ph+YMVahyF
 Tfbg==
X-Gm-Message-State: AOJu0YyUmqBEgFuiGbgFfC/E8XDi5KRBRPSxt3U/7OHhT3y+f+ZfznWf
 F8wAFdLEn0ZIVI82U+nlMH5qESyNoRgf+UqCqfudkZ+MgIrSEJWAa+22g/SDyGT8KIhIaySKS3B
 NdjZ2aQC2yyaYeQc8HznSsrlbBX/1JtaPBm4xbRgU2ktKbAFzdfabszEIebgbELAYVHJcJoMriG
 KJ6HGmJYy7YE8SLaDS6i0f95eSUss=
X-Received: by 2002:a05:600c:3485:b0:413:3048:5d68 with SMTP id
 a5-20020a05600c348500b0041330485d68mr241836wmq.20.1710163728707; 
 Mon, 11 Mar 2024 06:28:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTLUOWctNYlGT0yb+cuRyEHrP6pdKm4kmz16/UzCYq1uXQ3daClVE4+eQOzP7/z42bb3U2sPAq36/tvK3pe3E=
X-Received: by 2002:a05:600c:3485:b0:413:3048:5d68 with SMTP id
 a5-20020a05600c348500b0041330485d68mr241825wmq.20.1710163728423; Mon, 11 Mar
 2024 06:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240305105233.617131-1-kraxel@redhat.com>
 <20240305105233.617131-3-kraxel@redhat.com>
 <CABgObfZ13WEHaGNzjy0GVE2EAZ=MHOSNHS_1iTOuBduOt5q_3g@mail.gmail.com>
 <q6zckxcxwke2kdlootdq3s7m2ctcy7juuv3fsezhpw3nqyewxo@sqku62f25gdc>
In-Reply-To: <q6zckxcxwke2kdlootdq3s7m2ctcy7juuv3fsezhpw3nqyewxo@sqku62f25gdc>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Mar 2024 14:28:35 +0100
Message-ID: <CABgObfZtUKcNH8HF2Sey29c7kfm9HPreyMxzVwtbPHaWYiJcFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kvm: add support for guest physical bits
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <thomas.lendacky@amd.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 11, 2024 at 12:59=E2=80=AFPM Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>
>   Hi,
>
> > > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > > index 952174bb6f52..d427218827f6 100644
> > > --- a/target/i386/cpu.h
> > > +++ b/target/i386/cpu.h
> > > +    guest_phys_bits =3D kvm_get_guest_phys_bits(cs->kvm_state);
> > > +    if (guest_phys_bits &&
> > > +        (cpu->guest_phys_bits =3D=3D 0 ||
> > > +         cpu->guest_phys_bits > guest_phys_bits)) {
> > > +        cpu->guest_phys_bits =3D guest_phys_bits;
> > > +    }
> >
> > Like Xiaoyao mentioned, the right place for this is kvm_cpu_realizefn,
> > after host_cpu_realizefn returns. It should also be conditional on
> > cpu->host_phys_bits.
>
> Ok.
>
> > It also makes sense to:
> >
> > - make kvm_get_guest_phys_bits() return bits 7:0 if bits 23:16 are zero
> >
> > - here, set cpu->guest_phys_bits only if it is not equal to
> > cpu->phys_bits (this undoes the previous suggestion, but I think it's
> > cleaner)
>
> Not sure about that.
>
> I think it would be good to have a backward compatibility story.
> Currently neither the kernel nor qemu set guest_phys_bits.  So if the
> firmware finds guest_phys_bits =3D=3D 0 it does not know whenever ...
>
>   (a) kernel or qemu being too old, or
>   (b) no restrictions apply, it is safe to go with phys_bits.
>
> One easy option would be to always let qemu pass through guest_phys_bits
> from the kernel, even in case it is equal to phys_bits.

Ah, I see - you would like to be able to use all 52 bits (instead of
going for a safer 46 or 48) and therefore you need to have nonzero
guest_phys_bits even if it's equal to phys_bits. While on an old
kernel, you would pass forward 0.

> > - add a property in x86_cpu_properties[] to allow configuration with TC=
G.
>
> Was thinking about configuration too.  Not sure it is a good idea to
> add yet another phys-bits config option to the mix of options we already
> have ...

I think it's nice that you can use TCG to test various cases, which
requires a new property.

> In case host_phys_bits=3Dtrue qemu could simply use
> min(kernel guest-phys-bits,host-phys-bits-limit)

Yes, that works.

Paolo

> For the host_phys_bits=3Dfalse case it would probably be best to just
> not set guest_phys_bits.


