Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6080C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 10:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFWfH-0000MZ-Kg; Fri, 07 Jun 2024 06:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFWfG-0000M6-UJ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 06:17:42 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFWfE-0007VW-FC
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 06:17:42 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e6f2534e41so20548751fa.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 03:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717755458; x=1718360258; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=11AGaZqZ84qUcpFS74fl2+jeXAtFXI4ncYAPhdLQtQk=;
 b=seJRePNZcn0YG5pmSlO0zq94xhK/bTvIx/H47BGTNUh9J+7NNnrCEScLEDr4Nrwpzu
 B41HrBXwii2BRAd6IiCj/GSzUINcFsBzjUJweII3hyWJDG48AYy2kujUfi7DabiMIvCk
 CtdnI/Hug77ltVG5thMPlEzMml4SrVVBbNNsFq3igqGEbTmJHYvSU1qgMkP0hWWciPd0
 bNs+nhhLCFz6sAv/Y6cL1ZizsjEpbQRszZXqVynHH5mVQrJusIEVP1q+rRqOtnSJMm+P
 m7PdZsZl9O5qKmet9dBw5OSPSH9Tew1wO09go+b3sWoK4lkRFUEuRlfh0X9PHY4POFTN
 o6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717755458; x=1718360258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=11AGaZqZ84qUcpFS74fl2+jeXAtFXI4ncYAPhdLQtQk=;
 b=kEJkujEKseJz2xYKjRxjcWGeL6G48kVddzrQG6j2qJBa8RQw7wxihLr6mmd+qwZIQi
 6kMgXsAYg9sIRJ7EiGizzkZ6Kx+GaUZjewlQVvO69yVlHsXA0cPF0vW9sg2mjn7hTYih
 EiXgO5Vdk0sXOCem3PXnM7z8HkZwByaOkyFEOvYzm6j+EHA5NAIjC2VB0TEg6LQs05j9
 PA6keAiuF7ISsiQuWlYJ255gpiVUiycX2E9DKPrdAuPCoMQr+feGBM4CtfhFky33kLRQ
 hwiXF5TVl03SzjMmjksXN42vGBmUN70n+snTvbrVI5Uv7nX6ZPmkVaNdyecwghXsgCiL
 4JKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg+WHiYZo9XChzgYx2qvmJ8SE06akgmDrqhQBJgFJXreXdjub1VBDgKn3ytDtGLh2WIiAb9ICI9BpIwSevFvzlXmZULLc=
X-Gm-Message-State: AOJu0YxN7J4XlnPVfzCOEgzYLyuU2biP6WAIOv/oCdRkP4FFBk7CLHOc
 FrvjrsfZsdIQWnFliNMz+Q7xHeIHi3i+PAtfoTa+/ZtKDS71PVyj1w9CPRsFImZFG2PrKC1h9WA
 EvypryjXHdm+fkezFYzo5zm7ZYEZZBZiGO+dVhA==
X-Google-Smtp-Source: AGHT+IGVYppdpU64Jv9kNABJVkSWNaBljBPSW/F0VqrVXP+eXQMHD7CMcFg7JJJ/s12x2dPIlSS7mHa0MvQ39uIpJ1w=
X-Received: by 2002:a2e:9590:0:b0:2ea:d465:d275 with SMTP id
 38308e7fff4ca-2eadceac36fmr12481451fa.43.1717755458177; Fri, 07 Jun 2024
 03:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240606104745.291330-1-zhenyzha@redhat.com>
 <CAFEAcA_ovHZWFi8Xn1YdPNkFjNWQ+BGQTA0Oc9oXTNuPD+bmmA@mail.gmail.com>
 <20240606181338.00003336@Huawei.com>
 <6e67a59a-7ed6-46c1-b9ba-884800005c81@arm.com>
In-Reply-To: <6e67a59a-7ed6-46c1-b9ba-884800005c81@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2024 11:17:26 +0100
Message-ID: <CAFEAcA8pWdMF8e_gpP288HUppx=ceAfUGz_GH16hXaSw-aie0A@mail.gmail.com>
Subject: Re: [PATCH RFC] hw/arm/virt: Avoid unexpected warning from Linux
 guest on host with Fujitsu CPUs
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Zhenyu Zhang <zhenyzha@redhat.com>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, gshan@redhat.com, 
 eauger@redhat.com, sebott@redhat.com, cohuck@redhat.com, ddutile@redhat.com, 
 shahuang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Thu, 6 Jun 2024 at 22:18, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2024-06-06 6:13 pm, Jonathan Cameron wrote:
> > On Thu, 6 Jun 2024 12:56:59 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> >> On Thu, 6 Jun 2024 at 11:48, Zhenyu Zhang <zhenyzha@redhat.com> wrote:
> >>> In Linux, a check is applied to every device which is exposed through device-tree
> >>> node. The warning message is raised when the device isn't DMA coherent and the
> >>> cache line size is larger than ARCH_DMA_MINALIGN (128 bytes). The cache line is
> >>> sorted from CTR_EL0[CWG], which corresponds to 256 bytes on the guest CPUs.
> >>> The DMA coherent capability is claimed through 'dma-coherent' in their
> >>> device-tree nodes.
> >>
> >> For QEMU emulated all our DMA is always coherent, so where we
> >> have DMA-capable devices we should definitely tell the kernel
> >> that that DMA is coherent.
>
> The trick for that is to put the "dma-coherent" property right in the
> root of the DT so it plausibly communicates "the whole platform is
> coherent", and is then inherited by all devices, even those which
> shouldn't technically need it.

Ah, cool -- that's a pretty small change and it makes sense, and
avoids us having potential bugs in future where we forget to
mark a really-does-do-DMA device as dma-coherent. I like that
a lot better than adding incorrect dma-coherent tags to lots
of device nodes that aren't for DMA-capable devices.

thanks
-- PMM

