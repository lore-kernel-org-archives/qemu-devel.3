Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F015F327A6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF42q-0002ey-KW; Tue, 21 Apr 2026 01:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF42j-0002eD-Jf
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:53:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wF42h-0002ZB-2l
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:53:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so2535517f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776750781; x=1777355581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hYyaQPMXQZpIgqQHWX5QcNv1/agzaF1UDpVMXODrRIU=;
 b=ypuX3bzn7IBN0o9kWlrB9OT2J6Uu4UgxWG/ov9pp/u9hRsSkBGYVo8CXi2l86RQdBD
 uCiK451SNHbxNJQ8R8AjkgoHQPLVvFHgacJwwcpkUjQRHcbcJ8fqPRVK32SbNt2dqAhJ
 8V5U6OFMiERnwjRRC9Cabk2f5wXqdU4Wr+/tsINXxJlygJyArAcbkD4Stc/Wli5VzTAf
 Hyvo4Y2H3swKG0aGAn+ycEQYkUzoHCu/I/BQzlkiaPCqXIUOdaKVmYUN5rX4JfRd0iGK
 pxMKWMlKbpS6umceAxCx2r57nJ0NxtrPq9ntelxAWWDupIevxtq6tZFj3W9njPuQA1g9
 qnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776750781; x=1777355581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hYyaQPMXQZpIgqQHWX5QcNv1/agzaF1UDpVMXODrRIU=;
 b=k0INflEChPuQSm5BWZ+PXQJCUnUTIdMjJZ9AXsgAna8MqGlMtm1y11hQ6Vu3kzMfgX
 k5qVcFBR/5KvKY5+FeBh9KHRUVdZw5RMjydJTfalIv6C/J3qLlhHTYeQYwwAAe1NjoM3
 q2AQnqc6MsgsFYAj99Jw5dKloWrktv3FwDXOBpjZ0kuulyDXzuoECrt85krUt47J6lwo
 PHsjp4yR7fl0zurRxt6a3twxb/5rt+XAVqjJqz4C8TGMT4As8x0qpr8rRHPf6+99LHCP
 K2g3S1aK6Qn6D79AnChdGYLLqkyAS5DftQiFIAdJCPGVNLPt57QlxLPGAMXbEhXcb2EC
 XLCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GvFPAMVYF/WJSPLaQ60TuF8CsSnDw1rQLjKM8S8oBUr9C4rMDIfI98sZpZ+v99o+LQMqWz4EHojmh@nongnu.org
X-Gm-Message-State: AOJu0YyQP/LNks4YJDCMfLMt+nEmLyY16g4p/x21hZo+bWUJOxm+ngoM
 TvYkrwl34c6nJksrpe8XIn/cdelJY13upNkeopQh3rMLWrp0FRc8YBx0G19mfuBXc9A=
X-Gm-Gg: AeBDiettxIs6eY3zVyNw9x6yRpYzYp2UelOE21kPs1P0f3UGw4+10oavNDHepgNE0So
 mdkpNcr3GaWKJ76lXMNsgfz6h01dWiHzHTDnysN7l6Al995xlH5eCLstCjh1hbGQ0RzxFWtpna/
 I9XDMu9e/37OHx8fujb4gOiJehq+Pa5jsEkb3qspCecCnsEyfvlYVsCdpKm/8zDdoVnd34ae0db
 INTsigONg/KBkbXey7EYWpd1DWVZwkrravhOiMFzJhRMXMc5MNP+dqgsw0YoR0xIghcVw7+aFew
 rfjPC/Q9/z4PmKY4aRDq4KgWY3J1X6x2NRjlKZRdO0cTaPlS70c37k1cdBgUdAq1Jh18L8f37ke
 YjrlEe/ndxQXC1zEyJglMyPYUeMM+LcCOr2SCjfeEO2IgrLfzX+X7sfhP0hAdSajmthtkMmxlKY
 en5PbonIBQ3kfvyFO+kF1qtljyi7aWhkcIShQFGItV/sGAwQNymR1Ro1IyHjIHijiy1mqRS6tLn
 IPL
X-Received: by 2002:a05:6000:18a8:b0:43f:dd91:b022 with SMTP id
 ffacd0b85a97d-43fe3e0a2a9mr25001592f8f.35.1776750780955; 
 Mon, 20 Apr 2026 22:53:00 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm34704413f8f.13.2026.04.20.22.52.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 22:53:00 -0700 (PDT)
Message-ID: <23a86057-03d9-427b-af7f-d59dc730a3e3@linaro.org>
Date: Tue, 21 Apr 2026 07:52:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] hw/riscv: Add Tenstorrent Atlantis machine
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-10-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260421053140.752059-10-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 21/4/26 07:31, Joel Stanley wrote:
> The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
> and CoreLab Technology. It is based on the Atlantis SoC, which includes
> the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.
> 
> The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
> RISC-V CPU.
> 
> This adds the machine containing serial console, interrupt controllers
> and device tree support.
> 
>    qemu-system-riscv64 -M tt-atlantis -m 512M \
>     -kernel Image -initrd rootfs.cpio -nographic
> 
> If there is no kernel provided the simple payload is loaded to avoid
> OpenSBI hanging with no messages.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Co-Developed-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> v3:
>    - Merge simple payload change into this patch
>    - Fix fw_cfg_init_mem_dma API change
>    - Clean up irqchip #defines
>    - Add Michael and Nick as reviewers
>    - create_fdt_pmu was copying RISCVCPU by value
>    - Remove unused platform_bus
> ---
>   MAINTAINERS                       |  11 +
>   docs/system/riscv/tt_atlantis.rst |  38 ++
>   docs/system/target-riscv.rst      |   1 +
>   include/hw/riscv/tt_atlantis.h    |  77 ++++
>   hw/riscv/tt_atlantis.c            | 638 ++++++++++++++++++++++++++++++
>   hw/riscv/Kconfig                  |  15 +
>   hw/riscv/meson.build              |   1 +
>   7 files changed, 781 insertions(+)
>   create mode 100644 docs/system/riscv/tt_atlantis.rst
>   create mode 100644 include/hw/riscv/tt_atlantis.h
>   create mode 100644 hw/riscv/tt_atlantis.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

