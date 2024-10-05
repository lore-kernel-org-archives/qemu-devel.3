Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D49CF8869
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtPh-0006h7-Tx; Fri, 04 Oct 2024 21:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtPg-0006gd-3R
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:16:52 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtPe-00057t-Dh
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:16:51 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b90984971so28538585ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728091009; x=1728695809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9+F2elgozdrCfURcAATdNRYgq9OyWtB6HRywBMvHsjo=;
 b=NJ57fdMRntccXODLmQONcSgZLcGJ8qYGtbKGZlOY3COrjd3SFrkuWBwRecBVmnCE5j
 YalNibmstzko16cs9AOsZnBonXByloXABQPednkGQuHFrg048BHTSlhT5KIBJNFg72MP
 TCxf8cZW2+qQlh11z+ZcvmWp5zb1YGzn+sUKopWE3UH8d2kuYiWx8qtjbW76M8/Ovn2e
 5GUNuy10blA5dRZpvbNaTL/mZKh+aj+ySduD2mRVEQE4wg8v9mLmoiOjUZbbsGz7ozOs
 wu3eMKVW5HbDIzxvOn2KaNfGgp0Gw1imHB69lffA2qW6o3o563fFvm16nNQgFce3xVMI
 kWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728091009; x=1728695809;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9+F2elgozdrCfURcAATdNRYgq9OyWtB6HRywBMvHsjo=;
 b=D7RM0ql/FcT2Q6zlLgGs4B3lNkRKMEQN2D1M6PkmXxJEzH7pqHF42RUlqZzZ5H2jSR
 6zkQ7UBBMiQMoTN67o8C1K1oLb2D0RbNy0EqGMFdMerbETA35JkplmJ5MRecTSBYl8jn
 crPI1q6FKOGTxGS1W37FfhAfeypT70Na1WBB7Qm4Hzqfnu3qauep2FSrEpLkRFD8at0x
 q/mmmS379bjA/V3VYQctsrQI7EtF4/3JdViilnyi1MzpZjeGQnUwXXEDeSwQFhLoA2yN
 GAJPEHRHqv8jrDHnfBv6XAMudHxbRkVsaH+KkdZjxIIF5gZn9j/eKp1SC8PemfVH+Mjt
 Pdxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVraGYOJ0RC5Sv0kMK4pdCjky1Vuq42UzBAEfuRuUgLQ7uoo7NigXLYoxJVPFedcsrIk2JVQ1J3pFTQ@nongnu.org
X-Gm-Message-State: AOJu0Yx8ytYjldh6zvmj0r0rAW/miljD2gsh+or+W0VHCPpx4PiAhbZk
 FPqEJwPA+LaIXYyO9dBPMhbEzS8ujl0u0eU94lTOiV1ujDzSYIsGNcn90bjMk18=
X-Google-Smtp-Source: AGHT+IHBiscEUNgqgvcHQRpfhTjwcWWMPPRC+TPHjhKY+GVjv6ZSLfcXDtyIPPzvKTKVa2pHh8Qz5Q==
X-Received: by 2002:a17:902:eccc:b0:20b:78f1:88d0 with SMTP id
 d9443c01a7336-20bfdfd2176mr61570835ad.23.1728091009084; 
 Fri, 04 Oct 2024 18:16:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13987801sm4381775ad.255.2024.10.04.18.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:16:48 -0700 (PDT)
Message-ID: <4eb50ddc-95d0-4001-9100-eafee2b006ce@linaro.org>
Date: Fri, 4 Oct 2024 18:16:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/25] target/hexagon: Use explicit little-endian LD/ST
 API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
> The Hexagon architecture uses little endianness. Directly use
> the little-endian LD/ST API.
> 
> Mechanical change using:
> 
>    $ end=le; \
>      for acc in uw w l q tul; do \
>        sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>               -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>          $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/hexagon/); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/hexagon/gdbstub.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

