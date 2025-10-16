Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13518CCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 13:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9O3N-0007Ta-FD; Thu, 16 Oct 2025 09:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9O3D-0007S5-SM
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9O2z-0001eQ-Lv
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 09:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760621375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=txpfZzorlsjebwzyx5n4wV54IldZd3nTWHpgcrqFMws=;
 b=FI7+HaKMM3YPQ5wAWh2+B2+OiXWO384rIZfzd7GGAFkxbGN4oVQjy2Dk1zv5hCfg4pIWdu
 0ZZeMrpniARhYZedBmdt0QNXN91cwhXK9yC6l2YJpqUmoNe0A/7PGQ8MSAI8Ckbw4DVZvS
 2Zgv7CU1ETFHvDT+63s0OrzrL5AvaH8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-snXggyX5P1y-Ia_rs1Sidw-1; Thu, 16 Oct 2025 09:29:32 -0400
X-MC-Unique: snXggyX5P1y-Ia_rs1Sidw-1
X-Mimecast-MFC-AGG-ID: snXggyX5P1y-Ia_rs1Sidw_1760621371
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47105bfcf15so4571915e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 06:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760621371; x=1761226171;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=txpfZzorlsjebwzyx5n4wV54IldZd3nTWHpgcrqFMws=;
 b=Pxc/a8ms6FWD90LnHw2id+DDLhhtPnKEnJ4v1ali8hzGR6fQ1zKzjn1xUEi41lZFJ7
 Bt2GBrVifizf01Gz+6Ag//LhSzfxqw/DiPlOz6b9opYwpYBC97Gh2KjHKRu1JLlLIlW0
 jsweEbH8H6jOFa38FG+Otufj6p8Gzcwgma/Vsw7x2sxfE/0bhosWQrJFZJA8uIvjGEMp
 JjzVAomYuk4+jCg9k/4rOSyZzCFdWq/KVk5m9n339Qs71kHSfF89isaJ3NiISkyAYzpm
 gGCr8Pp0KSbrM6fxF1qtzW+uxdJahJicPLu0v9IMcbdzLy/3gbPjb4hQxWGEb70GWlPg
 fclA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7ARm9yEpUqSzglQuN8kQyy5PsJbUCFV3ZATJrWBT7y0nm0wULIsUEQADoMvTwIsIASyXSeSu4NduE@nongnu.org
X-Gm-Message-State: AOJu0Yw6Hk7jbaUtKlr9DDTbAMJeq83q5EaOHK0CdOPH+AJzBW1acMEO
 GJm4qKNOgTiKma/wQQxtEcamaI3l7dQIVdLf+eGh2//vIIQaCZ2NlsHqG2LvEZFsR8ivPHINgRs
 kFImCVKkse2RLzulBAJnmja63tce0w9+1GxRK9AgeETKqzwOUe2MmdJC/
X-Gm-Gg: ASbGncuRjnZXJDY6N+1obJqgX1LZOVZPPvNdEo30f9X6GtYCEO1ooVmnkTx70CuH8f+
 7AIpQ3RLdyc8WdTc3ORBjmv98nc6XVe4DO++xwbSifctBeDHvi9WT0+jfBv0HZWPEvgqVwbw7YX
 tWwK8dZnFw85Mrbe40KBnFxEk42Bx3IlFSbTjGI7ZJdlLPWqimAR8uvRd/TN4e8tJjHgRoJPdYi
 xSgejykBbRu/P01APgw/tWHIORxDbqOLZg7A8BpRe3PH/U6IBhN9Emis3ZFjskI/KmhI+JXky7k
 +p8zopWgj1zKgC8VaMfkjOGDdcgyYj/811IhL60pWX1kWk9FyStx1QveGoKwy+KeFlx+T3ZK2FQ
 oee1wiN/kuJXERXz8YaYb96QTV0fDwoIyAWua0Rww
X-Received: by 2002:a05:600c:4690:b0:46e:3dc2:ebac with SMTP id
 5b1f17b1804b1-46fa9afbb62mr223632875e9.27.1760621371439; 
 Thu, 16 Oct 2025 06:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcGqtzdt0SUXg5BC+IL7iCfcrXsrqiyGz8GBhuffySZd28kWc5xHx6+THVc1lRj1ilyXIB6g==
X-Received: by 2002:a05:600c:4690:b0:46e:3dc2:ebac with SMTP id
 5b1f17b1804b1-46fa9afbb62mr223632585e9.27.1760621371016; 
 Thu, 16 Oct 2025 06:29:31 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711441f66dsm26894035e9.2.2025.10.16.06.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 06:29:30 -0700 (PDT)
Message-ID: <dd902f81-0dd7-4c11-ba15-eb9af71ad2a5@redhat.com>
Date: Thu, 16 Oct 2025 15:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] target/s390x: Fix missing clock-comparator
 interrupts after reset
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20251016120928.22467-1-iii@linux.ibm.com>
 <20251016120928.22467-3-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251016120928.22467-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/10/2025 14.07, Ilya Leoshkevich wrote:
> After reset, CKC value is set to 0, so if clock-comparator interrupts
> are enabled, one should occur very shortly thereafter.
> 
> Currently the code that loads the respective control register does not
> set tod_timer, so this does not happen.
> 
> Fix by adding a tcg_s390_tod_updated() call to LCTL and LCTLG.

(I just realized that I mixed up store and load in my previous mail to this 
patch in v2, sorry for the confusion)

> Cc: qemu-stable@nongnu.org
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/mem_helper.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index f1acb1618f7..24675fc818d 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -1959,6 +1959,10 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>           if (env->cregs[i] != val && i >= 9 && i <= 11) {
>               PERchanged = true;
>           }
> +        if (i == 0 && !(env->cregs[i] & CR0_CKC_SC) && (val & CR0_CKC_SC)) {
> +            BQL_LOCK_GUARD();
> +            tcg_s390_tod_updated(env_cpu(env), RUN_ON_CPU_NULL);
> +        }
>           env->cregs[i] = val;
>           HELPER_LOG("load ctl %d from 0x%" PRIx64 " == 0x%" PRIx64 "\n",
>                      i, src, val);
> @@ -1989,10 +1993,15 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>   
>       for (i = r1;; i = (i + 1) % 16) {
>           uint32_t val = cpu_ldl_data_ra(env, src, ra);
> +        uint64_t val64 = deposit64(env->cregs[i], 0, 32, val);
>           if ((uint32_t)env->cregs[i] != val && i >= 9 && i <= 11) {
>               PERchanged = true;
>           }
> -        env->cregs[i] = deposit64(env->cregs[i], 0, 32, val);
> +        if (i == 0 && !(env->cregs[i] & CR0_CKC_SC) && (val64 & CR0_CKC_SC)) {
> +            BQL_LOCK_GUARD();
> +            tcg_s390_tod_updated(env_cpu(env), RUN_ON_CPU_NULL);
> +        }
> +        env->cregs[i] = val64;

That looks nicer to me, indeed, thanks!

Reviewed-by: Thomas Huth <thuth@redhat.com>


