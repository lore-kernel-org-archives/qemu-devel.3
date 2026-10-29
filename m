Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D95D606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cgMlw9cb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMSoy-0001OK-Ar; Thu, 29 Oct 2026 12:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMSop-0001Da-FF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:17:37 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMSon-000156-LD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 12:17:35 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-8451a619da7so1613531a34.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 09:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793290652; x=1793895452; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P5X4qZfnVS/TY2lC2As6mqHNcdxtEQ3uCFZzF8qH/Rw=;
 b=cgMlw9cbRgHBTxBTuOCxJcC873n4pF7vlnEhuCi+1IgZ7RuXkUCE9TOqQ6ur4ICHK1
 znagQUrgp/gOBdngzB2hoGwtutdgND5v+8c/Zoyxf6pYJ+spePEV8WC9L4Cj/ydudNEf
 sgR9r0ypAvdpD9migruMw+J3t+tDKVmEk8zNotcpMftx3Lw6QmQWMD4NUMOyMxPURf+x
 BYNCxbK9vdmuz4QYHj4tbz/r1LdZSzcdyV+IEHvu9BUIS4fyzGSXOXd/PoZjQfpzLgQ3
 YDX660y9rc57tr9szZlUYPlf9Yuw3GE5g460i0zHmXvKjUVe9TCKiDqdDGPxjKA2xkBG
 RbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793290652; x=1793895452;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P5X4qZfnVS/TY2lC2As6mqHNcdxtEQ3uCFZzF8qH/Rw=;
 b=r12ZF2ImNA+KX5VcmJSsfuU7q8CB8Ew2NcHfJTzaplPChH8foSjQFuaYsEUrLgGcJ7
 DgXE7PI4uAJdn7Rl6XUq9Uvy/HcLd69BqWpqx2pSgxDX/boIQQRSAgsTq231VENwcO9q
 4Aq7uJE9zdCq73GkqKKZpmKVn5yuT9bQrReeBMAjkXcflp9DwprLtYOXMt9/t95NJF6H
 qQfdwV3xysLV0cYieAI1cXvL+liOfSRAMkmoHURmRPtrCCAnIdqVcq4KeQDt5SnROwWD
 fbCVc3XFZYa5H++2wqTwwQfZ5d8Z3ArYxNjxIeT/smMTvn2ALtRp5g7sUfy1/mc2yVgt
 oH8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMkPtAbEmqB3mc7BeFQIJChVxdkY0yxhLuJJFEkQWWrBwuPMiN6/ZR/9bYJmBRWrz8I1a9+AKO7oMq@nongnu.org
X-Gm-Message-State: AFq9FYI292l52H0k6zxN3S1hXwtMaNWofjijM2W78BDWc7jim/tXfmlL
 5Co9iP77MqMqLxuPj5/+Ed2a7kgB0XWoIUHNupJ0xPCa29laSssyx1E5OKOf1um1Y40=
X-Gm-Gg: AYBFou0EPTU4WDLkN7+ZBBPsVwxq2dVliJtL0KywAW9+khTagNpjBfip4vGP+WmZvqX
 3jNLTElvXrhc7RWrwjH010MFArFuZ57jd8Nr04BkelCeKG6T4p/ySc/X0LiIIy3UtMoP0dZ6CO8
 iraELHeOKy+GBXDGu8fQfYseqrwEhRIDvoEPcJdL4w6hVNWRpYUFoBqpQuVLrFZn2sLIzM3GNME
 1iyw8mKU07AyBxSofrVoZEyYPP0riaKO0Uyvuadvgo9UPThI3NXqF/K/UE9YuUdI+thvgFCkDX7
 NxFRat7OgU9EkFgxBHTtWCWIFkc73YIqEJshHMdMDDSevbTbfvF+YZZhUz/KUewptusH9YO7Dsx
 n+o5yCfaFK8OOrTfMTXZEANRu7VKfESsZhKseyNC0X6oilpx6b25mphGWePh6nysOYat4FS+sgk
 MgP4X5CKrbAb5Q3TLZa4HNcA5dKw5RwrMwBjOAc+tnwYPDWEg4yLg9YeAFC1OcN82iW02+Jyr8u
 WVWjX9B+Xjk1swaysCbCUdgAwX9q9x/+39HDvrxZFEM3NNOwDOgz+tBJ3UvrKQWxHXweOk0Vace
 cKev/rwGblHYF15LmrPglTHdH6n+UezSjS5CB8XEEyrD
X-Received: by 2002:a05:6830:4ac5:b0:824:e29:e00e with SMTP id
 46e09a7af769-85ab929b937mr5764081a34.20.1793290651815; 
 Thu, 29 Oct 2026 09:17:31 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d33e3696dsm303074a34.1.2026.10.29.09.17.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 09:17:31 -0700 (PDT)
Message-ID: <5418c6dc-9de0-400a-bb0e-528d00ccb21f@linaro.org>
Date: Thu, 29 Oct 2026 11:17:29 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target/arm: don't pass env to the sev helper
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261029161310.2065290-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 11:13, Alex Bennée wrote:
> It was pointed out during reviewing a recent fix that cs is only
> needed as a loop variable for CPU_FOREACH so passing env is just
> wasteful.
> 
> Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M")
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/arm/tcg/helper-defs.h   | 2 +-
>   target/arm/tcg/op_helper.c     | 2 +-
>   target/arm/tcg/translate-a64.c | 2 +-
>   target/arm/tcg/translate.c     | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

