Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC78CF6C0F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdPI5-0006B1-9i; Wed, 07 Jan 2026 03:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdPI3-0006Ag-Ui
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:53:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdPI1-0000kQ-SL
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767775992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KgczxPr1ni5oqncF61pxzsANw8KUsEzH4gNOxYp1LKI=;
 b=GDCMdpqAU/BOE88BcLWMqYbU2tIIv4KUIZKtN9Hu6eVhU8Gt4S6sy1RjAHfPvRU6z850mN
 zYoPwJq1oIb/5xB7jJYbZ1PBk7aVvnoj6XE9JamB8Ta0tev7RoH9BHZcrCSVU2mvVj4jqI
 AYZBHCrljb7KwTSeeXK7vvUJEDebljY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-YFnZTOvUMQWZ-4RmnRgqKw-1; Wed, 07 Jan 2026 03:53:11 -0500
X-MC-Unique: YFnZTOvUMQWZ-4RmnRgqKw-1
X-Mimecast-MFC-AGG-ID: YFnZTOvUMQWZ-4RmnRgqKw_1767775990
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso18673075e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 00:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767775990; x=1768380790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KgczxPr1ni5oqncF61pxzsANw8KUsEzH4gNOxYp1LKI=;
 b=t+OaFBMu4as5qJ1Pakq3yquj7R0f0tvjW8dicWcNvkrFSAcCbOzVB29vLxtENy7TSa
 7SirnXoSUWaOuQWJBhPzLgkqsQNfsqQFdGmgamg5n6e6Wv1rGIPunBbjBLif0/u5K8CD
 U97mZt/WGEjsIFKQUxeW0t7P4aA1KmS+mgPHQ/L41glDOF3+vCSvV2SLZQH19VKpLynH
 Bs82VBW2Rfpf8U1tOmOkophSI6TBnNxap2JMGij1Jy2R7q3CKtRG7iAfvEVkAdev6QJk
 5wkIZOoeCu/ta7IUxQbX2mRHoNru40uy2MLd6teih3GxUd5HGI6WuUr5H4UB5XVhuzxb
 BcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767775990; x=1768380790;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KgczxPr1ni5oqncF61pxzsANw8KUsEzH4gNOxYp1LKI=;
 b=vAXYgLkGZYS46Oh52yuBSG4s1pLan/nnRvktY+AyszuRDn2yh9tERoRPC04+sG0njl
 I5//KqVJFnWelRjpYH++ie+2D9xnGSJaonQbaAvjGFwFTffKGSpzzQwz4dhq166a+/2s
 WmZUU0oKmZWXRhQ9S7u5OFHQH+OeRPLXw68OxFIWSkxYtMMLOyE3sSNU+1e2ouW0fduN
 uRjxkjE2d1M0FzJltkJGpjOa4sbGxEkz1KS4mN8FTwLpWGE4S9TiSSI3FAYcJZ7V7opA
 Khr1zrwnySVhXZzCgM4Ib4sTsw5+XeGEQ33R85pnbRR2/8ngSsu/Ra8j7ZzZ97MlML9E
 IvDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEfUq7OfZL/BP7hBYmIMXHkjoF2EM8tiMR538fLuLBOZz2vIiNaHv37/1kkYPx4O+nYln3gGdsJqTC@nongnu.org
X-Gm-Message-State: AOJu0YyROnAoBZLqrl5QufRooC41bZcJF+SE7Ff/jXiAg8j+NBdOR7JL
 vdhPL/0dZlAlhDfAZsuBbLjBTvk1NG3+kCaOYAzLc0uHvpjx1x+dZaAPiajZA4W4vN6KAACLzao
 28j/CFeyKy/qRKZEkMDk2VkI8ocAliYwZX72Nxg5dUveoEPCAwDZURJp2
