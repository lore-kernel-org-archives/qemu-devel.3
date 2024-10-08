Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A1ACED275
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 07:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy4sB-0004qC-8t; Tue, 08 Oct 2024 03:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy4sA-0004q1-Dx; Tue, 08 Oct 2024 03:43:10 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy4s9-00043Q-0R; Tue, 08 Oct 2024 03:43:10 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-287f29182b0so956429fac.0; 
 Tue, 08 Oct 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728373387; x=1728978187; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghd2BPQRelb4O0f2ybokHHDLcMUidNiWh38TM2yCeSM=;
 b=HF8atwbuLvO5xAZszK5wcSga3NoZqo5gE/J5S5/4ixVQD0N8iPV/rkF905yoF4dCHT
 FoUuPHjq0MExKhv/sGXNBpHmo31Px8lTNEBRkhXu7vO2Ec6hS9tPalFJ1DlZaB4mwM1K
 jR0AxbFoCGL13GINzJpOP8sVJxephsQeiMxapZYBi0r9lB5gAIxpql7S8Mq9y99MCCzo
 hmej+68MWoeMOidGGmZ4CaB8wFuRmU4piYk0TQ/hVnQ5VZrkTLZDB2AzEr3NO9PUIG9m
 H3FUzPV96mhXKIr0n859ODiYzrX/mmZOU2/6edMGUn7G/fg1hlco0+zh/krnTWd2XzxH
 qabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728373387; x=1728978187;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ghd2BPQRelb4O0f2ybokHHDLcMUidNiWh38TM2yCeSM=;
 b=aH6HdInmTfWFHNb8yapS81sXmnl+fJV7Ux/Bxg9EE+8baiMEHNg7buP//Sj6VT8wf6
 c4EI0FhQryQeBuxVnsoBrPrWyB0kYzR1I5qn6w0BzndwwVsb090hFTras6xDVYCMj73r
 BrcwCR/mpiPNhxY/J5PwS+DVMgxN8xoVRVZOwy7PsqWL7eQPXi1/keH7ZLYT2fD9yjis
 PcXjZd+Pak8FmyOLitextWnj/V9Sc9EBEohWHZypwupZnc60imHvkZZFhgoY68LWjs5J
 dWiHwhe9CWxS7qJy5Lg9fG4zdQFHzNnJPZoAuTcKP2rkxPuS/XPdGu1rERyJruwNMlGr
 h9lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2L19wCDN0MzDGUU6hkOgHSgoIWOK4LfOUTWtTNIfMMZaka2fc59jfKf0K/aI3GEwICwj5yvMOFRKh@nongnu.org
X-Gm-Message-State: AOJu0YyDVGPoxHwAM+yctsL9jfvAyclbEYDoueNLhSbOZ8ahd70/H07K
 4Ps5gsNQQkYUJ2QuTP2x2BeKh6M+8ihsDzj6rWdrKyqFk0mUIoTN
X-Google-Smtp-Source: AGHT+IEJdkO8e38nDhdmIguwrtMUTU5iMzNYCkAGfrevJCYKPqeUfseSITQxd3+MthiqWYC1QZgkvg==
X-Received: by 2002:a05:6871:e288:b0:270:631e:cf7b with SMTP id
 586e51a60fabf-287c230d617mr6986418fac.41.1728373387020; 
 Tue, 08 Oct 2024 00:43:07 -0700 (PDT)
Received: from localhost ([118.210.103.101]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6c36bedsm5320126a12.71.2024.10.08.00.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 00:43:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 17:43:00 +1000
Message-Id: <D4Q989HQVNJA.3LVK3LEUYT1G4@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@linux.ibm.com>, <chalapathi.v@ibm.com>, <saif.abrar@linux.ibm.com>,
 <dantan@linux.vnet.ibm.com>, <milesg@linux.ibm.com>, <philmd@linaro.org>,
 <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.2 v3 0/3] hw/ssi/pnv_spi: Remove PnvXferBuffer and
 get_seq_index()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
In-Reply-To: <20240918165045.21298-1-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Sep 19, 2024 at 2:50 AM AEST, Chalapathi V wrote:
> Hello,
>
> v3:
> 1. Update the PowerNV maintainer section to include hw/ssi/pnv_spi*
> 2. Use of PnvXferBuffer results in a additonal process overhead due to
> frequent dynamic allocations and hence use an existing Fifo8 buffer.
> 3. Use a local variable seq_index and use it with in while loop instead
> of repeatedly calling get_seq_index() and make sure s->seq_op doesn't
> overrun when seq_index is incremented.
>
> Tested:
> passed make check and make check-avocado
>
> Supersedes: <20240807202804.56038-1-philmd@linaro.org>

Hi Chalapathi,

To be clear, this fixes Coverity CID 1558831? A Resolves:
tag for the CID should be there, I guess it's patch 2?

I like patch 2, but since it is quite a significant change,
should we take the v2 series first which is much smaller,
then add this conversion on top of it?

If it was long-standing code that would be important (because
you don't want to introduce regressions or conflicts when
backporting fixes). Since this is a new model I guess there
is leeway to just take v3 as is.

Thanks,
Nick

>
> Philippe Mathieu-Daud=C3=A9 (1):
>   MAINTAINERS: Cover PowerPC SPI model in PowerNV section
>
> Chalapathi V (2):
>   hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure
>   hw/ssi/pnv_spi: Use local var seq_index instead of get_seq_index().
>
>  MAINTAINERS              |   2 +
>  include/hw/ssi/pnv_spi.h |   3 +
>  hw/ssi/pnv_spi.c         | 228 +++++++++++++++------------------------
>  3 files changed, 89 insertions(+), 144 deletions(-)


