Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30429C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 06:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMLwX-0000e9-By; Wed, 26 Jun 2024 02:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieudrif.etu@gmail.com>)
 id 1sMLwV-0000dH-R3
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 02:15:43 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <clement.mathieudrif.etu@gmail.com>)
 id 1sMLwT-0003hB-RO
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 02:15:43 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52cdb0d8107so5894315e87.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 23:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719382537; x=1719987337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aSyGffkMjerVf/jIJYa5CWxy3pFcK+I+Sdt2TMFAIjs=;
 b=ZZ24673K6UIbBwqtSfvAqsZT0AVJXebYUh7Zwjwd+Nm3qR/x5pLNTA3KFTt5HA3JIJ
 x8XHXDBoLG45Vu04Tf86qCfG0zZfrtxMtnbpvpcnMrfWA0iIp3byNw55Zqd9ccYZTCaW
 VjorIfVpHiee6NjxPOgZ4owXZc4Go7ISYSH3Y13IuFgkyfLvPX5aa4RWJO/Ox63M37qc
 Wme71vMYgwxy2ZcSyvlHcOhRX1aNZo7YHEtnxigWv8FIUSASfHhWFURyBkJ2ZMlv7nG7
 2GECH6dpxXXAsKGpGEeom2HiZ4JALCTZO3JD+l8KaZXXC7XG4NwiAn5SZ1mPP4iQjF5H
 gGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719382537; x=1719987337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aSyGffkMjerVf/jIJYa5CWxy3pFcK+I+Sdt2TMFAIjs=;
 b=ZpzDIrEKy3wuFObh8xx98qlNg8m1MIIUXSV10I9POFCXKwvHsXO7yvQgDDkubomKqV
 lzU/ESkEZ7VnjOEA7ZswxbVJWn2lFJLTo1sqwD4kQZtAUgbhjTt8dm25PXErCo+Wjivh
 08RqSCKAIsrqqweY99fcFgHzHg9Xfw3k7bXPcJnkvzCHjRPEF7UmCQMgy1Etcs6UTzn8
 8Lzh11zSQlLHVvI9URbNnIZnGsr2MBBiA4iO223Tz2QmRfIOmh+7b9Y4+Gx6wJ1fw0Mt
 5KONdet4uVS3aTlpwrSDEOlt4u9VllBXalAu8TOL/zVOAAFK6kd2qq8H2eWE1PMg9pM+
 /wog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeYzD6DpZ9U9iq0l/+0hGZCJx4i9RfcsfpBozCYufXmysGO2ZpMeNrSHSqsNeoN0pKD/+uD9r9T+qlWQQxz6EtWVwfe8U=
X-Gm-Message-State: AOJu0Yzwh+lRSBbPt+bqVS/EblIdHb8EOUtOR9h6ufQUTCbCH/35qHU0
 Fli1rhob0Y7v6JYn80wYDJfYi/w1I7TPTEhrUkEXifLH0A/ZwEWg
