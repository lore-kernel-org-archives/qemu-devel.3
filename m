Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FA1C35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tub5z-00086E-D0; Tue, 18 Mar 2025 13:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tub5Z-0007sd-Hc
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:51:07 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tub5X-00024s-Ms
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:50:53 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso4714631276.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742320224; x=1742925024; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OvJ1Chpj2jYmxujQHwHr5y5q3DIlYijmy0IxxUrM06M=;
 b=lJQCebEnfbtY4uoCQ8S2u4jcYHTuPseRAnQnP9i/Q6aMZ6vjtqQCWL6ROnzQl2QXaE
 Jcvj1GCBPuyubWzvYKvjuQOxpSK2D5bk27vYhcZHjfUc5ZdNICmwJzxz4nDoPMIAsQpy
 PZWI0DQPSsWO2obr4/biV90YrUtIZSDq6Qe21THZRhXjJFU4dljkqFomppURtYZB3UY8
 TpOtsktLLiDa41Y6T4b4kP7AJ47AItB7eTyzoai3kh9tmgDT4+q5NKoGUrrWkJt99NoK
 yzX4Pf1/PqcoQe4Gyi3bO8CVAN+UzJI8WyjFe6+t5+5+98TwDS81/OX2K8kFz60GEll4
 DhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742320224; x=1742925024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OvJ1Chpj2jYmxujQHwHr5y5q3DIlYijmy0IxxUrM06M=;
 b=IK88NYf79VRBnNVsKR5tUkBS0RzzkFhzV8H9H94JoRTwb5TQujKQxTTpcfsTO1lrdS
 mPKtboWKODJrLaIwLzXT932YiVU2bMrdqVYwt4SKhgqplA96IzTd8HUyT0cE9MReohPl
 jSCJWnSd4dqryk6tSGcIWnT1sjA4fnaaNgbSAlo8WAUAneStU9pdXKDZbF+9xyRBXiE8
 V8Vy3JxFKwCpWILvkhBHeLZtrfry5ei3/ojaSdgX3jSo2AionEILxQuYscDqN3Dx4ZJX
 64gMjcgoex5J7GwWT95kiStRm1/aBVXqW3tXIsobODd2t0MumvCX6HtyNesst2OSswnX
 3RDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvqX1JG1USF+L146HPOsySxVlxJOCPJlXEHND0wW8K+0Mjn5Ri/tVjdMjXYorHI1vThsdgOpseFMHG@nongnu.org
X-Gm-Message-State: AOJu0YxtuZnCswGxDbafYShhsHx6S8vpU3bBdSjM687iYsOLnuVDSHkN
 YZBi4dmSCeJUa3pxP7/dcuIAEygmRz/1qn5QTiked9id8AQm8UBmkFgE5bdyYzmiQGEE865DZmJ
 rVPrWSoCSPe9C5Lq9Ag94B1sZpnv9SFw4YsnSFw==
X-Gm-Gg: ASbGncuNN1jiNdrKaoNHWL52b43hxHn6LhfohvMG9HyEZPyEN9IACh/QNEEDcbsKvy0
 zeIu7+QFquj4sU0x1pA/k4NUflDTTnttOLGewSxyS3YGkLZn7+FYMvGmVVsjYFcN0z53bBZ/CMe
 xYVHAh/ZQPdKeHuH4SsRHn49RdK6E=
X-Google-Smtp-Source: AGHT+IGorLR4vpvSPH7Y1YAxXeFqCzaxkKZMA/+kwGP1IAahctRspftJyPmwcr0ynAjnueUx7zlU29wbFehiSxJqtI8=
X-Received: by 2002:a05:6902:4812:b0:e65:c4be:6fb9 with SMTP id
 3f1490d57ef6-e6679026c82mr264264276.25.1742320223682; Tue, 18 Mar 2025
 10:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-12-pierrick.bouvier@linaro.org>
 <8a24a29c-9d2a-47c9-a183-c92242c82bd9@linaro.org>
In-Reply-To: <8a24a29c-9d2a-47c9-a183-c92242c82bd9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 17:50:11 +0000
X-Gm-Features: AQ5f1Jq64ZMc3wNHD96Q-O52LvCc-sDu2DSilR-8cUO11vSS_VSAPQPzax2vqWI
Message-ID: <CAFEAcA--jw3GmS70NTwviAEhdWeJ1UXE+ucNSkR60BXk6G8B6g@mail.gmail.com>
Subject: Re: [PATCH 11/13] target/arm/cpu: remove inline stubs for aarch32
 emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-arm@nongnu.org, alex.bennee@linaro.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 18 Mar 2025 at 17:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 18/3/25 05:51, Pierrick Bouvier wrote:
> > Directly condition associated calls in target/arm/helper.c for now.
> >
> > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > ---
> >   target/arm/cpu.h    | 8 --------
> >   target/arm/helper.c | 6 ++++++
> >   2 files changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index 51b6428cfec..9205cbdec43 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -1222,7 +1222,6 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunctio=
n f, CPUState *cs,
> >    */
> >   void arm_emulate_firmware_reset(CPUState *cpustate, int target_el);
> >
> > -#ifdef TARGET_AARCH64
> >   int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int=
 reg);
> >   int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int r=
eg);
> >   void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
> > @@ -1254,13 +1253,6 @@ static inline uint64_t *sve_bswap64(uint64_t *ds=
t, uint64_t *src, int nr)
> >   #endif
> >   }
> >
> > -#else
> > -static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq=
) { }
> > -static inline void aarch64_sve_change_el(CPUARMState *env, int o,
> > -                                         int n, bool a)
> > -{ }
> > -#endif
> > -
> >   void aarch64_sync_32_to_64(CPUARMState *env);
> >   void aarch64_sync_64_to_32(CPUARMState *env);
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index b46b2bffcf3..774e1ee0245 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -6562,7 +6562,9 @@ static void zcr_write(CPUARMState *env, const ARM=
CPRegInfo *ri,
> >        */
> >       new_len =3D sve_vqm1_for_el(env, cur_el);
> >       if (new_len < old_len) {
> > +#ifdef TARGET_AARCH64
>
> What about using runtime check instead?
>
>   if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && new_len < old_len) {
>

That would be a dead check: it is not possible to get here
unless ARM_FEATURE_AARCH64 is set.

thanks
-- PMM

