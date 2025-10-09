Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11365CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6u9D-0007NA-BU; Thu, 09 Oct 2025 13:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6u9A-0007Mz-96
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:09:44 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6u95-0000Jz-HV
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 13:09:43 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7810289cd4bso1181908b3a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760029777; x=1760634577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DoffVoqYISbUn43ZQHNi3DaYL8UJEHhYA3TgwaLHblc=;
 b=RVD397jtDRvm/73rwQFVIKiwqVkxZCIUkkxNI5EDcRFiCEofQU/dTApNNWPhBpD3OQ
 iAxjH1Crz/8NF2v1kT2hmEQoK2/eC4VZQjlZRvOMRxHnkor4WIj4GWVI7f1Smm1aweXl
 sHe4mgzXv4ASgihWyxBr/m7DnXqrzTjL91AWXhmzoPIiRyJ+SzEgUMMXtK91fZG5AQQa
 9v8npc/zYMviz7kK1XiWZPEv4xxwQOtpdlsj5i/BFdZyo4ax7r14+trun2xCcp2pgCLM
 OS2loYVMd7Zrm7HLEsunnKS95tjdo56DGG9Ij4fZvsgRuD40CfiOp2ijQSDULFcz/1as
 kWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760029777; x=1760634577;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DoffVoqYISbUn43ZQHNi3DaYL8UJEHhYA3TgwaLHblc=;
 b=cF11ud1MNZNQt53kohNa18XWxXsKvI/yMD8lMCqbIVFAep/NmuDFnuHjw9ktyrLtpZ
 wup3im6CljoKYBwMm1oHoigUBJPY2nD3UeFaKakl6E3w+WThorlxfwHHfacbvztGSYmY
 rXO0J3IdPrFnWPpVKg4+9H1Uj05xswlWgaWUY7BDkBq/47Za3Ex0wJmfwYqqnmRWBhWQ
 ICm8fXYGrRJIM1sh0aWoLBJ6w6jeWaDMONw50v7SA4yFw9J6IjhaF6UfBbgpRxLhdEnd
 JNumCFIi6fjUwNG0a3lsFWhekBYhSHe/XoN7ZghY43ndT3sIAC/yec3jHtjU+XTBiC5o
 Mcjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuyjyKR+hbN2AlseQYPLxMWZkhOagmsoojodwlUY9Dy4VCgcPeKf8pzgf6V7IBJ3Ijm+ZNECZoRoDH@nongnu.org
X-Gm-Message-State: AOJu0YyInND90KKyztkW4LmN/CpsnLsZU3RuIxpVQXZEPjX5ioR32TxD
 +325KxhDQk71cAyOf6Hli7arokBpMAbR4fUM4ROA3EfY8uD0IUfYjZ/BTfwsF68HlAk=
X-Gm-Gg: ASbGncscPNBmeZimlJDjoeSrUuMevRVOR34nTHvvQghSuNfuTAL5MXu6SNlPhYGLj1/
 gQoj06hx9jrjeayxMaZcCQoG/MtNPC8ziI2Gf537Mj0cqd9RSAQwfu5wV1ODb0w4jpNHNaHhzAR
 bpUjhMfSCR22NIhox2/Vm/z4Y71mSnIfmax/gMXoefPA2/dS5/YpZt8aQkBTG0JRLCPKbfaNAU4
 /Afc144tp1jECjeacKMhf+udtSHsdJESE3fmv7hBeD0od6fQ8gJ95moems66czfsHRwaZgFXJgd
 5KyXLLKknwwvND1cihleIOdVOFs7pMXISiS+BC2uo8WjFBdy/nuQmoKhOO+wXTR5Y4dRQDl7iDb
 zOhPZvjjXQknoeqPyBIhNdRqxHs4L1L3XrWDfd9RE86T/BlDyuYw/G0EVDMLQvUP/+qjPANrLLo
 U=
X-Google-Smtp-Source: AGHT+IGMN14Br8FtxztLTitzyyywQ/In2ahFqlBIIXBKXT3wEp41Q+je+Szpvsp9Rs+xl6cnlTn6FA==
X-Received: by 2002:a05:6a00:4f86:b0:77f:4306:d248 with SMTP id
 d2e1a72fcca58-793876373b8mr8965155b3a.22.1760029776602; 
 Thu, 09 Oct 2025 10:09:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bb19a14sm267945b3a.28.2025.10.09.10.09.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 10:09:36 -0700 (PDT)
Message-ID: <20e09526-0363-48c2-b701-217d8ad87880@linaro.org>
Date: Thu, 9 Oct 2025 10:09:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] hw/hppa: Factor QOM HPPA_COMMON_MACHINE out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>
References: <20251009143106.22724-1-philmd@linaro.org>
 <20251009143106.22724-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009143106.22724-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 10/9/25 07:31, Philippe Mathieu-Daudé wrote:
> B160L and C3700 share a lot of common code. Factor it out
> as an abstract HPPA_COMMON_MACHINE QOM parent.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/hppa/machine.c | 61 +++++++++++++++++++++++++----------------------
>   1 file changed, 33 insertions(+), 28 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

