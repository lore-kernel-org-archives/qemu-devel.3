Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A182AC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3dk-00064J-VY; Tue, 11 Mar 2025 13:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3dL-0005hF-2h
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:43:20 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3dB-0008I4-4Z
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:43:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-223959039f4so117766655ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741714983; x=1742319783; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8qSVzPUhDG0GTL4i4RT9PRBYXv6am/UhU/KuTc4E/6Q=;
 b=jPD1Re1SI77CxkGtOHh9DdtrixCP965xEN6N+s4TwarDA/feVwg2p/CRCAhIdzxnja
 H5bAqHgBy68OlFix4vtM/jFpX4rIPu4fE/A+KXFi9qqJs2ScTOxCYniqy9bXEFG0uMPn
 dRzDsrHTVuImGnfozVbuOhXf43Q8TXrQEE5YhZvSC2OfaJ+f5ph651+wdIf1SPGV+wSZ
 gbU0pUS5Vy1oIzJf6713J3dAhuKMlPvuUMoZCT/IHhsoc2MHKNjibcc9N2BhPx/59on8
 v2FLTBDQKzVB+nju4VSkz0q6+/50RMEerJns0EU7394u+hmCTlBVhpDdnuUIh5ESknYS
 9KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741714983; x=1742319783;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8qSVzPUhDG0GTL4i4RT9PRBYXv6am/UhU/KuTc4E/6Q=;
 b=DBMWEg9MDv/wHPfwb6ZWe6hRDzCWrgVn43Bw1d7g3hGgLozksVRt+McY4Xs9ga4+ke
 UMXGjd70u+vB4eBVxr4reYQeDX0FsgbwTDkvwSDb5Xp/frn+avRLJ1myW+9Fc5Ilm2RU
 CPZwTZ1pQ106Wl0446AqWvu0FndainblKB7q0ziBf3GvsBttoh8TP/Lk0UcIjtgOm/pk
 7tILuOF3s5P7PeSMkgSpkDdA6sJOHmfzK/CJ+a+g4sCjPAYS2QWxF8czWrkgM3oriu1Z
 sexqZdvMWnLwuD/z8PhKlmZm0ziOMOxcJhvS5muFSd0xx/bbpxr7EIvUN+yR9VWuJ8Ph
 qNkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxhWZd3m9T6Wt2m9lQE1lD0yFGQ59I6gam6iQNFyYNIm/v/ZNXDJ8O0OsteGmj21exGOanLECIUBGF@nongnu.org
X-Gm-Message-State: AOJu0YzIobYM4ficaiXXJy9w57DERUzRnzjwwk3ClhEJshpP/k2RGlFO
 otG/Zgy3bpQbqGdvQ06vFZS4sVQ03DMjH0zRSuCM+KcOiR+3CsUl48Mo0V7mW/Y=
X-Gm-Gg: ASbGnctPzt7bsCQD//TgtJFMRS6BcD29ef1CbvTERaHc41mIgR1gSdmx8/VKEe+fJmR
 XYtmNHnFUR54kW/uW7OrfG4ihgaKjp7moY8Rz3sp5nmPNVs26fQeKEwuFGQzR8IwLPFspciXYvy
 OiSTNxGvlksA4H+U38TVFI9K90LJCKd7/p/UElphumr64Ulc+fJwGi/RIWVgPrqmdeAwfcAosDo
 HDV3vKKWv5W8x09+dDk5kJwv2cTMUAQFnh6bZkplWTay6TpLJKYKxC+nzs3oDHPSiz3IQmwBPoi
 6DSwTTN0w/RCa1+uExbXdYF1EJ64DfnRvWDDWvw1xY68zr1E/ybuUdc+ZbPj5AKPRq3HyMoxGAs
 zVDJ91vsZ
X-Google-Smtp-Source: AGHT+IHFfCAZGUgmbekvmi8yTjhV5+moI/OqRSML+sSMWJcFyIrtD+3hxavB+a/FtHC47qL6a1cLrA==
X-Received: by 2002:a17:903:2405:b0:224:5b4:b3b9 with SMTP id
 d9443c01a7336-22428bd551fmr289271735ad.33.1741714982949; 
 Tue, 11 Mar 2025 10:43:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410abc694sm100488105ad.257.2025.03.11.10.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 10:43:02 -0700 (PDT)
Message-ID: <c04f6007-3899-4286-af0f-e3ffcc930145@linaro.org>
Date: Tue, 11 Mar 2025 10:43:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] arm/cpu: Store aa64pfr0/1 into the idregs array
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-6-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311162824.199721-6-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/11/25 09:28, Cornelia Huck wrote:
> From: Eric Auger<eric.auger@redhat.com>
> 
> Signed-off-by: Eric Auger<eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   target/arm/cpu-features.h | 40 ++++++++++++++++-----------------
>   target/arm/cpu.c          | 29 ++++++++----------------
>   target/arm/cpu.h          |  2 --
>   target/arm/cpu64.c        | 14 ++++--------
>   target/arm/helper.c       |  6 ++---
>   target/arm/hvf/hvf.c      |  6 ++---
>   target/arm/kvm.c          | 24 +++++++++-----------
>   target/arm/tcg/cpu64.c    | 47 ++++++++++++++++++---------------------
>   8 files changed, 71 insertions(+), 97 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

