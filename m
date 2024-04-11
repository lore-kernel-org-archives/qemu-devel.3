Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6455ACD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 11:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rusSC-0004o0-2p; Thu, 11 Apr 2024 07:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rusSA-0004nV-79
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 07:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rusS8-000347-8a
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 07:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712834325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lFyUkLCsRZiSHhop7oonRnJbtUC8hFA16mhDHqnzE4w=;
 b=KzINvtcDkD3ew/7b0hToaEM0Xw4OCyKxspRk/smvKMDFDvV3CprHbug8gfFPhgtS3nz3Kw
 Gm+P3rEZ+FZhDEeNv2vQ9yxqj8JQrbdrcYq/bQzFtC4cHkiLNHG4M25yG3gSxxU4nlPf6K
 +BDsfJ692S8Wv/OzaktrGzKvgwdZ5yg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-7rgvHZ2zO--k-EgtWpqv7w-1; Thu, 11 Apr 2024 07:18:43 -0400
X-MC-Unique: 7rgvHZ2zO--k-EgtWpqv7w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343eb273904so3269953f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 04:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712834322; x=1713439122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lFyUkLCsRZiSHhop7oonRnJbtUC8hFA16mhDHqnzE4w=;
 b=MwDrK9OG96/zzOGAzrVFBwcoRh5AWf+TLsdE499+Z1/Ty5LGNLM29AWLqmHGqCHbk0
 2ewA4Yadk/OJaXreE8BbwMblYXNLw1dTq6kWJPMejgLDjA5sXUPqfbzDAxGzAvx6Wdxl
 mwY/FAO0zHG8XOsp7Uv+X2LEzGsO1xVvmp5N72Ka0FZ9YaQYS3qWweMHHyeSIKqDLdRp
 6NeprHoTqrPwaE+rHtXyaMVSTLoIML0tSNLHGRGMEMJwOSXyVF/dxbYHnMTwcnmgHVep
 qFfOtAGSc4Y4Am0lBY3VcledjIyB07L9Qw9aYQ9ocBzx7Ha9KjlyLijDAZsGjILTq7ub
 l1Tw==
X-Gm-Message-State: AOJu0Yzm+2wTdv6XJo/ELQBbB1B3JJ60gxKUdS3qdSjI5VYBFzwKLBvi
 zXWsb1UBi7eUy8+VSS1gMg7o7OqGCbrZI4cf7cCVbUNaE3QWQm8lr9TJmthbaLksX5UV8E5l8ZZ
 qKA/dOAvMRgDPWZbvpEbbe/RNHwbPHvedXdfMBa3JZTAkM/dhbirB4e+mv+YCYfM+o35tGEV2ox
 iQ6zu5NR7X8ccPWAz5zzsHMjMQoK8jtnELrjQMRg==
X-Received: by 2002:a05:6000:acf:b0:343:7a0c:62ff with SMTP id
 di15-20020a0560000acf00b003437a0c62ffmr3765741wrb.61.1712834321849; 
 Thu, 11 Apr 2024 04:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEDOU0k6AVuXVD6U/SbsJUR6fkNptaqz1z5BOYwfC44ABCtHalY3n6q4m6xDpCV607kvHrIjK1+pUsxo5F+uk=
X-Received: by 2002:a05:6000:acf:b0:343:7a0c:62ff with SMTP id
 di15-20020a0560000acf00b003437a0c62ffmr3765731wrb.61.1712834321552; Thu, 11
 Apr 2024 04:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-10-pbonzini@redhat.com>
 <f211d5d7-9d0f-455a-97c5-d2c09d600bcb@linaro.org>
In-Reply-To: <f211d5d7-9d0f-455a-97c5-d2c09d600bcb@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 11 Apr 2024 13:18:29 +0200
Message-ID: <CABgObfaNq5uWcan1cRsLRHxpe=f8Db3gg0yWC202cZYLjKLAuA@mail.gmail.com>
Subject: Re: [PATCH for-9.1 09/19] target/i386: move 60-BF opcodes to new
 decoder
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
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

On Thu, Apr 11, 2024 at 9:47=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
> > +    case MO_32:
> > +#ifdef TARGET_X86_64
> > +        /*
> > +         * This could also use the same algorithm as MO_16.  It produc=
es fewer
> > +         * TCG ops and better code if flags are needed, but it require=
s a 64-bit
> > +         * multiply even if they are not (and thus the high part of th=
e multiply
> > +         * is dead).
> > +         */
>
> Is 64-bit multiply ever slower these days?
> My intuition says "slow" multiply is at least a decade out of date.

I was thinking more about TCG_TARGET_REG_BITS =3D=3D 32.

> > +        tcg_gen_negsetcondi_i32(TCG_COND_LT, s->tmp2_i32, s->tmp2_i32,=
 0);
>
> This seems like something the optimizer should handle, but doesn't.

I wanted to avoid using TARGET_LONG_BITS - 1, but it's not a problem
to use extract. I've changed it.

At least the ppc and x86 backends do support it and convert it to SAR,
so I didn't notice in my test that it was the backend doing it and not
the optimizer!

Paolo


