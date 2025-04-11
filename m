Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D80C369AE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 14:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3FeH-0006pL-VJ; Fri, 11 Apr 2025 10:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3FeD-0006p5-T5
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 10:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3FeC-0003F4-7j
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 10:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744382782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WbXUl+spj8AmkjxWio3TRnztugvoBN2IWr1hHJyt/9g=;
 b=HFgR51rOkXGVTbAZpqA+c4lDaeFuE+MLS8xqcsA79/cmOeTAK8sek4+DxnsGxbC4UEX+Ri
 rtwiU9TStKOY/+Lg/dN6U+E9l1rMs/zBWHOGVPl5WMyyVhs4cLify5W6DBnGOCPYuGys8U
 gK89Zy+CWJYHXsxBjscPtzgtftp5VT8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-2Dc8c7qIMCKccGU_fNdjGQ-1; Fri, 11 Apr 2025 10:46:21 -0400
X-MC-Unique: 2Dc8c7qIMCKccGU_fNdjGQ-1
X-Mimecast-MFC-AGG-ID: 2Dc8c7qIMCKccGU_fNdjGQ_1744382780
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3913f546dfdso1164948f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 07:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744382780; x=1744987580;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WbXUl+spj8AmkjxWio3TRnztugvoBN2IWr1hHJyt/9g=;
 b=R2yStYDJG10TORC/s2WZdvKAKFaiF1P8Pxr7/9PXm5mzvtTI29Xd/rth5ERn7K4La/
 /O1ceVQNS6IuJWgO5KVoGdH/wOgpEc7L59RmGxlFA5z0ZpgluJ8Er1h091flHwkWnlbK
 4CVTOyuTCDmu5C/9D2e77k8DtuDSvhHeCMoj3vznE+YklYcsj9RzeT/yLUKtKc8bnboW
 IpEwKGbW5HAPVh7U0cgIAm1TOce1FCp4/gTzWBIIo9e6+9MBskkkWTFwTamKl92hKzNQ
 sv2Yv+RgMuPHZsTElHn4+DnkNdSxs+ktd+CZmf5X313WNAnV7DX0V2+Yo5c5sXJuLmdL
 RFxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlimJxuNCp+NZPQSc4XoPuvJRIRafLORb2plkWC/EjJ7SZZLtwK0tV4321LXUmrEZX86fU94VNcAGP@nongnu.org
X-Gm-Message-State: AOJu0YwuiQIeSBXvK8QXGxbTHWbqwSWxibBH4YzdVNGvfC7HcQYNX4bT
 H+z+BSne3HVqyJo8dX8mjvWawUEowG5m1gTcNqLwKXwW3peCctn//M2+IWcoMUgu+HkDZRC+RNo
 iSOmg7q/kRz7/VMkyL5107hvLMI8L9WIW0wAIartdJ5uQ5VERF+36
X-Gm-Gg: ASbGncvsEvgyV1Y7oLz6Mehkum1bxRjt4+tOAoU0cdHerT9BS+2EDx973s0MGDhE/ju
 mANB7EeNErfO12tqLX17E36J+WE7LbDx81qSxy6eAVFtJXrk9jmVpQkV/gf954geT2OHtfN8Lbx
 dkaVIFFHcAoXt1caM4kZiFJeaUavmlvuGDc4nclTaButBY0fmt9E8kVdtjMs1//pDNRMXzHl6br
 8Bt6qeNgOpuJNxH4QMEKufSUw0B7fA7yXXNwCSMajI81yRRZJojgauBZMNQuKJS4l+czgLsSI+0
 hqf7cqp6osLNvj+jN9jC6QP80gzR18yxIVI6bTIC9B0=
X-Received: by 2002:a05:6000:402b:b0:391:31c8:ba59 with SMTP id
 ffacd0b85a97d-39ea51d1033mr2408740f8f.4.1744382780064; 
 Fri, 11 Apr 2025 07:46:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6G7BL7gYLjkXqPMMYmObBVZEPnuDCN7cTb8zzn4FUhDURXUnD3xO91F9HvL8TZYn9QjMqNw==
X-Received: by 2002:a05:6000:402b:b0:391:31c8:ba59 with SMTP id
 ffacd0b85a97d-39ea51d1033mr2408703f8f.4.1744382779663; 
 Fri, 11 Apr 2025 07:46:19 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae977513sm2178599f8f.42.2025.04.11.07.46.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 07:46:19 -0700 (PDT)
Message-ID: <3033a0df-44d5-458d-b738-cb93456e9f75@redhat.com>
Date: Fri, 11 Apr 2025 16:46:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/24] hw/s390x/ipl: Set iplb->len to maximum length of
 IPL Parameter Block
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-14-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250408155527.123341-14-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/04/2025 17.55, Zhuoying Cai wrote:
> The IPL Information Report Block (IIRB) immediately follows the IPL
> Parameter Block (IPLB).
> 
> The IPLB struct is allocated 4KB in memory, and iplb->len indicates
> the amount of memory currently used by the IPLB.
> 
> To ensure proper alignment of the IIRB and prevent overlap, set
> iplb->len to the maximum length of the IPLB, allowing alignment
> constraints to be determined based on its size.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/s390x/ipl.c | 6 +++---
>   hw/s390x/ipl.h | 1 +
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 59ec81181d..b646fcc74e 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -460,7 +460,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>               if (scsi_lp && strlen(scsi_lp) > 0) {
>                   lp = scsi_lp;
>               }
> -            iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
>               iplb->blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
>               iplb->pbt = S390_IPL_TYPE_QEMU_SCSI;
> @@ -471,14 +471,14 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>               iplb->scsi.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           case CCW_DEVTYPE_VFIO:
> -            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
>               iplb->pbt = S390_IPL_TYPE_CCW;
>               iplb->ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
>               iplb->ccw.ssid = ccw_dev->sch->ssid & 3;
>               break;
>           case CCW_DEVTYPE_VIRTIO_NET:
>           case CCW_DEVTYPE_VIRTIO:
> -            iplb->len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> +            iplb->len = cpu_to_be32(S390_IPLB_MAX_LEN);
>               iplb->blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN);
>               iplb->pbt = S390_IPL_TYPE_CCW;

Wouldn't it make sense to only do this iff the secure IPL is also used?

  Thomas


