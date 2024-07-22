Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49B8C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 22:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW1Iz-0002gB-1Q; Mon, 22 Jul 2024 18:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW1Ix-0002em-OV
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:14:51 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW1Iu-0001Oh-IL
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:14:51 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70d265e5278so826570b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721686486; x=1722291286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9bm5ZHfIENt33oX18YmEAbA4/5twgdpC+ydOn+Iec70=;
 b=p3hCWuHQ8UcA6KCdWeFsq3AUoRjrjvXLJC8lBXH44b3fck6WBE9bb8bjv6kvHbKKbz
 qBvAKIKuq6AB7G+0yEYAFeJ3iMF6A3En41w00ci/DVav1P4UsvpES1ae5yUdO/GC6iMV
 hpb9efMxlSwpPBGCDTwRCmo/KO6QyQegSDxAMiWj2kTA7kEkKGpB+sTK1XypQ7dKrGZE
 Zpm4QyXRkq5HFUYyGKAcqciW96MN5duEWVSakfevF1bIa1pysrYOkftnR+PWD/ZeOXm6
 G+WG24KVmth7We21WLzqE9IYvhZGWyMMwZhJ60pq79HTfGtXoHsbfSDQAVriVfTUEPzX
 5OWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721686486; x=1722291286;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9bm5ZHfIENt33oX18YmEAbA4/5twgdpC+ydOn+Iec70=;
 b=qXN4dcBexS8ylVOguIV415Tw9cZc62MTFqUaWsMjk5IByhXMmRdbnZdwXkAzCt4fDr
 25Hs/I+aVJEbt2gCmTXMDQUWXfUYMUFsiLGxpA29WlAIOTki09hVe+Dk/RHJwnED480g
 IAc8UGQnxfl5e3ZaDxilO7ZE19oEVftSvkIZyGwymMbZoeCi5+aQ8F7jbncdZZgdanWp
 6KrOe3/11RFQgqUJ4g0Ru/zpxvUus2IinnJMYmIatVWIP/kexXaA6LjijAj/w0lOe0kg
 6cijBfSGP8T6z7T6K4VmHHc4/WykCHDl9/aZ8jbBwHzNPtN1dAHEGZHHT5LkpMsr+qGg
 5Z4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbRb3p/suPtMj7szWUkBYla+xtrwIv/qKXjf24+j40aQ5Sjyr1DJRBC9HMeD34n/BQDvXs6u/wiVuYgExPEL/G8oEGUjI=
X-Gm-Message-State: AOJu0Yy1kY93Bl76F+VgAj9A49rXliKhjW5EKitjTS+JnSVXojrw2I5N
 x1q06/tk0H9KHaOx4X9NqgU5srd23JcpMppkznsg/hyMuzlIF6+TT8qF5KdpuF1Oh6LsnItJw4h
 1h9y6UA==
X-Google-Smtp-Source: AGHT+IGBymF61sYZOV0Arvo1GF0f6rRuw7mii+jV/er1xTJfPPaOJQ+uFUHmBrkbGT24gVoe4cd+Mg==
X-Received: by 2002:a05:6a20:2d23:b0:1c3:a63a:cefc with SMTP id
 adf61e73a8af0-1c42285f614mr7066636637.11.1721686486160; 
 Mon, 22 Jul 2024 15:14:46 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f31d2bbsm60096285ad.132.2024.07.22.15.14.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 15:14:45 -0700 (PDT)
Message-ID: <10a16394-ac70-4cf6-b72e-b39749d64871@linaro.org>
Date: Tue, 23 Jul 2024 08:14:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/arm: Various minor SME bugfixes
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240722172957.1041231-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722172957.1041231-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/23/24 03:29, Peter Maydell wrote:
> 
> Peter Maydell (4):
>    target/arm: Don't assert for 128-bit tile accesses when SVL is 128
>    target/arm: Fix UMOPA/UMOPS of 16-bit values
>    target/arm: Avoid shifts by -1 in tszimm_shr() and tszimm_shl()
>    target/arm: Ignore SMCR_EL2.LEN and SVCR_EL2.LEN if EL2 is not enabled

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

