Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F504C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZbt-0006bB-Tm; Fri, 07 Mar 2025 10:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZbo-0006aR-T6
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:27:33 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqZbn-00087q-0l
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:27:32 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so1725580f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741361245; x=1741966045; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fdep0qw5C2uCQxBsaR5ZRgsLzZW+XizIXV/FbJ1+ubs=;
 b=cpeq1eBp2GeAHsQDhlDbkTM4tB1faFu1P/nqBJAQTYA5U1MplaS0hFN9FvmO6U4vVW
 dhQK55KsmCNF24792bO5/bgts2aannhdlxHdr/xdE9ZSWmiou2Hzm3CJVBARSwhfq7Mq
 DL1/uwkU63mogiJKDOCh/WEIqSOpLjW25J2SeKmBAKNzWO7kE4fPakEYYX9xaiqZB+xR
 9w2thfOXkUMZm9yyk9k72x3vyQzC/uPRuxgFcC/fwAWtUdMUNM14FvW002MeDBriSR/q
 WlHYDNJoXyrMuj53uq2AhtC/ojKWv0m525cnGldg1DNKdVAEQShYudMMfAyKSgUL68vG
 W2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741361245; x=1741966045;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fdep0qw5C2uCQxBsaR5ZRgsLzZW+XizIXV/FbJ1+ubs=;
 b=aSZ9PnDTBSzpLPoah1STQDcqg2hN8EG2Z0mO5eQkv8McLLZC5d0Ws9fzKFaWSAJM5F
 0FZ8llGMACkFzT9KuUqEpUFCvNQs+UEFxpQFyxsR6PkqGVdn7MTO5wMcZw/s5TIdeSwo
 cPak/LSMEjA2stC1j5RALLu7p4aVge5b1HnJu8kPWiJItyM62jEjv1nQiUw0b7Nj6xns
 X16jCjsSWHLmz2EobWGA5cp7RAfxM6qKICF6o543wEmSNfvoMizZ3gWVELb54G9kXuNv
 MjsQQ6T8A75RIJdCc9YGAutydddQr5iP1wrE7OxINm0WmuhLOsMNgs94w3726z7qLuhV
 ZGbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJZXGEfJRKd6wwPrRe60OPff+DUHxdz0fIw0NxUbKMpadqIMoA7tNtuhSMMMIHUZsVLXeBjGxm1o/x@nongnu.org
X-Gm-Message-State: AOJu0YywL9ysvE63xY4/zgGPl8mDwm9TbaMdSrhSKcqwg4Pr8sN/tmbk
 JQxLZyt5uZ5uzU9n8qw+cXkBtReTJI+TlM96JHkwXjSpLQHnJ7GaRi3e0gfh67E=
X-Gm-Gg: ASbGncvVmX3OiIllUdLf1xVrV5w2MGSqCh/iuL0BdzORdLYYom4e7+0do3CRylBeURz
 3sbRV2JdhPFghqokUKK4GxbragbbaD6ghPMPX2hvfk7Lcp7QJkiVu2vJktedc9QHbXaABx6YWNm
 oGXopYVWao3uCnsymvxDn3FFX9e30gMMPACqZhAJZ2vm4nwh/9Jtgdyoz702ZuyD5hHnPOM34dk
 UItJwYlcPz6rCwmYs8f4tBd/4uOqu3kY5V+aLeFapooOXEeCEi3ujklW6S2Y0EVt9BD5+nUmtQ9
 yNTlwtf8l8/h7POFSo6Vsyl34yyKO1CDy0sSBqFSkxxplL2R1CmRDPprsr1n9emEt2YFUsaQO70
 9t4/n4Gi9JcXE
X-Google-Smtp-Source: AGHT+IH/mB1DM+zFdWRbrU1VPXKti7yLAqg96qsILyOnMuaH01NLoJTrUihKar/sdabxeSbpye1EkQ==
X-Received: by 2002:adf:cb01:0:b0:390:f6aa:4e7c with SMTP id
 ffacd0b85a97d-39132d7b7f5mr1906186f8f.28.1741361244595; 
 Fri, 07 Mar 2025 07:27:24 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd93c9b6sm54193065e9.29.2025.03.07.07.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 07:27:23 -0800 (PST)
Message-ID: <ced1ce10-b211-4328-b944-20154c24da63@linaro.org>
Date: Fri, 7 Mar 2025 16:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/11] target/s390x: Add a CONFIG switch to disable legacy
 CPUs
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240624091043.177484-1-thuth@redhat.com>
 <20240624091043.177484-12-thuth@redhat.com>
Content-Language: en-US
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240624091043.177484-12-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Thomas,

