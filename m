Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACEBC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwoE-0004Xb-6O; Wed, 19 Mar 2025 13:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuwnD-0004Co-Nq
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:01:33 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuwnB-00074A-Jb
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:01:23 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-476b4c9faa2so85678611cf.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742403679; x=1743008479; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PWAFjDMDcXyHZiHAlt1wygQ1ttrWIFE6y4m7Vhg09p0=;
 b=ZmQXurzOce/5caDOQ9byVWoytVX/ssdSf8hjkHb1WAV4iBfCqje0FlJIvBPXOYTDn7
 LcnH0yBZu380ukL9S+hsdkLYRphULJKkXM2osrLKzlGTgbQaCq79FB4Zo6+P9L0Ol7Fm
 qSliHlz6ZPIOyCseGe71TV7zTTyS0JqYuTHFQJWsdz1DE6WGwgdch9hOsZv+1eV0P1zW
 nZ4z4q7UZN5fj6S9qPbGc6BkbISSDlZKJLs63MseokQ5EKLdlnhD4JyxrbaYl8OdPIaP
 uMIR9ddxTMeaShtZe5XM1iqOsUX94B4pq96ReWfVbUO8/xOreUwwxj+1qPwC1bSwRHee
 UOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742403679; x=1743008479;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PWAFjDMDcXyHZiHAlt1wygQ1ttrWIFE6y4m7Vhg09p0=;
 b=NJK8dSJeQnm8QRq7t6W7KkGdzsaRgJyjdlOp1iL6VS0IxmY6ixJcXHBuEv9nAat8vu
 y58jem/ufVbyuSS2K8fjSpVyxoJuzj5A5E1y9L01BM6NyZyTmBfJvGECg61cTgiWa/F/
 4rQinnDqKxClEFz8XX10HRapn2DIE8ljUMXJW0+PW1hKahWf9M8RAKCEynMzbJPmIcMl
 n081d/AFnbfUnCu3WQBPqdRQ9J7GagaAbKRs7Z4GqMlWUkvpTISHL2yhENzA0pZf1OiO
 giX/Tj/CokIidV8NfsTqq5nSALzfCNmQ/stm9uxkuEnI14xEWsnb+PGl8y1gs1rL1Noo
 7TgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbHJkILJjP7MEzkMmTmYW702daBo1UOL/pLSbSxmIj3bngykuHh34WlNij5TfKSlZ4FzI69bXtWcq/@nongnu.org
X-Gm-Message-State: AOJu0YwPTYNE5x1IGf3gnwOx2EeroQ895nMpx4qki/j6pJc6Pf4b2PLQ
 dU+j1EZineCjlXKjzPEn2lj77xZM84QJkRKrfekfIv4GHyaE3Zp2
X-Gm-Gg: ASbGncuh2G3A0IvEkmUvXlbtH5gkc+wnJKnQUpmVrPhKSy5ee+MGvgNOj89nUCv4VvW
 qy9vB5kb7B257IERpv8zQ/3X14hpKhYMA/73QCZnri9ay5vEwk7DniCbb0GluJKq4dhNNI0GETz
 DVOtkTuE/7C9i54bTT+NL9kg5w+iS+1kSyvsPJj4O/6fBLFqhKkWjFbZTHJrGrVynvHESwjTGB0
 JjAzN23ONRwDrJUKIPwGwRsqC25sLRzraV4D0WvzMjW6obXgZNF7cemlBBpH1BDBXD4mqJCaNfp
 2IjPYkC4LwlvLuQ0012yVO33jAx0jx/iNxX3HOgv3NlSmQtC6nzRTouHQF9iqg==
X-Google-Smtp-Source: AGHT+IEt9TL16mk/aLLXzvfpkyLdzTp72DjGt3yiWGUJ3TFxpYQbO8FsGu6s0TDJZwJpDaEE/VVg4w==
X-Received: by 2002:a05:622a:4d06:b0:476:923a:f1cb with SMTP id
 d75a77b69052e-47710dd5b54mr3046761cf.41.1742403679370; 
 Wed, 19 Mar 2025 10:01:19 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb63e688sm81104271cf.31.2025.03.19.10.01.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:01:18 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-35-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-35-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
