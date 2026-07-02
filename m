Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04283C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLkf-0001Md-6g; Thu, 02 Jul 2026 14:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLkb-0001Jd-0M
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:03:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLkX-0001G7-UC
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:02:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8478a25f268so1541869b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783015376; x=1783620176; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aVx8enAZsftxIcGL0xojtj24NNn2E8Df/JOcb32+KxI=;
 b=CnqVnVCysIAN/w5H4RNbri3KBAbZk+f/dFtaykCA+vJ+vIxxi+4DyvQkjxuqqUzSuB
 4eqhttX4Czj0x3TUx4NlH5cXfwp6MNoqBfqWLVLM583xPHPs1LM51fIEbDI87pBXivM3
 LPyPCDsDlQWfnrUWPJJWvDVNKAFj3aqpqNJXBX6F4nnPnrVQdj2zVpV3kIVG24D3Dgix
 7Nhlvlwsviemwi7HT8udq6OfpcQMKNNS+Ki8htqEuKofE2ficzxFs5iGyr3HL5V/eM2G
 ujltKZTpe7B2CgQLzGUWcE5BkKVl8UkxKAyeugjMpMfSqMcOE75TemssuU0wXKhZUOLP
 63MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783015376; x=1783620176;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aVx8enAZsftxIcGL0xojtj24NNn2E8Df/JOcb32+KxI=;
 b=TD353PJyiYFBtOsucSyif1b4B12J+WvmCDNd1dWWpkIenjMw5K77hM62sS7H8euoxe
 VK+LBKb6K1vm+O7an7/yoiZOUdppo6zdpOu3ddQnh33owzoL7AAQ1btBA1EFIYNHXMFN
 CyxHtcNympe/4sPFsxyYP47mTCg/b9nRkCnmq4KyUZSTFmf3ASbga3apOVnjvrXZEPHp
 r2jp9z0hB986S+bMxQdqpjNwTIPPwxM+Gqg4+Nd4K3giKPx5TCQxCjIYXCQDsmUucvmg
 pD2/pCIPJCB1JLa3ArPffwa7gXPUavNt5Rhm2BIaWU5PwWew9nFx7CXqhVoAeDlmUXUX
 I1Dg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxT+i7vfV61egTCQVX/eP+wdwduchSvBDm1QiK7EW7dPcstc4UZRkuGP5PvtjocFiR7mBeJObQBhNG@nongnu.org
X-Gm-Message-State: AOJu0YxkXLLAoWocJa+fkqQcDMb5KazCQ+VHks2WuJECFHFf44SxmSgX
 EDUb2RC5LGM7N9uwzgy/3t/gPCmi14EWeD4NEaLuZwqB8jpTCpSxLn9zekpfU007HVg=
X-Gm-Gg: AfdE7clF077QocZk6ETSzReCwu7/NmuRQd18zvgKsKgyyDmT4bJ6vGUI2ecXi6/xANG
 XyJ57HMzp3BHtkUPv8UXEUfTmK2ulfROmeVIdlM2bbi9iMOdy6vxwLrvvVHV9EWgM4w/+qck8X+
 31i66bxp3oOSWcz91yqDrctJhbayDXnSdIpZrEGmfSovsyDVfZWMQYsBS+Zcr9uTEp8RuIBtL2e
 bi/UgUEbJyTK3AmKZY6hfUjx6jwQXLdwv4VcumAV9/y9jAZZGgS98cblTRqCjfKPL31zjFzkDFw
 5xibVPtSn9QFiR5KybCJPtd5LkFAXrLem0/YLFl+BdraHryGtIDVVIxMAwmvshuAKtpLEjGHNM2
 qsYSw94XAfjEds9zzoU/Ak5rdEllfWgMFusaqgqoaJCav33xA5baardYe15kAsC0JnzQQNvgqVM
 uU/qDUQNPlXUhEyNMhqY7Fzt+KVV8s91N9b+SFR4EG9atEi1geI4qH1TZ6xQ==
X-Received: by 2002:a05:6a00:847:b0:847:9267:2104 with SMTP id
 d2e1a72fcca58-847c5005699mr5725904b3a.12.1783015376338; 
 Thu, 02 Jul 2026 11:02:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e8eb0ec6bsm1595754a12.7.2026.07.02.11.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 11:02:55 -0700 (PDT)
Message-ID: <3a6d2b4b-823b-4b70-8cfe-0932adbb638e@linaro.org>
Date: Thu, 2 Jul 2026 11:02:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/33] target/arm: Factor arm_check_watchpoint_hit() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-26-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-26-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Factor arm_check_watchpoint_hit() out of arm_debug_excp_handler().
> No logical change intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/arm/tcg/debug.c | 37 ++++++++++++++++++++++---------------
>   1 file changed, 22 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Note for future work: I really dislike having these separate "check breakpoint" and "check 
watchpoint" hooks, then having one single "do debug exception" that then has to work out 
what happened.  And clear the "watchpoint_hit" state.

Ideally we'd reorganize this to "raise watchpoint" and "raise breakpoint" hooks, which are 
given the CPU{Break,Watch}point structure in progress.


r~

