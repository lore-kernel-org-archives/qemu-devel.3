Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A0CC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvxw-0007WD-GV; Mon, 17 Feb 2025 02:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvxv-0007W0-DK
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:54:55 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvxt-00079S-RP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:54:55 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4396a4d5e3bso24904545e9.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739778892; x=1740383692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pXZpP6qeRYE8FKkmbApKMLEb0TDIS9XUl3BJt16HK/E=;
 b=HFLNVy3q4fU9mCSNjLBFepRECmI2baRerNG1Uu8XYePYN5dNNqJm8CCNIn4cmzxfE/
 HgtBg75d1d4Ypnxoj8vPX9E0+40yh7QGak94vHgmiVOMObGVtwx0NrzO07LDMFwbKGAR
 YJREN5dxTKAMh7oppaJCj+DzX0IXeaHMJkUqUgzSL0r1DS8DhpLm3Tim7quU99nMnkvq
 vx/3EqoxtqGB1UQczB54ZfZysWxISaQ9IamLtbeEWMmUPi+BoSFIYB9Vs5dUGtTb1RQV
 1ZXrzHBDVjS+iOuBr2jGClPmdirIEYVJXIoqoG14WrTB+nMHV0Bm43fZlvCM11BuCHhY
 Bb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739778892; x=1740383692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pXZpP6qeRYE8FKkmbApKMLEb0TDIS9XUl3BJt16HK/E=;
 b=ob38ZONV3Qt8YpJABdyq54kt7ZAbJh/NAKaRkaoemDmx+gBvu3WfNVFr2pIN+lNNZC
 6knxtQX+Q7jQxs1qUprQncSfxsR4XFOxMJrr5MKkuUpYoXUH36rivSfMkbnX8vnUTzOV
 Kw31NREm2aKwwHLgpsJ7jlZuT8KSdRc6JebNfSp0+bivMb7AxBnRC8FqzX4mFltNmbxw
 QOOmVxgyICMacLUlJKhUrJ5SVsSDiyYiwn2pAWhDOisg9h/e+wm57qwElU3woC4pzYv/
 mbdGHdUjDP7Fr6NEixj47nMMoAZ4rTWKYeN60xZAydwClKCGH6mWdNaAMcY7cWT+UgA0
 vn8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUysh7/EDcgOq3zRlJ/7OMuu9PN6tZcQiAMJS1c0MrNwZ6DgpeUFqagWAcSqlKyCgwy+sFM5rv/biUw@nongnu.org
X-Gm-Message-State: AOJu0YzIJKVGBZH2gDPNQ5ZG/OLi2eWQZdfJH0WbL/xXJ2iK91gPy9NS
 zbP3Zzdr2FuxYZRmH0OhSJ5yxuQhxvGAOq+xrmAZ/cvpDlZWbqNzi7KaG9wETZqkBkble5Wr3f6
 t
X-Gm-Gg: ASbGnctsavOO5UfSo+MiRWWYFOS1a9plsn23tlVxKYEMFEtWO3X1Nc65GagUU46LkEw
 MPNFSnv75O4C5FClydrGYfJDOq/ILWTce2s1oKGejVXHjNSj4vfrJBgvPj1vO3Cmqy6bIB19DZY
 1agUWv4UTerpAFRpJIjYEHzJyqmXnT/B21DrgHexckMijuiqYIp9/zydC8/FeRItVwBtX1Sr39/
 V2tUt1hELQIYeJsupoIM04FzwbXa03MAc3GeWSuS5lS542tEPTlBYTjZQyr1kv8Z2e56Re2E8Tz
 qhRBWM8ylXkPeglOeTdfE8xpe+r5Pd/z0OM=
X-Google-Smtp-Source: AGHT+IHmU3NyDEQjdcdagBwc3p4/lBpeAcKBnNu2YrmvJUCijzoQbz8lBx3MzTmCcCOH8NjlczuPhQ==
X-Received: by 2002:a05:600c:4e8d:b0:439:59cf:8e16 with SMTP id
 5b1f17b1804b1-4396e70c739mr73721765e9.23.1739778872988; 
 Sun, 16 Feb 2025 23:54:32 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398ba53406sm4219565e9.14.2025.02.16.23.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:54:32 -0800 (PST)
Message-ID: <da585062-67f7-4234-8258-32be1d03f9ef@linaro.org>
Date: Mon, 17 Feb 2025 08:54:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 055/162] tcg: Merge INDEX_op_shr_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-56-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-56-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 17 +++++++----------
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                | 11 +++--------
>   docs/devel/tcg-ops.rst   |  4 ++--
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 18 insertions(+), 29 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


