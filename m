Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B78C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKwL-0007S5-J0; Fri, 12 Apr 2024 13:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKwI-0007Ru-M0
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:43:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKwG-0006B3-Qd
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:43:50 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-346b480e1acso710601f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712943827; x=1713548627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e/Jp/Gg+W5Xvp16CzLQKlYWnZlaSFDp1tefxb3NRXo4=;
 b=ImO8tX8AkyqU89mDgjW6Y9LZjhajfpRpmlev7zj0vRO8Wdq9WdDCe4bh85WMofqXiq
 rJoc1OsCXO3v8C8PY1kaaiE7FNHbO1Xf37bah33GYxwTiVJBv+Coe+t+zYVGsHvaWdWq
 p/iyrOMsRHUGdiXbQJxOa+z5AGzoYlqjOwkglD0Oyv1rz1pI6FPimFEQIs4PkAymUBKD
 HypCQeuWlKFZbeDaYrRhNCzmn6q2Dnbfj0ZWI3N785TEIwriNj2lNWNHo1t4+yT5mHjm
 oUiEC3BSLkZqSM9e1sBMRdafvjqL6wRgaR+gRN7TVA/bfr87Q5f8CYWdlSIADSF3i1RA
 Z6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712943827; x=1713548627;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e/Jp/Gg+W5Xvp16CzLQKlYWnZlaSFDp1tefxb3NRXo4=;
 b=BeIS+FzsZU7BjHP4iICtgAB+pd/9A6EnFc8/q/Eg3E1f9lIyKAWFRWWz+n/vMvxtCf
 ViPbK0KKMHKVZm+CvrkRER6crW0z4lmeubTcM5EAC2RSzFKosdHWbNzBveJYvZKJVO3d
 6WGPrv0irZnkuhIfvRlFhDLQleZqXuW+rnzyZRwjOcuyhfCpH5NwotS7dMNwvk4jOGZo
 L8KkO+ZXWQ+TgP5y3c1kgsPfjXQUNHoJurHelc654BUa6yyUzl5AAqAH4Nj9cfu4bdJj
 iccfgxlq+45xnnpA4uRlHMujzEp128x8LrgSgE5Yvo0kc2/KaA1tib9Mk4z36lBTMjvP
 OvBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW99eYgJUynUyfEFUfBvDtBTDOFhXfjyAGzYyo6QjD9+XuYVw0DofXIjU8T1YMMTVo6wJulJwr2U7r00WJR4S26ZSmJn2M=
X-Gm-Message-State: AOJu0Ywkfe3D7QtLpT9NH9JjzU7EsmTrLKoLDTl/Jsu+hNSxPwA/IYZ0
 8aRdoa6HK5bkggMlt/fcF9EknuiDZJgnrEaXwIuDUL/QP39zUzvlEW/odCP8u4c=
X-Google-Smtp-Source: AGHT+IFUaBaosWXam9ULK5zkwRDuAhLScDyPF0WHAxFHI4R1jDMPYwI7A9jbGgDZbMPTfVUUYLDsXA==
X-Received: by 2002:adf:ec08:0:b0:346:fa0b:bee8 with SMTP id
 x8-20020adfec08000000b00346fa0bbee8mr2054981wrn.1.1712943827049; 
 Fri, 12 Apr 2024 10:43:47 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 h6-20020a5d5046000000b00346df659e7dsm3323625wrt.17.2024.04.12.10.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:43:46 -0700 (PDT)
Message-ID: <07fb11cc-e3e2-423f-bc37-e6db459a3f83@linaro.org>
Date: Fri, 12 Apr 2024 19:43:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/27] util/hexdump: Inline g_string_append_printf
 "%02x"
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412073346.458116-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 12/4/24 09:33, Richard Henderson wrote:
> Trivial arithmetic can be used for emitting the nibbles,
> rather than full-blown printf formatting.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   util/hexdump.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


