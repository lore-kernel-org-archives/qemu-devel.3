Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C3FC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 17:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAXgG-0002Ml-Pr; Thu, 01 May 2025 13:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAXgE-0002Ll-7r
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:26:38 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAXgC-00046B-CE
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:26:37 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85e46f5c50fso118061339f.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746120395; x=1746725195; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hbb5ZO47x5Q1P8GTn0r6Qa+hJ9JfMXkypXYYocFs2Zo=;
 b=OSYCJFXi5o5hyH2wegc/gaxYApeZk6Kj+rCZCuQpsRH7bvFvdwq67fnCoMo/6W5URm
 GMfqlRp8R/z99e7OpvyLdktOwwztmChcgt7OQNlrl290qpU6SEmTDAGIrdL7ZvGs/Fpj
 xHRQkoxlvq23kIobapbBpMPplQtSDfvUc8jPyE2l12QvAWRbBSKPIg9sfBeI2WNqdVzB
 MPuLkczVwizE6DEj143b83R9iPwCCqV1oxMnj3Pq+01GNWCWvLPaAUIgcSiIZ366LyaM
 lL+d9AyhlqZoG+WMydc7ESwMnqvIq7b/yXyjg9LfU78naShjgTcn1Y+nWTMnwoouzgb2
 Al1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746120395; x=1746725195;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hbb5ZO47x5Q1P8GTn0r6Qa+hJ9JfMXkypXYYocFs2Zo=;
 b=XHMDADTtPzOMiwZ5obgvz4bdH5qKiJ8AXvivJP9KHvc5vg20xqtHzTY1nF+oRa8QVg
 xb1QPDt26DUh2+26jGIws1FrWIJp2C5tulbApEdYm6NrWDaE+wukrsktPce7CSfJNi2y
 4RCKcNtW4icfrb6gF3chRzYGqObyaevjD3BV3UTcHgGmZQUpKfT1b49JXZGZhLXAxK4x
 5WTdE8E20HYCIlSCoupt+8JYsb7YNfnFS8sbbrmgMBfHjzeFg6AHHyqMyA1KreirV7JX
 biQXssEXSAgBeHSHxIhY2QC9bwxXrcRuB0mxQFfe1SAPJRvOxCnmpWDUWPiFZ4wuQoJV
 pgtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTeIaYiRXdsiN7OcWkxfbd2oGcFYyLddjMs9K7tRXf+2vSzSH3Lhcsdq0jZwxh7nYwB5uBVnbxNUtW@nongnu.org
X-Gm-Message-State: AOJu0YzY04Pn0VuSyoXc3lN3VDtzgofrW/XAsAb90BxrqaGBOjgAZCGz
 f5PcKELR/yVJw1DxEGG8hUiAyRjDraQ9mMTTIsX34nodTb8MPdVeAyzMwt+0+vCrT97L9lkeKeY
 T
X-Gm-Gg: ASbGncsrBoGYmZVnpzgDdv1uoWPQD5xZ0PgIV4UVjTNKhXvZAxaDhCbZM5Kngz72afg
 e4haZURgwd/CKnAUK2z0qBNf0ucxlOcmQAtyvVtzrKr1oTstSxdc+EpVoJ6B7RFl9vio7srX5rb
 s6vvH7OtJviIydBTF67erdA5s6gZ4eNOXrTZWRerIwRO4Nb/ykU79ECaCFd8ElAD91G+uUo588k
 QMxBBvi73KaAIAVFounJErpVkeD1l2kSOkhqwpF4CV09LRwQgSghEF4NzpitUbc5Ge9hsu4tlk3
 6C+NPwSdLjiZonz9EZSovYcK6hHLYNCCaZMrug9lh4pFUYZ5Lf6gKLrbi8OpWUyRBjotqqvS031
 MeIK8aaUjMgs80ysLFjo=
X-Google-Smtp-Source: AGHT+IHg3PFsp/wq1VuZpNcXkmb5ggcYSbaVN39QYUCs0wn/dpnfYeSb5WsrPxDbv8CWrgN7xNjYJQ==
X-Received: by 2002:a05:6602:2988:b0:864:4a82:15ec with SMTP id
 ca18e2360f4ac-864a33bcdd9mr474652139f.6.1746120394713; 
 Thu, 01 May 2025 10:26:34 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f883016071sm276886173.127.2025.05.01.10.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 10:26:34 -0700 (PDT)
Message-ID: <4e3328be-776f-417f-952d-ec38a7a36434@linaro.org>
Date: Thu, 1 May 2025 19:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] accel/tcg: Build cputlb.c once
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501145520.2695073-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd34.google.com
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

On 1/5/25 16:55, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c    | 3 ++-
>   accel/tcg/meson.build | 5 +----
>   2 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

:)


