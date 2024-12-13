Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3067E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 12:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM4ke-00050Z-HP; Fri, 13 Dec 2024 07:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM4kc-0004zr-70
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 07:26:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tM4kT-00050L-L9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 07:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734092783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w/iFNh1Vle7YqZYTB19tHU6pCpdwFKjoDv35iyVfAHc=;
 b=LSgr8AKcO8Jv+95NbnAT+McNo7Ws/D5sYYhCgQY87MEbiaoAQmgns9euoIO1E+60fDTq2g
 7phCq/q9cii7UcFn0IpK/a/jNFshYOv4zsIfBQI+e6d9LRkVZhKyDHx0yVFTIGKbngWTaN
 1JhV4c3K8WNGuqxgEzKRf+KpBlq3ks0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-slvPCxaBPHSTlzreRGWlpw-1; Fri, 13 Dec 2024 07:26:20 -0500
X-MC-Unique: slvPCxaBPHSTlzreRGWlpw-1
X-Mimecast-MFC-AGG-ID: slvPCxaBPHSTlzreRGWlpw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so16087995e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 04:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734092779; x=1734697579;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/iFNh1Vle7YqZYTB19tHU6pCpdwFKjoDv35iyVfAHc=;
 b=Y8iyfwWq+ZqHb1/ivO5JIRnwGpW+nQ6lUhi8Tw+1v9aifFyQk7aBZhV86oXsdqrCFc
 InuLMrovyFcIbBMsxDLLSrCVVuCfxcVdo+LMWfcpnQJfRQ8Gye4fi8+LyMh0F5VEQSTB
 /Texz33NrngDZ+CmX0tzy3ZgWUi6ZM8Z06EZs2PfY2sTpL4UhyKqdwKcfM6mkYwt+q0m
 5cWyy+nmjel1TDmkTelhSuHM2Zkhlr/isq+Vrin73CHjd6FY0gUA75fh2mxQYLq4s6a2
 Lb/Y4ZFUHGPPePAj4uZnSdm6czcxBqaYWr1N+dCcKBESrcXt6sHlndlJL6cijKISGyZH
 El4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOeZu13UOY05rFlaZvNvrLjlBS+b2GcnV6tzWRYKj3cVJk9aQLKccdziT/E4KODZpXCggX88U3K5u6@nongnu.org
X-Gm-Message-State: AOJu0YwNlZZZLoM6024YY9udJli/1tMpIJSuCJSG1zkvt86GVQAWgH1B
 noACHGFzD7BECS+Ivbf03i/Ey6mrFHefA32sPD1nkwLgucVJ3tuh6MRD5zTHEmUpxfFKnP/GSD6
 Mg2KxtNUz2WTIF538UQ9G7VD3RSQEU/I+wbWJceB8PN2VMikXlgc2
X-Gm-Gg: ASbGncuTD/uZVgZuXmpHGAGvvoyEkwhz3wrenileGIxmDfrsz5O/yJGNrRX9ikbLWgm
 n/ZEbPA/KWAM3Nftsepa9DA23/sBaHjhwgmTaXQEwCEMr/bm6SBCg6OoBwseGBGIXpxCOWL7NA7
 VIlTb2QGQ6g3E0km/0KeGw5FjbOAcvWi1deldBhM3ojh8bWqUcuHP5LJFEqKM0/4cFQZ92qrOR+
 pk8gilGN6pBfuQHYRO767IAYWjq82C7JW/ZUKh+q4aF5aSnAUCXldIe4AliKGAXXiDqbsCowekn
 4/RmUw==
X-Received: by 2002:a05:600c:350a:b0:436:1baa:de1c with SMTP id
 5b1f17b1804b1-4362aa36cfdmr22347815e9.13.1734092779131; 
 Fri, 13 Dec 2024 04:26:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa4jcq7vunA6VHcKfzUXlMdFNo7w7ja1v+Cx0AokLJjqU7f8GVdsPFK3T04lChP1aPlampkA==
X-Received: by 2002:a05:600c:350a:b0:436:1baa:de1c with SMTP id
 5b1f17b1804b1-4362aa36cfdmr22347535e9.13.1734092778786; 
 Fri, 13 Dec 2024 04:26:18 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436256b7c62sm47528135e9.34.2024.12.13.04.26.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 04:26:18 -0800 (PST)
