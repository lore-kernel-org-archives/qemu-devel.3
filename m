Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453AECA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 20:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utBcc-0000tO-Jm; Mon, 01 Sep 2025 16:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBca-0000sn-OO
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:59:24 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utBcZ-0004aO-3M
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:59:24 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3d965477dc0so286640f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 13:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756760359; x=1757365159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xFrAV7/BUfAZXXKn8t4CkubHNvkcLgfU39lsOzMDwNU=;
 b=OppSy8gA6jsFqRSNyiQnzVuIcU16kH3LK2aa89pfQk6mla5CP0FNm15JeIXcKuJxXz
 k0svpzrqTfVJLgZhcxqG6RKbMfLA9qNbZOgdsrI64XViQIxWqH+w2dVCBBczJ9khG2GS
 N/n/eNV+g1uAA/7rfbqNPfLrPaWkOeIvtrDW42IQ38f1AfkMdgvKcej9KZIqPS8nS3nT
 WG1szGvJNbaVc7YDGWJPmsQRW5VEh52QieK+zFOqAFi6w47pE10kQjhixjm5+p6u9OEz
 CkCPwrDri6ZSIW7F4k6uB45mWo0DQlf8iD8XHZz4eq+Xt8bZQHWJ4MlUvt3yfYU0CE8q
 51rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756760359; x=1757365159;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xFrAV7/BUfAZXXKn8t4CkubHNvkcLgfU39lsOzMDwNU=;
 b=jFDc7V1QeDYAETRiXU6+2P5R/yrJYkE4OL2yyoagxBnktRCGjH75n7PCfFqvLefPYt
 8YbUnY49iSWSzEMCZAfus0M5JtTk7lBCo0BVtmlzrlA3ECQv5uS63G12PA+lLqbEXI3u
 ldH3c5zBKOWw2UZtZYCn5XOcg2F/RSqPgdO/3fpKL/QqCV5IWIHEl+2siQ+O0kmHhx1N
 ipRGVRlUXRzRbJQ3FRplok0Jw87oAO81yHE+s4GhDSn4bFoOXD6uhBRb00VHxYZfk6xJ
 5F9XgI0w+fcSFHf5Y/+kinvZkWCykwm997wZQuHi4Y2JGvXJnbBGcD5zc4BGav8Lrxaq
 wwTA==
X-Gm-Message-State: AOJu0YydhfsAZ7FjclDrW+M2JUw6z9TVA5Z1mKj4wm40VObDNUwo/oAd
 Ow44mUj0yV3zvkfz65+wCK9SWnPk4vgJUhR/Qy0Ko9uFX3Un3rPDebr9FB9/HnT8bIl5bZ297yu
 bTXbQ
X-Gm-Gg: ASbGncsmT9f0hd5G+c5HBTJMEikjTwMcuJfjpl1WSf0yryYkNErtLeCcAozTqgyECdW
 iezxaBTIrnro8dZ3R+p3I4/etsVArTelMeJbh2Jim84b9dRukCicQiUB7C1Bzejif1MNwlKrqAM
 ry8FiHVMxAx8STiAAs5mgSW+cdJyiDD4PjIg2Z+TD6i7wghtlwzENzDJ85hkHHaHprtSTzKysSs
 mTQA7iOCE5wCUl64tvoyquG1bi2sPg7iUzKDJ9PDSaoglffi4caVt5KBn+HPJ1JqzVXwKEudrHJ
 ikYSjWc4aF+RxqSlEAKz7UGT6NPXl4vbIowL4dDtgZ2Uyzx/05vJllMhOE8Bs/ijAhK/6Eo1ucI
 XIIZeQpweH5mUR/8uDj60Yr2XwCFAp5EXlx33Z1gR2ylwjNF4fEI68Zf+JeKvptzjAQ==
X-Google-Smtp-Source: AGHT+IEPvAAwmZOq2tL7nEjhPLBiOAtYWUc8vPScTdIhNirkAZiLSAC/rKSlmrepH25N1hzIUoMMZQ==
X-Received: by 2002:a5d:584c:0:b0:3d4:4a27:af9 with SMTP id
 ffacd0b85a97d-3d44a2711damr6039458f8f.59.1756760359419; 
 Mon, 01 Sep 2025 13:59:19 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf276d5816sm16637964f8f.25.2025.09.01.13.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 13:59:18 -0700 (PDT)
Message-ID: <0568f6da-20c2-479d-afb6-66889910630b@linaro.org>
Date: Mon, 1 Sep 2025 22:59:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about/removed-features: Clarify 'device_add' is
 removed
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20250901113957.17113-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250901113957.17113-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 1/9/25 13:39, Philippe Mathieu-Daudé wrote:
> All other titles in removed-features.rst mention when
> the feature was removed using "removed in". Use that
> instead of "since" which we use for when a feature is
> deprecated.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   docs/about/removed-features.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Patch queued, thanks.

