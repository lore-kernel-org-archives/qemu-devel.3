Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5F9C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 07:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzAOY-0006E7-Lm; Tue, 23 Apr 2024 03:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rzAOU-0006CH-HI
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 03:16:48 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rzAOS-00028v-AK
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 03:16:45 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ae913878b0so436524a91.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 00:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1713856602; x=1714461402; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7pmlAdIn9m1SqZIWLYgZAiFVGEC3YU6DNx7ytYC2Qg=;
 b=I+L1o7RGvmkzwZchDXatUIJMX+ih7ZKSkCpd57rGSOkIHo+O7e4lI5OqorajVEovZs
 8f8kdTTtdSHF9FOl25nCjfpgFVc7FLE8fasiS+9n5t+oBaU9XSa+u0Xo1QRphyVX/tBt
 oaO/TIsrs49hECdIRRmTShEvde8XmfZiPQYUz1mjEtOtqVWs4FEXYz/bHoq/pK5GajXe
 Wtsb7gVUZMfKPEo2uAjHJy8gPQwt+6kWhWCkVWeALf8iTlNdX5o4T0hTBROUcwxy6yKX
 WPD3csE1LYyZxI62Uu22yvCH54WYiuro2otR23kIbTONoHEACQjHyTYTCbrOUdeHZlNV
 NSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713856602; x=1714461402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y7pmlAdIn9m1SqZIWLYgZAiFVGEC3YU6DNx7ytYC2Qg=;
 b=MRi9OnwOlL/Z2T+OdE6W/wKHX6nS2qPIN0Zoi6XkxmKrlXPBKKztSzv48nvRJrYZGU
 htDJxu+ba85R2HqeIcMpdCBgBcYOzXEF/XpOEmw5iI4u8TOUUUGdNR65OoYEWqoO+xz3
 84EqHnfU/IxF3w5kWSx63b7P8CLSAuBTommKzpDPBi23h0qDCoCAROzOvkApTjQE+ogl
 l2XVeVTfjWW8HvpebB3z172Wo96v1UBMWIcprkFRx95s86CFyjI2tRHyAhHEEfAb/1cG
 wpSTxikF3bPK+Zqmr7nNWB9eYbKPH8CUZr+BDeeB+XzZ92yc705KyhVpGfVeb/fC1GAy
 IpmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKxioyzoKtQ3br0t1LR0H9jNah98rwmlm13fk1BhwGoxV1LOUhfGsTL217YKhbWCa7rN2moVF0tWCm8MvCX3GBVgqXHzU=
X-Gm-Message-State: AOJu0YydTf7JTG9sS5IUGamCNpHbZ/eitI5F0BtihsohJMYl0OFXAOdf
 +QI7osqyK2YWfEl45MwIVlzfwsjY+2T28vh4Sd+HOJjbdIcwrNMgvpDIfVqdWy66I9AO+/0Ztmb
 uZR8WiS3VNJYCpxqrjdUf5RVJHM2CI8QIsYE4
X-Google-Smtp-Source: AGHT+IGm6uU7C/MIeXgxJNy4OpG+8M7Q1om0eYbUyNzF8oKtFudHCnkIH5j/Icpxx3a+BYKW3iF7/cnJawxpii0qBXo=
X-Received: by 2002:a17:90a:840b:b0:2ae:d03b:9594 with SMTP id
 j11-20020a17090a840b00b002aed03b9594mr314221pjn.39.1713856602658; Tue, 23 Apr
 2024 00:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240422170722.117409-1-richard.henderson@linaro.org>
 <ea575a44-9ce6-4da0-ac62-f283c436c540@linaro.org>
 <98baa946-494c-4907-9a1a-5333482b5193@linaro.org>
In-Reply-To: <98baa946-494c-4907-9a1a-5333482b5193@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 23 Apr 2024 09:16:31 +0200
Message-ID: <CAJ307Ej0Jv=UCwBM9s--q_iPFKvyp0j1xjou51qeDeAJApzLFA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Restrict translation disabled alignment check
 to VMSA
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 peter.maydell@linaro.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=chigot@adacore.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Apr 22, 2024 at 11:02=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 22/4/24 19:09, Richard Henderson wrote:
> > On 4/22/24 10:07, Richard Henderson wrote:
> >> For cpus using PMSA, when the MPU is disabled, the default memory
> >> type is Normal, Non-cachable.
> >>
> >> Fixes: 59754f85ed3 ("target/arm: Do memory type alignment check when
> >> translation disabled")
> >> Reported-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>
> >> Since v9 will likely be tagged tomorrow without this fixed,
> >> Cc: qemu-stable@nongnu.org
> >>
> >> ---
> >>   target/arm/tcg/hflags.c | 12 ++++++++++--
> >>   1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
> >> index 5da1b0fc1d..66de30b828 100644
> >> --- a/target/arm/tcg/hflags.c
> >> +++ b/target/arm/tcg/hflags.c
> >> @@ -38,8 +38,16 @@ static bool aprofile_require_alignment(CPUARMState
> >> *env, int el, uint64_t sctlr)
> >>       }
> >>       /*
> >> -     * If translation is disabled, then the default memory type is
> >> -     * Device(-nGnRnE) instead of Normal, which requires that alignme=
nt
> >> +     * With PMSA, when the MPU is disabled, all memory types in the
> >> +     * default map is Normal.
> >> +     */
> >> +    if (arm_feature(env, ARM_FEATURE_PMSA)) {
> >> +        return false;
> >> +    }
> >> +
> >> +    /*
> >> +     * With VMSA, if translation is disabled, then the default memory
> >> type
> >> +     * is Device(-nGnRnE) instead of Normal, which requires that
> >> alignment
> >>        * be enforced.  Since this affects all ram, it is most efficien=
t
> >>        * to handle this during translation.
> >>        */
> >
> > Oh, I meant to add: since the armv7 manual has both VMSA and PMSA
> > sections, and the language about default Device type and alignment
> > traps, is in the VMSA section.
>
> To the best of my knowledge,
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks for the patch.

Tested-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

