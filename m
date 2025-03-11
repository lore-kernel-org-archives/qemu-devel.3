Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8355BC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 07:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trtqf-0005hX-52; Tue, 11 Mar 2025 03:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trtqK-0005fm-7b
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:16:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trtqH-0005oN-TZ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:15:59 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-391211ea598so2817165f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 00:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741677356; x=1742282156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w1eB1eNzRxI5BLEhOaPQxaWsrRouj3I7pLCBxfKwt34=;
 b=zEVD7G37WRxrGF6WKn/AuMT1bF9umHBl3knUkSTWe12znU7CCk0P3xnPoR2q2HNsak
 JzQFoSPtqJ7AX+3+tBEQccERO1XUrAuaH1QH66Z2rPKXuVJak96N8QA1Ea3AQRnQaUhm
 CmB7C0MrITqxTg4mxIGVkxFV7m5FeBLNfvSWbvTWI4f+7PHMSTHwAAubnTomgL9bbwCR
 EEUF4gkskOxttdAKtMiouPDPwTwup1vOMbVTHWCZcSZ3HdA7CMiXtCwmxB5UQuGpjb45
 +pmcYF403h0dPLEAItjW+X+Wa0OzirUBprESLv3bAnbCBaLKbLq8+SOLzJr3VMg//IiW
 Kpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741677356; x=1742282156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w1eB1eNzRxI5BLEhOaPQxaWsrRouj3I7pLCBxfKwt34=;
 b=jcM3pUnh/4Pq31SiCzMUGy/PAOli+E7A9y1BP0oGKqvK4Cn+o4smFFRCM0LrYjvItg
 +ybv8FfQZjaxSOfhtXXaRqmRqmgvrk/TUFUvWhaLaUzXT/+76bk7gDrmYv6n84dtBz9h
 fOwwEdyukaecaBYX7M6Y4aJi8Jchlv9FaMPQqRCA+IE10LDUSwWvMLmoLK6uwJhy86GX
 M9eiG2ezeQfnfUhhmpvE3EGpZsa82Im0fyg3x54QU/KZb4ZHSdRIsmcGUBPm/eOBD02v
 xEYBiZ3eZR+9SnExhRkrJJtmjvvJ/dkPH+zOCFLjiSVp+O9Ig7DHiuqtHxwk0k6gaJYf
 ddsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsFVh2Zr94GDw/mNu3B7ecJk2Plssr2qLrW/st68VxlhgLaLAClwSduYidsgAcEtIVWw35EXUvjEyO@nongnu.org
X-Gm-Message-State: AOJu0YzXU9Z+3Xnkn5c2QZXnL3eF7P8B2kv0+wax2DVM2JVwQoCoDELK
 YVELArsAY++R1yOu13MxPAL6Isp0VghNhP92WZOsq1O/LIo1jnXyb2C5TlupBvg=
X-Gm-Gg: ASbGncsu21NE95zGxsedloitpGVeNhWFrbEAK53j4i3EcIiAXlndHPDqSw6yaUWXXUp
 gr9PTFY7ORrsGT6XJ6mAioXg5tU3ynO0C402r98RyKD03AtSYAOoMWOkg6LBTR7t4iscnC+5F9k
 UG3we1Kb909wSR9zOp9GNtOUE1tOTBzols+qamnLpRodJuUfahF344qzfej8Odz72OWLXf4TBpF
 bwkSF1R0tLU0FRHcI+mwSJHvOj/p+L95VAGeDBNfhtFwvqDwHPqRsR4axCyzZ7UAC5A21mL6Ulz
 uFTMobwi/C5AraBTIHzEKQw4Id0cfXWKguR97hkNkhG9ZlVlrG4oRACaSo7h4LwFLNLyP0BHF5S
 I3hG6MQmhdO3i
X-Google-Smtp-Source: AGHT+IEBU9bOVIgPPaJTzTeIUwfe1Qd1Q+ej/oQA6IHaivo8jXGBvlRUaxmFhmJTs410iz6i34lZ0Q==
X-Received: by 2002:a5d:5f8f:0:b0:391:2e0f:efec with SMTP id
 ffacd0b85a97d-39132d1faebmr11382142f8f.7.1741677355682; 
 Tue, 11 Mar 2025 00:15:55 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfad7sm17064182f8f.26.2025.03.11.00.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 00:15:55 -0700 (PDT)
Message-ID: <fc4bc85c-7ef9-4701-a7d0-735048d7921a@linaro.org>
Date: Tue, 11 Mar 2025 08:15:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] target/ppc: Move TCG code from excp_helper.c to
 tcg-excp_helper.c
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20250127102620.39159-1-philmd@linaro.org>
 <D8D7YBC7KXTQ.156IWAC3B116E@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D8D7YBC7KXTQ.156IWAC3B116E@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 11/3/25 07:22, Nicholas Piggin wrote:
> On Mon Jan 27, 2025 at 8:26 PM AEST, Philippe Mathieu-Daudé wrote:

>> This series is a simply a cleanup restricting TCG specific
>> exception-related code to TCG, by moving code to a new unit
>> named 'tcg-excp_helper.c'.


> I pulled this in and just added some minor changelog and comment
> and subject line tweaks noticed in review.
> 
> Patch 2 was already merged, patch 10 I left out because it had a
> few possible issues (but it generally looks good if you plan to
> resubmit it some time).

Thank you Nick, I will!

> 
> Thanks very much, it's a nice cleanup. Sorry I have been slow
> with things...
> 
> Thanks,
> Nick

