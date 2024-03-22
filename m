Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4C8C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnb4v-0001eX-LE; Fri, 22 Mar 2024 05:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rnb4r-0001e3-In
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:20:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rnb4q-0005jU-28
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:20:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33e17342ea7so842201f8f.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711099237; x=1711704037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pouck9HZQleT7x+vFBGmfvusvsFxN07XU6u0eukEV1M=;
 b=M30rFtKR/CyXPKtgrSBcsUq9tsXm/adF+nhSoKVd1OdVSAbfpyFCokafrGmy/l/0BA
 f4igtQPv+XHR1Bj6/ktbHfQOwQoSOcsfXmcYG4812qbbTQY0q87Y1i4OF5K36mdhw62W
 cSlcFxHZ5FW3RiTKbWYTbHq9dXlQuD3hGsbzcKZ2bNwCrGfJ4zoD/7ttqDjdsSWdBFW7
 w1kDBbofjqoBgtiRHZ9bk8pDPMJzb2od9Ym33/cvK40rJVy3dV6+QL2u7LvlpGE12RL5
 8tcb9jnoTCpXvuesW00dsgXAMtgHac9iZtfAIB6mQniE3pYJWjZRsrKZLQpO+jehEuuk
 p06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711099237; x=1711704037;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pouck9HZQleT7x+vFBGmfvusvsFxN07XU6u0eukEV1M=;
 b=pNOca5hevXiCILBBYbIiCbbK6igqYWy34YjP+x5Gnnpr3Pg/xKhKQ8Ui7BYxndwcCy
 vroDqsn9AIQtim2UMG0vU/XUSYUr5MXDvWYnKG19xGrOizDQ8OvG5w66U+JlJ9in5o37
 lma6/d+DIqEiyhfpxbOEwuUNhc+PzQBNZ76iW774vKTwawwOCeVHLIO5/ELdzROWaT0o
 vf4YEAdfO+tHv84/gltZqLp87KUt3IAJ/nNvHPHdq9WkajKI81Rx7+Rk19rpjaGdhDsC
 NdkOO5exHBIqmXhg5Jl41V73T9pIp0aTjnFNTP60OxjILSPzBEv6mB8pDEJGdPhytD36
 aZsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsFX5R/3lr0gGt9go7Dvq1gFfC+IYudn9DTsa5rxxUUDjmWOXYMDGSBtja13WTb63RieZoaa3Af8tvG8ED9VXul1bHokA=
X-Gm-Message-State: AOJu0YwYbjIzxMPWftDU+/vdTirVW+h0hveuI1zg/NlsSvOkx8ajYiVy
 hnDRRENZ1nNTGdFxLX43mPMPUPs6n/s3kmczvlLbNY8LBCAbHfEd/koS7XFHG0c=
X-Google-Smtp-Source: AGHT+IFGJj3d1+cZS1lq9wE69kifci8I4tFueyzMIqY5sKIeDCarj8jSpzHLJgnwEGRiyPEktGR9Sw==
X-Received: by 2002:a5d:6884:0:b0:33e:aab0:9984 with SMTP id
 h4-20020a5d6884000000b0033eaab09984mr1233864wru.24.1711099237648; 
 Fri, 22 Mar 2024 02:20:37 -0700 (PDT)
Received: from [192.168.200.106] (83.11.22.169.ipv4.supernova.orange.pl.
 [83.11.22.169]) by smtp.gmail.com with ESMTPSA id
 v7-20020a5d6107000000b0033e9e26a2d0sm1615431wrt.37.2024.03.22.02.20.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 02:20:37 -0700 (PDT)
Message-ID: <5587d9ed-6cdd-47ae-864e-75cb5ea47aee@linaro.org>
Date: Fri, 22 Mar 2024 10:20:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/2] hw/riscv: Add server platform reference machine
Content-Language: pl-PL, en-GB, en-HK
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com,
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com,
 yin.wang@intel.com, tech-server-platform@lists.riscv.org,
 tech-server-soc@lists.riscv.org, atishp@rivosinc.com,
 ajones@ventanamicro.com, conor@kernel.org, Fei Wu <fei2.wu@intel.com>,
 Alistair Francis <alistair23@gmail.com>
References: <20240312135222.3187945-1-fei2.wu@intel.com>
 <20240312135222.3187945-3-fei2.wu@intel.com>
 <CAKmqyKN-Yj-HZrR2MtxD2jC=JR6nFn5cEq866EXm0OfaEydXsQ@mail.gmail.com>
 <cfac29ce-f353-4bbd-8e8d-4a7d40bf80e3@linaro.org>
 <ebd63aa1-b4e7-490a-bdef-d952c8e37c47@canonical.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <ebd63aa1-b4e7-490a-bdef-d952c8e37c47@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-wr1-x431.google.com
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

W dniu 22.03.2024 o 09:50, Heinrich Schuchardt pisze:
 >>> I see no mention of device trees in the spec, but I do see ACPI. Do we
 >>> really expect a server platform to use DTs?
 >>
 >> This platform "kind of" follows sbsa-ref where we have very
 >> minimalistic device tree sharing information qemu->firmware.
 >>
 >> libfdt is small, format is known and describes hardware. Firmware is
 >> free to make use of it in any way it wants.
 >>
 >> On sbsa-ref we parse DT in TF-A (base firmware) and provide hardware
 >> information to higher level (edk2) via SMC mechanism. Then EDK2
 >> creates ACPI tables and provide them to the Operating System.

 > We should ensure that only either an ACPI table or a device-tree
 > description is passed to the OS and not both, e.g. when using
 >
 >      qemu-system-riscv64 -kernel vmlinux -M sbsa-ref
 >
 > But that requirement is not machine specific.

I would not call "qemu-system-* -M machinename -k kernel_image" a proper 
way to boot for several systems emulated by QEMU.

DeviceTree is in rvsp-ref and sbsa-ref because it is easy to process in 
limited space 1st stage of firmware has.

And if we knew how people will mention 'sbsa-ref uses DT' we would use 
something else instead. But that would require adding more code into 
existing firmware projects (libfdt is usually already there).

I did not looked at DT generated for rvsp-ref. I know that sbsa-ref one 
is too minimalistic for kernel use as we added only those fields/nodes 
we need to provide data for firmware.