On 24/6/24 11:10, Thomas Huth wrote:
> The oldest model that IBM still supports is the z13. Considering
> that each generation can "emulate" the previous two generations
> in hardware (via the "IBC" feature of the CPUs), this means that
> everything that is older than z114/196 is not an officially supported
> CPU model anymore. The Linux kernel still support the z10, so if
> we also take this into account, everything older than that can
> definitely be considered as a legacy CPU model.
> 
> For downstream builds of QEMU, we would like to be able to disable
> these legacy CPUs in the build. Thus add a CONFIG switch that can be
> used to disable them (and old machine types that use them by default).
> 
> Message-Id: <20240614125019.588928-1-thuth@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 5 +++++
>   target/s390x/cpu_models.c  | 9 +++++++++
>   target/s390x/Kconfig       | 5 +++++
>   3 files changed, 19 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 3d0bc3e7f2..cd063f8b64 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -47,6 +47,7 @@
>   #include "migration/blocker.h"
>   #include "qapi/visitor.h"
>   #include "hw/s390x/cpu-topology.h"
> +#include CONFIG_DEVICES
>   
>   static Error *pv_mig_blocker;
>   
> @@ -1126,6 +1127,8 @@ static void ccw_machine_2_12_class_options(MachineClass *mc)
>   }
>   DEFINE_CCW_MACHINE(2_12, "2.12", false);
>   
> +#ifdef CONFIG_S390X_LEGACY_CPUS
> +
>   static void ccw_machine_2_11_instance_options(MachineState *machine)
>   {
>       static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V2_11 };
> @@ -1272,6 +1275,8 @@ static void ccw_machine_2_4_class_options(MachineClass *mc)
>   }
>   DEFINE_CCW_MACHINE(2_4, "2.4", false);
>   
> +#endif
> +
>   static void ccw_machine_register_types(void)
>   {
>       type_register_static(&ccw_machine_info);
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index efb508cd2e..a27f4b6f79 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -25,6 +25,7 @@
>   #ifndef CONFIG_USER_ONLY
>   #include "sysemu/sysemu.h"
>   #include "target/s390x/kvm/pv.h"
> +#include CONFIG_DEVICES
>   #endif
>   
>   #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc) \
> @@ -47,6 +48,13 @@
>    * generation 15 one base feature and one optional feature have been deprecated.
>    */
>   static S390CPUDef s390_cpu_defs[] = {
> +    /*
> +     * Linux requires at least z10 nowadays, and IBM only supports recent CPUs
> +     * (see https://www.ibm.com/support/pages/ibm-mainframe-life-cycle-history),
> +     * so we consider older CPUs as legacy that can optionally be disabled via
> +     * the CONFIG_S390X_LEGACY_CPUS config switch.
> +     */
> +#if defined(CONFIG_S390X_LEGACY_CPUS) || defined(CONFIG_USER_ONLY)
>       CPUDEF_INIT(0x2064, 7, 1, 38, 0x00000000U, "z900", "IBM zSeries 900 GA1"),
>       CPUDEF_INIT(0x2064, 7, 2, 38, 0x00000000U, "z900.2", "IBM zSeries 900 GA2"),
>       CPUDEF_INIT(0x2064, 7, 3, 38, 0x00000000U, "z900.3", "IBM zSeries 900 GA3"),
> @@ -64,6 +72,7 @@ static S390CPUDef s390_cpu_defs[] = {
>       CPUDEF_INIT(0x2096, 9, 2, 40, 0x00000000U, "z9BC", "IBM System z9 BC GA1"),
>       CPUDEF_INIT(0x2094, 9, 3, 40, 0x00000000U, "z9EC.3", "IBM System z9 EC GA3"),
>       CPUDEF_INIT(0x2096, 9, 3, 40, 0x00000000U, "z9BC.2", "IBM System z9 BC GA2"),
> +#endif
>       CPUDEF_INIT(0x2097, 10, 1, 43, 0x00000000U, "z10EC", "IBM System z10 EC GA1"),
>       CPUDEF_INIT(0x2097, 10, 2, 43, 0x00000000U, "z10EC.2", "IBM System z10 EC GA2"),
>       CPUDEF_INIT(0x2098, 10, 2, 43, 0x00000000U, "z10BC", "IBM System z10 BC GA1"),
> diff --git a/target/s390x/Kconfig b/target/s390x/Kconfig
> index d886be48b4..8a95f2bc3f 100644
> --- a/target/s390x/Kconfig
> +++ b/target/s390x/Kconfig
> @@ -2,3 +2,8 @@ config S390X
>       bool
>       select PCI
>       select S390_FLIC
> +
> +config S390X_LEGACY_CPUS
> +    bool
> +    default y

Do we have plan to deprecate or switch that off?

> +    depends on S390X


