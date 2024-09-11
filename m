Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B467EE0204
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soDus-0004zz-65; Tue, 10 Sep 2024 23:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDup-0004q2-JI
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:21:11 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soDun-0000WA-Nk
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:21:11 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20688fbaeafso64066085ad.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726024868; x=1726629668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N80eVUTjbb+xd3KQQYCA0MpV1UfWPcvUG91GCfVP4Fw=;
 b=tcBdNQbqmiFJ9wN4lbEcNW7ZQXD/y1Xa422uYUzOZjUd1RsW0TD7cxgWeNVXLY7sav
 xkVOFYqWfHNpVI+1ndHCOMGuX0VYmx+wujSx0Eu844IlFt3Nuak1o+dvCmK9b+UQz4Pm
 amdl+Y0w+iNCqtuMv3c4Wn3nrB4Rfz9L46pBMXEeQyHQcFuT5Oo7TPtBpvwKryLeygCZ
 CeUmsH4MIA8/PxAukkkVsfHLwxZVgggNL8zUnTR9DL6XmN7sTjeh3XNC6468vg0AVgyL
 xo30BH1jL/iW5uVQRsKYd17bNJ2aFkOGE3EOUkOjhfkPeXHx+PnHsiy9ZF/F+NfTZMOJ
 R2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726024868; x=1726629668;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N80eVUTjbb+xd3KQQYCA0MpV1UfWPcvUG91GCfVP4Fw=;
 b=v7aXZiyuui+mXwpZX9wTKVDAOdhq+rsf7QsQJ+CN/5M20xewGKNrqdV3rdtCW1g0BI
 kqct6Gb8pMpM4g0KNGnucCoIlcD3qJoaCj5Y4kwu4lwmn2s7SpyoJ+L7L7h5dvzp1Ukp
 GwIx/dE+xLdJ5li2i57s6dioBOc71UifVuLhmMbq1rvn9E1Bn7gSfza6zPfSYFTe2LBv
 6S+Fm/BHIyBFO6S1k7P49dCAkAyKbKwP3Lyg/XpvkOVzfDmoX7wGRLIKy0xNmR6eFnzq
 5sT7/TK9Vhob1iFNOysHlyH0Q4yZtxS8UjGqgvaMSMieyMXPpYOdZGEqy51ywC3Qkbn9
 7lIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt9X5sfZD8wRVZnp3Fqb34XjUFAVY88iDZtD5C+bKXKm51eQ9yKGslPxfe79K2VdAmQZ012SG++niz@nongnu.org
X-Gm-Message-State: AOJu0YziVLF2AliqkEe++6fp/EvbxbVH0fnHzG+rAh73VlpaMX7eQk+V
 3yurWOzLBWXK+ajFTfx1Y9r8PBre4aoBxDu3YhEdetuAM3H8P+ggKO3BTEfYq5w=
X-Google-Smtp-Source: AGHT+IGKZVxGbqWX5s0vQli1Iz075nurtMv8TFRepuLS0ke9VHPHl6zO1OxIZtbYSIEzceNn5P5KGQ==
X-Received: by 2002:a17:902:e947:b0:206:c486:4c4c with SMTP id
 d9443c01a7336-2074c79e99amr49386375ad.57.1726024867854; 
 Tue, 10 Sep 2024 20:21:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710eea9d1sm54977045ad.157.2024.09.10.20.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:21:07 -0700 (PDT)
Message-ID: <49a682e7-d822-46e2-92da-47f222b7593a@linaro.org>
Date: Tue, 10 Sep 2024 20:21:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/39] hw/hyperv: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-17-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-17-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/hyperv/hyperv_testdev.c |  6 +++---
>   hw/hyperv/vmbus.c          | 12 ++++++------
>   2 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

