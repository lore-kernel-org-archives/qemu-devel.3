Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552FBC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 19:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxAmw-0005pS-9z; Wed, 17 Apr 2024 15:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAms-0005p0-2s
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:17:43 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAmq-0004vx-Gw
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:17:41 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2a28b11db68so101316a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 12:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713381459; x=1713986259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wkrau5uvSUE0y2z0MWLdblr7U2jCAsGg7QRkrScPcUY=;
 b=tqzU8MmWtzOfEIf7ro3wjPRnVVctK+S7WRAr881ES6tkf4s7SqYSbEwkGdcDvpv2U1
 LzCOmLGJy1aPnQ7C3i15bLTq14UFAeVxYtMtEta/mmBfW23mTHy4AZ0LZLw+Pwd6GZ+z
 0aScuGqVR16AogyMzoqURydilCOi2LIvAwcR9cfqEz50NK7odoYPRmD+N9yPjnhR3599
 h0bKBVQg5z3UAHUuArXakg39q9DFv4Cx51zyaKnQaWmTQl9Gh8Sd4T5IYdZ1B8s5mC8t
 qtBxb8YLHy3+XlGfeJhfJkn4DXpAwJyHyXH+Ydzt8EB6nGw/TopukV3SeFoH98hUqn7M
 fXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713381459; x=1713986259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wkrau5uvSUE0y2z0MWLdblr7U2jCAsGg7QRkrScPcUY=;
 b=Bs+8qrhZlZW13zWNhc4Ma3OAyJwOYURKil7SUTQUC/lda0HCXzhTzKYYw7U3wkREbx
 dUt0NuZ5YfpKFBACPfob/cXtIYOI+z01aoSec3wJzMBwglwr09ufNtvE7NzpNdKpWiqr
 fVM5mjP2geVle+2S0iR4tarXoOSJc7pqmnMNag4rA48fG9XRjgJmHMQ4GHrFBOB0mCtX
 ve77dXBowXY7+krnEEC/r2kFnDZSjMl3lwBoLqdAhQJxO4rHkvIVWoyF1xW7knoySxYH
 cFkC2gtg8EyK7yV2xnVc8PXW8lqYlfW0czDgJVv2e6ZJ/zHNDAUOqy1gTrbM+oQT6hYP
 X8fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8O7ipvx8BdcCyU5DmDYOK66vgUCqOO/A8OiXBpgRRuJL+YhFInnCmE/k5/e3bECezJyVRgDAht7GXbM4hSzzAfadVnAg=
X-Gm-Message-State: AOJu0YzNM69BsORphkiN8Z9aToxqnnB8v7EJa1DLLbmpGo5uGUMZwX0+
 j3buMmWlldXLDfk64C5dUp/mifixTgxlmh/dcHXqrRwzY4IuT4gs0gnLMPqug20=
X-Google-Smtp-Source: AGHT+IHz9nXKPCKN5hphbQrrDKmr0fzJLUo9MHAdWsLFZrwTiCcNy0nra6s82VASePPCd3xSmbnNsQ==
X-Received: by 2002:a17:90a:6b07:b0:2a2:579e:652f with SMTP id
 v7-20020a17090a6b0700b002a2579e652fmr312563pjj.27.1713381459137; 
 Wed, 17 Apr 2024 12:17:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 bt19-20020a17090af01300b002a2b06cbe46sm9467pjb.22.2024.04.17.12.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 12:17:38 -0700 (PDT)
Message-ID: <490e0a75-b8d5-48a4-950d-594a33eb950a@linaro.org>
Date: Wed, 17 Apr 2024 12:17:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] semihosting/guestfd: Remove unused
 'semihosting/uaccess.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240417182806.69446-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 4/17/24 11:27, Philippe Mathieu-Daudé wrote:
> Nothing in guestfd.c requires "semihosting/uaccess.h" nor "qemu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> Message-Id:<20231212123401.37493-8-philmd@linaro.org>
> ---
>   semihosting/guestfd.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

