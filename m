Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5BBC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkIfi-0006ky-Ge; Tue, 18 Feb 2025 03:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkIfg-0006kb-Su
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:09:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkIfe-0008CZ-Ve
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739866173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ruSUnBPTy2QjqtparPthdvTIbUB9xMxEdQ4Eirr+oj8=;
 b=Zl6ytjD44uSVLqR8zrrd5zQ8nzVycyA/ZxyMAH0el8o+KC/tk1715vhurZSGAmEyW4eZCH
 Gj/MllKpM/fVh0ezVIglnzBTrvnL39Q7/sovgd/eQYif/v+7jKcNTD1rEZL9nHjcoLGO8l
 qzMZN25QpanpnyeKK7sVLCuoGKYws6o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-HTtQ7Qu-MPWU0t5Sy8QmSg-1; Tue, 18 Feb 2025 03:09:30 -0500
X-MC-Unique: HTtQ7Qu-MPWU0t5Sy8QmSg-1
X-Mimecast-MFC-AGG-ID: HTtQ7Qu-MPWU0t5Sy8QmSg_1739866170
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f31e96292so2700207f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 00:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739866170; x=1740470970;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ruSUnBPTy2QjqtparPthdvTIbUB9xMxEdQ4Eirr+oj8=;
 b=XaqhPxPNUBTLE8PX7QZ8XIi/ikCdStpZ4/n5X8RFhQmHg2Uypp0hVibd9uVr32Mg0E
 DtMZds3hgxIedcts0yV44VZXJmWelqcBaqf9+sHlcoqtwC+rywmtho1Z7TSqpT+vnn/0
 RF0F4RFdDMNMAv4dw7+cQIiHw3morbJuyYj1oTk0ewpnT44N+Da4fJUC8VN+HDiAsGLS
 QPLmb9lIlb7s4iswappx+gMt6FymzZSuDJJ7xl2vaGYf77+1C5arnt0BVsBYBAycEKLW
 vgRfcOKwx3UaS8aSjpXy8Uqdq2AR8s31zWrQpWsR0C2/xjFtVpwaUx0RWLJxHr69Cd1l
 Hpqg==
X-Gm-Message-State: AOJu0YyUst8DDrK98wcDP3KxpTQbio8l90Do2qYY27MmTSycT1ZzCRv6
 2CHPShDBcba8OaSus2M2VTRyC38DxfHJr53LjY8SZEPlv2SsV5U0ZVDEQ0i66S0bUgECurv8ccj
 ZTKXMvQlj6mpmkRGDJKEyFvCDzQocvD94M40X+PdTw4RT0/MuaMTu
X-Gm-Gg: ASbGncu+PLU4E7aHU+w71of23rH2Mx6qDN5P1c4wZSw1cXaJz2n8f5thFIyZS7tO7Zw
 EynznS2kkF5IiX2OHarxmsq0kD8wH6+Ts54aaYotjOkTL+pemnINbmus2FbA54rmVGp6mB6Wmar
 McUTZ51NiG86dOA03IyHMG0KMmEgB2UBb++lI87/MJPlkqyHlPD7VdJVwIMmocnkSJdTD69mimD
 alWJBGdb45/omQdVYAdR7qVvQn12tE0ANFCqn46CbYKXTgf8cMT2DMxMhg1Ey52sRYJrSwa4F0k
 CW4J8P7ZHuY=
X-Received: by 2002:a5d:5268:0:b0:38d:dc57:855d with SMTP id
 ffacd0b85a97d-38f33f4388emr12360891f8f.35.1739866169717; 
 Tue, 18 Feb 2025 00:09:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz4GCumN0ygWwAE2ynBvmNef2hCjNdDARPvi6qiaojrmE84MTlKkO+fQj4GIsVX0Rl6gvqDg==
X-Received: by 2002:a5d:5268:0:b0:38d:dc57:855d with SMTP id
 ffacd0b85a97d-38f33f4388emr12360867f8f.35.1739866169361; 
 Tue, 18 Feb 2025 00:09:29 -0800 (PST)
Received: from [192.168.10.81] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7b68sm14048295f8f.85.2025.02.18.00.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 00:09:28 -0800 (PST)
Message-ID: <e43f8169-4017-4a3a-9274-4daf9919c290@redhat.com>
Date: Tue, 18 Feb 2025 09:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386: Fix the missing Rust HPET configuration option
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250217154416.3144571-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250217154416.3144571-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/17/25 16:44, Zhao Liu wrote:
> The configuration option of Rust HPET is missing, so that PC machine
> can't boot with "hpet=on" when QEMU Rust support is enabled.
> 
> Add the Rust HPET configuration option.
> 
> Fixes: d128c341a744 ("i386: enable rust hpet for pc when rust is enabled")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/timer/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index 9ac008453408..c051597180f4 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -13,6 +13,10 @@ config HPET
>       bool
>       default y if PC && !HAVE_RUST
>   
> +config X_HPET_RUST
> +    bool
> +    default y if PC && HAVE_RUST
> +
>   config I8254
>       bool
>       depends on ISA_BUS

The config item is already declared in rust/hw/timer/Kconfig, so it's 
enough to do

diff --git b/rust/hw/timer/Kconfig a/rust/hw/timer/Kconfig
index afd98033503..42e421317a5 100644
--- b/rust/hw/timer/Kconfig
+++ a/rust/hw/timer/Kconfig
@@ -1,2 +1,3 @@
  config X_HPET_RUST
      bool
+    default y if PC && HAVE_RUST

I applied it with your commit message.

Paolo


