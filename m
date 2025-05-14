Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DE2C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7pw-0000po-6z; Wed, 14 May 2025 04:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uF7pu-0000nt-J9
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uF7pr-0000pF-RG
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747212690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zhPRrMtUBmWDxJKoUJThtxUt/atF9EFXg1s4WY6TKro=;
 b=LfVRD5hOtWBwEoSF2+XOXUF9BnfjT/ePwmoHncFrvxgzKDsT/hwJj0zSwYws4trd2nczEa
 iQeHpKmVfmkjzJ73ZP0xoGHdi9B6ecfabFhA3bEWGKYB87Fgv4AEzKTkFuu9ah7np9gTpn
 6uVO2vARto/rEfaKKnAvektVZxQKh7Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-y-adSPChOA6EX9OtL1G6wQ-1; Wed, 14 May 2025 04:51:28 -0400
X-MC-Unique: y-adSPChOA6EX9OtL1G6wQ-1
X-Mimecast-MFC-AGG-ID: y-adSPChOA6EX9OtL1G6wQ_1747212687
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so29068665e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 01:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747212687; x=1747817487;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zhPRrMtUBmWDxJKoUJThtxUt/atF9EFXg1s4WY6TKro=;
 b=wivptYDKjPw7IuzCFUbSuemxXf7iwwdpzHjUqz3LoSTHjdsuCcwpxu8VgBSdDH+JCd
 o3JT6zeS0odDLMdrsm3zZeNH3an4/A4H/12fociASpwiq9gXRc6IZ87w6ryyDOvb1bSD
 Q6AeYre8JGhM9O6xEeGKXNPl1VXKksZol+/5V43wTkw9HUpA6bn2b2DQLN1umFlG9Qew
 dD9+M/KMVoNmtHI26zWXbiPPgzv9WrC2WqIHjE61hILxbp4G0PvatFp6N3V/6AtgWeud
 dmoMALzLwKZeV+GBvaQnVycbLxaU4R821Di57bbj2DlpdAQbg5awH0ZERbH2IYKyWgir
 OUqA==
X-Gm-Message-State: AOJu0Yx2ZB2vmh6Y4DoSwZvIjdtDPeSM+OhbRbCqay6eets6XL7994jP
 WrcqTgx2Q4gEpxRdjHMw33YS7XEgDD6omL8b4ZpcprQicUewSgVzIPjqElfNBFECtEOHdSSYVBG
 PsxWxy9U8pPrrVQZHYiKfCteg1OsZfINl1Wb95hvVVAeGjIpDd7Vu
X-Gm-Gg: ASbGnctYA5o4O2xsu0oDDkq3dJFvQuzo5Ng+/fGa9c4sveV6UZLT03kiGmmfOKvQMWf
 cd15nY6AOfwqbap3l7Gz+ntAdnBDEZKMiLfAFuPFIgXdip28PTEc28G5AfmTDXBytyeR5Ksa89/
 68cVp4LRJnkfsQXbiTv039GzyGCT2pjsp67tRZJdtt5z6lQS2Pd+lgbWyZUmWmdDGyBMAL3sXfX
 h1LMLFnFqbIUIwBKoOJr1m4s5e1hckXzUgNXz/e/VQxXbri4WPrwkrmCEqYF95+QJWqaSckNYb4
 D71XSKt4cGFflM9Jf2wkUB9XF3KR5UMpa49LoWDNy0YZbdIisddWh/jPdD3v6RGai839CIyoc8Z
 fWRxeh6NQfGXSg/5UwGo9HrUYOrWyKgfNcg11vlU=
X-Received: by 2002:a05:600c:1f95:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-442f20e85d7mr24297855e9.10.1747212687269; 
 Wed, 14 May 2025 01:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcvRc2j/kAByzWMTAR1Y5XArqLx0TykTmqK5eQ8cqbD9LA/j78vhFqPzBqxYIqCJPw4vlwSA==
X-Received: by 2002:a05:600c:1f95:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-442f20e85d7mr24297655e9.10.1747212686907; 
 Wed, 14 May 2025 01:51:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f15:6200:d485:1bcd:d708:f5df?
 (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de.
 [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2cf1bsm19149195f8f.72.2025.05.14.01.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 01:51:26 -0700 (PDT)
Message-ID: <e0146386-ccf4-44ba-b58f-0bb4d3317f89@redhat.com>
Date: Wed, 14 May 2025 10:51:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/s390x/kvm/pv: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-9-zhao1.liu@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250514084957.2221975-9-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

On 14.05.25 10:49, Zhao Liu wrote:
> The QOM type of S390PVGuest is declared by OBJECT_DECLARE_SIMPLE_TYPE,
> which means it doesn't need the class!
> 
> Therefore, use OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES to implement
> the type, then there's no need for class definition.
> 
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/s390x/kvm/pv.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
> index 2bc916a5455f..a4dbbcef7e08 100644
> --- a/target/s390x/kvm/pv.c
> +++ b/target/s390x/kvm/pv.c
> @@ -313,12 +313,6 @@ struct S390PVGuest {
>       ConfidentialGuestSupport parent_obj;
>   };
>   
> -typedef struct S390PVGuestClass S390PVGuestClass;
> -
> -struct S390PVGuestClass {
> -    ConfidentialGuestSupportClass parent_class;
> -};
> -
>   /*
>    * If protected virtualization is enabled, the amount of data that the
>    * Read SCP Info Service Call can use is limited to one page. The
> @@ -380,12 +374,12 @@ static int s390_pv_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>       return 0;
>   }
>   
> -OBJECT_DEFINE_TYPE_WITH_INTERFACES(S390PVGuest,
> -                                   s390_pv_guest,
> -                                   S390_PV_GUEST,
> -                                   CONFIDENTIAL_GUEST_SUPPORT,
> -                                   { TYPE_USER_CREATABLE },
> -                                   { NULL })
> +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(S390PVGuest,
> +                                          s390_pv_guest,
> +                                          S390_PV_GUEST,
> +                                          CONFIDENTIAL_GUEST_SUPPORT,
> +                                          { TYPE_USER_CREATABLE },
> +                                          { NULL })

I'll note that existing callers of 
OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES happily ignore the line limit 
and put it into a single line.

(which ends up looking better IMHO)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


