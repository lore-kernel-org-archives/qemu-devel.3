Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC22DE87829
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 13:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnGMi-0007ar-IX; Tue, 03 Feb 2026 08:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnGMh-0007aY-In
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnGMf-0003Qw-D6
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770124964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ndQSdBX8cGPNgve9yPmKoU2rBt5Jaw3M7B4r7QAIeXM=;
 b=TQp0O+QTv+09RM+/8+wJeJyehkO9nyPVm+m6RRphMtv2YV0mw0hLgy8QojrFtjEfzrdvxt
 j6bq5GH1UaJiGz7KAW2zubLYni379iEdqG44VLU9zCviisthgwcmOF2wWOHuhcXSFpa3ER
 WnPNXkS/zV3dMbzSKA0a7q9OvAWff2s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-sP_ZIgq5Pw6Iqc3bbrRESA-1; Tue, 03 Feb 2026 08:22:42 -0500
X-MC-Unique: sP_ZIgq5Pw6Iqc3bbrRESA-1
X-Mimecast-MFC-AGG-ID: sP_ZIgq5Pw6Iqc3bbrRESA_1770124962
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430ffc4dc83so5760950f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770124961; x=1770729761; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ndQSdBX8cGPNgve9yPmKoU2rBt5Jaw3M7B4r7QAIeXM=;
 b=Qe3ru5j5hSaRjGtRlceH2Risogmi7cIx91sjv8DmEXXde7g6AVgOQzgf2wfQWw5ltY
 003W+O/3F1nZ+W4WKxbxdEmyjV4e5WLbEFRSDBz6Pvt/G5h+RvvvJmY9qUuLQKhbIfoZ
 L/ONOAj0P4BeVFg1ZViKF95yCzNKbavsB8Xgkw3RYf+XDlZ3ZdAdBirr03+670LnZalb
 p2PS4G3CSCF7N4hnf+Ks/oc+ioEfxFjdrivRTjhygmV9UEDra37Old8+YMnu+8pmcDvC
 AjJ8CR7N6WexnbDW0uQk8ah+jYD/K432zfhU2i+hYVZGYnwNYaZUWwu6X3D8idICSbCN
 voFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770124961; x=1770729761;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndQSdBX8cGPNgve9yPmKoU2rBt5Jaw3M7B4r7QAIeXM=;
 b=vbXVgKnwj0rSD5nYZpcP3NIqL2PZjw37SQHoOkGjA9Fy7G6A2FPnJkymFBSK4NM07X
 2VmfRVrlk08Tg2CymAAFqD/r8QTB7Noxht//p4qg3HYt1YuTL6loMoVDKjBprbmsW6mL
 cIuoeYTKEfwA0lU2O26cfEhmKMhA0bBRuzOxA2/fOjbCJKOW+oka4U3t72xMU6rufPvF
 2PzqaOiXGUlaJF0H3CQB75nBp2sd9/Gb7KhcSLnf0BjeCwuTIrmAhxIALPlrkmqU/InT
 +5iamzwmrQCDvvNF5cwlU58BAzNa64lrmpT0ahOEBdgo+X/s75r5HirrSMcV0jow6Ed6
 6k9Q==
X-Gm-Message-State: AOJu0YznfjDsC6JgLtwj0xn+VflQ5Qy60xIfopxL0HfmnTneNsivomLG
 Uz2hmx/L3kaoNq9mR9uw3wh8hut3KQTlpzU6k0AVn7PLVOdqVqEZZi4SV8basgCaSn6uqPLlUr/
 DPd+4nJGaXcbJU4S+SiFaLm1Q6xVHMfU8ZCuElSP/bkff1c6Z+VdEKPGZ
X-Gm-Gg: AZuq6aJo/r3vwkU3fEr/rl+EGDIsu8++OO4x0Q2oBq1k9h4GOKlu4woxlivpkcTMRtZ
 fzbi+eYUzXDtSsOdr9Ube/IG0YTd7WhaePx6phmfGw3DO02fHjdAQWwrlcOQ0uGN+aCzUIuZI5v
 v8SvFQ+VNfLgkN5VcvlRTKB25DXdWZvVTDk8LoxSltjFa1sFhNfmMZySAiWBb3pdGqOuhh88tuD
 JOe5jnT8+1oP1RNcuBjqWshZbg1SkdnIRe1D+sXaPtTvau7+uIGOI6jZ/c3Gj7qXBdIbQ14U+RC
 7eVB/Ss6/0CzuvZPDsi4IeUeOxCg+jYeX+pvwTGFAz4oSUBil6W18NPjQMx67d2ZtNpNS8EgH3P
 i1h9N003Y3CeWg+yLcf05WQaVrFC7USTC0Q==
X-Received: by 2002:a05:6000:1849:b0:435:a21c:f946 with SMTP id
 ffacd0b85a97d-435f3ab0131mr22675177f8f.49.1770124961328; 
 Tue, 03 Feb 2026 05:22:41 -0800 (PST)
