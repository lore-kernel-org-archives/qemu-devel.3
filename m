Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC7EC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTB7V-00086o-Eo; Sat, 21 Jun 2025 23:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTB7T-00086N-75
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:11:47 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTB7R-00048c-L3
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:11:46 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so3663366b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750561904; x=1751166704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ESJGHbYYNrLMWtyMZ1uuRRCxW5mnTqfumH4WpNf41RE=;
 b=YOGshLkPpG12FQd78DREgeeeekAYVpnoTuu7RsRjLELJ8eZ/adlRXkZeNcilhygPij
 uQ1U8uC7cWkDGHZ/FIW7I9Fv+eDORhAFp3tbQIBeUdFrJngfBrwQjcQMOu57LIy61xYc
 LAbn/t4TMpTwaLTI0sUrOqkAbMi+kKmZ9lI1TBSUTf2fGNBs6JQBVXReh9tOxAIytExd
 hXrxaLqNEw/1hES0z017/spid915jsRUl2yW18NwpXlTK2+YSjvsEMGSb6qiYSUWsJFs
 gpODNxEMPA+WEqS15ZN6Y1VgjiCj0A25KC6T0Qwmoq5j+5pv5Ig8ym1pDb0peHI31VWZ
 v/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750561904; x=1751166704;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ESJGHbYYNrLMWtyMZ1uuRRCxW5mnTqfumH4WpNf41RE=;
 b=eMP5b0obPVr7h04HNKFo8cG978bGTTPZ4ofGHKmZbSyVOs9slOBShqkcrwtXoFeYyD
 q1sSXih3EiDxy8wR5+IuJRfd4+hwS4s3Rbrfl79W+0IsiKBta92rXl9QEdSHLqu42nNw
 esSl7aGJeWCOCqNywHVUUH0JZKMLqWNKZYDTa93IalVMMtGSYwMbcjGm2B3R2lWcP6Zh
 ExBgs/RAXptaEKSG36baQ3x8AzCc4dhk0GDQ9QZp+fUtqfu3voCoifnDODF/4m86D8CH
 yzHAEEf77RRqsC+XvQCbK7vzgwM+Rt3Bkef8IEl+F0RuAjy4BL6YDyLbQBIJMkMfJiAG
 SAwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU24UDg0ddLtNpzsNZkflt0lvXxcJZnuwBNQOrJilgYiXMHDPh3cdk+lSN67F8SkhSipl7VNC1Plfo1@nongnu.org
X-Gm-Message-State: AOJu0YwQAnz+7aEOmruzNxD48604j/DcHTB3kBh1sjA0AS4pXl/Gc8yC
 0HCndTzxktzlxpHVFNNBAijOGoebn1oSAoDOupz0s4UYj26FP7bp+7PIem85YH2C3UrQdkS39Wj
 LhVJ8RUM=
X-Gm-Gg: ASbGnctppThsghdcjsvi23MVBFGjYRAAhg6rSMEebPRrfgfoQqB0c5qH9KFN4JlZC9i
 H3I4vTKYpF20GDsllxhLa+lxwiR0vKvIH5oZBXGiWuP8rs5bHocwtxowQ6ad+pzYV7q/tTUaijT
 p76zZ3br1sG5K3Cb+tIdvtvTJZ1u+lc98NhzCxx40n7CblzXisHXmT7w5t8wPU9jraBwmaxRAml
 R1ZVnR3GAEbv+HxHzPA7UNkNHfaSBn7zmPKEIfdc3VFzegF66bdG+ydJBzgkjSvLBRI76NXWQ9t
 v4fDPHU3uTQ/pS+ey0FqlGwwGhJ9N7pWhLhe7KymBLPyWwRDSiFmNyWzd4aea37llFri0H70DQx
 QYIOen101PGejWduWn1OmlJ5A1cGg
X-Google-Smtp-Source: AGHT+IFGJ+I1DbejyUCA7TMFWb52hPGuPY3vL+tlW1zo74ZYT6SbHyIRLrJZkVUZHzu4BTmQy4C0iA==
X-Received: by 2002:a05:6a00:14c1:b0:747:aa79:e2f5 with SMTP id
 d2e1a72fcca58-7490d4a3046mr10463401b3a.0.1750561904120; 
 Sat, 21 Jun 2025 20:11:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b574sm5389092b3a.15.2025.06.21.20.11.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:11:43 -0700 (PDT)
Message-ID: <20e925f9-9bc2-4580-865a-7d04f9bf54e8@linaro.org>
Date: Sat, 21 Jun 2025 20:11:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 26/42] accel/split: Empty
 set/get_virtual_clock()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-27-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-27-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 12 ------------
>   1 file changed, 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

