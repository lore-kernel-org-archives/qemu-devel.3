Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC45E1091916
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Ktv-0006JA-IB; Thu, 19 Mar 2026 17:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3Ktu-0006Ho-AR
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:27:30 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3Kts-00077H-QS
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:27:30 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so9007865ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773955647; x=1774560447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JSu9iJ+Ai+uTxKLZdU7fFZp7WivAO2Q5DSXtiW2wbgc=;
 b=X8msKMmy84qTcjl1RyxDxMg70p9sQrb1ETvIMSpbujk1b769rzc+Jd8FLY0+wOd8so
 P3GHncYDGyW3mJ9UMK/JrPqDV5qJgUVAWjlh2w3/DvvnHAjN4ET+SJstsuXzzxt7ZGgl
 mYKAkhWnB2Arrp9AP65qusWSiIyY3key7EwSCLBrQkESEvIe5TkDPLJtQnkVaoeVEH6z
 8q0FIOJZBf6rrqMBbHJ1tD4EI6c8zZ/QgpUZEdYxiu80BGNRTSmNLCDdWVXKsbNVqaGq
 2gPnwsAkKWVYLE/jTzujle8EN+qXk7J44JWxNelY7RWX2xzBOV4EoKFWI6m416IF98yc
 60nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773955647; x=1774560447;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSu9iJ+Ai+uTxKLZdU7fFZp7WivAO2Q5DSXtiW2wbgc=;
 b=qU+mvI7UrUZXFYkvWtYk/ln0Tl0Jp8F57IrH0NBR5AChMTgX0ZllF+Do5i+pCq6DS4
 YRP9xJTFQlR0AF1fYjdjBSO3pufWf8S0RaTEsak0xsd4UsZHKhJtBh3SJiiJC3BegMbN
 pCwtKYNhdLdV3f+iEmkS5ehkMn1yn/riWeO1AQ3AepiTKuYX8lf1J1Vf2y42bFuO+wEz
 C7UZCy03YkwUflZVJEAMlVy7ckw5Hilk6/tjm1Qp9CR9QkUK2AB8Bw1+UWSp0BP7D138
 HM+et3HzQ8vACao8M6pXwnFZ0A8u0hDLTflDOVUU4gTXndIc0oX0nAdwS/aut81IkMIY
 cO5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyMimdOPbKR+ak97Oxns8IcOb5nUo2FOhLDJGIAq2UuBZH0zVBb3Wzhv9cmR4FfAqRgIcOUCJn3Kw7@nongnu.org
X-Gm-Message-State: AOJu0YxpBMTO9rjUgOtfRN7W7D3sdP19NEMPE6TyFhuPVgA1+O9TXu/f
 OnkZKVX7prDWsRJVWi0Zb+kFAGEfGxgbW0EopX99ejsQDfvZmVbb02MXb8BENCW3MuU=
X-Gm-Gg: ATEYQzyXyrqTJf9fFMRuF8bC3MaF6wJHerYxQOCYFHmypjY331qJTDlbvF1Fs29DR53
 0fhNYIxL9IxRUg1/ewW/23ZuzYMQoBXrmuLO/xdYCPAfyKFSa4Wyvrqw028w83msc+5IZJgpZ2C
 Enl/Yspa/h9CHOYqMT707Maq4rzMEQiLldnIZXLWE2usCjIKrPDfSOO83KgdL6pDtwc76l1RRr0
 cit/EYx4b6Zk8qDXsmVJWfHFLdtmKAq/jzAgly9H9Ym5ddTfV1sonAP1ST8W22V3zKaJXmCcgbe
 JSE37XvDMx2wBCGvUel6k/GX3yDT8LNkjF+J55/SKdyFxh++eDIVyt9CQ9Ap9IOvz7ksCmJlHHQ
 dy8DhBOp7UWLns2xFLNZ2jy7K6jzK1EafhgkC+vfKQHklsn+Xidjc2FPtdXo+89JhES3BhZMZ/b
 N1XOwycT7/YGJdE6Fw/dsn4CT/+JKPOCHv20FfEdbgIppjI62Gr0ESVvz5oKNwPA52KziF
X-Received: by 2002:a17:902:e551:b0:2ae:c9be:5f30 with SMTP id
 d9443c01a7336-2b0827898f7mr5965525ad.23.1773955647099; 
 Thu, 19 Mar 2026 14:27:27 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083655b68sm1753605ad.43.2026.03.19.14.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 14:27:26 -0700 (PDT)
Message-ID: <23215f96-17f6-4eb5-ac50-9bef80bf5e13@linaro.org>
Date: Thu, 19 Mar 2026 14:27:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: Remove unused variable default_cflags
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260317120215.2075164-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260317120215.2075164-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/17/26 5:02 AM, Peter Maydell wrote:
> configure has a variable default_cflags, which was originally added
> in commit bafe78ad3bc4c ("contrib/plugins: use an independent
> makefile") as part of it setting up the build environment for
> contrib/plugins, which at the time used make.  However, we now build
> the plugins with meson, and in commit 55c84a72aba4 ("contrib/plugins:
> remove Makefile for contrib/plugins") we dropped the logic from
> configure that does that makefile setup, leaving default_cflags
> as an unused variable.
> 
> shellcheck helpfully reports this:
>        default_cflags='-O0 -g'
>        ^------------^ SC2034 (warning): default_cflags appears unused. Verify use (or export if used externally).
> 
> Remove the unused variable.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   configure | 2 --
>   1 file changed, 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

