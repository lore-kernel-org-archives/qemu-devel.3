Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2AAC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 07:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8xIL-0001XN-Fq; Mon, 20 May 2024 03:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8xI9-0001Ww-PB; Mon, 20 May 2024 03:18:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8xI3-0004yB-Dj; Mon, 20 May 2024 03:18:40 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f457853950so1288557b3a.0; 
 Mon, 20 May 2024 00:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716189512; x=1716794312; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+s4UVcCidt4yDvvgXa0MkAYqlDeRqzByjMEbbQ/j4U=;
 b=TbpWAiW111Q7Xfo9MyilmFZc/iMlP1VV9DKvIwbN5/E8/wSohU5jqODnb3Uu+pti9L
 0CHNDSOD4vHCbBtXHr6keg+w0emzS/yVwaldbwguI4RghZcBI7QWwrREa+/hmjKKM4wO
 f11WNJ6kgdlxbmPPbFo4kMPxI3JvwSTS3eClRc3HE3d6mO5F2VPzjICRqN+ONRb6lhSq
 14AYjVg/8cIpCicy5S4e+3L518kHLmHsXc8ewAiC/FGcRO/Z9GjqAgDIrHPtrKqgKHGC
 5GqKY/LnWewcx7Qwbax36cDxsshFGj1mG5NZOyMAp/eJ/vjBlSpssk3Nn5gPjXSHL/XN
 I3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716189512; x=1716794312;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7+s4UVcCidt4yDvvgXa0MkAYqlDeRqzByjMEbbQ/j4U=;
 b=S9n7fS/m2GDMr/mJ59pgPEr57DMBGD86GksGSloAnRU8eIH9CH9p9TYhjegnxdrqCs
 /r0wo4FgyL7fN98duI682kno2PnPQf57DV4zP/4hikVxeD23QyIBHMugqtesOFrmKqEG
 tjaBSx89M25mDqq+9UNsUnoYA9oxAngeDEt555fwOlE+s9qwXD+kdbc3zRNBscBEgtra
 hjxG9fiQ/ajTkxzRZdfjqSdOJthiItRipC8BVl89Vpq7QhHH7SQ/FF2lWzlJQ59HGfaz
 Gbjjt4wq3dHWRx+FTqWxDwFAtZdO0MNtjQUG7O+q0PrquWlku9DgJqcQ/dDQv1Drlp+Y
 oRWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXndnqgY2ZV5TmDYgCwjZ+zaKpTwCvDMQSRDOgVkB2eiFauCcXjzDeZLh57Ypt3uRUalBY0fm0gswV/UdEXCxhhufw1
X-Gm-Message-State: AOJu0Ywtdm6HJ8wysYoNSNJckVw4tX1NJV0+v64grzmQW/MAA4N6Jj5o
 YD921BCE4y4QicVPs+MrAzQivlFODlIM9nsalJ4unqG5Otxl8Ops
X-Google-Smtp-Source: AGHT+IGRJjy+X6CjGh3eAD4nIgGaC4hSvmk9Mlg+ljlcs7iZP8pAzyRZ/xzrvi7h17MHhoOmmB+/9g==
X-Received: by 2002:a05:6a20:3c91:b0:1af:f88d:9efe with SMTP id
 adf61e73a8af0-1b1ca3ada42mr7805231637.3.1716189511824; 
 Mon, 20 May 2024 00:18:31 -0700 (PDT)
Received: from localhost ([1.146.114.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a6669dsm18526072b3a.31.2024.05.20.00.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 00:18:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 May 2024 17:18:25 +1000
Message-Id: <D1EAEMSLTZZO.19107537679QR@gmail.com>
Cc: <qemu-devel@nongnu.org>, <danielhb413@gmail.com>, <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 6/8] target/ppc: Move div/mod fixed-point insns (64
 bits operands) to decodetree.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, "Chinmay Rath"
 <rathc@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240423063234.76282-1-rathc@linux.ibm.com>
 <20240423063234.76282-7-rathc@linux.ibm.com>
 <D1BXJXYYCCJF.1KUFFHK83W8CV@gmail.com>
 <eba18599-1e0a-4b57-a728-b5a7847e4f14@linaro.org>
In-Reply-To: <eba18599-1e0a-4b57-a728-b5a7847e4f14@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sat May 18, 2024 at 8:48 PM AEST, Richard Henderson wrote:
> On 5/17/24 14:48, Nicholas Piggin wrote:
> > On Tue Apr 23, 2024 at 4:32 PM AEST, Chinmay Rath wrote:
> >> Moving the below instructions to decodetree specification :
> >>
> >> 	divd[u, e, eu][o][.]	: XO-form
> >> 	mod{sd, ud}		: X-form
> >>
> >> With this patch, all the fixed-point arithmetic instructions have been
> >> moved to decodetree.
> >> The changes were verified by validating that the tcg ops generated by =
those
> >> instructions remain the same, which were captured using the '-d in_asm=
,op' flag.
> >> Also, remaned do_divwe method in fixedpoint-impl.c.inc to do_dive beca=
use it is
> >> now used to divide doubleword operands as well, and not just words.
> >>
> >> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >=20
> > [...]
> >=20
> >> +static bool do_divd(DisasContext *ctx, arg_XO *a, bool sign)
> >> +{
> >> +    gen_op_arith_divd(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a-=
>rb],
> >> +                      sign, a->oe, a->rc);
> >> +    return true;
> >> +}
> >> +
> >> +static bool do_modd(DisasContext *ctx, arg_X *a, bool sign)
> >> +{
> >> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
> >> +    gen_op_arith_modd(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a-=
>rb],
> >> +                      sign);
> >> +    return true;
> >> +}
> >> +
> >> +TRANS64(DIVD, do_divd, true);
> >> +TRANS64(DIVDU, do_divd, false);
> >> +TRANS64(DIVDE, do_dive, gen_helper_DIVDE);
> >> +TRANS64(DIVDEU, do_dive, gen_helper_DIVDEU);
> >> +
> >> +TRANS64(MODSD, do_modd, true);
> >> +TRANS64(MODUD, do_modd, false);
> >=20
> > Sigh. I'm having to fix a bunch of these for 32-bit builds. Just
> > doing the #ifdef TARGET_PPC64 ... #else qemu_build_not_reached();
> > thing.
> >=20
> > Which is quite ugly and actually prevents using some of these
> > macros and requires open coding (e.g., because DIVDE helper is
> > not declared for 32-bit in this case).
>
> Compare sparc:
>
> # define gen_helper_pdist     ({ qemu_build_not_reached(); NULL; })
>
> etc.

That would help indeed.

>
> > Maybe we should move 64-bit only instructions into their own
> > .decode file and not build them for 32-bit, so we don't have
> > to add all these dummy translate functions for them.
>
> That's another option, yes.  The decodetree script will take multiple inp=
ut files to=20
> produce one output, so you could separate the insns by base vs 64-bit.

Thinking about it a bit more, I guess the downside is that you
would usually like to group instruction variants that operate on
64-bit data together with the others in the .decode file.

Thanks,
Nick

