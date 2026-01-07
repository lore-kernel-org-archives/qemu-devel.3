Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E58CFD65A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVjh-0001tl-EV; Wed, 07 Jan 2026 10:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdVjc-0001n6-Pi
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:46:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdVja-0006m1-A0
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767800765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lnMpjz1wdj/6yyTnqFu+Mgo+POL7yisPeHwXQ8xzQsI=;
 b=fEPgxs2Ik/9jPQ82B1dM8GMkhEFdT7e+eRKLwK8i2WR99lxsyp9361m8RM9xCq/OqODm2U
 hUZRKg3N3wr33zuXPqbslQ47UIyM+6MP4BAbJt64DJcIEymT2YzafhV3LyvLI+kvdCMo/+
 Dd9lQ9pX5BIpz4pzj4hGGRrG/E8L/7o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-jbTg1HtoOty4DUgUtm8mIQ-1; Wed, 07 Jan 2026 10:46:03 -0500
X-MC-Unique: jbTg1HtoOty4DUgUtm8mIQ-1
X-Mimecast-MFC-AGG-ID: jbTg1HtoOty4DUgUtm8mIQ_1767800762
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775f51ce36so20552305e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 07:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767800762; x=1768405562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=lnMpjz1wdj/6yyTnqFu+Mgo+POL7yisPeHwXQ8xzQsI=;
 b=tsTCmrET80JPIDPIwQdYwhVtCZQ/Co8uWlDMsaUPAxyRhxhG0DAxfO3EaoHusr4SX0
 KLp5/WGLz/WjaqzhLa7geCkBhKWATyQTYrlYYgvqljyiSudGW49lQMCHher56g+DFXMl
 dmXvwUx5Cniedpmzq+bIMqLsXI1J1O32DpH7OwEDz3p0rsu0SYcaaVUvU+pne6JLkuIf
 xS45xdbW0FYpuQeUQiMLN9utF/hsoKkYXUxDmLLWTqYg0bNgRMGPFE2FS8hn1JadfH2p
 g8kjJTRpF5hl0y4Unoz8U68z1b/A6v13q8eoK3oLbTOb71F3q0beyNNi9vNSUl5I8dbf
 UQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767800762; x=1768405562;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnMpjz1wdj/6yyTnqFu+Mgo+POL7yisPeHwXQ8xzQsI=;
 b=ezOs6eBI1HQBuiJ/EC2lU+s/TPC8Ng/pR55nBjMRMhaFzwxMNP6KIBXq1ZWTPqgqic
 90odUCrHhMG+KVl/URJciBMnZKgEx+gRMJMyP00Zq6zGQEp1kz3My+C3HguRizcL20gB
 R7khfQfAFGg33gTQ/ZNo5ZHa/rVa1gtupZDC1IP1qrtVTObElSJ104ir46BsfyZ346dZ
 Yfr/y7AppcOLqOOCQ1ICj1d5WMFQnqRnXySLsw4LI58BX8afbSPmSRimHvv9cu5D3Mvu
 cqxGdJ06GG2NOQ0ZzQ6TWi/8MF+GIjPcj16d1WTguUAp2g1tpoYmsp6r+khDETqJcKOk
 wPCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNrYGamVpJXXKpt3pByfMM82JGMuopTtXz8yjgCZFe8SLGI7n3aU08dyaf0/Dexquhonp4Fwky7qmJ@nongnu.org
X-Gm-Message-State: AOJu0YzIHlRJsSQTbvo+UwTges4LqXAwxQd3NtjzYu3UvMV6Kqz4DlWa
 SBAj1t2S4FeB04S10gsWpK+Kg2d78G7Uz6Nc9R5YjIxykmLvHmLN/OFfIiadMjGli5VercuBFl3
 NsfPJk3aiXnXf66tfDHvOnN+hTatIW2VdPrVS6lQ7dybGjMIvKMpVVkBG
X-Gm-Gg: AY/fxX5+lQsFu2upYWCRYFuqKbiH5tuj0243eFGRFLLDNoP9/acduPJ6xKmjvAnpLg9
 nOBxUmTHtegGCcdlIXGB2kqENt1+jlJJKIbyIljOkiAXbpewGympJHK4+mp5WcHKjIlTsAvFIJd
 cN8J/fn7zCv63o/EZD14mHl0fX3L0HFktSMgkWiB74hxfZ3uU/Tr1Ls7topXdlEdhzKuvs2uvhT
 xLNlnWjx71v9mdDxvP2xmmAtimxckWbrpFppQA4Y/VEU0lzpwCSvtN7IRRcaiIXnXF1AcL8ugLx
 ey7CWnu2qmoB9nXLDHoJrVVSe5t1exrv1U1m3kQDbnOx98f5QFvXUsQ4LFzqJhLvzAnGFRF1pnt
 z6l0PRPZbvVXe7HKDb31TAWu9UCJbTmW2pNQ=
X-Received: by 2002:a05:600c:4ed4:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-47d84b41181mr39620895e9.33.1767800762114; 
 Wed, 07 Jan 2026 07:46:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2C+3OGNt2y+SsLcjCj4GVMaqNz/zwSpkExOMihXzbGCr2Bul/3Hsot4Wjeas/Aw+Fge1rLw==
