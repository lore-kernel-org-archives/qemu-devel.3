Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF0606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZcOPcbz9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXgQ-00081L-7P; Wed, 21 Oct 2026 10:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXgF-0007xX-9j
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:52:41 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXgD-0004vb-ML
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:52:38 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so780870f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792594356; x=1793199156; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VtmJ3+HF2o/DDyhJVCSoCBMJoq2eT+VcJa3fqTnZSdY=;
 b=ZcOPcbz9YLpSp+h7DTcubQFYv4i33f5F9m1gKb4MZyYPGIN9VI6SRgrjn8MnUmlg/o
 fKsP2x+SmmuEO/MJLyU2SMnI3K1GHwDHaYabA3X6BBQdpqK3HTCwHVmrLyySwaLCrsjZ
 GthPtqu3AkRE+otqDC49U3Sb92PSeisFyiPS0FuJ16Uem+WD7rGyeXX4sDO7kvP6D9Ty
 nPM1fjQTN2zC33B0a7FU1t7M5JvUfN4jXCVt+gFnqApaSpqeGQ3YIrYsJ913ncgMVXZj
 tHCemhW8U8OLX09kYn77iooWkZe8bKRBPdhVO8ATdApt6G4/Xlpt3lv7OsvtkHlM2EWj
 A0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792594356; x=1793199156;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VtmJ3+HF2o/DDyhJVCSoCBMJoq2eT+VcJa3fqTnZSdY=;
 b=qowdEujeEhUR6iYrCWjmY+wwL4WTdVJ//RtRY/aGXkq+HPrW4xKCjlaXmmh1aa93Zy
 jDZmh93GBadE/in9ykB+5fO0GEeDQDhMWXk+mC5t6fx6SkmdFNZlaiHRaGCQbSDH8JN0
 nXlPCeFRDaY8ZlNmoLTg++5UKOCkgCdLsldhbwuGvFqQUpe1RmD7ng0mRPqEb50R5bXV
 AxptXlB45FeQnqD5TYZPpa08Le6iLGKUEQ3vMAhgVa9KVCEIHgC5S4Fv7TkoC6I2N/NH
 H7w/GKESUO4CeTDX+iF/AJ1tkvBv3MHHWNaTkDl4Umtc4zhF/rytJSl1WkXxHZ8IwO2R
 4ZLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZ2hEV4tvNhFVtOyK3SdpApl97nCZTm5TlpGMqDhrP/d6EoOyohvIxaTv2urPmW04wfLiKA+syp6xy@nongnu.org
X-Gm-Message-State: AFq9FYKMLLqTlNZplQ2osgtxb2sV1/Wng8frMEkoDMBSXz+aaIuEFaVf
 zBUnXDgfbHfQnuVSERI9RUksxq7lW12uDkqyksgBowcV5LRfldfaF9ezqynGPsTn03M=
X-Gm-Gg: AYBFou3MyYCPa55Lsd4s+TChI/tLxzQSHGg/bfiAkfcjlyDWpHhad9yzKbrctdHi01r
 diwY02twKqtN/J09BdwwKhL+ZMY/cP8KgGhVaaHTUlNKX4+HDjNMQrQeBY0SZHKSZLBpdZ8TDAC
 W6f4VOs65ibo0AN3pcO5QgEOv74h9ChCyX3vWNVZ/GQOjw3OLRtRAs+DxQVfQ3V/DLKSJlqHJ1i
 AhKvd4LBiIVsONAoFHRAgfiMmFrnwGsY3ph+OyOuVg3LhnTnnaV1X7Ys53eFFsvJqKcNHJVWrtb
 ooOQjN+AlTWv2FdDlLMsXkTNWsBZBKy/eUesYGK11dZKfGI1iLppt0kCdtXWXi2NG33LdGE+5QY
 6uJTz/WpDxuN/jD8tO1kfhB8daMH6mAHfVEFlu4V9WmXwWnS9cc8Vz5dbUxr8T/E9V7FG51yKcy
 vLnUuPcHcRAY+AVEUCXmRAenVp6QPwCh+t2khafF2QMGJ631qt99wzfl3II3LY/JBSpFSr/ADmn
 gTMoaa+eHqBygz3MZqgiqBE34U5SRk8IJyEcrTB2PlBSRZ3c/2EqBuwV6oDBH72INgeckVL3XO4
 QHA6nivpXKle0T8dQj67ZoUnsFA=
X-Received: by 2002:a05:6000:4313:b0:48d:f498:91e9 with SMTP id
 ffacd0b85a97d-48e2647cf3dmr5213393f8f.9.1792594356082; 
 Wed, 21 Oct 2026 07:52:36 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254efb2csm6246855f8f.2.2026.10.21.07.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 07:52:35 -0700 (PDT)
Message-ID: <ea1d0163-5dfd-4f9c-93f7-ecee49c4fc7c@linaro.org>
Date: Wed, 21 Oct 2026 16:52:33 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] hw/intc/arm_gicv5: Regularize spacing in
 config_readl() switch
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260914160020.327787-1-peter.maydell@linaro.org>
 <20260914160020.327787-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260914160020.327787-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/14/26 18:00, Peter Maydell wrote:
> In this file we don't put blank lines between cases in switches,
> except that for the switch in config_readl() we've written it half
> with blank lines and half without.  Delete the blank lines to make it
> consistent with itself and the rest of the file.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   hw/intc/arm_gicv5.c | 15 ---------------
>   1 file changed, 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

