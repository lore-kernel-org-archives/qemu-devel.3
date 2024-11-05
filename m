Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACBDD3E77E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8STC-0008QO-2Q; Tue, 05 Nov 2024 17:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8ST3-00084W-W8; Tue, 05 Nov 2024 17:56:10 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8ST2-0006IA-6p; Tue, 05 Nov 2024 17:56:09 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so46677495e9.2; 
 Tue, 05 Nov 2024 14:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730847366; x=1731452166; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OvadvgB20VHSjTESNhpzW4DP9cYXTgUQ/+EBKkv+h0g=;
 b=jGtYzbjhgSF2RzWt92monYtYuq8D9MHD+4RpqSxmMcukT9mNul+1Zk2Yr/mohubHsc
 a2duvOyw5J00MP8/LXyGCWPxQ3GBGF4BzInXmWYaYs6qBagaYKGamBZEORrk30A6T+WJ
 VjLGndUpYZlNMYWOMw22w95gKBarhhcRMgstWpU7VAwfMoNNbXSDzfFAd/l2iiv4Cfqb
 I0JOGdgnQf+/zRznN7F7slZdQvXLIfRoLoGrGi5YNcGG0j4tgBGnH3lnKiyAejLELOX3
 UyLGA89umXCFT4G6AdOzzvKo4OTrrtWxkxLeWfcp2xhkYUscxx7bb0ov/pl+UlUPbDc8
 fiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847366; x=1731452166;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OvadvgB20VHSjTESNhpzW4DP9cYXTgUQ/+EBKkv+h0g=;
 b=vC2ByNTQRsRD0f0xucoaqtUZgPTdlAwfWtN5ly9gw3RkhKRi2wmcjZfg0Dgv6KyE6n
 VHVb3CKFqC8e/TJCNLJ3JZHwc9uXDQzHN8qoY+EON5zO8cUrURLnwsJycGwovVRMY/iA
 wwk5VsP0vjmVywllnr99DXtUeDFFLj4dHiwEvu0qGcErQeUQMUQshpqnOSsuLaOdgR1L
 wpWGOcMkRtENngZmoOminbbt3/aiifduo47yc63D1lEJR9kTI8/f0e7FvoJLYJ1w7yef
 Cqsu39coQgAX2zxjxZQC8SFP98t/kCnoXNVgrmP0aabEuHqdzjLVfCvVWhvFIADXDwrP
 AMhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCjPEki3vNNhcSjookLPlXviABM2SgrV8snKTBU34o40CxDgHnZuM0A2ZsVRvLbqm8ICKLIc2SKw==@nongnu.org
X-Gm-Message-State: AOJu0Yw8w2KFYovqd86vUjdy7KGI4CJFtN7I+oeN+EYF4aJDmeVEwYDZ
 kIKfZGL61rKdjit605EBgvZfFivBhXtua6jk+ZQbCQ+OF1iQpcgz
X-Google-Smtp-Source: AGHT+IGte9292AC20Qvx8Bh/g7/vthphiLg/Br+UkTUHCRPGL7qp2jxTxPod/GU4iKlCyIAktZ5dGg==
X-Received: by 2002:a5d:4145:0:b0:37c:d54b:a39a with SMTP id
 ffacd0b85a97d-381b708aed7mr18570074f8f.33.1730847365815; 
 Tue, 05 Nov 2024 14:56:05 -0800 (PST)
