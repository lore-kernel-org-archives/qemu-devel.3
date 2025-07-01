Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529F8C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 15:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWd7i-0005Sh-22; Tue, 01 Jul 2025 11:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWd7g-0005SJ-FE
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWd7a-0008U8-CB
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751384528;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=knpxdZnqXLQC9XtqfBwzd0/gTVLSukHtyaVrMMe7/AE=;
 b=eKiaorNwMzfpUKP+h9RHEkwF/1IZPZ0qVF0gTsSHSsceHEyRKHwK0UfNGVlxXNzBWmcxwu
 dc4MpT08aJvRis9nzSvrsHSEVhzV/yjvY3hgRPWX+xDzDo/42GYBtN9QmJD3y6YF3RlHkA
 jb8UmKWWyqE6w9jikrypLJPRg3JMVI8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-dKNoi9CkPPC9RGzm6VlYUw-1; Tue, 01 Jul 2025 11:42:07 -0400
X-MC-Unique: dKNoi9CkPPC9RGzm6VlYUw-1
X-Mimecast-MFC-AGG-ID: dKNoi9CkPPC9RGzm6VlYUw_1751384526
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451ac1b43c4so28990025e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 08:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751384525; x=1751989325;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=knpxdZnqXLQC9XtqfBwzd0/gTVLSukHtyaVrMMe7/AE=;
 b=Y6SFUEqQ/mQZrYgJaCJoDLVMJqysQgI1A5BpAgNm8UWsVw8YSxANkA/7P7zLrTYkHS
 YYKsjl6Rig+Y57I2Ra4bz77M+sTtFHUwa+w++udzA+3etrLKuYlV6wC63Bqcr+aOlSTH
 7oBTf+uPrCEhip+6ry834az7Y7yOjgWDSIaDW59h1PsexOkThxORwNoeS3n2HaB9/ZT+
 hjNudkLRuzdo0St9kW45eGI+zg1DwugKW6k1nPM4eWQMud+ENo7fMSfBP5GXgYEkw+EE
 K3XHUY7bl2ZP0mkmA17HfNGu7mOcxYPLohYrnUCCJ37rCBHGNaKBuL94Xcl7RarAsHDZ
 3vKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHqqUGJV4NSG6L8kwVi8XSeCCBPJnm8zg3reMZP5R7MboquddDtTGlOtckW/bpVyrPGonAEQUYFs41@nongnu.org
X-Gm-Message-State: AOJu0Yy8o46yeqUHYnw20Y6Rd9ZR3FRJx/cRWgjk+ZSMy4ITDUMqnP7B
 ld2boac/iBv988QdtZ36Raq/mz8CyWik9WArTUGzrBrq9oCIkiqAQ2xxbmVuEQ4ypt1ySJA8iyh
 kGnz2C9RBqR450WR6GBEIRn5sSj2wTIoKszi9lK3YgFkuLkN8cOLu+oAq
X-Gm-Gg: ASbGncuJ7ROdke8Amasl8yTjSb9UxzgpkYR/b2sP3KuNLHKBXN26BBV+NoUNlBXKAKR
 abVT/cBWLFJLeOj0hLAB3SKXhCILh2cWppDOeMQ4dHl/z7fW98JbyqvYb143nyeAKS+qjq78uVa
 ejJNWMpu3JnnRZC8/jupKCWJtMB8Y3+cg9jOtQzuL4h6QOsCOd1A1Abc+6qBoO4+1xWA6XmIAIB
 KFZvKkaOgjsJFALIgqgNI5pibIuvooE3n6ZiojiwSFxO2gwjEQR3CRQEsr8dpXZ1prdKbgo3j/9
 FmITGyN231Vg3reD1VsOpqH40u5UVtbHjU4XEsQNO2fHcSU+5eWqjzLy9Phaiuy6uGFpFA==
X-Received: by 2002:a05:600c:828f:b0:450:d00d:588b with SMTP id
 5b1f17b1804b1-45392bc88damr174331135e9.9.1751384525595; 
 Tue, 01 Jul 2025 08:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJve1TAHCBKdYAwJ4yJVAsUhL5lVig43gaMFe/oIWm5C97bZeWTADeUSVHhlbUroDFDgSg3Q==
X-Received: by 2002:a05:600c:828f:b0:450:d00d:588b with SMTP id
 5b1f17b1804b1-45392bc88damr174330815e9.9.1751384525163; 
 Tue, 01 Jul 2025 08:42:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a5599sm173282975e9.13.2025.07.01.08.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 08:42:04 -0700 (PDT)
Message-ID: <29373347-2b7d-4cb8-9b0f-7b53d5633890@redhat.com>
Date: Tue, 1 Jul 2025 17:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v16 4/5] docs/cxl: Add an arm/virt example.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
 mst@redhat.com, Zhijian Li <lizhijian@fujitsu.com>,
 Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
 <20250625161926.549812-5-Jonathan.Cameron@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250625161926.549812-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jonathan,

On 6/25/25 6:19 PM, Jonathan Cameron via wrote:
> Only add one very simple example as all the i386/pc examples will work
> for arm/virt with a change to appropriate executable and appropriate
> standard launch line for arm/virt. Note that max cpu is used to
> ensure we have plenty of physical address space.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  docs/system/devices/cxl.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index e307caf3f8..73e80e672f 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -384,6 +384,16 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
>    -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>  
> +A simple arm/virt example::
> +
> +  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8g,slots=4 -cpu max -smp 4 \
> +  ...
> +  -object memory-backend-ram,id=vmem0,share=on,size=256M \
> +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> +  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> +  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
Matches the x86 identifical example entitled "A very simple setup with
just one directly attached CXL Type 3 Volatile Memory device"
nit: in case you need to respin you can add something like "featuring a
CXL Type 3 Volatile Memory device"

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> +
>  Deprecations
>  ------------
>  