Message-ID: <f03adc63-5167-4982-90e6-70b65f0c90cc@redhat.com>
Date: Fri, 13 Dec 2024 13:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/sse-timer-test: Add watchdog reset to
 sse-timer test
To: Nabih Estefan <nabihestefan@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, roqueh@google.com,
 venture@google.com
References: <20241213002602.4181289-1-nabihestefan@google.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241213002602.4181289-1-nabihestefan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 13/12/2024 01.26, Nabih Estefan wrote:
> Recent CDMSK Watchdog changes (eff9dc5660fad3a610171c56a5ec3fada245e519)
> updated the CDMSK APB Watchdog to not free run out of reset. That led to
> this test failing since it never triggers the watchdog to start running.
> No watchdog running means that the timer and counter in the test cannot
> start, leading to failures in the assert statements throughout the test.
> Adding a reset and enable of the watchdog to the reset function solves
> this problem by enabling the watchdog and thus letting the timer and
> counter run as expected
> 
> Also renaming the reset_counter_and_timer function since it now also
> affects the watchdog.
> 
> To reproduce the failure at HEAD:
> ./configure --target-list=arm-softmmu
> make -j check-report-qtest-arm.junit.xml
> 
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>

I think this fixes the problem that I was seeing on Travis-CI:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2702

Tested-by: Thomas Huth <thuth@redhat.com>


> 
> diff --git a/scripts/meson-buildoptions.sh.tmp b/scripts/meson-buildoptions.sh.tmp
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qtest/sse-timer-test.c b/tests/qtest/sse-timer-test.c
> index fd5635d4c9..d7a53ac23a 100644
> --- a/tests/qtest/sse-timer-test.c
> +++ b/tests/qtest/sse-timer-test.c
> @@ -29,6 +29,13 @@
>   /* Base of the System Counter control frame */
>   #define COUNTER_BASE 0x58100000
>   
> +/* Base of the MSSDK APB Watchdog Device */
> +#define WDOG_BASE 0x4802e000
> +
> +/* CMSDK Watchdog offsets */
> +#define WDOGLOAD 0
> +#define WDOGCONTROL 8
> +
>   /* SSE counter register offsets in the control frame */
>   #define CNTCR 0
>   #define CNTSR 0x4
> @@ -63,24 +70,26 @@ static void clock_step_ticks(uint64_t ticks)
>       clock_step(FOUR_TICKS * (ticks >> 2));
>   }
>   
> -static void reset_counter_and_timer(void)
> +static void reset_watchdog_counter_and_timer(void)
>   {
>       /*
> -     * Reset the system counter and the timer between tests. This
> +     * Reset the system watchdog, counter and the timer between tests. This
>        * isn't a full reset, but it's sufficient for what the tests check.
>        */
> +    writel(WDOG_BASE + WDOGCONTROL, 0);
>       writel(COUNTER_BASE + CNTCR, 0);
>       writel(TIMER_BASE + CNTP_CTL, 0);
>       writel(TIMER_BASE + CNTP_AIVAL_CTL, 0);
>       writel(COUNTER_BASE + CNTCV_LO, 0);
>       writel(COUNTER_BASE + CNTCV_HI, 0);
> +    writel(WDOG_BASE + WDOGCONTROL, 1);
>   }
>   
>   static void test_counter(void)
>   {
>       /* Basic counter functionality test */
>   
> -    reset_counter_and_timer();
> +    reset_watchdog_counter_and_timer();
>       /* The counter should start disabled: check that it doesn't move */
>       clock_step_ticks(100);
>       g_assert_cmpuint(readl(COUNTER_BASE + CNTCV_LO), ==, 0);
> @@ -103,7 +112,7 @@ static void test_timer(void)
>   {
>       /* Basic timer functionality test */
>   
> -    reset_counter_and_timer();
> +    reset_watchdog_counter_and_timer();
>       /*
>        * The timer is behind a Peripheral Protection Controller, and
>        * qtest accesses are always non-secure (no memory attributes),
> @@ -195,7 +204,7 @@ static void test_timer_scale_change(void)
>        * Test that the timer responds correctly to counter
>        * scaling changes while it has an active timer.
>        */
> -    reset_counter_and_timer();
> +    reset_watchdog_counter_and_timer();
>       /* Give ourselves access to the timer, and enable the counter and timer */
>       writel(PERIPHNSPPC0, 1);
>       writel(COUNTER_BASE + CNTCR, 1);


