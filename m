Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50822C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJW67-00037D-Tn; Mon, 26 May 2025 07:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJW65-00036a-69
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJW62-000373-Me
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748259260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B+KJkczOlbOtglUFm5bDKvPq0s9V92C6PAETaX0VaH0=;
 b=AbysZG6EJdM5i2mczOJOyU4f8HpGkzQdFg3otHXBi+obDW4+dLmF8lksiFQ4IfqeBNRsKb
 fn2pTamkqlR+89ZNH4nh9JdNLYYXSsdE1uSEm5e5Mh/tVmzKcMCORCRv86BbO/zpyEuHOP
 2+aa8a5u4ubno3LviCpDxjbQeZhWqsk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-sN3gLiG1Ocej4PRj8hD0RQ-1; Mon, 26 May 2025 07:34:19 -0400
X-MC-Unique: sN3gLiG1Ocej4PRj8hD0RQ-1
X-Mimecast-MFC-AGG-ID: sN3gLiG1Ocej4PRj8hD0RQ_1748259258
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4bafbb1abso1379206f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 04:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748259258; x=1748864058;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B+KJkczOlbOtglUFm5bDKvPq0s9V92C6PAETaX0VaH0=;
 b=ImQ3azr3JYrLox82qOi5NsCWaI9SNoP5gA/P6iKjyx/Xsb6QZrGbp5biZhnvehFQYE
 F/2z8ijTsXfayfFhFJf9LsIiwGpOelR/5PmjMEDvD0jN3im9TgvVGRxqEzu+L6pIzwF+
 OE6Ki/KtP+XTDG5R3xWoVNyB8KS22CcDWJGUvDq5fAsILqUyKeKSIigPY1r6liv9MXWb
 cYDpBaW0CibPRyzIEQBFBWqHI5q7mcTBmtweE7AEbDmLBU18NQfl6x3geQGmwxMvpw1q
 maS26Fb8Jn4pVG84WfEfNx1ZQxgxoTsmy7WVdxlmuygSXrK7LfR+XZF79p0JFamLGgv0
 lYtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzAu10i6fNcgKfT5Cq7Ttg/43mJpO7FJeEViYwcz/QGfkuqreh61mxXM1ozqfa7I1il+JQeW51Zn6V@nongnu.org
X-Gm-Message-State: AOJu0YyOjC4IwGNTXzUMtHw5E+ReZCCgdJa7lAaSf2LrznQbPquyRcLW
 KFS9GmbqUCBd89+ipBO3MY8D2+hpMA3/pDPJOtwjlq6AAeBD5IASlbZRd0xEldJ6rcu1bnHvyag
 jALbjgQeHWXPHlCmBQvx+pZpsrhXCYCAkVtEpxyUgvt0xXG1CiQyUOvqFsd3Byk3NDe8=
X-Gm-Gg: ASbGncthkiw5XSAFv/OkSPu+ghu8qoH0IccyujaiutSBCiQKDW2V2T06nA2nVPV9m7e
 f60LDoOLVpdj6DuBthljL7CeqwNRWkLM1xZVgwycquyHP2cfxCPGjdWcBENF6QJpYcNpSTotL0a
 MkX1QpWFsmGtZWtr/KSrVsp77S8ysFg5UQU8VCZMN0AAX74Jnfqg4aYu8rsAfdDbhrXEMSC1Doi
 h1xhGCBbfbqxXoP4ragn/k7BUneHuf9Mr2jsYwVPUXBSHs6T+IuMsW2Pd9ssoS9horQxZsbipOm
 Df/HH/e3ADhco/eF2HwxVQT5eLk6td2RSp3I
X-Received: by 2002:a05:6000:2f88:b0:3a4:d0fe:42b3 with SMTP id
 ffacd0b85a97d-3a4d0fe4f1dmr5837541f8f.26.1748259257725; 
 Mon, 26 May 2025 04:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQR9AUlPJjusFwfUZdG70ROmMmTX5TnKSJqeICikx6wzENUPR2t5qn/epgj1tTknrFTD0uog==
X-Received: by 2002:a05:6000:2f88:b0:3a4:d0fe:42b3 with SMTP id
 ffacd0b85a97d-3a4d0fe4f1dmr5837520f8f.26.1748259257382; 
 Mon, 26 May 2025 04:34:17 -0700 (PDT)
Received: from [10.33.192.219] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5a84csm34968978f8f.31.2025.05.26.04.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 04:34:16 -0700 (PDT)
Message-ID: <94cf7838-9daa-4238-a842-50d8b184a1c4@redhat.com>
Date: Mon, 26 May 2025 13:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/ppc: PowerNV machines expose a I2C bus
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20250526112346.48744-1-philmd@linaro.org>
 <20250526112346.48744-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250526112346.48744-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/05/2025 13.23, Philippe Mathieu-Daudé wrote:
> Since commit 263b81ee15a, PowerNV machines instanciate
> a I2C controller, so expose a I2C bus. Express that in
> Kconfig, otherwise we get a configure error when trying
> to use '--without-default-devices':
> 
>    The following clauses were found for PCA9552
>        config PCA9552 depends on I2C
>        select PCA9552 if POWERNV
> 
> Fixes: 263b81ee15a ("ppc/pnv: Add an I2C controller model")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index ced6bbc7404..0d017df83ee 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -29,6 +29,7 @@ config POWERNV
>       depends on PPC64 && FDT
>       imply PCI_DEVICES
>       imply TEST_DEVICES
> +    select I2C
>       select ISA_IPMI_BT
>       select IPMI_LOCAL
>       select ISA_BUS

Reviewed-by: Thomas Huth <thuth@redhat.com>


