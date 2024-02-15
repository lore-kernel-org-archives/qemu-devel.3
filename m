Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90518C48BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 07:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raVnV-00021d-EB; Thu, 15 Feb 2024 02:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raVnS-0001rQ-4q
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:04:38 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raVnP-0002O7-V1
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:04:37 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a36126ee41eso63171166b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 23:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707980674; x=1708585474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EHM0j1GIpPHDzl54RhHg5ZaTM1ZlSARIsO5jLgfJC60=;
 b=qgmLVjNZpkoHn0Xo3aJi3Qj2dMJs4jkWqjAjIR7miButYHaSirfaw1/Amh90jiUD1e
 telToU8enuE9vTZiHWdyhkgJR1kOj6dcq0X5Ycpq9HuaoMkJ2Pc+7udYxRw3MQDcwbPi
 pletFrzULYkKU4rWvRNfq3RlqyB5XQJMQLSnVJQLWdV3ONNwgTnNctbkwpLAEvp8z7Nm
 AEDBjMcKPgUn2rQqzTRodHvc180RwvR1q9jSBrDfZQqnkBTFzzeXSPxzcdnGB25JpAZ5
 H9FJVipGZuLy9kEESh+8RYSn/OkGLXOaOOYJp/UTcIrw61D8vxe8o7DNYjrLgcDZM8yh
 +mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707980674; x=1708585474;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EHM0j1GIpPHDzl54RhHg5ZaTM1ZlSARIsO5jLgfJC60=;
 b=fYvgG10fnbsTee6wZzS1OpC45UNTIjs6xark9Kylllc91GyU/TMfExrd7OJe3tfhYt
 rwP9q6/XQP3VO2Oatbr6JLGOzpE/fSnOZfowuwkkPwKEfu0m4/TC3VpQ+XiciM/L1p9W
 nI/CCUTw8/l3AbH9Ztpj/j8BC+9q5zesZdlqi2Oj7/t2w4sD3cn5ATjmTaMo3nyH8rVJ
 eHnGInsWxrY2auRdWD/PUKAC8u5V6UKVf7RptmuJ9h4C7DHD8dZbD2q4LLkAfMbqFZos
 UwBB7TqmlIhWfIXKzU0L7PW6J/ZK/t8U2uMY3tEIXMv3ur8um8EqDmO1SCB4UQGMk5iO
 hKIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbmltjv/0DC9FxeI2ogKMPKxsfmGLlCXdd17mIqMMmufzUsyjnMC5HjW5iXeJTIPMwR6BzQBDzGt8Bq1SybckoQkilGSY=
X-Gm-Message-State: AOJu0Yy6HwxscQYWE6ZrYB77425X686U+4QHMAGcm2WVV+JoJZ9iseaC
 RDotUYqtWDDI/7PjLcL3zXjmbDIJPBU7y8G1NcSf2dO6bh6aruU2We80bXMYqZE=
X-Google-Smtp-Source: AGHT+IGZ9c8IeFfUyQnCpklf0EwvYu5kLCRAEjUOu2lasErkhlIUkVi4KQlneJLOQwJRezCkYPS27w==
X-Received: by 2002:a17:906:46da:b0:a3c:f73e:7829 with SMTP id
 k26-20020a17090646da00b00a3cf73e7829mr517775ejs.65.1707980673751; 
 Wed, 14 Feb 2024 23:04:33 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 vk5-20020a170907cbc500b00a3d60daaa72sm253766ejc.41.2024.02.14.23.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 23:04:33 -0800 (PST)
Message-ID: <38a15093-6f2b-4f56-9f31-e828cf58772a@linaro.org>
Date: Thu, 15 Feb 2024 08:04:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/36] linux-user: Split out do_munmap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240215062018.795056-1-richard.henderson@linaro.org>
 <20240215062018.795056-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215062018.795056-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 15/2/24 07:20, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


