Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAF606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jQ6mKlBT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKdRg-0000IC-LH; Sat, 24 Oct 2026 11:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKdRY-00009f-GO
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:14:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKdRW-0003ZX-TN
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 11:14:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so11984385e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792854837; x=1793459637; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hWc3Auk1Hc03brZAhIBqdfIACQ+iYZP93Qb+LR0SjO8=;
 b=jQ6mKlBT+W+x4mQqgaskxvpBx77bY6VY35V1tY0CrX9q4Z7KtgRcU7K8/NpTUXOy9X
 0hpOd/bjDJ3Cv7ZFewqurx4urdpV1QulNgWKJo6+9eSpdgXRdH+R/r352qhWitZySfn4
 fkKIaAyfXU7SBSC+nzSRQTDqvSybW6y8Z2oyuPjSSBMCZ+SW/rkav13beeYnjeW6kMsp
 ikjo9jrONSyesN15gjz8qVcXr2e6u2994jvZ/8P72AWu0eV7hxeD2/8wNpSl1TQwS421
 ghqb+tRhjyhcHuzwYhEISJkgjwnHTEU1qXVSwNDFaakTEtwM87iaZaxCzUGaIHywLA7U
 bvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792854837; x=1793459637;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hWc3Auk1Hc03brZAhIBqdfIACQ+iYZP93Qb+LR0SjO8=;
 b=WzP6dQgW35ONUGUXSC8HAVfUMfCBlmxgmwdklXCKJPrepR115ZMgCSFGsIPH35iOc+
 l1d4/xm1Q/tO+caZLgEZyomzNByHoQd0abeLU93n8gn67h28Cwgn9+BXxs8l1rNMoEGJ
 Rw4Pd4/BADL2ctVyQS/AYYQTdo9uGv+DwzPgplZ9pcSnT+wiavzyB7nNNwEa8exSMu5m
 U4zdydSkh0mfPzN3XueD+eYrqJTGKv+3L3jh0esctWtKe9ZP2nurEH9/QHnlvXapqUup
 FZIlerPodx/JQeXk4FJMvesWYiA0GY7TB0k8T/hsiGDfdcauzt3XLwDnksIFWaXZa5tZ
 moog==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGNsK4sNKambgSqV3h7Zz1g17D09rjyfzILS3zrBKXB/UVTCu7ommjSlpfVmz2FRZJz+OEKKBtQ266@nongnu.org
X-Gm-Message-State: AFq9FYJZbIRV2CMv7e9w7o5i9Hnj+YEOQtp+KCyEHln7dPd1e2tguptD
 Aty4UAN+44rVislViyohy32xlJdYlF0t0VA+ip5yRmGOuIkYEQrIyWSQcCYP2HLf7IarXfpGWqN
 WTfuhhrI=
X-Gm-Gg: AYBFou1CiJkF6p+9L6Tv2fArJ83qiiMbuDaTVTtilRrNHqRrRecwVAk8eZLMsDcf2Zn
 QPF7IMQ4+QyPGjBtSkDblTheHaPfIZEYPtn56mj3ANAGDSCT7rYlWD0gwq8Og9yU7Fz031iDwCh
 BWM1rc+MI0o25D9i4ac3oUZR70Yd8OXWMU7WCaceOwNPe4l6NGbVnPmW+rmqQbyaNBrpQg4i9XT
 0O7EmR60ABLB2Tuoaz/YiNRzREoOUqgBwwwsMIDLnZbwe9lgc06MzdCf0cOUQcRJGzAWJ99u5cm
 lKd1uxprqskBo8tAP4MNCq/lqOrELyYMCGbqmvQ338Wrdmi+DSxy7nrI/Atlgm7OFGXJGy9m0SJ
 TyVO6oDauMMypQknRW9LWxPpFZe8d2wbYYM7wbpxS4cGzN0m9BLbryhhZt7azl14bj42G7nGg8P
 0g0hcA/JO8dk3c8fDegq2ycqIubA1smU+U3MDHZIAaE+aBIFIgtIqoig9dsGTS+UcadcPWOvqX/
 XLjV9PUM++D2HWJzXDiorZWoJMaAi1Hbf9x5GqeWTLCj7Jo2ocdujdlOCsN5T/7Tnwr
X-Received: by 2002:a05:600c:a306:b0:4a4:fc8c:cfd9 with SMTP id
 5b1f17b1804b1-4a4fc8cd1edmr442875e9.25.1792854836762; 
 Sat, 24 Oct 2026 08:13:56 -0700 (PDT)
Received: from [172.20.4.74] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm166256695e9.1.2026.10.24.08.13.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 08:13:56 -0700 (PDT)
Message-ID: <0aa125b7-cefd-4061-9612-88de7e971e5b@linaro.org>
Date: Sat, 24 Oct 2026 17:13:54 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] baum braille device updates
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20261024132128.618909-1-samuel.thibault@ens-lyon.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261024132128.618909-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 15:21, Samuel Thibault wrote:
> The following changes since commit 4c0fe2b6a9adb155c18691a19311ac2bae6cae8e:
> 
>    baum: send device identity and cell count on protocol off/on (2026-10-24 15:15:24 +0200)
> 
> are available in the Git repository at:
> 
>    https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
> 
> for you to fetch changes up to 4c0fe2b6a9adb155c18691a19311ac2bae6cae8e:
> 
>    baum: send device identity and cell count on protocol off/on (2026-10-24 15:15:24 +0200)

Applied, thanks.

r~

