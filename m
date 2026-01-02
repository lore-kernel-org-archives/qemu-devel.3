Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E0BFA3727
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 09:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbb7k-00068l-4z; Fri, 02 Jan 2026 04:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vbb7i-000684-S1
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 04:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vbb7h-0003i6-FF
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 04:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767344824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vEFMmNVwYXNq2YtMkBLuu0wmQ5SWNCghCHFruACUfoY=;
 b=C4PGmErNJPOUs8AzkmcUVYTw8T9KLkDNnJibWF+VIm+3PvzA5Dku586qeotB1HXZZ2+l6O
 jc2+wAQy9pAdY2x0KOJSl0o/+gEoO3p3iqrcP3Hbeb+guUbBhnLFgQuaWoX2IPcMybGlBn
 l6SkBLr3XG2IbNOPFumaiteJC8xwOCY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-JIX-ag-rM5mEVAMAO4i3aA-1; Fri, 02 Jan 2026 04:07:03 -0500
X-MC-Unique: JIX-ag-rM5mEVAMAO4i3aA-1
X-Mimecast-MFC-AGG-ID: JIX-ag-rM5mEVAMAO4i3aA_1767344822
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47d1622509eso72133585e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 01:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767344822; x=1767949622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vEFMmNVwYXNq2YtMkBLuu0wmQ5SWNCghCHFruACUfoY=;
 b=OmASvOCCiZ9hQVTJ8sCz7f4ksx3kiE1LcVQkp3srUYTO3F78KxuD0MJaX/t69d7oad
 yYOozvhf3Z4KA7rNGuWcAF7MSQyG1p5iQh1+IxASYOwjycM+8AOf1E9kiG3rE4m+UGGS
 KZZVXa4eE545d/P/q73JsgIzSbAaKJpNRAUvQa2HqANwTdagfT0EwpXU+O6K0R7J9Wep
 h4TANYhzIIEaDuLh1A2H0mqIVGAVcVuoReQHbRKF8rkbkinWQxQilF3zD2gicz7hJxCP
 m/nzwLIKBo0qzQIbWCjvzyNcdEiARhH8ahFUUjvy2HsnJrbigkEENVj080dL7Kbvqh6j
 ofxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767344822; x=1767949622;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEFMmNVwYXNq2YtMkBLuu0wmQ5SWNCghCHFruACUfoY=;
 b=KoF277x0xNB9/u8u+xRmHLNE+qsXNNF7qMeCJdZ7mNWVim7/NbXpXSZmSICab366C2
 SxCCl8s34nHPbN/L+E3cPAzeqcJWIzP3thJJps6rpkVidRrr3doUWYVLQ3w+mjpgH5TK
 26ywT8f252Ctv3C+E4nhYxX1XolIomfUZPLxQ3y2wCSCBt+wgGpN6hzvl89AlFjqNyHw
 xDLEQmGJkmpJA3EZQMRse8t45Sz7RvtK0oAAoLrZSuLVsbC+ZpDlkiIcwHCZbUoISoRY
 rUkHcs69z6fxdJS8jnVMvZR2zEGYv88MB5SkelM1S9lHbYYdG5lg08+Hk/clEUSrkOtW
 jr2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOsRwcN+Lrs2fGcHSWWqZdAvP5q9YN0OR2/UUI9ZE8S1YWP/MjqxZ+Zso2yy+TYM/htwcibGNkJHQy@nongnu.org
X-Gm-Message-State: AOJu0Yw8ZjW12HJdr2tJd13RZ+BimD3kfv/wDbsbQZ+IJqMT9fdJIvS9
 1V0wqA99ZU3PBCa2S8+d25bR4P4OIPcQ93Tb4+yLNuZZr0paLEJtw0mvnXipe9ZCKkpq8PealgI
 KhKhpkqitD9fpu0eVZ84dOmaZN9sXZc49CNXH1PPccdQIdKBRhiln78Xo
X-Gm-Gg: AY/fxX6f5hWc9b6q1esxoPmiUin1i+AUbX6jVD1LbWi6E9VdVLs6NHkeLByfDyAaAab
 tidQ0jv68TZ/HqK8oNeBeGXGKVa1NfFFwG2XNFLTQgN8PbqWHtCBblwA0dF5wCIW/eTjfZrSCGL
 2uuxfjYrrxf8oF/YS1gPGKQKqxQITS70g3LfF3kNZQ2OZnkR+vQgTdS+/BKfIgn9I2lELzuniSu
 TrJ73gRNYyaJP+0fFvzvsIheKqDg+8U1HtoC1ZWVsHP93JHQeBTwSEI2LGh3jWWSCWowQEOt/Vu
 rGZOcjgjmDzPWNzzOut6s1ptZfjbRhy95+rBq90qSNL5/tRIfcSgg3ZQUEoAgTksJiCZWUg/CKE
 SXt/XfoI=
X-Received: by 2002:a05:600c:458f:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-47d19592a3dmr477669775e9.32.1767344822211; 
 Fri, 02 Jan 2026 01:07:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+W1bpv/CicLFRZ3DDJQPUzPn0+fraZHM3/ps/PMtyUvODFfWs+Ss2hSG9gvwcGG4YlVkSTw==
X-Received: by 2002:a05:600c:458f:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-47d19592a3dmr477669485e9.32.1767344821798; 
 Fri, 02 Jan 2026 01:07:01 -0800 (PST)
Received: from [192.168.0.8] ([47.64.114.140])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a3ec73sm305363885e9.5.2026.01.02.01.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 01:07:01 -0800 (PST)
Message-ID: <5cb2ccfd-4c5f-45dc-bd15-cb64995f2074@redhat.com>
Date: Fri, 2 Jan 2026 10:06:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Add MAX78000FTHR section as orphan
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, alex.bennee@linaro.org,
 Jackson Donaldson <jackson88044@gmail.com>, qemu-arm@nongnu.org
References: <20251220173336.3781377-1-armbru@redhat.com>
 <20251220173336.3781377-5-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251220173336.3781377-5-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/12/2025 18.33, Markus Armbruster wrote:
> This machine was contributed by Jackson Donaldson a couple of months
> ago.  Its RISC-V core is not implemented.  Unfortunately, Jackson
> isn't able to serve as maintainer at this time, so add it as orphan.
> 
> Cc: Jackson Donaldson <jackson88044@gmail.com>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3efc943c9b..e91f9c4361 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -871,6 +871,14 @@ F: include/hw/misc/arm_integrator_debug.h
>   F: tests/functional/arm/test_integratorcp.py
>   F: docs/system/arm/integratorcp.rst
>   
> +MAX78000FTHR
> +L: qemu-arm@nongnu.org
> +S: Orphan
> +F: docs/system/arm/max78000.rst
> +F: hw/*/max78000*
> +F: include/hw/*/max78000*
> +F: tests/functional/arm/test_max78000fthr.py
> +
>   MCIMX6UL EVK / i.MX6ul
>   M: Peter Maydell <peter.maydell@linaro.org>
>   R: Jean-Christophe Dubois <jcd@tribudubois.net>

Reviewed-by: Thomas Huth <thuth@redhat.com>


