Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C361C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 07:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8xIo-0001Zx-SO; Mon, 20 May 2024 03:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8xId-0001ZA-B9; Mon, 20 May 2024 03:19:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8xIa-0004zk-BO; Mon, 20 May 2024 03:19:10 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ee12baa01cso71015115ad.0; 
 Mon, 20 May 2024 00:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716189546; x=1716794346; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kw1kuHl+nRQjv88CkzUyzSrYaWYXR8AwT0V/BT+KKAs=;
 b=BYJ67lKMner/W88vFXI9A9J/fvhedsz8Dp3FuYDNCJiH2x9QFgI0fa4ot88Lc3CTaZ
 4K1giE4hwpzxXZmpQgULW2uZnQf6234zZBSLC612og+9a7H0MM5DRP/MG0jc1MT6rHO7
 y5MNBEKUY7umWKR6flrV8OZu6KFoyLQx0+Mg4BxxGapMTZgYswH8PM4QMzrmdgEdCeuU
 9oP4xXh7sTcMfBOBrrLuLfgZlcG+SijmaQXqbFiTBe50yZEnNbEdGc4dlW0aWjvw9hZz
 lPAG6W30uo0+5rqwFxyLmfCATz/Fnnkn+NTimJBOfuSBmnpSSurqqDIAr0HKod87j4no
 EUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716189546; x=1716794346;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kw1kuHl+nRQjv88CkzUyzSrYaWYXR8AwT0V/BT+KKAs=;
 b=kiUD9BKmGXsDsLHsAA0OopSDWUe+8QwJKl8fevzvtrMucTZh95egB0k2ka4Psu/sCB
 XV8Zbw0C4hfjgbmhz18qNa/+Cl8bka32d1J3Nz9YyjMoNuYQOS+eplEm6VPE/rXm9hEj
 IR4LsRndWJ6azkZn9zay9YAauw70OP4IeVIbLrdkNO0GhCy/kG/wuPQ2QGKTLS/BPiYn
 hIAL2tHCcQyEXuxUaEazdD73tR8IDd70zGDgSp4BPyv3ncIlPUw+bCD4m+Pj0ipHf3BI
 OJI5szJJYyi1TfjT/u7lOI3+J/Q5hA6kGBQ+3OtL0ll0V3jrVwqzEfyBWt4xwMJ764t1
 0YMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjAenYU2gBTI3JQ4BjLj671aFmgoWZPd9UWUr8hflcsFvHtizwCwO46s44/deEsM08d6BFcKdAT4edjeuB+cjIxyLW
X-Gm-Message-State: AOJu0YzuvelUp1YwOWVRn5utmCLV8zsyMIS1isE5qzYW/1DrhqHUTY0n
 NRBH2KyhEhMhG4PO4yo+23J2w4aRTlmRycFPmxB4C5n6jI7O4sl1
X-Google-Smtp-Source: AGHT+IER4rWhJBhnZRWDQBertoj7p1vySml4YINXf7cYF3BoLrOLwdNINiDwXtNOePh9TAWQheOOxA==
X-Received: by 2002:a05:6a21:328e:b0:1af:d044:1395 with SMTP id
 adf61e73a8af0-1afde0b0c18mr31015647637.20.1716189546323; 
 Mon, 20 May 2024 00:19:06 -0700 (PDT)
Received: from localhost ([1.146.114.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2af2b30sm19170661b3a.146.2024.05.20.00.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 00:19:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 May 2024 17:18:59 +1000
Message-Id: <D1EAF2H5P5ZY.3PPKAHKC71VHJ@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Glenn Miles" <milesg@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/14] target/ppc: Implement attn instruction on BookS
 64-bit processors
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240518093157.407144-1-npiggin@gmail.com>
 <20240518093157.407144-6-npiggin@gmail.com>
 <6bedceb6-1f40-4ab5-ac30-ce89f415ee84@linaro.org>
In-Reply-To: <6bedceb6-1f40-4ab5-ac30-ce89f415ee84@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat May 18, 2024 at 9:05 PM AEST, Richard Henderson wrote:
> On 5/18/24 11:31, Nicholas Piggin wrote:
> > @@ -425,17 +426,17 @@ static void powerpc_set_excp_state(PowerPCCPU *cp=
u, target_ulong vector,
> >       env->reserve_addr =3D -1;
> >   }
> >  =20
> > -static void powerpc_mcheck_checkstop(CPUPPCState *env)
> > -{
> > -    /* KVM guests always have MSR[ME] enabled */
> >   #ifdef CONFIG_TCG
> > +/*
> > + * This stops the machine and logs CPU state without killing QEMU (lik=
e
> > + * cpu_abort()) because it is often a guest error as opposed to a QEMU=
 error,
> > + * so the machine can still be debugged.
> > + */
> > +static G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char =
*reason)
> > +{
> >       CPUState *cs =3D env_cpu(env);
> >       FILE *f;
> >  =20
> > -    if (FIELD_EX64(env->msr, MSR, ME)) {
> > -        return;
> > -    }
> > -
> >       f =3D qemu_log_trylock();
> >       if (f) {
> >           fprintf(f, "Entering checkstop state: "
> > @@ -451,6 +452,30 @@ static void powerpc_mcheck_checkstop(CPUPPCState *=
env)
> >        */
> >       qemu_system_guest_panicked(NULL);
> >       cpu_loop_exit_noexc(cs);
> > +}
>
> Looks like you're not using reason.
> Missed swapping out in the logging block?

Good catch thanks, I lost the hunk in a rebase.

Thanks,
Nick

