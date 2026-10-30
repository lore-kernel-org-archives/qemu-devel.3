Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8D606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zDWm/Tij
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoRh-00054k-AJ; Fri, 30 Oct 2026 11:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMoRf-000544-8n
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:23:07 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMoRc-00010I-QY
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:23:06 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-843cf077f10so991404a34.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793373783; x=1793978583; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9PxDoR8npLOf/F509BMFOE0OyxUYK3yLTdqQ6SraxhI=;
 b=zDWm/Tij8+SFdqd1srZjKVXQtGJXD6hcTAAGFGUFlySVeFVd1U6w9LMCwcrllUzq/6
 g8ZK0fznWKsgY+aNlXRa96+S7xYShwdIFamQQ1bjEA3n25ryLpj0Psf7dyQFjnso1//I
 shSMYbKua4iGloJQNfHbzn1EsiBtiUWKQHhigK9tE8pK+NCrSBYOnKxh7+lURpC7p0a0
 pwVoH++dDCaJ/pUkWSURdz3eYNwQjid2nIXdY2OMT2lU5woM8Vv2EdDwIZdAvtQZ08+g
 0g96PxPn0E3UH6zlD1+JSSouMCJSd0VQ0eKesRm+YsKi1O52z5mhv6IzJAEJkq6EgLh+
 K5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793373783; x=1793978583;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9PxDoR8npLOf/F509BMFOE0OyxUYK3yLTdqQ6SraxhI=;
 b=D/59h9gA9CfqZsqzcW9VpnPSAKYYhuLFa1QZ9kPUTA+RV9sJwA+qIS15UoNZSozzFm
 A4QY716wTq5s+PO4DrKUw0JrCYQxh1idK2wK+bbc5R+Ll010DF4saNQKWpg5ecsplXmH
 SyD+PHnnQXSJe8/5m8gcef6nhNec/dINhwIIuoiEIu7zTCewDgXqYze/pOqGUWQuU3H5
 waI6lVUtoDau9H00vgRweZEn/uvjA6Bo2J4L75QuJj3pgejyc3ORQAQA0WK8tI9KfhMF
 zKdRieVkiqW/o8Q66Mzdv7Zs4nvAF4woxz7Dsw0nmdd3t6rbwXHZu8XJNBmYsRZEEa1I
 YGpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqX18dhCrmaFf7QX9VlH/wIqjtmxnRVlcI/sThHhNQjbNh85oh6dp/88UTLPV0dJAfajUw9SQ9rUof@nongnu.org
X-Gm-Message-State: AFq9FYK3WxO7MCSvh7cjYGXIK4xCCWDkMzpWDeuWrb7uPAL3YpbWT/2t
 4eMkwBeBxzWXkGuu8bkUAwWW+7m+tE3nberov7rWyRMG1IYrPFfjS/sK+ZE8KXCyHHM=
X-Gm-Gg: AYBFou3V4j50/Q92JCIZeP2fFV1EM+wAejF3gYaWT+GYMx8mnkBK1ruRzpZuDU11Dzg
 eDLlMDvGUw0RJKmzt0hCylzrTmKZ1OhqOPaQpA1HzhodGo01I8ScH7OxVdtwO3Qbp5rXLGu/996
 pJNCjm9A5jxfZeLaPx3LE1ewRfQcjJXU6e6VtTdYhjTA/dQ7Wuz799NJzsswfClYVkiwuSCD9mu
 87SCiVdr7SDBXYK/pZwkn5SN9FVDWMPCQcP0r16GlDaxl8jk6YpDwalAQWgfOABBd5pTYCZxOnl
 BY2jO+3DlnM54KN2ZZw7H4h71aNXnvGrErAyiAPPb7hZquGyd3rdZs8b8hCsnBnLmmGPTS7rtjJ
 sJ+1mWizNnxNkuaSopo2HIopWLLw6xfabWGZjxoDGWuMnqtonxjODv+gSnc/yAPoz49dl1B9YyD
 oOonfMMZ1/w1T0e4u6IV4OtLA+r+OR4D6Z9VHXmqeUJ3CldSQSEzyg2IVOG2gARDmClPfM81R0E
 ZRuykMI9PCcG1s9yOr282ITXDy1HN0xpc4FKgdksNiI2/jCelkVwkePmbvQ09fLv6iUseiv9VmU
 Xy4vlVkoX8jFZ0a2Z4bHNdXxub4yCVD6r96VwD2n0XLE
X-Received: by 2002:a05:6830:25c2:b0:81e:bb4b:2324 with SMTP id
 46e09a7af769-85d365f642amr1794834a34.26.1793373783242; 
 Fri, 30 Oct 2026 08:23:03 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d351e77c8sm2166384a34.2.2026.10.30.08.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 08:23:02 -0700 (PDT)
Message-ID: <97b9f9d6-39af-4e75-955e-8d5d0bd8df2a@linaro.org>
Date: Fri, 30 Oct 2026 10:23:00 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/31] tests/tcg/mips: Group DSP acc tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
 <20261030150202.61556-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261030150202.61556-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 10:01, Philippe Mathieu-Daudé wrote:
> +int main(void)
> +{
> +    RUN_TEST(test_dsp_r1_extp);

Forgot TAP_START() ?

r~

