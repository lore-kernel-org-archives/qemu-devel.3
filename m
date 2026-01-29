Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BAED6101A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 14:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSfK-00010o-BZ; Thu, 29 Jan 2026 09:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlSfH-000109-4j
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:06:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vlSfF-0004G9-5T
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 09:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769695586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jMFUCVWRFIIkI6kAu1KSIwG61wj0aof6ueOK0gLXJGU=;
 b=L5Ja+e0z5AbfcnK2e+wupOHO8evUBOehxRgO8HQVb/4W1COKvc5MOoRDWXnMLwBX6Lfk9I
 YEdAeGgwQ9ntQboDd/l9YGpqInRwcjJiHkhPdAE8inr9iBUYJ/9jfYtTYSdNxqyMgrxw0X
 EXdXouEvW6IgE+osumtT9D0wKNsearU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-DgAntBZGMbuustXc6DHx1A-1; Thu, 29 Jan 2026 09:06:25 -0500
X-MC-Unique: DgAntBZGMbuustXc6DHx1A-1
X-Mimecast-MFC-AGG-ID: DgAntBZGMbuustXc6DHx1A_1769695584
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806865a01bso7228715e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 06:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769695584; x=1770300384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jMFUCVWRFIIkI6kAu1KSIwG61wj0aof6ueOK0gLXJGU=;
 b=WLNMik8Xiw6hE/9axHRia1inHM+yhCNFJWWLR3aRstVqVWc5J6wvNZZW0fkuEw8/Dc
 PSuDh2v4vZ9gkE5BNzLzCu6xrBaClmnM+F8I3CiWDhHl/QwrbdRsYsgybVlcv4aB5VVz
 ewzaoTV0Pxvr9Ze5G3x16BsniDvm5FNOEZNj63K3hNEix9ILZnjFy3XFptQYQsZOAqBf
 H5S4ZWRHx3L39oIxyo7ZClCGP7u7gzsdFFAMZxE4cnSLOYfBZvReUv2XCF1GqvVB2ujB
 8S18QO/8cAwie+BaXl80m9aKKddRHd0G7FUTk39Sb1Fjy5VS9xesjYxCcu2wY4AW6Sag
 rxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769695584; x=1770300384;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMFUCVWRFIIkI6kAu1KSIwG61wj0aof6ueOK0gLXJGU=;
 b=AdXR76V8qdnoH9ME305PW5+8YJIL5xzkzjBd3UuGwBT9RLNEVedrEndzt/7TB3krzE
 ChsTm2ACiupDbMcyD6PlGephFtE3AC6Op12akwl5aI7VDMs0QOhxp7eMevVTqot0AOhf
 B2681WvVvhwnxflaD3UPP2GU915Y4EzEruZ45jiGL6PPNNKbPcGsZw0v5bKnaNjVq7we
 s2jpWL+/Fm5MUo6B+rHNHw53yW3fw6xuYgsCnY0gv2Q2i9vjgtHoB+t23SMaEHonCCLR
 IiCK20QyR9i9ZMJlQCk+HrH92Wy7V8YrAkc4JkP7/lVC0yw20ppm3cTzeSVbu+pu7H1J
 6Fyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcv/8OthKTuk25HZBQSwMCm7DPnWHmbvwoL0J9D92mmBkkLQidNy0QdMiDt59KADHkQpjC+dh1XCS6@nongnu.org
X-Gm-Message-State: AOJu0Yy+rtzdgQS28/v2dmp/tixvaqN2q5gz/QucFUNnd6a1qUUGEdDg
 lnHDlAG8oEqMiQtMAiAABPuwWS99SqeXCYyBwBo2K0Hd3vZaisfTeBH+0wy+t2X+aBQHeMAtAEn
 KepMFXWrfD9NzjIHNSK+OF1dlg/FW4QO1WLcgcN+5wyQeEk+oaDJELtKw
X-Gm-Gg: AZuq6aIbv3IyYohTPv+YB31hwixetOwcwsRZZ1qPYoChBkc3XUB0ccIphE6zN5YN6P2
 1rfTUDPN5XKlgbMGZK5/RXiBhBFsKCCIPNqiSYA/BMfr4d8sHwOKchOomyf+cG29Z+C4na4N39B
 5T3rVTTP7+JMqelI47daO9whQR2/sYGYqXib10SzuoGp71f+GqbBkcmA4U0YnTUUT+Zi+6UXjP7
 aZbp1FjMY39RDPybvZ8bDPTpYmkInvxzMJijD9aV1NUKG47+O0XLQJu2phP3tGBqOTtG+k03crZ
 L/CJFhne/sJKzNcV1hGHUX6e3otI1YYZbmfNs94/iR6oR5BFGzcfsH170ZKVUSzzEALuEjCcRbx
 26lrM44k=
