Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE00F46C5B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 17:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9nKw-0001rI-Gz; Mon, 06 Apr 2026 13:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9nKt-0001nc-0e
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 13:02:04 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9nKn-00068a-K8
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 13:02:02 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-358e3cc5e7eso1991391a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 10:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775494902; x=1776099702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ng00C3KWmaRSa0g/M43SvTl7pGMijagSfGg05wKciqM=;
 b=qTIf64ZQB0lOVFq8Ahu5w5YGuOmFzaaVrTcuJd1FC0EqnaSidNUAstW8yBOB0GS6MB
 6GQ64n+RJtzC7usJSRYV5hVm/c46LDU8vYZZaB88OqR3xk95ioQxlNEJqX5384WUTgDH
 dhGxv3eYB7jnysQsfTw9qnJGaLH5Hv6XeBfwMUurbqf3NbkoR7jEC4JGh6pPWgV1aHA7
 9WG+Vhp1ppHIJz7ehgV4n5ScAyyd8f2UoqGdX917O0+0yX5mg+sE94bUbY9htD4v4iNr
 aYRGucSupyUTIBFIo8v0koArQ+3BWObg8EqMZHCLSQBsdF12/7eHRCm02H/8hkeHMGtN
 2EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775494902; x=1776099702;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ng00C3KWmaRSa0g/M43SvTl7pGMijagSfGg05wKciqM=;
 b=ctSz4qbettAFkA7ZdtYcSvYm5xmCvhA5+COsTuuaEO6CA8Amrzu/PszWWWQQKCj71+
 GdWOZmGufbrwBCzo/Aau/sY3xW43d0k2cWM8yGWEHYYpOUKkdC+3b/ohMDbu6T5ouJbT
 XYj02qgCaIrGZe+D7zuiiGQr4nBPOGow1xLiJLQs0QSce2ialUqGOv+fboWVQhbxhVbH
 zZzrqA/Ea3PoiVzaCs1KY+lkz/DMzTPezt25+GvsHOLyz0/6Yrrzb2xmjmW+8VbT+Lx2
 7bTAqb1f2YWJDfzMsxZuohRypU3Sv4TgLGPyPS/yCsSDPFR7D/eZ75NXbq4CBU0VajDe
 NFIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS2U37qaq4tX7dhtVqtRnlNBH1s1ylztR8+YZDBgsDiKo9Nay04tY3Or/JBRS4sygQ098iIACOOaJV@nongnu.org
X-Gm-Message-State: AOJu0YxQWV+UQCWiAbNKQgmB3sHle9+3GwK8Qd2MaetiVUBJavIyzeaf
 SfFDBlaDBgJhkYI9YbJifEN0SPKJpjstfa+Rq8UYMpLYDVtvadrGsZAMDYqUAxBttQ8TzHUoKSn
 rfi216x6/MA==
X-Gm-Gg: AeBDievG3Hcygi+QygX0fqiKwuTTLCNZwRcNKSxFZhxQVdojP/GgsQlco7zFqf6s1Qx
 Uv7p4PW1GiDI64hgMdQgFtQd5FVHks+Y3T2d/h8pNdq7Oapc6jkVLOI1Ieg2rkPmS2/DHQ7hD6O
 uUMUPOX7S7vXd7JHmzN+WO6QSwGv7zDUMvMwGqIzpKJ3uznRLPJx9fV7Ej+TrrZneP8myMXF9hd
 urMLXXUE80NFzevs5NMRuW2jfc1AKjrlat2ooJi8MPpTJy52xo69vT9Q2EWIrEdeztYu33dyq91
 nFjpdkPXC2B9TknG4J0BLF9Ie8bXRlcWZdpPZLYdBtvTCfHl1+MWBPWw8SUKMNsQdiyS6HMJK2g
 jdiEvwR6jEPkm5lg3nbCfU3V+++7HBdDWyNgxPD0AcZDs/jyCQ29VjuOWp17ZuwQGjfO6vIp5xk
 PI3Wv1W9w5BmLFUAL2kD/rH8qLNY9WPysk7iYhEEj/oxYcGGoIAFhvHMqZYzqYNAi05qNtcA==
X-Received: by 2002:a17:90b:5585:b0:355:35b0:8b78 with SMTP id
 98e67ed59e1d1-35de69a6545mr12280637a91.27.1775494902386; 
 Mon, 06 Apr 2026 10:01:42 -0700 (PDT)
Received: from [192.168.1.168] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe5e4ba7sm19637959a91.4.2026.04.06.10.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 10:01:41 -0700 (PDT)
Message-ID: <25e0ac8b-8ca6-45ab-ad8b-548016f77f90@linaro.org>
Date: Mon, 6 Apr 2026 10:01:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] docs/system: remove extraneous sentence
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260406165648.997995-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260406165648.997995-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 4/6/26 9:56 AM, Alex Bennée wrote:
> Lest we confuse the reader about something we are no longer showing in
> the example.
> 
> Fixes: 132f8ec799c (target/arm: change default pauth algorithm to impdef)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/system/introduction.rst | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

