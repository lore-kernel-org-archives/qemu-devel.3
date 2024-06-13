Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE1EC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 13:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHkYI-0000EB-Gn; Thu, 13 Jun 2024 09:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHkYG-00009z-D1
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 09:31:40 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHkYE-0002JO-Md
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 09:31:40 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6ef46d25efso136091166b.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718285496; x=1718890296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vbE/6xxgRupAd5IVFu16NkVdp3dNAs92KSDo2xozS00=;
 b=sqIgwFMIxMl5QGXNpxHlMNHAYd4l8GZqqFJ5VsXATRSL8xqfZXbCAnGyK3j4aHEvwb
 DiIXaGpNh5ACRgd5tdvu37K+N3RXnoCaVsr1JP1qupmn+hl1gHkZE5lu2lb6rSXq0+n+
 3OZdrVr7us8DU+qB2IxcqXvJPe5V9t3NALxKAVjzxPOv2p7r6UWpoxEZpWB4UV9Lfugn
 Lj7+7wQcoQKdGedh4TsBv8J/0/j4eSIa+kC9mOlXWgMYxkLS/niUD4vioBNJCFB3jKpU
 5vH4EU+I8m2Q+nS9GTUfLWwH3GjQzMiy9O83suCFXSrDFK81Fo/c+hf6VtKKbc/ILFI+
 6OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718285496; x=1718890296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vbE/6xxgRupAd5IVFu16NkVdp3dNAs92KSDo2xozS00=;
 b=upFcAMO0q/hV3wWRgLb2LPn01gID95eWCSD6JQINQ7echY+/10PdnpWKfIzJZFHm1b
 6I61vkB0uuCNjhG0JgHKOje/rxqGJzg3XUBhbfrkvPxtBX/tbjAOn0eicT7TbotBVgkq
 UBMVoDEAzvWSSi6xxbZT54TpqdRCDDGwU8Eb9zzIHom7Ni1y/IWjfqdk2IPco7e+mvab
 OF0s4VV+8pPC3PPYJULpSHNMwMdNu+9bgJBamExPoyziOORr/rcAj7R7e7cTBV6AfV5q
 bYoIi/AFqVQhWeNidQSiBT9Bvj9KxV9c8rZZmftDOijU5jSg4s3Milu94kagp1BB5nOT
 xgig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkgaLZtdaA+GT84NrHbnAa+uIZsmP6Z8XZfeX6XTtLN9UM0+E9T/HWnA0AOm7DfHaUXQaj7RXHQG1jPbVy9XBSt9I1HZQ=
X-Gm-Message-State: AOJu0Yyc6lKfVZMLBBC+lMeUG/na+vctxhxxcn4jc59JErHjMABvno5o
 WM3NuYF9kLSsftj4W7mA4o1aQsefxxRiL7HYIdsEvvGg7w6r2nvclh5c9rYD+KQ=
X-Google-Smtp-Source: AGHT+IEVqxe6ifn8NrqRodtpRWLIUDmXp9NCTCmLRw7lEyBUKqNoFRLGirQK5EOJk2hgEeGzMtY15Q==
X-Received: by 2002:a17:906:fc04:b0:a5a:2d30:b8c1 with SMTP id
 a640c23a62f3a-a6f47d56b20mr311822266b.14.1718285496157; 
 Thu, 13 Jun 2024 06:31:36 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da32c3sm74351766b.13.2024.06.13.06.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 06:31:35 -0700 (PDT)
Message-ID: <0282eacc-86d9-4160-abf4-0576c5389290@linaro.org>
Date: Thu, 13 Jun 2024 15:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] hw/ppc: Prefer HumanReadableText over Monitor
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240610062105.49848-1-philmd@linaro.org>
 <e2113792-8715-4d75-b730-fdd29492566e@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e2113792-8715-4d75-b730-fdd29492566e@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/6/24 14:44, Cédric Le Goater wrote:

>> Philippe Mathieu-Daudé (26):
>>    hw/ppc: Avoid using Monitor in pnv_phb3_msi_pic_print_info()
>>    hw/ppc: Avoid using Monitor in icp_pic_print_info()
>>    hw/ppc: Avoid using Monitor in xive_tctx_pic_print_info()
>>    hw/ppc: Avoid using Monitor in ics_pic_print_info()
>>    hw/ppc: Avoid using Monitor in PnvChipClass::intc_print_info()
>>    hw/ppc: Avoid using Monitor in xive_end_queue_pic_print_info()
>>    hw/ppc: Avoid using Monitor in spapr_xive_end_pic_print_info()
>>    hw/ppc: Avoid using Monitor in spapr_xive_pic_print_info()
>>    hw/ppc: Avoid using Monitor in xive_source_pic_print_info()
>>    hw/ppc: Avoid using Monitor in pnv_phb4_pic_print_info()
>>    hw/ppc: Avoid using Monitor in xive_eas_pic_print_info()
>>    hw/ppc: Avoid using Monitor in xive_end_pic_print_info()
>>    hw/ppc: Avoid using Monitor in xive_end_eas_pic_print_info()
>>    hw/ppc: Avoid using Monitor in xive_nvt_pic_print_info()
>>    hw/ppc: Avoid using Monitor in pnv_xive_pic_print_info()
>>    hw/ppc: Avoid using Monitor in pnv_psi_pic_print_info()
>>    hw/ppc: Avoid using Monitor in xive2_eas_pic_print_info()
>>    hw/ppc: Avoid using Monitor in xive2_end_eas_pic_print_info()
>>    hw/ppc: Avoid using Monitor in xive2_end_queue_pic_print_info()
>>    hw/ppc: Avoid using Monitor in xive2_end_pic_print_info()
>>    hw/ppc: Avoid using Monitor in xive2_nvp_pic_print_info()
>>    hw/ppc: Avoid using Monitor in pnv_xive2_pic_print_info()
>>    hw/ppc: Avoid using Monitor in
>>      SpaprInterruptControllerClass::print_info()
>>    hw/ppc: Avoid using Monitor in spapr_irq_print_info()
>>    hw/ppc: Avoid using Monitor in pnv_chip_power9_pic_print_info_child()
>>    hw/ppc: Avoid using Monitor in pic_print_info()

> Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks! As you suggested I'll wait for Nick to post the PPC
pull request before respining this series (and the series
depending on it).

Regards,

Phil.

