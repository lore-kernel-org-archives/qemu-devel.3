Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1141ECD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbjw-0007Kq-Qu; Tue, 19 Mar 2024 11:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbjj-0007Be-MM
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:50:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbjh-0006i1-QX
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:50:47 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41467d697a2so3692445e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863441; x=1711468241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sAFmieUWILTCKRkamo/d7jrRPjeosX/hmTYF3Y7FJ0I=;
 b=KNkjRW2lqyeqiwDFdJs1Ze7yY7Nekcd0ibal82qnyqN9k0m3K0M3YWaKADVQ0PqaJC
 P43ei1b0HD4nY+uM572NdlPzvRLeeMJRBCh21S9KfcQuLgpeNLqgo+na0iKIJfjUfefv
 OiFJJe3Oj3RXzDSlM19utDa42OxbbqCjYn45D2eVcnqVTHCSSGAEtWD4HQt3pd66nwyq
 j/jlJKYlXG6s8+2DbE0Vkx8SjlxqCIpEIfMjfUDPgyCxAVthih+9gtHKgKJKpOOJLHRz
 vB8UmVC6DkPr8/OcP+tAgL64xJyjjgZLrSnVDdu04c9DDw+nlgQH+rpYXfn88Lipr4T+
 6cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863441; x=1711468241;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sAFmieUWILTCKRkamo/d7jrRPjeosX/hmTYF3Y7FJ0I=;
 b=YI5/jojzvN60l4RuhriyEBE8eS15Yqhe6XEx6i+DHip3QmaFz6D8yMD2UBa+vByEh/
 /1f7pDSgwTbiNpLp1b4YSaJnJHkLsmsLtsFyYvbyA9UyHvbL0w0WHNIW+aXZqkrnPfn9
 O4nQy5XROsaOiSV4o4u301THrpJcGOdSXqKPxL+DS4cdjjUpjA1JnBxjKI7oglm7p4yz
 Z6Y35u3qfVFPzcDKKT7nkHR4JZPEQDRWMx1ZM8bYBsr5JfxHm4B/AhO+8/OsXboesgac
 SXSbdYmuWwmva+0ePWclmiFwbBGUBnrZReDavfk9gbtlfA+Hk5arwSRmGm6GSCeO9EO+
 FSHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0lAFa9uMmV56eEuT+jhQVWpsjJhedECiKbethMrtk6evhx/uMUu7TNPaAjFf3j7A8kdACaQDtB5uR5/oe6PwlWXtJ9A8=
X-Gm-Message-State: AOJu0YztfTb4rQNMwYmcWkxQc+EXkEebp6jirD9qyF76qnAlp28yHap1
 /CIC+RvjQlRyIyIiifJLzqjAokmdgal+LzmoWNqjlwwaeXgxKyHpzg4Iw2zMHIbMDceVLcj094z
 h
X-Google-Smtp-Source: AGHT+IFjZJs9yHA1Qd49SEy6w619cWg3XTOm1XRIHhSnEzfzA3znnekvzy8MRXaT+MYRqmYKuCrlpA==
X-Received: by 2002:a05:600c:a4c:b0:414:729:1189 with SMTP id
 c12-20020a05600c0a4c00b0041407291189mr7961730wmq.21.1710863441396; 
 Tue, 19 Mar 2024 08:50:41 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c19c600b0041413546e5bsm5711005wmq.0.2024.03.19.08.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 08:50:41 -0700 (PDT)
Message-ID: <61da973d-e017-41d2-bafe-12570956aa8e@linaro.org>
Date: Tue, 19 Mar 2024 16:50:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] aspeed: Make the ast1030-a1 SoC not user creatable
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240319150903.413662-1-clg@redhat.com>
 <20240319150903.413662-2-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240319150903.413662-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 19/3/24 16:09, Cédric Le Goater wrote:
> Aspeed SoCs are complex devices that can not be specified on the
> command line. Fix that to avoid QEMU aborts.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2227
> Fixes: 356b230ed138 ("aspeed/soc : Add AST1030 support")
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/arm/aspeed_ast10x0.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


