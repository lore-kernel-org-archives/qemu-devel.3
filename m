Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBFAC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 21:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTq6l-00039Q-1T; Tue, 16 Jul 2024 17:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTq6j-00037v-Hx
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 17:53:13 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sTq6i-0005RB-19
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 17:53:13 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-75c3afd7a50so3875078a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721166789; x=1721771589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g2FmxzMZcv/MEEdbkenuOaQhj+vVp0e+S9+LfJvTfVg=;
 b=cXQh+JRWmnrZQVqXLF+LlAHOyA1Ylz1WkprITf0Jz2gI/Ou0b4EWxt8eYDInYYl1XI
 xabaxTYrPCW4OaqTNH2OYZ9ZAcqAgg1wmNV9bbW61W8xrn4r7sgeK/mvPfKnptBcV0pT
 2molNv7c1S1tM1/b7A0R9U4yhaVpqHPTztn6tFjRWUV7ld+02gYzzc+o+7wYTIjSHhDf
 HCcxUITfqWd0qdH+YRlHQBTCj2hPzFlr/dGiTZMtLddATPBec9w2lsVc69jkVVs1u5Ul
 GPgAL/O+KNP3Fq9MhF+4P7nB54LnwWSclIxPwFredEz74NPrdqUlsXSPhVgSOo+jS8eH
 0Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721166789; x=1721771589;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g2FmxzMZcv/MEEdbkenuOaQhj+vVp0e+S9+LfJvTfVg=;
 b=S8hf8/eYLPv/ikf2ZBYMdT1jc2/2gzyPQlMnzeX/MkfUOSy26TI66L7L8ZJ8tcbCxC
 nQDbABXnkUGKmbfj8NQmV7Ol4/0thU4TaTE1V4XPqhgHC2Am0TxmPrC1BNiRp0SsPob/
 cUnqxqfQijIWHYsVw+g0b0LuYSvx5KmL6t2oze5nxLcHgj17uriQGkECrX6yQxdRnuW0
 skmJgjwgi1ZpjUZzVp+JC0hAGc/XaSNVLGteCu8QufAv5puzYY5ei3SYfej/Y6zomiFN
 iQDrSa3QXE0bT7pxM7qrugdWmLSpcOWOHPGWw+RuOzUv/BsZxOAj5d9DWtNQlQbyX/Kq
 uArw==
X-Gm-Message-State: AOJu0YwmqGCqC6GKsk3RfB5F0bzkfnp2Dn8l4ZUYjnsLwAfkQeCyScI7
 aSesy3179alxuH3xuv/ZSQ7Vg/XMWInlM6W6C/dG7nAS6RZzegatZzJfnQmvpXAzWFbcMB/B4Ny
 6JuM8Hw==
X-Google-Smtp-Source: AGHT+IHOqGxByi8tMVBeOQFEu+eGjhs9FGSfoSnODzpQBKeGWSUx+aXqyKTLbDRKZDbN2EHjzmTuBg==
X-Received: by 2002:a05:6a21:9206:b0:1c2:8d2f:65f4 with SMTP id
 adf61e73a8af0-1c3f1272a98mr3575819637.44.1721166789421; 
 Tue, 16 Jul 2024 14:53:09 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cacd2d05afsm8951057a91.9.2024.07.16.14.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 14:53:08 -0700 (PDT)
Message-ID: <afa432f7-ed06-4074-8849-796984be0bc5@linaro.org>
Date: Wed, 17 Jul 2024 07:53:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] gdbstub: Re-factor gdb command extensions
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20240716114229.329355-1-alex.bennee@linaro.org>
 <b9b178fc-04f5-49a6-992a-f6920408b41f@linaro.org>
 <87cyndgtui.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87cyndgtui.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/17/24 02:55, Alex Bennée wrote:
>> Are you expecting the same GdbCmdParseEntry object to be registered
>> multiple times?  Can we fix that at a higher level?
> 
> Its basically a hack to deal with the fact everything is tied to the
> CPUObject so we register everything multiple times. We could do a if
> (!registerd) register() dance but I guess I'm thinking forward to a
> hydrogenous future but I guess we'd need to do more work then anyway.

Any chance we could move it all to the CPUClass?


r~

