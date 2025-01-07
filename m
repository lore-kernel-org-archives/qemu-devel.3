Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F76E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3jX-0001YV-Gw; Tue, 07 Jan 2025 02:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3jV-0001YB-41
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:10:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3jS-0006FY-EZ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:10:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so172127035e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 23:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736233828; x=1736838628; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mVI3dYzHBeT8VZtZhmpxbHrEVgI9gtq2gj1l/2EtTRQ=;
 b=qaa4nEj6BhP4DDW7TzvD8A5Ho90S/MU7fyXMkoTH3BXYnnSI4cVOOKnYH8zTL1qbfz
 kXQGSpI9+QLdtZJsrlyjkbBBVwC2nx2/tGl+k5XiIavIT+JadUCYrL4q9s5s2DRitN71
 DIK6XGzbIJ5BX6nq9nsSibfH3oIKCOEJ9Bs6wlJCsCHs8MoXdI4Q3DvIIsBMm4orzRTo
 +gaNPJuLWjgsVGWc/EDc7p8IFsYNnsCZJ23lyNfr41mpBaaE+QrGi17C/rXdxc4NRTBY
 09m3JCDqVAPHk4/Ompi6BgklUl4yCg6DeoG3Ch3d9VVo86EMPe00MuysY/duHlRkxUwM
 ASmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736233828; x=1736838628;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mVI3dYzHBeT8VZtZhmpxbHrEVgI9gtq2gj1l/2EtTRQ=;
 b=DgVy+hPDWJqtL8Ib+nZ6xdGkltJ0Cgc51BpKNn/MyjkqpRNccKCNqchvxIiPiFXJTn
 jZYLF2Ox+Jrr98B3YDKnAFpj/1WvmFog/M6I+8IjmZWbxxU0SxhukhCFhjKUy6ifEVdi
 w3F9UTQxw0RYaz+lffArS1EAPXtXwXLUX4q2oSEf5M+HNQzqgWxdvUC+xCmVk0z/q2b7
 d78dqJXXezNK+0cfHxu2FhqE2HfWi8WA2iUjZuwKiSo18L2FIvqRNbUQcHTZrFlm3zUX
 /+MgRHRtna53C7iZOCbxW4FnC3mIjW1GjcjnJaOx9NO2nLxsEjqbhM6GletGt+3ctBzu
 bp5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuypdrwJNkWk8Xtg73wYsjIeOKx+uh5OQGKKtUZFMStLxkId68MX+DAC0ZpTr1WQ7nf80pWODf9rL3@nongnu.org
X-Gm-Message-State: AOJu0YzF3ykCL7klm/aVNK8csronfHR8Vwo1clEm2PMzNSkfPwTFQ7MZ
 Tffe8g5ryOc386Z5tSbv0RcCELw4AZ1DVFepuMJ4B4eih90JYrjrCC5HKeDpFHskl1J57aB+0pD
 tW+U=
X-Gm-Gg: ASbGnctmDlmtbmSITijacrajrlF0eN/aBN2VUmex4rCFVpI5VLBttzADDOd+5xvClME
 7RCywq3IzrY9BE7cPufTNjJNaqcJ26jqlP8JxMSCVNuY1VhKhqRg0FCfOdoONk9Gi0Dsc327JVJ
 8TAa/UIbwM0HnVeSdaEoX09w9FP6p24rjHZyiB7EngUhtZx9MHKDvghNs7lXcyAM/wC37vwx/xl
 04/LUzAKSX6/mw/Ttr/qZuFX6+iKdvMwy1B6gO021ptmUTLlWxQgIChhu76JZ674mDfIN+6MGIY
 DzPU8FjepZsS3NsMEfyiUhTm
X-Google-Smtp-Source: AGHT+IF5DMhmB/AF+MvNaMfprANjCJ7SRn0/iQOW6Z8zqi0lpr+4HByB/0nMfv2+Cyv33W5rw/8taw==
X-Received: by 2002:a05:6000:18a3:b0:385:f60b:f5c4 with SMTP id
 ffacd0b85a97d-38a221f9f90mr49525840f8f.29.1736233828440; 
 Mon, 06 Jan 2025 23:10:28 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e140sm50743145f8f.79.2025.01.06.23.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 23:10:27 -0800 (PST)
Message-ID: <c63f0db5-b53c-4380-8b58-6c4e1327218d@linaro.org>
Date: Tue, 7 Jan 2025 08:10:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/73] tcg: Add TCGType argument to tcg_emit_op,
 tcg_op_insert_*
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 2/1/25 19:05, Richard Henderson wrote:
> In some places we have a ready type to give.
> In others, like tcg-op.c, simply pass 0 for now.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op.h |  8 +++++---
>   include/tcg/tcg.h    |  6 +++---
>   tcg/optimize.c       | 20 +++++++++++---------
>   tcg/tcg-op-vec.c     |  8 ++++----
>   tcg/tcg-op.c         | 12 ++++++------
>   tcg/tcg.c            | 28 ++++++++++++++++------------
>   6 files changed, 45 insertions(+), 37 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


