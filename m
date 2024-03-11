Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C98BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjKv-0005xw-Js; Mon, 11 Mar 2024 13:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjjKt-0005xM-RT
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:21:15 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjjKp-0002lh-7V
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:21:15 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dd916ad172so10931035ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710177669; x=1710782469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+P/cZ85NnZf8y/cLHLzJl9tBg80Li0ZaXjFi91LpXns=;
 b=eiMd1IgLX1a4IDr0r8/lZhDn2KqyRdfn3Bify8BBhiNksg6UeoVzDz8CQYeGnGiMYo
 3fWd/Jq2kztiqg7Axb0vzsbTYJUdIOmGO4ROUzn72JZOV0oNM04lgKMYkfrKs7GchuHJ
 EUeL8zaJPdZ/Q5QbOLcIFZIDyBT1wXNnrDXF79iU4kG8gsoNYMh8/hELHB2BtyBHTaw+
 U6FIHOWvz/I4hE0rPjlkfS/iokHP4edRFT5mIUyQT/pL7tM6tFQ9sz0v/31lbU863Uxt
 HvXBVBZi3XXtv7KiAgaYBL11em9T+BXMFniuCcELwm/0NXu/FEy13GqW+oUgCNO27oJp
 csnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710177669; x=1710782469;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+P/cZ85NnZf8y/cLHLzJl9tBg80Li0ZaXjFi91LpXns=;
 b=WhNjxX16TeIljffdQCj9btnyV82ZACmRr00OX/1vf137NQ93h26Yf2jJuHpoILwbUk
 0InHGLWMYypLrDzAXaiutADzp/ewWnskh1Q2sJfhx4133mLYTI/3H+Wyg6RsIMkwvtjW
 Xj3mR5CQhMeX6tVHt65uO4rqW0iyKf1dhWuPRRPdy59eIUaGrNIdTK40WwM4ztXpIb9o
 SfhH1pNsC5rmEeQrAb0fyZcclKdicKAJ7FYDKYUHONHT+noZhHVHKFCvTFMypbiSGF9j
 5hu/bdbd1bfbxGt8z4DpoVbTZVGx4+qc2RKDz9tvGBgk1mpYV2Xn4KzYFJbRiqQrkybm
 dc+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU03M7XaKulqd5KL5QSQCYDhg5dVdYZf4oF3Xouofz7SiutZjzCiF8L+g5w8Leg+x//i7ECc7bD3YDSVjmv5QPaPZZCXrA=
X-Gm-Message-State: AOJu0Yxaa1mBVGDMfuytAjzXP/Coh5UtgNQCAi9/EdtUCPCVodyNlYWA
 vqWgTlBa38f4a457BKJzHR10e76U37t24nTQJoIIUf47kXnSTPMHrtmZIie7QdU=
X-Google-Smtp-Source: AGHT+IEBuWdQbPJMRCF1Y8oM9ki65Mn/yGTq2CI786XK9McrkmFJGiWokXMSJpOZS/bv0ODY2mbpUg==
X-Received: by 2002:a17:902:b711:b0:1db:be98:e9a with SMTP id
 d17-20020a170902b71100b001dbbe980e9amr6817122pls.26.1710177668767; 
 Mon, 11 Mar 2024 10:21:08 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 lo7-20020a170903434700b001dc01efaec2sm5009131plb.168.2024.03.11.10.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 10:21:08 -0700 (PDT)
Message-ID: <9c4e69ce-ec08-40cf-877d-bf4f346f4da7@linaro.org>
Date: Mon, 11 Mar 2024 07:21:06 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] gdbstub: Add Xfer:siginfo:read stub
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240309030901.1726211-1-gustavo.romero@linaro.org>
 <20240309030901.1726211-5-gustavo.romero@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240309030901.1726211-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/8/24 17:09, Gustavo Romero wrote:
> Add stub to handle Xfer:siginfo:read packet query that requests the
> machine's siginfo data.
> 
> This is used when GDB user executes 'print $_siginfo' and when the
> machine stops due to a signal, for instance, on SIGSEGV. The information
> in siginfo allows GDB to determiner further details on the signal, like
> the fault address/insn when the SIGSEGV is caught.
> 
> Signed-off-by: Gustavo Romero<gustavo.romero@linaro.org>
> ---
>   gdbstub/gdbstub.c   |  8 ++++++++
>   gdbstub/internals.h |  1 +
>   gdbstub/user.c      | 23 +++++++++++++++++++++++
>   3 files changed, 32 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

