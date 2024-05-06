Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42986C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 16:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s41Fg-000669-36; Mon, 06 May 2024 12:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s41Fd-00065A-5D
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s41Fb-0004sk-Cv
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715013098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dl8T0psyN5y4DEq2k1vlPEB8RdA1/fFpelNCBFpVVo0=;
 b=EE5OGPiWk+fhoOX0cyYw2e0NxZPbASusqpaEMe+/b+5SfLV5PtQggmT9b9/2Co5uNgcorv
 w0Vd5W4I373gASrswDKFALO35rs339P/WlVnZXZ0diRexa0cKLch6Sc8mhiPZM5W/rz7T/
 CrvwNdrJHe19z7ezDM+Xjq2si7GGAmI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-2bmZ7wpoPry9I5kJOnUl2A-1; Mon, 06 May 2024 12:31:36 -0400
X-MC-Unique: 2bmZ7wpoPry9I5kJOnUl2A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-417fb8195d7so8771255e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 09:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715013095; x=1715617895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dl8T0psyN5y4DEq2k1vlPEB8RdA1/fFpelNCBFpVVo0=;
 b=k2aVHtGRyxUuPGb5LUdtv2pAAXdBwv3zfOAvyYGxMdUgfCbpK4OD3nEkrVTsjh0u9M
 fKLR4Mdig+jOCiLZ8hxHIq9l2WvqNs725c2Ov7k3kSGVTSDWf+im5+55f1Z16T5x+xcs
 AovcTBnkdH945u5kmvykXvoWI0qmWqAw5YVKq2JBztfU/70tKLJ17fLZmT1GvjvwNwVU
 URYG2WOT3JJC/igW5e8jb6f3L7QqYtQIuHy/TqZTXjRdDipBzdXLh3jukChW5zw8zJVx
 IGDS9Eb3IH23rKygiEnQ7Ruz4d2OmJlHnQo1QPzOgHoXwx2u1ewugSa/Jw78J+mjKo5v
 MKcg==
X-Gm-Message-State: AOJu0YwBz5GQ4/qXzX/y4uDrksaJkA0tlCfa+79oG3sHgI4NCtxaFwH2
 dHX8XaoPP7L1R31rPx17YZCE1dij/aB25DxSDvobcLfGINtFYbtZ7VLnCFId++hQeT93D3gMQAy
 E8lyAnCs+V66of0BY6OHUV9vAft/F4p/n9/YtgsJHsT1gd6ufntld3V15XIPEQvoh2tHGbMhGHP
 OD2AiGPkT28Zfv6+EyLsck6oyK9n4=
X-Received: by 2002:a05:600c:1d01:b0:41b:f577:604 with SMTP id
 l1-20020a05600c1d0100b0041bf5770604mr7369097wms.30.1715013095367; 
 Mon, 06 May 2024 09:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjqJSPbLh413npQazq3MwaNOAcSkl2iBuBa2OHNWwOyfpBHc11BkD9Q2fIK4s+2FDjNilrjGIv7dfCKKg6YHs=
X-Received: by 2002:a05:600c:1d01:b0:41b:f577:604 with SMTP id
 l1-20020a05600c1d0100b0041bf5770604mr7369081wms.30.1715013095032; Mon, 06 May
 2024 09:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240506080957.10005-1-pbonzini@redhat.com>
 <20240506080957.10005-6-pbonzini@redhat.com>
 <e1019e1e-3678-4882-9cfb-f4747d80b9a3@linaro.org>
In-Reply-To: <e1019e1e-3678-4882-9cfb-f4747d80b9a3@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 6 May 2024 18:31:23 +0200
Message-ID: <CABgObfbDg99rNDQcBD2HZ3njkGmif2fQxRXFYqmwmGXXvXKa0A@mail.gmail.com>
Subject: Re: [PATCH v2 05/25] target/i386: cleanup cc_op changes for
 REP/REPZ/REPNZ
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Mon, May 6, 2024 at 6:08=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> > -    gen_update_cc_op(s);
> >       l2 =3D gen_jz_ecx_string(s);
> > +    /*
> > +     * Only one iteration is done at a time, so there is
> > +     * no control flow junction here and cc_op is never dynamic.
> > +     */
> >       fn(s, ot);
> >       gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
> > -    gen_update_cc_op(s);
> >       gen_jcc1(s, (JCC_Z << 1) | (nz ^ 1), l2);
> >       if (s->repz_opt) {
> >           gen_op_jz_ecx(s, l2);
>
> Ok, but only because gen_jcc1 does the gen_update_cc_op.  The comment is =
neither correct
> nor necessary.

Yeah, it's true that gen_jcc1 does the update. On the other hand,
there are two different kinds of cc_op updates:

1) at branches, if you know that only one of the sides might write
cc_op - so you ensure it's up-to-date before the branch - and set
CC_OP_DYNAMIC at the junction. Same if you have movcond instead of a
branch.

2) at end of translation block, to spill the value lazily (because in
the middle of the TB we are able to restore it from insn data). With
these patches there is never a need to do this, because gen_jmp_rel()
and gen_jmp_rel_csize() take care of it.

The comment deals with the former, the removal with the latter.

The idea of the comment is that after SCAS/CMPS you have CC_OP_SUB*,
so in principle you may expect that you need to set CC_OP_DYNAMIC
explicitly at the end of a REPZ/REPNZ, which is where the CX !=3D 0 and
CX =3D=3D 0 paths join. But this is not necessary, because there is
nothing after that instruction - the translation block ends.

So I guess the comment could instead be placed at the end of the function?

    /*
     * Only one iteration is done at a time, so the translation
     * block has ended unconditionally at this point and there
     * is no control flow junction - no need to set CC_OP_DYNAMIC.
     */

What do you think?

Paolo


