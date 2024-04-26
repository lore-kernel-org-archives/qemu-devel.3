Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8137C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 16:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0O63-0007Iz-Iw; Fri, 26 Apr 2024 12:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s0O5n-0007CD-VC
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 12:06:33 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s0O5j-0001yq-MI
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 12:06:29 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6edb76d83d0so2093131b3a.0
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714147584; x=1714752384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QZXIYs1DG+ex7iz5Fvnr4WBL4PBi6AnBOGf+DiWexcw=;
 b=nYkzl6ngvtqsKjCAkKcJ4jqJ7p7zzzG6/+ZleYdLv2mx462wt3Ge0f79zfZgo52mJz
 B14jIFuwCdsaBbmLZKUMzMkpkCpyb3VddpNM/g0/E5LWUd+6cVlk21pRnRn4Q+9Xyyyt
 dyHsJJbMjGBGxOEoQtwRCvdlAiIVq7dkB33awnuOpbjveJckJL7hUuclzpIEYs0WVYAN
 f3pnHZonPDaKXF9ewvBiARK1Gi+Yq66JS5ka6q/vOSft5TxPM8paKV0cozWINVMZQ1Ar
 YjTJtt46GF5OAiYd0BY1cHI6qqUBs13/tjXdJ6AcsZKATpJKEPyYHjPK1XXhhVbWZikb
 m17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714147584; x=1714752384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QZXIYs1DG+ex7iz5Fvnr4WBL4PBi6AnBOGf+DiWexcw=;
 b=eNMuWBJYSEcCVumNd3uRq+6nnN6JeG+FawMIUXQo2ozy9U5aNkKZWmjd32VubV0zFi
 mRMw9ZzmlZwd7ALGNYpGf0FZkpcNGIZwPtPhal4bPjO4FG3wbK1Cj5stK/yoTOUIWrhi
 wykRzfc2Q4ToRlsGT1DVOSbwfg6kgTS2NBRMVOY8FrEFeHVFjT/FSjsfOZSfGDxpfbIa
 bhr19erjOH7UtTCkIISNKBcgANDQVSQGzuAoyjnG/VS4HbdRsR4h+t0OybbHR+3htlj5
 icVo3UUGNUlFfVlwC6Ip2XSuphdFkS7qrK0D1m0ljb9oqelXj5/t5zZmYjpg+QV4NGhP
 eCuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvulrs4lByDq5LJ0AMBrV3+CrWZX8znyRktQB4K5ZGYJLOeNI2nzOauZSMa9wPwdtLNue0GDEUQDmOVBqqYQRrsipn1ak=
X-Gm-Message-State: AOJu0Ywm2hu10TdlsLXQ26I0oBKHQal916Y2/ieDsUO55gVG588VlvXc
 qZYmKCKq580FkJ1kKibo3qAhsrfIbkMZ273vH2+UWC/XJR7azQC79pjteJb4unc=
X-Google-Smtp-Source: AGHT+IEkqFjMl3O1EQKYPyyKYp/6sPB53LP0RdXHp0Bt8mgI4DTdSAq8FQBVxSK1cW+FxUmRdX68qg==
X-Received: by 2002:a05:6a00:114d:b0:6ed:1c7:8c5d with SMTP id
 b13-20020a056a00114d00b006ed01c78c5dmr3954379pfm.12.1714147584117; 
 Fri, 26 Apr 2024 09:06:24 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 b186-20020a62cfc3000000b006ecf56cb55fsm16029464pfg.96.2024.04.26.09.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 09:06:23 -0700 (PDT)
Message-ID: <a25e01c0-5f6e-4568-93ec-970987eb6d07@linaro.org>
Date: Fri, 26 Apr 2024 09:06:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa
 machine
To: Xiong Yining <xiongyining1480@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: rad@semihalf.com, peter.maydell@linaro.org, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org
References: <20240426073553.326946-1-xiongyining1480@phytium.com.cn>
 <20240426073553.326946-2-xiongyining1480@phytium.com.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240426073553.326946-2-xiongyining1480@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/26/24 00:35, Xiong Yining wrote:
> From: xiongyining1480 <xiongyining1480@phytium.com.cn>
> 
> Enable CPU cluster support on SbsaQemu platform, so that users can
> specify a 4-level CPU hierarchy sockets/clusters/cores/threads. And
> this topology can be passed to the firmware through DT cpu-map.
> 
> Signed-off-by: Xiong Yining <xiongyining1480@phytium.com.cn>
> tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   docs/system/arm/sbsa.rst |  4 ++++
>   hw/arm/sbsa-ref.c        | 37 ++++++++++++++++++++++++++++++++++++-
>   2 files changed, 40 insertions(+), 1 deletion(-)

Isn't this basically what MPIDR_EL1 is supposed to indicate?
We do not yet implement all of that in QEMU, but should.

Why does the same info need to be replicated in devicetree?


r~


