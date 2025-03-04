Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08001C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 23:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpbOn-0006zZ-6x; Tue, 04 Mar 2025 18:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tpbOg-0006xZ-SK
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:10:00 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tpbOe-0003Rj-Jg
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 18:09:58 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c3b63dfee1so313732585a.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 15:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741129795; x=1741734595; darn=nongnu.org;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+XSagkrtLIWWUgQ7VWsJ/ZzaGqlQpej4VwkzfrXlF0Y=;
 b=SAyBG3ob0Td/oY7r/kHg1vbjKR5VCxqxaPx8hnYP/I2u+K9cDoTmGGgz891jS3V3Ha
 LQUGaREtGDqUNO8JOczK5mweTpFNunYVvjfvy7j64x6QF1vYIDXWdr2KMvvkNEp4g4y8
 ftY4e/0ke885X6Vj+f7X0fqDXP0s3ZsyMnO2fTQJtd9t+TZr06fw7KXE+Mn8Rj+hPjvl
 4gSBeD4CRUU67dT8KDlN6grwKBS2BbQc/eMCPitpyYGQmH6UlSddCMkPWtTBwKkl7Nb0
 micAdtq1mvzafEjpFX3mYKwuTXTLzdqYqtmSv6T+yAqL50jHX3yLWia5mjr+k1efwBiY
 cyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741129795; x=1741734595;
 h=thread-index:content-language:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+XSagkrtLIWWUgQ7VWsJ/ZzaGqlQpej4VwkzfrXlF0Y=;
 b=Wms3oMFCWz3myyV7vqqFik2KWoQbxGmg8FWdy63pbU550n/oILkOOSsK8L9c1jPV9u
 DN8TaT7yh4XYdjaKM4TPOKSLzVYUbk4g1R86qBv/O4nuD9M8alCrM8IV2X2GaoqUShA2
 RtICLBcuj0X0kO5eug6OAvZGIl+RuUarOFKtbdhs0SnMw7kA61psp0D2987MqRhhY30W
 6hOuqsGcY7NRjLLWTLqY+ARyCj2gLMO/eRn8+OJg8euTJPVZBP6e1OsonjxymXVqSWnE
 JXA0DXxdIacX8duhxyJGMaFPA/tJcWzr4fky0sWRyB0moNp9dCQE4IC9X3CIDECwyDgz
 ClkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV54rC5U1OHzodtoEomL8Oj4TWFy1g8NR1zKRgY3wpHqqAvrkvSHNwdZC5+YVY1oc6pnhtmT00hfEha@nongnu.org
X-Gm-Message-State: AOJu0Yw/v2qlNDhkuoAk2wpeD0RmS/AvI+qtr5JmZFXVFh+aSpsmcnNO
 5Ba+c1Q7N9dH4AwdIbo2ZTE5JFzTvPGMn/Vgnq7RLgBz75y2VnZW
X-Gm-Gg: ASbGncuLstK9PW16Kk/GwrBvpLX+KNql5IgFDhz5eHkWr1aipZ+++LTy9Ip77SXChxL
 jBDMwYr9ELFTMR0gp05E/cIGfUcGqXaxcG7Wdo+qB2P+HpwMDsQu1cW6GMK2JmsZk5XH+Ypn27u
 Lm7/iZhQkhPj2kt1zERXHJCvgKriqceabdJAjW4kwpiJ/Rb8r149bL9RU0qJqSuOemSXS4hMoie
 yoD3MyszNwytSevGUt52o4TY57Yp3Y90KvNMGBOjobiv+V6UdRbMielbwjTSr9JATSV8h11Rwaj
 2FagBXV7LIgiUZEEQMmTRfhyRnuuuupvCyCCaPvTf7TayKJXMwLJ3rSulrhVlQCfDMij2lmP6co
 WcU0NE/g=
X-Google-Smtp-Source: AGHT+IGBZj8S74FApcP94/DLdVU4DoeznXNw5G6M7gFS7haBaVrgY26gt+VRZM9XOBoXfjtVCnr8zw==
X-Received: by 2002:a05:6214:230a:b0:6d8:f0ba:ea92 with SMTP id
 6a1803df08f44-6e8e6d5ed83mr17629286d6.21.1741129794743; 
 Tue, 04 Mar 2025 15:09:54 -0800 (PST)
