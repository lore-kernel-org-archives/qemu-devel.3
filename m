Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE04CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 06:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9HTS-0006cS-8B; Thu, 16 Oct 2025 02:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9HTR-0006cJ-0y
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 02:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9HTO-0003U1-OO
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 02:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760596103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i4PnV6cWcgmo20pRHke0qzsNeh5N95FO7jrbWicY104=;
 b=YcKhvA4PAGa/Z6HeI7vXPN9NH33JPW5IAwX0pthpEfpvsS9rE/cBzObmcMAQ0NgpRIpW3k
 jQdvNA4Oca0KF3FOZRcnYNAnpcejMpz9169TNIBXSdDrY/XL4Pf+Y2VS1iWTxXmbt54ST/
 ziGf5qnwbBOsMWHfzyj/1MVj2R+0/io=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-ADmNbJqwOHitGrHUFrdjbg-1; Thu, 16 Oct 2025 02:28:21 -0400
X-MC-Unique: ADmNbJqwOHitGrHUFrdjbg-1
X-Mimecast-MFC-AGG-ID: ADmNbJqwOHitGrHUFrdjbg_1760596100
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e4fa584e7so836525e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 23:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760596100; x=1761200900;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i4PnV6cWcgmo20pRHke0qzsNeh5N95FO7jrbWicY104=;
 b=Cwk66bP2USP9GmIGHkTmpLDqJDJsWoQJvlYgox4vGyWh562RTWOixFs7L5SCs8qfCe
 kG5JtOYm7hzOw4c/4ZRNndUZCk6+fTYHECOcrmh76BVZY3F07b1x4DkrS3hBw2CP+LWo
 eqvzyTdVaV1/Newpn3ABKCmWmw+NBJ4PcdpiGJnERLxVkX9sq7jFwbm/va11xg+wT1N2
 NW/jSGasK0CJwv7k81SIL3CT37alKa7D5I0+bstZ/Rf+/Zp5rl37ZqsarknSr2cRNvpY
 ayscVIOwLy+h+N3wLO1sd+khyTM4pqr+l9LLTv+byIE7mW8fuDb+x9d0aiYAoOvy4CNH
 g1dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8NGheqePsYkkS9Q1gs8T832nrhIrPHyVrnwZqQHRdr4nAfF6TMXhahT7BAqvjT0rJ6j3FQPx4w/Jg@nongnu.org
X-Gm-Message-State: AOJu0YxnYoGiG3ps6vkFY6ic0sW78nl0iGY82W03tI8Db+6LH72whDI8
 Yf92uAGg7AkmkV7xpTEE0+vTW/hihuKrz8D6nQzLuOqj9K+FIuzN/Zropy5f5jGtZqeDxYcO65O
 MPvR2usRYjSCDZJUGtBKQLlak+pFPaFNUX4V68X1Nz/MM8u5cRvyUiBez
X-Gm-Gg: ASbGncvQFwGwgClO67fkgXbhTA/L4hLnPucwyTG5Xw/KAzTgLIh6JBJz84y6vOisvFp
 xfZ0lCMGe3lpCVNYKCkMqqmGCKYHlRNv0ljWbWK8OMOgAD+dNCCj6d5JGVVT+JqlqCHd0md1/TI
 CZMWHM4Q13xz8JN0NbUWFTVBsdwxeNo1VIUq1tr5Hq52LsUMaW/kJ0JSLKfkUowYR1f86LIlk64
 qL468KWVOiYxpM6MMNTBalaI5RWUwV3O7K0uGwfXc9CgGXlFVB2d5xrnLjNJsJDBlUSYC4Y/yCB
 oRLgQWfEVj/Eem3g31fFuRn6bKcyosT6M6LUdZjBRE7McU9VadD2vCZhGV6eeewWPoMLWLFUJW0
 EKJxtQeE2Id7lJ5cI7YoVBfB54RQarv9In+6DGPtB
X-Received: by 2002:a05:600c:8487:b0:45b:79fd:cb3d with SMTP id
 5b1f17b1804b1-46fa9b13ab7mr222271005e9.36.1760596100130; 
 Wed, 15 Oct 2025 23:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9EfBylUFgpNVIKgHOlByRWravXOSZtGoaQtyrJemc+PMUJz+FwyRQb/l3BvVxHzjIB2mPnw==
X-Received: by 2002:a05:600c:8487:b0:45b:79fd:cb3d with SMTP id
 5b1f17b1804b1-46fa9b13ab7mr222270845e9.36.1760596099716; 
 Wed, 15 Oct 2025 23:28:19 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711441f975sm6963995e9.4.2025.10.15.23.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 23:28:19 -0700 (PDT)
Message-ID: <181040b4-4bc9-48be-8c15-6fa069957243@redhat.com>
Date: Thu, 16 Oct 2025 08:28:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] tcg/mips: Remove ALIAS_PADD, ALIAS_PADDI
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, alex.bennee@linaro.org
References: <20251015213843.14277-1-richard.henderson@linaro.org>
 <20251015213843.14277-7-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251015213843.14277-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 15/10/2025 23.38, Richard Henderson wrote:
> These aliases existed to simplify code for O32 and N32.
> Now that the 64-bit abi is the only one supported, we
> can use the DADD* instructions directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/mips/tcg-target.c.inc | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


