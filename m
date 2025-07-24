Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119B7C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 08:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uerga-0002TG-0s; Thu, 24 Jul 2025 04:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uergP-0002MP-M7
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 04:52:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uergN-0005jW-Rj
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 04:52:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45629703011so4733605e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753347126; x=1753951926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J/Agva/uaBmY+2rCnSNmB/Rgl0AZCDHV58eYSWguttk=;
 b=M53oHSqBJoUROMGRUPTYFCKvilK5FQAavZKPaeMmLWDUTQZ7UXaq3jwLvzKO/VpmXU
 vsJCtB+z4jcyrBl5Pbwd32VT4ETArPBwx3gK7s3m2AGVoBfuCGi1rFTwy5nOqwM8Ex/1
 qZkiYzGmmAXdHGZOZVnZKi24kb0sAYyTzmJInhIK8RlIjwVzqzEzOdK8eeuYdWtjikZA
 P7VeZtnhzuFu8ymCPWoqrqv690DUOdSPGEita9412RbiaeNK0v60dExNX2EKpzecM1sr
 B7scb+fa7MSAn1roP2lL5IqarN/57mY8tL8Q9eBMoLQ4UT1PYCLpDj0cmiOjVPqoqq88
 pZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753347126; x=1753951926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J/Agva/uaBmY+2rCnSNmB/Rgl0AZCDHV58eYSWguttk=;
 b=KATccPIo4vHYojubV1I55SJ4U1zjXMP2WTxoMZk9WZIg4nMxXKFbTDiLBKn4vTFUTN
 GkSVfttGxdkjDvyi2LQFNlQBu9ysYWO4M+eDzWZ2EI4fPGZzniwMOW2K8+Chgsj5in6h
 JP2660IaCa0Ul+TsNosKFaf/Iv9gr2sgTZOiMdEJH+F5nR2Xylq0WBvd8ttep3EysVNj
 XSCR5GgNqoavICNEfb3oPLBRRO74Us+2muUsVoAEmQAL7fMZBFwOvWa1REkVIj88bANT
 pCfT11jEjjNoXuPBBRH9F8zKgZnhJeq0c9YulKjFJ2Y+vfT8TO6Ro2HMbUs3LDbHrK1M
 AkRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKnbuxGyGBlPP3gjPu32PV8G+dsZUOuvZ50g/zpC/u5rD/BxM1ScoWAHYqSmtIJPpB4N42fdunqYG+@nongnu.org
X-Gm-Message-State: AOJu0YzECAMAeXfkhhHrjQmpLlvS6XKY7NOyBpA3X8uvxkEw1bPn+pQL
 tPHc8pJ7RE/9Pz8w3puKYAFxYekxSnIIVyW+Q/1RPKJZRyYBPakF2/1/3ODEgNm5sqE=
X-Gm-Gg: ASbGnctzpxB3pdH8tqOCpwG0srwHHBRGIRDuWH3zlWV72oHtk76UdSm7Z8Qof+5sxQ4
 bjZ7urt3VDX3CjIqULOWE5eyiLTsdhyJSr5Z478ILa5lDWCWwuhdP6MEtZRtfJN/W+SobwRuC2B
 EdUGlWAwcRfPWpRcPpUXNkxCfsBMPpRXh5f3/W+Xg8kZo34sHh2oH04Sgg+BMLPr8ekjWAif+P8
 SNHa6I87Abls/ZPel8oxS+KZvCb85s/72+DztPzV8i3qLVYMIk3AaK8cTcGsBtlQ4j6ZdgNTaeK
 fZw+SlR1YF7H3La0aH3sUjzZfHZCDbF12jSLdw0pAfEbuMILeGVDoZ5gd17Z3ea79kk8CR1we6r
 Ni+GmmgtuH3gD2pAYzXDChhNFfzDuBsrkUyAI7ftxJsZ//Gno3SHLxkZsAs81O6yENA==
X-Google-Smtp-Source: AGHT+IGv7E/XDc4n9DH0KdchYEb6Eth0k7aORxmYQl4tj3Pf4InLYGVyN5arLehtAEglGrQxu5y07Q==
X-Received: by 2002:a05:600c:1ca4:b0:455:bd8a:7e7 with SMTP id
 5b1f17b1804b1-4586fd1a863mr12611055e9.9.1753347125687; 
 Thu, 24 Jul 2025 01:52:05 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054e37dsm11600655e9.14.2025.07.24.01.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 01:52:05 -0700 (PDT)
Message-ID: <c6891bd3-eee9-425a-a785-f503284145af@linaro.org>
Date: Thu, 24 Jul 2025 10:52:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/i386/amd_iommu: Support MMIO writes to the
 status register
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 eduardo@habkost.net, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com, vasant.hegde@amd.com
References: <20250724064745.4091-1-sarunkod@amd.com>
 <20250724064745.4091-6-sarunkod@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250724064745.4091-6-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24/7/25 08:47, Sairaj Kodilkar wrote:
> Support the writes to the status register so that guest can reset the
> EventOverflow, EventLogInt, ComWaitIntr, etc bits after servicing the
> respective interrupt.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   hw/i386/amd_iommu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index bbffd07b4e48..7c2fa80d14ff 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -850,6 +850,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>           amdvi_mmio_reg_write(s, size, val, addr);
>           amdvi_handle_pprtail_write(s);
>           break;
> +    case AMDVI_MMIO_STATUS:
> +        amdvi_mmio_reg_write(s, size, val, addr);
> +        break;

Should we add:

         default:
             g_assert_not_reached();

to catch unimplemented cases?

>       }
>   }
>   


