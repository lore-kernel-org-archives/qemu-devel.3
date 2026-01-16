Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD278C9830A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 22:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgscg-00043A-Q0; Fri, 16 Jan 2026 17:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgscf-000425-54
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:48:53 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgscd-0007rB-7m
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:48:52 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-81f4ba336b4so2437052b3a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 14:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768603729; x=1769208529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sAC7e/d0bBtJEIwHTiI41xr+WOUYUHqJkfZ94sKSblk=;
 b=VxEexn8vgYhzSSqYyEIrYJHQAOlxLekgzgUMfKr3zCaOuPQq5RIX/UAnTD9Zq8W9iR
 fH88PO0Ht7NFhEey9lyGorJB+3CsZtr5VyEddN17wF2qFrRA9iorOPWU+ntiEtbO6BNm
 Lz+98xaeE43GT7hZQ1XF06JLL9Z4jSavahec73cMv/EV/to/adogKw3Jqjj+2CY8V0AS
 +Rdr2q585/tGqH1tRxZwaGdRy9cPMhK1GWfoEgChC2TvrpcGxX6q9Fg+ShQlOQ0UHYqf
 OLwz5lB2gCBOW9t9NZzNBDsUl6XgubBb6Jj1+ug9GjWDJ8z19AyZTWOQhbI9A8V8MOUD
 izew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768603729; x=1769208529;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAC7e/d0bBtJEIwHTiI41xr+WOUYUHqJkfZ94sKSblk=;
 b=JmJq5ph6exys9OzWAigOFCxgwFC8FLWJpY8U8NawDBHtDDeyxSvk+EyIMKS+MIUNMR
 dZKmrtls6HeMUrLglmsJ4gOeSMqP6YmYVzBeQhrcN3AsJeOFFGodCivWa6hCB0lHJbPg
 p9VmkL1M5/a10fRLKwzCWOVlIKJFzjnzPthe+mvfXl5zpMk1ZERvGvcIYDxSCfTSr6SU
 oPdrijfxjGx1H0JnH4mPnd1dZDToOG3qc4oZlnMxaWZwp040tWuM+QUeyigfCM/asgwO
 hM0amyt9GF9/iN539L+MhIQhsBajDLnSuSHElYVA7GSU0MtJ0KIOiLvUZ9PoK2MYqvyk
 uipw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAhd9E8ABJsgNiDe7pTHvfujI9Q1ny3HaM6L6AuQwyr8Fr67KvwcYC9iRWnfDFHUAoLtE5VRrXQYG0@nongnu.org
X-Gm-Message-State: AOJu0Yxbr8suTejrLXuUYBsiuGG+c9Lg5k/J6Asf24/JMqPthdLXi6Mw
 kq2OJwVP1y5UP94ly/WFPVDheVR/5pCJfE78udLIYwTl60n2qUX5ZfU/MqzdON/q218=
X-Gm-Gg: AY/fxX7B7oRRTbgQanF546mllB9xZwqIslqitIqgn/COIS/0khzIACIzwfgRIVELHAI
 j6b8/aoW+oogA2bcpLf/jS6MJSz0iFgUvZuvVajh/xqt9i7sJoTSf3d5SRuUHUUgJC+DsqEtFzY
 VJwnjYHOHtqWf4ixksth6lyD5NUayveEjhj3c4/hDeAUG+T0n4woUwdoJ8AaAr8+oElQRISR+oE
 tmMYN6yCFEiPuM92pDfLBeU2edyfLHWNC+GxtXmXHHgZ3gunhmAEKYqOxllGmeoNCHJwZjSdbnJ
 wb5ayq9VktsX4FvtjFWLDndjZB+2qPG7CooTXCqjRkAP7+SsUk8jD4VWCNbMPrVJJwZJzQ09fuM
 VLOwJ/UkLJUYuzefBNHrPC/sMEKq/OQ6sHP/a/de69CMINCizYZ7XHmx6a7PdvtOvgDVkMxcKFX
 odiSNMk1socR3RdNnpykx9Bi7rcE3Z073SbfC2thwP2uAmQg7No5+mIpTo
X-Received: by 2002:a05:6a00:809:b0:81e:6d2d:90c9 with SMTP id
 d2e1a72fcca58-81fa036a13bmr4418600b3a.39.1768603728988; 
 Fri, 16 Jan 2026 14:48:48 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa10cf1e6sm2884832b3a.26.2026.01.16.14.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 14:48:48 -0800 (PST)
Message-ID: <6e8b7db2-fe09-4901-817d-21678c986ca4@linaro.org>
Date: Fri, 16 Jan 2026 14:48:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 52/58] target/s390x: Simplify atomicity check in do_csst
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, thuth@redhat.com,
 pbonzini@redhat.com, philmd@linaro.org
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-53-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260116033305.51162-53-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 1/15/26 7:32 PM, Richard Henderson wrote:
> We should have used MO_{32,64} from the start, rather than
> raw integer constants.  However, now that the CONFIG_ATOMIC64
> test has been removed, we can remove the 'max' variable and
> simplify the two blocks.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/mem_helper.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