Received: from gmail.com ([89.101.60.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6ae726sm1243075e9.3.2024.11.05.14.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 14:56:05 -0800 (PST)
Date: Tue, 5 Nov 2024 23:56:05 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 02/19] hw/microblaze: Deprecate big-endian
 petalogix-ml605 & xlnx-zynqmp-pmu
Message-ID: <ZyqihSzMYts8nFjB@zapote>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105130431.22564-3-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x32b.google.com
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

On Tue, Nov 05, 2024 at 02:04:14PM +0100, Philippe Mathieu-Daudé wrote:
> The petalogix-ml605 machine was explicitly added as little-endian only
> machine in commit 00914b7d970 ("microblaze: Add PetaLogix ml605 MMU
> little-endian ref design"). Mark the big-endian version as deprecated.
> 
> When the xlnx-zynqmp-pmu machine's CPU was added in commit 133d23b3ad1
> ("xlnx-zynqmp-pmu: Add the CPU and memory"), its 'endianness' property
> was set to %true, thus wired in little endianness.
> 
> Both machine are included in the big-endian system binary, while their
> CPU is working in little-endian. Unlikely to work as it. Deprecate now
> as broken config so we can remove soon.


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/about/deprecated.rst                        | 6 ++++++
>  configs/devices/microblaze-softmmu/default.mak   | 2 --
>  configs/devices/microblazeel-softmmu/default.mak | 5 ++++-
>  hw/microblaze/petalogix_ml605_mmu.c              | 7 ++++++-
>  hw/microblaze/xlnx-zynqmp-pmu.c                  | 8 ++++++--
>  5 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ff404d44f85..e1c8829e1a4 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -279,6 +279,12 @@ BMC and a witherspoon like OpenPOWER system. It was used for bring up
>  of the AST2600 SoC in labs.  It can be easily replaced by the
>  ``rainier-bmc`` machine which is a real product.
>  
> +Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` machines (since 9.2)
> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little endian
> +CPUs. Big endian support is not tested.
> +
>  Backend options
>  ---------------
>  
> diff --git a/configs/devices/microblaze-softmmu/default.mak b/configs/devices/microblaze-softmmu/default.mak
> index 583e3959bb7..78941064655 100644
> --- a/configs/devices/microblaze-softmmu/default.mak
> +++ b/configs/devices/microblaze-softmmu/default.mak
> @@ -2,5 +2,3 @@
>  
>  # Boards are selected by default, uncomment to keep out of the build.
>  # CONFIG_PETALOGIX_S3ADSP1800=n
> -# CONFIG_PETALOGIX_ML605=n
> -# CONFIG_XLNX_ZYNQMP_PMU=n
> diff --git a/configs/devices/microblazeel-softmmu/default.mak b/configs/devices/microblazeel-softmmu/default.mak
> index 29f7f13816c..4c1086435bf 100644
> --- a/configs/devices/microblazeel-softmmu/default.mak
> +++ b/configs/devices/microblazeel-softmmu/default.mak
> @@ -1,3 +1,6 @@
>  # Default configuration for microblazeel-softmmu
>  
> -include ../microblaze-softmmu/default.mak
> +# Boards are selected by default, uncomment to keep out of the build.
> +# CONFIG_PETALOGIX_S3ADSP1800=n
> +# CONFIG_PETALOGIX_ML605=n
> +# CONFIG_XLNX_ZYNQMP_PMU=n
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
> index df808ac323e..61e47d83988 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -213,7 +213,12 @@ petalogix_ml605_init(MachineState *machine)
>  
>  static void petalogix_ml605_machine_init(MachineClass *mc)
>  {
> -    mc->desc = "PetaLogix linux refdesign for xilinx ml605 little endian";
> +#if TARGET_BIG_ENDIAN
> +    mc->desc = "PetaLogix linux refdesign for xilinx ml605 (big endian)";
> +    mc->deprecation_reason = "big endian support is not tested";
> +#else
> +    mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
> +#endif
>      mc->init = petalogix_ml605_init;
>  }
>  
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 43608c2dca4..567aad47bfc 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -181,9 +181,13 @@ static void xlnx_zynqmp_pmu_init(MachineState *machine)
>  
>  static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
>  {
> -    mc->desc = "Xilinx ZynqMP PMU machine";
> +#if TARGET_BIG_ENDIAN
> +    mc->desc = "Xilinx ZynqMP PMU machine (big endian)";
> +    mc->deprecation_reason = "big endian support is not tested";
> +#else
> +    mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
> +#endif
>      mc->init = xlnx_zynqmp_pmu_init;
>  }
>  
>  DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
> -
> -- 
> 2.45.2
> 

