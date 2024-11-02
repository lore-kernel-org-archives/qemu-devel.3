Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E299FE67807
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 17:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Htr-0004aT-Ck; Sat, 02 Nov 2024 13:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t7Htj-0004a0-2X
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 13:26:51 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1t7Hth-0000Ma-Mf
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 13:26:50 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5ebc52deca0so1474578eaf.3
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1730568408; x=1731173208;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n7pi/FvajqeDym4oFzIPU75adzhGvht79NsxfkMVB+w=;
 b=qZl9s0nc30ZGtqRM2LNzhxfeiq50uKMGDhFXKPrdD6w0P5Kj6Dv3kV6haMuIExNhgZ
 mPnHKHqHyAak8PvpJ92alwc2gZFAeglV3CXc/+/W7SDCdZRemQozWKu5KSCtbbk4idlR
 jDWyahMDVP9rwS5z2hp6e5cDr/fJN0mv1ksTxHN4hMd6ByU1TSmkYVp5J4KH9TpzEYhP
 mvTVBckNI35g8nUFHR4NywLCje+vU4rXzh+nEMnwh63TKgpC5bOvB4pl5pqFKuNN+bsH
 wKwIWltYynHEXUnCi31uxMLGpY89k7HX0pPkybbGFZbF9t2GrViorbIec7UHdf4i8Y+F
 lkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730568408; x=1731173208;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n7pi/FvajqeDym4oFzIPU75adzhGvht79NsxfkMVB+w=;
 b=AXEM9tdrmh/FMagKR5z5CM+xB0B2198Q8sXKlOYumOrwZhe71ISFt4+W8B9mwFcbZP
 2U9VWxwCTkDW2N+B+UfJTxx3ldqzqYJlBC99+8T2uYZyp3KtNvxoF3GrI4As57aYs0Dk
 fZSH8W8uryy8MASo2w/RzOzIcD9tC+25GQKlg2W7Iw3JJYtYKEpaSEcnR7WuYMIOX3W5
 euYMNF54Nt5ZmDgsKyKOmWJfQPzGx6ueVEKjcXkuR16eZ+l4KVb8zkDFIabqET8//7tH
 K04/upHBps9EUY+Apr+ggzwaOCttBhjzSNZgQ3XzxB3pHgAFrSORc2XOKc0477Eh+oCs
 TCMQ==
X-Gm-Message-State: AOJu0YxNAovug4HO6EnUwrTXnsZHCH9vrS4wdU8hOHUcOFSAa3irJX3p
 145xQT0kkrG5svNJxiSv31wqH67Ulg5Iy8DQWw4lwPQ5oHt1NNhG4SwfDBYsG24=
X-Google-Smtp-Source: AGHT+IGtMPc2XfCwz+1aRE7Fl66tohEb1E1+fvPbkpEyVa0BIL26Sw10v/O9QzfnPK7QnK8De3kEgw==
X-Received: by 2002:a05:6870:332a:b0:288:6365:d7a2 with SMTP id
 586e51a60fabf-2949f0b2f88mr6529969fac.44.1730568408222; 
 Sat, 02 Nov 2024 10:26:48 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:fa3e:9c23:b11b:a3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-294874ba769sm1807732fac.23.2024.11.02.10.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 10:26:47 -0700 (PDT)
Date: Sat, 2 Nov 2024 12:26:41 -0500
From: Corey Minyard <corey@minyard.net>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v3 12/26] hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
Message-ID: <ZyZg0QJqcT9WwvDs@mail.minyard.net>
References: <20241102131715.548849-1-shentey@gmail.com>
 <20241102131715.548849-13-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241102131715.548849-13-shentey@gmail.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=corey@minyard.net; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Nov 02, 2024 at 02:17:01PM +0100, Bernhard Beschow wrote:
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/i2c/mpc_i2c.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
> index 3d79c15653..16f4309ea9 100644
> --- a/hw/i2c/mpc_i2c.c
> +++ b/hw/i2c/mpc_i2c.c
> @@ -20,7 +20,6 @@
>  #include "qemu/osdep.h"
>  #include "hw/i2c/i2c.h"
>  #include "hw/irq.h"
> -#include "qemu/module.h"
>  #include "hw/sysbus.h"
>  #include "migration/vmstate.h"
>  #include "qom/object.h"
> @@ -345,16 +344,13 @@ static void mpc_i2c_class_init(ObjectClass *klass, void *data)
>      dc->desc = "MPC I2C Controller";
>  }
>  
> -static const TypeInfo mpc_i2c_type_info = {
> -    .name          = TYPE_MPC_I2C,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(MPCI2CState),
> -    .class_init    = mpc_i2c_class_init,
> +static const TypeInfo types[] = {

Same question as smbus_eeprom.  The old name was more descriptive.

-corey

> +    {
> +        .name          = TYPE_MPC_I2C,
> +        .parent        = TYPE_SYS_BUS_DEVICE,
> +        .instance_size = sizeof(MPCI2CState),
> +        .class_init    = mpc_i2c_class_init,
> +    },
>  };
>  
> -static void mpc_i2c_register_types(void)
> -{
> -    type_register_static(&mpc_i2c_type_info);
> -}
> -
> -type_init(mpc_i2c_register_types)
> +DEFINE_TYPES(types)
> -- 
> 2.47.0
> 
> 

