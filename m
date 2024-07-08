Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692FBC3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQqvz-0007TP-Nw; Mon, 08 Jul 2024 12:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQqvu-0007Fa-GS
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:09:43 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQqvs-0000Jg-LX
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:09:42 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fb1c69e936so20568035ad.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720454978; x=1721059778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yM6N3VDht5ht+1023//kXivrN6yx7acQZkn8MhuYu6Y=;
 b=Q1NCwH+lcgGMx57CxwTAc21kI1rEjzhdC/7zaxHGXl8IhQxQiLRE82qzbhGYxvmUe1
 cMHU+nJJui7zJFCpLXjUi796LXqXZfxQgjesztTYjcOt2jykL/Wz8jd1FEfZSEgG85Td
 yaxZS4RtNFF/SU8456fGzgvpSJLygWfMmWFypg8GseXLO2Tbhs7IJeD6BGVzUQmx1YOp
 NykdkUn6vl+HKshJ/7eGZ36QGl0R7e/xS/xP/PEYdCxOqMHz3RQC7ekNg4NKRxp78eR7
 ze6qRwYRmQpB1UGIfDBlFOV1r19hLYDeYBBPZOp92uAd4iaMNqbNuZHLwxg0/nmMyBv3
 INxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720454978; x=1721059778;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yM6N3VDht5ht+1023//kXivrN6yx7acQZkn8MhuYu6Y=;
 b=r+QyhRKTC45WNGqy6GZ0ZDivt2wbTi4X9zf8FG6yZFN77cdJvZ0F72aCsif9Ym7Sij
 q3nOhjw8PmL24IdGnMyF+jr2XAJwoH5Y3dw0mU4RufsZYL6XDwaDjE+C2ChoUuNWoLNn
 v0kgHv5V4CjhiENg58bTUb9hmONzk+Xnh+Oeo5dRO9Vz52ea5xytCLvbc8o7HM3hp5LW
 Z2dNV8xZoY9RAc93vQJ3yRa4pcvn9nu3NS2qbmJfArFmrPofXw2dAzbBDCfO2Bc/wcFa
 +dhKH72sJdVqcEuGNODtoqBOzxHfbTKdk45e8V4yh/w2m3aP8HNhQM6ltnhUjEfHWHos
 s82A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf4Gvmqo5sUiO5LWEIjsiOuYRzTfEqyK+A6tSpGzD14rl7ynG/GiYfuQdqiMKNj31E0rsvNB6WIVi7CCvp0VcwFTe8GKg=
X-Gm-Message-State: AOJu0YzgrHb6GwyMQO3YhgcblOQ4ABelBcSZ7oIKm1LkWOJWxVnXDT+0
 K+gYDrW3++5QmN/vQHTFJdEbShSSFIpjlX4TZrxK14FucuMGkSWTo8MzVmHd638=
X-Google-Smtp-Source: AGHT+IEXz/WrKDOZY5hhyBfQ6iJe818IIt3DV+XyYTadU5iDFe8TC+nv9mpSwh1RwwN9xswivAd3og==
X-Received: by 2002:a17:90a:ea0b:b0:2c9:7cc8:8e33 with SMTP id
 98e67ed59e1d1-2ca35c2aac6mr139749a91.13.1720454978283; 
 Mon, 08 Jul 2024 09:09:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a95624dsm8341382a91.20.2024.07.08.09.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 09:09:37 -0700 (PDT)
Message-ID: <a99defb0-026c-4ed6-8e75-aeab2be38313@linaro.org>
Date: Mon, 8 Jul 2024 09:09:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] bsd-user:Add get_mcontext function for ARM AArch64
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Ajeet Singh <itachis@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
References: <20240707191128.10509-1-itachis@FreeBSD.org>
 <20240707191128.10509-6-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240707191128.10509-6-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 7/7/24 12:11, Ajeet Singh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> function to retrieve machine context,it populates the provided
> target_mcontext_t structure with information from the CPUARMState
> registers.
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> Co-authored-by: Kyle Evans<kevans@FreeBSD.org>
> ---
>   bsd-user/aarch64/signal.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

