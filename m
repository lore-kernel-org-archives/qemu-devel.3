Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38295CF2576
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 16:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t016w-0000r3-AX; Sun, 13 Oct 2024 12:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t016i-0000oT-5F
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:06:12 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t016g-00045H-GY
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:06:11 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20cb89a4e4cso9671855ad.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 09:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728835569; x=1729440369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f/8jOx+Rh5vhol+XfHLwCekRjgovMvlYbe3eDuUj1CI=;
 b=F5n+NWxN12gP5jzLr8/+eC4A/bCaHm9qt074u8a6DtYtRdP1c51BgsLtpuxtBBOevl
 UKuZxrPaNdNY0FDoaPSFu2pttixCt3N1H3LCnrsKcu3xOik8OuwM97+nhSlFQ5/Nll2L
 GNwPaMqZy8omOgqJvfV95pHuKcIUVILVWlPb6so2jgDW2IAJnoIyWVpKvzFXpAFpWgZV
 RJR+HQkrb3ISSKkxDYLHjnwbF6CXTKbdlMfsxSvUfWroyXl9Fv7WSjBZM0PX89FAR+AY
 v5TaWH1RmEtGGeoZpknFYRC7AK2TNgYIrYPovlqkMJMZincueVrnzJXmojWxmveGwWgJ
 93Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728835569; x=1729440369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f/8jOx+Rh5vhol+XfHLwCekRjgovMvlYbe3eDuUj1CI=;
 b=EKYoyoI/v/tOXlZ8F5aQuE/cyLNXHMjnjFbBXS16YBiUG7zJ3tSOLkmpAOkL23jYGD
 4wYgikblT+AMfr8tRTiRIOYj1jfwH8B1N4G3W7DOP3eisWM2OCgl5LYSOMaGrR/2XnQB
 7cq+mWUrhUiltVLdaF7meVOtxfq0oSnsURliExN/616qabdlH5jBwGmk9BKCcuRlsLdt
 fsxSAlNjmXd/waP/3AZF5D5FbfWpcJMbtGIdJ7gSrxYZVS6724KcPPAzQ1AZXpfT7hDD
 m+jNZH2ga03tR9bCq/gUNwtN/LIhya4TKxk2FGGRX1M5servxdyI1yEcDxrOZISLJ6xL
 Xp+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb+Py4Y/7L2K8WcOnJmv+oAbovu9O3vcHD0leFklocJB4BwlcIdQyc2QnLfbT02t3iXUIMVySx8Rqi@nongnu.org
X-Gm-Message-State: AOJu0YyhRLryVFDiRCs58Ksx5/Z83AJDj/ITOrIyRh3gGu8L4DlabStT
 9CQRQ4H/XaUOxI4Pm3pG5WEZ+Hla6zRKAguOD/CXoGms+zJm9N/TTeZpMST4B/A=
X-Google-Smtp-Source: AGHT+IG7n4bj27CTmlgyy2d4qgR+SG/nIXbvYJValRo9HE7qR4/B25Pj84q9iZtGvKEEdiu80Eqc0Q==
X-Received: by 2002:a17:902:d501:b0:20b:951f:6dff with SMTP id
 d9443c01a7336-20ca131e652mr126576655ad.0.1728835568784; 
 Sun, 13 Oct 2024 09:06:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c35522fsm51506195ad.296.2024.10.13.09.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 09:06:08 -0700 (PDT)
Message-ID: <cc7d6d0f-9436-44e2-bd79-5bb6589c17f3@linaro.org>
Date: Sun, 13 Oct 2024 09:06:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] target/mips: Have gen_addiupc() expand $pc
 during translation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/translate.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

