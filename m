Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410DCC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 14:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGgQt-0006qF-UN; Mon, 10 Jun 2024 10:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgQs-0006py-Ol
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:55:38 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgQq-0004C5-Ou
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:55:38 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57c6afa1839so1303053a12.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718031334; x=1718636134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2qKjeMnjVAZ72ldJXqAKZoMJ8ZvwsvRWin/fb77dBtM=;
 b=l3MTGSVJ4zPYvNOr5XjPZWdjqKn8gKhlqNjJ8x7zqQv28Ql1N6y2DeYwsOz9Pd/Qta
 A2L/ARngwhiBNbWDeQdiQfokVuF4yp5DuVURuD/wxpVzqBEEpLompSxcKW0Hxhx4ODZ2
 D0FOqTHn0WGRCww0SbNYYulWuvrcVSFUu8YFuwQwu1VLc0mpWtpOy+VlRyPEFs8SMFI1
 2OtIijeIVOyG1rAyT/gXmvZLSyu4CuOEDN243/V0zOBBAPyUiR8C6J429eKhwZ+vj9Gs
 pPvoKIxsr8T+3lVYkuyhWvpzk5fJ8v8gQ8hwqXcslxtQ1FEA0ZnCh8+/beILkWo8Wbrp
 nYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031334; x=1718636134;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2qKjeMnjVAZ72ldJXqAKZoMJ8ZvwsvRWin/fb77dBtM=;
 b=ljfUrWfigHp+edhC+r05X240M/NqSPhChY6Eq7To+cBidM2ejV3VW39JJ7cG0Ex0vY
 ndDyVRaQn95FvQHR13MWfHLEvky3I9JusfHf8q75hX2tkIEbev5LY/jKWu0YgmxtRMlf
 2LOnNR9i1z/B2KRCP3QdL4yccggWuG+6ibgas6YXpwT7LXn10LdiXMUww3SEGc8Ek85Y
 /1wTWmmvr/KEDrvfyBv9rigKRDjfErjheg0QrnjKqi8XFXmsciIwGC8IjT66F5n94nqJ
 1E9Q1PMFqLO/Uyb95Bd1KZu7e+qscCrKw1W24xLpTl69nDV/un4u6/MqzC/VDK/7kvxl
 bKhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkhb6qUO0cSe2FQTTp0qTnLlVUGSdko/6nzs8r0loisVwDr9oI4jWurYm5ilhPcj20J0aWE6PEvlzvkQSU+qjplE4j4cs=
X-Gm-Message-State: AOJu0YxHtBWwKx6lMzgefkpkgrVyN18nf1QEe7xJBS5uuWf8rezESg7+
 3lO8oemgeJT+Aa61bIi6zTxoqHEZ3W/aZWe1jMn1P/Lbm+sTUeUW13lDHTe1jSA=
X-Google-Smtp-Source: AGHT+IFDHyA8im2QY3bw6UQ+7D8CDHPp7jDUJ1uWAXjTkUL8jJGLD1rkyzZS4e8D2IXAePDoYR7oXw==
X-Received: by 2002:a50:aa8c:0:b0:57a:70fa:8875 with SMTP id
 4fb4d7f45d1cf-57c509c6a86mr5645274a12.40.1718031334349; 
 Mon, 10 Jun 2024 07:55:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c815802fdsm2113036a12.55.2024.06.10.07.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 07:55:33 -0700 (PDT)
Message-ID: <9bba0404-982d-44cc-9d4b-cf8e7ad9746c@linaro.org>
Date: Mon, 10 Jun 2024 16:55:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/mips: Restrict semihosting to TCG
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240530145349.41309-1-philmd@linaro.org>
 <20240530145349.41309-2-philmd@linaro.org>
 <c2kx2jt43pcujrfx3szs3wztny7i5bvb3gypmw73dpcf5izvbo@3ahkvdtgrfl5>
 <aea6bd27-6c59-4257-ab89-18809444f8a8@linaro.org>
 <877cex16yt.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <877cex16yt.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 10/6/24 11:29, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 7/6/24 13:08, Anton Johansson wrote:
>>> On 30/05/24, Philippe Mathieu-Daudé wrote:
>>>> Semihosting currently uses the TCG probe_access API. To prepare for
>>>> encoding the TCG dependency in Kconfig, do not enable it unless TCG
>>>> is available.
>>>>
>>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    target/mips/Kconfig | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>> xtensa and m68k also `select SEMIHOSTING`, were these missed?
>>
>> TCG is the only accelerator they use, so it is kinda implicit,
>> but you are right, I'll update for completeness.
> 
> So I'll wait for a v3?

Yes, on the way...


