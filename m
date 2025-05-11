Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDAFC3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 17:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEAqX-00077b-Pn; Sun, 11 May 2025 13:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEAqW-00077L-5Q
 for qemu-devel@nongnu.org; Sun, 11 May 2025 13:52:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEAqT-0000SX-UX
 for qemu-devel@nongnu.org; Sun, 11 May 2025 13:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746985932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eTNtWMdtJVRxphB0XkaxqPrVhsptmuf1ozGfqkLl210=;
 b=disLZ0pr+8ZJnsfWmQNnCWKiIwwUNOAcPjrKWhG+AvqVrxW8WnAkqVR68Yv/uYWrlqGdOL
 cWAPMFK/hOxkdgii9io9O2LiTVntcuzxe3ZBM7mBq4dfCLYwklpdNm3PhVmeW6JnmHN0Ny
 tsmhVcdX9SJbqihBKjvPFVls4Zy0iTI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-c6NRx_TTNiO1rnvlpRcdPA-1; Sun, 11 May 2025 13:52:10 -0400
X-MC-Unique: c6NRx_TTNiO1rnvlpRcdPA-1
X-Mimecast-MFC-AGG-ID: c6NRx_TTNiO1rnvlpRcdPA_1746985930
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso17794245e9.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 10:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746985929; x=1747590729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTNtWMdtJVRxphB0XkaxqPrVhsptmuf1ozGfqkLl210=;
 b=PsPzuT9saDhkxFsDSJUUP6KUO3ohzBSJm1l2pt7OsQMZATW40LkE+RjL37ltCMViRp
 yeqskcaAhqtm7p+KETr8at+zAcqYeAOhSX0cApoinWcdONI7c1TuofuMBeknOglVp6F/
 YRwXNKpWfjQxSBip/TJAvErimn6eU0qr5a3lmftD0ZWKvfBwtrLWf5kW2S6vqraBiJmW
 J+OLk/eA65lt/o8oPXdrSKdlHFuy2o/fW5fXYnCylmGFkNimbIcwDT3xPhOF9fOhv96X
 RfHb4HMrXyC0Ha0X70Mkd0tMvYAmNqrsnWsO2dyGBXWhaZmt0RX3obd00s4el4xVz09P
 q3uQ==
X-Gm-Message-State: AOJu0YynqgDogVixuXYjHK7voqZdfWLEjNX7EgtDiAe2u9Xjk3u2y94k
 NcLOPfwrih1n4U8r0KITw1ozHaefhqsWH5ohJ9g2iPXzMYs2REMJh8julULfpNhWkqsYpTQyoAS
 Id9v4KVK6Dsc23VgNUEL7rhtBkVDH6yzlbqZkkdao4AgbAzfEpr/H
X-Gm-Gg: ASbGnctnRm8O87BnNaRPDLgVBwS3d0MEj+lTf/XWSRS2t5hHurRif5ILkFaZG5LFUDN
 egGNhcoSqfRT/lr1tTQBluw1hF/a0wYryLn8s6cpvMFjH9tCbp6XkVaCe+HcQcpBLT63AdiDUgA
 4LoxRVEa6XngK59GZ0tCFeJBC/9vK+UifEjZAjVz8TGItwiX8NcYeTRbnx3uUY3CseY94TLJB4I
 KHVFG44bGqMqizVwIwA7/8el0JEqsLgR6A3fvmQA0Gw6TsoOKzn72dOP/kp8yjpos/G74Rbr0yw
 9ECcYg==
X-Received: by 2002:a05:600c:4e06:b0:442:d9fb:d9a5 with SMTP id
 5b1f17b1804b1-442d9fbda6bmr70601815e9.9.1746985929577; 
 Sun, 11 May 2025 10:52:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd0WsK2612ML3LJKbjH+v+NfS+VTteHEJgZEDKCxYEJavv+8w9UfaJ7kd3u09HRyiVzDJ38g==
X-Received: by 2002:a05:600c:4e06:b0:442:d9fb:d9a5 with SMTP id
 5b1f17b1804b1-442d9fbda6bmr70601695e9.9.1746985929187; 
 Sun, 11 May 2025 10:52:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7d2bsm141688425e9.36.2025.05.11.10.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 10:52:08 -0700 (PDT)
Date: Sun, 11 May 2025 13:52:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 suravee.suthikulpanit@amd.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
Subject: Re: [PATCH v2 0/2] amd_iommu: Fixes
Message-ID: <20250511135031-mutt-send-email-mst@kernel.org>
References: <20250509064526.15500-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509064526.15500-1-sarunkod@amd.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
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

On Fri, May 09, 2025 at 12:15:24PM +0530, Sairaj Kodilkar wrote:
> Fix following two issues in the amd viommu
> 1. The guest fails to setup the passthrough device when for following setup
>    because amd iommu enables the no DMA memory region even when guest is 
>    using DMA remapping mode.
> 
>     -device amd-iommu,intremap=on,xtsup=on,pt=on \
>     -device vfio-pci,host=<DEVID> \
> 
>     and guest forcing DMA remap mode e.g. 'iommu.passthrough=0'
> 
>     which will cause failures from QEMU:
> 
>     qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
>     qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>     qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
>     qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
>     qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
> 
> 
> 2. The guest fails to boot with xtsup=on and <= 255 vCPUs, because amd_iommu
>    does not enable x2apic mode.
> 
> base commit 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365 (v10.0.0-rc3)
> 
> Sairaj Kodilkar (1):
>   hw/i386/amd_iommu: Fix device setup failure when PT is on.
> 
> Vasant Hegde (1):
>   hw/i386/amd_iommu: Fix xtsup when vcpus < 255
> 
>  hw/i386/amd_iommu.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Patches themselves were not posted to list.
Only the cover letter.

> -- 
> 2.34.1


