Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FE3CD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTnmM-0008Fp-JJ; Sun, 31 May 2026 17:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnmK-0008Fh-Uy
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:33:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnmJ-0003LN-He
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:33:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490a7629380so6832955e9.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780263182; x=1780867982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dCkE/F1GKuGxgYCcb8cb4qsK2Gk7UDCq+2NWT7B+q54=;
 b=W94gXTtqfZrAECHVDkgIc66WC57+iBnOvCTw/gHORRhzLHF52gev7qSoIA8CRr3gXt
 N9oXjXXPIePu9XH6h7OZ/EIQVfsiENrJi8uCQkJ305iV4oWy4bMg6qxMjeOxfNRDbUFw
 mv8aOGbSGPYDr5GmLbm6fbXt0wvtHEkmh9/vnPLbSr0YremcXoomNvhA3KnnT0PZXk7H
 7Xae0kHBF9YpyLV1r/0eKaSVz+zF6aVn7o4kavGp3eQlJFybXZAWPc/6eOvgzu+GbgZ8
 80Upu8JzryBMCvsCTLZMTzQxfCoGJPgU3ugtt8HDbDAMXm0vRTGy1a1cGfJzczFBpxyT
 22Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780263182; x=1780867982;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dCkE/F1GKuGxgYCcb8cb4qsK2Gk7UDCq+2NWT7B+q54=;
 b=ZsbCydeFHwBBEMNSEwdaqcHRQBWusI+E3O4ko6rCbMmXo++keMoyYA6ArhsvwpKddO
 7Tpox/yH4MN44OqlG3cANB8yp16C60+odLIbU3lN/eJlC+qCZglEPVFqwEP/8Hsz6pva
 Ffw55CVWuCTDtdzQyT3x7eYTqm0NBVgn+nnXGf1Qwv31+68sUwFrsrm4/vIR324+4Bb1
 cfK/7cA5Lj4ZxcqFP8EK0F9JGkrwK/eg+sbjME4EF5Y6WlOS/zOIcOuj9OZpPzPWaoy3
 6GCODlV6TYoHNM2ebUtHrzn1E8RD0I9n0zHWX13H8LDHqR9fFcGchJwq7VfDkYw3RDP6
 qK6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+88f5XUzhu5OwEohw1+uYfab0ydzU46jCNMlW1FrhVuSI80lU3sIjlm6f6zTNE5NPoSzF/aIxiCNCb@nongnu.org
X-Gm-Message-State: AOJu0YwGKYvogfC3ashHuztGACQlkWxepDsfdp/O5+gVgnQJeUcHz3ch
 1GTUUhHUJo0yEAqcx2Q4jZo0BPksAo3ysXb3EYneYD57kvcOmzPCEukx/QljHjCImls=
X-Gm-Gg: Acq92OE05VyqiyP4jrTXRKKbEcoQzvW9QaNLpi0/jHBKKbYq/ZqLcFpPkVK6PafMtUH
 1RAJkslspFAQi9YOCtViBbBBmQXoDulf7YyucZmCRmcZttr37s/TdBu8hIlmyp/T6VCSae1oCNa
 Wg30b2SHek2e04kk8ZQM8k1hF1N1Pjav5fNf+0rZWHnBwtYIEo7KUyK773hK0ivbeUAltLJWFxf
 H4A4atKmHGbWt11PJ06SCNS/2FcbnIwMz3q7RPEIZBEa3nUcGkg8/o+Y6E4LhD60gGepA7qHPYD
 raAKauF3JyOfTLKnG/jtDsejS9Ba25G6tjKOV2qkiXVgEYP02+boR4XvXfqAN96M0kfwHXPBMCc
 Yt8IquFtGBZEA7ni9x/q+zitHLkq9YOJe+In2YqnZSNy1cnKcitp0zS1QmovLrtDgWxddSOJ1Et
 X1xlIYXlLJEZNU4BEkAbvBgQc9JUSfpEM8GNPKR5GJ3cNJbQ1uuA/e7CT1Wmo6poiHLjQ2ok1eI
 hfH
X-Received: by 2002:a05:600c:1d11:b0:48e:8741:fd42 with SMTP id
 5b1f17b1804b1-490a291fa6fmr151217035e9.12.1780263181596; 
 Sun, 31 May 2026 14:33:01 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c967c77sm218703535e9.1.2026.05.31.14.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:33:00 -0700 (PDT)
Message-ID: <b9a9fe50-ca85-47cd-9672-c56f2d51f3ec@linaro.org>
Date: Sun, 31 May 2026 23:33:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 35/38] target/hexagon: Define MMU_INDEX TB_FLAGS field
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-36-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529215554.606133-36-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 29/5/26 23:55, Brian Cain wrote:
> Declare the MMU_INDEX field in TB_FLAGS and use it to extract
> the mmu index in translate.c initialization.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h       | 1 +
>   target/hexagon/translate.c | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)

Squash with patch #33?

