Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFC1606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l2lVOFCY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLyfm-0003YJ-59; Wed, 28 Oct 2026 04:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLyfj-0003Xh-Rp
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:06:11 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xLyfh-00067D-SQ
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 04:06:11 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-53ec9237600so451038b6e.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 01:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793174768; x=1793779568; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=25OMelnSZZE3zU+zi8D6U7XMiLUoMuOWR45q0inWlRo=;
 b=l2lVOFCYztievUX/FOrfwzqU4b9+n3M01jl0gEWXHzzBy2VuVGvlJ0He/148HDkIWX
 /EJHKEwPJ18JyDsXbX1I8yitScOJb0ms1TRqtpJXfbIN2EvG5GxhsV8GP9NQ2M0o1Qz5
 8pLzjTDPCaabYa/M9DryGDKt2a4WfZnhL9hqn0QWQBdNtRQyvt8xXhfKVuILP9TVeLqY
 ZKaLbVptFXUIAYB09IIDwBiz+i/uujyYShCfbtnEKflXyhGy+qqd75EG2x92grhRkxvQ
 emMOMoRgGZLSkZlFC+smWP5pgk23k9AhllIQVpDjbR2SaTOtuGNGKvNTMOSqDWXFE8u3
 XQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793174768; x=1793779568;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=25OMelnSZZE3zU+zi8D6U7XMiLUoMuOWR45q0inWlRo=;
 b=qRFl/2P+sk0INTR+ed6b9OVEQkQUEDXkiYmZuUvc2xkChQeoHC4EM0Gey6ouN0J5L0
 nJU3zwc1rX+gLQDcGad1SjIy7me950NMlfAGZD+dgc6nTUJ6oIvFNnNMTtq7DSK4MZ+s
 gvEdn6HiHVYhavWRueYe0gSRt9qrZ+qJsGuMZM0Vf3oRnxZkxhPwv60v99Lu1mtSdtGD
 Kh1ekYe+TmyPGd9zHiat/LZ97A2iK325rSOAI2RsFBu3I2i4/y9aVtP6DwwGosMK8JRg
 40Rou5VOm9wkfgkLCX9aqTzm57hhnABCICI1s12vDL/wXS1hl1bXf+u6naE7sbkhR64M
 QohA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/8fU0uYbF3jFcUvpmTI+K6Fd83WruKINOXncr8zI1YEuCoI6lZN8VjpV2uPEVu2CXaIIdIz4zBct7@nongnu.org
X-Gm-Message-State: AFq9FYJJLsYwKra23UJ1hVIMjk6ikwakTXRrXV4dDKOjiGiZIIOUGHh+
 oVaMAYovqGBpD9q+IuA8PgY6X6pR7k3BBWgrJIbQueV47p8N9Duc9kwwmyqJ19DGxmo=
X-Gm-Gg: AYBFou0opwDf1aLRt8YfgVDCK84k15dwRhBmlCVGdnubiNG8fucrXJnc0xzPNL2VnpT
 8Rddxl15V7cutABsFBKsPRMxrjRIQvTk+nllYQjW/F/5EQu6fHNnXEEjxkv9vB/owb4WOPxPnLB
 HvEvR219DONxsY+vyKaBy0arpM1gjZtHtELeerOxWjwhpBOSZJiuBr/GUdBd1yDz3gsTy5mgEYx
 rs1fZbyeED7N2A7d2VCp/RAHEn2vCwiN/QrCMO4Lp3p2TZSyh5B6XRCHBkm2yhkBZbf68WOa48q
 nDrasOWJjkPBf0HwYJdwX04vW1yBkzeyF8z8TbGe+PN+zYlz6JgMom49D2vIftur8nWIs3W6i/+
 1+jkHDQpXifbkuEXxB4wXCdxHv3ydTHZn9iiS64lM8DIeXG8G9ifMdR48XLoj6WWlPTRO26bJop
 7Ylp+RuWhs1A131kSv5OGcXqycG1Qf+diWCOrnFwlbuttX/h/5GONUZEAH/ic3fXxo8QMvqJdJq
 oTciN4lG93zjaE7ZYoo4p46xMqQUif5D1MbbWyx11OPYjz+xnciqlvK1PVNUMTrcpHMUA9xE8Qw
 wUEeu4sPHyxcVn6Ycjvh9mzJZkaSDWtpOoxPotXQh8oU
X-Received: by 2002:a05:6808:c12d:b0:55b:ea1c:3ce8 with SMTP id
 5614622812f47-563a20592bbmr747010b6e.21.1793174768149; 
 Wed, 28 Oct 2026 01:06:08 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-563c654ad38sm739165b6e.15.2026.10.28.01.06.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 01:06:07 -0700 (PDT)
Message-ID: <b1cea694-dc0b-4fb4-a5ad-e7c6fd75d8d5@linaro.org>
Date: Wed, 28 Oct 2026 03:06:05 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Linux user next patches
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>
References: <20261027155528.5040-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261027155528.5040-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 10:55, Helge Deller wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 4f4225874d4d3747ec1142e935dbd314218992fa:
> 
>    Merge tag 'pull-request-2026-10-22' ofhttps://gitlab.com/thuth/qemu into staging (2026-10-22 12:47:21 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/linux-user-next-pull-request
> 
> for you to fetch changes up to 2b1b98f003325761b839b4bbd5af653416d05f72:
> 
>    linux-user: Use QemuSemaphore to wait for clone child thread (2026-10-24 17:44:48 +0200)
> 
> ----------------------------------------------------------------
> linux user patches
> 
> Two patches from Peter Maydell for linux-user:
> One fixes the signal context on loongarch64 and the other replaces an old
> pthread implementation by an QemuSemaphore implementation which better mimics
> the wanted semantics.

Applied, thanks.

r~

