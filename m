Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C27CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 12:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5O7E-0003fW-Iy; Sun, 05 Oct 2025 08:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5O7C-0003fA-E0
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 08:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5O79-0005gl-A2
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 08:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759668318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KR1y8/m51Ecc05xsnZIRC0Iz/kr/T1Wjfoadsa3v1QQ=;
 b=H7FNrrVajMW0gSniaVHRnZvL9xcYT//+kV0xcKX63Qegqis3fQ5785F00BXpEshVqL5itm
 9L1rRt4GTebmYtsRERwt1OuEJqjsyr9rH+MVCurPsGWl2gW1WMOw5l75E407Q3u7K/5/jC
 HsCO/V0SnHRLGPw5bqP6cUVOWGyD56I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-8lYvBwOlPGusOdAN7Tgfag-1; Sun, 05 Oct 2025 08:45:17 -0400
X-MC-Unique: 8lYvBwOlPGusOdAN7Tgfag-1
X-Mimecast-MFC-AGG-ID: 8lYvBwOlPGusOdAN7Tgfag_1759668316
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e375dab7dso17789505e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 05:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759668316; x=1760273116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KR1y8/m51Ecc05xsnZIRC0Iz/kr/T1Wjfoadsa3v1QQ=;
 b=iu3vQhjPL063TsUSPcmBCC0DQ7IUfM/eRmsHkXiUajucWVTiLKdnfP/aQxO9gCf51H
 mYnQQEfcEf6r5rSLYsiKp1UazWfAQQ1OJ6ChTtpRm9HRtx2sIoJJNb1INE1wTZq2Og12
 u4JXfNXiLtpuvx1aSgPzTKujb+r20rTwd2exbVJdJ3AXJeK/G/wFD2skaZfmygSfIOnJ
 GsND6HXbGTmDpLCCygMYV31O+g/wIknE+dWHU1o5HkyKDzIMiX4RqTtp/mqOSpgwsj0h
 /c0blcMPA5R78pLSTB6GHqpPNNXFsPmsGOZ1dOm34F+XRDCw8AOj+QXmOCD4Qea/obkT
 NG7Q==
X-Gm-Message-State: AOJu0YzyjotULQj8A1EkLtMEUQxTTplOKhsAB8fDsLiayEOAa4y6vq7l
 wLPBwwooOWb53p8gGSKaXDhy09UMxUURx9NSMXj+rIdPHDEhiezY0u7LNMQd57RvG1m0cM6zHdp
 WQckWhGfYEgaO153+myRLa+nUYJn6wfADnOpRnCxPP7xBtcDLgUNtW7lT
X-Gm-Gg: ASbGncskQ5YP9HEnlLg79ubgbMsqQWsyZKPxOyUoU5lEWuDI+qmVRS43YdjolDGQHqE
 nHT8at331/xSw99tSyFxeDOW3J7z8bsLFCOTH1mQvWznsMiFxpaExgNPJujyu8qHC9xuu7cPmhO
 8mJPayI38t7C0fnqlwMUUapTrxJjBGivjxJn+a0fmywTsfpnA3KZPWhQZFAPVtGGbuQt1XYd5b/
 AP5tdZGbX09ObnxyaDvg76J1g5Gu8r7mnvY5jt4HkLq4yTQagDsBrkiJOGivUYN2udYHlj9ztR6
 HoXPJ2RjmJ4j+JVPxojNfUb/txbTBOryUo6JKgU=
X-Received: by 2002:a05:600d:41d3:b0:46e:44bf:210 with SMTP id
 5b1f17b1804b1-46e7114453bmr53156705e9.22.1759668316123; 
 Sun, 05 Oct 2025 05:45:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbsoXb2kiK7g6Pja4HUrm8ae4syHjwOFjHFwFZp+tlGu4DVq+9nPqqpE9nmStTCo4BucCFHg==
X-Received: by 2002:a05:600d:41d3:b0:46e:44bf:210 with SMTP id
 5b1f17b1804b1-46e7114453bmr53156555e9.22.1759668315706; 
 Sun, 05 Oct 2025 05:45:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72362344sm114955735e9.15.2025.10.05.05.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 05:45:15 -0700 (PDT)
Date: Sun, 5 Oct 2025 08:45:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Zhaoxin <lizhaoxin04@baidu.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>, Miao Kezhan <miaokezhan@baidu.com>
Subject: Re: [PATCH v2] vdpa-dev: add get_vhost() callback for vhost-vdpa
 device
Message-ID: <20251005084340-mutt-send-email-mst@kernel.org>
References: <2778f817cb6740a15ecb37927804a67288b062d1.1758860411.git.lizhaoxin04@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2778f817cb6740a15ecb37927804a67288b062d1.1758860411.git.lizhaoxin04@baidu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Sep 26, 2025 at 07:08:17PM +0800, Li Zhaoxin wrote:
> Commit c255488d67 "virtio: add vhost support for virtio devices"
> added the get_vhost() function, but it did not include vhost-vdpa devices.
> 
> So when I use the vdpa device and query the status of the vdpa device
> with the x-query-virtio-status qmp command, since vdpa does not implement
> vhost_get, it will cause qemu to crash.
> 
> Therefore, in order to obtain the status of the virtio device under vhost-vdpa,
> we need to add a vhost_get implement for the vdpa device.
> 
> Co-developed-by: Miao Kezhan <miaokezhan@baidu.com>
> Signed-off-by: Miao Kezhan <miaokezhan@baidu.com>
> Signed-off-by: Li Zhaoxin <lizhaoxin04@baidu.com>


For some reason, in my inbox I have this with
	From: Li Zhaoxin <lizhaoxin04@baidu.com>
but on qemu-devel the from address is mangled:
https://lore.kernel.org/all/2778f817cb6740a15ecb37927804a67288b062d1.1758860411.git.lizhaoxin04@baidu.com/

I fixed it up but I suggest you figure out what happened here,
because I do not like to fix up patches manually.


> ---
>  hw/virtio/vdpa-dev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index d1da40afc8..4a7b970976 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -338,6 +338,12 @@ static int vhost_vdpa_device_set_status(VirtIODevice *vdev, uint8_t status)
>      return 0;
>  }
>  
> +static struct vhost_dev *vhost_vdpa_device_get_vhost(VirtIODevice *vdev)
> +{
> +    VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
> +    return &s->dev;
> +}
> +
>  static const Property vhost_vdpa_device_properties[] = {
>      DEFINE_PROP_STRING("vhostdev", VhostVdpaDevice, vhostdev),
>      DEFINE_PROP_UINT16("queue-size", VhostVdpaDevice, queue_size, 0),
> @@ -369,6 +375,7 @@ static void vhost_vdpa_device_class_init(ObjectClass *klass, const void *data)
>      vdc->set_config = vhost_vdpa_device_set_config;
>      vdc->get_features = vhost_vdpa_device_get_features;
>      vdc->set_status = vhost_vdpa_device_set_status;
> +    vdc->get_vhost = vhost_vdpa_device_get_vhost;
>  }
>  
>  static void vhost_vdpa_device_instance_init(Object *obj)
> -- 
> 2.34.1


