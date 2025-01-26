Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768F9C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 12:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc26x-0001JL-G6; Sun, 26 Jan 2025 07:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc26p-0001ID-7k
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:51:28 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc26n-0008Fl-MH
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 07:51:27 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2156e078563so49101235ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 04:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737895884; x=1738500684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fByu7hFxkOojCBXmsJZACGt1zjQkTa2LRzVoUcqllhM=;
 b=FDTY7akDcGoWjCZEm5uCcuZ3oSUw5QELc1vkSJ9pfHqZZ5TLkJpvtuQ+lJwI3D468P
 o+yqL+J2IrAxldtvBRUVTdvcyxFAx1Pwcnl1CmywpJgyWkk+qU6FOeVF1ZgoTMiLbYb6
 AWdL+KLsARtO3Vl9PYGm/652VA5+i8dn0Xih/VWwDaJUbZnMww5vgVXmY+R+EbRcECQ3
 TzFgzfc9rShECYlG71QS5vTmCuy78PzSGZ7hUgiivXk9/We+sYqfVg/zC3ovXfv0jQc0
 CMzM465dQlND2jXKNAR2qUaXH9iUaPwkhaeDc4qEsw6wQgvKQe3FYQj8k1UmWgGMOsgE
 XbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737895884; x=1738500684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fByu7hFxkOojCBXmsJZACGt1zjQkTa2LRzVoUcqllhM=;
 b=V8a/Os+r36Ef7xIQERvvQ+Y5V1QK30R9bMcbo7Tzwd9WPIf5GQ4FC5kCv/GewSNk+z
 IRnSX8K76xdBTecv0YO9eKBvsYDaQiyUgiFC/APzF9RwctyBwUoZ1kQOdFxhVVEezkaZ
 TtnPltdKxrl9KEA0ep1/pN6IbMVD0rnmE9yJrxU+bvpvAMcD2M9Z4EtmkgZ0jki4Bn1Y
 nj0bjhi5wpREqW5UPO8DtCMxIWFPY42VAzRQpQfQinwypHGG0Y+BGWwGOjSiZJYn92RV
 GvAG5xZbN/PdYfBOinzOEtPeBCCQhLL01KNJ+kNpi2oRmeXYjnJwV7L4GtLvBRZMrmpo
 k7Ww==
X-Gm-Message-State: AOJu0YwUQYbgbh+HXqntrvcMjF/4NV/QiG5NOU/6YgcwUd2L8+pR/SHE
 Zi7SKWB2bfYGlfuUr5AsqJ7MNMoYEWre8lntpuD6s6iMWvmSm0a+BXc9YjGXa/Oe+lb0Pbx4/CZ
 /
X-Gm-Gg: ASbGncu3r/s9cWeIysXSPrTnlAf9wyF32Yvi+Y3+1WHYTAz/wERInQ8hxvXl6/AU+f2
 HPZ5qV/LChqUO+87AzsVJEfC44fn3NmfsjWaFKfsXY13DQt0PDm14zuyocLnkuHKf+JVBgsLUDK
 20k87Qj01BIH5q8v7MfZ9sigKSBt0GxlMqm6StbLOsR7YwqneywOc1BKMns2iwf8sKd+57iX3Ks
 UJCOSjI6fW5kRUHX2xv91BKak86TMib2SvmImnnL0OV//HZd/7wZ4CMVn1SMZwL6h1lgx5h/YYn
 1F7OcIbaVd8hf3COwMv2EjA=
X-Google-Smtp-Source: AGHT+IEtWdQQAdlGiAqLyLxKGPLHOKlQ8rhVBWYY0TQruRHLcawyTRAOanyYCyuRAGwdub/I+Fr1wA==
X-Received: by 2002:aa7:9a83:0:b0:725:df1a:285 with SMTP id
 d2e1a72fcca58-72daf97aed6mr52897825b3a.12.1737895884108; 
 Sun, 26 Jan 2025 04:51:24 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a7609b5sm5377205b3a.107.2025.01.26.04.51.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 04:51:23 -0800 (PST)
Message-ID: <3df1b79c-d2a9-43e5-ae4f-275801778650@linaro.org>
Date: Sun, 26 Jan 2025 04:51:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 49/76] target/arm: Implement FPCR.AH semantics for SVE
 FMAXV and FMINV
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-50-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-50-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> Implement the FPCR.AH semantics for the SVE FMAXV and FMINV
> vector-reduction-to-scalar max/min operations.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h    | 14 +++++++++++
>   target/arm/tcg/sve_helper.c    | 43 +++++++++++++++++++++-------------
>   target/arm/tcg/translate-sve.c | 16 +++++++++++--
>   3 files changed, 55 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

