Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3253606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgHziJGd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW4fk-0000hy-KN; Tue, 24 Nov 2026 23:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xW4fi-0000h9-8Y
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 23:31:54 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xW4fg-0006iN-FC
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 23:31:53 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-3ace304021eso51126051fa.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 20:31:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795581109; cv=none;
 d=google.com; s=arc-20260327;
 b=U12rGKaFROifW88imbksjeTU5Rfj51BtEn3rY3I9fUEzMZSUlqJtLwWdC4j/4ayHeG
 IECHUE2k7254ib51Xg5nb08LvEIMg5W8GSYRlxjjbwDTHTBR8Qu/bM9xNXPIoN1Z6k9W
 seASASE6LJ11l7LOON32a9KIY70S9HdyRDUe5E+K+xkq5/10V4Ryes16Os2kCjBGFQFh
 n84qer5NUDUPG919weKCbrgo3D2xTugekE0A0gl5VtKdtKGwjWuksTzPACG1zMcEfh81
 b8kZ6tZocRxAsHyaBXezQS+y2FGsWA9M3gPa08MosvSlU0OILFcrpPYVzRk4cchC+qc1
 3Pdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QZ52ETHoP26ebwlsjgI8/vKQEEnUcFsLW/3WDfTyk3s=;
 fh=6VNOjFf10Te1WtUJiFh/vOeUAF6/X0V+VGsRxu0yjrI=;
 b=fBU8G8NVpLXia6in+OVyNCi+lXHExDYh2VKiQy62ZO3d4BUTe1M8jV87K/K25Gj8yH
 v1I0duthHvtaD2qSHBlAVyEw9MaAXfEPrgSE2Q8wjboqAszurqtM2YueVePK92Jr4NhM
 TuSmmjrB6y+pBmIHKeuBqIAzbh/muTjPZgz+tlkTRggclsekX2k9t739wOUlQ2Xe9/RG
 Y3EzMwKBit2N2Tl0IQOWOD305L6rLpnAgu2gkronSM6zMwCallvYQcd7VRuScNsDIZ6k
 R0zI5jP3D6qkTOFDb/YbcMblI44SvuaR9vpUpqMM2ynrlPXY853XhCHLdxfW5qNHrZ/T
 +kVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795581109; x=1796185909; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QZ52ETHoP26ebwlsjgI8/vKQEEnUcFsLW/3WDfTyk3s=;
 b=hgHziJGddPJtN4qjnbXSLDpq0rX33fKsu6k3DcyVoCoXHcc9gn0MWQ8yIZU+7G+zvr
 eG+lzizzCjIzk0KFoH6YAki4oRLEJNsDoy5/jQY+qHC3q43Qwwe7NYiTcWZKqPHyQDJb
 7pbEtTFoXhRKpUWys864eR5DW7EE/UU/rWjP70ereBpsCtmLr6s6lt6P0k94OT6F7/m1
 0Kl3xaPASIPYb4JYWFr1+FN3mz0QAZa5SQNjSQSe4RmL2KVxzP/PSvjj900mRd5IXvST
 fr3SDWFyl5YuZ1S/jpkMvujeKIhuTmcdtmTy3s82PQMSkBYeHdCCLz392fRIDiU6i9cf
 5u3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795581109; x=1796185909;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QZ52ETHoP26ebwlsjgI8/vKQEEnUcFsLW/3WDfTyk3s=;
 b=fuFyVC1Yx7J7opPJAU/m3WV6ZusBTT8mhIUgFWeJlg0bB0c2VHMigJUqfCZrB9eSNO
 VymQVzKBiPpibBiRaa8VBD1Tetri5d0uDbzAbOjC4NpCAk74AV0cTzV3iNdbtincFAwl
 5/Jd7c6ic71x0E91ZT8cwWhoUNnF4dBrzcgNcN+qUxqO++KP8iKl59Du7c0WacRds1rR
 eO0mW3xncs5HqX3hIH2GnFS0iHwCDaNFo4pTZqgpYH7bh/WVjXurgCAF0RGowjbz+zvS
 MKepSEpWBkWaeL+VXSzd3Qp5ep53B09aUe4OWtS9i1YZYO+vXui4ebjDUwCfQ2xMdEKr
 cUDA==
X-Gm-Message-State: APuU4Z8DjVpBDuGwaJoLRmajBF9rqQKtDhs41y6BebXQWndrmIQBpHGb
 XK+cou+bxw4KjCSbuOmw2w4RK5fe5c3rm22ySKKwcu+EXxK6ZjlPZH9DE+ArL43z4bHJiV8Pi97
 iUgPmQyZMkYXm4iUszFnge92asZIz98XGPIAY
