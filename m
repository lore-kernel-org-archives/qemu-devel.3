Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2E9C3ABAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 17:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAB6M-0002Lx-My; Wed, 30 Apr 2025 13:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB6J-0002Ld-Bt
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:20:04 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB6H-0005O4-Nh
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:20:03 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b0b2d1f2845so56297a12.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746033599; x=1746638399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l/5QVyN8HqVrZddosnkhTATdVHxrZezKR2GacZZc4LI=;
 b=QG1DS4YS4/VtSZPCmn9FUE53EEuwW1BCyOXRfq09lxJpiRS2O5H4N3wweObqEpXIbn
 vhX3zlScUt+QEYjQ6U9nUQVI9lF0sev/l7su5QrYvqaS3nklWPKtpIo3ZeHB3Z91e3jD
 ypzlX22avY1JKSF9YJimy8tDkW9vCmlQeV3DqHQ8a2jVhp561r7X9W5jDMvdTfb43ewF
 pXJ29nJ/HLiWTZkpujLYbuy80UIZ1iyKAdmAh2a+lN56MdMWXhsI4xondFbEd1fyGm46
 b1Z5fFi1RS1LCOmiEffGPnazXp1PWlTXSg3ArprlZL7ns1QxAhbEM59qib3E9s3i0flS
 EGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746033599; x=1746638399;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l/5QVyN8HqVrZddosnkhTATdVHxrZezKR2GacZZc4LI=;
 b=BqCFldBTxdvRRFAEqyBh0TaV6nLT0H6tQ3J7LJ8YIb/Iq5VDRjgOwJK3KoxffydI8d
 06A+RxehyVoh35TeFUImCIb3XAunWE00n3r9hYdOs4WnuNY/UC2sctsNJkJ7wVltPG9B
 Ps+4NfWxOW+6OL7hbLHUJ8/bZb7Z1o3Yx83MjjfdrPiz/r4a2XarU0i8VD64smz3PLtm
 eakrJVu2PMMSRsT54HlMxGDIGAjRQwsh1nWEmJJjI3vuvbabvfD5XJYjktxHEibJCCPc
 +VCzn2thjzXUEjIphH6qplaHGJ2AlG1yDYDXeGbr8U/VLmUIXrWq8xSYd2mhkQRfD6r4
 jAfA==
X-Gm-Message-State: AOJu0YxcAPmX05TlEzMHifX9navsdXAbbs3NWFxWgPHbYUJIdn63VJmQ
 W/Kr8YuABIgboo3Qk68L/qmPYlhyOuZN1hpq2HJYaLI6I5654iQVrHIU9avZk1XgqU80r7yUWgB
 7
X-Gm-Gg: ASbGncsqStVEJM3BOlU8BxQrHblyPKYRrOLbmi+BRy89V+WkbaeuDlkxCCjZCgkf3Ad
 R7tSousGIGw0LUUJINmYN089h4k/DCK17It7v5Z4fr8rELXYIdwNAzWY4Ip0wBayiTx1PjBLP1+
 LUDIWou8DHn8ATkZE5gxQsOOisE9uFp9dOgc4dEXYFz2nKJRBhCBK+9aHBDJYvQzqG9QkZMHoVb
 4sdwEhEdix+22FhMHeiRwv7uYrAssJ7NBjUiCZeJwQSduJrlnyDsTeTs6XvnULdplOI1/gBbmzQ
 T/LixZ+shEEbYa81Ytf/IT0AWtkWOdlIPYhRDvEMIMMH2wlS+/i5w6cj5ePcv3/bNx/w88OkP/W
 s2DYsEHgtRXXMEqz3Vg==
X-Google-Smtp-Source: AGHT+IHHJh5yB4Y8YZCtb1s6oHNOt9eDEC7bBaiG1mvJGpiX5yt7e3A2v5GizBKYXEHGDWEaf1tXgQ==
X-Received: by 2002:a05:6a21:8ccc:b0:1f3:48d5:7303 with SMTP id
 adf61e73a8af0-20a8941b1b5mr5560273637.31.1746033599577; 
 Wed, 30 Apr 2025 10:19:59 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039922c83sm1973462b3a.60.2025.04.30.10.19.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 10:19:59 -0700 (PDT)
Message-ID: <2398b632-c719-4d32-9431-7206907f1746@linaro.org>
Date: Wed, 30 Apr 2025 10:19:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] target/arm: Present AArch64 gdbstub based on
 ARM_FEATURE_AARCH64
To: qemu-devel@nongnu.org
References: <20250429132200.605611-1-peter.maydell@linaro.org>
 <20250429132200.605611-5-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250429132200.605611-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 4/29/25 06:21, Peter Maydell wrote:
> Currently we provide an AArch64 gdbstub for CPUs which are
> TYPE_AARCH64_CPU, and an AArch32 gdbstub for those which are only
> TYPE_ARM_CPU.  This mostly does the right thing, except in the
> corner case of KVM with -cpu host,aarch64=off.  That produces a CPU
> which is TYPE_AARCH64_CPU but which has ARM_FEATURE_AARCH64 removed
> and which to the guest is in AArch32 mode.
> 
> Now we have moved all the handling of AArch64-vs-AArch32 gdbstub
> behaviour into TYPE_ARM_CPU we can change the condition we use for
> whether to select the AArch64 gdbstub to look at ARM_FEATURE_AARCH64.
> This will mean that we now correctly provide an AArch32 gdbstub for
> aarch64=off CPUs.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/internals.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

