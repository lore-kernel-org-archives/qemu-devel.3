Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F0FC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkaB-0003M8-9i; Tue, 16 Jul 2024 11:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTkZz-0002hr-9d
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:59:04 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sTkZu-00081X-7v
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:59:02 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a77c080b521so606808066b.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721145533; x=1721750333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EGMgzTpfMVZQJdw7JKV9s9tLpOelb413fiZFpq7MqHM=;
 b=YkkntWpjjI2T+qYBu7D1WNlDhdGwQmL2fq9+HYIHo5FvVmdG62RvQlu/dt7vQdWIBT
 bwmZqltsu+768Xb2dcwykcnp0/0CSxy7n0o7jb8QvTJ2ezmuUu4XhKhtRWS4+xoZxJGY
 HEAtkMpHOvdHVVcNsM/oLCYdyyhNO5DJ9yhPmRwyfZt1hmdhOXMfkvQaRu+6WzPSCcgC
 1orYoXJ3v9BlteeFSg3tSNAzd0Mplzr+rOHjIKvzIuhtdPYYb3ptPhVI/lP7K4CLrR8L
 ArDAyXOWvOXnWl+SiGPV9Mezrcg3sY58QXSUcMBJFcFoIQ/hCgXMGMxqvmrwLEmnJTFS
 q41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721145533; x=1721750333;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGMgzTpfMVZQJdw7JKV9s9tLpOelb413fiZFpq7MqHM=;
 b=VGoaC1/kXjlpaqZCoR+Giig4LmTqfEwLdKiYuuWVOLgVPyAnk/UZ9IhdE95Pwvs7U7
 sz3CtkOa6cDH+Tuq1ruT/B5WgNdi+uauUETree0gQRljeSwiAWj0kugmqxJ1O57eaIaC
 J8IpDFshI2yKiFUm3z7ZDdEr826n6OXEHF8IkyN8t6qx7sWGZJObVpDEf/DauibX0QPd
 Hxtv5QVoFT7hxPC1jea3KR71pAj6zTste0H/cphegbZHv3it9OK3T7mezD9ATs2brjmD
 V9Sgzg2yQxCrKWYFf0xQtqLtLNRae+cT2DlOoHmQavFHnniX8WBV670tq8yjbe8so3dG
 KTug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsb1yfvE06AMFvr06vO+x3m0SGN06tVu0PDIPDlZ4nCDn0p/eB9kzOXYdjBGvcr26tNTygbZ/6PuV3eBl9nZwCVqUICZg=
X-Gm-Message-State: AOJu0YyIbSB31NNb5m3UnHS69LSmTDuzS4zejgJYB8TdVqflWE0JYg4D
 AamHei9fFvwBSIon/zL2GLXIZP5/K4PyWzaEyWOKGI1/fsDs6+1evHA6hTR+TuM=
X-Google-Smtp-Source: AGHT+IH0F83ZBkxZScIg7HOe//hXAvrzMvFG8ifYxSOATlPmpeoTHINGGBL/JmRX8Uzoq87nXCCb7w==
X-Received: by 2002:a17:906:7c44:b0:a77:cad0:5a92 with SMTP id
 a640c23a62f3a-a79ea4367a8mr181106666b.24.1721145533058; 
 Tue, 16 Jul 2024 08:58:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5a3a3bsm333303766b.34.2024.07.16.08.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 08:58:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7C7885F7A0;
 Tue, 16 Jul 2024 16:58:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] cpu: Free queued CPU work
In-Reply-To: <20240714-cpu-v1-1-19c2f8de2055@daynix.com> (Akihiko Odaki's
 message of "Sun, 14 Jul 2024 19:46:52 +0900")
References: <20240714-cpu-v1-1-19c2f8de2055@daynix.com>
Date: Tue, 16 Jul 2024 16:58:51 +0100
Message-ID: <87h6cpgwg4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Running qemu-system-aarch64 -M virt -nographic and terminating it will
> result in a LeakSanitizer error due to remaining queued CPU work so
> free it.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

FWIW this is likely the queued async task that
qemu_plugin_vcpu_init_hook sets up on the fake CPU -M virt creates at:

        /*
         * Instantiate a temporary CPU object to find out about what
         * we are about to deal with. Once this is done, get rid of
         * the object.
         */
        cpuobj =3D object_new(possible_cpus->cpus[0].type);
        armcpu =3D ARM_CPU(cpuobj);

        pa_bits =3D arm_pamax(armcpu);

        object_unref(cpuobj);

Anyway:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  include/hw/core/cpu.h |  6 ++++++
>  cpu-common.c          | 11 +++++++++++
>  hw/core/cpu-common.c  |  1 +
>  3 files changed, 18 insertions(+)
>
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index a2c8536943f7..8e6466c1ddab 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1000,6 +1000,12 @@ void cpu_resume(CPUState *cpu);
>   */
>  void cpu_remove_sync(CPUState *cpu);
>=20=20
> +/**
> + * free_queued_cpu_work() - free all items on CPU work queue
> + * @cpu: The CPU which work queue to free.
> + */
> +void free_queued_cpu_work(CPUState *cpu);
> +
>  /**
>   * process_queued_cpu_work() - process all items on CPU work queue
>   * @cpu: The CPU which work queue to process.
> diff --git a/cpu-common.c b/cpu-common.c
> index ce78273af597..7ae136f98ca7 100644
> --- a/cpu-common.c
> +++ b/cpu-common.c
> @@ -331,6 +331,17 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu=
_func func,
>      queue_work_on_cpu(cpu, wi);
>  }
>=20=20
> +void free_queued_cpu_work(CPUState *cpu)
> +{
> +    while (!QSIMPLEQ_EMPTY(&cpu->work_list)) {
> +        struct qemu_work_item *wi =3D QSIMPLEQ_FIRST(&cpu->work_list);
> +        QSIMPLEQ_REMOVE_HEAD(&cpu->work_list, node);
> +        if (wi->free) {
> +            g_free(wi);
> +        }
> +    }
> +}
> +
>  void process_queued_cpu_work(CPUState *cpu)
>  {
>      struct qemu_work_item *wi;
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index b19e1fdacf22..d2e3e4570ab7 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -281,6 +281,7 @@ static void cpu_common_finalize(Object *obj)
>          g_free(cpu->plugin_state);
>      }
>  #endif
> +    free_queued_cpu_work(cpu);
>      g_array_free(cpu->gdb_regs, TRUE);
>      qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
>      qemu_mutex_destroy(&cpu->work_mutex);
>
> ---
> base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
> change-id: 20240714-cpu-c4d28823b4c2
>
> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

