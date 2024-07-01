Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFB5C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOHJV-0006S9-6g; Mon, 01 Jul 2024 09:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOHJC-0006FI-Ke
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOHJA-0005QI-SH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719841383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rIDlGfL/DvfAluSOXFJPk4ANF0Fy+JO3hBI44JUHjo=;
 b=PdyLtTSMSigoFGfb9dPd5gYAs8g44sg8PjEcFOd/YUzYN5B8ArSS+s8YxP7vi51h2gT9mw
 TxqiXH8Gob9qTsJ5hA+ymzuLuJ6VfLyo3XUqClaQUctsRk8hvhrEF4oac7CkNj6/TBOQTU
 dcR8jQGyJORjEPIQac6lZ2Ll6L53N9E=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-3YWaE2ToOXW561VZhQ80AQ-1; Mon, 01 Jul 2024 09:43:02 -0400
X-MC-Unique: 3YWaE2ToOXW561VZhQ80AQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ec617f8b6fso27502121fa.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 06:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719841380; x=1720446180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6rIDlGfL/DvfAluSOXFJPk4ANF0Fy+JO3hBI44JUHjo=;
 b=CV2UceW1dlsVjhRHfdIdpOGQHsb9ed+h2AW7IZpetEw7fqT6KH+DPuIGhCpu6HFw6j
 e97TUTwc8PoAuaFjNy/sq7IlqOTs4fWqeoqj/0WLqoxtXHny44MsyQBDLOQXpUKgvgD5
 Y+T8XyyeAFPKZElo0Rk41YlQHqM/32Ekm6Oejp15hyTsEvb/ueI+QtajQjis4VbCAHF8
 wp+/a0sceDeVVCWblp7es0YG9SYh5xcHd5H2Wyg4k/luxYBeVNfTj6WwA9eY/MI1gZ7Y
 DjvZQUODy164cK8QKtpLbW2Ob0a6R2VEl85J1GovGtyUhgC5wuVPo0yz7ezwET/Akb4O
 OfkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM375A0e/fYUgOXSfSIDi3xKNSGeBAIWs5fvm7iko7GBxweNbGVIarCAk7qShwyajXM9y6K47ankI0FJ9dnNS8nh97+co=
X-Gm-Message-State: AOJu0Yye7GCw3o+oMoW/taN6Y5kTdQA1CZkjANPdnTdgUL5HunE9rH4l
 pejGEw6SyuRfdC6ivUTqcS/1aDOeFbvawsXG323XpFJWWniBJwKkFgSHM64LNWoiL07HLZmXh6i
 tVdUnIThab+6icf9d+VxgeCmFD16o3sJOcFNCNFW2SctSNWbas5M0
X-Received: by 2002:a05:6512:4026:b0:52c:8206:b986 with SMTP id
 2adb3069b0e04-52e82727b47mr4977272e87.56.1719841380564; 
 Mon, 01 Jul 2024 06:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2zmTcd9JMwiNF83J0g+wsUHj/wNCc9WHkEV5aW8nhhMgdwkBhzs8Q3Oounp8IrTNxtkEITA==
X-Received: by 2002:a05:6512:4026:b0:52c:8206:b986 with SMTP id
 2adb3069b0e04-52e82727b47mr4977226e87.56.1719841379190; 
 Mon, 01 Jul 2024 06:42:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257fc934b2sm58052665e9.44.2024.07.01.06.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 06:42:58 -0700 (PDT)
Message-ID: <90c733fe-ef96-4612-9637-60cc3e740363@redhat.com>
Date: Mon, 1 Jul 2024 15:42:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Remove inclusion of hw/hw.h from files that don't need it
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Jiri Slaby <jslaby@suse.cz>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20240701132649.58345-1-thuth@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240701132649.58345-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 7/1/24 3:26 PM, Thomas Huth wrote:
> hw/hw.h only contains the prototype of hw_error() nowadays, so
> files that don't use this function don't need to include this
> header.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/misc/xlnx-cfi-if.h | 1 -
>   hw/misc/edu.c                 | 1 -
>   hw/vfio/container.c           | 1 -
>   3 files changed, 3 deletions(-)
> 
> diff --git a/include/hw/misc/xlnx-cfi-if.h b/include/hw/misc/xlnx-cfi-if.h
> index f9bd12292d..5010401517 100644
> --- a/include/hw/misc/xlnx-cfi-if.h
> +++ b/include/hw/misc/xlnx-cfi-if.h
> @@ -11,7 +11,6 @@
>   #define XLNX_CFI_IF_H 1
>   
>   #include "qemu/help-texts.h"
> -#include "hw/hw.h"
>   #include "qom/object.h"
>   
>   #define TYPE_XLNX_CFI_IF "xlnx-cfi-if"
> diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> index fa052c44db..504178b4a2 100644
> --- a/hw/misc/edu.c
> +++ b/hw/misc/edu.c
> @@ -26,7 +26,6 @@
>   #include "qemu/log.h"
>   #include "qemu/units.h"
>   #include "hw/pci/pci.h"
> -#include "hw/hw.h"
>   #include "hw/pci/msi.h"
>   #include "qemu/timer.h"
>   #include "qom/object.h"
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 2e7ecdf10e..88ede913d6 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -26,7 +26,6 @@
>   #include "exec/address-spaces.h"
>   #include "exec/memory.h"
>   #include "exec/ram_addr.h"
> -#include "hw/hw.h"
>   #include "qemu/error-report.h"
>   #include "qemu/range.h"
>   #include "sysemu/reset.h"



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



