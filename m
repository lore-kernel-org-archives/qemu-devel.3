Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA58C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 09:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRSuE-0000ZL-Qm; Tue, 17 Jun 2025 05:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRSu9-0000YD-AD
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRSu6-0000hy-TR
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750153612;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JM0RIiNZftal/f1jZbhP/9upwL7QmYYstUXcI6ZDHQA=;
 b=LV3tbRjkg9JPQodFi58DHotnJiUfXrN6cI3jaZbOBShooOj0wY2ZTRtrD2Ze8SUeeZHynL
 cSGxzQyeGY11yfuzkE7Ed8qLPpbddSR7ZwxUnncgGb586sKqlYZ47t0aEne8JkL60U95im
 ImOyizO9/7FsxhEkCR2esLaW4LrZiNE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-VMTK4O9jPI-5at1KbsZVKQ-1; Tue, 17 Jun 2025 05:46:51 -0400
X-MC-Unique: VMTK4O9jPI-5at1KbsZVKQ-1
X-Mimecast-MFC-AGG-ID: VMTK4O9jPI-5at1KbsZVKQ_1750153610
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450787c8626so41105355e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 02:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750153610; x=1750758410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JM0RIiNZftal/f1jZbhP/9upwL7QmYYstUXcI6ZDHQA=;
 b=wbtZMi20kSkZ/JfrzMey+pvriWkN5xKQbWthsk12RNqqKmMccbOfJ6TZi/tpfOGNXv
 llriWtyZG4ixZMRJNLRQUBTYl2AsthSvTTjThjHK8W9P37LpyAqjp3Ljf8hNQls+beaW
 SWrLddqf8J9H0QI+OGEXC3kktSUkCwvzMPf0pySAZ1Snvg6Rxirqd65Gs2dDB3J6HOV2
 4izgUoTNPbqxeG5lZ5D18KxJzspRP3t9/LLB3vdwpuWaB29taU0BQ1p5anxq39KiPKGz
 DUTp72PkmHae9dW/SIfYHSYRpca/cU8Tpjd4VwoKHRd56w6aZOZnQRQKYvbupniFB0Ty
 xu/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZllsvY6QTyIsFaMwdSVxscD7vqphKv+ma5y4pDmqAiO6O3UOExwMasE2c70Oi/e71m0myRBuW+65q@nongnu.org
X-Gm-Message-State: AOJu0YwNI2AE0iqye5VvHOZcJ550eWyJ1/+WFAEVhc+monHZs1RvH3+H
 ZwFigWAxew76wtRY22TbMblamhQKOABagb3SWR3s/Xmg+kxqWzLijC1zFCOeCQmp6lsW3WkmCGY
 ee5WFJ3KUIDbJ6SSI8eaoqNN2ehUVuzGyTRCk4XH5BKaS+L7oSsyLNO1M
X-Gm-Gg: ASbGnct66CDun7APLVfHMTEtTvsL84ThXDw31/37iNonGrV/+m7qJX3iurbF6AaX0Yr
 b0pmCRyAs+CsMaXSTyDpEqejWThP+PvnFRG/AEnGplU//1EfkTIV0fthnPEaX/RJxuVx03hdiN/
 w6t13Qy8rIerWp8aE0B/cAmfaF3+svHHPIRZTLv5tx/YXZwRPN1RFW1s/W7PqeDGB+vxj5OvH/x
 rbvF09oGYHs1NkkEbAgs8qghSudtDXt4uGzIeAW67swnsLFFEx4TamjKfQnlgnLxOsStpahSR+M
 MhppDLWJdb/uuANUMlUFB5q0PKLPEsBF/4qzZo01Lxtn67h+I3C5QLWcSCCpLv5HrfiH0g==
X-Received: by 2002:a05:600c:1da8:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-4533cb48606mr96572065e9.21.1750153609899; 
 Tue, 17 Jun 2025 02:46:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeWEkRIPFkQbIPYVWRmJxiAod+zgptacFpAsqATZRHQocNjFhC522uldytyXFmDdkz90UgaA==
X-Received: by 2002:a05:600c:1da8:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-4533cb48606mr96571735e9.21.1750153609503; 
 Tue, 17 Jun 2025 02:46:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e151c3csm174344405e9.30.2025.06.17.02.46.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 02:46:48 -0700 (PDT)
Message-ID: <aaf6ad75-6016-43f1-989b-1937c895dc3f@redhat.com>
Date: Tue, 17 Jun 2025 11:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] hw/arm/virt: Simplify logic for setting instance's
 'tcg_its' variable
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <20250616131824.425315-3-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250616131824.425315-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 6/16/25 3:18 PM, Gustavo Romero wrote:
> Because 'tcg_its' in the machine instance is set based on the machine
> class’s negated variable 'no_tcg_its', 'tcg_its' is the opposite of
> 'no_tcg_its' and hence the code in question can be simplified as:
> tcg_its = !no_tcg_its.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  hw/arm/virt.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9a6cd085a3..42a63a523e 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3337,12 +3337,8 @@ static void virt_instance_init(Object *obj)
>  
>      /* Default allows ITS instantiation */
>      vms->its = true;
> -
> -    if (vmc->no_tcg_its) {
> -        vms->tcg_its = false;
> -    } else {
> -        vms->tcg_its = true;
> -    }
> +    /* Allow ITS emulation if the machine version supports it. */
remove "."?

besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>
> +    vms->tcg_its = !vmc->no_tcg_its;
>  
>      /* Default disallows iommu instantiation */
>      vms->iommu = VIRT_IOMMU_NONE;


