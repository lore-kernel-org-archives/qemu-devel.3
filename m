Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51769C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 07:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcL1e-0006qI-1Y; Tue, 20 Feb 2024 02:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcL1c-0006q1-5M
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:58:48 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcL1a-0007Zz-2U
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:58:47 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51197ca63f5so5254541e87.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 23:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708415924; x=1709020724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sc4inLeKe01Y6gt6dvht8v818QXz6DqMFhhT7z2fVzg=;
 b=A/WRGgFuiaIx+zSyfp7xKJUphRU8ayO8AkBotzaL63WEPkdZ25bcyuPm9wFUnZFOW4
 ij2NYtHydv+WBphaRAZZp9vGPjrEDlTSU+Z+OXzzP4lAhZKdm5pVsOdXZlTwHhKdNkDw
 zOmysVD4IvyS4/o3DChSU5LEu2xDERrxA27klLNSPttBdApt2w4Nmi/cIfR3pScSTE76
 UaTnyHRJsUmtqQbSqkulso+5o6KoiUzxtp5J24IDI9kn4iBZGNuehnWuTB78cq/tVIZA
 QNpli7yo7RVRfJd93jtD3YF0KyRJS2ezEge8v1kNCRJIfm237eaffoyWAi3/pTF/6fFB
 vD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708415924; x=1709020724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sc4inLeKe01Y6gt6dvht8v818QXz6DqMFhhT7z2fVzg=;
 b=vOLd5o4MnRdZAMHWIrXIJNJwbiT7DIO5xg75axQDs/Fupd6GMOneukE+3UH2v8dxRC
 tfPBY3gCO6I6vm1Hn1i+vC8OPyjiX6QZwD2ReuKisOfDTjsSuEIbc0I5cwTZDEqeNaSu
 Gv+VYeyGMb/oPaU7eVo8qI7cmSRdSwirEVbS+qYvVAzl929OugQW7p1dzh0RFZYNkXNw
 ajFnd9UsBEkIxCHqbJYCfJStF8qcOmiCggOjbSwwcl/i3TlyMINSbiI4OyOnH4aI88Aw
 VGwMuFGF6hC38zpMPKINpl0tf1mLjxHYIs77YwllXZMgwWpFtW31/6nMNgvCjM2j9T5Q
 upqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDno+dC8Sq4ak2E+vJ1vTbGDsQXjIQJgeKjmlcQ4RiHS97hFYC891sdpymtTXja8RLG66IW27RXOjSmvweJhuqcXWX3g0=
X-Gm-Message-State: AOJu0YzQ8mFyTqoWV9JrlM1WYXPC7odSxuCOvnteSfDoYjZ0JZfLtdZG
 OrkI2JwEBaqnKmCKE2LTeK+LZxjU4EPvmOv3OVHWoTzmx0M3CTmEMlMRMMC3oSY=
X-Google-Smtp-Source: AGHT+IGhBCSUAJcYX875HjLuQPd+UFQuQHIRKRDS/eKMdzzCgMELAPOSC7En8Ft3zZT0nQi6ttjsPw==
X-Received: by 2002:a05:6512:39d1:b0:512:c2e7:27a3 with SMTP id
 k17-20020a05651239d100b00512c2e727a3mr1216082lfu.33.1708415923951; 
 Mon, 19 Feb 2024 23:58:43 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 b7-20020a05600c11c700b00411c3c2fc55sm13481152wmi.45.2024.02.19.23.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 23:58:43 -0800 (PST)
Message-ID: <50ad98bf-cee9-44f7-bf4d-ada2a02e330b@linaro.org>
Date: Tue, 20 Feb 2024 08:58:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] hw/isa/lpc_ich9: add broadcast SMI feature
Content-Language: en-US
To: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Bernhard Beschow <shentey@gmail.com>
References: <20170126014416.11211-1-lersek@redhat.com>
 <20170126014416.11211-3-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20170126014416.11211-3-lersek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Laszlo, Igor, Gerd,

(old patch, now commit 5ce45c7a2b)

