Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B813AC54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 07:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjDty-0001wi-Mh; Sun, 10 Mar 2024 03:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjDtu-0001wK-NX
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 03:47:19 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjDtr-00011b-1j
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 03:47:16 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-221a2d0c5dcso1289162fac.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 23:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710056834; x=1710661634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sgWzEZRwyKC1zm4r5+JNjGrUWOKMo0RclMRzkjtXYE0=;
 b=WmppS0OQT4m0YBu23cQb1BRHZwzvtrEi9GUr4/DAh10S7DSECSrK/JQk0c5jT2kz3w
 bcX56vQ3aYsUH6JLTq9p5yH33c3S4et0EUL+N2OZXLuE4728K6qNROCN5q84aLm0wsdy
 CLrFrE14J6ux+l2Kpaf2QXEzyWH6b9M3zMH3rKEqmYMeBt4ybfBUuZgunEigqa78QlZz
 j6ZoVbkxxcPmtZBFzrWrwncuHLBCRt/0LVCtOvUp4V13qStEL5jGRTTAlxxpIFYI4zXi
 ZB3cX31mgictL95sQdLrFwppRZtdNHHsyGX+WSMtbtTO3dq0mLA1YGb/iphzEb2jC2xY
 eBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710056834; x=1710661634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sgWzEZRwyKC1zm4r5+JNjGrUWOKMo0RclMRzkjtXYE0=;
 b=Wa4ububjDJAbaCzL1SyYfAsblrzguDGNwYwmaZG93xr0oeqmsK2icNYfgIQcv2uXdB
 HjtXOia540Ew0O6z1ckM/DHK6PH2kxkYtytPEjq65Pjf1F3y9lQ9oNY6Rn38zM7zoR4C
 vua+ECVxdG97RlG2fbHQ4qJRtauIDpt2bcTe0YMRYK+olyM0P4S9KhG7d9A7HvlmhJSq
 MlnZpLwOouCEKkfq6mkxgnycIiZRvUSwRF37G72LwWV73Rf1v26q31Igl6knBPPiAKwt
 ID/1jewSAq460loJLXHu3j5HyErXwxh6qBOdKD9VXYDkVQZUDHsWeD8AkP6/ndPQmSY/
 TNcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXcZFmmLWGaXIKCXyqval+qbIik3zA3FTf76rvnnDCllEpKw24KKCJCobkJXneh1OgMM28f5Sf0Q1Jm9C/xgOli4psYKw=
X-Gm-Message-State: AOJu0YwOyedc0hxx+hIT8kDbUYF4Lu/Z9RZ912V2Mfg5PLofJA7nJaMF
 fV2mto5/N4WRB6Kr/Ofdf0udory7hj1g6HOt8YlWo3RTLkaRWPwAUQVfdnCNisY=
X-Google-Smtp-Source: AGHT+IGy2KOXDwgXZhFNQrvxLLqZZ1eP+iaFOqa//6oy45jAZx5/qXpUa+t9W6RTM1Yxw14k6DkyJA==
X-Received: by 2002:a05:6871:888:b0:21e:b50c:3e8e with SMTP id
 r8-20020a056871088800b0021eb50c3e8emr4286899oaq.56.1710056833853; 
 Sat, 09 Mar 2024 23:47:13 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 p1-20020a62b801000000b006e66a76d877sm2276421pfe.153.2024.03.09.23.47.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 23:47:13 -0800 (PST)
Message-ID: <a3765207-28bb-44fd-b207-58327516a6cc@linaro.org>
Date: Sat, 9 Mar 2024 21:47:10 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/10] target/riscv: Clear vstart_qe_zero flag
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, Ivan Klokov <ivan.klokov@syntacore.com>
References: <20240309204347.174251-1-dbarboza@ventanamicro.com>
 <20240309204347.174251-10-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240309204347.174251-10-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 3/9/24 10:43, Daniel Henrique Barboza wrote:
> From: Ivan Klokov <ivan.klokov@syntacore.com>
> 
> The vstart_qe_zero flag is set at the beginning of the translation

Here and subject, s/qe/ne/.


r~

