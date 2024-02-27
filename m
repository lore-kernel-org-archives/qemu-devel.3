Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394BEC54E49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezNp-0001mm-FY; Tue, 27 Feb 2024 10:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rezNn-0001mQ-Hw
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:28:39 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rezNk-0004CC-UP
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:28:39 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-512e4f4e463so5199898e87.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 07:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709047714; x=1709652514; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XgShDo8iEF7Gb8d0FwTOqL/iZKUQUV1uy50qh6Nmy2o=;
 b=r5GuA8nGx64KB38H+EVePyhNpOzthGxOXstJ3HdzN922JD6nwt/mp+XwlQK+KF5/Jo
 Vu5Aftj32WoXeFL8ttVijGGHUms8OBNSCnqiOkdgL0bR/BPUJE8bRpvDKD5iJAimQgLP
 N3kl9cavQJGqA6FJfARtKjZQ6DbIWoMeK3FFvZvmV2PYN7hoajGdNaImXoByzla8B31t
 8gCzxdaAZoxIOag7GqhDIOpT9KHtPbJzzJplDn0YO4wV40zqY7sgWa9b49AesOypLpBw
 xCPe//X1EKl+929yMMLLRMcTET3T45YZVNkNeaOyPa8xMd73GachbpoZGCW86yqtJj5X
 6PoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709047714; x=1709652514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XgShDo8iEF7Gb8d0FwTOqL/iZKUQUV1uy50qh6Nmy2o=;
 b=DXwEJ+lXrrAy5S51tZJX7VVNXiRf25cni46TJponjasxT/LLPXRnGUVoqe47gpc/nZ
 viOtYvYEgKNV+o4fxIJTJ1CKZMQRTUbTm90YgQ2OjIl/BIa9lBfQZywYLlGBAGr/2BK+
 tiAFNErpQc9cGdHhuPDqiVhaJFx7QXjQjcAQd0wQgGGRCncBsiIlWRxZ7Om3jlpYwX19
 UbjYPBtdaNOysOJxDIWZA9WajhGNIaRt+Uxvi2lZrHO/XKorZk7CCPuJKDmdJt/P4iCH
 m6UptABFtE5t/v944yOGTaLV/dWLkOI/AztKRZ29myxVjmcEbNuF8vWDYNUp6XOl3npl
 b+Eg==
X-Gm-Message-State: AOJu0YwRNedufjSXKIcQAaUl/8beOrrhUwhHoTJzMnAn23Hg49I5XUZG
 dfY1/Vbp+xnzTAFWoVy5Hy0xKzsr1NXdFOXsDWZcSE4KSuXlU4nzUbaIedoBZ36bljYOrh6qmr7
 iTSRj3jO4vGS7M/YJi3LGJ7a8+jqY4tCeZLMGSQ==
X-Google-Smtp-Source: AGHT+IHicBvnf8qa47rMlEKqXoGZ9O3l68IwWudoCbDUVcMQhFX1uXG1gqfqu6esWqvVcffUfVAMHyS2eB58xNv0JNE=
X-Received: by 2002:ac2:4291:0:b0:512:cc50:c3e0 with SMTP id
 m17-20020ac24291000000b00512cc50c3e0mr5994725lfh.52.1709047714017; Tue, 27
 Feb 2024 07:28:34 -0800 (PST)
MIME-Version: 1.0
References: <252c0f8d-08cd-2e7b-63b6-1bbf42ff32f8@huawei.com>
In-Reply-To: <252c0f8d-08cd-2e7b-63b6-1bbf42ff32f8@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2024 15:28:23 +0000
Message-ID: <CAFEAcA81xV6wvBFoaGNpH9=0oAjP=toMBS=MNV_poXm5RPK-iQ@mail.gmail.com>
Subject: Re: [Question] Can I start qemu-system-aarch64 with a vmlinux(ELF
 format)?
To: Kunkun Jiang <jiangkunkun@huawei.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
 Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Tue, 27 Feb 2024 at 14:42, Kunkun Jiang via <qemu-devel@nongnu.org> wrote:
>
> Hi everybody,
>
> I want to start qemu-system-aarch64 with a vmlinux,
> which is an ELF format file. The arm_load_elf() is
> implemented in arm_setup_direct_kernel_boot(). So I
> thought it was supporting the ELF format file.

No, you can't do this. The hw/arm/boot.c code assumes
that ELF files are "bare metal" binaries, whereas
uImage format, AArch64 Image format, and raw binary files
are Linux kernels. Only the last three kinds of files will
be started with the boot protocol the Linux kernel expects.

For AArch64, pass the -kernel option the path to the Image
file, not the vmlinux file.

thanks
-- PMM

