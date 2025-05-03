Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F05C369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 22:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBL5E-0003aB-74; Sat, 03 May 2025 18:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBL58-0003ZZ-On
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:11:41 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBL54-0002vK-T9
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:11:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22c3407a87aso49493245ad.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746310292; x=1746915092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7LctirqTNATR4ocbX59fsgCBPnDuKRYJ8DURr+ffWs=;
 b=PI2hJOgv/DrpFXYiOtEeLnuJokFYYywkWB9fBTJw4y8XUpQAcI2ZKByfJQk09SRrE0
 rDsuHRSfJVmLjWuHiMc9GRl4F/sj1h/oM4N5aph6YOIyQxwBOyZtO9GXwpu117SKd+TW
 DjlxSB3BKIc942o/ZB0GRji0LdkMFvCSwlNMjBQcG9fZqqwYs4iagOlnuX02hD7NLATk
 w8FC/5Tp+dr1/j2bU97u9L/+rWlDhk/83WulO6BPoa/WrUOhp7jCeoPFnoh5ZjjtslpK
 pG8NphBigaXaGDmARL/ZnxOWpOBwK2jjKVuhuBT1PAydwia5nnDfrbSYLTFEuTYG3nq0
 mXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746310292; x=1746915092;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T7LctirqTNATR4ocbX59fsgCBPnDuKRYJ8DURr+ffWs=;
 b=m0Zg1u92MujS9jjG+YGIMZpY1woXeYvNNcdrmR54qgTzgKbwFX7fK399xC5n/FSDDK
 ONqC2wwVDx37LGA6yBpIu2qHsYMHH3BIN9F8dNcTP/zkyYiHdtU7YHAJ+lC+B/82yPUi
 5f3rF7Olhw943SmjJFCHFZtd8mYGfBA3E7wmu/H2gQUVBVJ2H1toecuxZw0mHouKU2ZT
 d8ExMrQiNV+qydzGnKyr55/1hvUrJILRWcpRB7gOCW9m74nPZGmfXUU7ZQR9jebjKGo1
 waxRdP439TBnC0hQfmMlJEr5IJotmznzf7aAuzTNTaJhYY/YFwdRRQhjj3WpLXwejoAT
 Er8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTWs6k+5BIbvr9AbzV5gT+C556sFbHw4Zbmn+mNhORAzNz8owQPk3ROVbH6DkHvwDlG+d6OtmiFi91@nongnu.org
X-Gm-Message-State: AOJu0YzNfHCZBAbIQYKDMVuIfefF4gBtv0K8Q2Y39RlM6EIkGRin0A+i
 ODK/dhmRe/cqHwjK35BhWoBXQYWqHmpMPwc5//h4/Ks2ylJbmO2PO2Ff6muoHKo=
X-Gm-Gg: ASbGncu610BYOabm1Z6HfynRFPpvnP8KNhaajRWe+G4WDZXW9tKfA5qbAaGxUHrZeeM
 GndtVwVSWdDJWHM17ngjpac0qDs+hIX8kSIy0d4NXDvhSeaAIf5E6/B8oiN7L9TlwtdBVWQ5/dD
 s9D2tPCZN1AVOKiYJ1uMHaBvatES7eP4UyjIjJ5oRGyMZLKxzJnq5TTTQGgPBbbWg3ZA/da9jS0
 aHpgr0nShE4fUrq2bAGeFNBPTKZra2QqZj+BqOEZd3fWbYy7lDnitoOAycbHJ9voB9DFNf3NovA
 TJAB3vs25EBAnoKFkiYeg8OPUJx5HskFl3UTAkjyYF7Hhg+psJzL8+KJzfWOjNzy
X-Google-Smtp-Source: AGHT+IGKZOl9sWhuTSlWLAe3uWJrr+qu/WKjiaqq1BSWM3eRAc1/owPtZQjoqVpboGxgTa1PqGq1pg==
X-Received: by 2002:a17:902:f64a:b0:223:faf3:b9c2 with SMTP id
 d9443c01a7336-22e1ea6a954mr30930175ad.27.1746310292542; 
 Sat, 03 May 2025 15:11:32 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a4748e813sm5644044a91.24.2025.05.03.15.11.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 15:11:32 -0700 (PDT)
Message-ID: <4abc3e82-acfe-4877-9f92-66e134d19d56@linaro.org>
Date: Sat, 3 May 2025 15:11:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/33] target/arm/helper: extract common helpers
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-16-pierrick.bouvier@linaro.org>
 <8f480fa1-609f-4b90-b6e7-02a76d2767d2@linaro.org>
 <00710aa1-2a44-4778-83da-05cc125506e1@linaro.org>
In-Reply-To: <00710aa1-2a44-4778-83da-05cc125506e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

On 5/1/25 8:24 AM, Pierrick Bouvier wrote:
> On 5/1/25 8:06 AM, Richard Henderson wrote:
>> On 4/30/25 23:23, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
>>> ---
>>>     target/arm/helper.h     | 1152 +-------------------------------------
>>>     target/arm/tcg/helper.h | 1153 +++++++++++++++++++++++++++++++++++++++
>>>     2 files changed, 1155 insertions(+), 1150 deletions(-)
>>>     create mode 100644 target/arm/tcg/helper.h
>>
>> Why?
>>
> 
> It allows later commits to include only the "new" tcg/helper.h, and thus
> preventing to pull aarch64 helpers (+ target/arm/helper.h contains a
> ifdef TARGET_AARCH64).
> 
> As well, for work on target/arm/tcg/, we'll need to have aarch64 helpers
> splitted from common ones.
> 
> Makes more sense?
> 

Added a better description to commit message.

>> r~
> 


