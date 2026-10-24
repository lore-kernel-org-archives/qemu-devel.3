Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250BF606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DaKHbzhR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKhvs-0001Je-9T; Sat, 24 Oct 2026 16:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xKhvk-0001Ix-OG
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 16:01:29 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xKhvj-0004tN-53
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 16:01:28 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b4213059d4so1859010a12.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 13:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792872085; cv=none;
 d=google.com; s=arc-20260327;
 b=A/upQc9j4jogG2j807rsi3nCkbMKhG8+nTTzGyS7H3OJOy+RVvNZZE8/0VgIafTccQ
 jRa8Cr81kJchDnWKeX3Bp1XKIHrVlN1NeuqckRq2ZCZN/Pk9H87fUvFriRP/HLwZkoNn
 VTvgCG8j3xYw6003/vNZR9l/+V+uGmQ7Xvg7cs/hdyWyWDZwvqnDsMdfN9Pyd2lpSW5e
 GRC/TNiLprHVt+njc/ZQGNx1E5PPIdU2CaaaFg8DO83QhXwrD5pQ7/R6ohR0ddpXWFQv
 hXCD8Rq5uTgnYMqRLaXcblWBSHdMOznRdtOJR9xCJeQKrFiVYUboBfh2EPAnK8R97jNc
 CmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=lp4tL382CP3l0gsgtbCkJF59mcXtxp4UwBdfRj5dEdI=;
 fh=ynMZpoLdc8EcguBEfEqlF67vL8jpBgF8ghejmEGS7cY=;
 b=gTE2JTxK7qQcJiXc6Ab9fCn1nEHsammo0ZVbFhtxm/g0ghVb+JzW2UIr1qzUbNpD3U
 sk/oHDpEZtdsQByDt75JRm2pFfhv2HfduoKvZr8Dy92EBfPZl0kqRMg40cf2Au3BHqPx
 0P39oNrc3awF0AzLG180RpU6GR9TEdlgRUZIrK4qWwyHfqmbJUZYhzki599g4MS17oRW
 GA+HQXYCMpyDD1zDfR3inrlgQspPXq/QhflXipx/TTYXVoyzf/1NKRzYltMVdQg9/1di
 tFPfZh7Fg5L45ER4oruCK49ul+5rqIxTwwFjAsA91SbMLOTE3mmRDvz9xtNwjFpBq6cR
 F2ug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792872085; x=1793476885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lp4tL382CP3l0gsgtbCkJF59mcXtxp4UwBdfRj5dEdI=;
 b=DaKHbzhRSrAsdFZPmWS7XxA/gW2E+4O3Na25/W+EJAm712WN5T18ClwG8RuGGLTaC9
 gQ2KirnmBF6LpElQSRwl3myB8FFBtfAXCW+K0XmQnJTGDXS5Zhu2QhaCiGtwGVZWvtHs
 qrOyZJIPsMGfQEnOf6McH+q0ICj2MS+mKfZ7rMCYQ0KfWmAqBfMTPXKuZietI2xeDAR0
 Z9hnI12mIpHwRTTNKUfJqR7uJeD/AfBRzeLjHoeN5ucwplBqeZv9ODFmbRR9W0QyEWHn
 pN+uPMvKAbocS+AkhN9cg7MDA/6a8upGt0O5nd3zZvwtPHM13msbcm4TcGdi1jgfeNbr
 9TzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792872085; x=1793476885;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lp4tL382CP3l0gsgtbCkJF59mcXtxp4UwBdfRj5dEdI=;
 b=ze/7UkbD+MppzjWnx7a2sWK32XGQt7xMuz/QFwgCCTptJE4dVTWORWAeWD/coEqCRp
 DFKWi+SxTp3skj/ijIlCTYnxakcZ9rxM72BHRMwrU383AcRbOmcp1R9Jr+sve8tEPONl
 Gn/tYLI4e61QRDVF9KwUAu6fOqHJ3OOhWjVHtV97VuEYAOhIWN/UjmYum7H1oYYXX9ic
 0uI0kEM+ZqsbuPFZSY2fV3AChrzi4+9+ogDbyX6WqNz2pxnQVnBLsH2ce2fajxaWVbGc
 f0bubt+VcIDbni4erDaXcwMQcIqNRcd84F7MSj2E9AhhCj1GQsTlv3IYB6ktImE6Ykhl
 5NDw==
