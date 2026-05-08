Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135F8CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHjW-0008Tb-M6; Fri, 08 May 2026 05:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHjV-0008TT-Aq
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:42:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLHjT-0004qw-QD
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:42:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso16883665e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 02:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778233374; x=1778838174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3uMB20yAphu5l/Xjzp3gtvbfflcKwhpCN9rGubpl+WQ=;
 b=cnLRDNMmbYWezBNrwrV31Va7dyq6956RevV+FyCB9UPCEs+aoA6oNCJ9e1YaFCIoAS
 2Q4Hbt8LFOom05Eeiw9IwsSt4OmNHUUrN4ie1eWH0pdPMHfHY5b2F/QseN2YUnbLI2s6
 L9wvyKD7mcQxFrCS17Etun4n8eu2coL26v5mns49pNIRN5yibgCytylJSrUuBREl7hgX
 zlSvRMPl3Iz5TkL+EplhBJwOzRt0KtmuJsPNysfCkKwXuPz9wYTzypqBnLYumkYmdSw4
 qvSGoouUKl7CdVEX2kAPBOeQI85vpX6wFau5PWwvi8fqZimR1LX0anW5VuyoxmfizHlC
 tUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778233374; x=1778838174;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3uMB20yAphu5l/Xjzp3gtvbfflcKwhpCN9rGubpl+WQ=;
 b=BFUkMLt221pnQ/LJ8t7P/LgGq31+vilZ6/JRHdxixuqG0Id/HLP84Cl+kovf1VeRAo
 BhkmhVMSrhJWVObLUstLtY96qnFuTO9Gd3gH+XBkxkjV/BaqtemP/z9nH5568YB1Vy7Y
 jXhixiwfANdX+Yvpm54KPHi9mH3K9xWtNkNnu5qeIMzVXp1qNF/dhftGPm1TgX5na79v
 f2vwDGBCWgutL+hklbeCmWGxeieQ+aYCHfJenLmlk99kLwMAV+44XJAPHf8YokFeOppK
 +NTVo//LAVms1PRqtfGl21tp/be+v/PUA1v+LK3GWDf58roE6E4H8ELfbE/V+pLXbY5A
 kC+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LUdf6MyxZb0ZeiWG/cCQIM7Vkcv5Pr/4DP5zDvvE09PTA9+GmMmOEo/Ib9KC4JMUj8QjIVqKAUL7e@nongnu.org
X-Gm-Message-State: AOJu0YyG/7+lzOkL3JBYoylTXsAfpW3Yw77NTURyY8vl5vGeuu0xQFFV
 Kj8gQIt8GZ7uyZWs6oW9fEmYETb7I1ZZEhhRhQlb0XMsUrsbKzLelEuApOmCFyTrFRA=
X-Gm-Gg: AeBDieuAOk2zGkf+8lmjfqUzaAPdc+gcN0KPu5pwW1HgOXMcFwB9r+6bOqiGbWUz6zH
 Ob3Jdp6n/i3oW1st5929sNi4umDbrFGbChpiy/M9AFR1NakVDr3DxO3xJ2Onv9rENfFZ7HMexfL
 4bsVlspGUPq+tQnpMgpqhkwq1vQbMeCh5eyQLJx/8J/Z5S3Clj+RwWYIrrSSDtOTWCBWrYm/2Fu
 kkCqMOkMFbVK9NaSMwS4BWm7ulo54FgExL84pZytco/Rt7SxFXIyIqhvXSoJPCpZS2UAFPEQsox
 vaimog/rYPIAs3XDswcp9MDo3lm8ozutujOQBuaS0R9gyjt4Kh7OiHBUXxL/CQB9SH2VXiAFJfV
 5eXTsqZpJPD/5o90n2cih5454p8azaz3hndSp/NoffeUWnjEaxgD9ci9YZ407OWMBFukhVRxmdH
 3prjL5624fV9gbQDyGHS4gQckFZFqtNrE/04/yVV5b8IBuRY43PBqGUSyZsCeD2Hwi
X-Received: by 2002:a05:600c:c094:b0:48a:557e:6b4f with SMTP id
 5b1f17b1804b1-48e51f45a0dmr139287915e9.23.1778233373578; 
 Fri, 08 May 2026 02:42:53 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68eaf237sm32317785e9.6.2026.05.08.02.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 02:42:52 -0700 (PDT)
Message-ID: <ab0a55d8-928b-4194-9d5f-64f7b657f40d@linaro.org>
Date: Fri, 8 May 2026 11:42:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] target/alpha: Remove CONFIG_SOFTFLOAT_INLINE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260507221717.486023-1-richard.henderson@linaro.org>
 <20260507221717.486023-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507221717.486023-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/5/26 00:17, Richard Henderson wrote:
> Don't peek into float_status internals.
> Fix the helper calls that were missing an argument.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/translate.c | 18 ++----------------
>   1 file changed, 2 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