X-Google-Smtp-Source: AGHT+IFHfnZRfkbnHqv9BHu9/0fZpa4JW6LmC3d8Tun/uMGu7nYbYobP45lzWyCUxOpk4opvUQV0ww==
X-Received: by 2002:ac2:5f63:0:b0:52c:a002:1afc with SMTP id
 2adb3069b0e04-52cdf7f66f2mr6331435e87.34.1719382537169; 
 Tue, 25 Jun 2024 23:15:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:136:9c60:df8c:dbac:5023:d101?
 ([2a01:e0a:136:9c60:df8c:dbac:5023:d101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c823c2c1sm12493325e9.7.2024.06.25.23.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 23:15:36 -0700 (PDT)
Message-ID: <0baa7fcd-0b86-4ce0-88c9-4954363c2616@gmail.com>
Date: Wed, 26 Jun 2024 08:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/intel_iommu: Block CFI when necessary
To: Yuke Peng <pykfirst@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240625112819.862282-1-pykfirst@gmail.com>
Content-Language: en-US
From: cmd <clement.mathieudrif.etu@gmail.com>
In-Reply-To: <20240625112819.862282-1-pykfirst@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=clement.mathieudrif.etu@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

On 25/06/2024 13:28, Yuke Peng wrote:
> According to Intel VT-d specification 5.1.4, CFI must be blocked when
> Extended Interrupt Mode is enabled or Compatibility format interrupts
> are disabled.
>
> Signed-off-by: Yuke Peng <pykfirst@gmail.com>
> ---
>   hw/i386/intel_iommu.c         | 28 ++++++++++++++++++++++++++++
>   hw/i386/trace-events          |  1 +
>   include/hw/i386/intel_iommu.h |  1 +
>   3 files changed, 30 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5085a6fee3..dfa2f979e7 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2410,6 +2410,22 @@ static void vtd_handle_gcmd_ire(IntelIOMMUState *s, bool en)
>       }
>   }
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
You have the same comment in both branches of the if statement, couldn't 
we put it between 'trace' and 'if'?
> +}
> +
>   /* Handle write to Global Command Register */
>   static void vtd_handle_gcmd_write(IntelIOMMUState *s)
>   {
> @@ -2440,6 +2456,10 @@ static void vtd_handle_gcmd_write(IntelIOMMUState *s)
>           /* Interrupt remap enable/disable */
>           vtd_handle_gcmd_ire(s, val & VTD_GCMD_IRE);
>       }
> +    if (changed & VTD_GCMD_CFI) {
> +        /* Compatibility format interrupts enable/disable */
> +        vtd_handle_gcmd_cfi(s, val & VTD_GCMD_CFI);
> +    }
>   }
>   
>   /* Handle write to Context Command Register */
> @@ -3304,6 +3324,7 @@ static const VMStateDescription vtd_vmstate = {
>           VMSTATE_BOOL(dmar_enabled, IntelIOMMUState),
>           VMSTATE_BOOL(qi_enabled, IntelIOMMUState),
>           VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
> +        VMSTATE_BOOL(cfi_enabled, IntelIOMMUState),
>           VMSTATE_BOOL(intr_eime, IntelIOMMUState),
>           VMSTATE_END_OF_LIST()
>       }
> @@ -3525,6 +3546,12 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
>   
>       /* This is compatible mode. */
>       if (addr.addr.int_mode != VTD_IR_INT_FORMAT_REMAP) {
> +        if (iommu->intr_eime || !iommu->cfi_enabled) {
> +            if (do_fault) {
> +                vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_COMPAT, 0);
> +            }
> +            return -EINVAL;
> +        }
>           memcpy(translated, origin, sizeof(*origin));
>           goto out;
>       }
> @@ -3950,6 +3977,7 @@ static void vtd_init(IntelIOMMUState *s)
>       s->root_scalable = false;
>       s->dmar_enabled = false;
>       s->intr_enabled = false;
> +    s->cfi_enabled = false;
>       s->iq_head = 0;
>       s->iq_tail = 0;
>       s->iq = 0;
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 53c02d7ac8..ffd87db65f 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -57,6 +57,7 @@ vtd_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova, uint6
>   vtd_dmar_enable(bool en) "enable %d"
>   vtd_dmar_fault(uint16_t sid, int fault, uint64_t addr, bool is_write) "sid 0x%"PRIx16" fault %d addr 0x%"PRIx64" write %d"
>   vtd_ir_enable(bool en) "enable %d"
> +vtd_cfi_enable(bool en) "enable %d"
>   vtd_ir_irte_get(int index, uint64_t lo, uint64_t hi) "index %d low 0x%"PRIx64" high 0x%"PRIx64
>   vtd_ir_remap(int index, int tri, int vec, int deliver, uint32_t dest, int dest_mode) "index %d trigger %d vector %d deliver %d dest 0x%"PRIx32" mode %d"
>   vtd_ir_remap_type(const char *type) "%s"
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 7fa0a695c8..38e20d0f2c 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -294,6 +294,7 @@ struct IntelIOMMUState {
>   
>       /* interrupt remapping */
>       bool intr_enabled;              /* Whether guest enabled IR */
> +    bool cfi_enabled;               /* Whether CFI is enabled */
>       dma_addr_t intr_root;           /* Interrupt remapping table pointer */
>       uint32_t intr_size;             /* Number of IR table entries */
>       bool intr_eime;                 /* Extended interrupt mode enabled */
LGTM

