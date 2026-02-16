Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AA3E63F25
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 05:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrqqc-0004rY-M7; Mon, 16 Feb 2026 00:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrqn9-0004Ll-A2
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 00:05:03 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrqn7-0004R9-Gp
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 00:05:02 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-354b20c1112so1877136a91.3
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 21:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771218300; x=1771823100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Z5eeL8KhhPNaZYUgPA9rNCozKBIkN5TVYK+RMbQFIU=;
 b=OWNKihdDV2KLviNlFzZPq6O/8OUih8z4kP+z9sx6sPsma40S4xrD/mAUNxq4RuHxkX
 FgbsRjsLQK+UrV+Vt2Y2fMEoxkqb+/WUvCySoyXWiegsYzcAMPxSsRNaXBpeFZRp0nry
 W39ac2+mwtdP6a61XUWARO+JUO0oJWvEamd2jRut+BPdk/+NfTQMwrp1GxA6m9BWKvcR
 PjDgjReK5dyXakxpntcbZkDXef2Z0y2ea3gKzA++3CO//FWaa6rZbJWkT2KULKUL/UCB
 wGtQlOir+42HXji6wNUBybCHaI05ST39KSIVoQI4svcZniek9davkfZ817r5mjjzwmG4
 6ugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771218300; x=1771823100;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Z5eeL8KhhPNaZYUgPA9rNCozKBIkN5TVYK+RMbQFIU=;
 b=j6hyYVFvx+r+fbjYvNxdT7ZuSGeUW77lvokIZPCPxURWJsSejMlLAtWcFLwtkjbf1s
 fRJL81MW5TBqbdzwZrIx2jVT34Rk+iiyRfmOcSRd8ZKpCIArieSX0nXji1ZicA3nS3bz
 Rxd68m7yshGSxQciuCR4MbDz7syepQZ7BUIzzhfry7w2scGni32rgA47eXW8+ZajkYEk
 E+GFKEpBOVlG4w59vCk+o9WWV4107ellXsu0HkCGrtv5+PhKFoD7ZSWnaB2MBQfBozbK
 yjueMZSWX3AV9UKIfO/WiHzmG5X8FmD0Lb7Q5Se01ZTMCEZcTjidyfgj4Q395txl/0tC
 Gg3w==
X-Gm-Message-State: AOJu0YwkIOcuBNclrDJuEJHNTgsk1YUCF+Zm9XdpGvzer36i5Ky3mi3X
 /hMu08yYW2WtwktkGVg291uyqhXCvWgb3dxhYx4zrk7jAwPJfkXBESMBlUZsXbX5CdQ=
X-Gm-Gg: AZuq6aJ2dVJg9HVPVRg9IAo0wgMpDF2dpAL1r4bKg6uxccUjPgDenZKeljCryPIcK+t
 HTdOwNRzSq3myOLBfbHUPL25SFENFjlTst+0eBZZyTcWmmDpKaG47H4AY4qsqFRBMwBnDilOvBD
 vlK8WY7Vo4FXsSUBrf8VA7AMOUyxiZ29LbWq29jf9vVXV697yG1dFZDRO6diSOoU3Miout/EXa5
 y/c3ViRoFeERx7nXCjbpKrU24RUtILFtHgoLwvxMdfyX8z1ghphXn6rjZTHsvxS9oMw4wpnQWtl
 vyHF1Cb1GxbJtxmo9nZ/JnuYYYBS5E/y7q5eJU83oZnYUGhKEDp3L5n8ic2AFYWR8I9q98KKeAq
 1MQk94FN8lrS2reHIXB8dbt3YN3o2P4WbgoGLMZD89CBjG+wa7ajU+uFLTUWsCEI4yVwhi5suM3
 y70SeHzRN5vVdtdi0g9FOQU3gnkvqhc/t7dum+7HB1L0vLCFwohsIMg015Mw1xC9cGARLaNc2G1
 WiWb2nOUOM=
X-Received: by 2002:a17:90b:53c3:b0:353:883:affc with SMTP id
 98e67ed59e1d1-356a7a42d1bmr10262745a91.18.1771218299729; 
 Sun, 15 Feb 2026 21:04:59 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:4a1:428a:70f2:5844?
 ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3567eba9451sm13991158a91.10.2026.02.15.21.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Feb 2026 21:04:59 -0800 (PST)
Message-ID: <0a41230f-e8c5-41f4-8824-9d45de6ca17a@linaro.org>
Date: Mon, 16 Feb 2026 15:04:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] fpu: Add conversion routines for OCP FP8 E4M3
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org
References: <20260205111622.461497-1-richard.henderson@linaro.org>
 <20260205111622.461497-9-richard.henderson@linaro.org>
 <aZKVxean7S9fkHHn@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <aZKVxean7S9fkHHn@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 2/16/26 14:22, Max Chou wrote:
> Could you please let me know if you’re okay with the softfloat OCP FP
> conversion v4 patchset containing the OCP FP classification functions?
> (e.g. float8_[e4m3|e5m2]_is_[zero|normal|signaling_nan|quiet_nan], etc.)
> If not, I could provide another patchset for these OCP FP classification
> funtions.

Do you use those in target/riscv somewhere?
I didn't include them simply because they seemed useless.


r~