X-Gm-Gg: AY/fxX4Xno+VcOQ6wrlswpAF7yscl464QZ85M443w5Rjz9+H4MMIiradVvvIGn2gMea
 0Or4Yl2uKKLCR55Deb8Bpw8YYqDQM3wBpCXNMV/WGvOWa8ef8xDpA8V4ed6biaBb+AfnG9NyQCU
 LDS85rCrGIYl+P85VsWYsxysIL8JqIxahPewoRlTn7iayS5Ga1Eq/XWaRYDZlzcKZraslHwNZwF
 Izezipz8swxJG2B62y3iYDFjEhgDCiKFbP1qXnAu+0K1WMkqD5jmyzC07Ff8x62c40JY02UyrGF
 DUANg4Uqt0QhNS1LvVueBBHs84jODxzlnIN6wScY/yo28EMo7n+we7T+0BauVD1uQMKpsUjV5pq
 FQZfBkWjXxuANRG6W1jOHUaKvCODyKnFFwT4=
X-Received: by 2002:a05:600c:19d3:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-47d84b0a9bdmr18179595e9.6.1767775989627; 
 Wed, 07 Jan 2026 00:53:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7+QiMJZNXPADFdIfTQ7I89U0arn5PsYsy45k58ZGUIs8jfvrY9GW5XDlUMldjH73RfDuhnw==
X-Received: by 2002:a05:600c:19d3:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-47d84b0a9bdmr18179235e9.6.1767775989174; 
 Wed, 07 Jan 2026 00:53:09 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8636e588sm8992365e9.0.2026.01.07.00.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 00:53:08 -0800 (PST)
Message-ID: <26e6a35e-d42a-49c9-b36d-3dcfc315cb01@redhat.com>
Date: Wed, 7 Jan 2026 09:53:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] pc-bios/s390-ccw: Store boot device type and bus
 separately
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-3-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251210205449.2783111-3-jrossi@linux.ibm.com>
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

On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Store both the device type (e.g. block) and device bus (e.g. CCW) to determine
> IPL format rather than assume all devices can be identified by CCW specific
> sense data.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
...
 > diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
 > index 6824391111..8199b839f0 100644
 > --- a/include/hw/s390x/ipl/qipl.h
 > +++ b/include/hw/s390x/ipl/qipl.h
 > @@ -20,6 +20,13 @@
 >   #define LOADPARM_LEN    8
 >   #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
 >
 > +#define S390_IPL_TYPE_FCP 0x00
 > +#define S390_IPL_TYPE_CCW 0x02
 > +#define S390_IPL_TYPE_PV 0x05
 > +#define S390_IPL_TYPE_QEMU_SCSI 0xff
 > +
 > +#define QEMU_DEFAULT_IPL S390_IPL_TYPE_CCW

Would it make sense to turn this into an enum as well?

 >   /*
 >    * The QEMU IPL Parameters will be stored at absolute address
 >    * 204 (0xcc) which means it is 32-bit word aligned but not
...
> diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
> index 4b819dd80f..f40a9407c2 100644
> --- a/pc-bios/s390-ccw/virtio-blkdev.c
> +++ b/pc-bios/s390-ccw/virtio-blkdev.c
...
> @@ -129,6 +129,8 @@ void virtio_assume_iso9660(void)
>       case VIRTIO_ID_SCSI:
>           vdev->scsi_block_size = VIRTIO_ISO_BLOCK_SIZE;
>           break;
> +    default:
> +        return;
>       }
>   }
>   
> @@ -139,13 +141,15 @@ void virtio_assume_eckd(void)
>       vdev->guessed_disk_nature = VIRTIO_GDN_DASD;
>       vdev->blk_factor = 1;
>       vdev->config.blk.physical_block_exp = 0;
> -    switch (vdev->senseid.cu_model) {
> +    switch (vdev->dev_type) {
>       case VIRTIO_ID_BLOCK:
>           vdev->config.blk.blk_size = VIRTIO_DASD_DEFAULT_BLOCK_SIZE;
>           break;
>       case VIRTIO_ID_SCSI:
>           vdev->config.blk.blk_size = vdev->scsi_block_size;
>           break;
> +    default:
> +        return;

This looks like errors could silently be ignored here. Maybe rather panic() 
here instead of returning? Or use "break" to maintain the old behavior?

>       }
>       vdev->config.blk.geometry.heads = 15;
>       vdev->config.blk.geometry.sectors =

  Thomas


