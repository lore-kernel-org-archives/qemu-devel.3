Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE674C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 22:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riM1l-00047m-KF; Thu, 07 Mar 2024 17:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1riM1k-00047V-KD
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 17:15:48 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1riM1i-0004lB-MC
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 17:15:48 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so2135377a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 14:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709849744; x=1710454544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zmjDmzPadsEgKKJ21Btsh2Sccjz80mxMZr2P9sopgO0=;
 b=QjTzJ236r+6Fhqx/nMY9O+IrV5nrekebe9q9oJJO5EW8JKZGPQ3NVD55mh2fklW2UY
 7o5IcOF9JLN3JoDWX8Y4IFCU/T96e2aUx49EBZOt5HxMvJNjeK+28Sc+QhZY9VcRD7tn
 LzAMeRvwfIih3/DfOjX4KE/X6hzEfU+ldjPEsfOLgNs7GOTo75/Unu0alZWp+3Ak/Dmm
 2czfvFCpBvymdZtRFGl3gGrR+iJHE72kaajvQNQFTzJaTmtJDaIGcvhLtuamkzqB/gVL
 y4c99trzJVhLnbtn0i+A6Ac0PkQGy3zkAZajx5ILvBMuV9q8mZy7jjLAF97H+E7Za3vw
 7e3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709849744; x=1710454544;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zmjDmzPadsEgKKJ21Btsh2Sccjz80mxMZr2P9sopgO0=;
 b=IBezFIaWA2SiQPllLJSPJoA34e9NOMcbL0AUI6cr32re2MAgjsuJi4fLWwMU11I1Sv
 FaDeZl8jxPDe+texm5OI6QAQt/sqSR0zToK2eVWmIIarQO2yhZHIQmMh7uQaxAebZ5Nz
 0BX3QJsPJqqELmtGCwYoy1z26SDbfTT4KeGtx5ZGaEcld7dcOoyLWkmnOu1qA6nD+Dkd
 U1mt2/PjI9YZya3EV1TFEMr1ld+p+NrhlP9US1W5q7W5bvf1NAtM5mxLqdr7mbroR9JH
 AWWdEbbv01tyr28eOrIr7VVl0+/TKJ7WvVm2a1Fpc5SAM5lEhaRrMcIwzom9XDcZT6mZ
 tQBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDak25O0bhARbbJbUeVNiFtfKDJPgmXOyVMjD9M7eVom2bpHeHD9wWVKC/qgOjaaQSqOvg2FCqOXNtBp2IIB7VCAePay4=
X-Gm-Message-State: AOJu0YxtVhZcilMdZrxnsodVuEGBvXX8bbQazBDXC6zlywk5w/VaDqul
 a6lf0DIimDUuy0aUYoVUN+YBfUkZ/Ygd8QWsvEYg+NQ6dsgPliucUItwjLE6h3U=
X-Google-Smtp-Source: AGHT+IHkQgAuL4F3lHzy+lEYugLu1Uzq7ctx9d1LLrPsX6l/nVXCE7uUsYL5k7Rj4s3Pl6Ct4/FVYg==
X-Received: by 2002:a50:8d52:0:b0:565:dd45:48cb with SMTP id
 t18-20020a508d52000000b00565dd4548cbmr760982edt.4.1709849744278; 
 Thu, 07 Mar 2024 14:15:44 -0800 (PST)
Received: from [192.168.200.106] (83.11.22.169.ipv4.supernova.orange.pl.
 [83.11.22.169]) by smtp.gmail.com with ESMTPSA id
 g3-20020a056402180300b00566ea8e9f38sm7001471edy.40.2024.03.07.14.15.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 14:15:43 -0800 (PST)
Message-ID: <ff1b2b2a-dc8e-4346-92de-bee9c4b4b31f@linaro.org>
Date: Thu, 7 Mar 2024 23:15:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] Add RISC-V Server Platform Reference Board
Content-Language: pl-PL, en-GB, en-HK
To: Fei Wu <fei2.wu@intel.com>, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, andrei.warkentin@intel.com,
 shaolin.xie@alibaba-inc.com, ved@rivosinc.com, sunilvl@ventanamicro.com,
 haibo1.xu@intel.com, evan.chai@intel.com, yin.wang@intel.com,
 tech-server-platform@lists.riscv.org, tech-server-soc@lists.riscv.org
References: <20240304102540.2789225-1-fei2.wu@intel.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20240304102540.2789225-1-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x533.google.com
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

W dniu 4.03.2024 o 11:25, Fei Wu pisze:

> The RISC-V Server Platform specification[1] defines a standardized
> set of hardware and software capabilities, that portable system
> software, such as OS and hypervisors can rely on being present in a
> RISC-V server platform. This patchset provides a RISC-V Server
> Platform (RVSP) reference implementation on qemu which is in
> compliance with the spec as faithful as possible.

I am working on sbsa-ref which is AArch64 Standard Server Platform 
implementation. Will not go through details of rvsp-ref but give some 
potential hints from my work with our platform.


1. Consider versioning the platform.

We have 'platform_version'.'major/minor' exported in 
DeviceTree-formatted data. This allows for firmware to know which of 
non-discoverable hardware features exists and which not. We use it to 
disable XHCI controller on older platform version.


2. If specification allows to have non-discoverable devices then add some.

This will require you to handle them in firmware in some way. Sooner or 
later some physical hardware will be in same situation so they can use 
your firmware code as reference. We have AHCI and XHCI on system bus 
(hardcoded in firmware).


3. You are going to use EDK2 with ACPI. Hide DT from code there with 
some hardware information library.

For sbsa-ref we created SbsaHardwareInfoLib in 
https://openfw.io/edk2-devel/20240306-no-dt-for-cpu-v6-0-acd8727a1b59@linaro.org/ 
patchset.



