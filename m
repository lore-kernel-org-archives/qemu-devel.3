Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997DDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 13:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2sld-0002YA-AD; Fri, 03 May 2024 09:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2slb-0002Xh-Rt
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:15:59 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2slU-00026q-Nd
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:15:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f450f43971so224069b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 06:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714742151; x=1715346951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3r2UsCbl1pjB5ghw8OOKO21wDRMjUTv0dCjpAQXQIoQ=;
 b=LS+yb93xBlyQfkHlS0ZzwGolp7JBJRHx5oADKhBGGUxhBhO8DukbTccPEYp1+1dmDt
 RPHnSx8Goo3fOz4eEgWci/B05JXSdIG9rWMyel06ugIJFf9/ozHOV9x2AXvjvHlRD6yG
 /kBJgqGKRLQJen/s5xs2KCYC5NIeb5yQywV6u8TeRG+GH2WI/IwoWWI8QJ3l9j7HapFr
 yia1AvEJ7ZKhP2BZAHJuLz2KxdRb7fFv/JFE8uT19O97zxldlzDgMdDyJGDi/9OyMHKN
 D4xigxCmDktkdK1kkMFQG1ANCLIhSMG6DraxQqo5rXqtdHVGX4JmJHh3+pDRMFLNvWIo
 wsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714742151; x=1715346951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3r2UsCbl1pjB5ghw8OOKO21wDRMjUTv0dCjpAQXQIoQ=;
 b=XHxx70lZXELIJsBM/zmujcv7EdRvOLL3ky/mJ2JR5vDVvePUPOWoYfriACHboNx6Sg
 tjpIgWFSsNFTI+4xkYJk7Qe6YdlQOhFHWQfnz7zMY3q1TSfkRedDUS9e06g3kh4K1wP0
 f3MS4zFLQ31k9Oi4cCp6MUu9Han1fS64j0GOFz//HnWtBPfnolKDsNbFO9vI6qTQNiGd
 hkvcMKpGtFtoanjV5Vb4cpWQVqm2ZIor4VHsvbyBZ7eRQ6bfdnrBjHEgaghUZ6C7O5Lq
 QEVOOuofsFM2IyPAoN35DIgBjZJ6APi06J2ohKavIgAY0c12N7xhIxRW5o2CYuDak6ua
 ZRmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCgLCYV4aioGtEbiQ60hHsHefazWtuoj6a6FOP5MR9pjblvIwhFnp+CEyjqLW+4B9ccpTp+s2EI6Z8ZkcNareYTSos7OY=
X-Gm-Message-State: AOJu0Yxk4OxVNQh7WS7h1GTFvrTp/g92n7QtKsqHLCvUsDro9Cncnaxd
 bLvz1lna70R2lxfzKXdSOdEMXdDVS3IQZePdj4Jj6T0ixuo3k+vSWGJzBy2W4YI=
X-Google-Smtp-Source: AGHT+IFYxkjxZsYPclV1iVxdlLvJYyhr4V7GzNM3AnBeFnkzc8hpBFmI/FRje7rMSTg1w1ChrscUCA==
X-Received: by 2002:a05:6a20:748f:b0:1a7:919f:2b60 with SMTP id
 p15-20020a056a20748f00b001a7919f2b60mr3138161pzd.37.1714742151224; 
 Fri, 03 May 2024 06:15:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020aa78245000000b006f44e845915sm944530pfn.74.2024.05.03.06.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 06:15:50 -0700 (PDT)
Message-ID: <bc36cf5c-45d0-45a0-adb0-801b6ec61c7a@linaro.org>
Date: Fri, 3 May 2024 06:15:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: skip m48t59-test if the machine is not absent
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240503085104.187538-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240503085104.187538-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 5/3/24 01:51, Paolo Bonzini wrote:
> Together with the series at https://patchew.org/QEMU/20240423131612.28362-1-pbonzini@redhat.com/,
> this allows adding sparc-softmmu to the target list of the
> build-without-defaults CI job.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/qtest/m48t59-test.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

s/absent/present/ in subject.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/tests/qtest/m48t59-test.c b/tests/qtest/m48t59-test.c
> index b9cd209165a..605797ab785 100644
> --- a/tests/qtest/m48t59-test.c
> +++ b/tests/qtest/m48t59-test.c
> @@ -262,11 +262,12 @@ int main(int argc, char **argv)
>       base_setup();
>   
>       g_test_init(&argc, &argv, NULL);
> -
> -    if (g_test_slow()) {
> -        /* Do not run this in timing-sensitive environments */
> -        qtest_add_func("/rtc/bcd-check-time", bcd_check_time);
> +    if (qtest_has_machine(base_machine)) {
> +        if (g_test_slow()) {
> +            /* Do not run this in timing-sensitive environments */
> +            qtest_add_func("/rtc/bcd-check-time", bcd_check_time);
> +        }
> +        qtest_add_func("/rtc/fuzz-registers", fuzz_registers);
>       }
> -    qtest_add_func("/rtc/fuzz-registers", fuzz_registers);
>       return g_test_run();
>   }