X-Received: by 2002:a05:600c:4ed4:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-47d84b41181mr39620495e9.33.1767800761666; 
 Wed, 07 Jan 2026 07:46:01 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653cd6sm109819885e9.9.2026.01.07.07.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 07:46:01 -0800 (PST)
Message-ID: <fd8d6c6b-6e39-40a5-99c5-5ae33d5fb6f8@redhat.com>
Date: Wed, 7 Jan 2026 16:46:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] s390x: Build IPLB for virtio-pci devices
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-9-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251210205449.2783111-9-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Search for a corresponding S390PCIBusDevice and build an IPLB if a device has
> been indexed for boot but does not identify as a CCW device,
> 
> PCI devices are not yet included in boot probing (they must have a boot index).
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   hw/s390x/ipl.h                  |  3 ++
>   include/hw/s390x/s390-pci-bus.h |  2 ++
>   hw/s390x/ipl.c                  | 56 ++++++++++++++++++++++++++++++---
>   hw/s390x/s390-pci-bus.c         |  2 +-
>   4 files changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index aec2244321..5396d4ed91 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -107,6 +107,7 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>   #define S390_IPLB_MIN_PV_LEN 148
>   #define S390_IPLB_MIN_CCW_LEN 200
>   #define S390_IPLB_MIN_FCP_LEN 384
> +#define S390_IPLB_MIN_PCI_LEN 376
>   #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
>   
>   static inline bool iplb_valid_len(IplParameterBlock *iplb)
> @@ -179,6 +180,8 @@ static inline bool iplb_valid(IplParameterBlock *iplb)
>           return len >= S390_IPLB_MIN_FCP_LEN;
>       case S390_IPL_TYPE_CCW:
>           return len >= S390_IPLB_MIN_CCW_LEN;
> +    case S390_IPL_TYPE_PCI:
> +        return len >= S390_IPLB_MIN_PCI_LEN;
>       case S390_IPL_TYPE_QEMU_SCSI:
>       default:
>           return false;
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index f643e13057..6cbe26a0b8 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -402,6 +402,8 @@ S390PCIBusDevice *s390_pci_find_dev_by_fh(S390pciState *s, uint32_t fh);
>   S390PCIBusDevice *s390_pci_find_dev_by_fid(S390pciState *s, uint32_t fid);
>   S390PCIBusDevice *s390_pci_find_dev_by_target(S390pciState *s,
>                                                 const char *target);
> +S390PCIBusDevice *s390_pci_find_dev_by_pci(S390pciState *s,
> +                                               PCIDevice *pci_dev);

Please indent according to the "(" in the previous line.

>   S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
>                                                  S390PCIBusDevice *pbdev);
>   void s390_pci_ism_reset(void);
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 3843d2a850..cf423ac764 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -22,12 +22,14 @@
>   #include "hw/loader.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/boards.h"
> +#include "hw/s390x/s390-pci-bus.h"
>   #include "hw/s390x/virtio-ccw.h"
>   #include "hw/s390x/vfio-ccw.h"
>   #include "hw/s390x/css.h"
>   #include "hw/s390x/ebcdic.h"
>   #include "hw/scsi/scsi.h"
>   #include "hw/virtio/virtio-net.h"
> +#include "hw/virtio/virtio-pci.h"
>   #include "ipl.h"
>   #include "qemu/error-report.h"
>   #include "qemu/config-file.h"
> @@ -339,7 +341,8 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>       ipl->qipl.boot_menu_timeout = cpu_to_be32(splash_time);
>   }
>   
> -#define CCW_DEVTYPE_NONE        0x00
> +#define S390_DEVTYPE_NONE       0x00
> +
>   #define CCW_DEVTYPE_VIRTIO      0x01
>   #define CCW_DEVTYPE_VIRTIO_NET  0x02
>   #define CCW_DEVTYPE_SCSI        0x03
> @@ -348,7 +351,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>   static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
>   {
>       CcwDevice *ccw_dev = NULL;
> -    int tmp_dt = CCW_DEVTYPE_NONE;
> +    int tmp_dt = S390_DEVTYPE_NONE;
>   
>       if (dev_st) {
>           VirtIONet *virtio_net_dev = (VirtIONet *)
> @@ -395,6 +398,31 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
>       return ccw_dev;
>   }
>   
> +#define PCI_DEVTYPE_VIRTIO       0x05
> +
> +static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
> +{
> +    S390PCIBusDevice *pbdev = NULL;
> +    int tmp_dt = S390_DEVTYPE_NONE;
> +
> +    if (dev_st) {
> +        PCIDevice *pci_dev = (PCIDevice *)
> +            object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
> +                                                           TYPE_PCI_DEVICE);
> +        if (pci_dev) {
> +            pbdev = s390_pci_find_dev_by_pci(s390_get_phb(), pci_dev);
> +            if (pbdev) {
> +                tmp_dt = PCI_DEVTYPE_VIRTIO;

Hmm, so this code assumes that all PCI devices are virtio devices? ... I 
guess that might cause trouble in case someone tries "-device 
nvme,bootindex=1" ...? I think you might want to do the object_dynamic_cast 
with TYPE_VIRTIO_PCI instead.

> +            }
> +        }
> +    }
> +    if (devtype) {
> +        *devtype = tmp_dt;
> +    }
> +
> +    return pbdev;
> +}

  Thomas


