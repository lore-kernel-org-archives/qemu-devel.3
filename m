Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0341BC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 23:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSQYZ-0001IW-Pb; Tue, 23 Jan 2024 18:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rSQYX-0001IA-Tc
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rSQYW-0005XL-3Q
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706053906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=68Jz1F7qwDslZzXDj0R9t398ZC+kJvNEOfOavg9BMlM=;
 b=OTXrCndxYZerDORuRFhJfDRIOleFDI+YJnrO7+B/HE72zcXec7SezxDa8p8C5Kvkox96Bq
 GcgftGOGotNNCXcwSDmOyJIKVAVH0COSGydSM9bcPAJUuDBXeThL0ZF9oOeqWP76ahqasN
 2GTbyut4f/ghfEDIXrGzLQQTU3dfzK4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-0NCoby6pPBiGvlRn3XDGUw-1; Tue, 23 Jan 2024 18:51:44 -0500
X-MC-Unique: 0NCoby6pPBiGvlRn3XDGUw-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6de423c4a27so5534996a34.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 15:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706053904; x=1706658704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=68Jz1F7qwDslZzXDj0R9t398ZC+kJvNEOfOavg9BMlM=;
 b=vDEQ1FdRYWmXtuNYLIC2Ab6W6VlZ4m5cnYdymDDJmjlGcJsjviQwbuZmt42H555aG7
 dfFgQuVDnxP9jVS74BTKXuxXVMhE/aPgoxqEBDH8NshZx8uig9UD4NBJOneZ56sMCKrM
 7BC2k/Gm4zKh4WMXmSPmFktkt/Qq0jwQEI18thHI6DWSmWv+0PtsqfSP1tdqyfQ4a5B/
 KKt+LSJKKrM7W7UYVQXCx4zc2tgF46piDsiX+SkON3p3Bow6unxPbtvvwd4LLnLTeiUc
 /sr/Lu5jrOlsT5l6xrxVu4hUKApYjXteihctHTEYgmqZIIhcWc5cGsGjeYRPldnBDQxb
 5XlA==
X-Gm-Message-State: AOJu0YxkL/rrM6yxbPcAwj3qF9JeCLOEJc8RErpO+/SlbCQJOfoTn0sa
 D3VWvR7cdq72GWuvQJrwSwmqOc4mXv6wuHwvsAjXeQVVjZO873EtFPxjpCh9VVrpVqXbVG9O5TN
 y+Y4+NRbj4pFHbjWiXalM/uOR8vq0BZigNG8J5Bcq7NgmnAaVt08m
X-Received: by 2002:a05:6830:1e14:b0:6e0:e7b4:4cc2 with SMTP id
 s20-20020a0568301e1400b006e0e7b44cc2mr704140otr.28.1706053904072; 
 Tue, 23 Jan 2024 15:51:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmZHbRSYToaPjdRvPY3+GKooi4vtMb3A8CRfx3sUL5GV+zrJa+6mqFVmupx3qkj1PPlS/7lg==
X-Received: by 2002:a05:6830:1e14:b0:6e0:e7b4:4cc2 with SMTP id
 s20-20020a0568301e1400b006e0e7b44cc2mr704125otr.28.1706053903783; 
 Tue, 23 Jan 2024 15:51:43 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 g9-20020a9d6209000000b006dc488ad48fsm2337621otj.51.2024.01.23.15.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 15:51:43 -0800 (PST)
Date: Tue, 23 Jan 2024 16:51:41 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, peterx@redhat.com, yanghliu@redhat.com,
 mst@redhat.com, clg@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH 1/3] virtio-iommu: Add an option to define the input
 range width
Message-ID: <20240123165141.7a79de34.alex.williamson@redhat.com>
In-Reply-To: <20240123181753.413961-2-eric.auger@redhat.com>
References: <20240123181753.413961-1-eric.auger@redhat.com>
 <20240123181753.413961-2-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 23 Jan 2024 19:15:55 +0100
Eric Auger <eric.auger@redhat.com> wrote:

> aw-bits is a new option that allows to set the bit width of
> the input address range. This value will be used as a default for
> the device config input_range.end. By default it is set to 64 bits
> which is the current value.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/hw/virtio/virtio-iommu.h | 1 +
>  hw/virtio/virtio-iommu.c         | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index 781ebaea8f..5fbe4677c2 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -66,6 +66,7 @@ struct VirtIOIOMMU {
>      bool boot_bypass;
>      Notifier machine_done;
>      bool granule_frozen;
> +    uint8_t aw_bits;
>  };
>  
>  #endif
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index ec2ba11d1d..e7f299e0c6 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -1314,7 +1314,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>       */
>      s->config.bypass = s->boot_bypass;
>      s->config.page_size_mask = qemu_real_host_page_mask();
> -    s->config.input_range.end = UINT64_MAX;
> +    s->config.input_range.end =
> +        s->aw_bits == 64 ? UINT64_MAX : BIT_ULL(s->aw_bits) - 1;

What happens when someone sets aw_bits = 1?  There are a whole bunch of
impractical values here ripe for annoying bug reports.  vtd_realize()
returns an Error for any values other than 39 or 48.  We might pick an
arbitrary lower bound (39?) or some other more creative solution here
to avoid those silly issues in our future.  Thanks,

Alex

>      s->config.domain_range.end = UINT32_MAX;
>      s->config.probe_size = VIOMMU_PROBE_SIZE;
>  
> @@ -1525,6 +1526,7 @@ static Property virtio_iommu_properties[] = {
>      DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>                       TYPE_PCI_BUS, PCIBus *),
>      DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  


