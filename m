Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F93C6FD1F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 21:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnQFZ-0005hk-Qk; Thu, 21 Mar 2024 17:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnQFR-0005gf-8e
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:46:54 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rnQFO-00055s-3M
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 17:46:51 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so1050243a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711057608; x=1711662408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SmGgtiFOPzv4VrcvRrjl+Yo7UF6yFXdTiOHgu1RPmUA=;
 b=qXHBln7XrEQ0r9LGm+wY1b8iHR+k0pK7QQSld/qgvImVYQrg5jGfXGT3aEPjuPMeR1
 rx0ibgqFtnxvoEc6963U7Ol+EiXRG2dIedJ9sdOL+L3zfS/5v/jMo3vQcbOGkSWDQ5T6
 KDES55TCCnlo9yK+dQE6wzu7RK9GnWz/1ylQzbRzCCHzM26rA620sEbEBzy6VWjbl3Lb
 zRWVhYXvkqbk98OaqxABuaaxnlxzpgTFu0DwNMhmBx291PDafO3gwX+z+CHaJJrXUqn8
 WnjXuotY15/zqAeIjNtz3nKocFmZW8xlNIiNJUYuCzmJAqEA5i4DE/Bkg73lsHOMzB3J
 qdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711057608; x=1711662408;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SmGgtiFOPzv4VrcvRrjl+Yo7UF6yFXdTiOHgu1RPmUA=;
 b=WhICrYvlcViRMsn3dVIFTL3beusOAxcrKU3yQ8LPQ0gepH+B5Ulfq+S97EcamSHQNC
 rSHS3CHcA6vVOSS/GwWbR3XRz0NGpUS6xMD183u17M1PwmQ/aSFpEp63md+GAbTkiPaT
 sN4OgNjzz34CqPdQDk4OFD+IGGLAQCbrusnsMIMOTb0O5TijzUu1Rvk5mYKqCDqcwpy7
 LAzG3dWlgVzKoh/239ky5I+i2WiCTDt3TBlGMTzzkSsNh2uUJrRN5VGyBGiunX7xrbJU
 H4cLmbmZgcDdrNifc+b79QQ4M+VkNGWlI8i/2NY927AAw80sEqCGUlggO35UIXhTJhD/
 UMCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/I7JYkqRd9222pENO4OUQSg0wz88X3MmbcyrcYul4zDaA02pNCmVlEX7OzXEDQlR4NzZkqqiRqIzHBsQDrUVr7x7WuBc=
X-Gm-Message-State: AOJu0YzOJm1czgo+kAv8wOyz3bOsOfKur/QDo1NDSwg2MonKEbr8bT+q
 c58694auyuVL3DAYgBbBu9lDBotkN7gRyAjzcKMjcSlQHgZ71yf4jRVwCsPg7kM=
X-Google-Smtp-Source: AGHT+IF8c4T9qYPteYc8W/KiA2VGVx4EAwErBsf28p/dZMa9URrNa8bErO36OThtK1I0M9VCI1SlIA==
X-Received: by 2002:a17:90a:c292:b0:2a0:298:536 with SMTP id
 f18-20020a17090ac29200b002a002980536mr358159pjt.19.1711057608527; 
 Thu, 21 Mar 2024 14:46:48 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 oh11-20020a17090b3a4b00b002a01802565bsm418625pjb.57.2024.03.21.14.46.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 14:46:47 -0700 (PDT)
Message-ID: <99060282-06cb-4865-bf9d-ca67bbb38327@linaro.org>
Date: Thu, 21 Mar 2024 11:46:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 04/21] target/i386: Extract x86_dump_mmu() from
 hmp_info_tlb()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240321154838.95771-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 3/21/24 05:48, Philippe Mathieu-Daudé wrote:
> hmp_info_tlb() is specific to tcg/system, move it to
> target/i386/tcg/sysemu/hmp-cmds.c, along with the functions
> it depend on (except addr_canonical() which is exposed in
> "cpu.h").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/i386/cpu.h       |   7 ++
>   target/i386/mmu.c       | 231 ++++++++++++++++++++++++++++++++++++++++
>   target/i386/monitor.c   | 215 -------------------------------------
>   target/i386/meson.build |   1 +
>   4 files changed, 239 insertions(+), 215 deletions(-)
>   create mode 100644 target/i386/mmu.c

Patch commit message appears to be out of date wrt filename.
Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

