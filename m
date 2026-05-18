Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC75BCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 08:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOtcg-0000kp-TH; Mon, 18 May 2026 04:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wOtce-0000kG-Ds
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wOtcc-00059I-LA
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779094004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udrfsbQyHjIQqW2SC5P9t1PVGvQE/FNQbqsDkpSjdwA=;
 b=IXlwuMIOpyeQHMgtwBiAmu+zFeMBfBH2skoqZEFZlAo1NVfz1k6dqDk8cT6jBp2SEWFHrG
 QTOtXn8yyKDB1fBqI3CnaEas/gfqHQpFoxpF5o/xIxkI8BOBxZROeZ++Y2QebG6uTgrGcQ
 379DDb63xtPZs94Lla9m0qTRdbtronc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-JXy7N70-P1K3SERN5WRElg-1; Mon, 18 May 2026 04:46:42 -0400
X-MC-Unique: JXy7N70-P1K3SERN5WRElg-1
X-Mimecast-MFC-AGG-ID: JXy7N70-P1K3SERN5WRElg_1779094000
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45e81291d62so396321f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 01:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779094000; x=1779698800; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=udrfsbQyHjIQqW2SC5P9t1PVGvQE/FNQbqsDkpSjdwA=;
 b=XWSjqmgbaTlmVMLp01dtj9OF5aAxJlKIACbe6B/xanDRZ5I8W5lKVAYXo23Rd5HCCZ
 qgSpnJwTv749sq0N30Z9FsAzvIovMH1BA/xNPFTrU3Dy780ZuPts1YlIswojYbEOMs7U
 /uRaLI6q8ZAPiF5Iu9rskLh0d0iO+R2ajIxWO1cawNPTYcTssGO46GMPC15Gkxd+9p49
 ek2u9vmHVLfQ0EtFbUUmtvHSnYVu+Gh33aolOnxSKsCMw/ePLqSnLFRkb2wtIg3osf7o
 G8wJ9jLcC+HZlhBDinZTHwKFab/OHZfQqN06sW1pLqjjhewc3wS+kxKRADokyD5vO8br
 XewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779094000; x=1779698800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udrfsbQyHjIQqW2SC5P9t1PVGvQE/FNQbqsDkpSjdwA=;
 b=m1Bs9C/zprpYkI6/t0vlMo8mwsH1k57xD9JnEuppP17DpHg/XZ4PaDeBYTgJj7RCVf
 aRyUDRqv9YIWjWiLfVeLrfqtjfQIpK+AaEjcmZycPCreb64ofTKroKtNwFD7Ce/rnT5w
 czDacGZB4zcg6EWePRsT3im/gIiPMI7qyMrs8HC5RG7JKFByR/lSghz2EyaRbTypATeD
 MJOJss4nXRZOkEtEJ5epa2XB7rH88wbu2KDht/h8M6SibB3PaPX0FchN3IPcw4RItSSM
 cZ5yMuUu2eFq6YTb3LpSb/343tzPzlskc1Viq6M1ZXiUXPfdSEPko6LnFzIZ4ugD8Oe0
 7enA==
X-Gm-Message-State: AOJu0YxUZ23zBtrtVDKpjGm31+20YO+z3AYKwd4zo2HR+4qyAq+bPsvM
 VjgwNV5x/q7jgw6ST+8qcw3bm/hQCkFPDqvCHez1IQcqS77cxUf484DsT/CcV8TJxDwhSQ9CCd/
 L40ihXlKyHRJFOsuxuu6zlxMruO5P5uYdUzQ0TQuV7vvkey2cdV57N3kk
