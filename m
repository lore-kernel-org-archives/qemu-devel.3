Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7E2C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliHq-0006jj-3C; Tue, 12 Aug 2025 02:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliH2-0006Ig-QW
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:14:19 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uliGx-0004NO-6r
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:14:16 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b914186705so38076f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754979247; x=1755584047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ElmGRZXtBianV6qZi7wLW+BYFTb5y/OXbI4Df90GETI=;
 b=fZycT7VajNJw2k0XM/DjeVGQgvd//q/Bd97FifVcFb3ompUQSiXDFLKRw19AQIzcuV
 hwrh39kfO57W1sxYp8m+a9xKjFTQc0/jgYMmR81JVUVAbgiDCA9jGYOX3mTPrMudHrUo
 WkUWJaYBDBSDj/LkBXQ7CYjZCncAKwvm/J0DoAAg9BLLTJg70zw/af7S8gnkTV3SkbQV
 J1QX/vXDWIF1ieusNAn6bEXrn6Xo8EI77O369GvcO/EUIpO1OS8XoQsmA7/y/cxlS8yq
 krmmQmPYps2YRrNta+7LS5UYZBT36oF2jGZfvOzOb5jEG6gaT2/c/e4hezPDQ4kEaKyI
 5mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979247; x=1755584047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ElmGRZXtBianV6qZi7wLW+BYFTb5y/OXbI4Df90GETI=;
 b=qD0Bq8dvhDoEpGwhhGVEUd35RjWVT1GiPi/0e7CsfZcTOKV8hyHKJQux//W5eQ5IeP
 gypfe5mVfPIFgMmqYISjHMq1YUmcoU5K+J1mixKebyVB+Tdpq8lg4atohrZ3mzYSjEPo
 0stsxcg9tsPBzr7X6+R33CZAXcREqBQTqO+z3d4l3sJ70odg8UojU/XP4dI/r3iWgPYU
 JhXq6UqTfPtjTligh+QSLSGrXZz9pfQo0BMQNOCL6cJEj3IBcbQNOpyq1ZcnHkNmQR1K
 HsyI/C+aAy9npBav8J8659hl2fkg0sJYog0KrcaNZ03L2OvXNVjJHakxOrSWB+MoryDL
 r/Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ6ZiS89ov1VXS8dfXeEjrYAlu9/CthWot6CnSpwGQ282dQfEgpZoo3ITAdxAxsBEe55yojrcE1+yv@nongnu.org
X-Gm-Message-State: AOJu0YxhUGRT2n02lBPXoutuQaopyxFhrNb45qgx2ZrxUdlTsrsuCjEh
 af68551tCHld7zDavoQBVv5mWbYeRTkU6XTEx1q1e5uGqriAZ3FSPiqXgBQj6md2a3eo5sQdcAe
 6S5yu
X-Gm-Gg: ASbGncu+Bfo16j4jSy9bUhn+nTAZzsOLrBhgBdqh778c7QJX+LVLXmdbq2Qw4FfcZ4Q
 yskVK+QNRdNQJn69ak5rdipnYPYv7TeV2Hd3WbdXWu0jr1799+QA5cxYeqVS8Fugp0OnUmHNOuw
 KeWyMH1lh6zo2NvTjCoQIf5yMeZXZgLWN15bTGKjgTun4l2OAq8K63mshBFFP4F/AdQ1d+dYRXc
 wl+JA379jj/wZP5QUg5UgTisJzy9By0T7lxuTqRk3L7CYf9N4wZdnCM0UwVvLO5rSk98wxCqiT5
 QvfaPelGvZbwgqvksJQBwpP2yQD+yZyrCYVClIbYhFiKo5b9fgzJpiu5+rYx4D4lCbDGeD7opmt
 EURYRv0y1mfckOFlaT5x9bDMKMyqMig+vqW676G1h4o+JF9tsxd9b2zxWBgF2PVn5iw==
X-Google-Smtp-Source: AGHT+IG7Egdiq57krLhYfRt5hbgwVtBqLSjMS7+TYvq4FZMwSdgCTNHNqegl3WryRBOMIce7LmvXRA==
X-Received: by 2002:a05:6000:18a8:b0:3a4:f66a:9d31 with SMTP id
 ffacd0b85a97d-3b900b2d56cmr10940359f8f.16.1754979247094; 
 Mon, 11 Aug 2025 23:14:07 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b9132f00ecsm713509f8f.24.2025.08.11.23.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 23:14:06 -0700 (PDT)
Message-ID: <f8e97cdc-1ee1-45b4-974b-822cfd469117@linaro.org>
Date: Tue, 12 Aug 2025 08:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 41/85] target/arm: Convert arm_mmu_idx_is_stage1_of_2
 from switch to table
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
 <20250802232953.413294-42-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802232953.413294-42-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 3/8/25 01:29, Richard Henderson wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h       | 19 -------------------
>   target/arm/mmuidx-internal.h |  8 ++++++++
>   target/arm/mmuidx.c          |  7 ++++---
>   3 files changed, 12 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