X-Received: by 2002:a05:6000:1849:b0:435:a21c:f946 with SMTP id
 ffacd0b85a97d-435f3ab0131mr22675131f8f.49.1770124960876; 
 Tue, 03 Feb 2026 05:22:40 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436143d81desm3968259f8f.42.2026.02.03.05.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 05:22:40 -0800 (PST)
Date: Tue, 3 Feb 2026 08:22:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, bill.mills@linaro.org,
 edgar.iglesias@amd.com
Subject: Re: [PATCH v1 0/5] virtio: Add the virtio-msg transport
Message-ID: <20260203082120-mutt-send-email-mst@kernel.org>
References: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Oct 28, 2025 at 04:23:45PM +0100, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> This adds virtio-msg, a new virtio transport. Virtio-msg works by
> exchanging messages over a bus and doesn't rely on trapping and emulation
> making it a good fit for a number of applications such as AMP, real-time
> and safety applications.
> 
> Together with the new transport, this series adds a PCI device that
> implements an AMP setup much like it could look if two SoC's would
> use virtio-msg across a PCI link.
> 
> Current gaps and limitations:
> Shared memory FIFO layout likely to change in the future.
> Temporarily uses PCI Vendor Xilinx / Device 0x9039.
> Documentation.


I'm happy that the spec effort is making progress finally.
Do you want to repost a version aligned to the latest spec posted?


> The virtio-msg draft spec:
> https://github.com/Linaro/virtio-msg-spec/
> 
> QEMU with these patches:
> https://github.com/edgarigl/qemu/tree/edgar/virtio-msg-rfc
> 
> Linux with virtio-msg support:
> https://github.com/edgarigl/linux/tree/edgari/virtio-msg-6.17
> 
> To try it, first build Linux with the following enabled:
> CONFIG_VIRTIO_MSG=y
> CONFIG_VIRTIO_MSG_AMP=y
> CONFIG_VIRTIO_MSG_AMP_PCI=y
> 
> Boot linux on QEMU with a virtio-msg-amp-pci device, in this example
> with a virtio-net device attached to it:
> 
>  -device virtio-msg-amp-pci
>  -device virtio-net-device,netdev=n0
>  -netdev user,id=n0
> 
> If you're running on a QEMU machine that has virtio-mmio enabled, e.g 
> ARM virt, you'll need to specify the virtio-bus for the device, otherwise
> QEMU will connect it to virtio-mmio. For ARM virt machines:
> 
>  -device virtio-msg-amp-pci
>  -device virtio-net-device,netdev=n0,bus=/gpex-pcihost/pcie.0/virtio-msg-amp-pci/fifo0/virtio-msg/bus0/virtio-msg-dev
>  -netdev user,id=n0
> 
> Cheers,
> Edgar
> 
> Edgar E. Iglesias (5):
>   virtio: Introduce notify_queue
>   virtio: Add virtio_queue_get_rings
>   virtio: Add the virtio-msg transport
>   hw/misc: Add generic virtio-msg AMP PCI device
>   docs: Describe virtio-msg-amp-pci
> 
>  .../devices/virtio/virtio-msg-amp-pci.rst     |  70 ++
>  hw/misc/Kconfig                               |   7 +
>  hw/misc/meson.build                           |   1 +
>  hw/misc/virtio-msg-amp-pci.c                  | 328 +++++++
>  hw/virtio/Kconfig                             |   4 +
>  hw/virtio/meson.build                         |   5 +
>  hw/virtio/virtio-msg-bus.c                    |  89 ++
>  hw/virtio/virtio-msg.c                        | 695 ++++++++++++++
>  hw/virtio/virtio.c                            |  23 +
>  include/hw/virtio/spsc_queue.h                | 213 +++++
>  include/hw/virtio/virtio-bus.h                |   1 +
>  include/hw/virtio/virtio-msg-bus.h            |  95 ++
>  include/hw/virtio/virtio-msg-prot.h           | 846 ++++++++++++++++++
>  include/hw/virtio/virtio-msg.h                |  56 ++
>  include/hw/virtio/virtio.h                    |   2 +
>  15 files changed, 2435 insertions(+)
>  create mode 100644 docs/system/devices/virtio/virtio-msg-amp-pci.rst
>  create mode 100644 hw/misc/virtio-msg-amp-pci.c
>  create mode 100644 hw/virtio/virtio-msg-bus.c
>  create mode 100644 hw/virtio/virtio-msg.c
>  create mode 100644 include/hw/virtio/spsc_queue.h
>  create mode 100644 include/hw/virtio/virtio-msg-bus.h
>  create mode 100644 include/hw/virtio/virtio-msg-prot.h
>  create mode 100644 include/hw/virtio/virtio-msg.h
> 
> -- 
> 2.43.0


