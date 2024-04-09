Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16570CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 06:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru4wV-0001Pt-7v; Tue, 09 Apr 2024 02:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru4wH-0001P6-Cx
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 02:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ru4wE-0005CK-9g
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 02:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712643992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n+vBgzkMfWX9QqGlWIVXaqQ3JoTheSuWCYO/W5s/lAg=;
 b=haS0gkxWw9hj4til5FwEXOdTD5ONOWZpXdSB6eiaid3BNgu6j+GkjgbmoPx0TlAlZW5X31
 xytv8P5rXTxN9YDRqgdQ3gadcMev1cpREQc35ssVshADZSl8RHcCXMQhVqzvVMwJP4WXK4
 iTKfMFecxH+4VrAhH1s+0Wu7d3P3Kk4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-cddYLY_TN-WYVTavpldP5A-1; Tue, 09 Apr 2024 02:26:31 -0400
X-MC-Unique: cddYLY_TN-WYVTavpldP5A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-516fe9d0c4dso939473e87.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 23:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712643989; x=1713248789;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n+vBgzkMfWX9QqGlWIVXaqQ3JoTheSuWCYO/W5s/lAg=;
 b=ADit6KAExNaYepRqxYF8sciI91lmBEgUnjrGBzhfis/BLzVSJox+QC5V4I7rW1G8zZ
 qwsueGiB5Jy2ldU5TFJRapFP2QKHfz3KvVbq0YxRJoXvwGQ4rn12cXClZIGRR1Fbndii
 twI/Adf71ufXqhq9umMURhu/towxUMOK0FpFJM9KfxgDlQk6IBhvOY4k0tCZZQ5Cik/y
 2t4igxHwzEHtki4QOz/lpW4PxswXST/Uadr/eSMwkvoF5ZjOvK7elS2U7IP7AL5iAAhG
 Xkn+s+7Jmh+EHbpZZIq/lCSKMAzzvZB5N1C7uptQblZmeS0WUe2kTUMxvrYr9bBBL50r
 1foA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrNOAM3Kyrvuuho4gGuH97qm1pFw/pFC12mtNwNx+hWbzmXH5EhdVIb1EgQ+ppjgStViiBqSOsRDKV7SfKfqtPtLhJtXM=
X-Gm-Message-State: AOJu0YyEgu2gV/AsHNSsIQudsip2XSATg6b/4XaC9viH7VxvOi3OytXU
 +mGWNILeTzChIx3C7uPMtUlEVFiOl0u4B4GpvucWA+Pn9Npo58ImX+QDOTIHqbRTJRttjqwmqi6
 eylx4hS+DXIc/6Ri8Zuxr/sJBXEDqZEyGFNA17Mz083ccmjktzGtSA3H/QmnO
X-Received: by 2002:a05:6512:285:b0:516:d18b:eaea with SMTP id
 j5-20020a056512028500b00516d18beaeamr7088645lfp.33.1712643989187; 
 Mon, 08 Apr 2024 23:26:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnCSxx+B6D12G39UZjuU7MkhnUhwgcaFdY0WRRGQ8ZJPtVsmsnWqDi0MixQRi58JpiHzQIEg==
X-Received: by 2002:a05:6512:285:b0:516:d18b:eaea with SMTP id
 j5-20020a056512028500b00516d18beaeamr7088632lfp.33.1712643988593; 
 Mon, 08 Apr 2024 23:26:28 -0700 (PDT)
Received: from redhat.com ([2.52.134.26]) by smtp.gmail.com with ESMTPSA id
 ek15-20020a056402370f00b0056c3013485csm4828166edb.69.2024.04.08.23.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 23:26:27 -0700 (PDT)
Date: Tue, 9 Apr 2024 02:26:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: Eric Auger <eric.auger@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio-iommu: Do not process commands with bad size
Message-ID: <20240409022246-mutt-send-email-mst@kernel.org>
References: <20240404124505.2108743-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240404124505.2108743-1-zheyuma97@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 04, 2024 at 02:45:05PM +0200, Zheyu Ma wrote:
> The device should not handle the commands which have bad request/reply
> size, it should just report the error instead of raising an assertation.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

This fails test for cross-i686-tci


https://gitlab.com/mstredhat/qemu/-/jobs/6578222837

57/258 ERROR:../tests/qtest/libqos/virtio.c:230:qvirtio_wait_used_elem: assertion failed: (g_get_monotonic_time() - start_time <= timeout_us) ERROR         
 57/258 qemu:qtest+qtest-i386 / qtest-i386/qos-test                        ERROR           56.69s   killed by signal 6 SIGABRT
>>> QTEST_QEMU_BINARY=./qemu-system-i386 PYTHON=/builds/mstredhat/qemu/build/pyvenv/bin/python3 MALLOC_PERTURB_=112 G_TEST_DBUS_DAEMON=/builds/mstredhat/qemu/tests/dbus-vmstate-daemon.sh /builds/mstredhat/qemu/build/tests/qtest/qos-test --tap -k
――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
stderr:
Vhost user backend fails to broadcast fake RARP
qemu-system-i386: -chardev socket,id=chr-reconnect,path=/tmp/vhost-test-80QXL2/reconnect.sock,server=on: info: QEMU waiting for connection on: disconnected:unix:/tmp/vhost-test-80QXL2/reconnect.sock,server=on
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: -chardev socket,id=chr-connect-fail,path=/tmp/vhost-test-CZMWL2/connect-fail.sock,server=on: info: QEMU waiting for connection on: disconnected:unix:/tmp/vhost-test-CZMWL2/connect-fail.sock,server=on
qemu-system-i386: -netdev vhost-user,id=hs0,chardev=chr-connect-fail,vhostforce=on: Failed to read msg header. Read 0 instead of 12. Original request 1.
qemu-system-i386: -netdev vhost-user,id=hs0,chardev=chr-connect-fail,vhostforce=on: vhost_backend_init failed: Protocol error
qemu-system-i386: -netdev vhost-user,id=hs0,chardev=chr-connect-fail,vhostforce=on: failed to init vhost_net for queue 0
qemu-system-i386: -netdev vhost-user,id=hs0,chardev=chr-connect-fail,vhostforce=on: info: QEMU waiting for connection on: disconnected:unix:/tmp/vhost-test-CZMWL2/connect-fail.sock,server=on
qemu-system-i386: Failed to write msg. Wrote -1 instead of 20.
qemu-system-i386: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: -chardev socket,id=chr-flags-mismatch,path=/tmp/vhost-test-CBHDM2/flags-mismatch.sock,server=on: info: QEMU waiting for connection on: disconnected:unix:/tmp/vhost-test-CBHDM2/flags-mismatch.sock,server=on
qemu-system-i386: Failed to write msg. Wrote -1 instead of 84.
qemu-system-i386: vhost_set_mem_table failed: Invalid argument (22)
qemu-system-i386: unable to start vhost net: 22: falling back on userspace virtio
vhost lacks feature mask 0x40000000 for backend
qemu-system-i386: failed to init vhost_net for queue 0
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to write msg. Wrote -1 instead of 20.
qemu-system-i386: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 2 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 3 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 0 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: Failed to set msg fds.
qemu-system-i386: vhost VQ 1 ring restore failed: -22: Invalid argument (22)
qemu-system-i386: virtio-iommu bad head/tail size
**
ERROR:../tests/qtest/libqos/virtio.c:230:qvirtio_wait_used_elem: assertion failed: (g_get_monotonic_time() - start_time <= timeout_us)
(test program exited with status code -6)
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――


So we hit the error where we did not previously hit the assert.

Dropped for now. Pls figure it out and resubmit.

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


