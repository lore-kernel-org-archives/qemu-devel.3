Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049BEEED635
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 18:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sooMH-0002Sv-3x; Thu, 12 Sep 2024 14:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooMA-0002Nz-5G
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:15:51 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sooM8-0000Jo-J6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 14:15:49 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-718e9c8bd83so1765260b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 11:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726164947; x=1726769747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A5dig4RG1oR6IWPtrbP9Lmew5kk+agvbcyFHyD0KR/g=;
 b=flKc3LAEMmoTPk7eniPMW0qRYi7hY/NbrD4EJZ03DCemw5Ssqh71xNHzzriDta7zEl
 uBMQ6grP/XR7C6w17fPTt1scPl3csXDZM4khloTFU3L/6I3UIZnnLODiTd5mebnCN+VN
 6vzu5gyNA+BUnc9pjjTnjFaouOQODP7/4E/c+wj75XZdBwlaGs5N6yGY4FftUfKtBl09
 Ir2QQQRBNcpRu+AjNU+bFbzN81Z1LINRl6WSgZsshUYtb+zHLB15EnsefGvoIIbzez/M
 hapt5SkLvyNgpgvKPBRhDh2bId7vjK+XJjFTCz0TiIkx7khwdc/VIwj989VXHPY/K0zF
 Bh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726164947; x=1726769747;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A5dig4RG1oR6IWPtrbP9Lmew5kk+agvbcyFHyD0KR/g=;
 b=Q2mKAiYTtH+h/KbIwPYH09GYlbG0WOwUaEShTIW9pssFMggF9W72BCMc8j84FKk//e
 vHr1f2y/n2MJJj64rCf/jwA69UzK4gvz6DBf0MtLEoJJzlUaOe1Ivat02t95AaNvZ6mP
 8661KtrWNSSkq1yvz2CS4YokkNtJ1oMAo3u96ThpYPhc0U74xxHiNRarpQMnNbqbPuLZ
 iZXR0vfzQiX/s0q1bOMeQ63uyRVyzm/OLiAy7fYmf8AlxQsyjgBI+9xO/8Gi87vA4k7C
 jxlczwMK/taOObHULK09bLslmECXq1EpEnZHxcZWdSdyWVbm7MJmBdth3X5OzunVSnOB
 b4Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFvcGlB6nG9ZB0XzF14T8dEvaLPWdNnJ5KmsIzhJ9bqgwDLPlTIJDRqBFINgSkU3J7w2wgMw6IvUz8@nongnu.org
X-Gm-Message-State: AOJu0Yx1QAANN5hiTyTSi7GplXqF6kTh3wRx0w09DE3YUODEKQICrsde
 vqPllwpFYQdWVuh1EWo+iR4dvWiGnRHr+hfhMYDoIpSwAHpMKq4aXptvNckBIObwCal28rlzAxq
 3
X-Google-Smtp-Source: AGHT+IGvwQmiJD2B300yWXnaJ99F6GQPc6jjYlUzLTmV5IgL8qg2WEBsGxZRalsPm6qeHMXRppUDZA==
X-Received: by 2002:a05:6a20:3942:b0:1cf:3736:49c9 with SMTP id
 adf61e73a8af0-1cf5e098173mr14166922637.8.1726164946852; 
 Thu, 12 Sep 2024 11:15:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fbc0992sm2055163a12.51.2024.09.12.11.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 11:15:46 -0700 (PDT)
Message-ID: <efad5486-4996-4d76-91bc-2c8fc93626e7@linaro.org>
Date: Thu, 12 Sep 2024 11:15:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/48] docs/spin: replace assert(0) with
 g_assert_not_reached()
To: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
 <20240912073921.453203-2-pierrick.bouvier@linaro.org>
 <cf9642be-8169-496d-81ca-203ffa0f8edd@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cf9642be-8169-496d-81ca-203ffa0f8edd@redhat.com>
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

On 9/12/24 09:14, Paolo Bonzini wrote:
> On 9/12/24 09:38, Pierrick Bouvier wrote:
>> This patch is part of a series that moves towards a consistent use of
>> g_assert_not_reached() rather than an ad hoc mix of different
>> assertion mechanisms.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> This is not C code, so please drop this patch.

Oops, yes.  I didn't look close enough and thought this was documentation.

r~

