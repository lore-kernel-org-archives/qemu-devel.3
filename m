Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FABAC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 01:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvp6B-0008Jb-2c; Sat, 13 Apr 2024 21:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1rvp69-0008JP-4A
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 21:56:01 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1rvp67-0000Yp-DE
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 21:56:00 -0400
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-69629b4ae2bso19118666d6.3
 for <qemu-devel@nongnu.org>; Sat, 13 Apr 2024 18:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713059757; x=1713664557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jrk0f0iP1dx5RG/G/6V3NzGgGIEWCznULEOUL80m2iA=;
 b=qKL4MwrJPm2iylr0i8HJxQz5b3R9LCqHgtvoJvKsYA1yIbtIQ8Y8gFu9TfkRPK0MBT
 0UoBQGg7RHlT58oDsux2s0/dtuSq78M5Ktx1/EyREF4gFFN7Gx91DDhqYZNxdWhiNewn
 PjKeA6YiKVQgE+6IfG1c50y3Te1IeDjbqr1tO0B8SH71kBK2w3n2L/3VGiwpFn7E+SbI
 y3a4EZFfEXjhUH1wZaeVHPa+j3tditHR86+Vr13QkwS0TL3lb1/uOGaLFmoLIvpK1uzL
 8d9P9ILjiBDfwWIRrA8qR9xap7C+YPBn1ckLPv+O3libSIfpuIaJhAxF2O850G8rj3AT
 VTUA==
X-Gm-Message-State: AOJu0YxTj07060TB0SWYEk2jwKhfzyYE+GVh4lA7bcQq+MTWj2/Q81yA
 4kjQONYkpDk1QyDV5ufTXk0nMvniReAWFsM0SbXY5UlHcrDzXm/+G53AdA==
X-Google-Smtp-Source: AGHT+IEcyJD8P1miknYoGoD3AlnQ5y2NARIs5ArTE9oY5YJhK/LvFzGU2DXkh0sFH8BbyccYZCFuKA==
X-Received: by 2002:ad4:5a07:0:b0:69b:23eb:3d3a with SMTP id
 ei7-20020ad45a07000000b0069b23eb3d3amr6128015qvb.35.1713059757012; 
 Sat, 13 Apr 2024 18:55:57 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com.
 [209.85.219.44]) by smtp.gmail.com with ESMTPSA id
 a5-20020a0562140c2500b0069b5150712csm3754277qvd.56.2024.04.13.18.55.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Apr 2024 18:55:56 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-69b4043b7b3so10317196d6.1
 for <qemu-devel@nongnu.org>; Sat, 13 Apr 2024 18:55:56 -0700 (PDT)
X-Received: by 2002:ad4:5290:0:b0:69b:54f2:a811 with SMTP id
 v16-20020ad45290000000b0069b54f2a811mr6218432qvr.16.1713059756421; Sat, 13
 Apr 2024 18:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240411212936.945-1-bazz@bazz1.com>
 <dfa87b87-8685-46ea-ae5d-3735124fc76a@linaro.org>
 <CAMFqb-anRmzo1HP8Gn2y0eD98+ZsG_a54c_fLMaMc=0AGAz7DA@mail.gmail.com>
 <48ec5cfe-e584-4e84-85d8-856bfd46345a@linaro.org>
In-Reply-To: <48ec5cfe-e584-4e84-85d8-856bfd46345a@linaro.org>
From: M Bazz <bazz@bazz1.com>
Date: Sat, 13 Apr 2024 21:54:17 -0400
X-Gmail-Original-Message-ID: <CAMFqb-Y5mRrVk7dmEjt=EWerFu3qKAVjxE74=X6yfrRJJnqF5g@mail.gmail.com>
Message-ID: <CAMFqb-Y5mRrVk7dmEjt=EWerFu3qKAVjxE74=X6yfrRJJnqF5g@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: resolve ASI_USERTXT correctly
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.219.51; envelope-from=bazz1tv2@gmail.com;
 helo=mail-qv1-f51.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Richard,

On Thu, Apr 11, 2024 at 10:16=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/11/24 18:15, M Bazz wrote:
> > diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> > index e581bb42ac..4f87e44a93 100644
> > --- a/target/sparc/ldst_helper.c
> > +++ b/target/sparc/ldst_helper.c
> > @@ -684,6 +684,7 @@ uint64_t helper_ld_asi(CPUSPARCState *env,
> > target_ulong addr,
> >       case ASI_M_DIAGS:   /* Turbosparc DTLB Diagnostic */
> >       case ASI_M_IODIAG:  /* Turbosparc IOTLB Diagnostic */
> >           break;
> > +    case ASI_USERTXT: /* User code access */
> >       case ASI_KERNELTXT: /* Supervisor code access */
> >           oi =3D make_memop_idx(memop, cpu_mmu_index(env_cpu(env), true=
));
>
> No, this also does not work, because it uses the wrong permissions (kerne=
l instead of
> user).  I have just sent a patch to fix both problems.

This thought just came to me. `lda` is a privileged instruction. It has to
run in supervisor mode. So, I'm struggling to understand how the
kernel permission
was wrong. Isn't that the right permission for this instruction?

I just want to have the right understanding, so that I'm more prepared
for the next time.

Here is a related excerpt from the Sparcv8 manual:
"For each instruction access and each normal data access, the IU
appends to the 32-bit
memory address an 8-bit address space identifier, or ASI. The ASI
encodes whether the
processor is in supervisor or user mode, and whether the access is an
instruction or data access.
There are also privileged load/store alternate instructions (see
below) that can provide an arbitrary
ASI with their data addresses."

Thank you,
-bazz

>
>
> r~

