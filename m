Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14058C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhlD-0006QD-7z; Sat, 25 Jan 2025 10:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhlB-0006Pb-88
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:07:45 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhl9-0001am-Sc
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:07:45 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2164b662090so59510835ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737817662; x=1738422462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BySP3pfz9snQ6m2bJOR/ctgIuJR5xXCPvv9R4jg6Yy0=;
 b=dUGEQV3sxC60C80v8mbVN9l0KYmOW/B23KVz5hrPqRikiT5K7LmiXer24b0jRlKLBz
 byaxcVE/UsXS9zBmuDANYhe92o2vEloxGVo8c063VEc+th6xUKj9YqD2I3X1xr1JGtEh
 VE+JFP983svHdefWiZcWS/Bj33v70D3XqifhOYzFQyy0tfxdYxtYxwIMmjo2/WgZ9do0
 q3GUt5lAELAUBf+JgAzrFOPeIo3KfWIVCc9/s7lqndi8H1oqvfuFUpoGX6WOQq1oK+jY
 XGJuxlO4fMS8P4uHnclbhM1vtzHImCi+Vg0ARMD5qrtcrPLhdIs9F2iaKK/E9Js0ASq5
 f7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737817662; x=1738422462;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BySP3pfz9snQ6m2bJOR/ctgIuJR5xXCPvv9R4jg6Yy0=;
 b=MhhtvGvHrK7eAI3WDnOkH6+Qlm0HGY/pa9fmcYGCs6yPIZh2i+1jSKXVqIKA9a+yoV
 GNCsIIUAVFh5iWIkE8FgfMsqgiWT4fbFRQh9gIC7p41gca3WxmYybO0ncHpuEa4fd2ke
 +9++mqjUq3GcFE+tdSsvdH3Xvd6UszmZdwteJBCF1AFN0UGRWk4ANvzjK2RoUGi7gGKq
 EpZ89PlFUDkDBPVL8AOLv+XCUxTMKoigKaH2PzDx0I7qeagkPTsdgQZwvHHTN7R7TsBN
 PtC63mOtpKTMI6JUOR1KYd+oaFKSCBzYQdN1mqdYYURofxUWShL8OXwEdyyeELbo7uSJ
 /JFQ==
X-Gm-Message-State: AOJu0Yy+cjo3TevikZvqKyWNWz/rSZOXhXMMJxHtz7uoWsi00lgOI7Dk
 L9JUmNhLXhPFmvduke/AYJLRw82VwtqiBDeKSgD8oxn7IVFK4kpnDHOoV9DyGXs7Inc53l7srmi
 W
X-Gm-Gg: ASbGncukLj6azYt6DSz5Xjv0c7TMVZTvTBXLl3QLnZnM3HCnjpxonfHUGXBtds1qmQJ
 qLXvAOi02XEa6Rwajku4H5dZQHi8G/x5pOX7IBmb2y9t22WJvegik7NQgjIYimHri827YQnLC41
 wU7C9X4ELSRCBVTti7Eh2a4VCa3QUSkZ+kdyRCdTmGlxEeobuJRQmSJDNgZ8en7+x2Iz1t5Qonf
 WgT3PDAp7v5fMj1Be4cDqxqUGeZnGzfYJ1CBCTV2WU8vHg02csKd1cUazkkZkjE/FOJpD1CN8Yz
 ar8UniUtB/adnrWtrzIMaw==
X-Google-Smtp-Source: AGHT+IHAcdumVhLG9wa2SYwhlI8V1eblMxx891rT/xVoZnAuRqgd55vnXmnYa7ZBZgPGyaHrkIV+6g==
X-Received: by 2002:a17:902:ced2:b0:215:9894:5670 with SMTP id
 d9443c01a7336-21c35503ad0mr574823075ad.16.1737817662578; 
 Sat, 25 Jan 2025 07:07:42 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414d87fsm33254815ad.172.2025.01.25.07.07.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:07:42 -0800 (PST)
Message-ID: <8837a9d5-3acf-455e-9d57-bd5ef95cf6db@linaro.org>
Date: Sat, 25 Jan 2025 07:07:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/76] target/arm: Use FPSR_ constants in
 vfp_exceptbits_from_host()
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> Use the FPSR_ named constants in vfp_exceptbits_from_host(),
> rather than hardcoded magic numbers.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/vfp_helper.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

