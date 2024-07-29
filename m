Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16653C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcTr-0005Cg-Qy; Mon, 29 Jul 2024 22:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcTq-0005Ac-IN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:20:50 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcTp-0006Ze-1Y
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:20:50 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-44feaa08040so23892581cf.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722306047; x=1722910847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hs4GzPNy5V54pZYKeUr6ChWpCBV5fc0f5Vs0nKwuDRM=;
 b=tXTfrVVtpkA2BSbfVSY7rwz/kiZs1bz98hu8EEZbmuBFfQHbCO2yxN4ZiSZYojPKRk
 5Qg6Pj0MlMWzdUcq+ePQNteK2H+1xO0VAdOwgWvYmVt7BKyYCEuGKOj8W81vAdbJfiml
 6S5T24FxoV45TOCmy9gzZ2bJEBUNRVRNdgZOa/hAMcwg7Icifauk2QTkEBFe2GcCPk2C
 iy3LWm49sj/n4tadjS1EPHoEoHZD+AJgvCsYbCKX97YApmZdwN8Ly3MeX7VHxC2s3S0U
 +fIFyFxDsVZuoMuajV1F7yyF7YIQNEVf/1rYVHd7r5UNFiBnMjbvW2OXw5Okc4McfObn
 PoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722306047; x=1722910847;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hs4GzPNy5V54pZYKeUr6ChWpCBV5fc0f5Vs0nKwuDRM=;
 b=v6c7hpNnV5w/0TUpj4p1qf16BaLjSm2w6iQAV+LkDHUQ6jjbKzGlMImD5msnxFjXSe
 Do7XPsUywj6pS4xmhfJZltS7V40sPoAI4q1A582RlNIpTdPihSYuYCvNxPbuKWozw/wS
 DOT2jOoe8ZY4qWAgtUmE9N68xqBb1tF0rxAB6gCZ0waVZyQwIgzQr0IgflSnp9tRcIEo
 uyc2ucq3Y1KWzKZS0j1rfdEK/BsTp0DRa85ycEAP7asCkjOun6KBGhhTedf9/dEoeHO3
 O13euh4DGUgU/mfY7Zi3CKYJ2b7SuNZSC/PI4qV9Vk0FIvfL5e4UHOTrnas+pFdOgcXI
 FfZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxIJ+9xBT+nvUDVATYYH7MgYX+fYBNqsmZAYO4rfXeDDV3D0iKGEYirOvcghGV7MVjz5Gt0kDxy0PWb/UR5Gs+R+5J52E=
X-Gm-Message-State: AOJu0YxKDAyvquHwC2LkZ96Tv0353+OZzL7fn1C9JiIprQmuQC4wXDrE
 Uu7cYWUDA0xnpGSOnAkK5Nz/3qYJaJjZ/xbuyGQijgSb+F4brddeUNetkDH2+dgRvfJsP76e+X9
 J11M=
X-Google-Smtp-Source: AGHT+IHngSVEDMj5B8lDVcAhXv9ZB0s3OKkfKPjEAISMpEIoGC+o10yKL16QUUkOxpdFkF+gvu4vYA==
X-Received: by 2002:a05:6a21:178a:b0:1c4:c93e:a57b with SMTP id
 adf61e73a8af0-1c4c93ea754mr3989950637.23.1722291899783; 
 Mon, 29 Jul 2024 15:24:59 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8a1aadsm7293808b3a.193.2024.07.29.15.24.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 15:24:59 -0700 (PDT)
Message-ID: <61658a95-5e6a-451d-b36c-5031618876ab@linaro.org>
Date: Tue, 30 Jul 2024 08:24:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] docs/devel: update the testing introduction
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240729144414.830369-1-alex.bennee@linaro.org>
 <20240729144414.830369-7-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240729144414.830369-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
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

On 7/30/24 00:44, Alex Bennée wrote:
> Move the mention of "check-help" up to the intro text and also mention
> the meson test integration.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   docs/devel/testing.rst | 21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

