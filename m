Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F047C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 10:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbeIK-0004Qg-8a; Wed, 07 Aug 2024 06:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbeII-0004Pr-Mc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 06:53:26 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbeIG-0003qL-PC
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 06:53:26 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70d2b921c48so1295989b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 03:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723028002; x=1723632802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixRpl+2tbgj1e6C+MA2T+KhL9IlzpEJY3FY7y91n5AI=;
 b=ioxSiNAnvnsnndOZj5rluY3u5/CBl3DDEsMKar9KofPdUbmCvX1/1N2ddAa4EfC21V
 mdYG8sJxciBH4v7EY8NLUzMXeTR4H/6GQBybJ2wDwcRpzeeDBcxBEbgueLfMwMs3jCEn
 eOvClqSBuR0ZOYTkM/SqHrpmyTLt3IQmveQQijxr7BVuNziwiJwjJ84LluvOx2B7MvIz
 +AK8vQ6iH1eUw6iFp29zeCfGWtzkhp+L+mDruYik5UxdKnskL58NzUBn7nsaCNvgSMt9
 DgDxxfccUapDOeye68VbtnIi8f4Tfqs/QUfWThllRjF+xXyynNCFc5h5fwp7wynJNwxY
 kbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723028002; x=1723632802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixRpl+2tbgj1e6C+MA2T+KhL9IlzpEJY3FY7y91n5AI=;
 b=aEWHWqjOu9pLY0kRCdjB6pjtUIfN0ApHgqWrCFrvrIP4jBNpEQLwJhUqZsApFYSheq
 8HJQpQQVW+GtxbOYd6RkN8S3aEaHIqSpCwvVk6cFfL7Ka6M9Dz0N8xBBWc5cp27FTcDH
 mDWIKkzz/8G6TkZ6GflzOh2GWOiQmGScLuvaooQo8LF9IHlNkMXGEnnP7ttzxtNPmQPA
 eXYWdC1LYfA3rUUpMbVUYjkHk4tDse5CZ0MRFZTz7/GW231kNKYAgAMN4+oN4foNEaS8
 843ZyZYdZegEqse7WGewJddGrByZuyOieo8NrgNLrRPc/EvQUO46oDQFZ7Ud+N4Ajoie
 Kerg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW3k6MdEMBX7fJqygEvUzOMSAou2lhIsG54d+hKC1hcWCzCudgIjm7zJX0jvCTTN2qoXYLL5aJEPza2Bf0YzQ7nKwk5xc=
X-Gm-Message-State: AOJu0Ywmtr4CgngiOYiWJngv5z6w/oLyxFCdBY1P8qrf3xR8mzeCaCUc
 br4l9CKCNNCoZAbUvBTJDes14QrJUJo8WxtV42q4ZPGxtTtZaLuKD2QaNrCH4VkdqhFb3uPLemp
 77t4=
X-Google-Smtp-Source: AGHT+IGNgJP6BuHmPjU79Np8OP60ixCIkUJLUHrJ9lMUDBsyK0XaHnM+PkVWYe9cRvB15/Rfb8I0ow==
X-Received: by 2002:a05:6a00:2e2a:b0:70d:2b23:a714 with SMTP id
 d2e1a72fcca58-7106cfa2fb5mr19538342b3a.4.1723028002226; 
 Wed, 07 Aug 2024 03:53:22 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:eb61:b5f7:86fb:b626?
 (2403-580a-f89b-0-eb61-b5f7-86fb-b626.ip6.aussiebb.net.
 [2403:580a:f89b:0:eb61:b5f7:86fb:b626])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec54457sm8193384b3a.86.2024.08.07.03.53.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 03:53:21 -0700 (PDT)
Message-ID: <8ed97693-be8c-43aa-8818-98930dfaf5ed@linaro.org>
Date: Wed, 7 Aug 2024 20:53:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-user: Display sockaddr buffer as pointer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>
References: <20240807083508.28134-1-philmd@linaro.org>
 <20240807083508.28134-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807083508.28134-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 8/7/24 18:35, Philippe Mathieu-Daudé wrote:
> Rather than 'raw param', display as pointer to get
> "NULL" instead of "0x00000000". Remove spurious space.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   linux-user/strace.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

