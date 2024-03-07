Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80B2C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 15:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riFoz-0002Du-Jb; Thu, 07 Mar 2024 10:38:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riFox-00027k-Ba
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:38:11 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riFos-0001iD-4R
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 10:38:11 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d2509c66daso15356561fa.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 07:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709825884; x=1710430684; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gw84/vaSgbCAjFlxKcLsgC6mzuzeK2gI3t/OK6tP/hM=;
 b=RRrZQfTUOYUjb4RKm0M8W2sK1RPuBFTQn4Gu4/tN+LHFA9EYTzRj+hD08j5RI43GGA
 T4J+FppOm0NluTFNEfgyeDz5rJ9mX/IX/gcCFaREAURuyKtM2+mppcnFnmowp0MGiftp
 Lk6MZxq+cGF/ZZKlrqn+frcfjTs/1jMIYo6jHzIinj/c0ckaHDaY2dmw/cbMrO6gHkVT
 SJ3RTzvsgGZZ5qPZYDyDu9yBNydf9wzyGp2MAeaQn22zXB7mYV9zffKkvI4og+qv2Kkk
 UQ6pPw4htR688q4XlsWh/rwZ57ZUoIzqgZg5Wep7kIxuFHoCos05hWErzNvVO0wfNpED
 Ux3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709825884; x=1710430684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gw84/vaSgbCAjFlxKcLsgC6mzuzeK2gI3t/OK6tP/hM=;
 b=Li2VtyKREfCn6TEKWefJ9lDGlPOrhExAOdO0uI8rWf8vZxLp5XCyhhJ1ENdeIpcbAl
 yX0IYqB/AewnImQTScVt2GLGtGDu/7vQrHZ1uyeemEil+t5RucaKPDgFjNADgUWgFiY4
 pFoZnWhpJpOEnFqM8cRo4E2tjBxDnScHM9KSrOxny4BVMAexsfw4qiatG3/OKbE6r2sV
 xbdI/Oksm1Q8N1EUmSo1/JHocFcCPP0uMAS+Rx9Qdu+2it3U7mV1OONOz6NkeKSPx9QV
 BhpK1TfftWDwLzIEzjda10I9WSRrtFkzQDq1J7OAjwFROWJU92icAE/YIn3hp5B91lth
 NfEg==
X-Gm-Message-State: AOJu0Yw54hY3IHoqxTL1rRVtbzBTe2fMYeSTJzocw194zme8KBpKGw3Q
 a6b4TfmC3sLByGeDaEpMXjzvNBjfMTeo1/87EvhnlhENJ+O3LYvJylbyP8i8+RDrCfD8WcuMtfD
 P9Dap2PQtWT/fEPKYADo4p109UTt7WqZbhabKLQYphhtDdX8k
X-Google-Smtp-Source: AGHT+IErOgT6LCAOHZF02FPPlmRHGu/wnXb8O160fwIYyOrZY+ZDztaJjPgO/PibFBS26hcxKJEkakJkS3Ool9BVJ1Q=
X-Received: by 2002:a2e:b889:0:b0:2d3:228:ec0 with SMTP id
 r9-20020a2eb889000000b002d302280ec0mr1894302ljp.32.1709825883823; 
 Thu, 07 Mar 2024 07:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20240307152835.299233-1-gaosong@loongson.cn>
In-Reply-To: <20240307152835.299233-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 15:37:52 +0000
Message-ID: <CAFEAcA81hgtmpvQopayV6AL2bi1gz3nYvfyga=jRpp9xnw3puQ@mail.gmail.com>
Subject: Re: [PULL v2 00/17] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Thu, 7 Mar 2024 at 15:28, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a87:
>
>   Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-06 16:56:20 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240307
>
> for you to fetch changes up to 4dc2edfd6f8abfc38f0ba110502790aa5051b1b5:
>
>   hw/loongarch: Add cells missing from rtc node (2024-03-07 21:58:00 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240307
>
> ----------------------------------------------------------------
> Song Gao (17):
>       hw/loongarch: Move boot fucntions to boot.c
>       hw/loongarch: Add load initrd
>       hw/loongarch: Add slave cpu boot_code
>       hw/loongarch: Add init_cmdline
>       hw/loongarch: Init efi_system_table
>       hw/loongarch: Init efi_boot_memmap table
>       hw/loongarch: Init efi_initrd table
>       hw/loongarch: Init efi_fdt table
>       hw/loongarch: Fix fdt memory node wrong 'reg'
>       hw/loongarch: fdt adds cpu interrupt controller node
>       hw/loongarch: fdt adds Extend I/O Interrupt Controller
>       hw/loongarch: fdt adds pch_pic Controller
>       hw/loongarch: fdt adds pch_msi Controller
>       hw/loongarch: fdt adds pcie irq_map node
>       hw/loongarch: fdt remove unused irqchip node
>       hw/loongarch: Add cells missing from uart node
>       hw/loongarch: Add cells missing from rtc node

Looks like our emails crossed, but see my remarks on v1
about test/compilation failures.

Also I have just noticed that none of these patches have
Reviewed-by: tags. Please make sure patches are code
reviewed before submitting them in pull requests.

thanks
-- PMM

