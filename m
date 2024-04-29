Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9D4C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 23:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1aob-00063F-QO; Mon, 29 Apr 2024 19:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1aoa-000637-Hy
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 19:53:44 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1aoY-00022r-C5
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 19:53:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f074520c8cso4969953b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 16:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714434821; x=1715039621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9fJELmmjJOQI0n3GuoIlnJvJGhKnbs/yL5JfvqkR3M4=;
 b=OmanpX3jtZzrWLu1FFduh1Pyn4e81zCPZ0/TrOChH4FPD3j9dm5Bp2iO+MakrfQ+08
 pUxgFrt32VzG0ZFJvSOXrBzmm3tGplbJwV++7GMG3YO1FovfSVsOtMT6JkjYZ1Uqx3ys
 Cp8TyrVvAzfDRxHpvQcS7pnOFXlz6e34wQZciboYQL6ypalenmR32sL2Q1SUvSB6ObM9
 Ym3Ll3HBMRcaxkagsBuwo1J7SlciPj6yB4FevPunpFBSmipFRq9xRMr4S3tsHC2lQMed
 hXmZ4/GzUhrWUo6UaYoDI8iN+UTfAVa6D8B+ISbDgfT5WxV3KOYMP/vvqX1orszV0CWQ
 0qxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714434821; x=1715039621;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9fJELmmjJOQI0n3GuoIlnJvJGhKnbs/yL5JfvqkR3M4=;
 b=gZGCS+bhE5ba8xOSPZoWLfZQxH9GsdlSv7OAGRIf1DSD8my9XPe93+MxuSM4wBsYdv
 m0U4xL5HyfgxPX9g99CUU79sMwTZ3KGaCg7ba6NoagwKZqjEYi4vv8NbkuQ4slCWAtr2
 VmIzNnUc/CGHqPhM2afapuCb6DYWwzDjasuiRX1hi4v75QhlRAC3Uui6c/+elqfUzL51
 RM44SvPPUTXo1qpwcof9H+3fBRe7v9CAMLeUSKh/rg7SKOBwqBdN09ZzwdrOa+8Ac6lm
 BpvsKU9s3z1Z/QzRNnme2VrI4aFG08O3l882B1heqF1S3m/rR4+dC4PtMXAp+rUHo9fA
 v5jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHvedgIsxsf08JskuNQBpPaLiy1wEiOAgoDIqEGFJWzsgFqnNy1YsHy7CtyvN4BrQ+hiS0ClL+Ub17On5uDg8T+VTam98=
X-Gm-Message-State: AOJu0Yy8wnZuhvKW9Otk3skc9aXlXh/sEZ5EpQ+odFBx7BuSkrM319vd
 BPptlQvDDA7zRzEFDRj3dIdiI8qw/wt0v4C2bd/Fq7FALbEcgk6VMNtmzkjPpKU=
X-Google-Smtp-Source: AGHT+IEvr9iThHBBbDtgmh+4zzL6Rd5fcIrcEDcPLr5Kx0mKhdsBIA1l8VL36HFugBYzfiiIZmP0Iw==
X-Received: by 2002:a05:6a00:22c2:b0:6ea:bb00:dbb6 with SMTP id
 f2-20020a056a0022c200b006eabb00dbb6mr11483421pfj.8.1714434820740; 
 Mon, 29 Apr 2024 16:53:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 lo8-20020a056a003d0800b006ed4823671csm20504324pfb.15.2024.04.29.16.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 16:53:40 -0700 (PDT)
Message-ID: <005400a5-26bc-4dbb-a130-4b8372db610a@linaro.org>
Date: Mon, 29 Apr 2024 16:53:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] accel/tcg: Move @plugin_mem_cbs from CPUState to
 CPUNegativeOffsetState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240429213050.55177-1-philmd@linaro.org>
 <20240429213050.55177-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240429213050.55177-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/29/24 14:30, Philippe Mathieu-Daudé wrote:
> @plugin_mem_cbs is accessed by tcg generated code, move it
> to CPUNegativeOffsetState.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/internal-common.h |  2 +-
>   include/hw/core/cpu.h       | 13 +++++++------
>   include/qemu/plugin.h       |  2 +-
>   accel/tcg/plugin-gen.c      |  5 +++--
>   plugins/core.c              |  2 +-
>   5 files changed, 13 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