X-Gm-Message-State: AFq9FYKgiYts7uVy0zPfnmVm5SKXwubzLWtb1yxedgza7nn4AXpy/72z
 8N8Oh5cBp/Z8J3/w8g3lDOJ+ZPwA52KM2b8EsVgoPHURPNDL62zLDwTknkm46mPAi5EsB5mYQ7D
 L9ioMutQ6erZz7EaTYgEaK0JEExzL3Dw=
X-Gm-Gg: AYBFou38bIS0NmYpij374A7UdsDwhl+DhE9WeBGhThFwgpTvFGsbt9jyRvEzMSX00yj
 lY/mWKUVkZwYb/vIpBoXadU8F21wr2WK2o/TDHuisTt6uHf4epGYKFi62Mlsw2tiC9Qe4dTBI1k
 xmFY8VUxLX7YEk7TuXt2s8aPDH7davO22zbGuay3gMTcx3J61YfwhxgSN0YUbZV6dzjb8QrQejj
 FUldZDrCZ0dEb++J7qvWjiSoIhpgHN7QF5I42RbtVlbviJkIJBcLo02ycTCW7l0fWSf+aqeJQRj
 PL4g+gMyN2nvsza2ZOX6KL7Eyk1wb19LuW6g7Iw7kbAUZgnnMJ9V/LvKWcZ7GDK6N8yrhYhnVPJ
 m/LIpVXOiRRnLYZ71H2L8xgaZuM1lI8+wHTMe
X-Received: by 2002:a05:6402:2742:b0:6b4:43e6:6b28 with SMTP id
 4fb4d7f45d1cf-6b443e66c5emr3300585a12.35.1792872085132; Sat, 24 Oct 2026
 13:01:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
 <20261024173649.7405-19-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261024173649.7405-19-pierrick.bouvier@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sun, 25 Oct 2026 04:01:13 +0800
X-Gm-Features: AclHuK8Lkz91JVAu157h8HergqAZyli3pQquoNr9QIJLND-nzljP7F6AgP4mX9M
Message-ID: <CAE2XoE91maBskVqb=3XYgjQSAZ3t2=T51DWg01C0Xbs71oRBzg@mail.gmail.com>
Subject: Re: [PULL 18/20] target/riscv/kvm: restrict kvm-accel-riscv-cpu to
 riscv targets
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x535.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Pierrick

Sorry to bother, but this has not Review-By yet, is that reviewed by
others offline?


On Sun, Oct 25, 2026 at 1:38=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On riscv hosts:
> $ ./build/tests/unit/test-multi-target
> Type 'kvm-accel-riscv-cpu' is missing its parent 'accel-riscv-cpu'
> Aborted
>
> Parent type is conditionally registered from current target:
> register_accel_target_type uses '"accel-" + target_cpu_type()' as type
> name. Thus, accelerator specific cpu types must only be registered for
> riscv targets.
>
> Link: https://lore.kernel.org/qemu-devel/20261024061616.27381-8-pierrick.=
bouvier@oss.qualcomm.com
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 45ad5e1525a..f28d9115c82 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -26,6 +26,7 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/target-info.h"
>  #include "qapi/visitor.h"
>  #include "system/system.h"
>  #include "system/kvm.h"
> @@ -2208,6 +2209,7 @@ static const TypeInfo kvm_cpu_accel_type_info =3D {
>
>      .parent =3D TYPE_ACCEL_CPU,
>      .class_init =3D kvm_cpu_accel_class_init,
> +    .is_available =3D target_base_riscv,
>      .abstract =3D true,
>  };
>  static void kvm_cpu_accel_register_types(void)
> --
> 2.43.0
>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

