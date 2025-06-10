Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C248C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyQ7-0000mC-Np; Tue, 10 Jun 2025 08:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyPg-0000NO-Bd
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:49:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyPa-0001g0-5D
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:49:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so32655235e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749559743; x=1750164543; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AoMikksxnXdYGRhyqfdY38jzMLWdVcYKsVpV/YhTMQA=;
 b=SyT6Zj9F5mrX4Bx7/OzF3NOzdUFB2nKO/XJl5fjUHtAkxFwi8hYGpU4ewLv2kcYZhh
 4XTxnZ7KDFKmufOeIKs6RUyvQcW3XLeO2d1lXvegQS0HTifZaGTo7oCkh61WdO/fhPot
 1spdFpZmh5OJi0mBVq9g2cefmE/UYwu2X2Q4rHY8uTqSQZEtpdOYjc6mhNHam+XY3xyn
 YMiw98EYfB9cuX3LvIhzj7bqMf2WA3IS6VzIQHnTY+dQ/HiJy6VOjK0oxrpyVNVcefYy
 MsUx1Qcz3D2oN/ULnm+JKwU8LYMgfPZtzSLjkE8+j6a8ZR4LPuQBaVauK6L6hqvurTcN
 IPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749559743; x=1750164543;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AoMikksxnXdYGRhyqfdY38jzMLWdVcYKsVpV/YhTMQA=;
 b=QtT0hOxIQ7udr9VxhJrfBsshP0t9qI4H3lV1oenKQQoQHhAQb535HOU8PKYv/Co4Hm
 qT33WFoLstXMSYun1/V6bIcX3XOBhOFsx7z1f2C7FdG+TZuhLdL/sCStyuevwIlzWBlm
 5Uz35WnRUTTQo/jEYnUpzYiaBXNNAC5EQWbInEJgkTVJ1ZspvQn5rV65NoHvLxvcKBo5
 Os2pPzgCNKm3mLR6sDAgxyqt32Xt1YkplatUyzYpTwv6FBrkVzz3R4Hfg9vUupFJfMAY
 qu86PIzywRvGcjpXNQx76ipUL6qO0R6RdKGxb0hj7EVpz8PNFKgBmLn0cZeyJR2JnL1x
 Djag==
X-Forwarded-Encrypted: i=1;
 AJvYcCU588UFBTE+1JR7ns9B4CZF/y3A91tFaKKenvhijkwH4iGgvq10tLfqMHWAJ2N40LGKNPU7x/b/UGtN@nongnu.org
X-Gm-Message-State: AOJu0YxWQf1fAFZRjdoEbAnDm7AMbCCpUEmUa7BFx596xvOMTMaQ8Oq1
 /4RbO7SGlc3RGmHnCc6J/wHnRuLVNxs0Q3LXnOrHcakqgDp7sS0WmDE/jPKTfubvTd0=
X-Gm-Gg: ASbGncvUTF6XfXgDEAhASYnzr7bfCeWGds4KylEsH2JYW2Kv+aWUF3XlBjlqodz4kPq
 ouCjzM2voVRBcuE2HGsEW+uG4Dzf+OpSNtO61G/ZNvgcB567rIEgQT+uOFbqgRcQejYoOw91N7Y
 qgNFgRg03mEcmVQqE+vTBH3z/aA6+nyhO3P2k7bqJrvSiYBdBWc4jawTJ9qYprsZU42qGxHFd8r
 KDxUOeaiwZX0Oewsq0xhZWqjVPooQuGX9j/oQKMcxVBw72IqX+bxjeqPPr0OJZl8zzCesm8Z/+v
 RefZRY7UTbebkQiCJXHtd2SMwHGKrYQlLnYnhgkDyLLeDkY5xRyczgBm39U9fC765M1HK3nXLaZ
 XrB+fFkVoMJNv6CxT6D1KUfaSJU6XtTISbOQ=
X-Google-Smtp-Source: AGHT+IFExA/vxNyfJdsqAvxybPHbjN6ERBgW5E/z+Reol1sptXJYy/aBskkRGn3fpI6cG9HeoWu6tA==
X-Received: by 2002:a05:600c:4691:b0:450:c210:a01b with SMTP id
 5b1f17b1804b1-4531de673c7mr27799755e9.17.1749559743444; 
 Tue, 10 Jun 2025 05:49:03 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452669ada25sm142090435e9.0.2025.06.10.05.49.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 05:49:02 -0700 (PDT)
Message-ID: <50405e77-e665-4772-9715-3901730d00fd@linaro.org>
Date: Tue, 10 Jun 2025 14:49:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/31] Skip automatic zero-init of large arrays / structs
 in I/O paths
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20250610123709.835102-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250610123709.835102-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 10/6/25 14:36, Daniel P. Berrangé wrote:
> This series is an extension of Stefan's proposal:
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2025-06/msg00736.html
> 
> It used '-Wframe-larger-than=4096' to identify all code locations
> with more than 4k on the stack. Any locations in the I/O paths
> were chosen to avoid automatic zero-init, to eliminate the performance
> overhead of the automatic initialization.

Should we eventually add it to our default CFLAGS?

> Note, although all the changed locations are I/O paths, this does not
> imply that the changes make a measurement performance difference in
> every case.
> 
> This is because many of the emulated devices are likely limited by the
> emulation impl, rather than any implicit memory zero'ing overhead of
> stack data.
> 
> None the less the memory zero'ing is still a redundant CPU burn in
> all these cases, so I felt it worth setting the general precedent
> that any data over 4k on a stack in a device I/O path should be
> skipping zero-init.
> 
> I did reasonable review in each case to identify that the data was
> indeed initialized explicitly later in the method.


