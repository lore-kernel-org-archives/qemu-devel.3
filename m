Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7574ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzWh-0002d1-0e; Tue, 10 Sep 2024 07:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1snzWb-0002MI-9r
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1snzWZ-0007gL-Dh
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725969549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=01NQPZIJCJdBgDvZ+UoSUBxgd09rbVgEbnkSLpVV3Yc=;
 b=NZJ1Zc3ztWD3Mlfb+g5ke3oiexhl7ifDcSMbLOR7Ja4teN0YtM3vATkG1yER9VB+5nlVlL
 3qD/xdHHLQXqOS9qGFuEBMyueczvxs6wVwEo2tPFgaY39vrfseMD22EWC2WkYLY0ziE3ny
 LJ5Pqd+4oM1odfCkTyke6JXziyPlFoI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-lBjlK7K_NKOCLKWb5mfbjQ-1; Tue, 10 Sep 2024 07:59:08 -0400
X-MC-Unique: lBjlK7K_NKOCLKWb5mfbjQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-374c44e58a9so2881695f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725969547; x=1726574347;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01NQPZIJCJdBgDvZ+UoSUBxgd09rbVgEbnkSLpVV3Yc=;
 b=QFpZlBK+WsCN+ou0XPft6yLGcToeGQtwX7u+0ZxLk+OzW0oWjQIW9VUfGxzMI23e/g
 TG05JMwQvpke5wr8jFoq5n9Swn6YJs074u34QGTnUxjOvbph6+rlPySQMYI3jk04B/XO
 pOSof969XWGsiF5Ls0mtmBiw0HQWL+TrEWE3URt0xoO7VkqZp1R55E3tL5pt4jYA3+nm
 7407biBAQV83DceG0T/U3oIKs8T/Vn5Ug9NzTjQG0g13VWZSZZZW5ppD/oSoaSPHhUny
 UuxvQTbnwAx6RaoqQmqGJYCymBhqP+As1E5RDV0FookB0hkAC0REMYiRBDUer2uAvVtq
 3shQ==
X-Gm-Message-State: AOJu0YzWE4ez4b8D/11aTNDwGTN6IYoPQLbniewB0Np59CGQB09940b+
 y1V3ZSvCu/1mpwiOpgTF1lVJIJQosCTYXSoUk9r1ZSDu/7w0JlDyi+j+kgR2aFoN1T/EIp2lQBt
 NXWtqhaoxik71jvFUEm7xWSLuaZeTXFer/1cHFsSr6ZvX0Ne9uRFh
X-Received: by 2002:adf:eb92:0:b0:371:c51a:3b2a with SMTP id
 ffacd0b85a97d-378895c2b67mr8580663f8f.4.1725969546818; 
 Tue, 10 Sep 2024 04:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWlbbqFr7NyZ/LhM6X4dbLgnLgF+hXYivsciDnbTHln4miZR0onDwbiI7M0keKQMBBipQRWQ==
X-Received: by 2002:adf:eb92:0:b0:371:c51a:3b2a with SMTP id
 ffacd0b85a97d-378895c2b67mr8580629f8f.4.1725969545891; 
 Tue, 10 Sep 2024 04:59:05 -0700 (PDT)
Received: from redhat.com ([31.187.78.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d365fsm8701035f8f.82.2024.09.10.04.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 04:59:05 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:59:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuke Peng <pykfirst@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: Re: [PATCH v2] hw/i386/intel_iommu: Block CFI when necessary
Message-ID: <20240910075656-mutt-send-email-mst@kernel.org>
References: <20240708100816.1916346-1-pykfirst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708100816.1916346-1-pykfirst@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 08, 2024 at 06:08:16PM +0800, Yuke Peng wrote:
> According to Intel VT-d specification 5.1.4, CFI must be blocked when
> Extended Interrupt Mode is enabled or Compatibility format interrupts
> are disabled.
> 
> Signed-off-by: Yuke Peng <pykfirst@gmail.com>

The rename is fine.
The issue with the patch is the extra section.
We need to avoid adding it for compat machine types.

Do you have the time to address this?

> ---
> Changes in v2:
> - Use subsections for the cfi_enabled field.
> - Link to v1: https://lore.kernel.org/qemu-devel/20240625112819.862282-1-pykfirst@gmail.com/
> 
> ---
>  hw/i386/intel_iommu.c         | 53 +++++++++++++++++++++++++++++++++--
>  hw/i386/trace-events          |  1 +
>  include/hw/i386/intel_iommu.h |  1 +
>  3 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5085a6fee3..af9c864bde 100644
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
> @@ -3283,7 +3303,25 @@ static int vtd_post_load(void *opaque, int version_id)
>      return 0;
>  }
>  
> -static const VMStateDescription vtd_vmstate = {
> +static bool vtd_cfi_needed(void *opaque)
> +{
> +    IntelIOMMUState *iommu = opaque;
> +
> +    return iommu->intr_enabled && !iommu->intr_eime;
> +}
> +
> +static const VMStateDescription vmstate_vtd_cfi = {
> +    .name = "iommu-intel/cfi",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vtd_cfi_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_BOOL(cfi_enabled, IntelIOMMUState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription vmstate_vtd = {
>      .name = "iommu-intel",
>      .version_id = 1,
>      .minimum_version_id = 1,
> @@ -3306,6 +3344,10 @@ static const VMStateDescription vtd_vmstate = {
>          VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
>          VMSTATE_BOOL(intr_eime, IntelIOMMUState),
>          VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * []) {
> +        &vmstate_vtd_cfi,
> +        NULL
>      }
>  };
>  
> @@ -3525,6 +3567,12 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
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
> @@ -3950,6 +3998,7 @@ static void vtd_init(IntelIOMMUState *s)
>      s->root_scalable = false;
>      s->dmar_enabled = false;
>      s->intr_enabled = false;
> +    s->cfi_enabled = false;
>      s->iq_head = 0;
>      s->iq_tail = 0;
>      s->iq = 0;
> @@ -4243,7 +4292,7 @@ static void vtd_class_init(ObjectClass *klass, void *data)
>      X86IOMMUClass *x86_class = X86_IOMMU_DEVICE_CLASS(klass);
>  
>      dc->reset = vtd_reset;
> -    dc->vmsd = &vtd_vmstate;
> +    dc->vmsd = &vmstate_vtd;
>      device_class_set_props(dc, vtd_properties);
>      dc->hotpluggable = false;
>      x86_class->realize = vtd_realize;
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


