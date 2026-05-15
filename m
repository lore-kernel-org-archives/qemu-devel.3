Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2455CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtZS-0008Gm-E6; Fri, 15 May 2026 10:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtZK-0008G6-79
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:31:15 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wNtZG-0002xi-Am
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:31:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4585a116a4aso4600121f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778855466; cv=none;
 d=google.com; s=arc-20240605;
 b=YkGy5ZefVX0qLnrZvcAg871kkj6nY3+RcW+kRTy6g80dOxmSK36fcHCLH1/WCzm+sP
 pkJLVSpWQh47rh/izu1f51N/uYRoEaGQ0FHME/wahu7PKfY56iZuRJDzm0JHbFBhFAn/
 X65O0FavRDjCek05zHAhqHIAV+IGHRsexvAJ8/fq/9GZ3Ef+b+JuiGzFrAYZjk2lXDyJ
 IirMU9T5zyOW50XuU1UhhUMC0TnuI32IX1UJyvKzI8o+7mRhzu6djCyiVCpzr+5xafuh
 82S47lGwxo9prhTVcppnnxabALWfjk1Zm2qJQKTT/a6gmXwdkGExcL8IV3sfJRC7v2XO
 dg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iqpaB11lB+i4Tnn2aT9+weYYqZdjgfUKZ0Fy4jcne1g=;
 fh=G+JBw2Pu6hUZ8zKsXx/FXyHuhiws+/jrNByUetwlSSw=;
 b=WOmy/MfU7OL1KFelsfZVD32a/60uQiDJfTjEKMmrHk2+nKufk4dUNr6nTweMhccgWa
 P7k3RMHb66IdmfeEO8KG2sw5cRdRGClKplOzmkmNbAjdIJfJWFzunk9JlXbA28OD2nGX
 ssMjtFpXvOsKM9L/60FRYQ7+QYMeyOhdrvJBIrcTKF4Vyanoj44AMZxLHTIOjlpTVQtp
 nN/X3ClJ/rdWtLwmzO0XpXDBR+bOxSU+iSGsrJYbRVINBS19VYBL551f6Dezxd50VCbR
 wtlGPilZ9Li+KHojdXzQNEcPcUhVgBaZqJ8AxoN1DNreLWlbrUXu44lyEeEgmj1mCB5g
 bRHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855466; x=1779460266; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqpaB11lB+i4Tnn2aT9+weYYqZdjgfUKZ0Fy4jcne1g=;
 b=UVDgCZMZuMMaW0QF7oA7PxHa+bAUsgY2uONKxaLbXgbTCtlgVr1PFpDe8a8qqaIomV
 5L9SU4RIAFxtbkFJirtQVpHTpgeEV6x8GZ91gqkwBwxZxLUeORX7iSXJlT2GRbJrF7zN
 cK+AMJnrHiM/u+YlMXtiqwSV4gulQhIINagiqnUd7CMzB4sBPOYQ0Cce55IP7k1VThdh
 UeQ1CsHJZLiO08upSdHIiTybT0u7bJc8Odoe7ywmNEgb1zJpGd+u6tJnmnerobFSSLAT
 8P5cxIsPuPafvna64ITfnebTw4yWWGUAz5ZcomcwdXr+j65G4ZkfJnRMYL9Ck56ujXmu
 c5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855466; x=1779460266;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iqpaB11lB+i4Tnn2aT9+weYYqZdjgfUKZ0Fy4jcne1g=;
 b=A03TB17X8rrP5L0jCvs7bH+CzgnfyrH2BxyD95TQY8jCoStYwSRtmPaENm+5UAHvqa
 Y1VKVLdNo7+O7WhNlAYDx60Y/Dt9bQSLS6vLnZKncKHJSeD6dDa8zIevjO54hAgP+NQz
 xqZnNhagBSo4/yB7ZPUqC4CeEm9HxBNJqNxV3wMIZodTw0mfua1hX+cGoslsk0T7+xV/
 E8vxuf/XYnPOshc50rFwAs9vDuZRDZ1bhPmmf0kN7Q8WNvmJFH8QwKxUliTtuak3capk
 +GAB/2MzjBRIcxErdhTiloctO3vQiyHJGRaVB0hS1g1m1Wm+JBS12eN3m0r08V0XV5Da
 rJ9g==
X-Gm-Message-State: AOJu0Ywzj9+0GlPg9BOQQiC/Cb8o9Y+9Jf44xTxx9f0UpFN7xF8gXjMm
 dcl4K92FVOGfEKVQ6ail1tGQJ4Ewv015Z7tFdd/T3H/tnSecuyF6tL6FfP1TMX+t41z3eJTnzn+
 0UvEKL2FbdZstAtcu6OoYbtcTdUo20kSvU1iqgsXCd+ZfroKPIqIMX06mhA==
