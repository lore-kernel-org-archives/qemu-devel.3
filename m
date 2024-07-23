Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47B4C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 01:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW48K-0002wd-F1; Mon, 22 Jul 2024 21:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW486-00024S-7u
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:15:50 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW483-0001y7-PK
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:15:49 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fbc3a9d23bso825305ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721697346; x=1722302146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=llxCVToRyfUAht24Ji+fDcCnlhyuGiCqw7QeSSjcM40=;
 b=TpR/zpytxaOXRxlrAfFJdGBJ7R2DrfJS+EqjnlxDsz4GoB7Phm5MeiyJINl3hNM/c4
 xiZ74LoTlhCydRQGZPnZ3QM6zsfJlKtZrEB4el5bV9+18Y1UqNkLfY6Qs0rjUo7hDgId
 WluTs8BqVrdk2a8McsZ9+MFNqHr58Yy9Mg5hoNUxcMd+ha5juO2BGFdgNaLfWixEw/xr
 yKVFyMPp6d77hOlQn7ti9CqLe3VrfAeN+8lcjdeJHpE4/e+PmN4HlgdjBkivPJ6vv40V
 HT5Z2XTdrowL3Y0wzd2URDNDCsw3KvMUM2Q+ZlWVGDPedeiMKnxSTqT63ruTIyLlDLLc
 rTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721697346; x=1722302146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=llxCVToRyfUAht24Ji+fDcCnlhyuGiCqw7QeSSjcM40=;
 b=oKSCckUEEcaKW+boRuprNVbhSBR7o8fNcth7q0u7sMaqrpyuGhXbVDEQ6ZHdss3yCH
 dNy9TNP+JpfDMmlvpj2aDemOFm4tq3IQkmYCY6rUUOogD1C0Y+ALFK41qzd06hxK8Cpi
 xmMlia/3uROlaY7BhMvVdICJJGM31qtjz783taNKJe2T9dfo6xRFIo3UIcnfuS65R2I4
 GrPGyAo3DLNGRKWe7g/Ej6zpN+IYBXnervevg1GlltCv+0Y5dJr5LomX4RYVjMlBWePn
 Uk+s2woHoSaZZCXKosv1QBBZRAeBIby1xK5DqzbudNn9S9yMrUnYjfUejPjeNoHDnpix
 RIhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEAaEXlbpRdkyPi5A2jtACbHS/Xs9GIG0sqE3hRUGyOnTiAIZh8uc4Phq4aXUqI2Dwlu8Si9eXu7IFuNW0cqwQ2bFzydI=
X-Gm-Message-State: AOJu0Yxlqns5siC5Va7wSeib1uI+XP/lf/lyFxXVDCLmzHjXIc2zptGq
 Dhr2R1V9Jwl6rKm6fJL9JGZuwhyXSMLXf50mM9WI8l/5uLEk331lf0Pqz0CWty4=
X-Google-Smtp-Source: AGHT+IEHnFwI5qTtHPLNDaAx3wp6V4DQq5Cdq0H+jCNV1sVWbcKWohNVYUPhnFwmwUqS5d3U8Lr/lw==
X-Received: by 2002:a17:902:d58b:b0:1fc:60f1:1905 with SMTP id
 d9443c01a7336-1fd74638e50mr62534495ad.61.1721697345991; 
 Mon, 22 Jul 2024 18:15:45 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f436d26sm61586465ad.201.2024.07.22.18.15.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 18:15:45 -0700 (PDT)
Message-ID: <8919bbcb-2e39-409d-a90b-c924932bdccb@linaro.org>
Date: Tue, 23 Jul 2024 11:15:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] bsd-user: Make compile for non-linux user-mode stuff
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-14-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722214313.89503-14-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/23/24 07:43, Warner Losh wrote:
> We include the files that define PR_MTE_TCF_SHIFT only on Linux, but use
> them unconditionally. Restrict its use to Linux-only.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   target/arm/gdbstub64.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

