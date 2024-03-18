Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1470DC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFJQ-0001wR-3C; Mon, 18 Mar 2024 11:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmFJM-0001vw-Ih
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:54:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmFJH-0000Vs-0e
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710777236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VKp46MdrvPXV9opIc4bNA8CPYHEh5tnkpRdL7EDJ3/g=;
 b=gDEM80o9giNvzYxgTgExI0hQ+E2Wl7UJDZ2fMgsIFWsscG547qSl3o2+icn3Tcl2y5QsEJ
 PHXt2vkFWe11uFs2gd9pa1Fu/oFnFZc/Y20odek3jmibZC7bEOlioWDLYavGKLCass15pd
 WPrwkwkU93FuVOkGeARZsFxp231mVAY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-GUov18U3PsKFx4OVz8S_qQ-1; Mon, 18 Mar 2024 11:53:55 -0400
X-MC-Unique: GUov18U3PsKFx4OVz8S_qQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34176bb228dso425072f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710777234; x=1711382034;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VKp46MdrvPXV9opIc4bNA8CPYHEh5tnkpRdL7EDJ3/g=;
 b=VCWThwcdsoicovd9YLSW/0vHTlsGIXEvQq1tciVGTETwp03C4SmtVBrXP3GRyb8JE0
 lgwB/1SNHf+HeFCHpeaqySpChf4t1uk0nMlBG7cfwjbLL3HWPLGRJ1kJh11ElXKVpILw
 UJ9vnefE1bPDoiD+okb6JTDfEGNkL/VevOdiRBQMlf3wBGrWXh1KiOcB+mo7Ji8TJu7x
 Md4SYKMies+2cpo0RJf7PemYZ/xHfGAnCTZP9j0qhI3txmLlzF8BaCTAfnOaNzBG8iTc
 G4LjBaQANxOQ9E9Bg3a0D1jm9jWWqSlKBPp4CxNzT3qQ1vw0F/+w3x+yA9QuACXKzntM
 5LBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCzxiK5kfokjJ5XeFLMakY2fM4XLT6oFoX6d2xAEOvY2FJwahs+nWCXDXgQbfAKCrkw/VBsE6KVsn+wtmM/EkKHvobuUQ=
X-Gm-Message-State: AOJu0Yw09iTyXBs9YVhYF99nA1d3VgjzMbSzBEsPHx8EtGCaUZEy86DP
 tr+0LR+nlsustF9OdBWvY+OADnQ70JkyV4TVIMsrfSwYk7NFywKLeG2rxDZy07UK46Z1RRatBmi
 8DlNMYrthvwkjizW4ZD5LbaU2vXuqfzrGd9IxKnc4Hz2cpE1Lmgeo
X-Received: by 2002:a5d:58d9:0:b0:33e:c604:dd50 with SMTP id
 o25-20020a5d58d9000000b0033ec604dd50mr8243258wrf.51.1710777230350; 
 Mon, 18 Mar 2024 08:53:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt8UXjMLWO+S4H0SMH3kcmdEk8PriLexATjthDXvXlZLAcftt3Oe7TvNIKo2n8CuhWYlUDtw==
X-Received: by 2002:a5d:58d9:0:b0:33e:c604:dd50 with SMTP id
 o25-20020a5d58d9000000b0033ec604dd50mr8243245wrf.51.1710777229996; 
 Mon, 18 Mar 2024 08:53:49 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-176-251.web.vodafone.de.
 [109.43.176.251]) by smtp.gmail.com with ESMTPSA id
 a18-20020a05600c349200b0041413d11838sm1872323wmq.26.2024.03.18.08.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 08:53:49 -0700 (PDT)
Message-ID: <264f2738-6766-4611-95c2-8341409539b2@redhat.com>
Date: Mon, 18 Mar 2024 16:53:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: I2C controller is not user creatable
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
References: <20240318154420.220734-1-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240318154420.220734-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 18/03/2024 16.44, Cédric Le Goater wrote:
> The I2C controller is a subunit of the processor. Make it so and avoid
> QEMU crashes.
> 
>    $ build/qemu-system-ppc64 -S -machine powernv9 -device pnv-i2c
>    qemu-system-ppc64: ../hw/ppc/pnv_i2c.c:521: pnv_i2c_realize: Assertion `i2c->chip' failed.
>    Aborted (core dumped)
> 
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

Maybe add a comment in front of it (which is good style for setting 
user_creatable = false):

         /* This device is part of the CPU and cannot be used separately */

or so.

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>

>       device_class_set_props(dc, pnv_i2c_properties);
>   }
>   


