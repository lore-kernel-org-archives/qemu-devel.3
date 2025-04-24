Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A6FC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 08:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ruX-0003QI-Pd; Thu, 24 Apr 2025 04:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7ruO-0003OO-Q1
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7ruJ-0002IO-48
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 04:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745483163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T/GqnyPXA9kMIyzWsFT0j04yOPwpDInT0nGe3psUzCQ=;
 b=BeifbLjZi0g3t4SY1ygkIJHAijp5oR1bFV4CCbd//im0QlZ1lDfP9SPCqfstrKGQPtGzmJ
 4N9qLJIzQfBvpb1iEm5GREcAQ8i6apxeZWMLBFQFXf5AU8D4ImBYZTTZqdzTjvfrI78T05
 MzOq6xyk9uwjEo1qUHsH8N4SMlW2eg0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-qcg6mVuQP4qvugiG6SeG2A-1; Thu, 24 Apr 2025 04:26:01 -0400
X-MC-Unique: qcg6mVuQP4qvugiG6SeG2A-1
X-Mimecast-MFC-AGG-ID: qcg6mVuQP4qvugiG6SeG2A_1745483160
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso3743555e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 01:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745483160; x=1746087960;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T/GqnyPXA9kMIyzWsFT0j04yOPwpDInT0nGe3psUzCQ=;
 b=hWIcLDFH/PkB0x9oIPUfP7soSie+wHMS/MS7sGBu27ZVceUtgchvilBln7l3AQzKo2
 EQ7YyXTKg8etyA2fUy+F6+VX0k1QCyJxaeIleqd69/WRvjEt76kQXKtvzzV7bRNhycJ3
 6HnOeRBdt+xsPfirq1yrxP4/AHau5l14+Y24oSy++WTY27rnvI6TfpVypUxWEn7m/AUC
 A1H06hLb2dEY3sYC7p9pF34BHsizKlfoCJQ5G23GnQ1TrxarSfnfSZ0P8DKsgzhNoQn9
 0ybpG9PLMihkQZ91tbqSXUwkxhGmP4sXscdM5rieCqYdkPsechZhkln1YMF44joz6b1I
 COFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu/v3Zz51gCyEpcPPRvTi2FruzZKGNMFTgw4+qfCZLOBR/M2DrWChf7Vb6CH2B8T99v0BpODMRkPq+@nongnu.org
X-Gm-Message-State: AOJu0YxRu31M1b4g7BqglBcs/vxWxaI9g7JPnyurhZvd1SlBa3WzBfNn
 zCTLO7C/SktjeU4uxegmBiVqrBDI5tudFvyUeVKt3yTwcXQl2QHvafCZeb5iMZmF/Le1KW/5Tct
 WfDc+XzKRgkv9dT8HJHIp4JcNKbZbMyW2hgbQPlFzE9IcTsOT5USV
X-Gm-Gg: ASbGncuryg8163BhvAnTC32y9B+w7niuVkH+WF/XOPZRBAK7WTwcE/9TjmhQhhkyLi6
 wv5mpaOCTGhKfJQjnFNl5gYfhQCdBqVeMD903Tl9AerEMGRgTfPgGhlOzYqvGWSfdobmLNWBw2/
 Udd4wJZbDEWYjXhA0YvdFTsx6lPa7Kceo03bdbrMvlJSk1Rd3ajT6d9tsqJNGwUO2/RCk4udu/k
 9ikaGyNsi5E/3ZcSXK8Cs9GNq931lbrH9vzoUtHfM5Q4V69UkVqOrCTepyn2H3oTH/jtaflvQ+o
 CTpnXLP5wDcT3ES3lc/LI5UOs4wgb8DgOUl/ZnIVyty4nQ==
X-Received: by 2002:a05:600c:3d0c:b0:43d:224:86b5 with SMTP id
 5b1f17b1804b1-4409bcfb42cmr15512465e9.4.1745483160315; 
 Thu, 24 Apr 2025 01:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKhjonNZ5FVeA82yDtHWdT0A0yVemREopNXNO1K4YM7gr9QSb2JaabT5cpmN8jghZp/fyvww==
X-Received: by 2002:a05:600c:3d0c:b0:43d:224:86b5 with SMTP id
 5b1f17b1804b1-4409bcfb42cmr15512275e9.4.1745483159975; 
 Thu, 24 Apr 2025 01:25:59 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-178-177.web.vodafone.de.
 [109.43.178.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2b77f9sm10956845e9.25.2025.04.24.01.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 01:25:59 -0700 (PDT)
Message-ID: <2d6dead5-f56c-43cf-b7d1-9567fef99616@redhat.com>
Date: Thu, 24 Apr 2025 10:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/2] target/ppc: Big-core scratch register fix
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-stable@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250408124550.40485-1-npiggin@gmail.com>
 <20250408124550.40485-2-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250408124550.40485-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On 08/04/2025 14.45, Nicholas Piggin wrote:
> The per-core SCRATCH0-7 registers are shared between big cores, which
> was missed in the big-core implementation. It is difficult to model
> well with the big-core == 2xPnvCore scheme we moved to, this fix
> uses the even PnvCore to store the scrach data.
> 
> Also remove a stray log message that came in with the same patch that
> introduced patch.
> 
> Fixes: c26504afd5f5c ("ppc/pnv: Add a big-core mode that joins two regular cores")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   target/ppc/misc_helper.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 2d9512c116..46ae454afd 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -332,6 +332,10 @@ target_ulong helper_load_sprd(CPUPPCState *env)
>       PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
>       target_ulong sprc = env->spr[SPR_POWER_SPRC];
>   
> +    if (pc->big_core) {
> +        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
> +    }
> +
>       switch (sprc & 0x3e0) {
>       case 0: /* SCRATCH0-3 */
>       case 1: /* SCRATCH4-7 */
> @@ -368,6 +372,10 @@ void helper_store_sprd(CPUPPCState *env, target_ulong val)
>       PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
>       int nr;
>   
> +    if (pc->big_core) {
> +        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
> +    }
> +

  Hi Nicholas,

this patch breaks compilation when QEMU has been configured with 
"--without-default-devices" :

FAILED: qemu-system-ppc64
cc -m64 @qemu-system-ppc64.rsp
/usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in 
function `helper_load_sprd':
.../qemu/target/ppc/misc_helper.c:336:(.text+0xcab): undefined reference to 
`pnv_chip_find_core'
/usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in 
function `helper_store_sprd':
.../qemu/target/ppc/misc_helper.c:376:(.text+0xda3): undefined reference to 
`pnv_chip_find_core'
collect2: error: ld returned 1 exit status

Could you please have a look?

  Thanks,
   Thomas


