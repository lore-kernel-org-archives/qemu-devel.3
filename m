Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5977BCD37AA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHrY-0005dt-MN; Fri, 08 May 2026 05:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHrX-0005ZF-Bc
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:51:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHrV-0008CS-Jq
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:51:14 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso1581063f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233872; x=1778838672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bfalB5UxuvtYeYz5kWi3OP7FXcLSwNtIAYg1wTkHlXM=;
 b=ugLCbGyX1uLkzwc+aKpXguWAVyZETgeKTSNZb189EzY+KbVQG06yEVcsv/eR9ikUnc
 bur7zmTggdWGzkkJKmpQnj3cgebob8Hb55ai4x+EnkXG9cGLvRJOE1C87kuQesXakRBf
 Ty7vC9Y1q1tujaxxyRPE2EuRooBw5d3dhUI1HapAiDZcqID+aje6T0B8NSev3d8tL++G
 IeUA4t5+d3bmt4gRPuLxjfOomfVlb4LnK6AQLEqnHJ577fSw/Bbf+Xb5hhOXhTAM/EZk
 GGw8K+pcL5Bnf42k9cNFu01CYPOB4+jFagTrQC0d5Ee4EvEIfBNOAQu37bi5i6lG+5dS
 H+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233872; x=1778838672;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bfalB5UxuvtYeYz5kWi3OP7FXcLSwNtIAYg1wTkHlXM=;
 b=Pj0sDeLzAld2XQbDVzuH6/TPEW9aKenb3BlmWl//NQ+PjNYwP9kOaM3w6ooVLbL8ny
 +V3Of2wS+G04t7V4U8e/J9Wr2RMd87s2vExMiF99uszjxX9YbcI7+/cjGSQ+XN1IczL4
 QuAcCrHv7w+ZEFej3bNWhbSr2TJBfNgAyjt9AZOusUzjqmxYg56V56ekjY54nvqxhUMZ
 ySBNIdNRSo7yVoVqwWX6khc2X9tJ/+9vGHTYX0N8a49waXf+ik2cPj/WBCJIwORMGO89
 zYcuo29C4U/v9Lq1w9L+suCKoqMlshB2HIsBeoRl+E/JGrWohsoMRvp1CZzcVrLjb3NY
 zGmQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ttwz0yt5IOzpViUKZvs8TeiZ8c0MpUGnlm+q4/1W4k1yANabw/FQ7g5TA31IJn0lwirU64RnzI9H9@nongnu.org
X-Gm-Message-State: AOJu0YwcRVw/rGNcFSPGtaolUqeftEyLFpO0lToRdAI6Piv2y0nYd7MD
 yC8PqAYQpTd4i0HFFTu0+vTfpGXtwm7f5c60jAWnCdGVrbKiv11/KAU/zGu5G+gfcdg=
X-Gm-Gg: Acq92OFabL6Q9yF2GugwFwDkAiWJCIhM2RxDPmRRXYvf3/0oZb9x19iD5f9X7CiihMT
 vT4/N2mdnjlRv8fw8f8PEVqag7SEma9OL/YSGzRyWjLKsDK5yp95BvyExQwbBTLg6Kpald/rU82
 G61omg/g5NHaxJUIzTe4oTRLjtImgF3Ysa8quPSJKBphBq5J3veXDinlaeijZQh7U4vE9lDjkx8
 IKyvFZVD5pj4QmNrunOUujHcZAxgBYMqt1rQr9MzfIALXO/1kPVX/kiL/VYPYE2aoneXCh0YjSn
 FRuRJB4YAq444qYK8qTqYVD7EBidVucwdti/RwOgpPUp92Glc6SjaBTp8ka1YdrVpgxJD1vUsjU
 R+QxNEcwejbbMwPouaMqT3bDmWzTXlZ7PpVhPXj14YhibnsFc1WOaa6v7YHgcl6yvxBZr3txJsL
 4hCkHQfHXidSFcOusN0/H3bvjDD88iunnuv02Rc4AOy4KniwCtpCIHqQ7mcSqmKu+17ZVkXQ==
X-Received: by 2002:a5d:5d0b:0:b0:43d:c2bc:21b4 with SMTP id
 ffacd0b85a97d-4515b525d65mr18321242f8f.16.1778233872006; 
 Fri, 08 May 2026 02:51:12 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491ca2fd6sm3278062f8f.30.2026.05.08.02.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:51:11 -0700 (PDT)
Message-ID: <5aa38f5d-1f76-422a-bab6-88a106c1c3cb@linaro.org>
Date: Fri, 8 May 2026 11:51:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/18] fpu: Use get_default_nan_mode everywhere
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 8/5/26 00:17, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/helper-a64.c | 12 ++++++------
>   target/arm/tcg/vfp_helper.c | 24 ++++++++++++------------
>   target/m68k/softfloat.c     |  2 +-
>   fpu/softfloat-parts.c.inc   |  8 ++++----
>   4 files changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

