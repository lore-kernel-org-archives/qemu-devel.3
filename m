Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82299C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 10:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzSr-0001f7-D2; Tue, 12 Mar 2024 06:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjzSi-0001Nj-7z; Tue, 12 Mar 2024 06:34:24 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjzSg-0006SJ-Mc; Tue, 12 Mar 2024 06:34:24 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6e6ac00616cso189603b3a.0; 
 Tue, 12 Mar 2024 03:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710239660; x=1710844460; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnW7HBG4kdGoNPo5hIfOwERnxGFPx9GHJSqXIeViXjY=;
 b=myeqFmlVbUGGNZ5UyO787dt5hMmSA/ZJEzSxiazF0C+kxQ59hlcSattRvyEhsODhD+
 CjB3omFFxBX+waQ5fruQK0wFYZ7MF7zPhoztmaAZQ11CvwNA6Yo6rXLYNp/+8mgdl3HX
 88dJWpK2RpE03j1mKgzhYIcVI7whuTNVayFWV1DcOFoWGL3swq+wbt1lGCaiPrlE/kyY
 FI4DDNrOlTWe3bZH9gpWnKZzVulA094KxWMHInG9OzzWaPposO0ZUSOMQk4a4LrcWsHJ
 x71U2XE/iut0yFJGKgyyA1ECkxLY4Tp4yJJlDB7hxjZ+AzSQ9jP3Y39NSZx5L/f5iWW7
 1sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710239660; x=1710844460;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZnW7HBG4kdGoNPo5hIfOwERnxGFPx9GHJSqXIeViXjY=;
 b=NKoZlH15Dte8I6AmVj5MR4XsaErFomuyMeu5onA56JgnjLAylhLw7I7T6YY4fzlumz
 77pfWGEopMAG8lKGgs6faLD5sgYOe8/RhaqlEXRWxJ13WtJ6425Cp3tz+JIUkasj+Bq2
 GmoZkZa0NyiiWh2TXxJdabqg0+kh8la573pYWPYnGJV6NGD3siVJ3rQgATfgiNi4RZjG
 0lASMAsqDCQh959AiJCfsTFFXtZ4QbcmY7lgw8PY1wbj+wbuba2kd+jdQnQPzCr986DZ
 vPq/X8EN8u/cRz9kzC5zZgSOurCggX0Wbx6WbCoxyJ0ClL48NlGSUjBQrheuyLW/NFoe
 qDfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvgKorvNUeo0o07D8wGrjujKcaZcuM3V6FOC6SKSsFlVmIornIKAqSKsZMmswlSjA9bThrg5yht3SgEcXXpJmVFLMW
X-Gm-Message-State: AOJu0Yz0dIropcVx2lH+MKp4lnEm28SS1VbAAgqVenRMms1nMxOpTxbq
 VB6S59A9QWW4AWmH7o0oT9WnaxZQxVqbXy/i/OxH8z4K30xFfEap
X-Google-Smtp-Source: AGHT+IHDVQK17QGYVvlte/FNZIeusGMxYYZHJ0kTdpGYHjys/+ANL66/iZbBG2YodNQQ+x34D5RnUA==
X-Received: by 2002:a05:6a21:3986:b0:1a1:4df8:1ec4 with SMTP id
 ad6-20020a056a21398600b001a14df81ec4mr8603289pzc.19.1710239659959; 
 Tue, 12 Mar 2024 03:34:19 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 w7-20020a17090aaf8700b0029c09574b43sm3036503pjq.20.2024.03.12.03.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 03:34:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 20:34:15 +1000
Message-Id: <CZRPCZAA1IT6.1ACEYYVZ27C5D@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 10/13] spapr: set MSR[ME] and MSR[FP] on client entry
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-11-npiggin@gmail.com>
 <eb0f5c3b-92ee-4c89-82a4-fcdd9db068b7@linux.ibm.com>
In-Reply-To: <eb0f5c3b-92ee-4c89-82a4-fcdd9db068b7@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

On Tue Mar 12, 2024 at 8:03 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 3/12/24 00:21, Nicholas Piggin wrote:
> > The initial MSR state for PAPR specifies MSR[ME] and MSR[FP] are set.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> It would be good to mention PAPR section numbers suggesting the same.

I'll see if I can find it and put it in a comment.

Thanks,
Nick

> Anyways,
>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>
> > ---
> >   hw/ppc/spapr_cpu_core.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 50523ead25..f3b01b0801 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -42,6 +42,8 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
> >        * as 32bit (MSR_SF=3D0) in "8.2.1. Initial Register Values".
> >        */
> >       env->msr &=3D ~(1ULL << MSR_SF);
> > +    env->msr |=3D (1ULL << MSR_ME) | (1ULL << MSR_FP);
> > +
> >       env->spr[SPR_HIOR] =3D 0;
> >  =20
> >       lpcr =3D env->spr[SPR_LPCR];


