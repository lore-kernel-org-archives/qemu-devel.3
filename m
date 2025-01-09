Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAB8E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVtuv-00075Y-ND; Thu, 09 Jan 2025 09:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtur-0006xB-G1
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:53:45 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtup-0000X4-HC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:53:45 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so760799f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736434422; x=1737039222; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=inJzFej73TPHFT71Py5dLswF5pzHTQpW3Y3CRSOF++g=;
 b=M7T+4WBlLxqA800PphvgR/+BYQ/ldnG9ri/V7GRT8PYlycVMS4On9x9UWirM5jNbcV
 usvrzOkXwMojsw5on90nNhVhgN7znp25Ujna9snXa5FVJ1hYv3inQX1c2Fc3CZ17L1I2
 85eO2TUqa9ZqAVtOhp+Pc9S3+nY0umIbTxjKPbDKQN7j+JcBZIi6ik9N+MOG71qCFzjI
 5fvNvNMqrgWwiQ3n0tYtSQd5nV6DxyfYIUcZArSQG1RpKLEiQjqgQiD6HTGTEWt7Rmjg
 ttErnDX3jE3DD18O7w7r6o/fVm9h2yYCcQ6Zl71Nkw2as3+7SLBGsSCwOYslnttR41JT
 hgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434422; x=1737039222;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=inJzFej73TPHFT71Py5dLswF5pzHTQpW3Y3CRSOF++g=;
 b=EKBsAFBzOtIbjNro/YaOj1k26TOQzObAUxCZRlRqI25WpxG+/YPTZXmB4NVdGQahFW
 r709iwVJyWPTXXUx8KTQtxuF16bXBYn3JQCIxFtgu3LC979tDXBkPnf6gXrrLirlM4AK
 lf3eEhsRigmoYgXMs5//SP7k/UJOtlUOXENFNu5SgXA+eNEM4aK245CZxlO2e4NUctmx
 9QLeYkPGaRvkIETuz6Ptt8Cca7Xs3gDZP79HM98xOvkTX1FH972y5BoTuGGbroeah1NN
 OyS7S2tjJ3Yr/km8xRzg/DNJlaHbKlgKnx1+HCrlJcLxLy4bUmxZnwhZzMneURe91v4Z
 gIuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq/u/GdbMBnIeHxRcBtTcWJYcDpXW4sZ+76l7U/X9NmLrR1euUZwFHPLE/zpRTBNm7Em/t2h4GMnC6@nongnu.org
X-Gm-Message-State: AOJu0YyzMARwYnDvTEhymqmkRW7qMq+BoIJy/aaBa86QJi+SAT041Duv
 VyUYjHUum3lG90r/E3cCZk8vJ/ucHG0vwS3gxVuqXTm7ODNavWwxxl36sw4WD3U=
X-Gm-Gg: ASbGncvikgNAvnxdbnZ/kM9onXCNTZycgde2+LjeA8XIJHrkqU1YOf3seR1woEUvlNm
 5zp6nEi/b1wEQZFoUKBKuhZOR8wdJZRZFjAlVhEEYTNaHFwQSRsyGbE+jBMjQLXSOh7Jdqeow4v
 04fPzqRuXmp4owcRLd/CxHT48rQgR9pb0GgnrEoFp2MDgWR46sg9sPZgO2KMLflvljHSIxYfGd1
 4kmoSYpuetktng+C/Jzhbq8xGez0WeybKdiyNUJ6ln2S7oAiOEsgVn0GQL63NLmRE0eZYePd9ae
 89JhLv2va6QP7Lu4v3T4emIFj/I=
X-Google-Smtp-Source: AGHT+IFsFNFcJ6B+RnNDiVT760XN4BZJ725vAjISwTmA9FKp9dHun3n94HxcyuYxHjpPMecHn1PjdA==
X-Received: by 2002:a5d:59ab:0:b0:386:37f5:99f6 with SMTP id
 ffacd0b85a97d-38a8733bf6dmr6692948f8f.53.1736434421831; 
 Thu, 09 Jan 2025 06:53:41 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383df8sm2070161f8f.38.2025.01.09.06.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 06:53:41 -0800 (PST)
Message-ID: <c60aba0d-1813-4809-8b97-95178a599506@linaro.org>
Date: Thu, 9 Jan 2025 15:53:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: remove myself from sbsa-ref
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
References: <20241218123055.11220-1-marcin.juszkiewicz@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218123055.11220-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 18/12/24 13:30, Marcin Juszkiewicz wrote:
> I am ending my time with Linaro and do not have plans to continue
> working on SBSA Reference Platform anymore.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)

Patch queued, thanks.

