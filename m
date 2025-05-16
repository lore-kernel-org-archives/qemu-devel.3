Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0530FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqHq-0004yW-2A; Fri, 16 May 2025 04:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqHo-0004yL-9V
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqHm-0003tB-CO
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747383556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7kT/ISKQuuqqlqlGxoOC8wex7uRWm6meA8VeE0YxdDU=;
 b=V8aeCNrmONzS9ov7fpTGEJr+wu6S1Mdtcb9NJaH4gyEQJeps/RjdsRVcNY0Mx41h113yev
 uQ4/QgL3NGP+XkJBwMVE2ikbmgBldAjEPhpKKZuiwTlV4all4V21olqqFcFbeWIWoF037q
 rnzqGnFlX+nQeQ+Ed9pD/8st0Pdh/uw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-7gteeRThOpGRhBgK01jfDw-1; Fri, 16 May 2025 04:19:13 -0400
X-MC-Unique: 7gteeRThOpGRhBgK01jfDw-1
X-Mimecast-MFC-AGG-ID: 7gteeRThOpGRhBgK01jfDw_1747383552
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0db717b55so1263928f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 01:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383552; x=1747988352;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kT/ISKQuuqqlqlGxoOC8wex7uRWm6meA8VeE0YxdDU=;
 b=jfcM67WzdH+3sAc/5B6VOHKdV9LtrqPTIOEwk1Iif0WrArxIklF721hEhparxb8DYG
 3SGNMpEwtNgJn0rZGXTtxm8+GXMSW9ebqxjORTTOpCQl+bIxl1VAA8W7E0BbamBK7VRi
 qKFKjF2l4XwEMbA/xoR3YsF0Ky2H6xu5v95WfsC8TSSADZ3zMmS/D7OMCfQxGk9cXNc5
 yE6CX31p9Xbj6oiX4LaY0NZ6EIiXUb0mIbchOWrKQrslYfezk4qt9gR1ITRiZthWS/0c
 qlio4TxZQFR5VettSNTSuy3BIAilSA9uJ+mIjXecwhIpt+7WrZaKuoIF9whGikhIdwXT
 WBhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHaffOGyWMDZfX57tGpNAeHI+23u6CiHB7AZasuWrQAfpVlt95pe2KSBW/uyf1D8rbYAaMM3sTmhRE@nongnu.org
X-Gm-Message-State: AOJu0YzwYv8oCfxTG0BAQfeGgH1u3YUDdDz7ajwy9mA3HW3siQE24c4o
 sobVqhUHYIyTjtDaDjWl5haphQhOZZVSJEiY1Le0M6JOFk17k+7MNeNSTPMNvytnekxKjfgQUh0
 vhSdteZ6453ISKr4SC/sFd1mqcvzEPB/La4OJv68xD1EmkbBt1/wquS9g
X-Gm-Gg: ASbGncuB02xse5QMLvlpWOebGnLyLW32Btf8iTAWfL9y8SR7ZHQnO8NYzK8hv2YGVFj
 qZcAsIN+kGbuW2eKSHcOhWbTHTjXF6lykFi0KPLNMMILRiDTzBAyjE8Q9qOrsh43IETz50x37ex
 k9BWbqfbQeoyraHPMzFKhcPAYuqvj+o88CNDXdK1LhxduJTXedGw628MZlW8isSxd4pMQqHkXPg
 nEVwIP9liWi+RMcqQ7KqTLpTZcSWo/M5opWnYSWS1E1wivwGT3pWRdHuHL79RWRx1HVtuRwr4zE
 PrB+mZrfCGm2xMNnf5pVzmVv+MAKMOa8PmarzS/si5PFZCNM8Q==
X-Received: by 2002:a05:6000:1787:b0:3a3:5fc7:bc18 with SMTP id
 ffacd0b85a97d-3a35fc7bd42mr1477489f8f.27.1747383552061; 
 Fri, 16 May 2025 01:19:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL3Y7kTRiQRFlGq/IaVHVgUoGAPc655EGtWvWzsAkvkWEYETo2e+ju68uDWMECqe1UfIdU0A==
X-Received: by 2002:a05:6000:1787:b0:3a3:5fc7:bc18 with SMTP id
 ffacd0b85a97d-3a35fc7bd42mr1477461f8f.27.1747383551686; 
 Fri, 16 May 2025 01:19:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca4d1c6sm2072713f8f.2.2025.05.16.01.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 01:19:11 -0700 (PDT)
Message-ID: <c0aa3971-85bd-4e69-bb13-4e13349794b8@redhat.com>
Date: Fri, 16 May 2025 10:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 14/42] pci: skip reset during cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-15-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-15-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

On 5/12/25 17:32, Steve Sistare wrote:
> Do not reset a vfio-pci device during CPR.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/pci/pci.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index fe38c4c..2ba2e0f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -32,6 +32,8 @@
>   #include "hw/pci/pci_host.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-properties-system.h"
> +#include "migration/cpr.h"
> +#include "migration/misc.h"
>   #include "migration/qemu-file-types.h"
>   #include "migration/vmstate.h"
>   #include "net/net.h"
> @@ -537,6 +539,17 @@ static void pci_reset_regions(PCIDevice *dev)
>   
>   static void pci_do_device_reset(PCIDevice *dev)
>   {
> +    /*
> +     * A PCI device that is resuming for cpr is already configured, so do
> +     * not reset it here when we are called from qemu_system_reset prior to
> +     * cpr load, else interrupts may be lost for vfio-pci devices.  It is
> +     * safe to skip this reset for all PCI devices, because vmstate load will
> +     * set all fields that would have been set here.
> +     */
> +    if (cpr_is_incoming()) {

Why can't we use cpr_is_incoming() in vfio instead of using an heuristic
on saved fds?

Thanks,

C.



> +        return;
> +    }
> +
>       pci_device_deassert_intx(dev);
>       assert(dev->irq_state == 0);
>   


