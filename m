Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0E1C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 16:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s41Nb-0000Io-Ol; Mon, 06 May 2024 12:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s41Na-0000I6-48
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:39:54 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s41NY-0008IT-IY
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:39:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ec92e355bfso20727805ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715013591; x=1715618391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jvnVAbnXzuJHvIOJlzEHd0kPbXYUykCHcitaMD1jS8g=;
 b=AxtK5YQnjd2sDH5RrEMul46fW+CtBT0jdepAzRJ7U7f/2MVHSEcWIuDrwL3dfQYI5X
 zBI7OOe71azknbJguxzGe/yF5Z3aIkdBmoP4IYKTSPVQxhB0hpixtrnFik7c6tnOPW53
 UGj5m7e2IK4ZuBVed9UsIDKhJo0Ol08UuJ2wfZdEtvO1Jnp6E55mtv4jLwdIlz2DXGIb
 nouG3n6Cg7xKu54YZe8u80ya0S5e9w6CLhk6buawV1SScCB8iHTFB0uxV14F9YB/4ioZ
 Y9rJjheEo3zuW9rsz2gfNrlZ32KaahIp+Q70ab+vzhNzPqRlpHGluWhuF7BiTI5dAZSC
 ozDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715013591; x=1715618391;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jvnVAbnXzuJHvIOJlzEHd0kPbXYUykCHcitaMD1jS8g=;
 b=OC9IJoMM3DED5XpwKUu8qWiM5C5dZ1YKlNfJPwapSS5aEqZG2iM6rSwiATnXJUkfj3
 VKjy7iLmudD2C4pGOH1gJleKxoZqsPgSDEuFaGFHMzDRrA4nIZTMLBGCX323I3qWJj2B
 D9DHT/Y/Ov/fVCyphlihbhgsu3VigOzG0TqiwAd42lrJE1fsfpwq3SIt06pR40uynH99
 K7FpOxzyU8jUoxXPSoGcKRbybXNHwhtR8DPIB/q8iHu2cNQ+Nn6tuG3wcCN/0lK364n/
 4No5Ehc+aqZj0l2HyI3yimhHExy8Q8jnKx7x8yHvooD42x/LzRZDvl+HbDNAp7wwzp1c
 i14A==
X-Gm-Message-State: AOJu0YyInNl89T/UfR0G+G9pokfwIyAuD/Gpt4N/jg31r5/UEqKuZqwi
 ERBPal+KSeiE53x97XAlX6W/5kbGfRD7gWWRxyrTSUAq6Tq9fLl0vZOqNI/C3Dg=
X-Google-Smtp-Source: AGHT+IE/DhV980tWJCSEBuPSw/t57xJNflHfhdd9tfIdAXXyszhSTl7L5Jnawzus+Fj2mVrBCEJDZQ==
X-Received: by 2002:a17:902:dace:b0:1e6:114c:2e54 with SMTP id
 q14-20020a170902dace00b001e6114c2e54mr13626047plx.69.1715013590973; 
 Mon, 06 May 2024 09:39:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a170902780300b001ed2d84c1cbsm7028460pll.193.2024.05.06.09.39.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 09:39:50 -0700 (PDT)
Message-ID: <80b692cb-cce0-4477-aa98-c3db5642386b@linaro.org>
Date: Mon, 6 May 2024 09:39:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/25] target/i386: cleanup cc_op changes for
 REP/REPZ/REPNZ
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, zhao1.liu@intel.com
References: <20240506080957.10005-1-pbonzini@redhat.com>
 <20240506080957.10005-6-pbonzini@redhat.com>
 <e1019e1e-3678-4882-9cfb-f4747d80b9a3@linaro.org>
 <CABgObfbDg99rNDQcBD2HZ3njkGmif2fQxRXFYqmwmGXXvXKa0A@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfbDg99rNDQcBD2HZ3njkGmif2fQxRXFYqmwmGXXvXKa0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 5/6/24 09:31, Paolo Bonzini wrote:
> The comment deals with the former, the removal with the latter.
> 
> The idea of the comment is that after SCAS/CMPS you have CC_OP_SUB*,
> so in principle you may expect that you need to set CC_OP_DYNAMIC
> explicitly at the end of a REPZ/REPNZ, which is where the CX != 0 and
> CX == 0 paths join. But this is not necessary, because there is
> nothing after that instruction - the translation block ends.
> 
> So I guess the comment could instead be placed at the end of the function?
> 
>      /*
>       * Only one iteration is done at a time, so the translation
>       * block has ended unconditionally at this point and there
>       * is no control flow junction - no need to set CC_OP_DYNAMIC.
>       */
> 
> What do you think?

Just before gen_jmp_rel_csize?  Yes, that seems good.


r~

