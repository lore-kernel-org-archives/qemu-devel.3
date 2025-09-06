Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E998CA101C
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 06:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uumYG-0001EK-HN; Sat, 06 Sep 2025 02:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uumYE-0001E0-DN
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:37:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uumY2-00059o-KY
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:37:30 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45ddcb1f495so4645795e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757140633; x=1757745433; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ag85WSTMlvkx78O96FEj5Z5gFB4Zlx7FRbt7gXQqJkE=;
 b=c+DqdtUbuc8qFO3I2Q/QaVU1J4SQGEOnfUBO5ip2ZPTcUJv0UlwXOt+dPklGho+TGW
 licDx3M9SJW6lRlcPboqFP1eZnmnX+XWtCa0lOedOZNfNdkY2anwyD6VOueNSnlWybfj
 R3gPlffPTmKIYeOPJVLKwO1czN9zEXRlx6xcH17I1SHEeBYWtKklNk37b0LgSS5q5x5Y
 NrO09qgKDre0090K2cUGKRnPHmLwLp8jvQ6Ej2MZHhzPudcqBR8oOH6pn4Fdq7rikyBj
 LhD15RudqoO8Ns8NwKoJKDJVQHA2SwXv3d7lyAcTWLcQDd5NpNuo3sPqVWfcvNlekJxf
 dlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757140633; x=1757745433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ag85WSTMlvkx78O96FEj5Z5gFB4Zlx7FRbt7gXQqJkE=;
 b=cG66VqYCWs7N505tYlfAfqJKnW/y+XqtGe5iUAP9MssGy5dQX9+C+W0qWZLTMRkyeW
 j9AVBOV5kX3t3O6pEiZ1RYH7QaYhMd2vFTxdOWYXf902yhqS/dxhlfDox4+PRrRWq5ro
 ktyW0gS3AMPhohn4jSHhafyMmJioYSstGUbBl3T2F0AYfGwXXjH+huvfC67MPze6LfvA
 wbLDnaQocR5No1omkCxn8yvyqeQbipYjuECJNp5nzjSes3/bM8HTLnO1CxSNztFb+/vU
 6GYcqRXKLvL1kVj+gaa2RV+l3+dg9vm6dza+suQmQWeTDKxFRLqxFgzZzZp7rFPlvwct
 ezag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsKRyPHvQcbcj9AXETZmBZemZGXdwIE2TaZ8O6JC5tOfnLFnyDl/C9d4XGEallkIp1QOglwWa/PiV4@nongnu.org
X-Gm-Message-State: AOJu0YzT3T0eo3XekFSNpYlCjEIXyUBhwItdUzJjjzVioem2bLoGKMLA
 Q3Vh2LwPSNLK3/QEk62WJOVO9dunbL4rcQXXD6sVi2Xz4UmY3QWsNagWvb7yEwUU0UQ=
X-Gm-Gg: ASbGncs+0e16G/LGxlci+dzW68/KRfR0j3U2INUFLShxr3Xbng1/f7yJMf/2+riVK6g
 z2vxAIbKnMhSvnNsdwfaKbM9y3cQO22fUdJtVo9Oqug4uAyeaPZRb/geKG8niKMYWhtOkFxjMxm
 lAM90l5JWERxOtOiVE9/x6pmdK5L1FBw8epWOcd8S2otx3L76cg1mHJMdT4e8QEcHu9CKKzu8/d
 9DxPYaFT42rc76jKO1Iza2NYEbh0WRD6j0GffrKyHqOHJIPl1U0jtyfrPts084uKodRxnkyiYlr
 o+gGpN6VUkW4Gb8fELctzwhPu82FRnzU7G3G9TOnsrzeRSoWZYc+kKlvH7+4Heau3cN6t5mPAPg
 o/yHqbLKhhvPXTJUyuZRkJMShXDlCra1TsmTfXMA=
X-Google-Smtp-Source: AGHT+IEpD/2d6v9eLf3j6141tHb0/yRjLSB3K7uHLoeOlLi+oLnsZVwdERbB0Cz8LtUY5V5UqkdJTQ==
X-Received: by 2002:a05:600c:4695:b0:45d:d2a6:ad8d with SMTP id
 5b1f17b1804b1-45dddeefa0emr8048295e9.29.1757140633098; 
 Fri, 05 Sep 2025 23:37:13 -0700 (PDT)
Received: from [192.168.104.251] ([217.65.133.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd60b381csm61111985e9.17.2025.09.05.23.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 23:37:12 -0700 (PDT)
Message-ID: <9803467a-dacd-43ba-901a-6c0d4ea72615@linaro.org>
Date: Sat, 6 Sep 2025 08:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] target/riscv: Record misa_ext in
 TCGTBCPUState.cs_base
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org
References: <20250906051820.160432-1-richard.henderson@linaro.org>
 <20250906051820.160432-5-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250906051820.160432-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2025-09-06 07:18, Richard Henderson wrote:
> The tb_flush within write_misa was incorrect.  It assumed
> that we could adjust the ISA of the current processor and
> discard all TB and all would be well.  But MISA is per vcpu,
> so globally flushing TB does not mean that the TB matches
> the MISA of any given vcpu.
> 
> By recording misa in the tb state, we ensure that the code
> generated matches the vcpu.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/csr.c         | 3 ---
>   target/riscv/tcg/tcg-cpu.c | 3 ++-
>   2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


