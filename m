Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D372C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNqg-0005nQ-Qy; Wed, 12 Jun 2024 09:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNqe-0005ms-VM
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:17:09 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHNqc-0002w9-Dv
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:17:08 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57cad452f8bso712236a12.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718198223; x=1718803023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XYJHKps1pu0uvMf+P1skU4hY8mwSsIBxLOHxCxEwrac=;
 b=IcIBYn8VYvoXJ7Wzx7N5KmcOASPOepjBp5uzcsq3XaTMUkpkhqRyGxChVQnHbLO/Eu
 GtrduSDcLvodfrwn4qIi+wVV4d45o3aOCMHBUuPkcVVibtXdrMMnBdnweypI78wBVNIy
 tFD32Z1yH8ur4W+EYqexFdmkabkRJiDzfLlCvSEL4vNXt4IIfa5+eDZOAeYQJZvBMrwi
 6+pPPfiYfuvsSwGr4Y597bYVsSIamujGu5nAd2LHMq/3KSEhTsec7Jkwp5Dl/IQ3acw/
 ZNTufd2gkRm8T4GvV5Ohkg8kKNpq73vRbDggkN1URZxKxPLf4SHB/dnC/+oxQXP9Dszw
 EuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718198223; x=1718803023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XYJHKps1pu0uvMf+P1skU4hY8mwSsIBxLOHxCxEwrac=;
 b=auFZUz0Ovdpgeb8AhjyQ69mEI7+6XSs2+JL8VURriI49F8GUQB8pk/JzrJVmNouP62
 To07eWzM/9NrPCUxfxBvRNQCLGHDLdlq2s9YgNtTIWcyNlloc14QBYwVre2k9jaTaRos
 2m0CdEYdfgROkOuwv3nNjNmK2Bq5ufhQT8yEnmyvvXkzPWdidhKTk/tVKtj9ngPTJihn
 KlIeH5tc+2HtGBX8nTdxDtqGfTiuMGPtVLdeBje3c3LDLiCMmN/DP5bDf45fb0xYrlEs
 yTCSFecFXbBU8atqaXH989DUVX0pxfflQlzcTv7L5PljvL1iEW1MYzsR8mOzZlAfZZcu
 dmvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1pKntf8uf4JJkKidfmTb3CPIt00FMcBeCkJN6SRrpwFEdSAhwDm1dUWiqZRk+G+RCaFjtjHgMwCAvPCVYt+b9s//kCDE=
X-Gm-Message-State: AOJu0YzHXSk8xZ9Enb4q5d05rPFy/ov41+XlpxQ+5SyKS0mFnNJ6XPmI
 MRtmthd591G7/5JVMKG7TIB+cNxRZd3EfrSVKviz5w0f/UBoV4DLn0Hw8+yJ7B8=
X-Google-Smtp-Source: AGHT+IE5Hbi9AN/zB+wlBzIL+FBGs6l/0TdduAwP0ZiWCi/MVX0HGC755HgCk5PpIfpxQ4nTr1xH9Q==
X-Received: by 2002:a50:d69e:0:b0:57c:74ed:88c5 with SMTP id
 4fb4d7f45d1cf-57ca976c0dfmr1255466a12.13.1718198222986; 
 Wed, 12 Jun 2024 06:17:02 -0700 (PDT)
Received: from [192.168.69.100] (ram94-h02-176-184-0-172.dsl.sta.abo.bbox.fr.
 [176.184.0.172]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c867a6c6dsm4630423a12.32.2024.06.12.06.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 06:17:02 -0700 (PDT)
Message-ID: <8a3a4707-07ba-4d64-939c-63ccb922aed8@linaro.org>
Date: Wed, 12 Jun 2024 15:17:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/tcg: Fix typo causing tb->page_addr[1] to not be
 recorded
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
References: <20240612131509.14132-1-anjo@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240612131509.14132-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 12/6/24 15:15, Anton Johansson wrote:
> For TBs crossing page boundaries, the 2nd page will never be
> recorded/removed, as the index of the 2nd page is computed from the
> address of the 1st page. This is due to a typo, fix it.

Please keep these tags as they are useful when backporting
(maintainer taking your patch could amend them):

Cc: qemu-stable@nongnu.org
Fixes: deba78709a ("accel/tcg: Always lock pages before translation")

> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tb-maint.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
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


