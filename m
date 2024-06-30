Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FECC3064D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 16:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNxsC-00078W-HF; Sun, 30 Jun 2024 12:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNxsB-00077w-EY
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 12:57:55 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNxs9-000681-Ty
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 12:57:55 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d55db7863bso1567044b6e.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719766672; x=1720371472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aw9EvYQaWsba6fWp4636361M0Whac3FMHIkcsb/E8Gc=;
 b=pQ8cah8DqXUu1lgPRPHv+yh+6/TdX91OtabxMeMAI4W6YWcKJqmNvHev1fjVJg892K
 0h/u64VkrHgZ+bzUOX7+By5tHyN8G1k0B5YLGK6vIn00gep3OREv8GysFlp49zk1UXx5
 JbsjHooH3wggyS3Y0u1qwfPVBFTSsT5t+AauUea+ItQxgxbN6sXXyb2ksvUP2W/gzmSq
 XBGFigpbE2Y4PZ+v2cl5Ssz9F1GBdxjYQHh8a13+PlekmRKd+2LIjFN951juheHeizbg
 sKHk4xBqWXkbFtpCBrnPWcLzQvNzAaU1or/OCdWCZkbGJc4BVGBDbuBtxJMywZTQYavc
 GGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719766672; x=1720371472;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aw9EvYQaWsba6fWp4636361M0Whac3FMHIkcsb/E8Gc=;
 b=QGs5EQKaVnjmLwQgOrWE9keV0qRbngnOUqQEIix+WRBDoLOCQWM3pOq/82pTazp5JU
 +Qa0Z4754tR6jGgsdnvcs4lw2M+Me7SrgIEwHyNPUom6aLWN0MLm9uqjYjER8lU5AuFo
 oyf951KzJkg+V3y51lwQE7P7l+aAWYE4FJ08gdwvEiNJ9dA5pOlQT95u0PUmO0oG0KpO
 RAN6JyGso/P+tL8aZYcZUY5djhSjdxUxhGICWqJ8DpBvD/NZuU6rX2AWKLaqR24lPi/Q
 ACLKF3Mn7dVr9yrgJvatVPvGtz3c3UKzawJAco3ehAjYlLekJyBlY7G+CXtye10l6jKb
 8FVw==
X-Gm-Message-State: AOJu0YwgybOc5RCpvH58NOU93wOlPyKsUvRR1rQrEUlW+pZ34xtMMRoG
 yYpk6dEvNl62N4XQzQDDBOS0uu5ZjiiTNEvfgKktrmgw4OkkV7T7gTGcXw4G/00=
X-Google-Smtp-Source: AGHT+IGwMlF9G6+yzRuG+X8sM6DYWJ9TY3DUOS1XN9HEtt0V2FIa49Lekc2vTwU8YYFrVWN8llHozQ==
X-Received: by 2002:a05:6808:19a8:b0:3d5:5ed9:b92 with SMTP id
 5614622812f47-3d6b5689b97mr4177465b6e.56.1719766672438; 
 Sun, 30 Jun 2024 09:57:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080295961fsm5014299b3a.93.2024.06.30.09.57.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jun 2024 09:57:52 -0700 (PDT)
Message-ID: <dbd64b52-5e33-4726-9be8-3463e57d1d30@linaro.org>
Date: Sun, 30 Jun 2024 09:57:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/ppc: Move get/set_avr64 functions to
 vmx-impl.c.inc.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240630120157.259233-1-rathc@linux.ibm.com>
 <20240630120157.259233-2-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240630120157.259233-2-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 6/30/24 05:01, Chinmay Rath wrote:
> Those functions are used to ld/st data to and from Altivec registers,
> in 64 bits chunks, and are only used in vmx-impl.c.inc file,
> hence the clean-up movement.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/translate.c              | 10 ----------
>   target/ppc/translate/vmx-impl.c.inc | 10 ++++++++++
>   2 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

