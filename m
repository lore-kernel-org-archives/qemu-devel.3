Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB56C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBWY7-0001bT-Mr; Mon, 27 May 2024 05:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBWY4-0001ZN-E1
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:21:44 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sBWY0-0002Vi-Dj
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:21:44 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5b98f49e27bso744705eaf.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716801698; x=1717406498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MVjX/0bcikX44F39xQGF8AtuyQpw/NXj+W1HhMED9R8=;
 b=aFB4vHyYxlaeiftkLGP/0DOa4l/xSEvuggc4zSpXuGp9KPLPQRdjd6WixFntFnOBFy
 qqQ9d8CdfEWc/dA284NjpOopSlvyZNGrk9306gen5qYDbWtaYUr+VJ2uF+COy0e+qk9A
 GUuPGxJB0R1ap1Orsr65hQY24ZeQPpWLoBamxEkokFkOD4TIySlMsQVFUKEVqOyIE3MR
 N9vB0ivTVMT7W/4mdNbhnu31OCpiJP81ZL3dvHw9Lqn0X4IUcj1I4n3Y9dG08WE9bJH1
 9Ms37mVIiqGdLthLbPFI3IMQ7C6Qe4w11zFOElliucsMY0i6v2OTAgXvefIAp5olwVCI
 cuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716801698; x=1717406498;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MVjX/0bcikX44F39xQGF8AtuyQpw/NXj+W1HhMED9R8=;
 b=ceJ+4nc2q+mj1pLyVrKxjgpc1lrL10fcIJzS9lRAJbJmdQBBvalenSZXs/3Qnps2Bw
 Fz7bh8mVAxitIkVWYcwkJy3A8pg4yc2aU8xtKcPOpQ6TfrmF4avJseX5DVGlaRODJRT0
 RO0jjxHgRV7Qt92or1mZ2pM4L7NB2T6//SJK6hyI+/aY+huEfDxFXln+y25zuGiC9S+M
 9qXiFHRqJw4FclFyLU1vBrLw7GKw4wp7BQG7xbKbZEbYhbu9vR3mmIJdkq7BLLh7+n1S
 3vfziNBkFDlkCsPWlyZTr4L7Sm9yXJFxvIDXLeNGaCN2nrJwRjBZ5tl56qSKTp64LkQ2
 3QHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYR6tDEyQln+Xm0dX2piO1VE/w0c0eKpE/tUhIQgSzSC6oW6lxpuY7svfolhZj34T6EVXFsl7UQq2G5WIRizEhAeURw1Q=
X-Gm-Message-State: AOJu0YwvyaTiGbJbWnY162gjI0gyWF68Apxu4QjBoyBDtYCZsE3jfvw5
 BWTHoqiGzMVO1F38pIQ9oyftdOTOiLKPK0x+FLZPrmV4DGq4plmeVmMIdijEqYc=
X-Google-Smtp-Source: AGHT+IFaAAGuqAK49lFqYjG/UaHNeqF1TfriIviUYQCJI8avKPpBCGXyohDCSea2JyZXtySlz7idEg==
X-Received: by 2002:a05:6358:9f9f:b0:192:ba37:f9f1 with SMTP id
 e5c5f4694b2df-197e4fc7886mr827976555d.5.1716801698238; 
 Mon, 27 May 2024 02:21:38 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6822073fbffsm5707738a12.2.2024.05.27.02.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 02:21:37 -0700 (PDT)
Message-ID: <4d2d56aa-5758-4320-a5ef-53ebb87ab494@ventanamicro.com>
Date: Mon, 27 May 2024 06:21:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v2 0/5] target/riscv: Support RISC-V privilege 1.13
 spec
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20240515080605.2675399-1-fea.wang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240515080605.2675399-1-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Fea,

Please try to also add all RISC-V QEMU maintainers and reviewers when sending
patches. It will get your patches reviewed and queued faster. Otherwise the
maintainers can miss you your series due to high ML traffic.

You can fetch who you want to CC using the get_maintainer.pl script with the
patch files or any source file in particular, e.g.:

$ ./scripts/get_maintainer.pl -f target/riscv/cpu.c
Palmer Dabbelt <palmer@dabbelt.com> (supporter:RISC-V TCG CPUs)
Alistair Francis <alistair.francis@wdc.com> (supporter:RISC-V TCG CPUs)
Bin Meng <bmeng.cn@gmail.com> (supporter:RISC-V TCG CPUs)
Weiwei Li <liwei1518@gmail.com> (reviewer:RISC-V TCG CPUs)
Daniel Henrique Barboza <dbarboza@ventanamicro.com> (reviewer:RISC-V TCG CPUs)
Liu Zhiwei <zhiwei_liu@linux.alibaba.com> (reviewer:RISC-V TCG CPUs)
qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
qemu-devel@nongnu.org (open list:All patches CC here)


I added the extra folk in the CC for this reply so don't worry about it.


Alistair, please queue this series. It's already fully acked and I would like to add
some bits on top of the priv_spec 1.13 support.


Thanks,


Daniel

On 5/15/24 05:05, Fea.Wang wrote:
> Based on the change log for the RISC-V privilege 1.13 spec, add the
> support for ss1p13.
> 
> Ref:https://github.com/riscv/riscv-isa-manual/blob/a7d93c9/src/priv-preface.adoc?plain=1#L40-L72
> 
> Lists what to do without clarification or document format.
> * Redefined misa.MXL to be read-only, making MXLEN a constant.(Skip, implementation ignored)
> * Added the constraint that SXLEN≥UXLEN.(Skip, implementation ignored)
> * Defined the misa.V field to reflect that the V extension has been implemented.(Skip, existed)
> * Defined the RV32-only medelegh and hedelegh CSRs.(Done in these patches)
> * Defined the misaligned atomicity granule PMA, superseding the proposed Zam extension..(Skip, implementation ignored)
> * Allocated interrupt 13 for Sscofpmf LCOFI interrupt.(Skip, existed)
> * Defined hardware error and software check exception codes.(Done in these patches)
> * Specified synchronization requirements when changing the PBMTE fields in menvcfg and henvcfg.(Skip, implementation ignored)
> * Incorporated Svade and Svadu extension specifications.(Skip, existed)
> 
> 
> Fea.Wang (4):
>    target/riscv: Support the version for ss1p13
>    target/riscv: Add 'P1P13' bit in SMSTATEEN0
>    target/riscv: Add MEDELEGH, HEDELEGH csrs for RV32
>    target/riscv: Reserve exception codes for sw-check and hw-err
> 
> Jim Shu (1):
>    target/riscv: Reuse the conversion function of priv_spec
> 
>   target/riscv/cpu.c         |  8 ++++++--
>   target/riscv/cpu.h         |  5 ++++-
>   target/riscv/cpu_bits.h    |  5 +++++
>   target/riscv/cpu_cfg.h     |  1 +
>   target/riscv/csr.c         | 39 ++++++++++++++++++++++++++++++++++++++
>   target/riscv/tcg/tcg-cpu.c | 17 ++++++++---------
>   6 files changed, 63 insertions(+), 12 deletions(-)
> 

