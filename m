Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A34CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 21:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPSGA-0004z0-1n; Tue, 19 May 2026 17:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPSG3-0004y0-VN
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:45:51 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPSG2-00037u-4m
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:45:47 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so2931791f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779227142; x=1779831942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aybs5KJEwNcTuSr7ZUAmGn6pX+YzIrCrn+R7PFXXGBk=;
 b=GZi1To4wMHi1kx/DC1pVicERHa7ovOU2UniczD4z3DTEg4HrZGu/u0MYPd6RX6Gr/f
 fKe45fdsvMvay141At0QFcpLUl5v4CiVBhEkQ8rGczG5yW0VPwuYwyMSi64KazutmTjR
 nQiopTC1oedpmFq+XGLjaanT9lIuKVI+KbzEy0R3DsNwlAZySEH4QgrU5bku21xT0iNp
 g104tGBE6Vr2pSqmow1WZCbTfmlTdR0b6mx/jWckFnkkYYAddmLR0A2/jlkJOU4h5hFp
 19tH0+iz+PQPWQyoWEuf6ZpMTnsWptfVFTCNXctmqfdr6XfaN2unZhYbF/CSpOeQUiJ7
 8FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779227142; x=1779831942;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aybs5KJEwNcTuSr7ZUAmGn6pX+YzIrCrn+R7PFXXGBk=;
 b=JM8IAERYLzir19fu6c3uBwg3dR97u99Mk/VFGFd3WDrPNQ3foaq7fUDU85igGceqyr
 f7qyfTb7XxZwUEKdfhpQ1Qd1Gu5pxbXryR2fTDYsyV8w81Y/E/1L1kboXngDzqqAUpuk
 9bSknUCVzvAxkxguAbii9mbwDRlhBwK1EwVyMAQkIBMdJb/u8Cab7AdQMinlWRMOqhDp
 TfuEB0WYCkirdqC8Wipm50M3humTNHxUQv4kdQGAJy4o2o/THL+KAKr2Hz7FfWvQZ9Q5
 xNC5mQTr94ifREjzqPGBAjR+Kh9fmOdIBKPGh4AnDSn7tPBvrnljrIacn7Qc7UFeGGfz
 S1qA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oSK27i/dgrHneZokMC6v+RK++xKgkNtpTXl+CUD1S8SgJ7mRtqBddK4EMJuSL3KjfBl1l8AHGWfGK@nongnu.org
X-Gm-Message-State: AOJu0YxYI49Rh6cBkoQUrpL0Bep1I5KoP+zHMloRXvJ0ko4Qsi53V0Wf
 mOQIddhocZy5+xQ3SMxvvHRgl2fJQc8Hk7semDiKzjc7w509FqtFSkEJv8wRhBlnmIM=
X-Gm-Gg: Acq92OHb7GbYtrx86lQSuprxux1VeDfXMIWsFqi/UVeYF9OaOeOFzps1lg2gbMUCK+t
 bAMnDHFBcum/VfoK6JNvpYB22z5RpcZBCS1Knu0DYOJOghqy7gcl2GBuuRvMUKU4mOU7XUJM0Sv
 BeIU+E1AoO42KAGQdgrIKoiKIosbTKyJBzrUWWmEex/YLtM54jgwnPj5Ph1Yu5fWRFk2aiAkL/D
 h3i+JAYujLgJLDKOAjceUf4hV3hWhG8D4qLxsydSi24/jL/JnwUABjCqg6g8CHC0R8xEYgRdf+U
 VQ3wEPtPtUvYJHoLWI+8EtqV5Z40/3ENak0LxTHBC6QC7xdjVXA90YvpyqY+X0orCFFKxs1M/q2
 hIAX2bHfAKZWDFSAzrUoTJPotAwEVS9NCqvNrGSGP6Q0TNQbi7GsbtQEdTQRySzj+7Tkpwjerz+
 Sefd84UdEy51/nCpNFfSA+NS4J6VmHILMatodI4mGOT1jzq9CyyrUCtqFzuNmkNFrpxA==
X-Received: by 2002:a05:6000:1a8e:b0:441:202e:3d2d with SMTP id
 ffacd0b85a97d-45e5c59a3fbmr33149995f8f.19.1779227142429; 
 Tue, 19 May 2026 14:45:42 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed30110sm52775931f8f.13.2026.05.19.14.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 14:45:41 -0700 (PDT)
Message-ID: <28c31997-b4db-436c-bff7-12ead07254fd@linaro.org>
Date: Tue, 19 May 2026 23:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv1 6/7] hw/arm: Enable Cortex-M7 AMP boot on i.MX8MP
Content-Language: en-US
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, shentey@gmail.com,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
 <20260519175635.3245229-7-gaurav.sharma_7@nxp.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260519175635.3245229-7-gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Hi Gaurav,

On 19/5/26 19:56, Gaurav Sharma wrote:
> Configure the i.MX8MP to boot the Cortex-M7 core alongside
> the Cortex-A53 cores in an Asymmetric Multiprocessing (AMP)
> configuration. The M7 firmware can be loaded and started from Linux
> running on the A53 cores via the remoteproc framework.
> 
> CM7 boot is made optional. A GPR IRQ is connected to a cpuwait handler.
> The handler translates the CPUWAIT into STOP and RUN.It follows the
> classic Cortex-M boot sequence: initial SP and reset vector taken from
> the vector table.
> 
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>   docs/system/arm/imx8m.rst   |  86 +++++++++++++++++++++-
>   hw/arm/fsl-imx8mp.c         | 143 ++++++++++++++++++++++++++++++++++++
>   include/hw/arm/fsl-imx8mp.h |  13 +++-
>   3 files changed, 240 insertions(+), 2 deletions(-)


> @@ -72,7 +155,8 @@ For i.MX 8M Plus EVK:
>   .. code-block:: bash
>   
>     $ qemu-system-aarch64 -M imx8mp-evk \
> -      -display none -serial null -serial stdio \
> +      -display none -serial null -serial stdio -serial null -serial /tmp/imx8mp-uart4 \
> +      -smp 4,maxcpus=5 -global fsl-imx8mp.enable-cm7=on \

Not a blocker; I wonder if this is a good use of the -smp/maxcpus
(thinking about long term AMP modelling).

Maybe we could use a machine property for the M core, and keep the
smp default value to the A core cluster:

   -M imx8mp-evk,enable_cm7=on -smp 4

But IMHO even better is to always create all cores like on real
hardware. If the M7 is not used it is just sitting here, created
and halted, not disturbing anything. Personally I'd rather not
accepting any -smp option for such machine, just reporting an
error if used "Can not restrict this machine, it is always
created with 4 Cortex A and 1 Cortex M".

>   static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>   {
>       MachineState *ms = MACHINE(qdev_get_machine());
> @@ -277,6 +368,23 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>       const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
>       int i;
>   
> +    if (!s->enable_cm7) {
> +        object_unparent(OBJECT(&s->cm7));
> +    } else {
> +        /*
> +         * When CM7 is enabled we need one additional vCPU
> +         * slot. If the user does not specify maxcpus=,
> +         * QEMU defaults maxcpus to the current -smp count.
> +         */
> +        unsigned int need = ms->smp.cpus + 1;
> +        if (ms->smp.max_cpus < need) {
> +            error_setg(errp,
> +                       "CM7 enabled requires -smp %u,maxcpus=%u (one extra vCPU slot for CM7)",
> +                       ms->smp.cpus, need);
> +            return;
> +        }
> +    }

