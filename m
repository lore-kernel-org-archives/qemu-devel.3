Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE679C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcPI-0007rj-3b; Mon, 24 Jun 2024 01:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcPF-0007pf-Q8
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:38:21 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcPD-0005bZ-2s
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:38:21 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3d229baccc4so2076972b6e.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207498; x=1719812298; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1yd9jpLBAWeoF91GL2dOD1ecxQtcA5dMx4lXJm0N/uI=;
 b=SNoh37P1YJT4vj8Q9EEEJeP89A3kreVk73yNfccy8P+96qamLyn5xiwu3bLRkwI4ji
 IYkCwRiZZ67kd+q9tAuqGlGb6Z4TgVFqDr9GhxsVhFvTKIDIgJpGc74J8PBDFY2uSgCX
 4pkSKVdcXMWRZU0ty8l8riMy+HXggwcT8cO2mmifHD5+bgg8La3SPLc2EUl2Nk5d3Jzj
 WGWkLxdWNa/T7h0YENxxIclQFhAaMkSfhEUAFS+v9rtcakeo1Sn+BQu7vpTg56X/QeoW
 wOtdDP8SIszZ0TA1UC1oiVNZ169GVGKM7AkPElsBrpUCa/Yz2XUdrGypgJ0FWghIcYul
 H+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207498; x=1719812298;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1yd9jpLBAWeoF91GL2dOD1ecxQtcA5dMx4lXJm0N/uI=;
 b=w2M0xd8Yp+IShbY//otrHzpBNReiFyuyN7aRQKd6JByT8PzXKmE6mwtYhgTe2AzHbl
 xyPK5l7NEHuPDjBCYcwSrmanQoil7VnvwVqsjK0ZD5b4Ebbcwk+yEfEkkTnGekzUjDoy
 7V/yheJJ2BTYSWH3sDFfggnbaGsQHO+VIJDQ7aeTjizX3k1rpNigvgTpm4tqunKjKXJF
 0hkwGLtR3igWo+I8E0qMvZwfsWX1tYLrg2LyoyEcgcv3PR+iEJCuRX5V1Ms4x9ZGKqkd
 8Go/3npK0ODVJDDpP2oZ9/q5ehTYoCLErAvxluKw9AwbFX0yYZNHWdUirx3DNo3dbtbm
 9NTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJlgduR52dRbzn7J089X7fwKmXJNlkl+7TCxUIUifb0cS2ZezhqDykOEL7v3fsY3Af3ibCedF++hA94Ia+BegsExLX1vw=
X-Gm-Message-State: AOJu0Yy55wqzLvy5xMqDAWIbHsT5hufD8jHqUz5v+VgzpmVeoPjcizCP
 tBCVRcr0TjJ3A42669XGwz03TKMbELy5zfj2T/fQaPHpOD55xUWP/Wl7AXmfSKg=
X-Google-Smtp-Source: AGHT+IHvX1WpgSxDgq/cddsCs4LJSYlmyqfGBea7UAJbor14vsnnODKZG+fJGOn5yStGKvTWiwc0Fg==
X-Received: by 2002:a05:6870:470e:b0:250:756b:b1ed with SMTP id
 586e51a60fabf-25d06c0b974mr3005128fac.19.1719207497807; 
 Sun, 23 Jun 2024 22:38:17 -0700 (PDT)
Received: from ?IPv6:2804:7f0:b401:1758:f7d8:1e03:a6d:61a0?
 ([2804:7f0:b401:1758:f7d8:1e03:a6d:61a0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70651191da0sm5350312b3a.50.2024.06.23.22.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:38:17 -0700 (PDT)
Subject: Re: [PATCH v3 6/9] target/arm: Factor out code for setting MTE TCF0
 field
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, peter.maydell@linaro.org, alex.bennee@linaro.org
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
 <20240617062849.3531745-7-gustavo.romero@linaro.org>
 <9127eb3a-0a95-4c72-96b9-9a6af6725c2d@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <74c77eaf-a900-5881-b3c5-d87975e4f2de@linaro.org>
Date: Mon, 24 Jun 2024 02:38:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <9127eb3a-0a95-4c72-96b9-9a6af6725c2d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.379,
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

Hi Richard,

On 6/21/24 1:35 AM, Richard Henderson wrote:
> On 6/16/24 23:28, Gustavo Romero wrote:
>> Factor out the code used for setting the MTE TCF0 field from the prctl
>> code into a convenient function. Other subsystems, like gdbstub, need to
>> set this field as well, so keep it as a separate function to avoid
>> duplication and ensure consistency in how this field is set across the
>> board.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   linux-user/aarch64/target_prctl.h | 22 ++---------------
>>   target/arm/tcg/mte_user_helper.h  | 40 +++++++++++++++++++++++++++++++
> 
> I'm not keen on this placement, because this is specifically linux syscall semantics.
> 
> I'm not sure what the right thing to do here, because it's not like there are any other OS that support MTE at the moment, and gdb is inheriting linux's ptrace interface.
> 
> I think it would be less bad if we put the header in linux-user/aarch64/ and have target/arm/gdbstub.c include that if CONFIG_USER_ONLY & CONFIG_LINUX.

I think that makes more sense indeed. Done in v4. Thanks.


Cheers,
Gustavo

