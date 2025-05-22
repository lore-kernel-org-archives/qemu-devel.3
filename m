Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF437C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 11:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI4My-0002Gu-6U; Thu, 22 May 2025 07:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uI4Mq-0002AD-4I
 for qemu-devel@nongnu.org; Thu, 22 May 2025 07:45:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uI4Mn-0001lu-F2
 for qemu-devel@nongnu.org; Thu, 22 May 2025 07:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747914339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bRPhXblA8J7fizv58w853LZHARqbP/0pPmDyhoZxGCQ=;
 b=WsPsZvLfZyV1hAevOy+ZRoXvZ/deL/cQ1yLEtOO0x4nUTySUkUESlciStjLt0iUIVcZlUD
 ++8jOPwwcXmfjwoF+F/AKEMR7Zp0NtMEFLO5ALBRT6q2jSJYwt2AkiQIMF6h8COMB/WS1m
 GBL00WMbSqwiWbhieF7Wai/CChpDd+I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595--OeqTyfAPG6FTs8LKa94Dw-1; Thu, 22 May 2025 07:45:36 -0400
X-MC-Unique: -OeqTyfAPG6FTs8LKa94Dw-1
X-Mimecast-MFC-AGG-ID: -OeqTyfAPG6FTs8LKa94Dw_1747914335
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a376da334dso2552977f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 04:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747914335; x=1748519135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRPhXblA8J7fizv58w853LZHARqbP/0pPmDyhoZxGCQ=;
 b=GCz8S+G8iLCj4sBVyjxxW+AQQ7Fwe+c0bVs++UkJEB+GqJg6V0MVHM26xNra2LKxA9
 6u8f9s16GhdoGjVpPLYSuAKn+hAEhQ7GzQwLDZhL7tpCs/DW/jnujLNFchHunYqQ9qPG
 ERbvGJETcY/UE35YQrWGAQXY8DL1EE+WXXMBqsBbNeh8OjqCEHeVMgJu9EsxL1O2wFF1
 F9e4UHFsM5OAX9OwDvImKwOFJ/87TkEijfmYQhzoTKsWSUxyGkFmlPDMjXzni08R5CJr
 oEruBzOgHdh8pBKiRlTW3JXj8+Z3SZ2JHtS6hRNTtmw7BDEdQrGYII+rJYSQRdu2iKeX
 UIaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqu+dGpCt3Cs8NZHw4Dsshr/ifCqISfYDK9uFCSNeTU5+C3yo+ql8n5w7YXy7XlHuCNGdxEmpBq/cr@nongnu.org
X-Gm-Message-State: AOJu0Ywd7umbZy5EIDGOLGEf387ODSeHGr1V4UJc/h0bZOb3nzRRBLAB
 swHLXxn9nRNFBzGcpcMqmhINKcdzE7q+Hq8WNCi6vHxykEagRkyHoIXOn85w4Uz7915QUypjhhn
 n6gppvOIr4OsszNZV9pQ4TRD1SR5gHBDP8Zoyq0xaNhih4P3cd9Q/2jjL
X-Gm-Gg: ASbGncuvHM/UFtgCh42C0RrznnxDkbhf8sMSHKMM0+Y+T1C5LkeWz3b7ob4+7tqoU/O
 uUxDcf0eHWhJv3Mza7T9Ikqg78V4g7gnrUnBc9cSbxOsosiJy8cLso0BUerLSwHTGn0jw90dL8n
 1m6LFm5OXACOLwRUHCsmM6MXoH1xVpRtyRKNxkSP1NPFj0X2qUjiN1GLlkS0AbwDxdz60y+Myl+
 UIIivjs8euEucRdfdmXssWXgFJZLOV2iEK/Q+lpmBjGDIXxZLJoDgRk/p0LXDjwzzuH6N6uS3gj
 FmuGIAcQtS9cpbapbvXUIlhd0IdtoHPMPq2CteDWW+isu3ToMoRowEMrnnR9
X-Received: by 2002:a05:6000:1846:b0:38f:4d20:4a17 with SMTP id
 ffacd0b85a97d-3a35c8218b5mr21582716f8f.13.1747914334967; 
 Thu, 22 May 2025 04:45:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgAnZma/bQxH9d/VzdTOkElm8ZxkLh5fonLeuJSjKXJDgWep+gZqe7U7LNian5yu8E7JDS3w==
