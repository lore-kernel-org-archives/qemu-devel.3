Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D65D1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwpo-00071O-Dw; Thu, 08 Jan 2026 15:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwpm-00070o-QD
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:42:18 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwpl-0008Tx-36
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:42:18 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-81345800791so1976441b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904935; x=1768509735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qWu5cPYFuAGi7autqkICiGQ+ftX3esSAox5aQM9wuNU=;
 b=mVpbZAGIUUpFpFutU1vOGxmSaOhrVyRUVoT0zQ0WD8OTlqucXSpzJUQx0zYKH5UaEA
 TwbU6dIhxkMg9cBuzULB0y04HQifTTSsxhmlrr5A+3UIU9yR6NmW79abn05HLPRHOibc
 /YuZndTR4svvfCeoGMeCXXV8Tdmtakwi8IywHEuv88r+uMQW/mA01pAAw3TouQFhC0Sd
 80HqWdP6zpq+eoS+VbXyNmkAR3B2VNFfHLZEb5g5gKheTooUM7li/xvnwhdjW4t6dBFE
 71reSjJRdFA/gBoMZsorbGK/2kBzCY8Ipf72vzLgtQKWkXARJZFvXEoL+fVm0RkOU8DL
 5DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904935; x=1768509735;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qWu5cPYFuAGi7autqkICiGQ+ftX3esSAox5aQM9wuNU=;
 b=siEY2Zn/17BV3xN5lOS6EKs0rrY5Be3KnWfy3eKnN4vpIQ5K2mzKWntGfUe3fEffDH
 fpoXQgYci+wRy9+360zlcTSP1oxGlhxlMmh5dQT26qY93maAYzlFGoSUd2phzQpOPVmp
 NI4X9dtxPiuAygDxcPGFcZwCTneBP6FQNbnOVjWqt+7A5CgcaeUSY9rXhwhvFyYSshOB
 B3E8+HTXCDvs6nK7rARb18quZT0nehdjNmZJnxJpMKaWObf8L8DU0VHQDfL84edUp0wV
 plqH0MFLEzvbVHXJd/6Rg9ftpnAVapdyiFNg81vTdCplfFe4OEwMX/cWfcorjKUla3uB
 KjxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRw4ia36JoLLYgpyOgROe6iyJGg7U5sLgTm7GcdbqaTzApliV718E/fT3TUpXExD6xBY+KdtHRdZWu@nongnu.org
X-Gm-Message-State: AOJu0Ywn6qzwF/nVHjOQ2/rnbNk6GGfYuHJ7d58Qv6cYLPtHHHsJvJK2
 C+Hr1f3w2sD76SBKwmuSvNVaGdm3YVlsx+DI1EAcaBDNU+tISYd1vyUJx9Pg6bgBN00=
X-Gm-Gg: AY/fxX7JzE2SdQKssEeBGibVIJELRG3Exp+rG967omLxWQY1OEa5+JLnlexG5jVMa+A
 YqKKdRfXKncl7+s8phPPGXCpn0a/ncWniFCWBqvoVO424DLUHVmfJKBpAzgBLoBOVSwC9P1U1ZM
 NLP+UgRYdnLkcQ9+Q6h+a/vmi7ER1P21jvWHKdqA5XaruhpcllZC4pZnFj45BpE13HjMYWD20lz
 ZIwDliPQg9nWQ2wZSCOMFj2t8brJH+kLHdCzS1/aKJvLYLaPB05WFTBqQyvhQtiAq1FC2e+x0Ww
 No65KfegvajRzQFmAHI3YLWtg8T1y2hpx6kL72PXlYxr/jdv8D+gDYD0blI/Zpxta30UZ3h1MyY
 FogxHmuAo/psXSH5ezEuu7eh41G+GbEXeJp67DFKA6ioa0sYCG0FCSFxG0aVc9N5ECp3fIIxaPz
 Bq7/159LXWUw1IDHu99vSA+1HeDYOG2YcHeFfXqgwAt0uCqyojEUx2iIt1yLRIBGeU+1A=
X-Google-Smtp-Source: AGHT+IFo7EIESN+ZqxYq7JEPOZfsMUJU0NnPKqGacGYKuDir20uhDkECvlYn0g7krmmryKKgYIVRWw==
X-Received: by 2002:a05:6a00:ab03:b0:781:1f28:eadd with SMTP id
 d2e1a72fcca58-81b7d7544d9mr6749730b3a.20.1767904935292; 
 Thu, 08 Jan 2026 12:42:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c59e0531sm8418033b3a.49.2026.01.08.12.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:42:14 -0800 (PST)
Message-ID: <807dd19a-1d60-4746-ada5-0a6630ede20d@linaro.org>
Date: Thu, 8 Jan 2026 12:42:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/50] tcg/tci: Remove glue TCG_TARGET_REG_BITS renames
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-24-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