X-Gm-Gg: Acq92OF79BWXNYEqKdjSb8/fxgb5w80nFCBJY6mex4Aa40bN3ABL5NQlf9CCvCf/cIL
 s1S9PmqoWWPkrZvgC0M7/KJqljM9ABSR3LmWrU+Byt8vRwge6G5lKgelrC4NSGTgr/YBrC/kyFH
 fN/CaV+kpzLUDcP9reYKRQL1T6fO25tiVh/QG/Hp9k22wxaGSGj+VFvth7+NcQiekmSN0dqQedz
 i4rd0BQg8FGe2G0815MHgbfWs/7uJpB8pyaEtLvyp89Z2I+cn8oLNjGb4yo9XNQUezKZNDtFCXK
 kpNEMZD1gU+ZJFsZBHwvDNnssYh5Bz1bqIk8DwNVZHPFvvCtxKV7HqrL1VHYWUIogmoJkVfnynP
 NUE1pxU5+ljWKY0pPmqY6orqtX5kwa9ZoSWOVAEsl
X-Received: by 2002:a5d:5d01:0:b0:452:a293:4d91 with SMTP id
 ffacd0b85a97d-45e5c34b279mr21973881f8f.0.1779093999756; 
 Mon, 18 May 2026 01:46:39 -0700 (PDT)
X-Received: by 2002:a5d:5d01:0:b0:452:a293:4d91 with SMTP id
 ffacd0b85a97d-45e5c34b279mr21973831f8f.0.1779093999218; 
 Mon, 18 May 2026 01:46:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe248dsm35010296f8f.30.2026.05.18.01.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 01:46:38 -0700 (PDT)
