Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE80C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 20:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sONzd-0008Sv-JJ; Mon, 01 Jul 2024 16:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONzb-0008SQ-Dk
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sONzY-0001YJ-GX
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 16:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719867074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NuL3/F3Gh3wS6NyM0pNCxyvoleVqKJ+5sgmqGAHf6l4=;
 b=g4r+5JwP7RE+pajfa7Mq+cS0W+kiIL50aJXlrQAo1+VPpnRA0GZZtGfcNRJGj3E69DXezZ
 iAskGFK69QIx0cQA8oKGd3ZSgPLOkCT1RnVT40dKiR5nLoz2COGQmEj7aZnowYB+bqjj0a
 XSb+6T8tnPlXLegwWkJyTGEBG4JqRiw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-7Tn87Zx9NoOLW9I88mrwPg-1; Mon, 01 Jul 2024 16:51:13 -0400
X-MC-Unique: 7Tn87Zx9NoOLW9I88mrwPg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-424a775ee7fso24675085e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 13:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719867072; x=1720471872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NuL3/F3Gh3wS6NyM0pNCxyvoleVqKJ+5sgmqGAHf6l4=;
 b=mmDMWgckXpZ83m5bD/RVevqmj+cpNVuawwT4fSptGQq3Fei3fKDhkCv2xmoIMhe/D2
 AZHaL5+eHTggJiUTH2f3gBzMgTY+KC6YjAi4k61K5HDfRbLbb6HrBBXf/9fX5O6SWXwe
 XQq2IUOWylxKjeBOd4UdJmZVrWOiTse4Py2p/RkwMVdlqE0SpPC1s0G1XClNupMBMhw+
 SdFVRUzOKbq6r6x74byJ3APtS5waUd0yK/YENwRouxa48o0qotn9ZsLYfJfhu2JcIemL
 eJn7RfuikbXrORmydrQO52m53D3rgNDdPxx1zWN70ZrvBK8MtjFMFvZ5qhPf00Xum5lY
 An3A==
X-Gm-Message-State: AOJu0YztZdU+NULD3/qPhfBgIyYAHR8EVZCrW5LR7c1l7Bdoe7K0GLrH
 61dAIK6hLGX7/5VB20bAWLjnnY61OSbzeYy+PqJj1/+fG84qd66Jff4Q6t7LrsguMbUfJhwyujy
 k+0gFiY88X2NhUmMKI4NeqmFf5bqiowELMRKj86s1ksoBEAAyX3Lzht5BCcyF
X-Received: by 2002:a05:600c:1585:b0:425:7b77:e943 with SMTP id
 5b1f17b1804b1-4257b77ea48mr40107795e9.14.1719867072102; 
 Mon, 01 Jul 2024 13:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+tO2wpo+fxDMqfGQX/vKcWc299/XWCtNKupZrjzMqFXvb8q+O6pSf1OnEIdw1wj41eFhcZw==
X-Received: by 2002:a05:600c:1585:b0:425:7b77:e943 with SMTP id
 5b1f17b1804b1-4257b77ea48mr40107645e9.14.1719867071477; 
 Mon, 01 Jul 2024 13:51:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0cee27sm168279665e9.48.2024.07.01.13.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 13:51:11 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:51:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuke Peng <pykfirst@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/i386/intel_iommu: Block CFI when necessary
