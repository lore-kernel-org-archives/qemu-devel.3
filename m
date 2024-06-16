Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552BBC27C53
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2024 18:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIufx-0001tI-E9; Sun, 16 Jun 2024 14:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIufw-0001sl-CP
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 14:32:24 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIufu-0003Vj-PH
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 14:32:24 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6c5a6151ff8so2632045a12.2
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718562741; x=1719167541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A1/WGOHDhXDp6Z8WsbyeZtoO0y/1fLSI8IszjDjfFfc=;
 b=lLueV0Q9Owz7l3WB2C0HEKaP/qZos4cno8BoE5ohEIM1OILnXSqJJmEgZVTAQhLXM/
 GoiI/gJojDtiylm0Uv3HtRS5Vm35LoqNxcoL7GyXBnA8ipLTC+NDeHQmIk2xv7bgiqHI
 88AdeyMTcxp+boB0lLiGL56nt1Lt/XSd1e5nuo1n7okUAxcMYBtSWQDg5/tWkf0iLXYS
 cXObSW30F2gxSji572LmQrgFJlatBCU+TR5W0Panm8g3iwE+1NpMT/6jI0ibbzGNRpB+
 2pkbaXCOMgoci24Z7gcLmtZ2rrnrIXHgueb4zdgP6N9qtntelwb5gJkcveeEEkoW8kHw
 cOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718562741; x=1719167541;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A1/WGOHDhXDp6Z8WsbyeZtoO0y/1fLSI8IszjDjfFfc=;
 b=eF9EF8Z2TLOXNY6058l+RiiSJC4dgeU8uUhAE60dC6KqH3eLZiiWo2KzqxEnUhpkGg
 a5OydWLRMGC0YI+6M8Unt7t+IWTZac2pqrgFEuWJNjiRBop9V3fi18go6IqxpNqJLW1D
 5BJa+gz87SWq0wl9gJWIEhv7LPXEWF4nFwSVdql+aLHTeDJSQ7QC6wiPdDgJXD1HrSDk
 QkVXrQcO0XqYFMI4OHbzcuXqPsvWfwCfsWao1nmtjNBALS/1xxNIjKSyID7AWgv7VQNq
 rz7sVYwlsIKvt5ZcUqMbx9aaGXwvjLg5/P4jM0T68iUZiZENMLdFu+VirtsX0S55eiuQ
 xOWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2MBhVdxhUmaSJoII5Y6DUx1iDcE35knYPvEWZBc1x6P4n5+oOfAWMNQfQ/CGBAvtmMPopM+MetPpoCcGI4uauTeY+IGY=
X-Gm-Message-State: AOJu0YxSQaf7Kww+K4uth+JkWCamFhwAlqLMDPMxjWbqoAf1FLtE26D/
 2o0GtFFOnp0QdLPHl7ajGBUixCBgQ8lG2FjAWd8E2oFJr5Zsc96dt2ngsybP4ic=
X-Google-Smtp-Source: AGHT+IHHgSjE+7Pgx/D6eAivoj0vwtFK8TsMAXB/gsCaA8SAcC9vLuCisbSI6ei0ah3yHB9GYLDi/Q==
X-Received: by 2002:a05:6a20:12c5:b0:1b5:d106:78a4 with SMTP id
 adf61e73a8af0-1bae7f3cdd1mr8180497637.36.1718562740581; 
 Sun, 16 Jun 2024 11:32:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a76aa3f4sm9882043a91.53.2024.06.16.11.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 11:32:19 -0700 (PDT)
Message-ID: <b388b34f-e947-4dcf-9b5c-e4b17637c24b@linaro.org>
Date: Sun, 16 Jun 2024 11:32:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/tcg: Fix typo causing tb->page_addr[1] to not be
 recorded
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240612133031.15298-1-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240612133031.15298-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 6/12/24 06:30, Anton Johansson wrote:
> For TBs crossing page boundaries, the 2nd page will never be
> recorded/removed, as the index of the 2nd page is computed from the
> address of the 1st page. This is due to a typo, fix it.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: deba78709a ("accel/tcg: Always lock pages before translation")
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tb-maint.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Brown paper bag time.
Queued, thanks.


r~

> 
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 19ae6793f3..cc0f5afd47 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -713,7 +713,7 @@ static void tb_record(TranslationBlock *tb)
>       tb_page_addr_t paddr0 = tb_page_addr0(tb);
>       tb_page_addr_t paddr1 = tb_page_addr1(tb);
>       tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
> -    tb_page_addr_t pindex1 = paddr0 >> TARGET_PAGE_BITS;
> +    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
>   
>       assert(paddr0 != -1);
>       if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
> @@ -745,7 +745,7 @@ static void tb_remove(TranslationBlock *tb)
>       tb_page_addr_t paddr0 = tb_page_addr0(tb);
>       tb_page_addr_t paddr1 = tb_page_addr1(tb);
>       tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
> -    tb_page_addr_t pindex1 = paddr0 >> TARGET_PAGE_BITS;
> +    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
>   
>       assert(paddr0 != -1);
>       if (unlikely(paddr1 != -1) && pindex0 != pindex1) {