X-Received: by 2002:a05:600c:46d5:b0:47d:264e:b435 with SMTP id
 5b1f17b1804b1-48069c489c9mr112359835e9.22.1769695584027; 
 Thu, 29 Jan 2026 06:06:24 -0800 (PST)
X-Received: by 2002:a05:600c:46d5:b0:47d:264e:b435 with SMTP id
 5b1f17b1804b1-48069c489c9mr112359395e9.22.1769695583558; 
 Thu, 29 Jan 2026 06:06:23 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be77b5sm189985895e9.2.2026.01.29.06.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 06:06:23 -0800 (PST)
Message-ID: <8df67edb-9f6a-4f31-894e-3c17bf15e249@redhat.com>
Date: Thu, 29 Jan 2026 15:06:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-6-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260127161547.459443-6-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/01/2026 17.15, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Separate the CCW specific virtio routines and create generic wrappers for easier
> reuse of existing virtio functions with non-CCW devices.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index e7c3d9b2d6..2ffce743bd 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -71,6 +71,7 @@ static int is_dev_possibly_bootable(int dev_no, int sch_no)
>       bool is_virtio;
>       Schib schib;
>       int r;
> +    VDev *vdev = virtio_get_device();
>   
>       blk_schid.sch_no = sch_no;
>       r = stsch_err(blk_schid, &schib);
> @@ -91,7 +92,8 @@ static int is_dev_possibly_bootable(int dev_no, int sch_no)
>        * Note: we always have to run virtio_is_supported() here to make
>        * sure that the vdev.senseid data gets pre-initialized correctly
>        */
> -    is_virtio = virtio_is_supported(blk_schid);
> +    vdev->schid = blk_schid;
> +    is_virtio = virtio_is_supported(vdev);
>   
>       /* No specific devno given, just return whether the device is possibly bootable */
>       if (dev_no < 0) {
> @@ -255,10 +257,10 @@ static int virtio_setup(void)
>           puts("Network boot device detected");
>           return 0;
>       case VIRTIO_ID_BLOCK:
> -        ret = virtio_blk_setup_device(blk_schid);
> +        ret = virtio_blk_setup_device();
>           break;
>       case VIRTIO_ID_SCSI:
> -        ret = virtio_scsi_setup_device(blk_schid);
> +        ret = virtio_scsi_setup_device();
>           break;

In virtio_setup(), there is already a "VDev *vdev = virtio_get_device()" at 
the beginning of the function. virtio_blk_setup_device() and 
virtio_scsi_setup_device() are doing this again. So while you're at it, may 
I suggest to turn that vdev pointer into a parameter of these functions now, 
so that you now pass a vdev instead of a blk_schid to those functions? That 
way we can get rid of the additional virtio_get_device() in 
virtio_blk_setup_device() and virtio_scsi_setup_device().

Apart from that nit, the patch looks fine to me.

  Thanks,
   Thomas


...
> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
> index 9cc40e9108..e14bcf0382 100644
> --- a/pc-bios/s390-ccw/virtio-blkdev.c
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
> @@ -12,6 +12,7 @@
>   #include "s390-ccw.h"
>   #include "virtio.h"
>   #include "virtio-scsi.h"
> +#include "virtio-ccw.h"
>   
>   #define VIRTIO_BLK_F_GEOMETRY   (1 << 4)
>   #define VIRTIO_BLK_F_BLK_SIZE   (1 << 6)
> @@ -229,15 +230,19 @@ uint64_t virtio_get_blocks(void)
>       }
>   }
>   
> -int virtio_blk_setup_device(SubChannelId schid)
> +int virtio_blk_setup_device(void)
>   {
>       VDev *vdev = virtio_get_device();
>   
>       vdev->guest_features[0] = VIRTIO_BLK_F_GEOMETRY | VIRTIO_BLK_F_BLK_SIZE;
> -    vdev->schid = schid;
> -    virtio_setup_ccw(vdev);
>   
>       puts("Using virtio-blk.");
>   
> -    return 0;
> +    switch (vdev->ipl_type) {
> +    case S390_IPL_TYPE_QEMU_SCSI:
> +    case S390_IPL_TYPE_CCW:
> +        return virtio_ccw_setup(vdev);
> +    default:
> +        return 1;
> +    }
>   }
...


