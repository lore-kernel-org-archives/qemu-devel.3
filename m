Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA625C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 23:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW2Ol-00049N-9E; Mon, 22 Jul 2024 19:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW2Ok-000453-A7
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:24:54 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW2Oi-00063t-LC
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:24:54 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5c661e75ff6so2280856eaf.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 16:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721690691; x=1722295491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O3zcffW/9Og8nMl7p0aEkK3Qzk1wT2SFMBnrP3P4Fwc=;
 b=BC/ZuHll3D9lxh9KD90of+8+OUBEOqz/AAmmydMal9zHWPwu+xAu3yXraChjMa1yWs
 VhrhHCI7Z5MmGZpZgMirQuGE2g/PEvEl48fGvzsltHly1DJhzZBI8XnW0SW5+tWISNRz
 cXEtvlhf2j5ZES+YE/pvAPoRznjiUnPU/WI0pSmmMo1QsPcT3pSB3UUJkIjJ0m3tR5dp
 a42VMuGD1bztCo5Nr7ym+vvi58oWDmmZnb4BmOHb35BwjsT/s0eOuAB8Z2wF5QlpeMp+
 2hJTxSgocH9RWi47g+rgW7RM8lZBOhA+wCQJ0wcu6g+9UJCifC2l/85svMJVOrEquMgT
 BnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721690691; x=1722295491;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O3zcffW/9Og8nMl7p0aEkK3Qzk1wT2SFMBnrP3P4Fwc=;
 b=IX2z0/jU8anEmcAE1LX91M9LKR0cITaXza2ZeawLyxF0bw6sWqvxHKR3FcsnQK6r6E
 CT2oX069n9NYJmbntAgx4yMY8CbsWugKWgO3mEz4D3RCV1JqSiypKlkSFN7UB8rbYWBX
 LLJS7pqzCvLFhmeupMnP7Kg+1Xl0aPDhHhv0dt19rDaGDMiAHA16r+w+qmSWTIaN/c6v
 zM3py9rpA81j6KfIwfogimu9y/l/RmTAodLYruiUOQ47CS80oaaNv7l1yEV1oRKsvxX7
 YrPPZVkC9gC6Av4bwAifHDTp+di3uUji6hZiC8+RstzbjbS4W1rSLN+ulbBjeE7t3yex
 Yeqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM5PU/IzcLUD9PnPohkiw86CLfIfSjpR2A7ilaLBHi6qTnModLmfaEPxHxW8XlC4pOMbkJih+J73KyEJ7JWlQjqBy3bVM=
X-Gm-Message-State: AOJu0YwiSBJE2iAkCsEr+YzMerxj/Tobz0bOXqvF5Ivwff3AG8fn+5do
 h5EyvEeo7qUz3QR+vCygIT78GyPN60oYCFjZskahFnfXFEJsLRUU67bFZtswqtk=
X-Google-Smtp-Source: AGHT+IEdCnDL7RSSjyPdaZ9lPKWDPWNr3FKLJfGzqomtXCUauRtssQZQtqiQlAAGg5/DVit9cLts4A==
X-Received: by 2002:a05:6358:7e53:b0:1a5:28a5:f2b9 with SMTP id
 e5c5f4694b2df-1acc5a781femr998006055d.2.1721690690966; 
 Mon, 22 Jul 2024 16:24:50 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cb77506757sm8750945a91.35.2024.07.22.16.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 16:24:50 -0700 (PDT)
Message-ID: <6438c625-89d6-48e7-be02-7b77f4090c0b@linaro.org>
Date: Tue, 23 Jul 2024 09:24:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] linux-user/main: Check errno when getting AT_EXECFD
To: Vivian Wang <uwu@dram.page>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>
References: <20240721090817.120888-1-uwu@dram.page>
 <20240721090817.120888-3-uwu@dram.page>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240721090817.120888-3-uwu@dram.page>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

On 7/21/24 19:08, Vivian Wang wrote:
> It's possible for AT_EXECFD to end up with a valid value of 0. Check
> errno when using qemu_getauxval instead of return value to handle this
> case.
> 
> Not handling this case leads to a confusing condition where the
> executable ends up as fd 0, i.e. stdin.
> 
> Signed-off-by: Vivian Wang <uwu@dram.page>
> Fixes: 0b959cf5e4cc ("linux-user: Use qemu_getauxval for AT_EXECFD")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2448
> ---
>   linux-user/main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 7d3cf45fa9..8143a0d4b0 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -755,8 +755,9 @@ int main(int argc, char **argv, char **envp)
>       /*
>        * Manage binfmt-misc open-binary flag
>        */
> +    errno = 0;
>       execfd = qemu_getauxval(AT_EXECFD);
> -    if (execfd == 0) {
> +    if (errno != 0) {
>           execfd = open(exec_path, O_RDONLY);
>           if (execfd < 0) {
>               printf("Error while loading %s: %s\n", exec_path, strerror(errno));

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