X-Gm-Gg: AZFdTZfq6of+2uNVom/jyUQL20Ofavg5rE2MT9Cbsi/sFrXbw1+y8cxOy0FlyY1DwbT
 +ol0KDby78pkt48ssd/3NDJNk+qUgdbdMHWXmBhQEGs1wuOoWroh7HSWr/i/9tFB/TuYgXQzYan
 yoMI7x7pHz/iKbSkva7FrSVEN+ZbKgZ6NcWDjHy0zdEpQ/hNAMSo02Q1cihAQbxvEa1PS9e77NN
 HIGsZ1GvQRLwJPFaQ4u+Te/4299TcPhA4uO79zQWouJoIFNXo808zDTO2+gqGhaKMswADKlHMtw
 BCLp0hvGwYcJLtoNHfoqPUbdy8hQikpmpajO/x8/igWD4J+LvvTPwmCfTEErqUrFIuHAooNrPIO
 CynITomiqDM6kcArsZCWPBf/4MO92tnDLRPGQiNxQC43VHFRQvHQ4k54vGakfI1otv3M=
X-Received: by 2002:ac2:4bd5:0:b0:5bf:e241:cd5e with SMTP id
 2adb3069b0e04-5c1bc7dc4d8mr4245642e87.40.1795581109292; Tue, 24 Nov 2026
 20:31:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118-4836-cpu-host-error-v2-0-ba02bb640d9d@gmail.com>
 <20261118-4836-cpu-host-error-v2-2-ba02bb640d9d@gmail.com>
In-Reply-To: <20261118-4836-cpu-host-error-v2-2-ba02bb640d9d@gmail.com>
From: xmphyr <xmphyr@gmail.com>
Date: Tue, 24 Nov 2026 22:31:37 -0600
X-Gm-Features: Aa3M54pzPJFb4wSd-rypP7rxA_fOFBe2WPQGs_xo09vtu_xY6rSlnP_-mOuYJQ0
Message-ID: <CA+hLWEE_yqsXoF40zzMeh_JuZ9fXA+Um+p9w4p=5SdwM7KLtdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/i386: check hardware acceleration with -cpu
 host and scalable error
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=xmphyr@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ping
v1: https://lore.kernel.org/qemu-devel/20261115-4836-cpu-host-error-v1-1-fd=
f0eb56ba8a@gmail.com/
v2: https://lore.kernel.org/qemu-devel/20261118-4836-cpu-host-error-v2-0-ba=
02bb640d9d@gmail.com/

---
To Philippe, I forgot to add this to my aside, but I decided to
continue with listing the hardware accelerators by name in order to make
the error message a little clearer. After all, the motivation for the
issue was that the original error message was unhelpful.

---
Thanks,
Andrew Nguyen <xmphyr@gmail.com>


On Wed, Nov 18, 2026 at 12:03=E2=80=AFAM Andrew Nguyen <xmphyr@gmail.com> w=
rote:
>
> Added an additional check with -cpu host: that a hardware accelerator is
> enabled. The error message for when a hardware accelerator isn't used
> gives a list of supported hardware accelerators. This list is made more
> scalable in the form of a separate function that is substantially easier
> to find and append later down the line.
>
> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
> ---
>  include/system/hw_accel.h | 10 ++++++++++
>  target/i386/cpu.c         |  8 +++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
> index f0c10b6d80..04608073f7 100644
> --- a/include/system/hw_accel.h
> +++ b/include/system/hw_accel.h
> @@ -54,4 +54,14 @@ static inline bool hwaccel_enabled(void)
>          || whpx_enabled();
>  }
>
> +/**
> + * hwaccel_names:
> + *
> + * Returns: String of supported hardware accelerators.
> + */
> +static inline const char *hwaccel_names(void)
> +{
> +    return "kvm, hvf, whpx, or nvmm";
> +}
> +
>  #endif /* QEMU_HW_ACCEL_H */
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7dd5535f80..375a4453e4 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -25,6 +25,7 @@
>  #include "cpu.h"
>  #include "tcg/helper-tcg.h"
>  #include "exec/translation-block.h"
> +#include "system/hw_accel.h"
>  #include "system/hvf.h"
>  #include "system/mshv.h"
>  #include "system/whpx.h"
> @@ -10227,10 +10228,11 @@ static void x86_cpu_realizefn(DeviceState *dev,=
 Error **errp)
>          return;
>      }
>
> -    if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
> +    if (xcc->host_cpuid_required && (!accel_uses_host_cpuid() ||
> +        !hwaccel_enabled())) {
>          g_autofree char *name =3D x86_cpu_class_get_model_name(xcc);
> -        error_setg(&local_err, "The '%s' CPU type can only be used with =
KVM,
> -            HVF or WHPX", name);
> +        error_setg(&local_err, "The '%s' CPU type can only be used with =
"
> +            "hardware accelerators %s.", name, hwaccel_names());
>          goto out;
>      }
>
>
> --
> 2.43.0
>

