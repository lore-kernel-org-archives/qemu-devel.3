Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5519F1075275
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38nk-0007nW-DB; Thu, 19 Mar 2026 04:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w38nj-0007mi-0c
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w38ng-0000dU-PC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773909135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nE4FdSkE+MXKjJZ+6basvJb745kw5EQgJ71kQ++7VG0=;
 b=iFrrzUhPNXaZ2DI3oh5gWfuhN894eTWBkqJknOtuCXyQAotJmLz8H2LsKEnX03cxK+Ot8m
 VGJunMimcCTsMyeN7dNPEktDwWn8Fbxh6/BtpvJ+FMB+i7OCqG/0oeZVZ/jh5tn77XC9fQ
 4Q9RyXUWmyRm1cppFdrWrldWKKRnOo8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-nJTdwg4bOMewaouR-r03qg-1; Thu, 19 Mar 2026 04:32:14 -0400
X-MC-Unique: nJTdwg4bOMewaouR-r03qg-1
X-Mimecast-MFC-AGG-ID: nJTdwg4bOMewaouR-r03qg_1773909133
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-486fa35b005so5792895e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773909133; x=1774513933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nE4FdSkE+MXKjJZ+6basvJb745kw5EQgJ71kQ++7VG0=;
 b=LA8wmj5r7m/WuAsmrHfu52gUhyjmWKVrED50oHbUMWyiQnHI/KxzqtMxH7JgkVYaBh
 C07UZwgdOpOKglwL6ves1tfJt8yVjOv6R65z05mkgUvRVtefvyRQbmGTpng21O2GroKc
 L/3rIYrPP6DakWKWOqIIsB/fIYc5OGcXB5n3kXxoI043okAb7dQJ8mJXtyrvw9KB24J8
 v+qFBRTzZGQjeVLw5wcZ2850nyUb7qIPgdhquE4wk+yMykzvrZRR1Rqm268pTgcC7oTu
 wg+XLhUdYkHIeD+rFssIQ0CBBbVFEQVD1GG7bfCo3449JsULecuaGn3Hg+kxoMo+Q8ZT
 Y5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773909133; x=1774513933;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nE4FdSkE+MXKjJZ+6basvJb745kw5EQgJ71kQ++7VG0=;
 b=GgHwX50rW2d6wPAUQcdiyU3seoBX65nsj60BZVPlFabZWzoQ/MFIf8mzV4pTFOt6/T
 28Etzmes9/hPYM/MpbtIvwvpwHt8ubfTzsJu83StIfMmqP6urvCimeCcSIqBC2B881B4
 wR0iAbbENBYhw2M1+TCIBx5ELZpcXFURRw8krSiXYvrkeoKGBkrRGlgaHjCo0aqt8Ygy
 BOQYZOJUGOP/a8HdK5jJZZULKy0fTMXCYkT57S+xEtEgxYvNIafQM6U1bkDO0biLjV0+
 t6fugHSN6SYXVwXOS+Ioo42DGIc8MY1ineVXG05RklcLen3JSUkYs95ONlDEhm/zpj50
 XPJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoD8J0g+2x0S/q9YL4f/V86a1dw2b1dn2ma0bHYlannl4RmHZanjWf9+Nh0ev3UyRzikKWklww86Sq@nongnu.org
X-Gm-Message-State: AOJu0Yztf/MFvOpAQvhJ/fFlvRquRblrpXu1Y1JGPRJ8y3BYlofAY/Mz
 VM7sVxLKAdqcQ/LiHlGpSUiPZlXKRIARCEN/5gMVrV7IspMqZ48Hpg20qXk8Zcv8JCtDZK47d9x
 4rdQEPbJRAcxzuJMmrhkk6qWiubXx0T7h+/9aYK+S4LBvSdA8rYcVrBDQ
X-Gm-Gg: ATEYQzxwczWSveaHjMU2/KP4jflUA/9gsvH23qbtcRqx2J0CmW89FpqmjGMEJ9Z07vr
 m8P/HYOs6crzsVZr9x7nvMRRv1/F5H/mzSD/pb3OBGaPf/V0Xry9YrevLY5tCJsccNkS6MOU1bY
 ZE3425zF38EKXRyI9QIlmH757QTQqlQqLelV2Y+Ac2pI7TpEhgX4TiLcdE9Tr9Ws2CiPBdLeOYc
 YEddKmV59Y3ThLuHLW5qeZEqwKAMrVS7dZUKIuhE30LHqEPrWtdRVWpfvNBJUrttiEMEdhHXbb2
 Cujvw1TNkreUllxNSbVJuP2zDq9cW7yxPwHC1Tdr0x/Nd1/Efrpyi+myLz5HPe13METpZRHKnln
 JVWUg6bXzgG2ZSsiBnPPHh3jMEoMfPrb4hSbBUFRA4LmsNuepwhBL7tJ5mAAU
X-Received: by 2002:a05:600c:4e12:b0:480:20f1:7aa6 with SMTP id
 5b1f17b1804b1-486f44435a7mr102649505e9.21.1773909132704; 
 Thu, 19 Mar 2026 01:32:12 -0700 (PDT)
X-Received: by 2002:a05:600c:4e12:b0:480:20f1:7aa6 with SMTP id
 5b1f17b1804b1-486f44435a7mr102649205e9.21.1773909132230; 
 Thu, 19 Mar 2026 01:32:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fc61dd4asm12072395e9.14.2026.03.19.01.32.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 01:32:11 -0700 (PDT)
Message-ID: <1a90bb09-9141-4fde-a8c4-87d82664da9e@redhat.com>
Date: Thu, 19 Mar 2026 09:32:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/8] hw/vfio: eradicate CONFIG_IOMMU from sources
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-ppc@nongnu.org
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
 <20260318174733.1717643-5-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260318174733.1717643-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/18/26 18:47, Pierrick Bouvier wrote:
> This commit removes usage of CONFIG_IOMMU in hw/vfio sources, exposing
> inconditionally iommufd related properties, which are declared
> statically (in const arrays). The alternative to expose them dynamically
> is more complex and requires boilerplate to set properties at runtime,
> with set_* callbacks and added logic to check if iommufd backend is
> available, with no obvious benefit.
> 
> One possible difference is that user may see a different error message
> when trying to attach a vfio device with a QEMU not supporting iommufd,
> without declaring iommufd object associated.
> 
> Instead of:
> ```
> $ qemu-system-* -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
> qemu-system-*: -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0: Property 'vfio-pci.iommufd' not found
> ```
> User will now see:
> ```
> qemu-system-aarch64: -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0: Device 'iommufd0' not found
> ```
> 
> However, since declaring the iommufd object is needed, error reported
> before and after is still the same:
> ```
> $ qemu-system-* -object iommufd,id=iommufd0 -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
> qemu-system-*: invalid object type: iommufd
> ```
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/ap.c  |  9 ---------
>   hw/vfio/ccw.c |  9 ---------
>   hw/vfio/pci.c | 11 -----------
>   3 files changed, 29 deletions(-)



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


