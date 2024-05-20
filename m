Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598A1C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 15:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s95NC-0003W5-OJ; Mon, 20 May 2024 11:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s95NB-0003Vo-Rd
 for qemu-devel@nongnu.org; Mon, 20 May 2024 11:56:25 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s95N9-0007VM-4J
 for qemu-devel@nongnu.org; Mon, 20 May 2024 11:56:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42016c8daa7so20365295e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716220581; x=1716825381; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a+RkeEr619EJdkSnk7X+jwlxNgRZI6y2mX4HsuR7B/U=;
 b=m9yIyEayqwn+YMBYL7HtvOftdtgZQ9xjryc3QcfbN8n/KHQdiDuvLA/R9mokrXLS93
 9cgE2AIt/oPRXGlZIGUy2Rt5gXPL3LHcWo4pXM5yXwLFT8KDXDRoxvEauLYTSFxBOJjc
 NPYEZcAmiXgg736DT7NtKPDdji0vD8c12aaE8MYcerVh0ACbVjPf/UksHU4ces7AuPh9
 ZAqF+1cZcG7Tkb2A0Zzwa+84ibR0VT338uH0B1VnTKSFND2gWeLs4W/c3pSaLv71UDAZ
 TIKA6kjMZa9lbL7uU7yE6/AtndqtRIriRMPVpt3+jmTmT3xML9Q4z7Eyb8zrtIFklGHi
 fXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716220581; x=1716825381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+RkeEr619EJdkSnk7X+jwlxNgRZI6y2mX4HsuR7B/U=;
 b=OLp/S5k4su6XM+uCTlxTTT3C93gwL6iMCMi2GY8rEOf+bRYJw4qaMe82cBFmtsR1uA
 jbCrOdGPUsbiK5oGrzSwI/3ck9/SvhVRhCVAqXnbuAgVNv2TpIq0M6CQx9X5Z1JcWnCb
 VkfDa+/FeVbyCAAiWByi1dEknqxwnAobunf5I2bXKLLdtKjduZT6rPbpt+TmswOgBubC
 Nnno4djrJ/wpbKs332TC9G3CL6+11s87NzDdDnwjsMZZc7xrAKn9ZFDu+G+Xf06mhuoS
 th0c/+Hj9MmFEbhwlE/piUA70yUIAjXyY5fXSZOOwansWxAUqO1j5jT+KCmb+BLdUnBC
 wmyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaVsCjD2d6zKBrJH6Y/1XLdbKQ8jJBjYL5fuB2ygLhc1TO0USbRjLcW6NlsZJcg5AwBMrtZzW7ZEWww5z6ZcDV1oqkfxU=
X-Gm-Message-State: AOJu0Yw9ZhUmadXcYo6kPWpPS12zJSDXDXELcuTbW7VlltWmcO7/FIBp
 h4ZWQwZb0hKCp7kDlBdbjcqeOewycu188VzKw8HKv3iMcbnqMBSl1/AItFnnkJ8=
X-Google-Smtp-Source: AGHT+IGaGk8kAggw345G4Vvn9mku0jKrUQNl5T4Hx0x3tjl0Fe0Gde4F7yAzgPQg5U98201OCcPQgQ==
X-Received: by 2002:a05:600c:4f06:b0:420:1094:65d with SMTP id
 5b1f17b1804b1-42010940753mr217045685e9.12.1716220581356; 
 Mon, 20 May 2024 08:56:21 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccfe1277sm414870455e9.42.2024.05.20.08.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 May 2024 08:56:20 -0700 (PDT)
Date: Mon, 20 May 2024 17:56:19 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Fei Wu <fei2.wu@intel.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com, 
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com,
 yin.wang@intel.com, 
 tech-server-platform@lists.riscv.org, tech-server-soc@lists.riscv.org,
 atishp@rivosinc.com, conor@kernel.org, heinrich.schuchardt@canonical.com,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC v2 2/2] hw/riscv: Add server platform reference machine
Message-ID: <20240520-2ca42f1c1d9a9c65f5474529@orel>
References: <20240312135222.3187945-1-fei2.wu@intel.com>
 <20240312135222.3187945-3-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312135222.3187945-3-fei2.wu@intel.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 12, 2024 at 09:52:21PM GMT, Fei Wu wrote:
> The RISC-V Server Platform specification[1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
> 
> A corresponding Qemu RISC-V server platform reference (rvsp-ref for
> short) machine type is added to provide a environment for firmware/OS
> development and testing. The main features included in rvsp-ref are:
> 
>  - Based on riscv virt machine type
>  - A new memory map as close as virt machine as possible
>  - A new virt CPU type rvsp-ref-cpu for server platform compliance
>  - AIA
>  - PCIe AHCI
>  - PCIe NIC

We should rebase on the IOMMU series [1] and add an IOMMU to the
platform, as it's required by the Server Soc spec (which is required
by the server platform spec).

[1] https://lore.kernel.org/qemu-devel/20240307160319.675044-1-dbarboza@ventanamicro.com/

Thanks,
drew

