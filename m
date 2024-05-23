Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72D5C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9B5-000471-KR; Thu, 23 May 2024 10:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sA9B1-00046F-Fc
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:12:15 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sA9Az-0003AA-Ru
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:12:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f3406f225bso4999375ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716473532; x=1717078332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VHeclCd3TS6Qb7HlsSElr6MP3U6crjObEabT4HxZ39A=;
 b=XDQkATW9iYqLZnU44dhkuXWwbgEqAyLMvF5wRqWC9m96Ke2DRwTPz4K07zT0JBWlju
 g1RgvtGSVpQaE0RXcwKL12pT/Q7B5c8STj/sbNPt9KO+4OMTa7qmhAeHzRHqxLenOe9E
 26QHVDLmd3hdl7oWFsaQjnM6xJgKrAlMOqC7PF0OfTrppLuXMVthMbFUEFbMEgeGtC4L
 52ejBHks1MNZx4sSSg2JjlPwj42q7Bw6wnUYc0mnv2STunUMZBx5J47vPW8/Rz1jR6gG
 77zH0LJwnl9tKnCtqA/Mu17HRy19kFCfXRDX+YL4G/ePtw/wzU3VEjCLlsUe2ORenEqn
 tMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716473532; x=1717078332;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VHeclCd3TS6Qb7HlsSElr6MP3U6crjObEabT4HxZ39A=;
 b=PBK8KcvNbikmUZrjhJVt26uRMSIj177GlhSl6VHnCVJqFcwKzxNBU79I72vcsxSPdI
 jUk7bIEfnA0nuYtkZLBQi67+4qIyCTg5ex0su952T+6b+btdB/sx0xAKig0WwAAruV4X
 CzmF6nBMwYgzGyWhX1Iwb0lwaU17JaFcg2TR52JbBP2eX5/F7WPub7TAOpGE5q8QvFPL
 1NZPeQQLG5rhL0x8bkDkV7SqxFrEIHfOCUb6yNl8UrAb0GcRnTj/3xRdwIxWd0fnvonc
 9DhI2jfhSiE31L2cgHVZADvFwKBOfPPS63VTjENKfebXx9wyY98TOBFZtUxzOnYMCqsu
 6QZA==
X-Gm-Message-State: AOJu0Yz13O7zVcqBA1fk19yayLm6Qdu6Rt7zZjDjPh8i/MhJzHK6ml3k
 0f3aGTpMmFYyoU9EPY8SwbbcUwJPUHjfpD7Lcc4WbJzwsHoyC2drsNthTcywmg8=
X-Google-Smtp-Source: AGHT+IHPa7ZPXKBvytWxnvpgI1zVVXCaA7Z+rombLWneQ0OtznUfAmpAsMBQwy884p+wwx3GJAH1cQ==
X-Received: by 2002:a17:902:ce84:b0:1f2:f182:f616 with SMTP id
 d9443c01a7336-1f31c95d694mr61621745ad.13.1716473532156; 
 Thu, 23 May 2024 07:12:12 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f3097f9098sm57912605ad.177.2024.05.23.07.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 07:12:11 -0700 (PDT)
Message-ID: <43d4cf95-f4a0-442c-a5ce-a92e4fb28c5e@linaro.org>
Date: Thu, 23 May 2024 07:12:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] target/ppc: Move VMX int add/sub saturate insns
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240523094454.123114-1-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240523094454.123114-1-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/23/24 02:44, Chinmay Rath wrote:
> Chinmay Rath (2):
>    target/ppc: Move VMX integer add/sub saturate insns to decodetree.
>    target/ppc: Improve VMX integer add/sub saturate instructions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

