Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C662FC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 09:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tatKG-0005bs-Ld; Thu, 23 Jan 2025 04:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tatKF-0005bY-9c
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tatKB-0005KE-JJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 04:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737623789;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dka7GSoGZN+xBNJl5mk81pg/2CtNp32GZEgIbMfNWjQ=;
 b=fkeTSzYB/s3UYg9/9PvH/Dsu2WG2g6xV2WBXcnoYAiuicBkkCwcvllI8JU3qdzoTLQHn+p
 2DB38RwsnO+RQLOTQbceaIjCEzN3Liu39z1Y2CSBHeqig3USpcE34ZjgNTZfPa6jKl/5AL
 IeRboarPduFkb2duYP1j5fhBahN3jdM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-99vF1iTmNcmGtIhrFCKMIQ-1; Thu, 23 Jan 2025 04:16:27 -0500
X-MC-Unique: 99vF1iTmNcmGtIhrFCKMIQ-1
X-Mimecast-MFC-AGG-ID: 99vF1iTmNcmGtIhrFCKMIQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso3043985e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 01:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737623786; x=1738228586;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dka7GSoGZN+xBNJl5mk81pg/2CtNp32GZEgIbMfNWjQ=;
 b=KPjdsezoJ50Tlxy9N/DqxAtbNGMmSlG7Lp5VEnYYMi6daq5QRH20yHIrIQGV7Io3p3
 nJqf/VRslPXYKp7PMSBU9XGIsup1uQ97hQ8wX7O3h51X8YgoFTZ5xmut4mUUOyod5VGL
 8sogPtoH5IxNNfZxEWOKEFE85uNiERDSR++Bjyu1rmFY8Y42rmeNQAdABZL8DN1A1BMP
 icvHMK4GL+TV2MmoB+JDGUj+NSURWeeKLGH4XmtLlJIs+LCOb2+UFYJeUSpZOfuCql/x
 pUxknC9jhbHWTq+tH1VbFKJVVgHxBMwITF9JZhq/RkKUzWujeubTLPeMSmYnLclOwk8i
 cC2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxQ1K9TD+QHNaiVAWJNIKqSQ5MUoo7yLc4ahY7LljM0F5N2x5SwVzQE7O6KJ01AW4YLlSMRSNgeCbK@nongnu.org
X-Gm-Message-State: AOJu0Yy1+lnxyGW+zOUyDRZzups69/gVNnUFIyi5V9h1kO4dz8ZMwiKX
 pxcAHWpW4dS67vjoNZJT0z6pdR+muSEVZk/RXz8U5ZAZ8dspQfP5tRz9zzS+Xay6MBRNx+HPRvT
 DedMZB/hfv2gylK+JaWhPh80BaJGoSSDfzA4cUo/rKiAAjnkB8ANT
X-Gm-Gg: ASbGncvkYjvAoU2Q8RE9oDJ1c6kGrGRSo8JvjQwe5bKEepZcWANOzsnar6P4OjqEDVJ
 tvj71Qqs5aBiek74lbTYBZ/fzlo51LUuKSe8wmK+qtIJNPl8Yp47d0NN7IYOwXdd8z5VJ9GQXft
 mRB1Yq5MMCZBfkqu7ZKQoiRLNWTDC/q9K8yCV3qORJNOycUOuS+WffJtAbS7I7OKfnOdiTd+hoY
 egEuO0tjPDkIhuLQtSFPMGapTAkdO2iDzojDtLW907bLmmoRqVEEbR7P6rAFmAfhOcxtLjSBmEs
 EW406lsrVUKE7bMAaKGM7OurbwH4hZroMoIZf6PrJg==
X-Received: by 2002:a05:600c:b8a:b0:431:5e3c:2ff0 with SMTP id
 5b1f17b1804b1-438913c9f66mr223992245e9.8.1737623786586; 
 Thu, 23 Jan 2025 01:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaspfz/8dP6qx/jQI1137BeRxZd3eM2BBFA22bhF4D4E2gACqykuV7naKIzL/ZRnbWvELqwQ==
X-Received: by 2002:a05:600c:b8a:b0:431:5e3c:2ff0 with SMTP id
 5b1f17b1804b1-438913c9f66mr223991835e9.8.1737623786137; 
 Thu, 23 Jan 2025 01:16:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31898ebsm54953705e9.2.2025.01.23.01.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 01:16:25 -0800 (PST)
Message-ID: <79e908f3-3f93-4245-9e5e-25b8a1026322@redhat.com>
Date: Thu, 23 Jan 2025 10:16:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of
 devices
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Cedric Le Goater <clegoate@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20240117091559.144730-1-peterx@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240117091559.144730-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 1/17/24 10:15 AM, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
>
> There're issue reported that when syetem_reset the VM with an intel iommu
> device and MT2892 PF(mlx5_core driver), the host kernel throws DMAR error.
>
>   https://issues.redhat.com/browse/RHEL-7188
>
> Alex quickly spot a possible issue on ordering of device resets.
>
> It's verified by our QE team then that it is indeed the root cause of the
> problem.  Consider when vIOMMU is reset before a VFIO device in a system
> reset: the device can be doing DMAs even if the vIOMMU is gone; in this
> specific context it means the shadow mapping can already be completely
> destroyed.  Host will see these DMAs as malicious and report.
>
> To fix it, we'll need to make sure all devices under the vIOMMU device
> hierachy will be reset before the vIOMMU itself.  There's plenty of trick
> inside, one can get those by reading the last patch.

I have a case with intel iommu and vhost-net where I see that the vIOMMU
gets disabled by the guest before vhost_dev_stop() causing some spurious
lookup failures. This happens when rebooting the guest (see [PATCH]
hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets disabled
<https://lore.kernel.org/all/20250120173339.865681-1-eric.auger@redhat.com/>
https://lore.kernel.org/all/20250120173339.865681-1-eric.auger@redhat.com/
for more context).

I observe that
1) the guest disables the IOMMU through the vtd_handle_gcmd_write
2) vtd_reset (initiated from qemu_system_reset)
3) vhost_dev_stop (initiated from qemu_system_reset)

So I can effectively see the viommu is reset before vhost-net stop. 2)
is already an issue that looks the same as the one addressed in this
series. Now I am also in trouble wrt 1). I don't know yet which chain of
events causes the VTD GCMD TE bit to be written but this would also
cause spurious vhost IOLTB misses.

I haven't seen any follow-up on this series. Is anyone still looking at
this issue? Peter gave some guidance about the way to rework the reset
chain. Is it still up to date?

Thanks

Eric
>
> I didn't check other vIOMMUs, but this series should fix the issue for VT-d
> as of now.  The solution can be slightly ugly, but a beautiful one can be
> very non-trivial.
>
> Review comments welcomed, thanks.
>
> Peter Xu (4):
>   reset: qemu_register_reset_one()
>   reset: Allow multiple stages of system resets
>   intel_iommu: Tear down address spaces before IOMMU reset
>   intel_iommu: Reset vIOMMU at the last stage of system reset
>
>  include/sysemu/reset.h |  5 ++++
>  hw/core/reset.c        | 67 ++++++++++++++++++++++++++++++------------
>  hw/i386/intel_iommu.c  | 56 +++++++++++++++++++++++++++++++++--
>  3 files changed, 107 insertions(+), 21 deletions(-)
>


