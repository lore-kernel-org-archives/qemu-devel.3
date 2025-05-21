Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE199C54ED0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 12:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHiRe-0005lF-Om; Wed, 21 May 2025 08:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHiRY-0005fq-9d
 for qemu-devel@nongnu.org; Wed, 21 May 2025 08:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHiRR-0008QQ-Gy
 for qemu-devel@nongnu.org; Wed, 21 May 2025 08:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747830057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PUMoQ4WVnpojTP+0R/wg5NTHLEtqJptoj5thA/XalsU=;
 b=QS267ccIB/E+S24s14dkH3uEE6flxtlqDYhZoflNgYcqKW2DS6qSKbhhf85UTIJYLTBSUX
 7FuPcuzJIW+3KIYmd3gE+GNLsQSY8hRC88N4GP86lBmnEDMqcf/wm56fcCt6S7X7gmqMZL
 1exS4rZ6mzzHZOpP1BqNouyW2WddM1g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-Y6nDWSxUNWWB3c52kh1Ovg-1; Wed, 21 May 2025 08:20:55 -0400
X-MC-Unique: Y6nDWSxUNWWB3c52kh1Ovg-1
X-Mimecast-MFC-AGG-ID: Y6nDWSxUNWWB3c52kh1Ovg_1747830055
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a35989e5b2so4159788f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 05:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747830054; x=1748434854;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PUMoQ4WVnpojTP+0R/wg5NTHLEtqJptoj5thA/XalsU=;
 b=u422jxL+8RLDZYoxTWrWe7E3/0GO2B+Fy/6D3yzL7P33ap3jFVvgltHNyLqfG7ekN0
 n74kZnibXvw+xJ7VbA68rldSx/Xr0+OVYRxol/g0seixrojIEjS9h2IcT64pclcyMLZd
 Dy6Bs68oD4ahO4QvGAWOoQNXdQ/kApHg+7xidjLsuSLHl9adVpf1M20g1z1WKf/bwicf
 flBdD3RWos8KkG3CXFcqEgtF8oU3CAFnz9WOiuaTg6F6Xpu9uGT/7dy2X8ALUNdYtlAl
 d7ksTfxyfIS7EsnUxYdTmS42rud/9B9M/OSVNgY67bRhHJfHLCxU51Crm9Fnjfk6OAke
 4UMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9BnRcPWIh1qgulpkX1fyhiIvpgsHrAykOCyFdrebN7kctj2b7FEE4H8fYudJQSMCcnkQblfvgsV9Y@nongnu.org
X-Gm-Message-State: AOJu0Yzm43HT+jDG0+RxyIBTuxXaDwU6+qRAchr46sdRjSJgnseYQXO6
 sXfffwesdYUZFk3yjyrqFhPEB5/m3JBFaIZVNoFVgy0eOYZy9YqdZxIspBAsFvFWRzEIfesVYhR
 rbCoDtVGAbG9ELB/EktjddfstYKF9gP77GDQXbyYzJ5gYFQkHCH1iRYhX
X-Gm-Gg: ASbGncuv+84dIl8maNvRa3K0pwVBHdGytL2zhiomtnFwR1gPXWCzQ1bzcFlZ45BNlgn
 pjS0SLTH/bBz9qDw0UEycGgJscp2k7Q8ty2TSIbvDHDIj3lylxajyRGVW2DiQOAIuUXXtjFROKc
 vYh5TfMnt++cBp6EcCdZ1yWWMfhjdvKiuJe2c8EPaEVih5KHAPAWIv+5rDc58nTdaqF+PUkNWcO
 VmKBG6PG7ZEtLcPm7mw5sQKOHdOPItRZCfYysaC/OALUcDtmyPl5Twx821qYVvSTOMHplevb6rG
 txxmtWD5jmc9YrKSFOGkE2MvRJF3BjIvY6Erb13kWWQ=
X-Received: by 2002:a05:6000:a8f:b0:3a0:b4a7:6e56 with SMTP id
 ffacd0b85a97d-3a35c84bc90mr14397613f8f.56.1747830054619; 
 Wed, 21 May 2025 05:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnHKfyN1/OKC1wJti+Rl+TDY36LEPwo8OCbsIPm+JhaPQ2vZ0nkSlMhipkj8ox0WQh24S/Vw==
X-Received: by 2002:a05:6000:a8f:b0:3a0:b4a7:6e56 with SMTP id
 ffacd0b85a97d-3a35c84bc90mr14397581f8f.56.1747830054176; 
 Wed, 21 May 2025 05:20:54 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5a87fsm19171137f8f.29.2025.05.21.05.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 05:20:53 -0700 (PDT)
Message-ID: <d10a6412-b9f1-4f31-85cb-964e0523c358@redhat.com>
Date: Wed, 21 May 2025 14:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/25] hw/s390x/ipl: Set IPIB flags for secure IPL
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-22-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250508225042.313672-22-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 09/05/2025 00.50, Zhuoying Cai wrote:
> If `-secure-boot on` is specified on the command line option, indicating
> true secure IPL enabled, set Secure-IPL bit and IPL-Information-Report
> bit on in IPIB Flags field, and trigger true secure IPL in the S390 BIOS.
> 
> Any error that occurs during true secure IPL will cause the IPL to
> terminate.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/s390x/ipl.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index d1a972ac8d..4c827be121 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -437,6 +437,11 @@ static bool s390_has_certificate(void)
>       return ipl->cert_store.count > 0;
>   }
>   
> +static bool s390_secure_boot_enabled(void)
> +{
> +    return S390_CCW_MACHINE(qdev_get_machine())->secure_boot;
> +}
> +
>   static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>   {
>       CcwDevice *ccw_dev = NULL;
> @@ -494,6 +499,17 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>           s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
>           iplb->flags |= DIAG308_FLAGS_LP_VALID;
>   
> +        /*
> +         * If -secure-boot on, then toggle the secure IPL flags to trigger
> +         * secure boot in the s390 BIOS.

"If secure-boot is enabled" ?

  Thomas


> +         * Boot process will terminate if any error occurs during secure boot.
> +         *
> +         * If SIPL is on, IPLIR must also be on.
> +         */
> +        if (s390_secure_boot_enabled()) {
> +            iplb->hdr_flags |= (DIAG308_IPIB_FLAGS_SIPL | DIAG308_IPIB_FLAGS_IPLIR);
> +        }
>           /*
>            * Secure boot in audit mode will perform
>            * if certificate(s) exist in the key store.
> @@ -503,7 +519,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>            *
>            * Results of secure boot will be stored in IIRB.
>            */
> -        if (s390_has_certificate()) {
> +        else if (s390_has_certificate()) {
>               iplb->hdr_flags |= DIAG308_IPIB_FLAGS_IPLIR;
>           }
>   


