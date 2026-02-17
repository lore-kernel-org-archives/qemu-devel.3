Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E50E9A03E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSyE-0007HL-MN; Tue, 17 Feb 2026 16:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSyD-0007H2-BF
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:51:01 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSyB-00016M-R5
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:51:01 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-436263e31abso4484826f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771365058; x=1771969858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zHHbkXwKbpEHzHvL5S7cK8Eb8SKCRI51G2844yOVlI8=;
 b=TxnO0IgUP8BEiZ6jsS3hlrbrytC8aOtls8XgmWi8/ABfNfI8cKPn5JJ+Mh2iQgtr62
 +FWPGUQBq4GLIofVIJXSu+F1q0FOgSm6CdiGjcbR9v3B38C9rRXGLfYDewxXuAzf3SYa
 sxQVvA4r4pS28bfWh2OObw5us3mjVMkqbqNXBMlLw85H0e4To3UEMP0nfYPqbcESNIUB
 fFc2up0WKYm9792ZbaeJ/mECa9PSW10eZ5xwUkJdujuwwmeWIp5FFV2s/Lmh5n7I2gRB
 1un5hdk9UKkpVAfLT0a6VlVlrRLSh9gGzRHayXrLbssjM4JGMnpi8Wdc4VyogoQtU3MW
 9pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771365058; x=1771969858;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zHHbkXwKbpEHzHvL5S7cK8Eb8SKCRI51G2844yOVlI8=;
 b=FQLOTLpbOU1m6cpv5Jse0mK64V31cufg80mI7UWcYXx+ZLGYJC9RE4e/O5ab64+PIo
 rcaaVY4loXKXtbyKoD9wBaMTPicB4hWQHEI79SkvdX0wdOQ2h0OxyKNXH8auJfOvcVaz
 ymqAild/dmREN9Isy03+rOf5U1/53Rps+4dKh8aOqprbDGPwI/oEzD1WtV1bYbuBLrWv
 x0jqE66FUs+RdVjoC/z4qnfhZKIgtxIdp9EjyV6K7OuqRZn5XR2JHZR7vwveYn1gyuss
 UeoOdiYp4LWv14M1g0Bl+xKxhMq0fFlpsA1gpjnzmMl5FG6sCpe3i7X5Vhvz3MdED3rn
 H6Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtfG3XlMS8rcbmoOqRbzGNgFoxCAcdOFg2oblxMajRN+ANdM+xalYw1G1QS+Idy2OGZpzJGIcaYFSv@nongnu.org
X-Gm-Message-State: AOJu0YwvaZpf8vh9jlMMjz3jCaHwosYXt8vNpYMlRBx6PX4IXqQb8iqQ
 jgS+hDw+3t3sNpFXD66on0n46pVbiSfmSI3OSBe/89hkhQvrV3n1cseGiWTQNhc64blAC0Cw63e
 B7LoQJGA=
X-Gm-Gg: AZuq6aJJFO1cqbOFP4pSqxDHJZzcEHw7h64DONz5ip/f2zSrp48l2fRR6CNFoD3/cel
 0W39IeOAzLGckY/O+oP9Nji9coOxGAuO6qoxQSxkD1mQvXXRUbNcQk0HGV8TwFA/9cJ0I3sU/DT
 utvNPy0aXJK8WUAE4RpOsN6G4COQs4zasNapBT9Leenu5+NjIb5gwjVDru/ntZx290D45cidAZv
 lRFH2E2RzWkCdNeUSBPel/V0vpN9o8J0+V9HqtQN/YDk7queJDEVq7r3VCDemDF1VbmlBUEEJRu
 B98UiHiipexFrSwKf1zZ7BFVpSWSMdYztpKQdbthjA5UvyNkIdt9KPRWn2S3rXNFtNHectHHWZT
 2qN6/XCJtt5v3Xlb9RDCWCm83B1D3d6lYBnodI5iuQcoIcCyAnqYM0CzN+8AetLOm5P4vDQs5KX
 Al/uFaWNeoJTuIgQOeu2vzMWXbOAQrXZn0f6WcNzOoQZhOIUyz2XiS8YUQRPU90naMYQ==
X-Received: by 2002:a05:6000:2307:b0:437:75c1:5793 with SMTP id
 ffacd0b85a97d-437978c99fbmr25065943f8f.3.1771365058199; 
 Tue, 17 Feb 2026 13:50:58 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac7d91sm38127496f8f.26.2026.02.17.13.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 13:50:57 -0800 (PST)
Message-ID: <6f53ba62-bf7a-4ef2-a70b-5c6e92606242@linaro.org>
Date: Tue, 17 Feb 2026 22:50:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] page-vary: Build set_preferred_target_page_bits as
 common code
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260217095106.598486-1-richard.henderson@linaro.org>
 <20260217095106.598486-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260217095106.598486-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/2/26 10:51, Richard Henderson wrote:
> Use target_info->page_bits_vary to merge
> set_preferred_target_page_bits_common into
> set_preferred_target_page_bits in page-vary-common.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/page-vary.h |  1 -
>   page-vary-common.c       | 29 ++++++++++++++++++-----------
>   page-vary-target.c       | 10 ----------
>   3 files changed, 18 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

