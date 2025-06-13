Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B020FC61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 12:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ3aC-0007xa-QL; Fri, 13 Jun 2025 08:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ3a4-0007tN-Rr
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 08:32:30 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ3Zx-0004ws-UI
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 08:32:24 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70e6bddc30aso18232807b3.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 05:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749817934; x=1750422734; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=07JVhg802iRo9r8/K0Jmv569qCvievwFPfErLy0AXps=;
 b=IxgZYgRvJ+/arqG61DXQKdHYJ7zmz2EVLfCpLyzeZxw4i22OgZJJ1jJIBxmFKTeEF1
 AaAXjzP27HVnMNJfCU0zLqrCokf/LFpANxs5NQtJXLgaCDN5LOx5WqQSmJAUvdlSawcn
 Jx8Gbp+vF4dpXAqzgjJq66or3f7i4kgq4fofq5ITZEfp8N9eM7ToDMHoSeT3pY3eqWfw
 eigo9COxi+Mw5yVZ0KEli+Erne9eSJZtr7PowJRGToSaov/tHfhku8pXKDdKwU8Qgp6J
 VdWW0niXB5s/yOIQpHpiUsHDC18maloMiDFBzPcPd04Wo19f1I0tXBTx2qJqosrV3A8v
 1zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749817934; x=1750422734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=07JVhg802iRo9r8/K0Jmv569qCvievwFPfErLy0AXps=;
 b=F92qAIR3k7N3KDrBrmz0OxY4Q8TcTvuSZfknOGAVaGpObP+TlWZxbDhpJqKWJvT7vU
 hR4WJeOrPVV3sXR/vWrTWuetGdR8rC5r7dVs1hr63RtvU273b7u2ba6xPiWvjUVHnXVS
 6f4ZAgBB+qgo7eW/nikX5duEhTz6t/L+gYiukFelygHnLuU6GQQxvv5ASEZMayaeCIPP
 Js9qPmQfQ75/I4pOzl+JlcRP1ktTkqA7mh1xwDFDUY7TXyZyyuBC31Gl8jCGBdszTpty
 dbGxEr5GvIdloO/W9peYU02DJQhfE1SfjIc+7ymvMRryYYfJb9ZRwI0pTRzmSDfQ22A7
 8zZw==
X-Gm-Message-State: AOJu0Yzan4aQ5yYBbn8+KHv2laKgmA0HLmJeaQoi6Fd5vVtX5e9kWiw6
 Wj5tl7PYf9NbeiIFQm4Dex1gATaxtJRZxejrY7SR2i61LqL+BfQSeVSJpEANTs+rPmlnulN3x/W
 D4+td3gB5hZ/zol9QTQCaTOe6tS760ZQY6KgEq6oTGA==
X-Gm-Gg: ASbGncumF1OfqFRdlvPfnseuHYwLBsHh91cCDf3ZGe34Ab4fWrWVvoTQcFZoVp5iTM9
 Fxe172VaEFnwr6l1VG7Yhq1ZsEzeBbO/X8O4JOT+RN5993zStBExUklpYVr6C6LqbMglyUgN49w
 OAga0GJfuYS+k7zlA59ExwQFKsXGpK27biaID939JebbT3
X-Google-Smtp-Source: AGHT+IFAh/pRObNEqsEHzHc9PX7qF1sWhz9Pj9Np6nag1q6YhuyL+Lq3qJpFmsYoU3w5VHRtSeualJtj+JZoQa8/Ww8=
X-Received: by 2002:a05:690c:f96:b0:70e:142d:9c52 with SMTP id
 00721157ae682-7116372329emr42840937b3.22.1749817934334; Fri, 13 Jun 2025
 05:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
 <20250612134338.1871023-5-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250612134338.1871023-5-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 13:32:03 +0100
X-Gm-Features: AX0GCFtY0-n-3gf_nsaxJ4DbwNp3JIuQBsYWobX7KaEQ6RzpFw0oR2DA4cIwVXQ
Message-ID: <CAFEAcA8xVQUnReg-3jYENLmOMG_PeJ-ACLQa0dRoLBzxQ+9Svg@mail.gmail.com>
Subject: Re: [PATCH v15 4/4] qtest/cxl: Add aarch64 virt test for CXL
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, mst@redhat.com, 
 Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Thu, 12 Jun 2025 at 14:45, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Add a single complex case for aarch64 virt machine.
> Given existing much more comprehensive tests for x86 cover the
> common functionality, a single test should be enough to verify
> that the aarch64 part continue to work.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> ---
> v15: Dropped tags due to changes in patches 2 and 3.
> ---
>  tests/qtest/cxl-test.c  | 59 ++++++++++++++++++++++++++++++++---------
>  tests/qtest/meson.build |  1 +
>  2 files changed, 47 insertions(+), 13 deletions(-)
>
> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index a600331843..c7189d6222 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -19,6 +19,12 @@
>      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
>      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
>
> +#define QEMU_VIRT_2PXB_CMD \
> +    "-machine virt,cxl=on -cpu max " \
> +    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> +    "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> +    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> +
>  #define QEMU_RP \
>      "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
>
> @@ -197,25 +203,52 @@ static void cxl_2pxb_4rp_4t3d(void)
>      qtest_end();
>      rmdir(tmpfs);
>  }
> +
> +static void cxl_virt_2pxb_4rp_4t3d(void)
> +{
> +    g_autoptr(GString) cmdline = g_string_new(NULL);
> +    char template[] = "/tmp/cxl-test-XXXXXX";
> +    const char *tmpfs;
> +
> +    tmpfs = mkdtemp(template);

We prefer g_mkdtemp() or g_dir_make_temp() over raw mkdtemp(),
I think. Other tests in this file use g_dir_make_tmp().

Also you aren't checking whether it failed.

> +
> +    g_string_printf(cmdline, QEMU_VIRT_2PXB_CMD QEMU_4RP QEMU_4T3D,
> +                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
> +                    tmpfs, tmpfs);
> +
> +    qtest_start(cmdline->str);

We never change the GString and only use its C representation,
so I think it's simpler to use
  g_autofree char *cmdline = NULL;
  ...
  cmdline = g_strdup_printf(...);

But I see all the other tests in this file are written this
way, so I'm ok with staying consistent to that here.

-- PMM

