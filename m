Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7206EC3ABAC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 13:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAqad-0003CD-T9; Fri, 02 May 2025 09:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAqac-0003Bo-6l
 for qemu-devel@nongnu.org; Fri, 02 May 2025 09:38:06 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uAqaa-0002Ed-0w
 for qemu-devel@nongnu.org; Fri, 02 May 2025 09:38:05 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e75608f945cso953691276.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746193082; x=1746797882; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3luG/UIDY1/GfJNc0Jva/acqJgU7jY8Ei1u63tDiqw=;
 b=WZVqYCpjAFuwQeyjXazYE2TSB1cfXCRtwbp75I0UeHdUuXN4al98TLm4YFhigxBcyY
 5Ct2LC2+D9kKQKl9kaNWADXdw7WPF8e6LrXvOKEuEIBagdzMF+1eOb/s1LiH3XUWTrKd
 IeEHbAAtm7OkI/cpkDz9o4zb/tZb9MkkIVM1pBFaMTCTkx2MmZSz7WMMc66tk0gzSxoW
 ihLt2wEvTs5BU56LEW3hEcHC5pBbs4lEMx8Ed5fsDVzM+oaGyXP3Y0g3JH/Oa7KUU4lU
 TNiBcKg9M7CbqfjhdCn78n+y1yE192NSeaB9BmwyPwVe/lzCJZr3uRBtEjwCFsa3c3kI
 7mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746193082; x=1746797882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3luG/UIDY1/GfJNc0Jva/acqJgU7jY8Ei1u63tDiqw=;
 b=bKUo3H1BK/WZHf74KMiLm2/Zi7+uXCulwQL1r51SAc3u0WzzyAbVE9wG0q9bu8TgCv
 bRxP7Nd8jbthkVGJl45w1Xvkyf46A+9ugblXYnMUsPVadWHVA7/3GoJTz+/aZQCzAAdl
 me1+efm65f9cLjyD0RIsblsRElReBb+iXn07AZKjXXTL3+Shc9MpTbdQxxKMHSEYtkUT
 2/LZtIo4jXXD5cXFyNDiYqeJ7GL5dtMEO1zijp0yFiuEUAqPAVkBcUuoIXjmiCVrmOgV
 UUEEpVaEU6QoKppYW+e7CzhgJYiVjPWylMzrUzTl0ttejQyjXTK07SRuZni99Fau8W3m
 B+9w==
X-Gm-Message-State: AOJu0Yy9ZVSJIyZYsf3DHQyMKGYeivzdfInF8+k2kvIpIlTnMBxeylEm
 JkNAImCWDrpVbjUQb7JOrTmOf9BFt9vo9AjdygcFiBPa3O5IugtikM3vCYKF4HItWW1JgrpNtkq
 QxGGt8OYIV1F2i84VQzsfKS5FBE9cSbm16edDWw==
X-Gm-Gg: ASbGncvwEjav7iH8V8ApmZA7XvFwHIralPpspEkTfFS/y/W+n+xJMcp0+lDPbV5Jm/v
 +ZosruxuyQzfJQ3eRGTvSvZg6mszvSRlPz4/SDPOGGbVO3t0lHkuWT25OHdw0Vcvn4HlsqV0yVU
 B/kA4fybMtM3wMHem2KLglLZY=
X-Google-Smtp-Source: AGHT+IEAWymbvfgJjsvchVISA/zyX5fAi9H/1QIrUO8o9PyH1gy3/M9stAXmBTJWdPRNTa4nFi4ZYanZd8XiD4hkkHA=
X-Received: by 2002:a05:6902:1607:b0:e73:22c4:117b with SMTP id
 3f1490d57ef6-e756566218cmr3817349276.47.1746193082647; Fri, 02 May 2025
 06:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250116145944.38028-1-philmd@linaro.org>
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 May 2025 14:37:51 +0100
X-Gm-Features: ATxdqUEcczldx5jH_6rLsaK17PZJwtYUB2WXlMy9Z2CyZaaALu6Olqh7QjkTdQ8
Message-ID: <CAFEAcA_7KfbhMj4c=HD4m+xivTK4NZcYc0O4NXt6MtVJ6bSitA@mail.gmail.com>
Subject: Re: [PATCH-for-10.1 v2 00/13] hw/arm: Remove virt-2.6 up to virt-2.12
 machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Thu, 16 Jan 2025 at 14:59, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The versioned 'virt' machines up to 2.12 been marked as deprecated
> two releases ago, and are older than 6 years, so according to our
> support policy we can remove them. Remove associated dead code.
>
> Since v1:
> - Corrected disallow_affinity_adjustment removal (Thomas)
> - Do not modify docs/about/removed-features.rst (Thomas & Daniel)
>
> Philippe Mathieu-Daud=C3=A9 (13):
>   hw/arm/virt: Remove deprecated virt-2.6 machine
>   hw/arm/virt: Remove VirtMachineClass::no_pmu field
>   hw/arm/virt: Remove VirtMachineClass::disallow_affinity_adjustment
>   hw/arm/virt: Remove deprecated virt-2.7 machine
>   hw/arm/virt: Remove VirtMachineClass::no_its field
>   hw/arm/virt: Remove deprecated virt-2.8 machine
>   hw/arm/virt: Remove VirtMachineClass::claim_edge_triggered_timers
>     field
>   hw/arm/virt: Remove deprecated virt-2.9 machine
>   hw/arm/virt: Remove deprecated virt-2.10 machine
>   hw/arm/virt: Remove deprecated virt-2.11 machine
>   hw/arm/virt: Remove VirtMachineClass::smbios_old_sys_ver field
>   hw/arm/virt: Remove deprecated virt-2.12 machine
>   hw/arm/virt: Remove VirtMachineClass::no_highmem_ecam field

Applied to target-arm.next, thanks (with the tweak RTH points
out to avoid a compilation failure in patch 3).

-- PMM

