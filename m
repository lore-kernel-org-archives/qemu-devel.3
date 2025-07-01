Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D78C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 09:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWXT2-0004S5-Ib; Tue, 01 Jul 2025 05:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWXT1-0004Rm-Aw
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:39:55 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWXSz-0004Da-Ar
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 05:39:55 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-70e767ce72eso31473077b3.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 02:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751362791; x=1751967591; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCOcQLmgdtfiHoEGzlEjIWzRramti7JO+XwYRKwRFyc=;
 b=F/ihg2IE6NHIAM56KES0V/KaMStlp+OavO87vAfZccd/yZau3qfKSx00TkNsEX2S9d
 Onw/hg1PMVPD70BoiJCAeUmWm/njgZsA9o2lIqI5oi8U24UD9wWMA8ukZ2dILub1/A0s
 0snskekHhXkeQ4r/Ft5T4O4ItHf/JKIA4POtSnjtaMwn94TmJuZ7fib/051qgUUDhFuh
 HnVBGW2vxBUhhdqajdJEinQjc15sb3Q785Al8vLDihoKy2IMa4Wr/nRNIy6lEYgfZsiS
 k1X4nPij4UzYreHQMn0RHhH9HJvteJfW1wHNwkp6y8trG/eKdaI4ixfnnSJqUGnqu+XU
 N2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751362791; x=1751967591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCOcQLmgdtfiHoEGzlEjIWzRramti7JO+XwYRKwRFyc=;
 b=gPcUXCljH8qd/ruAJ17V8RVumV31PgVpltyyZkvNKyGPJU9N5EJRbtUBHbTo4h3UHX
 e25KX3YeNcEv8XXyNgZ8W0rJs/En/z6dRcBW7DRf/FK0HIwJ+6kFvZmPxdawZ0EECIMy
 RviNWAR9f2le8h1fVrKosgxSkx37Jho+MYfDY+RMGnAsAfZ+4laBevMytgDIrEC3OYw8
 0bl+oAO75X6i5RHg5KZi68J+hx94MImhAli7MnnN6N3GHCWQbsUfjAbHucCg/O/XAxfG
 hk/DaOXii6NE5lG3C8jwD/dAwnDz04WNaZq51a3+3zZZFeZ1h8FwmNdIlFmTd6n64cBP
 FJzA==
X-Gm-Message-State: AOJu0YzYwe3FOtmtT//eetJa2ybjqDIdYFob4D1IqhOBR+b6gnV7Nfek
 EtQpJ+ItFdvhgjHC4T6/nr8b2wxoSrqQ9FdWogvnIsBrWy9W18xEtYkgP3CayCi+WFZX+yMGQhq
 8i2QHStmwLG6Ez9mDufFKgpkPlLlHsVU82RV3dS6aqA==
X-Gm-Gg: ASbGnctOmznDJv68vVOfCC/t4LhYXQdj0OwfMJwEME9B2GTaPDutHxnAQikIWZ4Ruoa
 yU3hso0cyq3olLEeR4uvGO6Kajea2hRtcc8BKhPomyk+lDzx9OO/X6jhBwzaezbGByG7LEx4Rs0
 UD2hUb8L6mB2nG92YqCZ5U+EyYXzLMjU5FdP6ZF5QZWyPN
X-Google-Smtp-Source: AGHT+IHDlq2gURbFKW5g1kNI0w9591f5lYZ70IA6CEkE0lSHka0P6ZqUiCTl2McDGmbd1GXnJnECbd53cRCfMH2DS9I=
X-Received: by 2002:a05:690c:7443:b0:70f:8883:ce60 with SMTP id
 00721157ae682-715171aacdamr245762197b3.26.1751362790962; Tue, 01 Jul 2025
 02:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-5-philmd@linaro.org>
In-Reply-To: <20250623121845.7214-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Jul 2025 10:39:39 +0100
X-Gm-Features: Ac12FXxpYnulxisO6QVKFIKPO-zv9Pwl_r62oxyX2ZYzOaAwSavLKRmqxWTN_Jo
Message-ID: <CAFEAcA8+9TPps4NkRwRTZXq-nkR=zJ1SsFLnMzzNf7MioU-qsw@mail.gmail.com>
Subject: Re: [PATCH v3 04/26] target/arm/hvf: Simplify GIC hvf_arch_init_vcpu()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Mon, 23 Jun 2025 at 13:19, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Only update the ID_AA64PFR0_EL1 register when a GIC is provided.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/hvf/hvf.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 42258cc2d88..c1ed8b510db 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1057,11 +1057,15 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>                                arm_cpu->mp_affinity);
>      assert_hvf_ok(ret);
>
> -    ret =3D hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_E=
L1, &pfr);
> -    assert_hvf_ok(ret);
> -    pfr |=3D env->gicv3state ? (1 << 24) : 0;
> -    ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_E=
L1, pfr);
> -    assert_hvf_ok(ret);
> +    if (env->gicv3state) {
> +        ret =3D hv_vcpu_get_sys_reg(cpu->accel->fd,
> +                                  HV_SYS_REG_ID_AA64PFR0_EL1, &pfr);
> +        assert_hvf_ok(ret);
> +        pfr =3D FIELD_DP64(pfr, ID_AA64PFR0, GIC, 1);
> +        ret =3D hv_vcpu_set_sys_reg(cpu->accel->fd,
> +                                  HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
> +        assert_hvf_ok(ret);
> +    }

This doesn't seem like a simplification to me...

Looking at the code, I suspect what we should really be doing
is setting the GIC field to either 0 or 1 depending on whether
env->gicv3state. Currently if hvf hands us an initial value with
the GIC field set to 1 but we don't have a gicv3state we won't
correctly clear it to 0. i.e. we should change the current
  pfr |=3D env->gicv3state ? (1 << 24) : 0;
to
  pfr =3D FIELD_DP64(pfr, ID_AA64PFR0, GIC, env->gicv3state ? 1 : 0);

thanks
-- PMM

