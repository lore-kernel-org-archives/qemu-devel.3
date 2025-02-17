Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC110C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 15:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk3AL-0003tg-GR; Mon, 17 Feb 2025 10:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk3AK-0003t4-2d
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:36:12 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk3AG-0003nL-4g
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:36:11 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6f768e9be1aso44556397b3.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739806567; x=1740411367; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q/SmX+4/x7nNo6mf4bgOhCg6hutnga5O426Jzw+klLU=;
 b=FRKpFud2XRfP+5xdxW4UrZzDZj/K5HEe2mjuZvfs0Tgu2WBA4snp935L59m8+0gTo0
 yh9ptEwjgdVT1+AGiXoDOHKOoCtqD/pdfJvxpclmmEFzIqguQ2n27b/DNIlLQHDHDzOK
 P65rpk+fv2KqbBjaLA98lKKhkrXZk0zg/gNT2GZewKgtbHJPzxRnVKdmlFKWNGNdVwEM
 wJV7BX2uG4Yl2j6uaUjUXdksu8J8OSGCbMkP+AaYfSXB996xqd/5ztohvlcHW4JHwJ/l
 z0AYLH+O3N09Z/6zaLZ4iMkHuM4BYFq2hdE23Btgyt78ZBaR8iI8v/q3dHgTEA+YGFL7
 TfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739806567; x=1740411367;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q/SmX+4/x7nNo6mf4bgOhCg6hutnga5O426Jzw+klLU=;
 b=WLrWSJSLgxJtGoRx3yyP7l5XR20XuhumsKV8ZZpcu289FiUJT9tJocee0SiIJTP2wM
 eTJe6F618Kt4hDAdSsv2Fzx+S0MZGBgncPrBoEa4Q3EZN9zKjfpQcxj4NqdKc4mho3VI
 07ixN+YZa1t1wUVC8uSVnpVG/x0QHRDu3flG/9hAi1q119AhqRBn9epfI6QV5smpaXvl
 K2IKEDiVkdDYNbYBLLdnf2oi21ClltLnDpihTb5FPqOqPXtz/Qy66XjBWcJx1wRPsLxr
 5H1EBliui0O1sqfomUVEQpShwdA9HT65R1w/3rpmg6ngRvtmKGWEdjqt4jJvOhK/GfjJ
 +7sw==
X-Gm-Message-State: AOJu0YxpDSf+XfJdlFuW7cyE772qttUYI/rPDA9LbGlvrUl3dQ+unVH0
 vg0aDPbcbCr7xd7g/rVN3+wiSjHTlbu8d/rdXBy8ppeyz5lu4n5jtbLj5aa7EX3jxegJyIrc1/a
 jzn3VxJBCCllnAlh970eutZSA9rd8mI7h4WhBXA==
X-Gm-Gg: ASbGnctYyC+f9VySP5rI1Sk8vPsv1b4g+kv02r8RGfJ5JE1lCMhmkHsiPj91+esJPgz
 8h3iLoAQU/A6lRC3c223wYN1n5I5TH5USc+C7xeTYMnaVPDTFnbNvO+y8y6lj9N7RX8hOEo+wqg
 ==
X-Google-Smtp-Source: AGHT+IGkoSLO4IeSNuiHx/pqdWke4LXVGVwGw33orN+DYy1sj6bo7Bem2wjgfvHognTBmIsmEJY/sRuFV20LAV9m1og=
X-Received: by 2002:a05:6902:843:b0:e5d:c697:8808 with SMTP id
 3f1490d57ef6-e5dc69789eamr9926292276.18.1739806566683; Mon, 17 Feb 2025
 07:36:06 -0800 (PST)
MIME-Version: 1.0
References: <20250212145457.1899954-1-mochs@nvidia.com>
In-Reply-To: <20250212145457.1899954-1-mochs@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 15:35:55 +0000
X-Gm-Features: AWEUYZmVuWh4m87DgtYJZdFtCG9lTUjCZM0LWlFJiKnUrbgAJXiTcKzFCUlofB4
Message-ID: <CAFEAcA8VN=M1ysRGTEY4dVd-PJHnK+bw8L2zH2x2bt2DKJ-OgQ@mail.gmail.com>
Subject: Re: [PATCH v4] hw/arm/virt: Support larger highmem MMIO regions
To: "Matthew R. Ochs" <mochs@nvidia.com>
Cc: qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com, 
 nathanc@nvidia.com, qemu-arm@nongnu.org, ddutile@redhat.com, 
 eric.auger@redhat.com, nicolinc@nvidia.com, ankita@nvidia.com, 
 philmd@linaro.org, gshan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 12 Feb 2025 at 14:55, Matthew R. Ochs <mochs@nvidia.com> wrote:
