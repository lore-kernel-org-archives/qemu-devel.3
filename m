Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F094C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 17:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsmLG-0006mf-AF; Thu, 13 Mar 2025 13:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsmLD-0006lF-PR
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:27:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tsmLC-0000Wt-3e
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 13:27:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-219f8263ae0so24356695ad.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741886847; x=1742491647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ATruOCkF0QWbtTKDbxInXha+ratgIPIgoQXOoVwGoqE=;
 b=wQwP4Gzg0xnecol00JBbiSizROh1HBbWSxj77nEfK9L2vTO85uCZgup857IXu1kspo
 gtSsxFuyv+SR9rBVmd2EikjSIFRz1c/jaiXIu2KmzNVwueaBqZYr+8Y6rMlvbzutrD7I
 evbMoEbgoi0I9raClGt6h8R1Q1GQu/TGvcBpwjPWyKikalOiaxXaKWA8ffxBapMwV98t
 MKx/tchf6mRkSlg22uRS9LKuMPiBABpErVwjKNw7pG9FfR6jC8LFTqCx1QOFoU1KQi68
 CN770dIs+RfutUBQGDL4cCHxayALSrrmZjX5pfAg/QyeiA5s+Xix3KZIsOHVmpPXrlVt
 gQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741886847; x=1742491647;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ATruOCkF0QWbtTKDbxInXha+ratgIPIgoQXOoVwGoqE=;
 b=gtmdTjVsNDyyIu4bCJN7DAGI8Di7avdHAyQ+CO4Wt+3KH2aNqV6Bz1dwksQcAdCUWo
 eJTVva3gEQTLyqMvoFk6EamoV5Ay6BEFeoAHuaQuGJyXtbSWUXGISV28dUdIdjyzHq9d
 VTb7CHagZaZemS2OGUhdfHEThBpb6wXH2d1t43lccTdKN03OYT2IwTWglvyzqOCYpbf1
 HVn4vN1Mql+hs6qTsz0aHQCeyHbDQebyYqrhCdmS7OPpEnijqlT3WxNtBVFQkoLS90+s
 u+XEbdkJIhoXk2dLv5KSwVxLEcKXIA4T3CBIupNJgkfgl1SbPdXkyv3N+6PUp+4koqdZ
 m1Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtH65shEnzcz9Dr3TNh9t7enQgzyiK+295iInHtEZr77R/J/zQUVUcjsiCKcRsXzUgSdHFZeYTGWdw@nongnu.org
X-Gm-Message-State: AOJu0YyS3DoUBmAjxTbx/yY2dhupyAuB3HlBV7fYQT6KPdidGsGyAuLP
 u12jGzHm0Jgg+GHrsU1STgQzzJgEuyF31VGCwP/9pdsXsYh9GGYxkjQbyxEZusI=
X-Gm-Gg: ASbGncusA4oXS7h7feTr0DbPjC+0qYDJlRxv/o43nMNJeAJDysr6OpJZ4VRKnX1XPPy
 pwM5f0Xicun1Ap5GQUd+LFsMXmLke1nlfYtfTOzUliN9/w11W3HkuDr3zu5kUh4vZ5P+Sxv+VLs
 14Hh8VfS4rOGnqUwrVaM4NJaIDl9yAxBnpQDKVruITN6miNkzEAmc3u9OfciCEeVRpUwVUUNeXG
 s1L7+U+8F7p8/jzsBipFwLbG7lBe8hjyKoNik1jJagMlt1R9CY5iwDZDdjqiOnNQPc9+Ec2aCtY
 XS8vWPKW+cAGvNjvqvjBCA6KJ1ye+S1Xl+apCF0r4b2fqZfQ6hFPYvfz9g==
X-Google-Smtp-Source: AGHT+IFl5HgaOYGqPbl//LEAkdXqf03dMzrfGluSjQj60FB3VGhjhPTGTx/Gmy6V0OwQFMF3OfOdHA==
X-Received: by 2002:a17:902:e549:b0:224:249f:9723 with SMTP id
 d9443c01a7336-225931af3fdmr151537605ad.51.1741886847209; 
 Thu, 13 Mar 2025 10:27:27 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6913sm15910155ad.142.2025.03.13.10.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 10:27:26 -0700 (PDT)
Message-ID: <72ea3099-86a2-485e-ae25-867fe1aaeba4@linaro.org>
Date: Thu, 13 Mar 2025 10:27:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/37] accel/tcg: Remove mmap_lock/unlock from watchpoint.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-13-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/12/25 20:44, Richard Henderson wrote:
> The mmap_lock is user-only, whereas watchpoint.c
> is only compiled for system mode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/watchpoint.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
> index 65b21884ce..cfb37a49e7 100644
> --- a/accel/tcg/watchpoint.c
> +++ b/accel/tcg/watchpoint.c
> @@ -124,17 +124,14 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>               }
>               cpu->watchpoint_hit = wp;
>   
> -            mmap_lock();
>               /* This call also restores vCPU state */
>               tb_check_watchpoint(cpu, ra);
>               if (wp->flags & BP_STOP_BEFORE_ACCESS) {
>                   cpu->exception_index = EXCP_DEBUG;
> -                mmap_unlock();
>                   cpu_loop_exit(cpu);
>               } else {
>                   /* Force execution of one insn next time.  */
>                   cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
> -                mmap_unlock();
>                   cpu_loop_exit_noexc(cpu);
>               }
>           } else {

Hum, how can we link that today?
Answer to myself: a stub in page-protection.h.

Maybe would be worth to add a g_assert_not_reached() in mmap_lock, and 
do the small cleanup for concerned places.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