Date: Mon, 18 May 2026 04:46:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: khaled saleh <khaled.saleh.req@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/pci/shpc: Enable 66MHz Bus Speed Support
Message-ID: <20260518044520-mutt-send-email-mst@kernel.org>
References: <20260518073714.70571-1-khaled.saleh.req@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518073714.70571-1-khaled.saleh.req@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 18, 2026 at 09:37:14AM +0200, khaled saleh wrote:
> The Standard Hot-Plug Controller (SHPC) specification (PI=1) defines
> 66MHz conventional PCI as a valid bus speed mode. While QEMU defined
> the relevant constants, it hardcoded the secondary bus speed to 33MHz
> and advertised 0 slots as 66MHz capable.
> 
> This patch enables 66MHz support by:
> 1. Allowing SHPC_SEC_BUS_66 in shpc_set_sec_bus_speed().
> 2. Advertising all slots as 66MHz capable in shpc_reset().
> 3. Dynamically checking and reporting a slot's 66MHz capability based
>    on the plugged PCI device's Status Register (PCI_STATUS_66MHZ).
> 
> PCI-X speeds remain unsupported and will continue to trigger an
> INVALID_MODE command status error.
> 
> Signed-off-by: khaled saleh <khaled.saleh.req@gmail.com>
> ---
>  hw/pci/shpc.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
> index 938602866d..3becde7f10 100644
> --- a/hw/pci/shpc.c
> +++ b/hw/pci/shpc.c
> @@ -12,7 +12,7 @@
>  
>  /* TODO: model power only and disabled slot states. */
>  /* TODO: handle SERR and wakeups */
> -/* TODO: consider enabling 66MHz support */
> +
>  
>  /* TODO: remove fully only on state DISABLED and LED off.
>   * track state to properly record this. */
> @@ -30,7 +30,7 @@
>  #define SHPC_PHYS_BUTTON  0x8000
>  #define SHPC_SEC_BUS      0x10 /* 2 bytes */
>  #define SHPC_SEC_BUS_33   0x0
> -#define SHPC_SEC_BUS_66   0x1 /* Unused */
> +#define SHPC_SEC_BUS_66   0x1
>  #define SHPC_SEC_BUS_MASK 0x7
>  #define SHPC_MSI_CTL      0x12 /* 1 byte */
>  #define SHPC_PROG_IFC     0x13 /* 1 byte */
> @@ -169,6 +169,17 @@ static void shpc_set_status(SHPCDevice *shpc,
>      pci_word_test_and_set_mask(status, value << ctz32(msk));
>  }
>  
> +static bool shpc_device_is_66mhz_capable(SHPCDevice *shpc, int slot)
> +{
> +    int pci_slot = SHPC_IDX_TO_PCI(slot);
> +    PCIDevice *dev = shpc->sec_bus->devices[PCI_DEVFN(pci_slot, 0)];
> +
> +    if (!dev) {
> +        return false;
> +    }
> +    return pci_get_word(dev->config + PCI_STATUS) & PCI_STATUS_66MHZ;
> +}
> +
>  static void shpc_interrupt_update(PCIDevice *d)
>  {
>      SHPCDevice *shpc = d->shpc;
> @@ -203,6 +214,7 @@ static void shpc_set_sec_bus_speed(SHPCDevice *shpc, uint8_t speed)
>  {
>      switch (speed) {
>      case SHPC_SEC_BUS_33:
> +    case SHPC_SEC_BUS_66:
>          shpc->config[SHPC_SEC_BUS] &= ~SHPC_SEC_BUS_MASK;
>          shpc->config[SHPC_SEC_BUS] |= speed;
>          break;
> @@ -220,7 +232,7 @@ void shpc_reset(PCIDevice *d)
>      memset(shpc->config, 0, SHPC_SIZEOF(d));
>      pci_set_byte(shpc->config + SHPC_NSLOTS, nslots);
>      pci_set_long(shpc->config + SHPC_SLOTS_33, nslots);
> -    pci_set_long(shpc->config + SHPC_SLOTS_66, 0);
> +    pci_set_long(shpc->config + SHPC_SLOTS_66, nslots);
>      pci_set_byte(shpc->config + SHPC_FIRST_DEV, SHPC_IDX_TO_PCI(0));
>      pci_set_word(shpc->config + SHPC_PHYS_SLOT,
>                   SHPC_IDX_TO_PHYSICAL(0) |
> @@ -256,7 +268,9 @@ void shpc_reset(PCIDevice *d)
>              shpc_set_status(shpc, i, SHPC_LED_OFF, SHPC_SLOT_PWR_LED_MASK);
>          }
>          shpc_set_status(shpc, i, SHPC_LED_OFF, SHPC_SLOT_ATTN_LED_MASK);
> -        shpc_set_status(shpc, i, 0, SHPC_SLOT_STATUS_66);
> +        shpc_set_status(shpc, i,
> +                        shpc_device_is_66mhz_capable(shpc, i) ? 1 : 0,
> +                        SHPC_SLOT_STATUS_66);
>      }
>      shpc_set_sec_bus_speed(shpc, SHPC_SEC_BUS_33);
>      shpc->msi_requested = 0;
> @@ -578,6 +592,9 @@ void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>          shpc_set_status(shpc, slot, 0, SHPC_SLOT_STATUS_MRL_OPEN);
>          shpc_set_status(shpc, slot, SHPC_SLOT_STATUS_PRSNT_7_5W,
>                          SHPC_SLOT_STATUS_PRSNT_MASK);
> +        shpc_set_status(shpc, slot,
> +                        shpc_device_is_66mhz_capable(shpc, slot) ? 1 : 0,
> +                        SHPC_SLOT_STATUS_66);
>          return;
>      }
>  
> @@ -596,7 +613,9 @@ void shpc_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>          shpc->config[SHPC_SLOT_EVENT_LATCH(slot)] |=
>              SHPC_SLOT_EVENT_BUTTON;
>      }
> -    shpc_set_status(shpc, slot, 0, SHPC_SLOT_STATUS_66);
> +    shpc_set_status(shpc, slot,
> +                    shpc_device_is_66mhz_capable(shpc, slot) ? 1 : 0,
> +                    SHPC_SLOT_STATUS_66);
>      shpc_interrupt_update(pci_hotplug_dev);
>  }
>  
> -- 
> 2.34.1


This can't be done unconditionally without breaking cross version
migration. You need to add a property (prefixed with "x-" to mark it
not a stable ABI) and then tweak it in the compat machinery.

-- 
MST


