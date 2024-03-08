Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF278C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridbB-0005aN-1T; Fri, 08 Mar 2024 12:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ridai-0005KO-Pc
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:01:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ridae-0000RH-Dd
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709917259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5mlJPTdJkWjqRDFmHZCmG622raxGwhz9st2Ydsv++Y=;
 b=QIxxkbjFGlQPZxxu+17dwtcDfLtdt8xOWIoVAc7zHhXS/YXyS2hTQKZnpciYW4C+JwO5F1
 ioF0Yfb5wlewqwEQ5O+NDc5jAITd4NjhUyUx5vFg1siu1gOTSNGJN+EfTJMTErMRf1ZCFZ
 rLfc9vjWuqGJQxMT7rxGKRxT85cYEug=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-bmFawY9nNRqRyJmw1FeR_Q-1; Fri, 08 Mar 2024 12:00:57 -0500
X-MC-Unique: bmFawY9nNRqRyJmw1FeR_Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33dfefa9b1dso1188773f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 09:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709917257; x=1710522057;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G5mlJPTdJkWjqRDFmHZCmG622raxGwhz9st2Ydsv++Y=;
 b=SUJp1S0Z0VC0ToI8HboRC+M7q/x5V9IfAtPG1TlG3TiGkjM70syoEU94mwzTKk8IM6
 qulg1yyBeHi6ZfVbytT0QETj0h8Fi9+LSBtrq52arLtOsNDPcvUKRmFND2LzeIkgbMPO
 Q9FwcMnwvXXDzmEIl09PqXbFfcFvVE9Io5+2JC/peR1hDXJ/Xb/Opqmg/N4RYKjn/4Tw
 dh5t+KIuFTtO+GKyx4wBhN9xhSN0EkWL+OtgS33/SScIVL6kAt6hL94Bev6oRpvZuDDg
 sIsApIcdBPM8oWOzEsjQi2pIe9D40+FRweqxOiYAhvYXECLraXCxsuP5xKSLk+jSagP7
 kzxw==
X-Gm-Message-State: AOJu0YyfgLSZFH2WzLQ2KzIU6atT9zV6GBnffylFTGoi4Bx4FXi41okM
 hCCsOL9D5w25PLE9H3OBRNtLPLr7+MxWYw2q2MGj5YApEpK0pdPQw5Zmi5pFsJNZA1dfB8sH6lq
 0go/9M9uT2NyZcuQ4/NyqWPtHLwa0reP7rEBdIiuYpjEO/181nsYz
X-Received: by 2002:adf:f74d:0:b0:33e:6a81:d8b9 with SMTP id
 z13-20020adff74d000000b0033e6a81d8b9mr964619wrp.20.1709917256546; 
 Fri, 08 Mar 2024 09:00:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5+HudhTCCO9/AQo1CbSQZRDzjKBZSZp57vnRV8/sIdymJYpEjcFBPYQEqzecM/mPOfNdlCA==
X-Received: by 2002:adf:f74d:0:b0:33e:6a81:d8b9 with SMTP id
 z13-20020adff74d000000b0033e6a81d8b9mr964568wrp.20.1709917255979; 
 Fri, 08 Mar 2024 09:00:55 -0800 (PST)
Received: from redhat.com ([2a06:c701:73cd:f300:bc74:daca:b316:492a])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a5d50ce000000b0033b66c2d61esm23296385wrt.48.2024.03.08.09.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 09:00:55 -0800 (PST)
Date: Fri, 8 Mar 2024 12:00:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, eperezma@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 raphael@enfabrica.net, kwolf@redhat.com, hreitz@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 cohuck@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 stefanha@redhat.com, qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 virtio-fs@lists.linux.dev
Subject: Re: [PATCH v1 2/8] virtio-pci: Lock ioeventfd state with
 VIRTIO_F_NOTIFICATION_DATA
Message-ID: <20240308115951-mutt-send-email-mst@kernel.org>
References: <20240304194612.611660-1-jonah.palmer@oracle.com>
 <20240304194612.611660-3-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304194612.611660-3-jonah.palmer@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 04, 2024 at 02:46:06PM -0500, Jonah Palmer wrote:
> Prevent ioeventfd from being enabled/disabled when a virtio-pci
> device has negotiated the VIRTIO_F_NOTIFICATION_DATA transport
> feature.
> 
> Due to ioeventfd not being able to carry the extra data associated with
> this feature, the ioeventfd should be left in a disabled state for
> emulated virtio-pci devices using this feature.
> 
> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

I thought hard about this. I propose that for now,
instead of disabling ioevetfd silently we error out unless
user disabled it for us.
WDYT?


> ---
>  hw/virtio/virtio-pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index d12edc567f..287b8f7720 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -417,13 +417,15 @@ static void virtio_ioport_write(void *opaque, uint32_t addr, uint32_t val)
>          }
>          break;
>      case VIRTIO_PCI_STATUS:
> -        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +        if (!(val & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
>              virtio_pci_stop_ioeventfd(proxy);
>          }
>  
>          virtio_set_status(vdev, val & 0xFF);
>  
> -        if (val & VIRTIO_CONFIG_S_DRIVER_OK) {
> +        if ((val & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +            !virtio_vdev_has_feature(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
>              virtio_pci_start_ioeventfd(proxy);
>          }
>  
> -- 
> 2.39.3


