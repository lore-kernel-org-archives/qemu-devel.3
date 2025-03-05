Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB49C021B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpcVj-0006KR-Aq; Tue, 04 Mar 2025 19:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpcVh-0006KC-NH
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:21:17 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpcVf-00075a-PI
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:21:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43bd03ed604so5944725e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741134074; x=1741738874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WoW+q7BTZbUkiJUh6sKjJaDMlhd/czq8uNbwaKkLoLU=;
 b=ptNg+VNelQtpc3ho5lxx8GVcr5kFGLg0hl4IfbTCbq4UXZ7SOM7ADRuuaH9/pnmISD
 cR6cNucT4Nj/HDP6J30acITJiiGB8+7omq9+1Yf62OkBBDFOFaSelQJyw3DK6BnLLF3b
 1oXF+atnFDKsWCSAVZA6rZf5HBxO+ZbCJjooZE357B4hjMrasuk0+3sGULdLn/kAO3xk
 QaYwMV+YRfQwDkRYyWMGQL0ziy5wRpFHJKclOCoKYB5pjhISxk4IKw8xTSvLHRS5flnC
 C8m/BsPVhbxr9ROSL59dyyAZOpxN6bqOCMEZ24Si7XYSk7fHOHx/oF6VGbWYlC+bqGrY
 996w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741134074; x=1741738874;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WoW+q7BTZbUkiJUh6sKjJaDMlhd/czq8uNbwaKkLoLU=;
 b=ItnCcNhDjTIRhm1+zM3zoEztJZkXoau6RiR81pskae7ilUSCFGJ81S0xFASkeFjNTT
 gXgMlKmwpMKWjiOskvTrQkarmUHNxe95NksMGlGwBaK6JYg6kM5fnl7xN+LY8904J273
 COvZf4QYeMlqwfxCRuXbhmiOqV+EZZy0raxFxayZ+G/4E9tnzLsFMN6apgckVCPNVO1L
 E7W38ZGoCj+/Qx7Pa3aFPFETzrAHa+631rbFuaNFtCbcQACOBaiEjAmwNIWqJzlKU/s8
 ViKQuOqVg/ZccVvV2s0GgIgWhNo6M98R+rPWEXRyUk/QOBlyXmU7Jzd5p44/0gzueTAp
 f4YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyhptHwxfTg/xVY7QEzxS0sQBp9mxXq9rzHbOf5doOXTRrIGRNiwEJoCyMcRixlRnWov4wqndPHAr/@nongnu.org
X-Gm-Message-State: AOJu0YyqFClUe/q1Fz9uOAtYbaPfYWZiKeclrpDbPDe8C8Nfnw+t+oja
 C+in25EFtpmysKWKXksI4wEdeqfbR7g0/RmKMIcg45iSHcoAy/fTDNN7XsNRbTig1rYa2TdjAmM
 zRPA=
X-Gm-Gg: ASbGncvgNeLVqO+nXWLmCKkzt4JX7HqqesyeRrFGZoZvvLgMlhhfBk1myJsUVyHa9w8
 5bUfMF7zhvS3so79+v+b0SuCkPRCGnCywbRJL8p11gi69FfgmoEdHWMUZpp+UnfF55M8y93yu/R
 Z7NJJ2vOP3ffkDDOWKS643zMG987CINsWeP1lLKbJkm1vUbiwCuh4O0m6P8ioQcmcbjG1+rVfFc
 GJEZBSDmRGVSKElUKJlcwrYlX350nh4QckuyEg4TI0SEFLpA6kONgb2hB+FvyKJHqCmaKKfI1NY
 cPi/gXTCncAmA9uQ0QSlgOcdrywYf3jrRiwyV5TcO368toV3c/vHITCrrMm7xjZRY3gRXl2guGw
 FN/tqDdAIckj+
X-Google-Smtp-Source: AGHT+IF4E4SLwIkqP119JOnJ5UiT1M1sVCf6DQ/3RuNHPjWJHRb5qJE9DNxfBBct103cPiB4wsEkFg==
X-Received: by 2002:a05:600c:1550:b0:439:63de:3611 with SMTP id
 5b1f17b1804b1-43bd29d7bc3mr4942855e9.24.1741134073745; 
 Tue, 04 Mar 2025 16:21:13 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd41c7cc7sm1250335e9.0.2025.03.04.16.21.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 16:21:13 -0800 (PST)
Message-ID: <d2225713-89ef-457d-88fa-4d356dbe7b0f@linaro.org>
Date: Wed, 5 Mar 2025 01:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] target/microblaze: Always use TARGET_LONG_BITS == 32
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Luc Michel <luc.michel@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <ad364fce-f73d-4dde-b890-0ea86d9c4674@linaro.org>
Content-Language: en-US
In-Reply-To: <ad364fce-f73d-4dde-b890-0ea86d9c4674@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 13/2/25 13:37, Philippe Mathieu-Daudé wrote:
> +AMD folks
> 
> On 12/2/25 23:01, Richard Henderson wrote:
>> Use out-of-line helpers to implement extended address memory ops.
>> With this, we can reduce TARGET_LONG_BITS to the more natural 32
>> for this 32-bit cpu.
> 
> I thought about something similar 2 months ago, but then realized
> MicroBlaze cores can be synthetized in 64-bit, and IIRC there is
> not much missing (I'd say effort would be to add 20% more of what
> we currently have). Just wanted to mention before taking the
> decision to restrict to 32-bit. OTOH if there are no plan for
> adding 64-bit support at AMD, then I'm more than happy to simplify
> by considering only 32-bit.

3 weeks passed so I guess we are good to go with this simplification
series!

