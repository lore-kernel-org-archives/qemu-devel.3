Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618B9C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbSK-0007ib-7o; Fri, 23 Feb 2024 14:43:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdb5N-0002GF-O5
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:19:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdb5K-0007nq-5n
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708715988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZpqHWqbAN/MBEhiC/FJWHqxhIj4aptI5ngFUgePBW6Y=;
 b=h7HtwJJmGQLCzhfuBnkvlEt0+UF9KUkWYKhD9IHHmrbj+xd4cmEp/UVomFd0E3joHBlL97
 VkpkB7/78v+Hv46AMMHiHK5EdLjc19EdQJvwkscmIbaeJmDvJo5opBpTxZQBqnmhgivE3D
 yKI3zl3MIms/fHCUVBn6aC/G0OYYwL4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-Ukj6UyqzMhOdzo5jAwZ2-Q-1; Fri, 23 Feb 2024 14:19:47 -0500
X-MC-Unique: Ukj6UyqzMhOdzo5jAwZ2-Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33dadb50731so380917f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 11:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708715986; x=1709320786;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZpqHWqbAN/MBEhiC/FJWHqxhIj4aptI5ngFUgePBW6Y=;
 b=M1dN+lRsWvav1fhup+rxmKrcvBbP8b1/gYmF4RGAGExS7HuEmv4+ZCLUQSIM0tCMPK
 teEh6VQEm5cWRz7mweS1GaEjbS7c2tbBlRIY85oDIbXyi7IV97hZFZgGdPgTUMCNYSKn
 5ESKZqxQ78e+MjZ3zN1VUncewsdZsD2u8I0FDdXHFdj8GA/6MmvtGXSGIn+7xXWrjb09
 BYuO87NVxbKpZR4Ubu2pnHrYR30KwBfSYAOBna/W+/wveqmQw6y0wUxFNgBEW2B1bRg9
 ZQLwZfAn1Rv0sYwgvhCQANZW3np+OVCRkwRQoCISTy0jrTgDlbQIjikPHGrFuzkGmZHA
 Nn4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDVrrJ2k7+eghLz2uI9+lmQrrf2uyq7zTBlW5AY3O4m4eMndQyLHfmzWpC2q6iI+OiZ9G7UzoMA9vYliWiuXCkZUbCby0=
X-Gm-Message-State: AOJu0YyCrAOG5q3pLfzM0oP+oSDqESQwXUggSUQUoI+2HJaiPNc2SW/2
 ChJoFz/n77YmW10Rl2bli6zbchpDfdkRjrC80/vxhpvVQQ7T5XRG/GziMUR7T1R6i87TjIbk40+
 i/0gmcOrt5bIFo1Td9r0eDW9VOIfhXaSEEmrEd6mZ5LSS2uMCNlji
X-Received: by 2002:adf:f88f:0:b0:33d:2226:a26b with SMTP id
 u15-20020adff88f000000b0033d2226a26bmr502484wrp.24.1708715986082; 
 Fri, 23 Feb 2024 11:19:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8BiqXEeDAx149bgRRErhjY5XVfClhAxL/0iGzOU+nMKqaraGJdWQRUXUBRx/Im6k5yigq4A==
X-Received: by 2002:adf:f88f:0:b0:33d:2226:a26b with SMTP id
 u15-20020adff88f000000b0033d2226a26bmr502473wrp.24.1708715985766; 
 Fri, 23 Feb 2024 11:19:45 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-215.web.vodafone.de.
 [109.43.176.215]) by smtp.gmail.com with ESMTPSA id
 ay28-20020a5d6f1c000000b0033d60cba289sm3950786wrb.68.2024.02.23.11.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 11:19:45 -0800 (PST)
Message-ID: <3936c63a-b67a-484d-b7c0-5297b4c3aed4@redhat.com>
Date: Fri, 23 Feb 2024 20:19:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide: Remove last two uses of ide/internal.h outside of
 hw/ide
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, philmd@linaro.org
References: <20240223142633.933694E6004@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240223142633.933694E6004@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 23/02/2024 15.26, BALATON Zoltan wrote:
> Remove last two includes of hw/ide/intarnal.h outside of hw/ide and
> replace them with newly added public header to allow moving internal.h
> into hw/ide to really stop exposing it.
> 
> Fixes: a11f439a0e (hw/ide: Stop exposing internal.h to non-IDE files)
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/arm/sbsa-ref.c                 | 2 +-
>   {include/hw => hw}/ide/internal.h | 0
>   include/hw/misc/macio/macio.h     | 2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename {include/hw => hw}/ide/internal.h (100%)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 5d3a574664..f027622a75 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -36,7 +36,7 @@
>   #include "hw/arm/smmuv3.h"
>   #include "hw/block/flash.h"
>   #include "hw/boards.h"
> -#include "hw/ide/internal.h"
> +#include "hw/ide/ide-bus.h"
>   #include "hw/ide/ahci_internal.h"
>   #include "hw/ide/ahci-sysbus.h"
>   #include "hw/intc/arm_gicv3_common.h"
> diff --git a/include/hw/ide/internal.h b/hw/ide/internal.h
> similarity index 100%
> rename from include/hw/ide/internal.h
> rename to hw/ide/internal.h
> diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
> index 86df2c2b60..2b54da6b31 100644
> --- a/include/hw/misc/macio/macio.h
> +++ b/include/hw/misc/macio/macio.h
> @@ -28,7 +28,7 @@
>   
>   #include "hw/char/escc.h"
>   #include "hw/pci/pci_device.h"
> -#include "hw/ide/internal.h"
> +#include "hw/ide/ide-bus.h"
>   #include "hw/intc/heathrow_pic.h"
>   #include "hw/misc/macio/cuda.h"
>   #include "hw/misc/macio/gpio.h"

Oh, I was sure that I got them all ... thanks for double checking!

Reviewed-by: Thomas Huth <thuth@redhat.com>


