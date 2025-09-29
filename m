Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78FDCAC5BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3EVs-00086G-8U; Mon, 29 Sep 2025 10:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3EVp-000859-36
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3EVd-0000c0-DG
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759154740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5dCEZpNGR+H76wMUwGKnZsHjseRbjO9wi4U4HClvEaQ=;
 b=eylOComodpozrie8im+MpFokabqrUdrbBrssD2EdGpfNh9OcnSkDX0Ss0Xz6xhE8Ncv9cZ
 61HL3TozXIO26OjhR79cLmlHmABFuOGBVH7njvuGrcKq18mvh+BIWKia1Qm2x/IwKrmszK
 EbdLQCHF02eLauQsuP1UamMVe6eC7qQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-yUSAC6I6MiiOwgA7fIh7eA-1; Mon, 29 Sep 2025 10:05:36 -0400
X-MC-Unique: yUSAC6I6MiiOwgA7fIh7eA-1
X-Mimecast-MFC-AGG-ID: yUSAC6I6MiiOwgA7fIh7eA_1759154735
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e4335fa87so15271595e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759154735; x=1759759535;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5dCEZpNGR+H76wMUwGKnZsHjseRbjO9wi4U4HClvEaQ=;
 b=Yh/NaB0scjPbMFzXMIoUWCzh4wmfQeqP2q3o56pVX95X3KwPBhp+mJm0IMwk3/NA6K
 /I2fhhW4sf7lWkEtN64Tnl8iGvBOkcLYrlQTN6H+DT6s2JHuYkQb4APLyBtOxTEl1xmM
 mNVN5iJhLH2d2OqoIyQAqbeRMGWI+BI4MDKe6VNdelkheMYjkzfkIaBFpQ+aHkcMpB8N
 qRv9CGl/yUimZp+PI+JWT8aa0UOVHoiZrgd4fAqzbmjXGOtkMvQJSILg8XR3oGyKWGpu
 6LPc++K2StbnTpLUYR1IXwX/1xOvEJWuVl/j65SsM6+SlqcL5EGOXIeDyXdXmGhSu2ZX
 Cr3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbHJoAzsCGsku43WD6cD6fSQYQxLlsqCG8mkrLTE7EDsKq0llltuOamzmcOl+gRWnXuZAxjNaDTWOs@nongnu.org
X-Gm-Message-State: AOJu0YwO5jvzxX1Bm4DtsoI+PhXniB/DwRhx/OU5hjA5OScb8ew09QQn
 4arnlvpIM0KSTWX+L0MtOi4GQdg3DzqaeOP5k1ne39L7a2o1abGCL0WAIopYFR8XK06eJOTYPOh
 tP66vNmQV60TwEk/Iz3s8dfFQ1vNx+ybsT22BOc/2T0qaFb3HeoxmGNnj
X-Gm-Gg: ASbGnctY5jFrQ5wNtsGNv1fMNNk7B0aD2KaY9HBfNUqbC7Pc2N71BvmcL2KEDZs+k9I
 LCzZxWuYBzoeU3pnS9P2YPkjU/HXD+oheE2UcK5Jb8tkw4i1lyLBuMr4ZBfGBQg630qZ/WIWlht
 XjSlsebc7uDhN7SV5+z6L9g5RRkDg15+VogOdWBg7tfYc7VPcX86dRkvfb/187yYSNsLEGjz2KM
 mwMhWjEkEM0/V2d1nTF1LwOedhuHdU+U8TZPQ/ReGEkwQcKATCkuw5jZ58eEKkHWXUP8hqvx/t1
 GJZLQxSL9Wy8Vl3SBo9NNhEtaf03d+g9AVEGJ6disB+lSBGnEAjGEvOBswUD5W8iS+k6QKUAnnG
 k8uJvBg==
X-Received: by 2002:a05:600c:818c:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-46e3d416194mr102014825e9.34.1759154734958; 
 Mon, 29 Sep 2025 07:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUqc6scxhJbBr4AeeGTY9EoH1Xzks5jOlyToVh0p3ZQARq+Z5jQiRkLa4Wir0XzlWb2ZinrA==
X-Received: by 2002:a05:600c:818c:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-46e3d416194mr102014455e9.34.1759154734537; 
 Mon, 29 Sep 2025 07:05:34 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc88b0779sm18248409f8f.58.2025.09.29.07.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 07:05:33 -0700 (PDT)
Message-ID: <feac12c4-3e60-4f30-bdff-1f2decf3b27d@redhat.com>
Date: Mon, 29 Sep 2025 16:05:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 22/28] Add secure-boot to s390-ccw-virtio machine type
 option
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-23-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-23-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> Add secure-boot as a parameter of s390-ccw-virtio machine type option.
> 
> The `secure-boot=on|off` parameter is implemented to enable secure IPL.
> 
> By default, secure-boot is set to false if not specified in
> the command line.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
...
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index 334b67ef05..1dba5ab37e 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -33,6 +33,7 @@ struct S390CcwMachineState {
>       uint64_t memory_limit;
>       uint64_t max_pagesize;
>       BootCertificateList *boot_certs;
> +    bool secure_boot;

Could you please move it next to the other "bool" variables in this struct?
(to avoid additional padding)

  Thanks,
   Thomas


