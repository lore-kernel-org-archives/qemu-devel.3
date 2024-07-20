Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F950C3DA63
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFZQ-0008Du-I2; Sat, 20 Jul 2024 15:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFZO-00084Q-1z
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFZM-00013H-QH
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721502995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TotupQWpD/GVU6gkou9HXvrJdz2NmKtSZtsiZcOY+aU=;
 b=jLnogX3w4SkXikIuBC+G2NqGy/B5f2bBlM9wPqTs4S42obIbVO43vWwssaOs7IfuQ4g8JR
 1j7dqlb5e+v9ls5FLnJ5zTL2uOhoyKXWGk3EKH7USm7EiIyT0pK15ctNaHlLDWg0OQyQ7s
 SsP45trPmK6meAPCpD7UxfsommbBFds=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-zWK2AjKIPSmDjNacF3fFYg-1; Sat, 20 Jul 2024 15:16:31 -0400
X-MC-Unique: zWK2AjKIPSmDjNacF3fFYg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36871eb0a8eso1442934f8f.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 12:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721502990; x=1722107790;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TotupQWpD/GVU6gkou9HXvrJdz2NmKtSZtsiZcOY+aU=;
 b=CYe74sAFKNoPGhAzGUFupSxpnmIwXYVK5yuY/0dIJnVN9wYBWwLzS4qmydx+GwR5x6
 psT2S+KpabrLQaaYlml8yPMvFSicF620Oe5gduPSqfW1lc9f8t0JeJBuK1gPYQNP/jpY
 iyEisN+u6PfhyuXRaSIdxGFPEadZqcA6P7SuUB4TGuGRvBA4cM3QaieARuW86HjST0G8
 AMx4hwtXBKCdRyn6wm25gPONSxrXaMTh2Laiy5x2jYta40q/U8C7lBtq0BI9QWstGPGs
 Cy5iACO6WebuRB8M49fxx5pKPNspOvo98NwHk1mSI5771tst6J4y5j9YkySKor3LPdjL
 pQTQ==
X-Gm-Message-State: AOJu0Ywo53pHUMLAWEu6szLbmSjhESunBJPxvmglh6JONuOJIHDUlRNH
 EQnq+d46C1n8mN+ceAdSL6KEp3xKf7i+KvjDjIcSdS85IP9Fb3PDDPplPGzx5tMlx9xbQV3cnTp
 cuUCiWkhmuUv7cWHxE9EeCPp1ZZLxieOkxIh2BukkybGmHGHV5g8N
X-Received: by 2002:adf:e84a:0:b0:367:97b9:d5ed with SMTP id
 ffacd0b85a97d-369bae4a3bdmr1367704f8f.9.1721502990522; 
 Sat, 20 Jul 2024 12:16:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF91mmIMjLb1LISne4ihplZUmmRSaZhE/4sGStWEsyTWSLpObllroymxZZbCCku4Fl+qJRSSQ==
X-Received: by 2002:adf:e84a:0:b0:367:97b9:d5ed with SMTP id
 ffacd0b85a97d-369bae4a3bdmr1367690f8f.9.1721502989968; 
 Sat, 20 Jul 2024 12:16:29 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868493bsm4403401f8f.24.2024.07.20.12.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 12:16:29 -0700 (PDT)
Date: Sat, 20 Jul 2024 15:16:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, raphael@enfabrica.net, kwolf@redhat.com,
 hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 fam@euphon.net, eperezma@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, schalla@marvell.com, leiyang@redhat.com,
 virtio-fs@lists.linux.dev, si-wei.liu@oracle.com,
 boris.ostrovsky@oracle.com
Subject: Re: [PATCH v4 6/6] virtio: Add VIRTIO_F_IN_ORDER property definition
Message-ID: <20240720151557-mutt-send-email-mst@kernel.org>
References: <20240710125522.4168043-1-jonah.palmer@oracle.com>
 <20240710125522.4168043-7-jonah.palmer@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710125522.4168043-7-jonah.palmer@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 10, 2024 at 08:55:19AM -0400, Jonah Palmer wrote:
> Extend the virtio device property definitions to include the
> VIRTIO_F_IN_ORDER feature.
> 
> The default state of this feature is disabled, allowing it to be
> explicitly enabled where it's supported.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>


Given release is close, it's likely wise.
However, I think we should flip the default in the future
release.

> ---
>  include/hw/virtio/virtio.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index fdc827f82e..d2a1938757 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -373,7 +373,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>      DEFINE_PROP_BIT64("packed", _state, _field, \
>                        VIRTIO_F_RING_PACKED, false), \
>      DEFINE_PROP_BIT64("queue_reset", _state, _field, \
> -                      VIRTIO_F_RING_RESET, true)
> +                      VIRTIO_F_RING_RESET, true), \
> +    DEFINE_PROP_BIT64("in_order", _state, _field, \
> +                      VIRTIO_F_IN_ORDER, false)
>  
>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>  bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
> -- 
> 2.43.5


