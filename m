Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348B9C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 16:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLliE-000284-Fq; Sun, 01 Jun 2025 12:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLli2-00027o-Bj
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 12:38:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uLlhy-0002cs-HQ
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 12:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748795928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jrTHx2kqtvR62Al7akJM+k48YuOHA2074iFmOUayUBE=;
 b=BtD9IQNYRzguLYdidtk0KyYAndUUbAPdBDrEMLeHnlpKLDzOtXcFbdmlr7D0ST49XZa8dG
 KZMS7H3pSwtxb1k13TFZmWkNsExQbHYjaF9BtmjIUfVpwj3BQ+ByGq2Ctnq090WfcXkp8b
 XEkVdy+JLlljc9QEHZEkh7wnTG20R/o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-2WZebqPNNQGR5bkXL2oeOA-1; Sun, 01 Jun 2025 12:38:46 -0400
X-MC-Unique: 2WZebqPNNQGR5bkXL2oeOA-1
X-Mimecast-MFC-AGG-ID: 2WZebqPNNQGR5bkXL2oeOA_1748795925
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442dc702850so24439795e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 09:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748795925; x=1749400725;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrTHx2kqtvR62Al7akJM+k48YuOHA2074iFmOUayUBE=;
 b=Z07E3arOEZ7fmlFOuHtTK81rO52rB+wL8NkpEbUOWVjT/cZiCFrxG6icJ5XDO4/e4v
 M5W5job9au9pSO11pdjOws1xGTSOy2x6oUecQyd+eXdGHaivX9eKd1CsIPy84wIk3cek
 Kd3FvhzE1pfrgbIxcdLD+Kz9kaJK+byFvum4/EY6zOSWISS0EHoMO8vE1WW5jYESBM3L
 bV7Wis3N7TVu7RgZ/1Wv/dtykSAzTLqdD7dkN9sw2FzLcX57mSBBJBr0SArjJxZoMyyk
 g/bxFw7voquQrz9f4Bnub2onIo6LCeDkFYP4/KvOQysLGSQgXO+VXK2EoY6s31YXmvV4
 GJtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQPKSOi8QkjF/W6+ppaFCBljQXVX/qxq80ZEFa/aPZg68110YbYJen7hyRoglsh6Cy1s99wf6sT4b+@nongnu.org
X-Gm-Message-State: AOJu0Yw14fAL9TDDAllzexC8am5OrbRbQcwGA88EvYaNogLvx/NgS6Eu
 j4f9wd0G9x71/3TKR43To0cUsa7GEHWgkYwCvVXsL8kEzRJ0f+lRq/uKgIHXsLxdKQp7ybpA1XU
 OBWIqcDrJvy7qqrp8ZLveuwyPqtwe8hCAoXP7wxWRe4ni6QdS6yipeI30
X-Gm-Gg: ASbGnct/3xSG+4iL5W3wajpZE/y+Rk1OTcIiusbordmFNbUZ+Hkk3dXq9mziHSSOfk5
 SYPXkNUd61vivv3e0sewmp5BvEmOS6qmfjBiNVQWfn0j4rcXzGyidFHLm+P1S48ARuc8YVL5l7P
 b+wVG85ozEp062qKb0Bg6rzFklrRGmWjSMgGoddrjOQ73VJmHRPNOGf9HmajvpldAHvpIvSaFMQ
 rQn1faZFyCb350PDpfNvNXKFnjxL4ZpyG+uatya4OxMFGOHv3QksgV+6C1UnsOTAWCWxgl4bjC6
 5CscEeEn9zSnF0NGs1L1GPoZK66efkWM9lQ0H1ud6c018Fb10+7iftTLDabw
X-Received: by 2002:a05:600c:3e8f:b0:43d:aed:f7d0 with SMTP id
 5b1f17b1804b1-45125cc48a8mr33931165e9.28.1748795925525; 
 Sun, 01 Jun 2025 09:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo2JcL5Z3XWtVEeooO7iIdxiZMoQDuaMgu5KL4LmqxsuJg0CyLQWrx26JDN4KrvL6C5YCKrA==
X-Received: by 2002:a05:600c:3e8f:b0:43d:aed:f7d0 with SMTP id
 5b1f17b1804b1-45125cc48a8mr33931045e9.28.1748795925109; 
 Sun, 01 Jun 2025 09:38:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8006946sm89863815e9.31.2025.06.01.09.38.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Jun 2025 09:38:44 -0700 (PDT)
Message-ID: <d62bd9c6-1660-4d16-8d7d-5445ba6c5031@redhat.com>
Date: Sun, 1 Jun 2025 18:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 16/43] pci: skip reset during cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-17-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1748546679-154091-17-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/29/25 21:24, Steve Sistare wrote:
> Do not reset a vfio-pci device during CPR.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   include/hw/pci/pci_device.h | 3 +++
>   hw/pci/pci.c                | 5 +++++
>   hw/vfio/pci.c               | 7 +++++++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index e41d95b..b481c5d 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -181,6 +181,9 @@ struct PCIDevice {
>       uint32_t max_bounce_buffer_size;
>   
>       char *sriov_pf;
> +
> +    /* CPR */
> +    bool skip_reset_on_cpr;
>   };
>   
>   static inline int pci_intx(PCIDevice *pci_dev)
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index f5ab510..21eb11c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -32,6 +32,7 @@
>   #include "hw/pci/pci_host.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-properties-system.h"
> +#include "migration/cpr.h"
>   #include "migration/qemu-file-types.h"
>   #include "migration/vmstate.h"
>   #include "net/net.h"
> @@ -531,6 +532,10 @@ static void pci_reset_regions(PCIDevice *dev)
>   
>   static void pci_do_device_reset(PCIDevice *dev)
>   {
> +    if (dev->skip_reset_on_cpr && cpr_is_incoming()) {
> +        return;
> +    }

Since ->skip_reset_on_cpr is only true for vfio-pci devices, it could be
replaced by : object_dynamic_cast(OBJECT(dev), "vfio-pci")

Thanks,

C.


> +
>       pci_device_deassert_intx(dev);
>       assert(dev->irq_state == 0);
>   
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 7d3b9ff..56e7fdd 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3402,6 +3402,13 @@ static void vfio_instance_init(Object *obj)
>       /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
>        * line, therefore, no need to wait to realize like other devices */
>       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> +
> +    /*
> +     * A device that is resuming for cpr is already configured, so do not
> +     * reset it during qemu_system_reset prior to cpr load, else interrupts
> +     * may be lost.
> +     */
> +    pci_dev->skip_reset_on_cpr = true;
>   }>   
>   static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)


