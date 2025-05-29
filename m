Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFC5C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 18:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiC6-0008V7-D8; Thu, 29 May 2025 14:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiC4-0008Qz-31
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:41:32 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uKiC2-0004AP-Fu
 for qemu-devel@nongnu.org; Thu, 29 May 2025 14:41:31 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so1352373b3a.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748544089; x=1749148889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HSclE2N5X5bCWCr9Ga0a40vpfvPhQcWBFQt2bm7Wm3Q=;
 b=gGv6BRM5wqm6LuVR0Zb8J3pR/gFw4ViuzN8WbNBhgYZ0R403CY/GOMj95GdZ3sxN8A
 sP33q3Kv/USrsSQyXJqTUGYHNdn7rM2apcP7hCoC+Fm8NdD2pVfDIyPFYkbP6CyDBfat
 eKxaQgASBXNB/6KKbVcGy7FEZ9qikPvwC/cvEM1A/JNDUxPxtnEeVLgNAkByhOz9H2Xf
 r6h5uxASAOsAIk57YseD1nG7us/EFo7yrTaESJPQCQk3spSU5KBcQjS8dSbhaJQOANPe
 bnGqkd/g9maSCJk2KpYbPO7lnQyX/+W2zuLmirNobaP7vfOL/d2v2n0SJruj8WdBHNlo
 aTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748544089; x=1749148889;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HSclE2N5X5bCWCr9Ga0a40vpfvPhQcWBFQt2bm7Wm3Q=;
 b=IbjQcch+Ati/Ec2jcDdOZQi3+VQ3nJ4p8foJtOWV00kkbqW/qjSm4NzBr0REuiA0XB
 iGPHFDGhhSENf2srQMUAKSmJaUAT9rWp4BC75S//kYT60tAb5ud/R+VBOpUcRN16uVmR
 9BCVI2cuGXcrfumfpGWr0pQI1MC8tW+3EXsQiOti1/JFarRMP/3l1k4vAShpdQHAJZSh
 1j3xBRtD/PnyknRNoLcqFPXaKTfdpQJ7HAoj0TKieldHOjEoA6RfAheFb23gBlBD7Xff
 qq5uiimTRBk/yrC04upeaQCb7wggkPA2RY0bQOnhn0ImXd65aBocINvDDML/mlkb6gNa
 CeMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv2O8Cif9ULKH2uTqhgZ/FAkrcfcfjjir/kFlv9lJi6iH+eSimt5zg6ENLSKvo6WINp7Y2oIPkRajc@nongnu.org
X-Gm-Message-State: AOJu0Yzxt9pRIlx5Ue9XMm+me8mQsUXRielSlNTjbEAVWBchDdzNSY5U
 WJYSO9qDGsD5fmt488b266kbjhTHXY4ksJKGTjCmOv7FFBXmS30ISqswYNMm5gBRsGA=
X-Gm-Gg: ASbGncsow3R+Pz9dcSL49Yzles9mn1jmz66Bg3h3Pzn5a9M5mQq91EyV2SifcQrn+1O
 S3Pc5R6mWb0IIGvgqcmmEOuq4N4udo7cG1TEFYOH7lzaWg1RL7QH7ya1s4qtBvkhDuXwrO0rV0O
 1odigsLUYZT9/T+3Gq5OIUqBIovoKlP6/WQYsYeZHZ8F8IYgEatYscHUU3niydYSBtW90FIVBII
 wZrdmIC0SdI2KiU+N9AW2diCVc3jj6yatkYdwY7i0bZhDKxmmtP1czCXZc95+jsHWuLDnflPF9E
 duZXl/pAwP5TlGnocN7mdxYteFendjzzLjdWogYviFsmV7OsVhmahbnu4g4il6LS
X-Google-Smtp-Source: AGHT+IGPVlIKMZy0i7MSgCXnR+vpcX5isOyDPs5BgkAQEzd3mU8HKMlHVstrar3DmcKdHcIsMntWVw==
X-Received: by 2002:a05:6a00:2e1f:b0:747:af1c:6c12 with SMTP id
 d2e1a72fcca58-747bd9658admr627876b3a.9.1748544089120; 
 Thu, 29 May 2025 11:41:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeb2c0fsm1647765b3a.72.2025.05.29.11.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 11:41:28 -0700 (PDT)
Message-ID: <64ea2b5f-020d-4044-8d6e-6cf76d6ef13c@linaro.org>
Date: Thu, 29 May 2025 11:41:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] plugins: Add register write API
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250523020344.1341179-1-rowanbhart@gmail.com>
 <20250523020344.1341179-3-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250523020344.1341179-3-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/22/25 7:03 PM, Rowan Hart wrote:
> From: novafacing <rowanbhart@gmail.com>
> 
> This patch adds a function to the plugins API to allow plugins to write
> register contents. It also moves the qemu_plugin_read_register function
> so all the register-related functions are grouped together in the file.
> 
> Signed-off-by: novafacing <rowanbhart@gmail.com>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   include/qemu/qemu-plugin.h | 54 ++++++++++++++++++++++++++------------
>   plugins/api.c              | 22 +++++++++++-----
>   2 files changed, 52 insertions(+), 24 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


