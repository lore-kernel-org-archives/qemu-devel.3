Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F073C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9My-00018g-Qh; Fri, 11 Jul 2025 04:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ua9Fc-0002Y0-3n
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ua9Fa-0007Yl-My
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752223018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sNxuheiEO6jH5pbSOcCpOn8IJ42/2Y83uWmMJv77Orc=;
 b=SKB/THpPL7STEdVkxo5nzezr7/gWRvIrGdQm/bdYM/6k9TMeQWK3QVLbkvi2ubdnW3wB4R
 fp6KkE3+h6EZuw8LBifrxx8qKtPMmBqGR8Vif+3WeUURBXA5g/7jlEQb+LBWx142RFMeTL
 ivnElsFFOVamdkk4Vzehtg6HIr3ryxk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-IRhHZltaPXmseQwStg-IAg-1; Fri, 11 Jul 2025 04:36:54 -0400
X-MC-Unique: IRhHZltaPXmseQwStg-IAg-1
X-Mimecast-MFC-AGG-ID: IRhHZltaPXmseQwStg-IAg_1752223013
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f8192e2cso1150256f8f.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752223013; x=1752827813;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sNxuheiEO6jH5pbSOcCpOn8IJ42/2Y83uWmMJv77Orc=;
 b=w+9yYjmEGs6AMjhFioGo/xteYmffsspQ1LmGeLYN1TUjjJJzk1YzJyme+zfwnM1ZzO
 u556/3BYp57v3+M4KtUk0QXrDp5z2IaAzQFSxgXRG8G431Dmz2Rb/hwrWjOKrAW0/rTp
 9fOgFNrgn6BtKmj6WKbL/snVAYywNcuumg93yoEne0XG2qihYk6bLgeUQ8VD43gcOKFQ
 vwJr4rNuQT+xrzKKMSbtSPqUCMRfgdGbmbl1jKh7KTpA5jIJDdGQvWSBNIY/H1mFhRIz
 Zu68KmRyVDZtKeravJQHrvXcWlfk+dTLvGfNfcI982oPJD+cTIOCNt/iufT/8QpLrmz9
 lXMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGYTVo9EfxPogp82HKXWGq4gYUVwGbv5+p3cF5HJWdKdURHq3Au4aTpvgndAnum9J6do8po/HMIXmv@nongnu.org
X-Gm-Message-State: AOJu0YzYA2/yShjlIksd+e/f1c73Yi9KVdqTo/OgDKancbFfWpn3ODRg
 8I2EsJdVJVUSQwnn+yycITXGQmnxoyCuP9G0EaHuXjWFSHID+253vSAPVofSHha2wCVHL6t+ZVG
 J29CM5pg6EbVm5JtY6dJ0gF/4O73yXSx0om6PWQ7VkWHHb+0VcH6wyzqW
X-Gm-Gg: ASbGncubiMijtsU1dYJfVP3Z0OMwDROmUFyxphMTy6INCi9Poj+W848aX10ZYwU9WFu
 t/aJEL9nTNoAO04rKx1h5jFZKAd+waBiM522NRThuvvVUM8nJH6Q9VBBelPlcmuWCYlQyF6YHmD
 WwdwmYxMwITZnkUjRzvI0BeyzpiggU7yn4jvU+GuP3nHsapWlpPX+/uHvuD8YgCM+7ThnSEkvtJ
 8KpG19YvkC/O0SeY+pG8T/oA4joBmC3sF6zrloufH0YSbKW5N7up/LkxLZBO5kpkxD+NWBD7bbf
 O692yY2/a+TrRl20dpl1p5RXG0whLeOIOT3Dr65SmepBSZ/Uq12Zn7mj76tfq3ihCALFvkPFGT5
 oqEYD
X-Received: by 2002:a05:6000:2481:b0:3b3:9c75:a4fb with SMTP id
 ffacd0b85a97d-3b5f2dfe003mr1508146f8f.33.1752223013128; 
 Fri, 11 Jul 2025 01:36:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+FHf44schPRORa+6Gg2z1TOmhYGRCeifV2bRYv2Vb+UAxjRgtmPzj1R/lvviKAPJ3eMOFOA==
X-Received: by 2002:a05:6000:2481:b0:3b3:9c75:a4fb with SMTP id
 ffacd0b85a97d-3b5f2dfe003mr1508111f8f.33.1752223012693; 
 Fri, 11 Jul 2025 01:36:52 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-149.pools.arcor-ip.net.
 [47.64.115.149]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d77asm3936707f8f.58.2025.07.11.01.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 01:36:52 -0700 (PDT)
Message-ID: <696abbcf-7d89-428f-b7dd-9d15cc8bfa5e@redhat.com>
Date: Fri, 11 Jul 2025 10:36:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/s390x: Remove unused s390_cpu_[un]halt() user
 stubs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org
References: <20250708095746.12697-1-philmd@linaro.org>
 <20250708095746.12697-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250708095746.12697-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/07/2025 11.57, Philippe Mathieu-Daudé wrote:
> Since commit da944885469 ("target/s390x: make helper.c
> sysemu-only") target/s390x/helper.c is only built for
> system mode, so s390_cpu_halt() and s390_cpu_unhalt()
> are never called from user mode.
> 
> Fixes: da944885469 ("target/s390x: make helper.c sysemu-only")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/s390x-internal.h | 10 ----------
>   1 file changed, 10 deletions(-)

There is another call to s390_cpu_unhalt() in target/s390x/tcg/excp_helper.c 
but it is protected by an #ifdef ... so this should be fine.

Reviewed-by: Thomas Huth <thuth@redhat.com>


