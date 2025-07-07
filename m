Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A950BC8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 16:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYog1-00028f-6J; Mon, 07 Jul 2025 12:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYoe9-0001Ka-ET
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYoe6-0003C6-SV
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751905480;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73lHyK1dSG44+Alh6C1OepclZN6fdLa2QCegCfeT4fY=;
 b=CQ1/2RJRvemlFUMfVYDuFVdB3Zn1svc7iSMG3s88mrAE7YberzgFaVzx9agPCyIlVcPPcq
 C5T5V5Pkeko3etmnTgXAfLZaera1BBzc10xexikvYCebPakMP5bVVXqh8aLDl0qtwl0oSn
 0ijwgah8mglAuwZkjvm9MZtmFFzAUQo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-GLi10rytNeKhAFMoYqSTug-1; Mon, 07 Jul 2025 12:24:38 -0400
X-MC-Unique: GLi10rytNeKhAFMoYqSTug-1
X-Mimecast-MFC-AGG-ID: GLi10rytNeKhAFMoYqSTug_1751905478
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso2072315f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 09:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751905477; x=1752510277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73lHyK1dSG44+Alh6C1OepclZN6fdLa2QCegCfeT4fY=;
 b=O3ivQyJABbh+xJ3V8rMn5lYfRiVrpn1253OHf6MtyFZ4XvcRnHELuvmZ4mPDJaGoC+
 dvtZ6EQBmZpd4MKT0nroiVM67ZaWvtjPXtn6xdQhuqKbbauA1XNPhymaMNgVQWyhB3wS
 cKwi7VSGeBMQhOYk48UujFDfO/SIPm0zAWQ6ObmVNRWTShdfqTQUmRlGZBkFTQK0inYw
 zhHuLmXh1s3nUX1o0Tk/6vhnQJCCd/rEhz3XeEOf2+SLwVpRmS1OOUmMMx7Bss7+AtGy
 6T70fBKSU32ee7Popv+oR/KBj3CrKkAyyOex1AtC8rbcDNSIo0coCq0OzuGUASshRyXu
 86sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpjuoZw7QydOV4EJMSpRw/PR4yM28ztB5NH8lx3cURqV9A75BJhOmFhdXUWLRbby7P6KaLl7mlOuR5@nongnu.org
X-Gm-Message-State: AOJu0YwZNhjoqrONKFu457xbwVdM8m9yJmthTUIAW/XjkZByxNRf7uBC
 ISIwN0nERCF60NSHezoFzu771o2cq7vFGBaQwxSX1SDPIUEeAiu1hoVbh3tpYWWVLDxuZSDPbuw
 bG03FQ5yr30lzkWSAdWNZrVIhinUCNWniE2V4pXti+Bhh928GMGjKbMvG
X-Gm-Gg: ASbGncuW321iCWvll1v7Nb0WFdHCBDBx+8plc4+QR2LvafLuAo+a1oJP2ZB1ES7/SQU
 RP3EwxxfbwHxYM7sdde8rXKPWSRMKRfhAp1ep0YQNAHi8mxdVQXW1w+AyAbExQExyGZw7ogw9F4
 00CgnuuwvCYpWSYqgVwkkxXwY7yYsnBfMN1vvGLMsyb5T2ppWDmi5TxhW6QV2eebMVzoq2qCvC6
 bdMCS3wV8mknmXgNlh0aRRxHv+KKVaOrI404pMeLScFeYBe5fbnlscOPzzE1tpOnm8m0U84jcni
 +IZ8IqCyldu8DskeIWk6IDvwmoIhfY74rDnFvwqvPO++UuuFo5dNJMwHn5kzjcj8ePNOIA==
X-Received: by 2002:a5d:5f02:0:b0:3a4:fb33:85ce with SMTP id
 ffacd0b85a97d-3b49aa7c401mr7115412f8f.46.1751905477389; 
 Mon, 07 Jul 2025 09:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI6raxdqfK8LmtsOdU1aAvOjnTEQwFTyhU4US7BSI88R7puW+XH2lV1+X6iRfewDvgpsb5Bg==
X-Received: by 2002:a5d:5f02:0:b0:3a4:fb33:85ce with SMTP id
 ffacd0b85a97d-3b49aa7c401mr7115392f8f.46.1751905476939; 
 Mon, 07 Jul 2025 09:24:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b97708sm10793392f8f.50.2025.07.07.09.24.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 09:24:36 -0700 (PDT)
Message-ID: <8700d75d-677f-4aa3-b666-d249dcd46932@redhat.com>
Date: Mon, 7 Jul 2025 18:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/intc/arm_gicv3_dist: Implement GICD_TYPER2 as 0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Marc Zyngier <maz@kernel.org>
References: <20250707161018.585469-1-peter.maydell@linaro.org>
 <20250707161018.585469-2-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250707161018.585469-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/7/25 6:10 PM, Peter Maydell wrote:
> The GIC distributor registers GICD_TYPER2 is present when the
> GICv4.1 is implemented, and RES0 otherwise. QEMU's TCG implementation
> is only GICv4.0, so this register is RES0. However, since it's
> reasonable for GICv4.1-aware software to read the register, expecting
> the zero for GICv3 and GICv4.0, implement the case to avoid it being
> logged as an invalid guest read.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/intc/gicv3_internal.h | 1 +
>  hw/intc/arm_gicv3_dist.c | 9 +++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
> index bc9f518fe86..fc586524f56 100644
> --- a/hw/intc/gicv3_internal.h
> +++ b/hw/intc/gicv3_internal.h
> @@ -31,6 +31,7 @@
>  #define GICD_CTLR            0x0000
>  #define GICD_TYPER           0x0004
>  #define GICD_IIDR            0x0008
> +#define GICD_TYPER2          0x000C
>  #define GICD_STATUSR         0x0010
>  #define GICD_SETSPI_NSR      0x0040
>  #define GICD_CLRSPI_NSR      0x0048
> diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
> index d8207acb22c..a7d10ed9493 100644
> --- a/hw/intc/arm_gicv3_dist.c
> +++ b/hw/intc/arm_gicv3_dist.c
> @@ -431,6 +431,15 @@ static bool gicd_readl(GICv3State *s, hwaddr offset,
>              (0xf << 19) | itlinesnumber;
>          return true;
>      }
> +    case GICD_TYPER2:
> +        /*
> +         * This register only exists for GICv4.1, which QEMU doesn't
> +         * currently emulate. On GICv3 and GICv4 it's defined to be RES0.
> +         * We implement as read-zero here to avoid tracing a bad-register-read
> +         * if GICv4.1-aware software reads this ID register.
> +         */
> +        *data = 0;
> +        return true;
>      case GICD_IIDR:
>          /* We claim to be an ARM r0p0 with a zero ProductID.
>           * This is the same as an r0p0 GIC-500.


