Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F8DC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 06:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdOAt-00005P-FJ; Mon, 12 Aug 2024 02:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOAr-0008VW-Nj
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:04:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOAq-00023U-2I
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:04:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-428101fa30aso29874715e9.3
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 23:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723442694; x=1724047494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z9fJcAFxs5RPqlywFK5Pcr5sIz2IiGoqrVmS5jgrKfs=;
 b=NT1qJAGK20EbL9mPxde2uHSAKlpsoyfYuXdKqFD8XFGVKgeRgE/CT/CZegbWuDrcn5
 CB/pu1NO/Gfm3o/OoYEfJgrJscXxeFIT//HhnZuKOGBJeSU2fAjXySQTkRCzC9zyl7YJ
 26ajYI/MAaKDCDh0iaFr9QFeql0VT+7pgOn4LQlKXEW+3SU7MJpu5e3lfw44QequJGR6
 Dbcxw1opuH7KGzqv/+UJ/lJGlrddOpfnrlXhCdFcoweVk+YOLAyuFuJq1xyvOm0qKHE1
 UfkcoUGgxAT4l2gcowk37llItQEkcKr2JkxFwlS3ekOoMX+HQlfnPW0T3mJuvkEOPP1Z
 t+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723442694; x=1724047494;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z9fJcAFxs5RPqlywFK5Pcr5sIz2IiGoqrVmS5jgrKfs=;
 b=N/s87EGQ8jiJWKf/UuhXK9jYGFIWBZm1khsouPCj6VrLoUKPjZHEpZD7EN1m1F+xwC
 raulo0kuvfrC0pIP5TzBeneTKu+9DtLi9/7kjc9e1VIi+hITZaAiCJbqIOCxVJoNPsXe
 R1Scj8nl5yKKokcZw5AnbkF7wWFVT6EiCWs9S8WbBCOQ3INFMVgRao+2+SkwhNEbLULh
 GstyHGmqFRuMmrOXMCgnuy9yh6qEuRplCUheRZeAFx59hANobiLaoLy3ui6JQUv+k9r7
 ymq0qqX4GbyQZZ+EkJaAD9d4xnYudxkuaqKpYRxmrZmtmT0AVvQv1e2j6XbPm7kgF3va
 8wcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiBcvk94dtSTLpV7KHjS3F4L+RG3MPmmCZ3AxvhSsmFsPXyVOwkcvDzPFwj1I9qxtROq4bBXUaY+7eUrqh70HSJ9DPlOk=
X-Gm-Message-State: AOJu0Ywj0eIqN0WobAY1JkzoyzfGQWW4xL/vy3qNOXNNKwq7E7VvckIk
 Rm5uMA7M95SGG7qC4CWyfih0bviZxiL0MXM//xE8ySBKq4niONWveqZXWorenrw=
X-Google-Smtp-Source: AGHT+IH/6LTr+Ywl8hmLDrjNqRMqvicfyLiqjHGlrda6mPr0hZ+bFv6uQfxfT+uKqOVCTIUZWqONeQ==
X-Received: by 2002:a05:600c:1988:b0:428:141b:ddfc with SMTP id
 5b1f17b1804b1-429c3a5802amr69256995e9.31.1723442694044; 
 Sun, 11 Aug 2024 23:04:54 -0700 (PDT)
Received: from [192.168.71.175] (133.170.88.92.rev.sfr.net. [92.88.170.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4f0a6d76sm6484940f8f.115.2024.08.11.23.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 23:04:53 -0700 (PDT)
Message-ID: <b759261e-8545-4ffb-871b-29ed830d70ff@linaro.org>
Date: Mon, 12 Aug 2024 07:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/i386: Assert MMX and XMM registers in range
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240812025844.58956-1-richard.henderson@linaro.org>
 <20240812025844.58956-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240812025844.58956-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 12/8/24 04:58, Richard Henderson wrote:
> The mmx assert would fire without the fix for #2495.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/emit.c.inc | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


