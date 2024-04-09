Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C8CCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 09:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru7pG-0003f5-QL; Tue, 09 Apr 2024 05:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru7p5-0003eI-W9
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru7p4-00056e-Ab
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 05:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712655081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CHm9lErPneZ6NueFGn5T2q6OqOjCG2hYKnmdyw3Evnc=;
 b=FB2Sbjf7dc5w6hA73wswe8w62fNPdkegSe7/ekjVOUfqF4GXP4SZ7jV3ScKEN1bQqoKEWy
 SUdh/yamJhT2/B/Cmg1rBM9oJcUYzC79JeJx5PEroxz3FPWrUHiy3iXOXrEh5N475K0oDw
 9Iu/OSCUHEdU9pfj+ikI2JcXhCpvh8o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-Z_rJubhyNP2SVRck6ogXgg-1; Tue, 09 Apr 2024 05:31:18 -0400
X-MC-Unique: Z_rJubhyNP2SVRck6ogXgg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41401f598cfso31786225e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 02:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712655076; x=1713259876;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CHm9lErPneZ6NueFGn5T2q6OqOjCG2hYKnmdyw3Evnc=;
 b=uH+GtGS9YMCwitg3hP6tsyQnBiqzFbecFl/7dmOSe+2u+WWYu+uWfVu8pLWNKCqdCc
 sBU+T4lK0xBM/+D/N2WegwXh0/Fah1odOz4NXtqTsP17g185t//mkpVVva9+aKXVItcA
 8nZMzqolAdhnvYistB4FAayXFdU6KtrXhfn2AZlMH6xTVqpN6GlgdeGXGh5Ut8cuS+x3
 wZWDMNkpb0yqEGkpyPItaQ7a+GVcvUMIUpJf7HqqlSWt8Q70/honG44fjF8aZugFfKpM
 1EEjyPjLystIL30/yi6Y6D9Z7HdxiX0Dh1TEm4sIPNCdkobJOrDiR+RvzxKKTket6J8N
 KH4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDOJpkp3CFiaoSaKpMP5/A1fgY9ddEedN5/uAvEEtH1fSiiAKxwUUkElIULjR5rPfltcCevpbBeqEeSZ7R3aPe7ozYwok=
X-Gm-Message-State: AOJu0YxOXjSIH6d09Gy95O3Y6ObjXymbYezhUMDW8M6iCL+WEJuxYaGF
 g2BeVCvXk72CZ62IiwCPEvs8gY/X3RczinxiUO7hQ6hCvkH2TW4yLi8pszs+G3QANpZxdZGFPs/
 K+wIC8SO3uPv1/hTmR76voX5d8pEaV5g2nU38+Uvbhx+ZOa7Crf/Y
X-Received: by 2002:a05:600c:b8e:b0:416:50ce:20d2 with SMTP id
 fl14-20020a05600c0b8e00b0041650ce20d2mr4844333wmb.0.1712655075735; 
 Tue, 09 Apr 2024 02:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGthi+WR0T65jCCLC2UuGWDSWe4milpnGtbK9ltu+w2f7EgsiDlRR4qreyZjzY3oO5vEBr8WQ==
X-Received: by 2002:a05:600c:b8e:b0:416:50ce:20d2 with SMTP id
 fl14-20020a05600c0b8e00b0041650ce20d2mr4844307wmb.0.1712655075168; 
 Tue, 09 Apr 2024 02:31:15 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 je4-20020a05600c1f8400b004149536479esm16590538wmb.12.2024.04.09.02.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 02:31:14 -0700 (PDT)
Date: Tue, 9 Apr 2024 05:31:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: lyx634449800 <yuxue.liu@jaguarmicro.com>
Cc: jasowang@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] vhost: don't set vring call if no enabled msix
Message-ID: <20240409052957-mutt-send-email-mst@kernel.org>
References: <20240408060842.2012-1-yuxue.liu@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408060842.2012-1-yuxue.liu@jaguarmicro.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Apr 08, 2024 at 02:08:42PM +0800, lyx634449800 wrote:
> When conducting performance testing using testpmd in the guest os,
> it was observed that the performance was lower compared to the
> scenario of direct vfio-pci usage.
> 
> In the virtual machine operating system, even if the virtio device
> does not use msix interrupts, vhost still sets vring call fd. This
> leads to unnecessary performance overhead. If the guest driver does
> not enable msix capability (e.g virtio-net pmd), we should also
> check and clear the vring call fd.
> 
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>


Fails testing under cross-i686-tci:

https://gitlab.com/mstredhat/qemu/-/jobs/6578881990

36/258 qemu:qtest+qtest-i386 / qtest-i386/ioh3420-test                    OK               0.15s   1 subtests passed
▶  37/258 ERROR:../tests/qtest/qos-test.c:191:subprocess_run_one_test: child process (/aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/migrate/subprocess [22197]) failed unexpectedly ERROR         
 38/258 qemu:qtest+qtest-i386 / qtest-i386/lpc-ich9-test                   OK               0.16s   1 subtests passed
 37/258 qemu:qtest+qtest-aarch64 / qtest-aarch64/qos-test                  ERROR           13.20s   killed by signal 6 SIGABRT
>>> G_TEST_DBUS_DAEMON=/builds/mstredhat/qemu/tests/dbus-vmstate-daemon.sh PYTHON=/builds/mstredhat/qemu/build/pyvenv/bin/python3 MALLOC_PERTURB_=144 QTEST_QEMU_BINARY=./qemu-system-aarch64 /builds/mstredhat/qemu/build/tests/qtest/qos-test --tap -k
――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
stderr:
**
ERROR:../tests/qtest/vhost-user-test.c:468:chr_read: assertion failed (err == NULL): Bad file descriptor (g-unix-error-quark, 0)
**
ERROR:../tests/qtest/qos-test.c:191:subprocess_run_one_test: child process (/aarch64/virt/generic-pcihost/pci-bus-generic/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/migrate/subprocess [22197]) failed unexpectedly
(test program exited with status code -6)
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――


> ---
>  hw/virtio/vhost.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index f50180e60e..b972c84e67 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1266,13 +1266,15 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          vhost_virtqueue_mask(dev, vdev, idx, false);
>      }
>  
> -    if (k->query_guest_notifiers &&
> -        k->query_guest_notifiers(qbus->parent) &&
> -        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
> -        file.fd = -1;
> -        r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
> -        if (r) {
> -            goto fail_vector;
> +    if (k->query_guest_notifiers) {
> +        if (!k->query_guest_notifiers(qbus->parent) ||
> +            (k->query_guest_notifiers(qbus->parent) &&
> +            virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR)) {
> +            file.fd = -1;
> +            r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
> +            if (r) {
> +                goto fail_vector;
> +            }
>          }
>      }
>  
> -- 
> 2.43.0


