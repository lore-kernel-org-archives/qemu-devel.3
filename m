Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A65CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v919S-00019I-9d; Wed, 15 Oct 2025 09:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9190-00015L-S9
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v918q-00004t-3O
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760533323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0npyJLISO76kvDHPooeK9oSkbv9T7yyefG98H+EuioM=;
 b=UnsyktMXBr8DAxL+1V30G76jV0fPrMYPWoiWhZyLV5XE3Hs7b1L95l2bDwj6x3+Ukp+BFv
 VwF7y4rUjGEBVAHwlcLcLm58crgbv/1S0zwqh79d16TSMdTOLgnC9SiePpGRSfCWQEu1Yi
 EjMsnhVnNIPqjR1cOJddKlbwrfTr5ZI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-v9U_mc7tPG64YXLK-rcxEg-1; Wed, 15 Oct 2025 09:02:00 -0400
X-MC-Unique: v9U_mc7tPG64YXLK-rcxEg-1
X-Mimecast-MFC-AGG-ID: v9U_mc7tPG64YXLK-rcxEg_1760533319
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47108163eeaso1191145e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 06:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760533319; x=1761138119;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0npyJLISO76kvDHPooeK9oSkbv9T7yyefG98H+EuioM=;
 b=mNmuSoTgZtMIjwxzhAxxuPfNijaCAnkyQ7HCsurT6g5NY5+QSeQ6+kQlSiacRhAUtS
 bsRsWSW0whadN+GwRQaPXJbkknIpi4DBue6UmXeLm3nSxiplZKmE2rl4lV2lu2PR34d4
 fhyyOjD3+OqcbBvwKxJc5ERXfKUqRF8n3tmnAKXZ3Y7LUDCi6x7/G1lPllO12csdCAES
 Zv1PgDIsoji2h6ZZlVvQZAsuzXIfZix7bdPsNTgiBvKTe6nE7/6BzhXGjim5PAqUsoVl
 dWPRznYZG1Sjn76uvmbGwGqeb/vu7hYykf/sGPPn5ri4IZa8ue5w/5YlIcJ/yaxJHl/K
 yKWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw2xwffDEsv7q3xanXRzOBH1JKAeRIqfMhdiSiUWKrrhHjJLmRO7J6vZzXsbCLw5ahMsqJbBuHIQDu@nongnu.org
X-Gm-Message-State: AOJu0Yx9xrO6K4jSNSJUJ3ciduQiYdHWf94j/+D7JlOlEa6jD5gufukt
 FzwWFxijEb862vvpxWsk8KKESRArc26pAZDtScvuFVXGn2RDyjGsAQ6xLPY5jBlD4HdYCvmq25n
 3QPLsP/wy9LqNSFBxQJJ3pegthb2GqdjvWfnsSJT7wNzzacy2bna12m8x
X-Gm-Gg: ASbGncvbvRgYNbXCFpjLluCyGttplXIUDlf5OobmfYn2zv3FIKyp6ZUljsglTc6O9iP
 xSaesT32aTms3XQMxsKWBtNVYhrBpq4GUBM/dXp929TZhCb96HOBAB0EEAF5U1kWg9iNxHqunMc
 cAyJuoxHl9hXsiVPqwogjjbPDJW7bwch3V7RO/Oqe9e2CV1FEanQ7W+7fhd4Zq8b35qNyd/JBgd
 aAsXBM4io1DFcCMs3nkjxKkfjk6389Lv48JSlOSDOlVvCuISxss7TOMn4hKldNsA+3H0RJJnDro
 LRpd8vuE7ASvHHm8+f4pWBlL8qO5FdfplBvpCZj2RCfOCbTCcqlE4/q252+34ktjoETKbNB3w/3
 ZNfTarA==
X-Received: by 2002:a05:600c:6383:b0:45d:d353:a491 with SMTP id
 5b1f17b1804b1-46fa9a8c425mr188850545e9.1.1760533317615; 
 Wed, 15 Oct 2025 06:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmx32PKiTUs5nn454l/69k9YxCKjFGnw/wWOFYhKPIIc7ZNF+PvJdmEZPdgEMHpjH96quU3Q==
X-Received: by 2002:a05:600c:6383:b0:45d:d353:a491 with SMTP id
 5b1f17b1804b1-46fa9a8c425mr188850025e9.1.1760533316861; 
 Wed, 15 Oct 2025 06:01:56 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426fb279857sm458195f8f.20.2025.10.15.06.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 06:01:56 -0700 (PDT)
Message-ID: <50a337de-3ef7-417f-9792-e1c580188274@redhat.com>
Date: Wed, 15 Oct 2025 15:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/s390x: Fix missing interrupts for small CKC
 values
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20251014160743.398093-1-iii@linux.ibm.com>
 <20251014160743.398093-2-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251014160743.398093-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 14/10/2025 18.05, Ilya Leoshkevich wrote:
> Suppose TOD clock value is 0x1111111111111111 and clock-comparator
> value is 0, in which case clock-comparator interruption should occur
> immediately.
> 
> With the current code, tod2time(env->ckc - td->base.low) ends up being
> a very large number, so this interruption never happens.
> 
> Fix by firing the timer immediately if env->ckc < td->base.low.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/misc_helper.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
> index 6d9d601d29a..afcf7688eda 100644
> --- a/target/s390x/tcg/misc_helper.c
> +++ b/target/s390x/tcg/misc_helper.c
> @@ -199,11 +199,15 @@ static void update_ckc_timer(CPUS390XState *env)
>           return;
>       }
>   
> -    /* difference between origins */
> -    time = env->ckc - td->base.low;
> +    if (env->ckc < td->base.low) {
> +	time = 0;
> +    } else {
> +	/* difference between origins */
> +	time = env->ckc - td->base.low;
>   
> -    /* nanoseconds */
> -    time = tod2time(time);
> +	/* nanoseconds */
> +	time = tod2time(time);
> +    }
>   
>       timer_mod(env->tod_timer, time);
>   }

Yes, this looks right.

Reviewed-by: Thomas Huth <thuth@redhat.com>


