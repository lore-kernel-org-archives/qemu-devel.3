Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493C6C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 08:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfavI-00080t-1C; Wed, 05 Feb 2025 03:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfavG-0007ze-UP
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 03:38:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfavF-0006ZS-FK
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 03:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738744692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=adcxD9HCUKEUWEsurZ+eUCyGw0MPtmmAahw9oEKcB9g=;
 b=Vau12++O22OSJ0QLoTdOl7IAHsqy2dokFK8Wfq8z6xKHCG0c1QqN7n+AKLAiKDfyo3x1UT
 ptde1dsNPIloBjXFGzlmDWFREAddBNJrFqRUtt7cdxQOhUF5eNhyXm2f7G3h0Gzh/izBTB
 YB8NFvXCWQbf1RPjaJMAiSvM/ciqZVE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-9RaACcpLOjmg-r3jvZyJGQ-1; Wed, 05 Feb 2025 03:38:07 -0500
X-MC-Unique: 9RaACcpLOjmg-r3jvZyJGQ-1
X-Mimecast-MFC-AGG-ID: 9RaACcpLOjmg-r3jvZyJGQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso6934075e9.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 00:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738744686; x=1739349486;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adcxD9HCUKEUWEsurZ+eUCyGw0MPtmmAahw9oEKcB9g=;
 b=Lcp1XZHxfwhSA2knPv6x/+44bQp63Vwhnnq5d/n2zBwtKbPd+MmkAeSxsZ3YdiEuUc
 M+RcEboI460DPpUi5+NyKS477T8ZUZU2ObuU719YbN9Bw7WdDaDiSfauMdJYkozS1JuH
 AxcGVqNsxZK23qin1d+50x3qPHBb9fYbA73YI3odMPRbRQtj3F1efKhCuSkKr3RfHbJf
 kzIEDMcFz2guN4Vw3l6EBOpWJ7S+x3fvZr9ZKZkQCTU4qNhn4sGAXMDQLlq3u47f5/FV
 OTQ8koZuMVShLvWqsV3EClkjznN+wRdK5xqYRLiAaBQK5/uT3hfgO00TvHYB3M2FqNUO
 pRVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn4EuefQqaeF6ORGikTC5Jfplie8YTILQQDTeTlblnL63sOwmUz/zkyfefnn1RBa2u8qOWfKxJviLp@nongnu.org
X-Gm-Message-State: AOJu0YwqrQFJVFVxrEpcgS9Vq+R37ZDaAdjdnUGRRoHy3/49K6/OTbKI
 Xc+5vqVBqcWoDDfE8jsAO//s22rzrsW9PDtCu4wEuKWh4tfDO2X3kPH5M46yqL7O5IpODEBcrXP
 NpitS9Opwud8VSFXOzP6BtZlkqdtVmIj3UnT1LuAzzyf2A0STjggH
X-Gm-Gg: ASbGncujapl1sI1ImkwZfzRPB3ssewAWaIPg90bb/R9O7e4AMkHw8EN4gYVt8IMz3SR
 GwvhFIIDfPzd3+Llr/uvMlsDq9fmDi9X3NtgkXvV8yCYxMvjDRrf6JDas12OZG6C3E2n5q+nZ+s
 y+4zcUh0+PVe+XElzsW9lnEe0+F2Ggbh14nMdbTKRBzlMXEnxOcvhqKkcbgxUx4KUPZhirRN9va
 8ReH7KhuSszz3CB3jxSwqOUcUa/a/IKlCFRS3U4WDUFhGRT2Ob7sDBIR8773Ls7lUeQsIzVGAQ6
 py7NhmZA+Mpxo06Hm8jt8xCXI0Vkwb416sBt7hbGxl0=
X-Received: by 2002:a05:600c:c87:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-4390d433affmr13596595e9.7.1738744686037; 
 Wed, 05 Feb 2025 00:38:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs/sbsC+b+0hqutucPvCZ+Uk0TBp7VWikqm/httQLYF7I+fo7LHvfBCk/coqqjsAzNbLt6Bw==
X-Received: by 2002:a05:600c:c87:b0:434:fa55:eb56 with SMTP id
 5b1f17b1804b1-4390d433affmr13596295e9.7.1738744685654; 
 Wed, 05 Feb 2025 00:38:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d898fd1sm14389485e9.0.2025.02.05.00.38.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 00:38:05 -0800 (PST)
Message-ID: <52dddefa-a9d6-41e7-ad23-a93f65896034@redhat.com>
Date: Wed, 5 Feb 2025 09:38:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/5] linux-headers: NOTFORMERGE - placeholder uapi
 updates for AP config change
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250204170759.36540-1-rreyes@linux.ibm.com>
 <20250204170759.36540-2-rreyes@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250204170759.36540-2-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Rorie,

On 2/4/25 18:07, Rorie Reyes wrote:
> This patch adds enumeration constant VFIO_AP_CFG_CHG_IRQ_INDEX to specify
> an IRQ index for signaling that a change has been made to the guest's AP
> configuration. This is a placeholder for QEMU patches that use this value
> since it is a linux-headers update which includes changes that aren't
> merged into the kernel. Linux-headers patches should be generated using
> scripts/update-linux-headers.sh.
> 
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> ---
>   linux-headers/linux/vfio.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index 1b5e254d6a..d0426b5ec0 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -671,6 +671,7 @@ enum {
>    */
>   enum {
>   	VFIO_AP_REQ_IRQ_INDEX,
> +	VFIO_AP_CFG_CHG_IRQ_INDEX,
>   	VFIO_AP_NUM_IRQS
>   };
>   

Are the kernel changes planned for 6.14 ?

FYI, QEMU 10.0 hard freeze is scheduled for 2025-03-18 which is
approximately when 6.14-rc7 will be released.

Thanks,

C.


