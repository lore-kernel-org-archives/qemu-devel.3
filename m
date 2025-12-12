Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4C9D4336B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 06:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTwsD-0000E6-5K; Fri, 12 Dec 2025 01:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTws8-0000Ct-0Z
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 01:43:24 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTws6-00038R-G6
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 01:43:23 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so314071f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 22:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765521800; x=1766126600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L5CStyI7BgsXJJWY8RP4qnl7WkZVTJBFDiiPPtxa1AI=;
 b=vIOloUjoNmb3jjUFhde2v+vBwNvYLbT18Uy5oxbaLAY3ptZm7oQvIreN2G5IJ1Ap9K
 aJPsXiYqI0eqTN/YzzTepLW/XDtPBkWgSIFDGo0kDyxJD3T/bA32JN6ss4L1JLeU7Mg3
 6j5sjJmn2s8PT8/WW9pkfjcRK3Y6QXAKU0w+BXLFRVKiNcnN+vSdoR3HClydUoFGSZhf
 irXRyOb5db7LxWAaiOqcIYvxfdRzTwvY5oomhiPrxAL8m1WdqcVIXzXnj70Wq0at/iQ2
 9Hj3c9p8L1QM13LVEsAKpeSo2xiJl0KcXe4N13dnaxcVYkQAF/yAKBD5Uv3pZIZ3Lsrn
 5vhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765521800; x=1766126600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L5CStyI7BgsXJJWY8RP4qnl7WkZVTJBFDiiPPtxa1AI=;
 b=afZWIPcZQ6qhVqfkdbf1E0oY9HTBAdeakwO0jTGfJCaiGvZNq9phY0bdXeCof9fcw8
 REBBA7KtV0Twy3bmCpGxBnI27m4PpgqJaO7F5+SdDg6bvGCW8rpaIS7mQuDfg8A4i/VN
 6WlmUsg3Qc2u0gJw3Ug5Tj+UixHbMq17jRIAL8WeWKZawdeEWNcUtUqtV85OMnMjro9a
 MhaZhEGpEPDjfh9kULKeCaRB9MYQ7tIiOXo+Oa2hcigGgYxgF0qlfpokTGk0vs+MRMVn
 m0ja4rsv0Mhk6xiFUAekwMmPMNZldRvjEArT7JCh7tbzEtjBmHtI+5Aa1ltFeYwdNIhv
 9QQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvRxcp3RWV9exzy4R/yAM8EhesrLQsMN7CeCfRxJX0g+OmMWMBEJE82RDVXPNUajmtB4TDlGoG28vT@nongnu.org
X-Gm-Message-State: AOJu0YzCMV/Av497Dh5KWkcFSlHhnoHoh13vIGGDy1cDAOvgUBeoiDZH
 ihQnISVZ+6y3sCVTu9L6SI0pQ2EmCDgKH2c55xASVaiXNZ1UNY9yDKWgW/N6ErGSBX9ShIQ+XgQ
 9wZuGs+0=
X-Gm-Gg: AY/fxX7n+BMqimwztEDHigbJxDWD0JwdKiZi9iDYhZaSNjfMUyO8Cdwq2164NwJG2rL
 bvzNDPU9jNWAAKywfNgxRnDGS2gKGg0mFZxECAzD+PUBqy72lV0Tgaom31nS8wDHbmAunR7aqjv
 B0p1ohKf/ms2PV0FpX+Je7zacFdBGdhHi6doRkliOSDPb9GR9UpDJAlaRKWCoYquriX1a7TYNxh
 He3YSeltlzGpozbW1sdWjSpNs5kJ3Kh7xj3pZEPhBlKM62aKE8WXvOKOA6mfvw1hj3c2Mv8Ub1f
 M/AZQgjgMCsGAy40uuVVqCr9fm10TtxrYN+GBVRczM37Ij1N948EMTrBP1wae70dftoTzaW+NpM
 9Zh0BaQ6LFBuHd9rf7BjUqT4hTJtcNYc9DbILWbaZYfcO1q+YKXwj/zYA7i7uHiovkm4BpHWdZM
 vysVHH2KSbQURgHcjWoxsjmo8cMKGVPVZP6i91jc7/yjp/t2Qowl2odQ==
X-Google-Smtp-Source: AGHT+IG3jMmM94bMrm+l1XaTTFas1YBXBa/VuO5y0occM+mnq3frbdRgFQwISOUE3JurH/Xl8gJYkQ==
X-Received: by 2002:a05:6000:4312:b0:42b:3b8a:30a3 with SMTP id
 ffacd0b85a97d-42fb44c491dmr899508f8f.4.1765521800382; 
 Thu, 11 Dec 2025 22:43:20 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a70440sm10326970f8f.16.2025.12.11.22.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 22:43:19 -0800 (PST)
Message-ID: <7fe36252-cd83-4eff-90dd-4665471585d2@linaro.org>
Date: Fri, 12 Dec 2025 07:43:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/9] MAINTAINERS: regularise the status fields
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
 <20251211180132.3186564-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251211180132.3186564-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 11/12/25 19:01, Alex Bennée wrote:
> Orphaned isn't a state, Orphan is. Likewise all the other "Odd Fixes"
> are capitalised so fix the ones that are not.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   MAINTAINERS | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


