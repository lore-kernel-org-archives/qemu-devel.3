Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CA7EDE9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 19:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so6NN-0000Nc-A6; Tue, 10 Sep 2024 15:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so6NL-0000KO-4f
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 15:18:07 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so6NJ-0006Eu-HD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 15:18:06 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7d4f8a1626cso4664869a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 12:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725995883; x=1726600683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bp+Lb4jAA1TZLo5WsOFnHJj8Ljjy5esPyPspHtQk5fI=;
 b=HmE9n2PmlyXBg9VKiT+3+yCryDiTkJel1a6kOFyM+Jl9Ol5dTjetX8wQxVjclv8Fzq
 etu6vTcjC1rNkWR3qwQhT2+ZY9zb4CNeibpt0WL4l1SvNyyGSl4Jx26oa9cp4+Denlx0
 Xk7CkYqm94/bE5+ggtCqUb6Uns3xJeRYS5Kv9ungGCFvv+dJ06eCbnK6iQYChonlKz5N
 qYHQ0t8F33yo7Qu8Tii+buNJ78k7HpNLuNsodYCWnHsIjInhzZCCm9+hXnQF1uo7tau+
 vF7w52xAy9pp2YEKssqvGH1G1hY1LQBmBu5oL3BkCY+0TVWIDI/Tb+UGlfpxuei12KER
 9/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725995883; x=1726600683;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bp+Lb4jAA1TZLo5WsOFnHJj8Ljjy5esPyPspHtQk5fI=;
 b=jUkjOFhDNBY0U1hIpxhJBje9Zuvl1juKB3eNrl/pWNlWgbyDwVE2NaAcT2Iip8SavU
 RGSZkrkXvDBBYVV8kMWoQJkLbrSme1FruqL4QkiFSjkx0Aw6cv3n1fICutIap0sxflr9
 5RzLa6Gd3oOG/jWiHcsIE5nJuv0XTHdRM6/Pu/2RHMQJPfj4Oft0MQ9mB8v6oa6CxoUD
 nJE1lYMwG84cyC/2soDwQRbUGETdGLTbipNNsRKd5OzL7nphagjp9jcltqSGr3MRfUqZ
 QiY1MeNBe2zmyLOx6eNTV4HweqnLNNAyTGnM0xekqPvRfuvR1AOrGfO1PU7PjrHVtUv5
 a4tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwyzj2p8f/3aUjcHurzpvcndUq2VhrAAAqCrATIfavZeF4PsWzEM6TebXg516qHaRGEdIOpjIZIYwB@nongnu.org
X-Gm-Message-State: AOJu0YxPfev3o0hNBKvz4Nfq7eTWA2vSwxGmVTR4+40tlKvOxch7hGyl
 ef1r2213hOtJBZHWZrZ4NCdnTMUVLphcCh72ZTNV1S5oNp4kviknw2yzG6ylEkuCWN3OtgMfsMG
 l
X-Google-Smtp-Source: AGHT+IFKXjge7M8V7+RkCRLG+dE2atytHHkmQCqSFSYPTaCuyeooA5Ut9pL0wSxdDDWpFcn0hlhFUw==
X-Received: by 2002:a05:6a20:43a0:b0:1cf:206e:3dd1 with SMTP id
 adf61e73a8af0-1cf5e136f62mr2520875637.25.1725995882634; 
 Tue, 10 Sep 2024 12:18:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-719090c7c22sm1687231b3a.203.2024.09.10.12.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 12:18:02 -0700 (PDT)
Message-ID: <ec1f551c-d30f-42f3-ad7d-aca593d492b2@linaro.org>
Date: Tue, 10 Sep 2024 12:18:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] misc: Rename included template headers using '.inc'
 suffix
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brian Cain <bcain@quicinc.com>, qemu-trivial@nongnu.org,
 Anton Johansson <anjo@rev.ng>, Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240910112833.27594-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910112833.27594-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 9/10/24 04:28, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (2):
>    target/hexagon: Rename macros.inc -> macros.h.inc
>    tests/bench: Rename test_akcipher_keys.inc -> test_akcipher_keys.c.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