X-Received: by 2002:a05:6000:1846:b0:38f:4d20:4a17 with SMTP id
 ffacd0b85a97d-3a35c8218b5mr21582667f8f.13.1747914334401; 
 Thu, 22 May 2025 04:45:34 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it.
 [82.53.134.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8874bsm23164039f8f.67.2025.05.22.04.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 04:45:33 -0700 (PDT)
Date: Thu, 22 May 2025 13:45:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: oenhan@gmail.com
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, 
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com, 
 leiyang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>, 
 Jidong Xia <xiajd@chinatelecom.cn>
Subject: Re: [PATCH V3] vhost: Don't set vring call if guest notifier is unused
Message-ID: <6rqjkyuvautarpuubc4s42ouwz4yupskyrowe3r5z6tcagw5ss@zsxqzeolyauj>
References: <20250522100548.212740-1-hanht2@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250522100548.212740-1-hanht2@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, May 22, 2025 at 06:05:48PM +0800, oenhan@gmail.com wrote:
>From: Huaitong Han <hanht2@chinatelecom.cn>
>
>The vring call fd is set even when the guest does not use MSI-X (e.g., in the
>case of virtio PMD), leading to unnecessary CPU overhead for processing
>interrupts.
>
>The commit 96a3d98d2c("vhost: don't set vring call if no vector") optimized the
>case where MSI-X is enabled but the queue vector is unset. However, there's an
>additional case where the guest uses INTx and the INTx_DISABLED bit in the PCI
>config is set, meaning that no interrupt notifier will actually be used.
>
>In such cases, the vring call fd should also be cleared to avoid redundant
>interrupt handling.
>
>Fixes: 96a3d98d2c("vhost: don't set vring call if no vector")
>

As I pointed out on v2 [1], we may fix the tag format and I think we
can also remove this empty line between Fixes and Reported-by.

[1] https://lore.kernel.org/qemu-devel/dmtvkhqkwdv7rzum6c4gs3uiekwckou3yp7w2ql6tijxshoiju@w4rplxvassk6/

I don't know if Michael can fix will applying or you need to resend.

BTW I still didn't completely get the pci bits, but for vhost LGTM:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
>Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
>Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
>---
>V3:
>- Don't change query_guest_notifiers semantics, just fix the issue
>
>V2:
>- Retain the name `query_guest_notifiers`
>- All qtest/unit test cases pass
>- Fix V1 patch style problems
>
> hw/pci/pci.c           | 2 +-
> hw/virtio/virtio-pci.c | 7 ++++++-
> include/hw/pci/pci.h   | 1 +
> 3 files changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>index f5ab510697..82f82e726b 100644
>--- a/hw/pci/pci.c
>+++ b/hw/pci/pci.c
>@@ -1725,7 +1725,7 @@ static void pci_update_mappings(PCIDevice *d)
>     pci_update_vga(d);
> }
>
>-static inline int pci_irq_disabled(PCIDevice *d)
>+int pci_irq_disabled(PCIDevice *d)
> {
>     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
> }
>diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>index 9b48aa8c3e..7e309d1d49 100644
>--- a/hw/virtio/virtio-pci.c
>+++ b/hw/virtio/virtio-pci.c
>@@ -1215,7 +1215,12 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
> static bool virtio_pci_query_guest_notifiers(DeviceState *d)
> {
>     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>-    return msix_enabled(&proxy->pci_dev);
>+
>+    if (msix_enabled(&proxy->pci_dev)) {
>+        return true;
>+    } else {
>+        return pci_irq_disabled(&proxy->pci_dev);
>+    }
> }
>
> static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
>diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>index c2fe6caa2c..8c24bd97db 100644
>--- a/include/hw/pci/pci.h
>+++ b/include/hw/pci/pci.h
>@@ -668,6 +668,7 @@ void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
>
> qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
> void pci_set_irq(PCIDevice *pci_dev, int level);
>+int pci_irq_disabled(PCIDevice *d);
>
> static inline void pci_irq_assert(PCIDevice *pci_dev)
> {
>-- 
>2.43.5
>


