Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8F7C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2sIh-0006DL-PC; Fri, 03 May 2024 08:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2sIa-0006Bu-Mw
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:46:02 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2sIQ-0004nv-OF
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:45:58 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a599a3b233cso51084766b.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714740348; x=1715345148; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=81/SzfK2ki8CXYvnsIczrSoQ6fsrU9n/ep797CFCWgE=;
 b=vgF7nhQdr/iSAtxyQQniFJjbwVw2ArpEjCQpfPT59a0b32FU3qJmfJl1nnYBoU/IRL
 TNNtnY6WMCTbWa8Bc8QNZZTvDnE857B6Wkgo/QEPVLR1F2svhpzyVnG0bFHJ35twd90+
 V9ij82qEmQHemrnr6kJG9RlEqenJWpMfOPR0tf4DgoxUdFBzO8vgjNVTl9cMscBH89Ap
 W5LRaCiO38nYkpEM0aTyTWQr99i8qsMlq3UzKA1/n6O0ZOY6/Jnlp9YK7ACXmM3T1NkE
 b7iXMkL63I3BpGIJ0zQOVh0yM3kGCa6kc/9wOp1YwsTffA2yHEGOtg4MumWPEXLUT7sH
 /S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714740348; x=1715345148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=81/SzfK2ki8CXYvnsIczrSoQ6fsrU9n/ep797CFCWgE=;
 b=XDXkNJscYxn5RT2SFSHNFsS7AgNFNqEZELNT+S2VkgCmgkHsIy0UkkOkkv247uhXPA
 39t0+X2V6xXsxZouaHvQx/TwyaZZbnGPP9BnDBut7izYYGoZzOS7W66VbZakh8RhnXoa
 WiDctX7EbIrr1GPJgGGGo05f0KnsBbA00r4I2rtZ8kyzL6tp/OvlyySr5ri6IERJqcZN
 TWKvqipCjok3Fb6/EqeunlQ3Qef+gQAbXQNaaqTFoe/yjK0vWxP4dqaW0bVSv6ZYN/Ng
 CIZ/a0eLWbmTvXghAz+M6PMnyhIw5lhkz1oW6xLYewoOBW19nNCacsNHWEackZrmgv0y
 TvCA==
X-Gm-Message-State: AOJu0YygfhJ4EupF21JD4yWGNlkIB4pRwgHwr35wr+O4vFNB61rCSePA
 uvNbkCPv5e6KsMZXILKlaEWnWxapRV+JVsHe7LurJRwuTuKNAoFtAWAA/26T4PejIFfZs9dwh/3
 Q3bTAvIbrRC52+xjuTD0uhj5wsZr0r2AE8joxbK9yE/TX/ZH0
X-Google-Smtp-Source: AGHT+IGHP50HP4bW09ZbAqWkF1zyIH3ewTjKgYy6BQ8psp0T0305GxHPlaULMxefjqtjgv3+VIn+CQhWop0pFA2xbwA=
X-Received: by 2002:a50:a693:0:b0:56e:2cb6:480e with SMTP id
 e19-20020a50a693000000b0056e2cb6480emr1976183edc.38.1714740348510; Fri, 03
 May 2024 05:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687782442.git.mst@redhat.com>
 <6bda41a69bdcee8ff7dcf75df2f9647ce55908ab.1687782442.git.mst@redhat.com>
In-Reply-To: <6bda41a69bdcee8ff7dcf75df2f9647ce55908ab.1687782442.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2024 13:45:37 +0100
Message-ID: <CAFEAcA-EbD2GLMuS-t_qeDFYM5z3NT-_zCKRNZ8TqjWRiRD+Ww@mail.gmail.com>
Subject: Re: [PULL 04/53] hw/cxl: Add clear poison mailbox command support.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Fan Ni <fan.ni@samsung.com>, Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 26 Jun 2023 at 13:28, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Current implementation is very simple so many of the corner
> cases do not exist (e.g. fragmenting larger poison list entries)

Hi; Coverity has just spotted what looks like a bug in this
function (CID 1544772) where we write bogus data from the host
stack into guest memory):

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ab600735eb..d751803188 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -947,6 +947,42 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>       */
>  }
>
> +static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> +{
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    AddressSpace *as;
> +
> +    if (ct3d->hostvmem) {
> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    }
> +
> +    if (!vmr && !pmr) {
> +        return false;
> +    }
> +
> +    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
> +        return false;
> +    }
> +
> +    if (vmr) {
> +        if (dpa_offset < memory_region_size(vmr)) {
> +            as = &ct3d->hostvmem_as;
> +        } else {
> +            as = &ct3d->hostpmem_as;
> +            dpa_offset -= memory_region_size(vmr);
> +        }
> +    } else {
> +        as = &ct3d->hostpmem_as;
> +    }
> +
> +    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
> +                        CXL_CACHE_LINE_SIZE);

We've passed '&data' to address_space_write(), which means
"read from the address on the stack where the function
argument 'data' lives", so instead of writing 64 bytes of
data to the guest , we'll write 64 bytes which start with
a host pointer value and then continue with whatever happens
to be on the host stack after that.

I assume the intention was "data", not "&data"...

thanks
-- PMM

