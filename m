Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0D3C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 15:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk3CD-00058Q-6H; Mon, 17 Feb 2025 10:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk3CB-00057h-87
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:38:07 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk3C9-0003wn-KE
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:38:06 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5dd164ee34so1536135276.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 07:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739806684; x=1740411484; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4wLnYmRin/+YWBkevN2cOEiMcojJOaA8Kgd0qzfJ3RA=;
 b=hmoy/eY5YCOgIZvbVysdtVtLVyM/ltj2aqyI4NFw6pLQUKaIepWk6d9qvl9fd4gNv2
 5/j6d1DPLADb6IuQJ+spyoFBPplWARdiHnkIslwRMYgP/BuMo99np98IQS9nspR1v9P+
 fTqr7WH2UQNGOSFY/p0me++uS4ix7w1cAKsZcyYCI65fNM4osgkHa/x874IYOaXtyPiz
 fNcGXkYutkjIQUa0fuoq2FkohnLnpK4nREiVASkBESHBpEmxZlv+q1XEWB+hlavMCRwN
 6dAY+yd+twc3nZmKKwIjYGZKlOqZXpf+H9etlN7UZzYOWVOwPR8EXq37V9mmBfM/FbrK
 imYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739806684; x=1740411484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4wLnYmRin/+YWBkevN2cOEiMcojJOaA8Kgd0qzfJ3RA=;
 b=GP5C+kvrsHdoxarfoAFZMq3qFyb/M+gTT2RirVmFny665se22Ce6bz3ULYVef1uoXi
 /joFlkw87atmhyCuHsoZR7CW/NP3r6Shp93HvC1JlBLcnatGRj5RZF6S3CD6UdlxWWdQ
 Nu2lYckRNtJyzEoKZJrUjh2gb0htnannSky4V3Q3dEVbXHA9sVtshnV461XhN5v3Qvod
 Jt9G4t9rk8R+sbqlRuZrdCp87belfJFcZ6apjkVMXfCKyRQSK1YhCjEIPXjXUNe20yIm
 CmHuZJLRIheQ2ZANSJTdPkoWT+4Zr8fGkLzprOrRYuzWjpFP4HdYqwza5L1grOXNlmcM
 ji1Q==
X-Gm-Message-State: AOJu0YyjIuvDLwsoXHDi7ZovDMWpMy7YHOLg8eFDBr5T0xeZof8S4pui
 KujJaXsi+Cce4cfyssxq39YMAw72sr8nZDVc4I3QySEShMbJBfAbIb0fB3mmCpcSqb4gZN1Sa1P
 J1q5AcDuvb570m1OwskFnlDPrL15bREnO6x9ACA==
X-Gm-Gg: ASbGncs6h1DXPoDMre6GUBeMAStPdEDC57M6YCJUJsVv9vnR8F04H9n7lJ7tRQynErg
 5AdTyDWO968oxkw/P4xk1usWppcfoSHAZ1/4ekih6uo0JDA97cRZswu/aU3dIKLBce9oM0N4ARg
 ==
X-Google-Smtp-Source: AGHT+IGf4mJQi/Pkq172KKvhvizv91DycK3Z98LfLq1aOuECvPkuZBcxaTLy04LgliSy4dm03LnNE47gnB8kAatp310=
X-Received: by 2002:a05:6902:1103:b0:e5d:c686:fe02 with SMTP id
 3f1490d57ef6-e5dc9043cc3mr6113106276.16.1739806684115; Mon, 17 Feb 2025
 07:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20250212145457.1899954-1-mochs@nvidia.com>
 <CAFEAcA8VN=M1ysRGTEY4dVd-PJHnK+bw8L2zH2x2bt2DKJ-OgQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8VN=M1ysRGTEY4dVd-PJHnK+bw8L2zH2x2bt2DKJ-OgQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 15:37:52 +0000
X-Gm-Features: AWEUYZlcLA8dtHhAFrmXl_uUIP-UO9fl042BMfId-WqLdhUlw57izfGQ4sS-bj4
Message-ID: <CAFEAcA-GhpfX2xg+nCOfeu3+p8rg9QC=9LeP9UyLyY4nPUWS_A@mail.gmail.com>
Subject: Re: [PATCH v4] hw/arm/virt: Support larger highmem MMIO regions
To: "Matthew R. Ochs" <mochs@nvidia.com>
Cc: qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com, 
 nathanc@nvidia.com, qemu-arm@nongnu.org, ddutile@redhat.com, 
 eric.auger@redhat.com, nicolinc@nvidia.com, ankita@nvidia.com, 
 philmd@linaro.org, gshan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Mon, 17 Feb 2025 at 15:35, Peter Maydell <peter.maydell@linaro.org> wrote:
> /* If changing this, update the docs for highmem-mmio-size */
> #define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 512
> #define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
>
> and use it in the definition of extended_memmap[] and in
> the "if (size < ...)" test for the "smaller than default" check.
>
> Have the error message say
>    "highmem_mmio_size cannot be set to a lower value than the default (%d GiB)",
>    DEFAULT_HIGH_PCIE_MMIO_SIZE_GB

...or better, use size_to_str() from qemu/cutils.h,
which will pretty-print a number into a human-readable
form with a GiB or whatever suffix.

thanks
-- PMM

