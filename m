Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FB4C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 05:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkHAg-000899-Ml; Wed, 13 Mar 2024 01:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rkHAJ-00084c-9Y; Wed, 13 Mar 2024 01:28:36 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rkHAH-0001a1-Ri; Wed, 13 Mar 2024 01:28:35 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e6ade6a66aso611946b3a.3; 
 Tue, 12 Mar 2024 22:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710307712; x=1710912512; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/K1la7pgEEWHnPcVxOwQq76xApyBNCBJbxaNlbx+ao=;
 b=fby6N/c7C0FgF4a8rfpkEsNJPELypGnN9CVa6Hdox8leWlaUFiKZAaFecI/8fnROzP
 GGuIOQqwU4ckW+4LFTrAo6bejBDJmwkgEvGkkBW97qHg+VkuVJX7L2sPoDwhw6m58ELp
 xR87ltxudZmD3YbPFdmu8WaeZF3sB48gaPD/WpEK5/Ed2y8aLg9OFMM0Qi9A9BYavZbx
 VUXp5Hs2LAfAEQFYogG1NE3ZFeCeLOyFO0btipROY91rtGLwkdZBibJ9rieGYuu0Z4Bs
 Jt0eH1suOU9Th8TzEAMhCeN6M/ixghNkFEoQb+pFDdfAQsip1ONutK8QDHteKQwIDpeb
 MW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710307712; x=1710912512;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3/K1la7pgEEWHnPcVxOwQq76xApyBNCBJbxaNlbx+ao=;
 b=EQ5Xh6i2DRFpsOy45FjvNzlFE58QtMjHPj5V1nM7tUMet3bgCmIJhsRQyHpauhrSFu
 ujxDIojPCXvh033obo39m+3SuW9uDNCuI6r+x7r0O/9FmzW57aCkPYvYCZWt6ktZWwEK
 +lEUFtpM3xO8FIhKtWUEZPVT3veqrD0OYgORFzdZ5mxd2+6TnutZj8jPEm6eTuk6UTQM
 oOddbKE8DneGFPUUyZsgpz8cTqlXK/EjHG/syIk5birNRSKObJj72yK5hwQ+ctOr5YL+
 IKA1nEnMdsulrZxZ/5T2OG98515Vax+D/UQ660Dnwrxt1FeXcGgb6YThItA9+WpTnF6a
 IRMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXel97pFSCVWlKe/QxVYhvBmayWcZ4xh/IC8XRdWA3m/GUlvkZFSXCEXM3MkRVTEIOCbfHbfvMozmnCbr7XA0OM1StjHitrDuj/QmbXRgvvunykHp9ho7b3Ktc=
X-Gm-Message-State: AOJu0YzlCBhsVMYIPIuJfoRf6/Q1aikJhne51keO3xDV3giIa9T4j0u4
 hyVQxw74j1+VUOnddgL61yUl5KdWHO6UNNdeiJyla/1nEAKstD78
X-Google-Smtp-Source: AGHT+IEN0rb6inaz/lUO9do9s2GeOscju0nNUUQt/GHR+1YTexZ2UX77NmrHYZpgYVnQwKWwPUz+Jg==
X-Received: by 2002:a05:6a00:2e96:b0:6e5:80a4:2ff2 with SMTP id
 fd22-20020a056a002e9600b006e580a42ff2mr1582717pfb.30.1710307712082; 
 Tue, 12 Mar 2024 22:28:32 -0700 (PDT)
Received: from localhost ([1.146.20.17]) by smtp.gmail.com with ESMTPSA id
 c4-20020a62f844000000b006e6be504b0bsm131952pfm.168.2024.03.12.22.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 22:28:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 15:28:24 +1000
Message-Id: <CZSDHCIGS20N.2X51Z0GLK9O7S@wheely>
Cc: "Richard Henderson" <richard.henderson@linaro.org>, "Chinmay Rath"
 <rathc@linux.ibm.com>, <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>,
 <danielhb413@gmail.com>, <clg@kaod.org>, <harshpb@linux.ibm.com>,
 <sbhat@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: Move floating-point arithmetic instructions
 to decodetree.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Peter Maydell" <peter.maydell@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240307110318.170319-1-rathc@linux.ibm.com>
 <CZRO4Y67CBPV.2IAKB80EFDKEY@wheely>
 <0c7c6be1-12fb-4267-9d41-bd51637d104a@linaro.org>
 <CZRU903MDUJ1.6S9RSO5A4RDG@wheely>
 <CAFEAcA8im7S-bsx-hYqgUy4tsc8yXjWQf7Sb-=KnuREyqqC8mw@mail.gmail.com>
In-Reply-To: <CAFEAcA8im7S-bsx-hYqgUy4tsc8yXjWQf7Sb-=KnuREyqqC8mw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Mar 13, 2024 at 12:29 AM AEST, Peter Maydell wrote:
> On Tue, 12 Mar 2024 at 14:25, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Wed Mar 13, 2024 at 12:01 AM AEST, Richard Henderson wrote:
> > > On 3/11/24 23:36, Nicholas Piggin wrote:
> >
> > [snip]
> >
> > > >
> > > > #define FPU_HELPER(name, op, flags_handler)                        =
   \
> > > > float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)=
   \
> > > > {                                                                  =
   \
> > > >      float64 ret =3D op(arg1, arg2, &env->fp_status);              =
      \
> > > >      int flags =3D get_float_exception_flags(&env->fp_status);     =
      \
> > > >      flags_handler(env, flags)                                     =
    \
> > > >      return ret;                                                   =
    \
> > > > }
> > > >
> > > > static inline void addsub_flags_handler(CPUPPCState *env, int flags=
)
> > > > {
> > > >      if (unlikely(flags & float_flag_invalid)) {
> > > >          float_invalid_op_addsub(env, flags, 1, GETPC());
> > > >      }
> > > > }
> > > >
> > > > static inline void mul_flags_handler(CPUPPCState *env, int flags)
> > > > {
> > > >      if (unlikely(flags & float_flag_invalid)) {
> > > >          float_invalid_op_mul(env, flags, 1, GETPC());
> > > >      }
> > > > }
> > > >
> > > > static inline void div_flags_handler(CPUPPCState *env, int flags)
> > > > {
> > > >      if (unlikely(flags & float_flag_invalid)) {
> > > >          float_invalid_op_div(env, flags, 1, GETPC());
> > > >      }
> > > >      if (unlikely(flags & float_flag_divbyzero)) {
> > > >          float_zero_divide_excp(env, GETPC());
> > > >      }
> > > > }
> > >
> > > Beware -- GETPC() may only be called from the outermost helper.
> >
> > Ah, because it's using __builtin_return_address. Good to know.
> > Using always_inline and a comment should do the trick then.
>
> The standard way to fix this is that you call GETPC() at the
> outermost helper and then pass that value around as an extra
> uintptr_t ra argument to called functions that need it.

Oh that makes sense, thanks for the tip.

Thanks,
Nick

