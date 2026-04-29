Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA19CCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI4se-0001ZM-34; Wed, 29 Apr 2026 09:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI4sc-0001Z8-Q0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI4s9-0003gB-DB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777468741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R80XNyhECYyHOqYawSkigCKtybqAUxewXFMHZeRfyKM=;
 b=LfraV+ay4g5+nvJFNYRlbFqQapgrzjpZjvVk1UHX2grc9MR+OkN4rlVo9X3tbssqw5s/Bc
 /jA/sC9HcX56zlPzTQpXXQNz6mN64wboYA1NI2wcSIUlqs3Ujlg1yiMDEKCiDuTk4lZSJx
 v7r3pwRbps03et9XryHYvjI14VvrxhQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-p5Ow9IlOOmSsOmLYjudzbA-1; Wed, 29 Apr 2026 09:13:43 -0400
X-MC-Unique: p5Ow9IlOOmSsOmLYjudzbA-1
X-Mimecast-MFC-AGG-ID: p5Ow9IlOOmSsOmLYjudzbA_1777468422
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35d99c2908cso12142334a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777468422; x=1778073222; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R80XNyhECYyHOqYawSkigCKtybqAUxewXFMHZeRfyKM=;
 b=eEWdCCRwm8Prc/umdboz1oGRx5DUlrJVmmb1ErR2LTEXMU04Llx1+AnGqIK4jPj/19
 g+mqZ2LSYN3xvImhKzIzzrv7Xh3fyLdKqNx3GHeZHm4DNXSqxHNKfNq8lSXGpNUzmXML
 BO9th/fHiWyargWIxN7o4zMGMX/D5CVh4vy89aL5JcQL+0cJJcLy50dYsUUQXMNkSamj
 il2hrufrCEVwaPbvgd67SiPfS8St1BWKPYD/Dut22E/6Vbp1U+YrVYQZ7Mp8R+LU7qtL
 ssDY3b9K95TWIQzIXFu4woGuKhXgfoGeze5sF9wpWpm+3FzPw8bwKu5zaqXs0KkluSUr
 wloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777468422; x=1778073222;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R80XNyhECYyHOqYawSkigCKtybqAUxewXFMHZeRfyKM=;
 b=ay74QwFOQp7bh6ZFTMR4L5djCDQ5O68B8UyuyyeLSy0w2KvawjSAEx1jqU9rV01XlK
 +4DYlwY1j+Gjo6KzA3xWtEZuxxoMx3EIlklWiQCWV4/xinEUtTVZ5uTaRjssfTNZoCn5
 jExvQQapcszAbZYRxFtisZ++EH+J85UIz1PBmLj7pP8DIFXpdSqWStobxG6qsrgoDXsD
 HzinUqAhGhwo6UzqRA5Pxbos/w/bPhUgiS5GY+DfeCq0Mq6CFxc2PFMLliZIsWS2p4Gw
 ++ctXYjaV6m77wrrtYzUTHKZG883YgCTb9/Q4l9+rx4BWeOdsQaFOASVkFWNH0T9qzNG
 S7tQ==
X-Gm-Message-State: AOJu0YwGvikRBMPfzAJQ0Tn9UUkpdhiKoP/Qs3BMj4UdAgVO5CkhILzE
 ni/y1B/LldCeI+WxzFYYMx6ankYejpWjgBmiFRX5Gg3xIfaYkNosd3YUHlzroNMB+1DKLkt5OiG
 Sn3+QB0MP4ToYFwdYJS/sjCZat8XrObfo890blEz7X0N99gR6qEa01GH1
X-Gm-Gg: AeBDies0+KN3uWP8EFg1rw+JZIlomyQR5rGCQ4Ak0Qe+sb/QaAFK2NVpw3Za3BHLrL5
 nQjFwtoB5ZHkX4KTz3S8cqvBsGpHHBP6Yt5qiAPDXsC4ttX5rNpEAQ5FvsVASQqp6NgnIhnscIO
 g9zvVdBGk1thjbY1I/7zOoNbGtuMT6V8zGWm0VcFiWB+jnmzCc9f4W/dpxHVoZI4jpCSLQ5H3dC
 M+oC99vQZtS12erHhh+xzOTkdAAA/Dd+STzZe8YMCoB4W/J4s152GmuDIaOx6n6ML2FpdRTwin6
 n95nerEbGVuBz8KijKlwW31SeGvJI5A5YdF2f+KT79lTJdKwRCLC/2wgOJcDnlgGaO05KVmCBYR
 udCpObtJcvkEGwuQfyn5FVPc=
X-Received: by 2002:a17:90b:1d51:b0:359:8e5e:43de with SMTP id
 98e67ed59e1d1-3649203b479mr7587215a91.22.1777468421648; 
 Wed, 29 Apr 2026 06:13:41 -0700 (PDT)
X-Received: by 2002:a17:90b:1d51:b0:359:8e5e:43de with SMTP id
 98e67ed59e1d1-3649203b479mr7587189a91.22.1777468421227; 
 Wed, 29 Apr 2026 06:13:41 -0700 (PDT)
Received: from fedora ([49.36.110.142]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a4152038sm3253907a91.2.2026.04.29.06.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:13:40 -0700 (PDT)
Date: Wed, 29 Apr 2026 18:43:34 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH v2 5/6] tests: Check whether the I2C master flag is set
Message-ID: <afID_pQ_OkmqrABE@fedora>
References: <20260429121743.1346635-1-stefanb@linux.ibm.com>
 <20260429121743.1346635-6-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429121743.1346635-6-stefanb@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On Wed, Apr 29, 2026 at 12:17:42PM +0000, Stefan Berger wrote:
> Replace the 'once' variable with a check for whether the master flag is
> set so that the flag can be set when needed.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tests/qtest/qtest_aspeed.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/qtest_aspeed.c b/tests/qtest/qtest_aspeed.c
> index f6da9adea9..7bf5abb9be 100644
> --- a/tests/qtest/qtest_aspeed.c
> +++ b/tests/qtest/qtest_aspeed.c
> @@ -15,18 +15,21 @@
>  #include "qtest_aspeed.h"
>  #include "hw/i2c/aspeed_i2c.h"
>  
> +static bool aspeed_i2c_is_master_enabled(QTestState *s, uint32_t baseaddr)
> +{
> +    return qtest_readl(s, baseaddr + A_I2CC_FUN_CTRL) & A_I2CD_MASTER_EN;
> +}
> +
>  static void aspeed_i2c_startup(QTestState *s, uint32_t baseaddr,
>                                 uint8_t slave_addr, uint8_t reg)
>  {
>      uint32_t v;
> -    static int once;
>  
> -    if (!once) {
> +    if (!aspeed_i2c_is_master_enabled(s, baseaddr)) {
>          /* one time: enable master */
>         qtest_writel(s, baseaddr + A_I2CC_FUN_CTRL, 0);
>         v = qtest_readl(s, baseaddr + A_I2CC_FUN_CTRL) | A_I2CD_MASTER_EN;
>         qtest_writel(s, baseaddr + A_I2CC_FUN_CTRL, v);
> -       once = 1;
>      }
>  
>      /* select device */
> -- 
> 2.43.0
> 

Reviewed-by: Arun Menon <armenon@redhat.com>

Regards,
Arun Menon