On 26/1/17 02:44, Laszlo Ersek wrote:
> The generic edk2 SMM infrastructure prefers
> EFI_SMM_CONTROL2_PROTOCOL.Trigger() to inject an SMI on each processor. If
> Trigger() only brings the current processor into SMM, then edk2 handles it
> in the following ways:
> 
> (1) If Trigger() is executed by the BSP (which is guaranteed before
>      ExitBootServices(), but is not necessarily true at runtime), then:
> 
>      (a) If edk2 has been configured for "traditional" SMM synchronization,
>          then the BSP sends directed SMIs to the APs with APIC delivery,
>          bringing them into SMM individually. Then the BSP runs the SMI
>          handler / dispatcher.
> 
>      (b) If edk2 has been configured for "relaxed" SMM synchronization,
>          then the APs that are not already in SMM are not brought in, and
>          the BSP runs the SMI handler / dispatcher.
> 
> (2) If Trigger() is executed by an AP (which is possible after
>      ExitBootServices(), and can be forced e.g. by "taskset -c 1
>      efibootmgr"), then the AP in question brings in the BSP with a
>      directed SMI, and the BSP runs the SMI handler / dispatcher.
> 
> The smaller problem with (1a) and (2) is that the BSP and AP
> synchronization is slow. For example, the "taskset -c 1 efibootmgr"
> command from (2) can take more than 3 seconds to complete, because
> efibootmgr accesses non-volatile UEFI variables intensively.
> 
> The larger problem is that QEMU's current behavior diverges from the
> behavior usually seen on physical hardware, and that keeps exposing
> obscure corner cases, race conditions and other instabilities in edk2,
> which generally expects / prefers a software SMI to affect all CPUs at
> once.
> 
> Therefore introduce the "broadcast SMI" feature that causes QEMU to inject
> the SMI on all VCPUs.

I'm trying to remove cpu_interrupt() API from hw/ and found this odd
case.

IIUC, the code you added is closer to what real HW is doing:

   CPU_FOREACH(cs) { cpu_interrupt(cs, CPU_INTERRUPT_SMI); }

and previous implementation was bogus:

   cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);

but to avoid breaking older VMs ready to deal with bogus impl,
you have to add a virtual (non-HW) ICH9_LPC_SMI_F_BROADCAST bit
so new VMs can detect (negotiating) it and use normal expected
HW behavior.

If so, and since this change was almost 7 years ago, can we
expect that most of today's VMs use ICH9_LPC_SMI_F_BROADCAST_BIT,
and would it be possible to deprecate it, so it become the only
possibility, allowing us to remove this bogus call?

   cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);

> While the original posting of this patch
> <http://lists.nongnu.org/archive/html/qemu-devel/2015-10/msg05658.html>
> only intended to speed up (2), based on our recent "stress testing" of SMM
> this patch actually provides functional improvements.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
> 
> Notes:
>      v7:
>      - no changes, pick up Igor's R-b
>      
>      v6:
>      - no changes, pick up Michael's R-b
>      
>      v5:
>      - replace the ICH9_LPC_SMI_F_BROADCAST bit value with the
>        ICH9_LPC_SMI_F_BROADCAST_BIT bit position (necessary for
>        DEFINE_PROP_BIT() in the next patch)
> 
>   include/hw/i386/ich9.h |  3 +++
>   hw/isa/lpc_ich9.c      | 10 +++++++++-
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
> index da1118727146..18dcca7ebcbf 100644
> --- a/include/hw/i386/ich9.h
> +++ b/include/hw/i386/ich9.h
> @@ -250,4 +250,7 @@ Object *ich9_lpc_find(void);
>   #define ICH9_SMB_HST_D1                         0x06
>   #define ICH9_SMB_HOST_BLOCK_DB                  0x07
>   
> +/* bit positions used in fw_cfg SMI feature negotiation */
> +#define ICH9_LPC_SMI_F_BROADCAST_BIT            0
> +
>   #endif /* HW_ICH9_H */
> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> index 376b7801a42c..ced6f803a4f2 100644
> --- a/hw/isa/lpc_ich9.c
> +++ b/hw/isa/lpc_ich9.c
> @@ -437,7 +437,15 @@ static void ich9_apm_ctrl_changed(uint32_t val, void *arg)
>   
>       /* SMI_EN = PMBASE + 30. SMI control and enable register */
>       if (lpc->pm.smi_en & ICH9_PMIO_SMI_EN_APMC_EN) {
> -        cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
> +        if (lpc->smi_negotiated_features &
> +            (UINT64_C(1) << ICH9_LPC_SMI_F_BROADCAST_BIT)) {
> +            CPUState *cs;
> +            CPU_FOREACH(cs) {
> +                cpu_interrupt(cs, CPU_INTERRUPT_SMI);
> +            }
> +        } else {
> +            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
> +        }
>       }
>   }
>   