X-Gm-Gg: Acq92OFpcDLmIlpEtyES5OkyP+V3pCujjvtk89Ef6rxlKPAmPE3WkVgXIapDDSL6iEW
 fHbwil1LQxCUN+3OoHeQHj2vJGqVrm/MAm5JVVxPUg6l31qWF5orenx4dSyGJv1GYJwyrXnX3L/
 NmfHmmGnnkW67OQAdB8SnN/tjl9ahMia3ibIbQhSw8QaYSbOeCvpFPj2xzmWJI+1QQtXFDxg/jX
 gPkZO2mThTg2bPqcWq26Xn7CYH8PRUcNWcoj3/C56q3+2F7tGBSbeY9Ct9o6hRh3B0I8aN+GCCY
 zlIz/WUVlNn9anA+svXrJ4NKVCkRgBF0fabHl67+YQ//WtyrbQ==
X-Received: by 2002:a05:6000:26c4:b0:43c:fc5c:aa0b with SMTP id
 ffacd0b85a97d-45e5c5e1da2mr5962329f8f.42.1778855465636; Fri, 15 May 2026
 07:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-20-philmd@linaro.org>
In-Reply-To: <20260515141032.3271-20-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 15 May 2026 17:30:37 +0300
X-Gm-Features: AVHnY4IuC7PDuu1wyvjnMXIMKADLWR42yUedf5EBSLmrMd84Bf5F8UW6cpoG-uA
Message-ID: <CAAjaMXZqtMx_3XFBE2nLkdWQdXbP6o86SSTVpQ26Cigb3M88Wg@mail.gmail.com>
Subject: Re: [PATCH v6 19/20] target/arm: Build cpu32-system.o as common object
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 15, 2026 at 5:12=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> cpu32.c only contains CPU types used in 32-bit system emulation:
> rename it as cpu32-system.c; always compile the file but only
> register the QOM types for the 32-bit binary.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



>  target/arm/tcg/{cpu32.c =3D> cpu32-system.c} | 19 ++++++-------------
>  target/arm/tcg/meson.build                 |  5 +----
>  2 files changed, 7 insertions(+), 17 deletions(-)
>  rename target/arm/tcg/{cpu32.c =3D> cpu32-system.c} (98%)
>
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32-system.c
> similarity index 98%
> rename from target/arm/tcg/cpu32.c
> rename to target/arm/tcg/cpu32-system.c
> index 8220d785f5b..51ed1f8f269 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32-system.c
> @@ -1,5 +1,5 @@
>  /*
> - * QEMU ARM TCG-only CPUs.
> + * QEMU ARM TCG-only CPUs (not needed for the AArch64 linux-user build)
>   *
>   * Copyright (c) 2012 SUSE LINUX Products GmbH
>   *
> @@ -10,18 +10,13 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> +#include "qemu/target-info.h"
>  #include "cpu.h"
>  #include "accel/tcg/cpu-ops.h"
>  #include "internals.h"
> -#if !defined(CONFIG_USER_ONLY)
>  #include "hw/core/boards.h"
> -#endif
>  #include "cpregs.h"
>
> -
> -/* CPU models. These are not needed for the AArch64 linux-user build. */
> -#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
> -
>  static void arm926_initfn(Object *obj)
>  {
>      ARMCPU *cpu =3D ARM_CPU(obj);
> @@ -738,13 +733,11 @@ static const ARMCPUInfo arm_tcg_cpus[] =3D {
>
>  static void arm_tcg_cpu_register_types(void)
>  {
> -    size_t i;
> -
> -    for (i =3D 0; i < ARRAY_SIZE(arm_tcg_cpus); ++i) {
> -        arm_cpu_register(&arm_tcg_cpus[i]);
> +    if (target_arm()) {
> +        for (size_t i =3D 0; i < ARRAY_SIZE(arm_tcg_cpus); ++i) {
> +            arm_cpu_register(&arm_tcg_cpus[i]);
> +        }
>      }
>  }
>
>  type_init(arm_tcg_cpu_register_types)
> -
> -#endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index f821331fbee..a6aac6deef0 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -29,10 +29,6 @@ translate32_d =3D [
>
>  arm_stubs_ss.add(files('stubs32.c'))
>
> -arm_ss.add(files(
> -  'cpu32.c',
> -))
> -
>  arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64 + files(
>    'gengvec64.c',
>    'translate-a64.c',
> @@ -83,6 +79,7 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', i=
f_true: files(
>
>  arm_common_system_ss.add(files(
>    'cpregs-at.c',
> +  'cpu32-system.c',
>    'gicv5-cpuif.c',
>    'psci.c',
>    'tlb_helper.c',
> --
> 2.53.0
>

