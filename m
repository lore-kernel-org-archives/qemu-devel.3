Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8034C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk33N-0003Jd-Q3; Tue, 12 Mar 2024 10:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk33D-0003FV-CQ; Tue, 12 Mar 2024 10:24:20 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk33B-0004RJ-U2; Tue, 12 Mar 2024 10:24:19 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dd9568fc51so20848925ad.2; 
 Tue, 12 Mar 2024 07:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710253455; x=1710858255; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/hKciDKoT9vMdm5a9JHc4PbMhyEUK9l8FOn6LEtH0jY=;
 b=l/rjpS1dx1fW0nv8UIbqhMWDmycfB7gNdhn9S1sWRtnmf3PRdXy2UeIyKDC7blMhkS
 SWAOd6J0Oqwd2a8rj7JMO+9Kww+ZzaU2uRQLtG0keoCl6I94ez6Ib11YVM2khv0HANhy
 5FnIMNegorKB2QfVRpajp+7ssQ1PBqgdqIWQOMXK3scR2f2cRmjLg8PJtQ9VTtpUuEP5
 Mn9uv/Qt78zG1NmCMr04Cemm0iHiqrqNGKFWRFf0akzr5+wr+jYgFCq75wqVB/P19L4V
 8RfX7Qf1hctciOjCuTwPyierXZDTZWUHZe9XjPNg2BvI25uiJiyHoitvaqDmRJiOkrx5
 cBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710253455; x=1710858255;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/hKciDKoT9vMdm5a9JHc4PbMhyEUK9l8FOn6LEtH0jY=;
 b=sZy4hSC+cGFJi17aeUc2FatF6aBh2eLPT8F9AwE1g/4WviS9VLVtGxhfrs6/61CorZ
 HA9NPJvj76X6earkzKzqIMMWwih+KbFxT4d3hfIUIxfCDxHKAVMnklcoSg8B0pZ63PWv
 kTZt3c+kRJ+mtKupMTvDjv8J+kVjOBHWHOJjr3n+9GkHYiQmyZSPc+gEUwWyhVAWL5cR
 8Fg1yw98SC4uBTQBRws02KBiDyELAKkOy0Z69QCa4+WkDsgCAZMWJzwTPJAa8PzYWeba
 +teIt3VbeDZnYVJQ7c9s7ffsZg4Hvwai/JAZHi+HKII5/vQeuS0m2BLwu3ECa3JzhqIH
 G9fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjrc47tusr1RtduLUWndYR78jFBO8uz0H0Ln83KUwGlUjLwts11rBf6CFt0z/o9dqkvRjwguqEpsnEe6idWsOJ0bfBjvImuQEehfN8pynKWrayeR0G/5M47G8=
X-Gm-Message-State: AOJu0Yw9D9clNLkBW3AsGZ9P2HXcr+Vj8rWXRsIj7+FMBkRZSiXz3/+2
 zmqnJDKpFhuc08qxTKtl9nrUK4H/PaUi6D7x9Ob4S8IqxJvSRD1z
X-Google-Smtp-Source: AGHT+IHSm/jdiTMCGU5O7dM9QkiRAhIk1F5pjPkSzsspcWatnZFwZuEHEuHdJ0UqLEObLMopdEFjoA==
X-Received: by 2002:a17:902:d302:b0:1dd:6a1b:2736 with SMTP id
 b2-20020a170902d30200b001dd6a1b2736mr7130355plc.65.1710253454963; 
 Tue, 12 Mar 2024 07:24:14 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001db594c9d17sm6730650plh.254.2024.03.12.07.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 07:24:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 00:24:09 +1000
Message-Id: <CZRU903MDUJ1.6S9RSO5A4RDG@wheely>
To: "Richard Henderson" <richard.henderson@linaro.org>, "Chinmay Rath"
 <rathc@linux.ibm.com>, <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Cc: <danielhb413@gmail.com>, <clg@kaod.org>, <harshpb@linux.ibm.com>,
 <sbhat@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: Move floating-point arithmetic instructions
 to decodetree.
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240307110318.170319-1-rathc@linux.ibm.com>
 <CZRO4Y67CBPV.2IAKB80EFDKEY@wheely>
 <0c7c6be1-12fb-4267-9d41-bd51637d104a@linaro.org>
In-Reply-To: <0c7c6be1-12fb-4267-9d41-bd51637d104a@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

On Wed Mar 13, 2024 at 12:01 AM AEST, Richard Henderson wrote:
> On 3/11/24 23:36, Nicholas Piggin wrote:

[snip]

> >=20
> > #define FPU_HELPER(name, op, flags_handler)                           \
> > float64 helper_##name(CPUPPCState *env, float64 arg1, float64 arg2)   \
> > {                                                                     \
> >      float64 ret =3D op(arg1, arg2, &env->fp_status);                  =
  \
> >      int flags =3D get_float_exception_flags(&env->fp_status);         =
  \
> >      flags_handler(env, flags)                                         =
\
> >      return ret;                                                       =
\
> > }
> >=20
> > static inline void addsub_flags_handler(CPUPPCState *env, int flags)
> > {
> >      if (unlikely(flags & float_flag_invalid)) {
> >          float_invalid_op_addsub(env, flags, 1, GETPC());
> >      }
> > }
> >=20
> > static inline void mul_flags_handler(CPUPPCState *env, int flags)
> > {
> >      if (unlikely(flags & float_flag_invalid)) {
> >          float_invalid_op_mul(env, flags, 1, GETPC());
> >      }
> > }
> >=20
> > static inline void div_flags_handler(CPUPPCState *env, int flags)
> > {
> >      if (unlikely(flags & float_flag_invalid)) {
> >          float_invalid_op_div(env, flags, 1, GETPC());
> >      }
> >      if (unlikely(flags & float_flag_divbyzero)) {
> >          float_zero_divide_excp(env, GETPC());
> >      }
> > }
>
> Beware -- GETPC() may only be called from the outermost helper.

Ah, because it's using __builtin_return_address. Good to know.
Using always_inline and a comment should do the trick then.

BTW., to Chinmay, don't feel the need to rework your patch this
way if that's creating a lot more work for your tested patch. What
you have is already good if it can just be split in 2 plus the
minor other changes. This could always be done afterwards.

Thanks,
Nick