Message-ID: <20240701164648-mutt-send-email-mst@kernel.org>
References: <20240625112819.862282-1-pykfirst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625112819.862282-1-pykfirst@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 25, 2024 at 07:28:19PM +0800, Yuke Peng wrote:
> According to Intel VT-d specification 5.1.4, CFI must be blocked when
> Extended Interrupt Mode is enabled or Compatibility format interrupts
> are disabled.
> 
> Signed-off-by: Yuke Peng <pykfirst@gmail.com>
> ---
>  hw/i386/intel_iommu.c         | 28 ++++++++++++++++++++++++++++
>  hw/i386/trace-events          |  1 +
>  include/hw/i386/intel_iommu.h |  1 +
>  3 files changed, 30 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5085a6fee3..dfa2f979e7 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2410,6 +2410,22 @@ static void vtd_handle_gcmd_ire(IntelIOMMUState *s, bool en)
>      }
>  }
>  
> +/* Handle Compatibility Format Interrupts Enable/Disable */
> +static void vtd_handle_gcmd_cfi(IntelIOMMUState *s, bool en)
> +{
> +    trace_vtd_cfi_enable(en);
> +
> +    if (en) {
> +        s->cfi_enabled = true;
> +        /* Ok - report back to driver */
> +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_CFIS);
> +    } else {
> +        s->cfi_enabled = false;
> +        /* Ok - report back to driver */
> +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_CFIS, 0);
> +    }
> +}
> +
>  /* Handle write to Global Command Register */
>  static void vtd_handle_gcmd_write(IntelIOMMUState *s)
>  {
> @@ -2440,6 +2456,10 @@ static void vtd_handle_gcmd_write(IntelIOMMUState *s)
>          /* Interrupt remap enable/disable */
>          vtd_handle_gcmd_ire(s, val & VTD_GCMD_IRE);
>      }
> +    if (changed & VTD_GCMD_CFI) {
> +        /* Compatibility format interrupts enable/disable */
> +        vtd_handle_gcmd_cfi(s, val & VTD_GCMD_CFI);
> +    }
>  }
>  
>  /* Handle write to Context Command Register */
> @@ -3304,6 +3324,7 @@ static const VMStateDescription vtd_vmstate = {
>          VMSTATE_BOOL(dmar_enabled, IntelIOMMUState),
>          VMSTATE_BOOL(qi_enabled, IntelIOMMUState),
>          VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
> +        VMSTATE_BOOL(cfi_enabled, IntelIOMMUState),
>          VMSTATE_BOOL(intr_eime, IntelIOMMUState),
>          VMSTATE_END_OF_LIST()
>      }


Looks like this will break migration compat.


The normal waywhould be that we use something like
VMSTATE_UINT32_TEST() or subsections for the new vmstate field.
sometimes it's possible to re-generate the field from
the registers, then there's no need to add a new field
to migration at all, instead calculate it in vtd_post_load.



> @@ -3525,6 +3546,12 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
>  
>      /* This is compatible mode. */
>      if (addr.addr.int_mode != VTD_IR_INT_FORMAT_REMAP) {
> +        if (iommu->intr_eime || !iommu->cfi_enabled) {
> +            if (do_fault) {
> +                vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_COMPAT, 0);
> +            }
> +            return -EINVAL;
> +        }
>          memcpy(translated, origin, sizeof(*origin));
>          goto out;
>      }
> @@ -3950,6 +3977,7 @@ static void vtd_init(IntelIOMMUState *s)
>      s->root_scalable = false;
>      s->dmar_enabled = false;
>      s->intr_enabled = false;
> +    s->cfi_enabled = false;
>      s->iq_head = 0;
>      s->iq_tail = 0;
>      s->iq = 0;
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 53c02d7ac8..ffd87db65f 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -57,6 +57,7 @@ vtd_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova, uint6
>  vtd_dmar_enable(bool en) "enable %d"
>  vtd_dmar_fault(uint16_t sid, int fault, uint64_t addr, bool is_write) "sid 0x%"PRIx16" fault %d addr 0x%"PRIx64" write %d"
>  vtd_ir_enable(bool en) "enable %d"
> +vtd_cfi_enable(bool en) "enable %d"
>  vtd_ir_irte_get(int index, uint64_t lo, uint64_t hi) "index %d low 0x%"PRIx64" high 0x%"PRIx64
>  vtd_ir_remap(int index, int tri, int vec, int deliver, uint32_t dest, int dest_mode) "index %d trigger %d vector %d deliver %d dest 0x%"PRIx32" mode %d"
>  vtd_ir_remap_type(const char *type) "%s"
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 7fa0a695c8..38e20d0f2c 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -294,6 +294,7 @@ struct IntelIOMMUState {
>  
>      /* interrupt remapping */
>      bool intr_enabled;              /* Whether guest enabled IR */
> +    bool cfi_enabled;               /* Whether CFI is enabled */
>      dma_addr_t intr_root;           /* Interrupt remapping table pointer */
>      uint32_t intr_size;             /* Number of IR table entries */
>      bool intr_eime;                 /* Extended interrupt mode enabled */
> -- 
> 2.34.1


