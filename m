Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508D5D5E123
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 08:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9gnU-00007j-Ol; Sat, 09 Nov 2024 03:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gnT-00005z-AW
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:26:19 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t9gnR-00042A-Uq
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 03:26:19 -0500
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so401369266b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 00:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731140776; x=1731745576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFNzTgKc/6o/EDp+e84Dy+93gae7NcOF06Lucq26PKE=;
 b=lbPl1KsSWxFNSEKcEcLQ6/NNorDCsC9yBa9d1kurMCCPM6Ku2n6CNE9bSPMh28YYuL
 vT8Qqqy4yAFBu1JzKVkHh5HrFZmci+3r4txBLdXRElTfD+D6oo+76YCz5cjrS2BcCOqG
 wzbzIQ/B5c1jOm9UOil1ehESAs9AYaNqiYdg6BmaP0JOr+dmD89o7aTJ37spq6xauEyM
 DXl7takxrgroelr8zQkRGzcQU5agLmC3hPT/2y/06L3OjuSqNyXTuLA/y8T1cPYMjMLE
 dug5Ld6eRmMw4xEG9/M61nMkGirrJ7JJN3vcpjnHTRczJbvJvH2CJbVAnBzeTvde1rWn
 PrIA==
X-Gm-Message-State: AOJu0YxIybY/JP3kExoWx6yKHQf+rzk7ziwyj6XZiUdeQh2VmygnsBZa
 SO9vdIGq9IOAFGrpU5IbcjP6yzuOAAdTa0HPEzR+4/zZt8m/i7AA
X-Google-Smtp-Source: AGHT+IF0+y5HpIP1zUj0C8ffloAXz8cV2MKf6IHsNoqmZaJk14qfNotyn5EJU8PUjO4wOdjXQPc+5g==
X-Received: by 2002:a17:906:2b10:b0:a9f:4f7:f064 with SMTP id
 a640c23a62f3a-a9f04f816a1mr87739966b.3.1731140776175; 
 Sat, 09 Nov 2024 00:26:16 -0800 (PST)
Received: from tpx1 (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a46119sm334652166b.46.2024.11.09.00.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 00:26:15 -0800 (PST)
Date: Sat, 9 Nov 2024 09:26:13 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 35/36] next-cube: add my copyright to the top of the file
Message-ID: <20241109092613.743d3ca5@tpx1>
In-Reply-To: <20241023085852.1061031-36-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-36-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.43; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f43.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Wed, 23 Oct 2024 09:58:51 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> This series has involved rewriting and/or updating a considerable part of the
> next-cube emulation so update the copyright in next-cube.c to reflect this.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index ece63f20b1..eefb372dca 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -2,6 +2,7 @@
>   * NeXT Cube System Driver
>   *
>   * Copyright (c) 2011 Bryce Lanham
> + * Copyright (c) 2024 Mark Cave-Ayland
>   *
>   * This code is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

