Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1A2CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 07:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVcC-0001y0-3U; Thu, 28 May 2026 03:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVc7-0001th-Uy
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:57:11 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVc5-0003GS-QU
 for qemu-devel@nongnu.org; Thu, 28 May 2026 03:57:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so7339728f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 00:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779955028; x=1780559828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ms/VZfmXUiHPszoFirCJAPb7OXnj7L8eDNNprRpcMuw=;
 b=fQ/KHAgnJf0VNyBqWUTHO8PTP2sYVqHIFQDwXSwSbQQsUKTJq+pHT7Qv0wlr99j0zS
 UyVk+7x7ky42izpf+clIbFAUFzgmyUfR3modI+4REKe/juuVP9by+uposnAxtH3xfOYs
 jOIO2g0kDdsiDVF6sXI0/o4aHMOUC41KbiN3Iu/co7qMejPrXVFvZcsrAkp0/1AksLRr
 a7G/95IaKsz1v/k4MWpM1HaKDEIxPIcfW/euHCD+mO0oT2FrRcHXB+icDT/xabIqt+g+
 D2g/uetK5k0Zg1zIr5ZhM5yrVRYZxpRqVBvW4AS6EGkRnVN+0wRPDKnK3u7OBM5Q2VZo
 ZB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779955028; x=1780559828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ms/VZfmXUiHPszoFirCJAPb7OXnj7L8eDNNprRpcMuw=;
 b=IFTuVAVB6GDYOm4nhvvp12CyDdibtUEgzmuJjJ07u51mswRXSdSbZ3zRQb7kO4KmiY
 LUFIdAw+ZjVfrgjOnSrBfIjpWvF1v8OmSi3O4dzm3sida2lXsr1ObMcIyrbqQUHfj+/6
 uHMIr+WD3y9CDa0Yzhi+V7+NPFkhIFTkE+feYdQBZjWvKLu95LRNB2X3xlbbBAu+YT81
 JogmgIrcXSzL4Gm5RFofBwqsV+YdRxcP/99vK8izFBkNfEFREJi82s0ec7bfZgFoxgz0
 D1t2Pt3xCpQi4KAVoTjwoNXGWopLpcE6MWQ81FO3W05IUvBw87SEiGWWJj4l66mpfgIl
 qd8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3OoI0nvRgnyxE3javy3MfHN1GHBNtAc3jjY4IW4Yic5C69TXLwptgMtiYg9E0zcTLNm2RU9VFcOCj@nongnu.org
X-Gm-Message-State: AOJu0YyqrjtBV7o/z26ZDfd/oHNUovtdieNAN27UcG2xkCB913KcQHbd
 SRLSyq88QNxHxEEG85pzeaJu/VkJGlg1xYQ+4xsStmYEcv4kBhPO1St5bzRixn2ySK4=
X-Gm-Gg: Acq92OFXM2yXaOY2woEntRjVtSKKtIwPbZh78MOdYD8/M9suuSGNg+fjN1W+7OPyoGR
 hyXONZuwb4dTb3MY/qcNYt8f9Mxv4CXHbDUhUl2umOdG4rC1wiAqbKHuuT91L1OzL3zHU0FPCIG
 QGk3N7ylxRHmY9IgBphQUiAaNh88v6oDK2PBko+Jzjzvy0Q8n1tHTXkXXUdrbtnU52XhIZy76P2
 vO7G+uTqOXvaj9+jN1ss92D5erg/idxHQP1fQlK2+Qlpqgo9/0zz3EgzgEBedVwKOEUyROr4Xfh
 dbJemylUDs8QeuM8rkmkJ0neBnJQjg6XLamsxZJW4KXN5xSih2JgtxLsMYDk2xl/KFXMaTa63um
 MQHKFj7LXX07wFCUyNRTHefc48zUWlXU4y6Rw/5+R7BYCifomEpL2F6zoyDbquPZb13ndC0iqlR
 Z2CbqnB42583Z3hSIq+fdsDAQ2PnoOwNc80y6c9r9khxfM59G3/8fNa1y7GBAiP28NQiRxZsTZ6
 21d
X-Received: by 2002:a5d:5f54:0:b0:45c:3f0b:be08 with SMTP id
 ffacd0b85a97d-45eb38a686bmr46861431f8f.23.1779955027560; 
 Thu, 28 May 2026 00:57:07 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5c1e59sm10855300f8f.33.2026.05.28.00.57.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 00:57:06 -0700 (PDT)
Message-ID: <d7840923-a336-464e-af7c-e526e73075ca@linaro.org>
Date: Thu, 28 May 2026 09:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] docs/devel/tcg-ops: Minor documentation updates
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260504125032.35465-1-philmd@linaro.org>
 <88625510-fb99-44a6-9995-8a1eb6aae2e4@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <88625510-fb99-44a6-9995-8a1eb6aae2e4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 4/5/26 19:24, Pierrick Bouvier wrote:
> On 5/4/2026 5:50 AM, Philippe Mathieu-Daudé wrote:
>> Update TCG opcode list.
>>
>> Philippe Mathieu-Daudé (3):
>>    docs/devel/tcg-ops: Stop listing dup2_vec()
>>    docs/devel/tcg-ops: List more vector opcodes
>>    docs/devel/tcg-ops: Slightly expand on discard() opcode
>>
>>   docs/devel/tcg-ops.rst | 20 ++++++++++++--------
>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>
> 
> I will let Richard pull that as part of tcg subsystem except if he
> prefers me to pull it through docs.

OK.

