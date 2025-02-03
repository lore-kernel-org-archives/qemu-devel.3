Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52445C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 10:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tetw4-0007IK-7M; Mon, 03 Feb 2025 05:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetvv-0007HX-AI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 05:44:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tetvp-0000wY-DK
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 05:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738579436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MDLBEa7dY2MCIvJO/+0DegNqssWVdj3I4JhsgtmQBN8=;
 b=hEJOaeNGkGw3WQCm5DFrFl2iFigMgBB+FA3ZfBi0Vz0p3+GU2xDgxkNIui1fgAwRqdeKIM
 hnrfsoylF/DK3nbdjN3ew2BImCSa431GSn8Z0baEoYyX1vWkc5j2DbSrXDoyA02D51980s
 2eSiQn/EMjjzqKBvWGo0LRRu7yWxd20=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Hj55uHTkNLK9OMBuyOs76Q-1; Mon, 03 Feb 2025 05:43:55 -0500
X-MC-Unique: Hj55uHTkNLK9OMBuyOs76Q-1
X-Mimecast-MFC-AGG-ID: Hj55uHTkNLK9OMBuyOs76Q
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4679fc5c542so80623171cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 02:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738579435; x=1739184235;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MDLBEa7dY2MCIvJO/+0DegNqssWVdj3I4JhsgtmQBN8=;
 b=hEq3wbHHtgS/m8dYuGgOL/6tu/NGOeVzGMPSUVnodLTZlyAlUrS7TyrYeWbVNmW1xB
 4QfH3OTHW2cnA26GlVH1Oq1qehp9i8ipo8fNc4omQ6OwIHAqfj48VnT4N7WHNi6WQJnz
 TM6yrBuk5vtHkTJUjYjwQhqk7Py/Iwfc4QrQCX5YGzx8XF/WM88V4+uWuU2CuvdEYmBA
 Fxm+kzBcbzu8yazYpPFBjCovDWt3nhgl5Shvt3EEffr+4MJ0+6/TrmDzvvZhD86cIKKU
 4uupfPZkQV8xZM/KRTrlUGfX0QBS4j6gMOpnJqQPS5KcELg8gSbtA2+6O8L1yMKZBhug
 CvAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU11TPPSIvHRSun2zCWR0OS8SUXSfc7bUM7Eai13uI046YNMPc4RnoB16W+D83qjwKd8o+dBDY3yWVl@nongnu.org
X-Gm-Message-State: AOJu0YxjxQ6Q8F6WRUD05SodKpMc9Uiz0D+OxkwCUf4yjIe18KOgaas3
 bR/KerkW5ZtvBIagPQlK2ObSSFQm+oA2FEFKQkxUd90Pq5WtS7OA1BYhCvOQVBWuE+kuV9HF+Zy
 9ND+vPC4NtMmnb8WYJXFBYtEM1vIRnabFBt3ln3Dlv3nhfeDBE2Rm
X-Gm-Gg: ASbGncu0kqM8WQAdhhX55dGc97Ju9N3DZtJqNcujKgpjAmkt1p1PB7Prn+pOHpZN0FZ
 YahTwKLw8cEhZCTM2IPbufMjysitDVqVM0Va5SxynTdWpWiuu0Q5F/pXtfRYSiBRVLgMxT8YDCA
 uTZx30aLgJv0tNdDr4LXFzMhMv9Ys6lJXbGmTywdOEek04mrnGDiiyfgTS6v8ZUqL2In6d7hsJZ
 ejlgiCOdGnEyIpw98O5EFsvXc/nv80AhMJDnatuYOQtrvaOEM1OxwTBO+dMCSM/fFRn9+K2jXav
 ry92jomfg5GbblhuBCG2Ik6wdF7VEg==
X-Received: by 2002:a05:622a:1995:b0:46c:77bc:ce57 with SMTP id
 d75a77b69052e-46fd0ae2a34mr305713051cf.36.1738579434966; 
 Mon, 03 Feb 2025 02:43:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmibxEJNUXLJfi2hn14mgLUakfcLbeSqsHMyQnzNzJzVaj/swzJBNDjcPeDBzDBpA038qcjg==
X-Received: by 2002:a05:622a:1995:b0:46c:77bc:ce57 with SMTP id
 d75a77b69052e-46fd0ae2a34mr305712941cf.36.1738579434658; 
 Mon, 03 Feb 2025 02:43:54 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf172372sm47272801cf.60.2025.02.03.02.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 02:43:54 -0800 (PST)
Message-ID: <6aad3678-778a-4e90-912f-d8f4f895ad6e@redhat.com>
Date: Mon, 3 Feb 2025 11:43:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] target/*: Remove TARGET_LONG_BITS from
 cpu-param.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-12-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250203031821.741477-12-richard.henderson@linaro.org>
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
> This is now handled by the configs/targets/*.mak fragment.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/cpu-param.h      | 2 --
>   target/arm/cpu-param.h        | 2 --
>   target/avr/cpu-param.h        | 1 -
>   target/hexagon/cpu-param.h    | 1 -
>   target/hppa/cpu-param.h       | 2 --
>   target/i386/cpu-param.h       | 2 --
>   target/loongarch/cpu-param.h  | 1 -
>   target/m68k/cpu-param.h       | 1 -
>   target/microblaze/cpu-param.h | 2 --
>   target/mips/cpu-param.h       | 5 -----
>   target/openrisc/cpu-param.h   | 1 -
>   target/ppc/cpu-param.h        | 2 --
>   target/riscv/cpu-param.h      | 2 --
>   target/rx/cpu-param.h         | 1 -
>   target/s390x/cpu-param.h      | 1 -
>   target/sh4/cpu-param.h        | 1 -
>   target/sparc/cpu-param.h      | 2 --
>   target/tricore/cpu-param.h    | 1 -
>   target/xtensa/cpu-param.h     | 1 -
>   19 files changed, 31 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


