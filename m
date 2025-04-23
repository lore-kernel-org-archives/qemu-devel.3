Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A0EC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UwJ-0007Zd-Gv; Wed, 23 Apr 2025 03:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UwH-0007YL-Qi
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7UwF-0004xa-TJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745394875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pE4vSNqmYzk8zkoouREDk9pbLmBvoAyDVmwPKJOQQdQ=;
 b=ExpZR6k3ZhNLc2mPAIMfC9iRHX5UbU1btPKJEw++yvkJJDlnd1jc12cC9a9LydKvpKOwro
 mxd/u5Nd7y5YDxXA+srOrIllMGaOmjZI6UElyX/uBLBQl/7fZPNIaI94GCZD4wymhQuWIZ
 JbJab/35peg6CjxCYZLC6QPXxdi4jKQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-eOSwV-CYPi6QhBTonFK_KQ-1; Wed, 23 Apr 2025 03:54:32 -0400
X-MC-Unique: eOSwV-CYPi6QhBTonFK_KQ-1
X-Mimecast-MFC-AGG-ID: eOSwV-CYPi6QhBTonFK_KQ_1745394871
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39ac9b0cb6aso3222995f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 00:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745394871; x=1745999671;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pE4vSNqmYzk8zkoouREDk9pbLmBvoAyDVmwPKJOQQdQ=;
 b=AozoV+Ogt1GkJMoQok0KZgtjE2jw9IEBVSV5T7dTCTbVEo7lz6eUfvIm8ebBnnojrg
 Kn3ZmgRIvLZZ/t/pHWNQfTsRL0yfxfeX9JPlhfAgFJqQav0tRibxB5yfJXU+bxuP1Jhd
 CJxMOmbK3tvvn7nefVHpWc0WLa2QXGuQwz9OxMLYSIUadTowfR5NZoCPKS8Dg5yEKEVW
 SnEevuup4jfktwctcV7VkG7E/yJ0WcIem8PID+VNMMuhzsL+ynaUOtTZWhcWd0nqzUBz
 Tc69N1WF4uxpeGFA6RrEDdqxYU+7Tb2szfeJpqJGPW3MXyYaCQA7MKGxV4YI0ICzRrHl
 OvRA==
X-Gm-Message-State: AOJu0YxcdLivHc0N3hkabzOhherguoTxF7YpsRLz7ZvfGGKnfPpWxsKF
 DtwwI1a7BQB2WS6IQPmHxRUbZfAV1bBKWEwTgCW4Um6d+jibvC2dgRC7SFdOwdJW3aTOdB2SvpQ
 WPP5FxQAb5KYbNN4sJlDZ6IWy1Viy+0av3+oItSXMAUEwAA97QRqn
X-Gm-Gg: ASbGncsQBx/JiXu1be9CaJA8MXf1RES83S8wEdjaAFcV1sug1YJp1Tv8xI34y4v8fUN
 KBca5toyQgHioQTAYhmmoegAdso1rWbJs3t0tO7k0CKSlqIgdKPIGJpiEY3mkklpPAgtwuGtnGG
 tMqI4azOYsxi133MWW9fU6+h8WiTmquRNjU5MDXuQaZl7UkqjRBc6KE9OEBQghTBA9oRmYpaqI1
 asXC1wPVEud2kpHjz6UI5Ue7A/DlurW2aXRDWh+qltEQGL/QRs1a1zzP3ksUno56GuS08JsBzhh
 yCtau7eyJv7v/ttvfRed+8TUIFlZyQSEqI3L
X-Received: by 2002:a05:6000:43cc:20b0:39f:fd4:aec7 with SMTP id
 ffacd0b85a97d-39f0fd4aed9mr3634699f8f.7.1745394871085; 
 Wed, 23 Apr 2025 00:54:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAsEKVdTVemx9M/YhyoWjCdddzHWAFiIMTW1YeR4HsDBcUS1NRHRMAIL8hipDPv0IpidsufA==
X-Received: by 2002:a05:6000:43cc:20b0:39f:fd4:aec7 with SMTP id
 ffacd0b85a97d-39f0fd4aed9mr3634681f8f.7.1745394870703; 
 Wed, 23 Apr 2025 00:54:30 -0700 (PDT)
Received: from [10.33.192.219] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408d0a7802sm27193065e9.1.2025.04.23.00.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 00:54:29 -0700 (PDT)
Message-ID: <18bb133c-629b-4ba8-96d3-159ffe2a380f@redhat.com>
Date: Wed, 23 Apr 2025 09:54:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] target/s390x/gen-features: Remove the v2.11 qemu CPU
 model
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250115073819.15452-1-thuth@redhat.com>
 <20250115073819.15452-8-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250115073819.15452-8-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/01/2025 08.38, Thomas Huth wrote:
> Now that the v2.11 machine is gone, we don't need the v2.11 CPU
> feature set anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/s390x/gen-features.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 41840677ce..150e4d1843 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -844,12 +844,6 @@ static uint16_t default_GEN17_GA1[] = {
>   
>   /* QEMU (CPU model) features */
>   
> -static uint16_t qemu_V2_11[] = {
> -    S390_FEAT_GROUP_PLO,
> -    S390_FEAT_ESAN3,
> -    S390_FEAT_ZARCH,
> -};
> -
>   static uint16_t qemu_V3_1[] = {
>       S390_FEAT_DAT_ENH,
>       S390_FEAT_IDTE_SEGMENT,
> @@ -1053,7 +1047,6 @@ static FeatGroupDefSpec FeatGroupDef[] = {
>    * QEMU (CPU model) features
>    *******************************/
>   static FeatGroupDefSpec QemuFeatDef[] = {
> -    QEMU_FEAT_INITIALIZER(V2_11),

Removing this from QemuFeatDef caused some trouble during testing, so this 
patch seems to be wrong. I'll try to fix it and send a v2 later...

  Thomas


