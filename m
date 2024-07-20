Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FC6C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 18:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVEpu-0004so-JR; Sat, 20 Jul 2024 14:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVEps-0004ks-6N
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVEpq-0001a2-Sw
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721500173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uOEW9Az1KfkeE271bQ6+gYXD4KUA6/7n9hI0JqF6iJI=;
 b=BAJJBdPDFcS1aI7JMGJhL/YMmeaXy1o0ST66yaxz8LivP37CISeUR9UEqITDiHfOB5vzWB
 l2eAP3/8kvMi2VJOz4pIiQhwb9IUrrApkmfAKq8Y4aUKn1hio28bh1saumhCecGvQnN4kn
 ITtMlhVtauEAiC70W0q//FIs8SjJeSk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-i7vsy5R5MTWsxlt7C-kksg-1; Sat, 20 Jul 2024 14:29:32 -0400
X-MC-Unique: i7vsy5R5MTWsxlt7C-kksg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3685a5a765fso1505088f8f.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 11:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721500171; x=1722104971;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOEW9Az1KfkeE271bQ6+gYXD4KUA6/7n9hI0JqF6iJI=;
 b=WDyjr1zQ5gaPX2sxRPHBmazPQrFqsQZhGoQWS+rMQbTR1ayeyLvw0NIcPR3Aa6p9S/
 51kJ/v+2uvlyIx8r73IBIp5nJ4++SGoY7dltwt8f+8DIDxelNs00yoU0qk8rqLw711U0
 JtSg5+2ZIB9wkiZZh8j3lcjOUzGbL/asgFj55CcDaIjVhel3E5LQgGD+9Y8jzFqSdrPP
 BW8J2anm+XVMIcx1l0WF1XXJIQDJm4CjGh/SRj9oT5P7enzp4LH2XeRACx4jeYPyzpsB
 n6T5UwhMm5PqlyU04HaONhVjry8x6OYMcGuSRsWXyGJUuC8KVkaKbxYv28VdAdJ4ASqp
 XpCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwPH9q7F+bPtITFyPboC7DdONeQu85yTg/lAG+FNiXBHS0wcmhmp9R5JeQPuJ4z/Wm/+pJAreX1UfVRq29bP/q+gXgolc=
X-Gm-Message-State: AOJu0Yw75d+k5waa803X2G0Q2DNjLGu55rgk3z47YEvLSumiErmh9S50
 bGt8VnSv/Mv/vtyvCneX3BYPU5A0/p7Lqy7jWj3Q9hKnx3aBRZrvY5le2g4FxhfhHjle4m4kFlK
 4oYxrAfowN1i42YYpDv5NyjNcypLckzpznTyLYUUx2EppfgTBVsD0
X-Received: by 2002:a05:6000:1284:b0:368:7564:5a1d with SMTP id
 ffacd0b85a97d-369bbbd886amr1456737f8f.35.1721500171021; 
 Sat, 20 Jul 2024 11:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGStjOY8q4esxK0BAAFgLMWWrEoRNu/uObQn68Xuf3qjMnFJeJ/Kj0oloCrQxwtc102e3Faaw==
X-Received: by 2002:a05:6000:1284:b0:368:7564:5a1d with SMTP id
 ffacd0b85a97d-369bbbd886amr1456724f8f.35.1721500170289; 
 Sat, 20 Jul 2024 11:29:30 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427dd0ef693sm22275135e9.38.2024.07.20.11.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 11:29:29 -0700 (PDT)
Date: Sat, 20 Jul 2024 14:29:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: YeeLi <seven.yi.lee@gmail.com>
Cc: jasowang@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, qemu-devel@nongnu.org
Subject: Re: [PATCH] intel-iommu: fix Read DMAR IQA REG DW
Message-ID: <20240720142902-mutt-send-email-mst@kernel.org>
References: <20240704035302.306244-1-seven.yi.lee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704035302.306244-1-seven.yi.lee@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 04, 2024 at 11:53:02AM +0800, YeeLi wrote:
> From: yeeli <seven.yi.lee@gmail.com>
> 
> When dmar_readq or devmem2 read the DW of IQA always 0UL because
> "& VTD_IQA_QS". So, try to fix it.
> 
> case:
> after vtd_mem_write
> IQA val: 0x100206801
> 
> after vtd_mem_read
> IQA val: 0x100206001
> 
> Signed-off-by: yeeli <seven.yi.lee@gmail.com>


how was this tested?

> ---
>  hw/i386/intel_iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 37c21a0aec..e230a45940 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2938,7 +2938,8 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
>  
>      /* Invalidation Queue Address Register, 64-bit */
>      case DMAR_IQA_REG:
> -        val = s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & VTD_IQA_QS);
> +        val = s->iq | (vtd_get_quad(s, DMAR_IQA_REG) & VTD_IQA_QS
> +                | VTD_IQA_DW_MASK);
>          if (size == 4) {
>              val = val & ((1ULL << 32) - 1);
>          }
> -- 
> 2.34.1