>
> The MMIO region size required to support virtualized environments with
> large PCI BAR regions can exceed the hardcoded limit configured in QEMU.
> For example, a VM with multiple NVIDIA Grace-Hopper GPUs passed through
> requires more MMIO memory than the amount provided by VIRT_HIGH_PCIE_MMIO
> (currently 512GB). Instead of updating VIRT_HIGH_PCIE_MMIO, introduce a
> new parameter, highmem-mmio-size, that specifies the MMIO size required
> to support the VM configuration.
>
> Example usage with 1TB MMIO region size:
>         -machine virt,gic-version=3,highmem-mmio-size=1T
>
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> v4: - Added default size to highmem-mmio-size description
> v3: - Updated highmem-mmio-size description
> v2: - Add unit suffix to example in commit message
>     - Use existing "high memory region" terminology
>     - Resolve minor braces nit
>
>  docs/system/arm/virt.rst |  4 ++++
>  hw/arm/virt.c            | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index e67e7f0f7c50..6ff1de1ecbba 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -138,6 +138,10 @@ highmem-mmio
>    Set ``on``/``off`` to enable/disable the high memory region for PCI MMIO.
>    The default is ``on``.
>
> +highmem-mmio-size
> +  Set the high memory region size for PCI MMIO. Must be a power-of-2 and

Nit: no hyphens in "power of 2" here, or in the error message text.

> +  greater than or equal to the default size (512G).
> +
>  gic-version
>    Specify the version of the Generic Interrupt Controller (GIC) to provide.
>    Valid values are:
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 49eb0355ef0c..d8d62df43f04 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2773,6 +2773,36 @@ static void virt_set_highmem_mmio(Object *obj, bool value, Error **errp)
>      vms->highmem_mmio = value;
>  }
>
> +static void virt_get_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    uint64_t size = extended_memmap[VIRT_HIGH_PCIE_MMIO].size;
> +
> +    visit_type_size(v, name, &size, errp);
> +}
> +
> +static void virt_set_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    uint64_t size;
> +
> +    if (!visit_type_size(v, name, &size, errp)) {
> +        return;
> +    }
> +
> +    if (!is_power_of_2(size)) {
> +        error_setg(errp, "highmem_mmio_size is not a power-of-2");

In these error messages we want to use the property name,
which has hyphens, not underscores.

> +        return;
> +    }
> +
> +    if (size < extended_memmap[VIRT_HIGH_PCIE_MMIO].size) {
> +        error_setg(errp, "highmem_mmio_size is less than the default (%lu)",
> +                   extended_memmap[VIRT_HIGH_PCIE_MMIO].size);

The size member here is a hwaddr, so %lu is the wrong format
string for it (it won't compile on 32-bit hosts). You want
HWADDR_PRIu. Printing 512GB as a decimal integer isn't
very user friendly in any case.

> +        return;
> +    }
> +
> +    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;

Because we set this field to the new size, if we try to
set the property twice, once to a large value and then again
to a value smaller than the first one, we'll print an
odd error message claiming the default value to be something
other than the default value. (Luckily I think you can't
do this via the command line; but you might be able to via QMP.)

Suggestion:

/* If changing this, update the docs for highmem-mmio-size */
#define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 512
#define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)

and use it in the definition of extended_memmap[] and in
the "if (size < ...)" test for the "smaller than default" check.

Have the error message say
   "highmem_mmio_size cannot be set to a lower value than the default (%d GiB)",
   DEFAULT_HIGH_PCIE_MMIO_SIZE_GB

I agree also with Eric that we should update the comment
on extended_memmap[] with e.g.

 * Note that the highmem_mmio_size property will update the
 * high PCIE MMIO size field in this array.

thanks
-- PMM

