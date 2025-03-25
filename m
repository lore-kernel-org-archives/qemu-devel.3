Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E5CC36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 23:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txDKH-0006nw-Ts; Tue, 25 Mar 2025 19:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txDKF-0006nI-LE
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:04:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txDKE-00019I-3c
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 19:04:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so45951805e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742943888; x=1743548688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LskFNgof4LL5cx2GgWMk9IRrhdOh+ruFXgOPnA6tDug=;
 b=WIejl3Pm8zUXebPcsNzW6NhUpHi9GSbvW4N2j5vZeQZny6B0+LMdqUxHJwT9stbsmU
 BT444D+7g7ikMnoZc7+zW8hYBPxeNJ44lMrJgwyN+zh8chSzyogL0mc2XQFEO+DQgHDt
 NCyz/hM0C4maO8ShPiXaUb2nWobotDBVbF9LSN0mTxt34kfPWvnkeQGIhqGWZv7KGHk3
 GuUFhxxypn8870xb2cUVXVUbu2XP4aLh0D9EL2LebM+jGWo9aYBU6ag3iiiJIsWrMIEq
 Mfi0H8r+h4lWv4tJ+I24RwvsJlDkdZ6YG/ZL2p9dAdwTZf7ZsqUmndiDCuNIQ1RP96zA
 ftAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742943888; x=1743548688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LskFNgof4LL5cx2GgWMk9IRrhdOh+ruFXgOPnA6tDug=;
 b=jqAkJfmXF7LbnqZ/xLREwmWrePykWm3SstTjhNlmU5lzIwBZgBSfXUIbtau4N4yLaJ
 z0d9tYrXuC776Df8sbAn4PSIGOLI4J/XCceUx6/18C/GvMVzRggEaRGK6OBZWitwwz6c
 qhWmHIgn7pvU21ufCF9eCQKKefRuiQ3PVjIvrM7zh32GkoT9tJ4rZ5d1iYrvXqzYkmhV
 PIjfIAew1IsklAVCG50yNAAK18wLnPCRSVnt3QN7Ft8iu3NrHpOjdRthbayvX1tsEMPT
 8zgGjPL60HEgBCvbSTEX2OmSRfDUihfGjBrkBCsDdsJTFSlsCOi9PaltMyrnbUeMSczE
 qITw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuZXKqQYGBx4399uAHaCF7KzjewkalVJ8SR9hln+tAOylasV9rnzeIBFqnPR/if+bzZ4Kk8spL9i4I@nongnu.org
X-Gm-Message-State: AOJu0YxZlKSKuszYjj4BDw1wsJ3gatFpi2S1/kegKb63y5BM2T8h2r1U
 kMY44Wzi+QNlIpdyO/KOeJNBqyInQrEZlJm3GPHO0d0e9Ewfhp0hyM+OPJmirlMB/xyTfmPN87i
 1
X-Gm-Gg: ASbGncuVR7v1BVuBM8Tf3UXwacy2iv6u6cjibobHNo5Iak92YBtPr9/9PMjkEQ6Zlq9
 50B7m+ubkUgLh5M5XLjyecwtlBuI11b+AvIPl72fSRWYO7S/nHu+AmL850NdZcH/1YAY15I4hTJ
 ra6zgTaPNg0CwzUMVUzrZ2b9m3+HRBhp7bi85XatcBEM4g9dx7QqtOLPK4VTf11eh59jH4hnr1o
 Ana4TboxBJthcPTqgzoAQsYb32wvfX/uj5cn2bUEcMm60K9aQUcE2WWkmPrFGUkEOHmTwuWdHSj
 4ekPI+hyzgJCetacpX9U3X1yW/QqMRsVLtBFGPe7JaafRaCG6/zUAKhWtcY0E6G9HLXR53ua7wf
 XA8KGwF0yeEWmyGZALkrOyd4=
X-Google-Smtp-Source: AGHT+IE2C+fejsuY4PrYjc4dGvxgGeQybUDcLx/3gNEG4LH2P7Wn8ZWfj6ORthnm6TEHqmhnMu6Thg==
X-Received: by 2002:a5d:47ae:0:b0:390:e48a:3869 with SMTP id
 ffacd0b85a97d-3997f8ed743mr17310945f8f.11.1742943888462; 
 Tue, 25 Mar 2025 16:04:48 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9ef155sm14729179f8f.89.2025.03.25.16.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 16:04:47 -0700 (PDT)
Message-ID: <208e3f50-89c0-45be-b476-05e7a144357a@linaro.org>
Date: Wed, 26 Mar 2025 00:04:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] target/avr: Add defines for i/o port registers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, pierrick.bouvier@linaro.org
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
 <20250325224403.4011975-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250325224403.4011975-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 25/3/25 23:43, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/cpu.h    | 10 ++++++++++
>   target/avr/helper.c | 36 ++++++++++++++++++------------------
>   2 files changed, 28 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