Received: from DESKTOPUU50BPD (syn-174-097-131-055.res.spectrum.com.
 [174.97.131.55]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e897634c3dsm71939996d6.1.2025.03.04.15.09.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Mar 2025 15:09:54 -0800 (PST)
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
 <3329ec67-3bf3-425d-b15c-ba77cd8bcd30@oss.qualcomm.com>
In-Reply-To: <3329ec67-3bf3-425d-b15c-ba77cd8bcd30@oss.qualcomm.com>
Subject: RE: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
Date: Tue, 4 Mar 2025 17:09:50 -0600
Message-ID: <014701db8d5a$8a1ad930$9e508b90$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQLrtTt/AcPvtViyyI+gUA==
X-Antivirus: Norton (VPS 250304-10, 3/4/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x732.google.com
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
> Sent: Monday, March 3, 2025 10:24 AM
> To: qemu-devel@nongnu.org
> Cc: richard.henderson@linaro.org; philmd@linaro.org;
> quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: Re: [PATCH 34/39] target/hexagon: Add TLB, k0 {un,}lock
>=20
>=20
> On 2/28/2025 11:28 PM, Brian Cain wrote:
> > From: Brian Cain <bcain@quicinc.com>
> >
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >   target/hexagon/sys_macros.h |   8 +--
> >   target/hexagon/op_helper.c  | 104
> ++++++++++++++++++++++++++++++++++++
> >   2 files changed, 108 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/hexagon/sys_macros.h =
b/target/hexagon/sys_macros.h
> > index 3c4c3c7aa5..e5dc1ce0ab 100644
> > --- a/target/hexagon/sys_macros.h
> > +++ b/target/hexagon/sys_macros.h
> > @@ -143,11 +143,11 @@
> >   #define fDCINVIDX(REG)
> >   #define fDCINVA(REG) do { REG =3D REG; } while (0) /* Nothing to =
do in
> > qemu */
> >
> > -#define fSET_TLB_LOCK()       g_assert_not_reached()
> > -#define fCLEAR_TLB_LOCK()     g_assert_not_reached()
> > +#define fSET_TLB_LOCK()       hex_tlb_lock(env);
> > +#define fCLEAR_TLB_LOCK()     hex_tlb_unlock(env);
> >
> > -#define fSET_K0_LOCK()        g_assert_not_reached()
> > -#define fCLEAR_K0_LOCK()      g_assert_not_reached()
> > +#define fSET_K0_LOCK()        hex_k0_lock(env);
> > +#define fCLEAR_K0_LOCK()      hex_k0_unlock(env);
> >
> >   #define fTLB_IDXMASK(INDEX) \
> >       ((INDEX) & (fPOW2_ROUNDUP(fCAST4u(env_archcpu(env)-
> >num_tlbs)) -
> > 1)) diff --git a/target/hexagon/op_helper.c
> > b/target/hexagon/op_helper.c index 702c3dd3c6..f3b14fbf58 100644
> > --- a/target/hexagon/op_helper.c
> > +++ b/target/hexagon/op_helper.c
> > @@ -1184,6 +1184,110 @@ void HELPER(modify_ssr)(CPUHexagonState
> *env, uint32_t new, uint32_t old)
> >       BQL_LOCK_GUARD();
> >       hexagon_modify_ssr(env, new, old);
> >   }
> > +
> > +static void hex_k0_lock(CPUHexagonState *env) {
> > +    BQL_LOCK_GUARD();
> > +    g_assert((env->k0_lock_count =3D=3D 0) || (env->k0_lock_count =
=3D=3D 1));
> > +
> > +    uint32_t syscfg =3D arch_get_system_reg(env, HEX_SREG_SYSCFG);

Minor nit - registers should be target_ulong type.

> > +    if (GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg)) {
> > +        if (env->k0_lock_state =3D=3D HEX_LOCK_QUEUED) {

Are HEX_LOCK_* defined in an earlier patch in this series.  Can we move =
the definitions here?

> > +            env->next_PC +=3D 4;
> > +            env->k0_lock_count++;
> > +            env->k0_lock_state =3D HEX_LOCK_OWNER;
> > +            SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);
> > +            return;
> > +        }
> > +        if (env->k0_lock_state =3D=3D HEX_LOCK_OWNER) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "Double k0lock at PC: 0x%x, thread may =
hang\n",
> > +                          env->next_PC);
> > +            env->next_PC +=3D 4;
> > +            CPUState *cs =3D env_cpu(env);
> > +            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> > +            return;
> > +        }
> > +        env->k0_lock_state =3D HEX_LOCK_WAITING;
> > +        CPUState *cs =3D env_cpu(env);
> > +        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
> > +    } else {
> > +        env->next_PC +=3D 4;
> > +        env->k0_lock_count++;
> > +        env->k0_lock_state =3D HEX_LOCK_OWNER;
> > +        SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 1);
> > +    }
> > +
> > +}
>=20
> This was discussed previously at
> https://lore.kernel.org/qemu-
> devel/CH3PR02MB102479550F96F09E0C9D50BA7B87B2@CH3PR02MB10247.n
> amprd02.prod.outlook.com/
>=20
> We have taken some but not all of the suggestions from then.  One of =
our
> concerns is regarding an architectural requirement for "fairness" with =
regards
> to picking the hardware thread to be selected to pass the lock to.  If =
we
> unleash the thundering herd, does this just mean that the fairness is
> dependent on the host scheduler design / configuration?
>=20
> Also - I note that we didn't take the suggestions regarding =
cpu_loop_exit /
> cpu_loop_exit_restore.  That was an oversight, the next revision will =
include
> that update.
>=20
> > +
> > +static void hex_k0_unlock(CPUHexagonState *env) {
> > +    BQL_LOCK_GUARD();
> > +    g_assert((env->k0_lock_count =3D=3D 0) || (env->k0_lock_count =
=3D=3D 1));
> > +
> > +    /* Nothing to do if the k0 isn't locked by this thread */
> > +    uint32_t syscfg =3D arch_get_system_reg(env, HEX_SREG_SYSCFG);

target_ulong

> > +    if ((GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg) =3D=3D 0) ||
> > +        (env->k0_lock_state !=3D HEX_LOCK_OWNER)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "thread %d attempted to unlock k0 without =
having the "
> > +                      "lock, k0_lock state =3D %d, syscfg:k0 =3D =
%d\n",
> > +                      env->threadId, env->k0_lock_state,
> > +                      GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg));
> > +        g_assert(env->k0_lock_state !=3D HEX_LOCK_WAITING);
> > +        return;
> > +    }
> > +
> > +    env->k0_lock_count--;
> > +    env->k0_lock_state =3D HEX_LOCK_UNLOCKED;
> > +    SET_SYSCFG_FIELD(env, SYSCFG_K0LOCK, 0);
> > +
> > +    /* Look for a thread to unlock */
> > +    unsigned int this_threadId =3D env->threadId;
> > +    CPUHexagonState *unlock_thread =3D NULL;
> > +    CPUState *cs;
> > +    CPU_FOREACH(cs) {
> > +        CPUHexagonState *thread =3D cpu_env(cs);
> > +
> > +        /*
> > +         * The hardware implements round-robin fairness, so we look =
for
> threads
> > +         * starting at env->threadId + 1 and incrementing modulo =
the number
> of
> > +         * threads.
> > +         *
> > +         * To implement this, we check if thread is a earlier in =
the modulo
> > +         * sequence than unlock_thread.
> > +         *     if unlock thread is higher than this thread
> > +         *         thread must be between this thread and =
unlock_thread
> > +         *     else
> > +         *         thread higher than this thread is ahead of =
unlock_thread
> > +         *         thread must be lower then unlock thread
> > +         */
> > +        if (thread->k0_lock_state =3D=3D HEX_LOCK_WAITING) {
> > +            if (!unlock_thread) {
> > +                unlock_thread =3D thread;
> > +            } else if (unlock_thread->threadId > this_threadId) {
> > +                if (this_threadId < thread->threadId &&
> > +                    thread->threadId < unlock_thread->threadId) {
> > +                    unlock_thread =3D thread;
> > +                }
> > +            } else {
> > +                if (thread->threadId > this_threadId) {
> > +                    unlock_thread =3D thread;
> > +                }
> > +                if (thread->threadId < unlock_thread->threadId) {
> > +                    unlock_thread =3D thread;
> > +                }
> > +            }
> > +        }
> > +    }
> > +    if (unlock_thread) {
> > +        cs =3D env_cpu(unlock_thread);
> > +        unlock_thread->k0_lock_state =3D HEX_LOCK_QUEUED;
> > +        SET_SYSCFG_FIELD(unlock_thread, SYSCFG_K0LOCK, 1);
> > +        cpu_interrupt(cs, CPU_INTERRUPT_K0_UNLOCK);
> > +    }
> > +
> > +}
> >   #endif
> >
> >


