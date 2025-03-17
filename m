Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36876C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuG51-0005UB-Pk; Mon, 17 Mar 2025 15:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuG4y-0005Tc-66
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:24:52 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuG4w-0007vQ-4N
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 15:24:51 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-476977848c4so49504231cf.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 12:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742239489; x=1742844289; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ALJAimVc90FRvPKACXq4mcDHRb+hXrw9oeNrL92qMhw=;
 b=fEMgk2APIdpW4lGzy1Hj9Zju0tlBdCAcDCBnsxWTxxDFqYTNyGvik9q/Ryp8Fg+Ct2
 oLH4sZwdjkK2nFW1XE9ZZbpehBVQwJztt74wTNEXZMxRdvqmkNV1CTTlGYItM+9WMns0
 CbXI8dkS5Gr2uWSJNog6n3Ti/VvHSo3iyRfMe+j3vVwLKlDYUZv1X3RSmr2I+2XLR2pE
 rbC2ZWcwh0zCspMQ4bbmSnmRl9x+Mdde1txe1TJP2PQ+V9vPSwGh22nJhWg54UbH5+k8
 GtzY7KkKz42E3JWrmfZoAVL4RGEwA8GgLq4P0wCiB7dZ5ynWWblX4Jvw+B7eQKsME0vX
 r2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742239489; x=1742844289;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ALJAimVc90FRvPKACXq4mcDHRb+hXrw9oeNrL92qMhw=;
 b=Frs8TMVaWZaOItoL7EeWtOsxLaPxdMuXVTPaoJDFa/KMMGiMwKuJI1tX39RkLeDtvp
 0VE15xaCeg4HawCk5B6GfOysBOmMAvapg82GrKQGcvV35LjrO9a15ykVYnHBKGLAhYxy
 /0K/es1OyxnI0fodwvb+P/jT6AyNWkZ7OMdUdWCcj3Zo9AEQGAlU4PGQTfWwmP28Fbl2
 M0kUS7KWXvw/BEh0K/1L3UXy8tMEg+62h9J0rVaCq1QxAwihH/nq1WzIIHoO06sRJ10j
 CQQqSDs0rxCWN2YWn131QcCVG35RUdUEcyLvc8xWY4RMCtkzPgt4/Ngj0uQjgDiIiswH
 jtIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWybgvGIEyJlQXRrx+SeTlT4DDNBRUT8IsCUd1OBNzQkqnQh36HJcsw+COrR9bC0D/SKsiSy31cLEb@nongnu.org
X-Gm-Message-State: AOJu0YzBAFdb9C23wULaCu5OG7qOehpOjdNN5sNQtt2pvfjOKglGQtg7
 t2KNy2bJxyZAH03u7MNEv76jdKRKAZl1KIyEYmnd9q7wmhSL2XYC
X-Gm-Gg: ASbGnctm4RLEgAS0dyH/PUY/RrOuv9V3zBPC/sNvAciV5qSIYx6fA45kKz3vN+54so8
 WSdv8ssiNU9uRs81487LSdpdXmf3Ngkffi+r/YXBWPotiT/7WqQ29M6iE9uVLwT8CEYcGwHP6wb
 uThU2Tf6//YwSiFkidt53DdPAJJqDZqn33jq4Bbe8TTO/AjR3g0vdAAK78CHZ5ciAckUduPcbJM
 Zw51VsYRI/mSIkqveExyHB6Lx2LySKychd0qp6tklnM6SKwBDS6XWZOP7a1qy2i05NocW9/obYa
 3YIvCGGYJGj1d78HriBC+aH69Ne0Q8RGf7Bl6aVxuu4nVDcL0ZPCBEijwxUxOVg=
X-Google-Smtp-Source: AGHT+IEATo2N3pNNP6wwMGoFj6SxFQoOuZDrgRqAIw5PKI14g8DBI8zUAMApLt9Y0H747zzWy/opNQ==
X-Received: by 2002:a05:622a:1448:b0:476:75d0:dbed with SMTP id
 d75a77b69052e-476c81ede6emr178001471cf.44.1742239488731; 
 Mon, 17 Mar 2025 12:24:48 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:3131:60d1:4874:e2c7])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f3d5fsm57297451cf.62.2025.03.17.12.24.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Mar 2025 12:24:48 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-11-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-11-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 10/39] target/hexagon: Implement arch_{s, g}et_{thread,
 system}_reg()
Date: Mon, 17 Mar 2025 14:24:46 -0500
Message-ID: <017c01db9772$3f31b610$bd952230$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQIr/MVfsvDT9eA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250317-4, 3/17/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x832.google.com
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:28 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 10/39] target/hexagon: Implement
> arch_{s,g}et_{thread,system}_reg()
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.h | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/hexagon/cpu_helper.h b/target/hexagon/cpu_helper.h
> index e8d89d8526..1cdf4f8dd0 100644
> --- a/target/hexagon/cpu_helper.h
> +++ b/target/hexagon/cpu_helper.h
> @@ -26,20 +26,27 @@ static inline void
> arch_set_thread_reg(CPUHexagonState *env, uint32_t reg,
>                                         uint32_t val)  {
>      g_assert(reg < TOTAL_PER_THREAD_REGS);
> -    g_assert_not_reached();
> +    env->gpr[reg] =3D val;

Gotta be careful here.  Not all registers can be assigned directly.  =
Look at gen_write_ctrl_reg in genptr.c.

>  }
>=20
>  static inline uint32_t arch_get_thread_reg(CPUHexagonState *env, =
uint32_t
> reg)  {
>      g_assert(reg < TOTAL_PER_THREAD_REGS);
> -    g_assert_not_reached();
> +    return env->gpr[reg];

Ditto - look at gen_read_ctrl_reg in genptr.c

>  }
>=20
> +#ifndef CONFIG_USER_ONLY
>  static inline void arch_set_system_reg(CPUHexagonState *env, uint32_t
> reg,
>                                         uint32_t val)  {
> -    g_assert_not_reached();
> +    g_assert(reg < NUM_SREGS);
> +    if (reg < HEX_SREG_GLB_START) {
> +        env->t_sreg[reg] =3D val;
> +    } else {
> +        env->g_sreg[reg] =3D val;
> +    }

Be careful here too.  Look at gen_log_sreg_write.

>  }
> +#endif
>=20
>  uint32_t arch_get_system_reg(CPUHexagonState *env, uint32_t reg);

Honestly, consider getting rid of these.  All the uses are a specific =
register number, so there's no benefit of things like g_assert(reg < =
TOTAL_PER_THREAD_REGS) or reg < HEX_SREG_GLB_START.  Also, keeping them =
runs the risk of not having all the proper checks inside.



