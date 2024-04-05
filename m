Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF9FC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsix4-00086M-Fr; Fri, 05 Apr 2024 08:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsix3-00081l-9w
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:45:49 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsiwy-0004N7-D7
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:45:47 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e0c00e7fcso2416921a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712321143; x=1712925943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+B/HjFmF3KeZiJzQVaMYhibtWopLYFUvSqXCql6oXvQ=;
 b=uZV1xBssXFrlgPPq80hG2WgfJ82eAwFnXp1X4BJOzAMNa3R+cpeTOIBFylzcmpaIQu
 3Eyj7jFgiPvXUOCHuqs6mc0Ly82mb4q54ebd1PH36rRwU45Fj6OeFHz8BkI3zpAdJqJ5
 1SDbrYkbXXOg948irBTYxkO0Vwj2QLUln9/sftTzsQdJu0fK99AScf2Gpkn8ETfpXxXw
 ULXn8K72mUT5WAFGQ5SXv2ET+5E2lq01lA1U0g81Qthv8RXDZ5UTCpbT30AUl3+J8PgZ
 h9USv0wFGzMsshNW4fq7lXrjTyd4uc653xkhwV1qJLOc2d7FXL4EyfZd02ZBMTRKqCmL
 /GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321143; x=1712925943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+B/HjFmF3KeZiJzQVaMYhibtWopLYFUvSqXCql6oXvQ=;
 b=W9d05zPe+PioylwVizw2VMfCs6ClAwyMrmm3rRCK3/VvKJ3pahnC3kk4z96uQ325fL
 z4x4sZyA7SPbhb0cjVvsSW9AtwIwAzaWjHbVa6hWPCasvB3119yWEh48qyDUMBKg06zL
 WDcQGaNcmjUEGcFvAB9p5hhclxQmy5/NGs+I85aOlxocTQUw7dX9ZXtdZpl7GA6iNI+R
 bTsoVFy3DrcHDsmPK5p547BNg4ykezL9mUYB2SK+5Af4mZAMtU9mI9SdeE4CH9i43GNM
 AD6hYf0br9SrmxI/zDpRMIOJH5rmOp0C7SF+bkNi3rhUHZNP8d7VPUJCFolEE0ZHYTYx
 BIaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9tQCl4F4ug+BEVBnSpXBT1gp7mfx0G+MfB9YBVgCQ6ogSrm3H3a1ikflZXUVB443kt7YYzvrAYa4L5aRYzYqQ/2n5r7U=
X-Gm-Message-State: AOJu0YyEaEuTeYzo08sycvLsIEVR0AdNx2F6DI4+1Z3fizutxJ0OvWur
 atk1Sg96aVL93ebwyLA9fLeAqME6VroOuOwire4OUJVbTCEAz1W/+lEAT9Jd9lOhtjJtQEo+z2T
 j
X-Google-Smtp-Source: AGHT+IFCNFuHFnxaa9PZCYj7Tv8nSDW2RRz3UZHEIpMmTzfSzWFJCd9g4kBzv33nL2DoeHQzhaH2DQ==
X-Received: by 2002:a50:8d0a:0:b0:56e:2bfa:c7e0 with SMTP id
 s10-20020a508d0a000000b0056e2bfac7e0mr1006778eds.13.1712321142780; 
 Fri, 05 Apr 2024 05:45:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 ev10-20020a056402540a00b0056c249798absm755766edb.71.2024.04.05.05.45.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:45:42 -0700 (PDT)
Message-ID: <70ed70b2-f63e-4f82-ae4d-f8f0e8c93e50@linaro.org>
Date: Fri, 5 Apr 2024 14:45:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/32] accel/tcg: Return bool from TranslatorOps.disas_log
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-18-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 5/4/24 12:24, Richard Henderson wrote:
> We have eliminated most uses of this hook.  Reduce
> further by allowing the hook to handle only the
> special cases, returning false for normal processing.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h    |  2 +-
>   accel/tcg/translator.c       |  5 ++---
>   target/hppa/translate.c      | 15 ++++++---------
>   target/s390x/tcg/translate.c |  8 +++-----
>   4 files changed, 12 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


