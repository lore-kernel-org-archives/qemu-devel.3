Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B64C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 15:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVmk-0000hy-Bb; Thu, 01 May 2025 11:25:14 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAVmi-0000gc-7O
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:25:12 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAVmT-0005dl-Kj
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:24:58 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so1082866b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746113095; x=1746717895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0vHjLZIKMAcpSYJ5CKGfm251JpODp3KFOdq9sZMqTe4=;
 b=r0yZQzTkoQc3alOA/DMwMzz60YEY/iBZy1KvsGHFzQS0DA6BAiiuKfXV/vYJYhI/+r
 7/6s2B6nTiAE8Zc2RzR5uB7Kvt0eiONXMbo7g6eg1tvr8O+Bg2NDkgIafemKyjibz/CJ
 jhoJhpqAdChM4RYHsOm9TGqgDyhaGef2Pos1ExHzE95ZgkseKq9aPRwqDI33cgaMNFIJ
 doElTEW4hNqzTD7aLa+LQYLQd+UiiROI1GygMCy2M72CJCzIz5S7pBx3x1H753JBx1N+
 gD4qjWHO3VSYH7nMQnG9Yv/nytWKHZaHR24C9LgiOByOv+wEKDwCiA2j2x5MHWtOXOYI
 +dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746113095; x=1746717895;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0vHjLZIKMAcpSYJ5CKGfm251JpODp3KFOdq9sZMqTe4=;
 b=XApADWiht2rHGDQFI6glNiudsQz5jVZO9avJTUvyet+N/tcRvQR8wl8utaDOK8qEbd
 SOA0eEEypLGZ8m7Qxg1TwLdtPHiAriQ91mAsRKLz5xUzhGR8Hdpjd4g6us7X6n6IWdpk
 jslKNAK5iVioHCXT/232cU51+PMHoRxxCUTRXnVERZw+V8ho2Gfup22FxLQFw8Ux+xVX
 hdqxrtUINjoXpFD149FiQTF7XjSVC51Z25UbYnZ6TwqgSprNr6gYhUIHjUOBBZEBMyoP
 ErYvHXPpibG7+4WSmW53z3k6hCjW4ZDnNYmHl3ZURlbrn+Yq+XmZsdoSlwJHtu3vBBDx
 KFaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCmFmTMz2VWY5u099duOylzCC1p6DqMNaqTwNI+WOBSKTy88yHQixGr43PzYULJRKc72aB/k3OUdHR@nongnu.org
X-Gm-Message-State: AOJu0YzVxU8NPN3gInImFb15rzc1XN2QCZVZ6hWeRNLcRIU7x48NVXHa
 rqMTELL6f+FWPjAPE2wxmiaaxdra0gFqe4JhXUxW3nj8vFmb6WQ+Qck7JYfs4AE=
X-Gm-Gg: ASbGncs1oBLqJxaSi9bmprLXJobXEVDZjBPtggFDTM+VtfqpRkHWRO4qfNYCUuY8Tfr
 Iujmx5qoXYtfzjURtpGPzv+0y6bYpLnlCzIvo81mDeRmZWd8EPHnwuAEJw4baKEIRVs/We2rJCU
 K7a1y0sE6aAI9e8A7eGjUGoM5UnLCAa3LUEvimoWjS22q6fw02f8C+WtIoBBNJc+zFlr8UjTh4Y
 6cZHVPhWoK0qiGWsaOWWwolFvzjKb1mGR3EKqkJRzTTFnHrWgY/qVjwll2PJk77jd9AGYLLpw1i
 goBooFELiWUa2ZbPWU7N7LlmoZ24AAnseYqara520ijZs0jlWwM3GyYzBQRIbKxv
X-Google-Smtp-Source: AGHT+IExeTBVUyRMlLYCEVZym1i0z0bgdXtdjFqSFp4tC+pPFl63Tb4G9p16DCpNKUe4ciqiRFLCCw==
X-Received: by 2002:a05:6a00:2181:b0:736:5438:ccc with SMTP id
 d2e1a72fcca58-7403a77bbf0mr8990694b3a.9.1746113095022; 
 Thu, 01 May 2025 08:24:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fe765sm940821b3a.108.2025.05.01.08.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:24:54 -0700 (PDT)
Message-ID: <00710aa1-2a44-4778-83da-05cc125506e1@linaro.org>
Date: Thu, 1 May 2025 08:24:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/33] target/arm/helper: extract common helpers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-16-pierrick.bouvier@linaro.org>
 <8f480fa1-609f-4b90-b6e7-02a76d2767d2@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <8f480fa1-609f-4b90-b6e7-02a76d2767d2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 5/1/25 8:06 AM, Richard Henderson wrote:
> On 4/30/25 23:23, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/helper.h     | 1152 +-------------------------------------
>>    target/arm/tcg/helper.h | 1153 +++++++++++++++++++++++++++++++++++++++
>>    2 files changed, 1155 insertions(+), 1150 deletions(-)
>>    create mode 100644 target/arm/tcg/helper.h
> 
> Why?
>

It allows later commits to include only the "new" tcg/helper.h, and thus 
preventing to pull aarch64 helpers (+ target/arm/helper.h contains a 
ifdef TARGET_AARCH64).

As well, for work on target/arm/tcg/, we'll need to have aarch64 helpers 
splitted from common ones.

Makes more sense?

> r~


