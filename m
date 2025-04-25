Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE013C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8OwJ-0002Fl-Kb; Fri, 25 Apr 2025 15:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Ow3-0002C9-Vt
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:42:11 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Ow1-0007Zj-GQ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:42:07 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22c3407a87aso42206795ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745610124; x=1746214924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rSRqlMxenuE/8LzP1Uvtc7lrpcHwTspjhwuMrK62kjU=;
 b=dyUM59sxMFlLPDkK9XMR4Ni14o0UqgLOugEZyPY7xb8jGZKsAnzwWS7jpa3KrqFWpr
 aqw1HOgBsA9bcpYlz32i5swz0fYRbpnEIXV5t54AUgFJ/PtfOkPcrjAIy1QtqjZYKl+q
 OeBP2/WScwwkkv4UptEpdLOc4mD5+j7TFpBXcPCN5n/OBvBgrSpI5mdxNsytroJYGlFm
 uE/TSvclIT0hvVGLs6HJCcWZFE8LwnUhj/v4H6TtenFnhVar2UE8P+87TWKKI1ZmEn/X
 l7ysyEoQx7sw1SDZIbWir61aUvMjVZub3ttmpf4jH2lO6MB0lXKw8Ky+I2rNGV+mcSJf
 tysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745610124; x=1746214924;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rSRqlMxenuE/8LzP1Uvtc7lrpcHwTspjhwuMrK62kjU=;
 b=Pn9Md7UGf57U94FN9zbE2DlG3QNPzzHdKZTVcEXZjqQ7O6aX+V7JbN0jcluC4CI+tk
 wlFn/fcKx+ARJJRg5rXX1Cd76yJ00GrjfRGzZ4PEDOq0FLHO7MwB9cqbPLH4rzZxDOFJ
 CaUjh3vLKqWLdUQvR61sNhArRihrKaSXs9ey2VxVkc5wNE160bgJ6Q5rkWmbQhQa4OX2
 0EPya+ivU8p/QeQpwajlL7iIhu0Fy/W5TBSxs+QZ4j59tzzuMuXiF5kveFADqMRqjpm1
 RwNpl0xBRN2exoqqxUz8e4rQnIc+ZzJz8ZEwpuRkjOTseHoUPQ3Okmfono8d/g3/vJIX
 szfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaeCe9VuLGlCixiutjHfR3rrRhMGgWQCTC9FEZUOWM/aM9yOZVPRLQwDJ5+/51xpocJj9z/v0yvSHX@nongnu.org
X-Gm-Message-State: AOJu0YyYLzO4T9z6mUSLh3I5tcgYL3ahqNepwMy92gjubLoy9cAxbaHq
 v/G+GA3gmwEV4EPx9eh9TBiRWB+5CfZiPafDw301E51olBSf2+K1JEWmfEkj3cU=
X-Gm-Gg: ASbGncvucYEwtCCr6Iyq71iGLS8L+mZTM81DpBVhxBj5/ZtD1vh0IOpg1QRFfbTi0Yy
 2e9OiWitLI5f2DSoSWp/MiWnH25aS9yF5LoppDY7VJVTmX85d1buMkbIGlhYVULiAdnvkZAMdgI
 YWPDR/4FMPwt6gNSDwQSN+n5oOQj24BX2smOEUKNC0VFUR1Sy88eMrCpHiAcQTbjfW8nn6pciZ+
 /eRK9y3PZzLqgS8ROd9PO65LCUUdxwwgCERSw9Ta+Sy5Mwg2KJ2fGPydTScU5kW74coErovg9gl
 sjVoXEUpFl8cVz4cSuW/oibiAh4iqhjb5YLUvrZCtRgzuVMtZnhI5Q==
X-Google-Smtp-Source: AGHT+IFUdN3AoKhuX+wQgSTz7eDkm8qzMqIilAx9NperY8ZgVFaDNRYjnqS5M2JOr2XykLkv5JPMCQ==
X-Received: by 2002:a17:903:8c5:b0:227:e74a:a05a with SMTP id
 d9443c01a7336-22dbf740429mr60447395ad.44.1745610123881; 
 Fri, 25 Apr 2025 12:42:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e7a9fsm36452555ad.111.2025.04.25.12.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:42:03 -0700 (PDT)
Message-ID: <3525bdab-0bd1-4918-ada1-46e0f35fbf66@linaro.org>
Date: Fri, 25 Apr 2025 12:42:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] accel/tcg: Simplify L1_MAP_ADDR_SPACE_BITS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> Stop taking TARGET_PHYS_ADDR_SPACE_BITS into account.
> Simply allow the entire ram_addr_t space.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-maint.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


