Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE9DC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 12:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHMri-0006u4-Oz; Wed, 12 Jun 2024 08:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHMrg-0006tv-RN
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHMrf-0007rd-1F
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 08:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718194445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=civCiIVtWJ89cSun1LN3fEoRWRuJy7HKEyov2X0fK6c=;
 b=H2KNm3dQEjSYA20itZ5+KutVKOyXmKmkIt/uSv0utjB4HoSrt52JvdRORthfbESMkSV8XE
 H8W3frPUV5KWxL8VRGNx2emnZqmTDKKYA7xJHRlPai4Qu5RhFZsIlo9I9GcBlkKk4jGl6t
 PWQwtNp2eEtXuFXDz5zJs5SrnO+2p1U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-JZOkIUzKNsGEJQAr2AC6-A-1; Wed, 12 Jun 2024 08:14:04 -0400
X-MC-Unique: JZOkIUzKNsGEJQAr2AC6-A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35f1f29ccefso2589510f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 05:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718194443; x=1718799243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=civCiIVtWJ89cSun1LN3fEoRWRuJy7HKEyov2X0fK6c=;
 b=leawgaaidMG2U1AvZp6LWhyBduIuqfQQIZ86IqWCM4p0BGbsdxpZTfYsKm1hO6Ltvg
 13xvlAFeed1PbpXswQfH+one7FKeNtmUmokcvGZVmk7JXiR/NBasr9FQWegYnZD3nA1f
 fE2IewkFa7iD4LziCTjalXFCdevMGXVdW36ph6Gw/1o4b9AdN/01q1xSD4pugEvIOQfG
 Z2SU5y8UJBTcs+/RpjsyIoj87swcQ18VIsQ0MgIN7sCnVN9nv4Kwpw6jh4wBS+OYCzky
 HE7FExb3xI3nXYufr/IkkaGtQilbCTOINgb5tE0wZd2TnPdkidEYFEiCcplKVfvwzARb
 nBUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM9KAQ12e8NEiUP0cRlGt6uM85RYrtmdoIjLJ+zE2US/5OfJnG9BwX/Z4BkdjkSPJXAMc7XWptSEOuZUSNFNOIDgG57sM=
X-Gm-Message-State: AOJu0YwUrUuAXwS2HKQhMccCLsdFVhkLnc+fSiN/u+4qDZ1sinNbwGvy
 PRu3DgRK/Uu1cuemRaa+zIjikdh/RU0zBqW+mVS5EWGLZNS41X5TmyfuYUmkNmV76OQt8jIsutJ
 4mipn7SutEPxdAqjH7V7X94aj0RpaB314YUZmLtrPDu+mKWBYVNjzCKQ3DdPuXRpTAp2+KDWDoE
 vnCI/xWswB/x6yqUxho4SxSapE81o=
X-Received: by 2002:a05:6000:18e:b0:35f:3077:dd4c with SMTP id
 ffacd0b85a97d-35fe892a6cemr1038513f8f.62.1718194442928; 
 Wed, 12 Jun 2024 05:14:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx2L4QzIewPiLHk+earqnYDcVTEnwXh5DQPprbu1BmxXXQpB+0/7OpcN/C8fMNCrC4gqwsGHoGvvA3xFdZpm0=
X-Received: by 2002:a05:6000:18e:b0:35f:3077:dd4c with SMTP id
 ffacd0b85a97d-35fe892a6cemr1038500f8f.62.1718194442565; Wed, 12 Jun 2024
 05:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <e26ac8a0-5cb0-22a8-fbf9-54f198cdc7ed@ispras.ru>
 <CABgObfYf8=3yXu1p6q6jzyZ7uHy92BHaBXtJY8AMYXBdd9+HGA@mail.gmail.com>
 <caa7d068-a2c6-28a4-51d5-93c61f004bc0@ispras.ru>
 <CABgObfaswAJRffjdu9h8crD6jvFAP78CaDDbutvoa7EGxwuy1w@mail.gmail.com>
 <e292326a-0f71-3d4d-4ec1-562efe94271b@ispras.ru>
In-Reply-To: <e292326a-0f71-3d4d-4ec1-562efe94271b@ispras.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 14:13:50 +0200
Message-ID: <CABgObfZEmA6DrN-8f_nTg8DHfN+m7DO+DbabW1AtdtMtHjbgyQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
To: Alexander Monakov <amonakov@ispras.ru>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Wed, Jun 12, 2024 at 2:11=E2=80=AFPM Alexander Monakov <amonakov@ispras.=
ru> wrote:
>
>
> On Wed, 12 Jun 2024, Paolo Bonzini wrote:
>
> > Ahah, nice. :) I'm pretty sure that, when I tested "pf =3D
> > (__builtin_popcount(x) & 1) * 4;", it was generating a call to
> > __builtin_popcountsi2.
>
> Why write '__builtin_popcount(x) & 1' when you can write
> '__builtin_parity(x)' in the first place?

I don't remember. :) Anhow, probably I will add __builtin_parity() to
include/qemu/host-utils.h and some kind of #ifdef HAVE_FAST_CTPOP.
Thanks.

> > Still - for something that has a code generator, there _is_ a cost in
> > supporting old CPUs, so I'd rather avoid reverting this. The glibc bug
> > that you linked is very different not just because it affected 32-bit
> > installation media, but also because it was a bug rather than
> > intentional.
> >
> > Since you are reporting this issue, how did you find out / what broke f=
or you?
>
> I found out from the mailing list. My Core2-based desktop would be affect=
ed.

Do you run QEMU on it? With KVM or TCG?

Paolo


