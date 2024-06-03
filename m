Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A1DC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 16:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEAL4-0007PW-Kb; Mon, 03 Jun 2024 12:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEAL2-0007Or-Ih
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEAL0-0001ws-4S
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717431307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZDkHPDARd6ByrLJnAQ3fC4BsMZLe6fYIgl0cOFLRvI=;
 b=NU6avS2lP3aRbUiO+PnJZy6B3DM06LKeqY8RZb/rkySVKwVVG66A/yRBKTj9ANRqD7QpVt
 Z5MQjAN+8Nyb0KsrxDSDgtPf1aHp7f/0gONQ2oe7x9c6Fg2NQmwzE2mIz/SXoTfocEzKgt
 qQgTuvcQTbiwoX/FqS/vLPh+7zJ9fwo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-sRWG2oiYMSmIAKuKhcLh6Q-1; Mon, 03 Jun 2024 12:15:05 -0400
X-MC-Unique: sRWG2oiYMSmIAKuKhcLh6Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35dc5934390so2327503f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 09:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717431305; x=1718036105;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HZDkHPDARd6ByrLJnAQ3fC4BsMZLe6fYIgl0cOFLRvI=;
 b=ew90LC2ty/rsBuWCPHVVKLabyy1geLd4xv48gOPpQX0lFBjfTgMw1AT5iv7vtSaMYH
 frbu+FwQrD9y8mbXtAUkRbAz/e9CjGFbykYYpjs38GYf3o3lzYJ4yK3upjEctaEpN5kG
 wiy54M88bSYfQ0Fa6p4FC8h7tnPqT9emgolqfH5VetFXOSEzyt/kkKOvnxwoVSB1tik7
 C07K/7rufF/rTBhsBQoICMENxZu0LfaCaUSRvQIA0Mr2zN5pVA83shmJfcurxNGxqfgP
 6gtAKr+aZeXfAQLW10CZeYbnjb5Zr40ovmi9on1E+IGbYtOFi2T2j3m3DIzfKBi5RXAx
 mzyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXR1zkiqxzRK/QoKouibL0XwrT0YAlRPFhsabXtpvnJyMuY+jELC4VPNRPCjrEtGFvKRvu1jHtsfiQkMlRBXZugw7TU98=
X-Gm-Message-State: AOJu0YwU6EQAaY6mP+s1MUv1JYyEGI363t7GS9OY9DCvIt8SjUGuScfN
 ufbslIaSQNOp9P1II6uT2X7GG/i0TBBVE6fl0YPl/LEl6jSxmO8hmhmlDalaFOTeTsZE/gGGl7J
 WRf8DCcVNdToYmrZ15jzFl7gRiz69ZO6846sgy17Dox44bJSDKf8+
X-Received: by 2002:adf:f9cc:0:b0:354:faec:c9e4 with SMTP id
 ffacd0b85a97d-35e0f32d749mr7275539f8f.60.1717431304710; 
 Mon, 03 Jun 2024 09:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSIxin9+jy2gnHUnAz+j9bdoBsMwWjhRMXb8FEO33MXhC1HW7gr7/nM3mURNdXX/QJJhLfkA==
X-Received: by 2002:adf:f9cc:0:b0:354:faec:c9e4 with SMTP id
 ffacd0b85a97d-35e0f32d749mr7275518f8f.60.1717431304181; 
 Mon, 03 Jun 2024 09:15:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7408:e400:91b4:ca60:f80c:a8e0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064998bsm9046025f8f.91.2024.06.03.09.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 09:15:03 -0700 (PDT)
Date: Mon, 3 Jun 2024 12:14:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: Eric Auger <eric.auger@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio-iommu: Do not process commands with bad size
Message-ID: <20240603121417-mutt-send-email-mst@kernel.org>
References: <20240404124505.2108743-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240404124505.2108743-1-zheyuma97@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Apr 04, 2024 at 02:45:05PM +0200, Zheyu Ma wrote:
> The device should not handle the commands which have bad request/reply
> size, it should just report the error instead of raising an assertation.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Seems to cause CI failures:
https://gitlab.com/mstredhat/qemu/-/jobs/7004894370


41/399 /riscv32/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-iommu-pci/virtio-iommu/virtio-iommu-tests/attach_detach - ERROR:../tests/qtest/libqos/virtio.c:230:qvirtio_wait_used_elem: assertion failed: (g_get_monotonic_time() - start_time <= timeout_us) FAIL          
▶  41/399                                                                     ERROR         
 41/399 qemu:qtest+qtest-riscv32 / qtest-riscv32/qos-test                     ERROR           76.80s   killed by signal 6 SIGABRT
>>> MALLOC_PERTURB_=235 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon QTEST_QEMU_BINARY=./qemu-system-riscv32 G_TEST_DBUS_DAEMON=/builds/mstredhat/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_IMG=./qemu-img PYTHON=/builds/mstredhat/qemu/build/pyvenv/bin/python3 /builds/mstredhat/qemu/build/tests/qtest/qos-test --tap -k




> ---
>  hw/virtio/virtio-iommu.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 1326c6ec41..3a7cdfe777 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -770,8 +770,8 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>              return;
>          }
>  
> -        if (iov_size(elem->in_sg, elem->in_num) < sizeof(tail) ||
> -            iov_size(elem->out_sg, elem->out_num) < sizeof(head)) {
> +        if (iov_size(elem->in_sg, elem->in_num) != sizeof(tail) ||
> +            iov_size(elem->out_sg, elem->out_num) != sizeof(head)) {
>              virtio_error(vdev, "virtio-iommu bad head/tail size");
>              virtqueue_detach_element(vq, elem, 0);
>              g_free(elem);
> @@ -818,8 +818,6 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
>  out:
>          sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
>                            buf ? buf : &tail, output_size);
> -        assert(sz == output_size);
> -
>          virtqueue_push(vq, elem, sz);
>          virtio_notify(vdev, vq);
>          g_free(elem);
> @@ -852,7 +850,7 @@ static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
>          return;
>      }
>  
> -    if (iov_size(elem->in_sg, elem->in_num) < sizeof(fault)) {
> +    if (iov_size(elem->in_sg, elem->in_num) != sizeof(fault)) {
>          virtio_error(vdev, "error buffer of wrong size");
>          virtqueue_detach_element(vq, elem, 0);
>          g_free(elem);
> @@ -861,8 +859,6 @@ static void virtio_iommu_report_fault(VirtIOIOMMU *viommu, uint8_t reason,
>  
>      sz = iov_from_buf(elem->in_sg, elem->in_num, 0,
>                        &fault, sizeof(fault));
> -    assert(sz == sizeof(fault));
> -
>      trace_virtio_iommu_report_fault(reason, flags, endpoint, address);
>      virtqueue_push(vq, elem, sz);
>      virtio_notify(vdev, vq);
> -- 
> 2.34.1