Date: Wed, 19 Mar 2025 12:01:17 -0500
Message-ID: <02c001db98f0$888d82b0$99a88810$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQLrtTt/su3bbaA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x82c.google.com
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
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
>=20
> From: Brian Cain <bcain@quicinc.com>
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/sys_macros.h |   8 +--
>  target/hexagon/op_helper.c  | 104
> ++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/hexagon/sys_macros.h b/target/hexagon/sys_macros.h
> index 3c4c3c7aa5..e5dc1ce0ab 100644
> --- a/target/hexagon/sys_macros.h
> +++ b/target/hexagon/sys_macros.h
> @@ -143,11 +143,11 @@
>  #define fDCINVIDX(REG)
>  #define fDCINVA(REG) do { REG =3D REG; } while (0) /* Nothing to do =
in qemu
> */
>=20
> -#define fSET_TLB_LOCK()       g_assert_not_reached()
> -#define fCLEAR_TLB_LOCK()     g_assert_not_reached()
> +#define fSET_TLB_LOCK()       hex_tlb_lock(env);
> +#define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);

Move these to the patch that implements TLB lock/unlock.

>=20
> -#define fSET_K0_LOCK()        g_assert_not_reached()
> -#define fCLEAR_K0_LOCK()      g_assert_not_reached()
> +#define fSET_K0_LOCK()        hex_k0_lock(env);
> +#define fCLEAR_K0_LOCK()      hex_k0_unlock(env);
>=20
>  #define fTLB_IDXMASK(INDEX) \
>      ((INDEX) & (fPOW2_ROUNDUP(fCAST4u(env_archcpu(env)->num_tlbs)) -
> 1)) diff --git a/target/hexagon/op_helper.c =
b/target/hexagon/op_helper.c
> index 702c3dd3c6..f3b14fbf58 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -1184,6 +1184,110 @@ void HELPER(modify_ssr)(CPUHexagonState
> *env, uint32_t new, uint32_t old)
>      BQL_LOCK_GUARD();
>      hexagon_modify_ssr(env, new, old);
>  }
> +
> +static void hex_k0_lock(CPUHexagonState *env) {
> +    BQL_LOCK_GUARD();
> +    g_assert((env->k0_lock_count =3D=3D 0) || (env->k0_lock_count =
=3D=3D 1));
> +
> +    uint32_t syscfg =3D arch_get_system_reg(env, HEX_SREG_SYSCFG);
> +    if (GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg)) {
> +        if (env->k0_lock_state =3D=3D HEX_LOCK_QUEUED) {
> +            env->next_PC +=3D 4;
> +            env->k0_lock_count++;
> +            env->k0_lock_state =3D HEX_LOCK_OWNER;
> +            SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);
> +            return;
> +        }
> +        if (env->k0_lock_state =3D=3D HEX_LOCK_OWNER) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Double k0lock at PC: 0x%x, thread may =
hang\n",
> +                          env->next_PC);
> +            env->next_PC +=3D 4;
> +            CPUState *cs =3D env_cpu(env);

QEMU coding standards prefer to put declarations at the beginning of the =
code block (just after the open curly brace).

> +            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +            return;
> +        }
> +        env->k0_lock_state =3D HEX_LOCK_WAITING;
> +        CPUState *cs =3D env_cpu(env);

Ditto

> +        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> +    } else {
> +        env->next_PC +=3D 4;
> +        env->k0_lock_count++;
> +        env->k0_lock_state =3D HEX_LOCK_OWNER;
> +        SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);
> +    }
> +
> +}
> +
> +static void hex_k0_unlock(CPUHexagonState *env) {
> +    BQL_LOCK_GUARD();
> +    g_assert((env->k0_lock_count =3D=3D 0) || (env->k0_lock_count =
=3D=3D 1));
> +
> +    /* Nothing to do if the k0 isn't locked by this thread */
> +    uint32_t syscfg =3D arch_get_system_reg(env, HEX_SREG_SYSCFG);
> +    if ((GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg) =3D=3D 0) ||
> +        (env->k0_lock_state !=3D HEX_LOCK_OWNER)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "thread %d attempted to unlock k0 without =
having the "
> +                      "lock, k0_lock state =3D %d, syscfg:k0 =3D =
%d\n",
> +                      env->threadId, env->k0_lock_state,
> +                      GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg));
> +        g_assert(env->k0_lock_state !=3D HEX_LOCK_WAITING);
> +        return;
> +    }
> +
> +    env->k0_lock_count--;
> +    env->k0_lock_state =3D HEX_LOCK_UNLOCKED;
> +    SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 0);
> +
> +    /* Look for a thread to unlock */
> +    unsigned int this_threadId =3D env->threadId;
> +    CPUHexagonState *unlock_thread =3D NULL;
> +    CPUState *cs;

Ditto

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



