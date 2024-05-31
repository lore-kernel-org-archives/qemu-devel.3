Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D74C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD1X8-0006Mp-Sv; Fri, 31 May 2024 08:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD1X6-0006L7-Vv
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:38:57 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD1X5-0001Se-3V
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:38:56 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so3462915a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717159132; x=1717763932; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wFesz+GthVT/XVc7GA+a3KCltFqP8x1o0+2zRLsWf64=;
 b=F2HLaq84pdcET4KqwyIQ8K6JxeVKbXeeq/AeWIxNBZbNrta1FYelkQWMzuKCVSNYUV
 q5wsSYsMmAIrF5rKpq2J5gmxdJwaystgwFzjsAXMikkaaWhg1WCD0bn8exAP+g49ESPc
 UMu5n4WrIeGj4ltxCXMK/ChifKkU5VKccAxG6dpUdwUNI3i3Dz/+2fjKBIGLBiUP/LWL
 UHXapf5+fC/AnBYLC2fiMCjJnUY6p8ViYqRW9zlAQhLmdfn7/eNp7vkLM0HGaXhCMCcP
 s8vBdraZJRAGx/kvrX9Yq1pH+XYw+gipPamHbRKW4bYUoS/XV4e6YVi3dmrEMO5XNKJT
 25Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717159132; x=1717763932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wFesz+GthVT/XVc7GA+a3KCltFqP8x1o0+2zRLsWf64=;
 b=dZWxCRpEYiXRJ9Fc9is5FKGm/paJy1L9H5csK3Ok4WuouvMT8iLHT+5tV5W1/jQ4iF
 jCwP2Q1FIZXnlVq0Fb3nsB79VsRUIIV5ELIcdPIoUl/Hrif/Eb1skuwOPDHHGydZIiQD
 CEOGStEcitdte9sUuGsoKJJv2bMZuZMNyDwTaHDaa+vgNdq2SxXZjH8fspFcruD6bDz+
 NN4nRxh0a7ewCa59uyaLq0btqT8DBKm8CnY+FMCvKFCdreWusVVBALb/h6EGB26KmcPk
 KgrpjTXTxoFZzNmsabCWbeKyOoWd8kkmv2rqhsXiFfOXmLwRvMdKYI3NKODzu/QtZ19T
 0FZw==
X-Gm-Message-State: AOJu0Yzk5zrN71RLSzsT97GHqRHxKa2pDOGn2dmh8KNeVH3nfbr3podG
 ieXdu01L3dJivKFWRNN9g8W8IMCCdMf3niw3gKiltmddz0xNvOEezCo26FF2C/SXvWn4HFDmDI5
 bluQs/cDofA11Qlxgy369NOAkwTYqKW0v7S9Nvg==
X-Google-Smtp-Source: AGHT+IEGMwU+mlzGAN0W8/ApdPXEe1o1wtBJ4s8GKLbjMsZsongaHeZdCd9JsEDacO+9BCY0qMWtlOGIh+2pwxlVULs=
X-Received: by 2002:a50:cd9a:0:b0:578:5c1e:45e5 with SMTP id
 4fb4d7f45d1cf-57a363b66eemr1880426a12.9.1717159131790; Fri, 31 May 2024
 05:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687782442.git.mst@redhat.com>
 <6bda41a69bdcee8ff7dcf75df2f9647ce55908ab.1687782442.git.mst@redhat.com>
 <CAFEAcA-EbD2GLMuS-t_qeDFYM5z3NT-_zCKRNZ8TqjWRiRD+Ww@mail.gmail.com>
In-Reply-To: <CAFEAcA-EbD2GLMuS-t_qeDFYM5z3NT-_zCKRNZ8TqjWRiRD+Ww@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 13:38:39 +0100
Message-ID: <CAFEAcA-u4sytGwTKsb__Y+_+0O2-WwARntm3x8WNhvL1WfHOBg@mail.gmail.com>
Subject: Re: [PULL 04/53] hw/cxl: Add clear poison mailbox command support.
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Fan Ni <fan.ni@samsung.com>, Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

Ping! This looks like it should be an easy one-liner fix
for a Coverity-detected read-from-bogus-memory bug --
could one of the CXL folks have a look at it and send
a patch, please ?

thanks
-- PMM

On Fri, 3 May 2024 at 13:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 26 Jun 2023 at 13:28, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Current implementation is very simple so many of the corner
> > cases do not exist (e.g. fragmenting larger poison list entries)
>
> Hi; Coverity has just spotted what looks like a bug in this
> function (CID 1544772) where we write bogus data from the host
> stack into guest memory):
>
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index ab600735eb..d751803188 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -947,6 +947,42 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
> >       */
> >  }
> >
> > +static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> > +{
> > +    MemoryRegion *vmr = NULL, *pmr = NULL;
> > +    AddressSpace *as;
> > +
> > +    if (ct3d->hostvmem) {
> > +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > +    }
> > +    if (ct3d->hostpmem) {
> > +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > +    }
> > +
> > +    if (!vmr && !pmr) {
> > +        return false;
> > +    }
> > +
> > +    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
> > +        return false;
> > +    }
> > +
> > +    if (vmr) {
> > +        if (dpa_offset < memory_region_size(vmr)) {
> > +            as = &ct3d->hostvmem_as;
> > +        } else {
> > +            as = &ct3d->hostpmem_as;
> > +            dpa_offset -= memory_region_size(vmr);
> > +        }
> > +    } else {
> > +        as = &ct3d->hostpmem_as;
> > +    }
> > +
> > +    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
> > +                        CXL_CACHE_LINE_SIZE);
>
> We've passed '&data' to address_space_write(), which means
> "read from the address on the stack where the function
> argument 'data' lives", so instead of writing 64 bytes of
> data to the guest , we'll write 64 bytes which start with
> a host pointer value and then continue with whatever happens
> to be on the host stack after that.
>
> I assume the intention was "data", not "&data"...

thanks
-- PMM

