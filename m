Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB83C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 10:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tetj4-0004Tx-QL; Mon, 03 Feb 2025 05:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetip-0004TS-IX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 05:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetim-0008SZ-4S
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 05:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738578627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UXZ9iexcLcFktU/hXRWYe8CKkwCjjIGpyQPrKy86dyM=;
 b=bAbHI7qU2zkCblnvJo2hzo8ArWTWxbYUg3KEYiYe+GUSqsaKQ3r7kSdf4S+iTae2FvPJjr
 Xd0TUjHWICa51xq9Y4mVLVjmyEviER0xcr8Iwm34rWhNOKcFJqyFJiD6uSJeBTtQ+pxQFF
 RfZ041D2t75BOgEr4g0iejMftf7aSPw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-IkHtyJOUPEOveNlioYHu1Q-1; Mon, 03 Feb 2025 05:30:26 -0500
X-MC-Unique: IkHtyJOUPEOveNlioYHu1Q-1
X-Mimecast-MFC-AGG-ID: IkHtyJOUPEOveNlioYHu1Q
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so36070295e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 02:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738578625; x=1739183425;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UXZ9iexcLcFktU/hXRWYe8CKkwCjjIGpyQPrKy86dyM=;
 b=DhsuoENM2OvwgB+uUrSzaCTKs5G0PPhXqY72fYYC+2hLL/ig1uee2SjaiHT55AHqeR
 8ukvIqRrGfk3QJtX10IOtJdR/cqdGwENNIvQealHaq7RHseQaMslQrKN7mdqKzBMuGRN
 Rrng17E0lffe3lakpwRBfE8uedZ6o9U6yp8wI2Y67tusa/f4knRV9VY5Rmm3UAOZLIlG
 YRCt338G4yvgxnMTwzk5McDRP62UvWWQKFRvobrhoxyhUJaG6WkK6IOR6dEQ56cdri94
 oCyok3I+n0RRB0d1eVJNIsnl0sRBjNPikO3BrmZ30tOCodnVW3FVPIc/bfpSaiS+siTO
 Gsig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr3huQHZbZO1t+LMQFtKnYA6gk8mVEKtkXcHYm7Esmatpq72yUeR+ySfZ01ivqUQP8Vg/TfyRcNOQy@nongnu.org
X-Gm-Message-State: AOJu0YwzRazFL82sztEArahUOCFJEiSxrac4oT9IZ0tO8ADLc2jDadYK
 3J1WwcxHEI86/7RBDKI4ELxQoJs0jTWM4H9MvSaOMeNZGCZpTKS2WUzF5W2muyWAZUeXQdsEYrV
 O9f+r0Ofg9vBvSwxdGw1UW+k6VwddYws+hKgj/LMpoyYnPOvRAcaG
X-Gm-Gg: ASbGncvFRtfyMDilUjNiI0EAZl/4Bfl344p2ktiAjDfzypOXDxM7+rfjRfFNE3OXLNj
 IphfAz338K2fVY7Rg+orY/Q5ZdLIb6Lt7uTyTPQ/u+BJwSBXiRyT2qmy+7qEpO2clGe0NSjviUC
 XSaoS5VErGzZoAY5Q++9D8FzJhwMB/ah/sEZ+0STYbdbBY7mazuZvjFapikBfhgUx2Uq5qU3n+j
 r4wd+WFj8BIdv7FVBBVdNbF1y2+fS5XXaKcFHhD9NdmriwgRyGdPCrnKLUNUC91FBBG2+D9WiZH
 e5nOXk3gME9VtsnHHZRJ4JrubESY5A==
X-Received: by 2002:a05:6000:1fac:b0:385:e877:c037 with SMTP id
 ffacd0b85a97d-38c51f8ceadmr21199571f8f.42.1738578624070; 
 Mon, 03 Feb 2025 02:30:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgEuq5CECqAC45rl/jF5MWUHLcgKrUYpVLHuHOJIyjJQgyYhVBNNOA6qPlkt8Sw+gFq4avJQ==
X-Received: by 2002:a05:6000:1fac:b0:385:e877:c037 with SMTP id
 ffacd0b85a97d-38c51f8ceadmr21199386f8f.42.1738578622260; 
 Mon, 03 Feb 2025 02:30:22 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b51e1sm12345494f8f.77.2025.02.03.02.30.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 02:30:21 -0800 (PST)
Message-ID: <7f51b6d2-0e49-4426-be38-2df8239046f6@redhat.com>
Date: Mon, 3 Feb 2025 11:30:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] gitlab: Replace aarch64 with arm in
 cross-i686-tci build
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-10-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250203031821.741477-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 03/02/2025 04.18, Richard Henderson wrote:
> Configuration of 64-bit host on 32-bit guest will shortly
> be denied.  Use a 32-bit guest instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .gitlab-ci.d/crossbuilds.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
> index 95dfc39224..7ae0f966f1 100644
> --- a/.gitlab-ci.d/crossbuilds.yml
> +++ b/.gitlab-ci.d/crossbuilds.yml
> @@ -61,7 +61,7 @@ cross-i686-tci:
>     variables:
>       IMAGE: debian-i686-cross
>       ACCEL: tcg-interpreter
> -    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
> +    EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,arm-softmmu,arm-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
>       # Force tests to run with reduced parallelism, to see whether this
>       # reduces the flakiness of this CI job. The CI
>       # environment by default shows us 8 CPUs and so we

Reviewed-by: Thomas Huth <thuth@redhat.com>


