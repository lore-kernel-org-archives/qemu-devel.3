Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55828C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFJi-000233-BN; Mon, 18 Mar 2024 11:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmFJg-00022k-GL
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmFJc-0000Yv-VT
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710777252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGdd3bTDQQMwTXMFHiRpzE8iz62FDcSheD0mzWIFn0U=;
 b=ZW2eklKRcH1yhlry6WOK+AmLCZqZ1nrv8vMCIjcrXZKORrRxFeTs0Zb5oYcOymeIkHN0AF
 0Y5zlzNAQqcZ1zn7UlGzM5IwX6b66++i1X1Hcu/dhLAhSkOqBbCFh/38xIe1JtPcJQ90fr
 tbTC9pcGGkF1lpgrsvSKYbkPj1v54XU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-Ek8cv2X_O3GJ4ESjPo_wNQ-1; Mon, 18 Mar 2024 11:54:11 -0400
X-MC-Unique: Ek8cv2X_O3GJ4ESjPo_wNQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-34172041676so662081f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710777249; x=1711382049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dGdd3bTDQQMwTXMFHiRpzE8iz62FDcSheD0mzWIFn0U=;
 b=FmXSCyCAnVR9GXoXPBxiMoAMraH7cmw3FkWjAujHXcAtZ9UP05uQVDk/4tA2kk2RlN
 q9w7IaNne6YWNq/YiqTw0jzQzDF9MCCQnmmDZG3toFOz9Rc3VmX7EKesjbizSbg7kx37
 YJ088vkdo3TkdyuAR45BoydSOMMwZ9xps+NJLtDfQ1ET3LU0dbErwRR6SN8eXcm47IC8
 VrzZkdESMa4XVG4Q2JECOwH1rKDNwGkxKjuGIZVNYSG2Coj1g7xWxCziUJx6gvKx7q3k
 W39wlA1jL5wwLctPU2fw3Y2WQPkOzw395ohxrlfmIfDhs0OwA5JAN9OeOgicWsOAQNUQ
 pp9g==
X-Gm-Message-State: AOJu0YyStI8nUWuex4QTr6jekvfUsy121I21OHkTp11ENkTWj+2ceGb6
 8E6pGBdvFNiuXkrqL+bEalc82UDX16Gd/lTHR2NCgq3lYsfjuevzqL6a3diMI6F07hraJSv6Dkw
 E3WncBFnHs/VdhkYsGyRSEyHLc+fYYLK9eBHEm05w8cjdzLzUZMaHnFgZaDsYij9iracfGVhT4d
 xZYf1V0w0PUfn1O6m7kX3Bhd/JKlXJ4Q==
X-Received: by 2002:a05:600c:4fd3:b0:413:f157:f677 with SMTP id
 o19-20020a05600c4fd300b00413f157f677mr40867wmq.0.1710777249558; 
 Mon, 18 Mar 2024 08:54:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiXmWWoTv7H8J64LEpM1ICL/VTft27EG3VZoED3c9XhofpHsdv19DqPZ+gIRJsKUby4x0FFA==
X-Received: by 2002:a05:600c:4fd3:b0:413:f157:f677 with SMTP id
 o19-20020a05600c4fd300b00413f157f677mr40847wmq.0.1710777249089; 
 Mon, 18 Mar 2024 08:54:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 fb4-20020a05600c520400b004132901d73asm15091097wmb.46.2024.03.18.08.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 08:54:08 -0700 (PDT)
Message-ID: <ae586f4f-9bac-42bd-ab11-5e82598aadb3@redhat.com>
Date: Mon, 18 Mar 2024 16:54:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: I2C controller is not user creatable
Content-Language: en-US, fr
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>
References: <20240318154420.220734-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240318154420.220734-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/18/24 16:44, Cédric Le Goater wrote:
> The I2C controller is a subunit of the processor. Make it so and avoid
> QEMU crashes.
> 
>    $ build/qemu-system-ppc64 -S -machine powernv9 -device pnv-i2c
>    qemu-system-ppc64: ../hw/ppc/pnv_i2c.c:521: pnv_i2c_realize: Assertion `i2c->chip' failed.
>    Aborted (core dumped)


and

Fixes: 263b81ee15af ("ppc/pnv: Add an I2C controller model")

Sorry for the noise,

C.

> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/ppc/pnv_i2c.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> index 4581cc5e5d4645ab3e358d983a633e33a214c425..37d7b3d68a98d88f201b9a297dbb18678ffdcec2 100644
> --- a/hw/ppc/pnv_i2c.c
> +++ b/hw/ppc/pnv_i2c.c
> @@ -559,6 +559,7 @@ static void pnv_i2c_class_init(ObjectClass *klass, void *data)
>   
>       dc->desc = "PowerNV I2C";
>       dc->realize = pnv_i2c_realize;
> +    dc->user_creatable = false;
>       device_class_set_props(dc, pnv_i2c_properties);
>   }
>   


