Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F452C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 19:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhadl-00025l-5K; Tue, 05 Mar 2024 14:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhadj-00025U-9f
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:39:51 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhadh-00079M-Qf
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:39:51 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412f1961101so1994285e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 11:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709667588; x=1710272388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f3EGRz5debVJ45qYlVH6UREGSUwJlBvUrwsO1hGmosU=;
 b=qSZNTw/PBOgHQRMFHOnmtoqmhqsho6T+C68B9aEbYWOFA/UFon1usxxF95Rgr0ZdDB
 bk3jpKsoeGTDSNEamBbFeOh6Zs5Bj+HoULX8tiPVr2O+E2n158ReBhqgcg6a6+EkkSyK
 LafkTXv17cQZkrgGq4U6GaucwaOvx5NslYR/ZlddDYA3CSLSQ4qlsycXhjIHS/ja8i2p
 t9QjU8Z86Ap5PPl4WtaFybFm2CD5F9+J61piOW8AYGhEaVwqV6U859wisze/Bw1qD2UN
 N2MkfSdmZWbRsW/rea4GS1Vrg+uVr4lOs9ItFcDkH2IxPTOZ7nYEGhQ+LbfaTesXKo5e
 5btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709667588; x=1710272388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f3EGRz5debVJ45qYlVH6UREGSUwJlBvUrwsO1hGmosU=;
 b=UJiBfXFw2w+cwjrKBStrTJy3opGl1cUqBTbmdbr1geSWnNyy1XC9aWcFt6C6GUCFEV
 HFCOS/gEVsfHNUABw4IUHFS5g5R1PxrDZOLl+iNLSo9fNzSQCwp+cZkJmYi5GFq3bu38
 lqNevcrNJxfezDbmsFd+TziOIrx6rQmNiEsm7sgz1qgOr1y6fKip9eZ0C+RLl/MprD1I
 b5m3dDQ9UisQoSuMlYd1numciun42waN/qL/JrQp9ih+Ze/rsCw3i94NN7D6nLkM6PXC
 pJkWVayEGHv93Nq5GtT1cWzEZUCt5E47NuhLdK/AZ7WKkL5PzEIrXfdx2MkftmXWZO8C
 29HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJLxyryk6swHloF6plJNrVQk1GXOtO9a5DIltfaL5HfSlRUY7KYxOejcKGc88OTcacTa9Hm/3eSLDCgT4Ehk2BpRNM9CI=
X-Gm-Message-State: AOJu0Yyqr2lLW0ge1EhodnyzRMcapV6fDYsdcjCJegnK6JqVi0+k3mY3
 1EbnCQM7zTRM5tLXVRIj4pnpKRfGH6vpmBsbkczhawd8Z7ptuhXKjS5Bu4F2rVA=
X-Google-Smtp-Source: AGHT+IGjCAYtSAzTQxouPXrc/qPQGuAPohTLnkwaZYW/2QajIZ3wssdjETJeNO+Xd9BEt6vtDvJ/pA==
X-Received: by 2002:a05:600c:1d16:b0:412:a6b:d572 with SMTP id
 l22-20020a05600c1d1600b004120a6bd572mr9036688wms.34.1709667588058; 
 Tue, 05 Mar 2024 11:39:48 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.193])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a05600c500600b00412ee8e2f2asm2340359wmr.9.2024.03.05.11.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 11:39:47 -0800 (PST)
Message-ID: <553732ea-e6d0-4669-a90b-e44831ab9d0f@linaro.org>
Date: Tue, 5 Mar 2024 20:39:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm: Fix 32-bit SMOPA
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-stable@nongnu.org
References: <20240305163931.242795-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240305163931.242795-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 5/3/24 17:39, Richard Henderson wrote:
> While the 8-bit input elements are sequential in the input vector,
> the 32-bit output elements are not sequential in the output matrix.
> Do not attempt to compute 2 32-bit outputs at the same time.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 23a5e3859f5 ("target/arm: Implement SME integer outer product")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2083
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> v2: Fixed endian issue; double-checked on s390x.
> 
> ---
>   target/arm/tcg/sme_helper.c       | 77 ++++++++++++++++++-------------
>   tests/tcg/aarch64/sme-smopa-1.c   | 47 +++++++++++++++++++
>   tests/tcg/aarch64/sme-smopa-2.c   | 54 ++++++++++++++++++++++
>   tests/tcg/aarch64/Makefile.target |  2 +-
>   4 files changed, 147 insertions(+), 33 deletions(-)
>   create mode 100644 tests/tcg/aarch64/sme-smopa-1.c
>   create mode 100644 tests/tcg/aarch64/sme-smopa-2.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


