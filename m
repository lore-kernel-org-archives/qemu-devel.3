Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEF6E9A04A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 16:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt6wr-0007K2-TH; Thu, 19 Feb 2026 11:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt6wq-0007JQ-9C
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:32:16 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt6wn-0006He-Sn
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 11:32:16 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82491fbf02cso603405b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 08:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771518732; x=1772123532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BmTh0jnwm/7Hn5VDO6WKksEgvE6xJqIOQ06tdlnmZ2w=;
 b=Se3y0N92jPQSS+xWtyIgORagBH0p32xoYgmeelMiI3KNaVqc5QuN56dPdiHcvWrExR
 vYN7vTWbJSNMZOkKDVK2uLbBcVdhQpeWjPLbSYggRZbGNvoFDy93mFCSqXEqwmP34ZXs
 lS5pblKsNYCnQRnnYXX+VRYkZyx5jQpmuTH5qcA7RTW9wVXpBKG1zq2NpnUWzh3wcA7j
 eb0VdEhc53UEI+JuI+JN6fSno0xtSZkCO0/NoPo9OHaTyiMgjIaM+CRrTOrPxIcnDxTW
 SseeAKREuFbwvpjyyI9x3vW8OaXSxjGI6pwv5pwzP3fGskIMvZyK767DHPheeKjt2Cfz
 i6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771518732; x=1772123532;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BmTh0jnwm/7Hn5VDO6WKksEgvE6xJqIOQ06tdlnmZ2w=;
 b=peJb/kkH2y7sQGDTXnx4v1iHR8M/vtoAFqsfzmkeaiCb6Bq/QOx5GRmMcrLg4qomZM
 w45dfZdsUlZ1UDKj0VLhhof/HPajeXgo5ODnldtxcndjfWekqMZTPUQ7r8K+CWd6u/9s
 VQ+YvR7qRKQcbqCjgEMkDIADORuHswAMEbU1A1krFnsj2U6wWfQtbEA13fQycfgfb0pD
 qmW7lZgv3EbUJCI+wbjBWYauf5+8T5ssjOxHitCD5NRUD16gBlz1DlInPl5r0kX9x2tx
 5By0m0wmwnpI+OnsIpQswunF5vYbBFwZPGrJVuriCpuLtrpLqd5nsAbpvzyTyVBZlIf8
 xh3g==
X-Gm-Message-State: AOJu0YwMOT9vRZ6xOMtNs7h3xyNbVZJ3Opcu2AtsLdM0Mmk1wEze2Obd
 k/WtPrxn+rBtOXaXgvI96qSM2GTaRHGs3J+GFh51voP5wGpsvSP+2HNKrrJNlxx5e6s=
X-Gm-Gg: AZuq6aJZ5HD5k5VDZCBzX9UVcOzyMeGDt5SpQGL56XlRjLAaagK2YSuYB5pJ7CdFtaP
 QmFibSdtL4LP7am49XzpG1b7n+B3rjEAltMvFSf4vlN++wKX+dwA1LUBwoVFXQp/4+CJjFl/R/M
 I8psP/GBeztlOtdma+iRup1U1fDlyt9E6kRD3K6iNSrG8WTyNb6jbkc6Q2cS7xT9KRP7CRbe9Y3
 G0QSCMunzH9zcE6derVNRmdgEqbfQMAI1vIvxxqYYRY2t7uAyhiQEZwDMdzijiJpRtrw0igOTZ8
 XNXK06M2RKCPO9oPHkbW0pXBjwHmLWLmMoJ50VRlrbMuuiF9sP5bhnBVcZyvOLcPhDS24kFIan/
 1VhEt1oom/xVBWNq6TXAZebW1QCfzw1RnxEsMhWBpIUfdvLiOnyTJUD123spYAwVWl5OszmjEzJ
 g/kEozJc6muznfOBtzgE3Xd4KWDp7PSyWGYaaoYju4ceTqB1nYLiCYMJuS7DVCP3B7dteI
X-Received: by 2002:a05:6a00:6c83:b0:824:b1bb:f6b4 with SMTP id
 d2e1a72fcca58-824d95f49dcmr15511190b3a.39.1771518731964; 
 Thu, 19 Feb 2026 08:32:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b69f14sm24859331b3a.35.2026.02.19.08.32.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 08:32:11 -0800 (PST)
Message-ID: <37acb360-6425-47c8-8452-cd0c610c2fed@linaro.org>
Date: Thu, 19 Feb 2026 08:32:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] target/arm: single-binary
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, anjo@rev.ng,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260219040150.2098396-1-pierrick.bouvier@linaro.org>
 <CAFEAcA__tnvy9dUUPrEG8jynGGSp9iz0H7Q2MFGdw4--NDH-ng@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA__tnvy9dUUPrEG8jynGGSp9iz0H7Q2MFGdw4--NDH-ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 2/19/26 1:38 AM, Peter Maydell wrote:
> On Thu, 19 Feb 2026 at 04:02, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> This series continues cleaning target/arm, especially tcg folder.
>>
>> For now, it contains some cleanups in headers, and it splits helpers per
>> category, thus removing several usage of TARGET_AARCH64.
>> First version was simply splitting 32 vs 64-bit helpers, and Richard asked
>> to split per sub category.
> 
> Thanks, I've applied this to target-arm.next. Patchew says the
> last patch here is the same as it was in v4, so I've copied
> the R-by tags from Richard and Philippe across.
> 
> -- PMM

Thanks.
It's indeed the same, except patch 8 which has changes to accomodate the 
two new patches in prelude.

