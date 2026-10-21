Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD615606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iixxuP9H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJRZ9-0007IY-GR; Wed, 21 Oct 2026 04:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJRZ7-0007IB-0c
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:20:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJRZ5-0007rQ-HH
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:20:52 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so2695855e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792570850; x=1793175650; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FSwcdvwS8IsZycANuGyZ4xB0O6pW//06JtIzIifqREM=;
 b=iixxuP9Hct/HYu1ZolxyF523g0boJetjq9VgomF29yxML0d+Us2BHw4qkFq3TgM4Z/
 wmuE7m585yaTge+rU2TYtduTbfnCZ+zM/T8JSCEqMlvxyMZm07I7g8ZTgGjP4JELVwyl
 0velvXR0MlDa0gnk9kZPf5PwIDGOhW242SJSET8ftzpZmBsNL08PU6Uf1Tu1G124B/BP
 o0pnz+enaArdmygnTJevsw7ouJAS0qh+rWIRH5zqhME2txnWwX+rWWDUSb2BW+tv+z6Y
 KV8ImJFj6+YLtTfdgYxmc5zYzVET3rLhN04FzZ1k9ZVSAnFkT3cFaJxWKrkAnFs8o9S7
 +lAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792570850; x=1793175650;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FSwcdvwS8IsZycANuGyZ4xB0O6pW//06JtIzIifqREM=;
 b=Ot8dbz9FYrOpVh0+HX1JBOtdTLPGmwdW/0uI7mChBixjzIhGghjtqAE3SWcVhK75cd
 Oa4ZGvwh3SCHQ0JaupZnGiny0QATqMnSK9VoQtHkQsZEWiMAqQwVBxk3iYim+CZIiSbm
 hNoLC1n3qGvozErgDSeNG8KdhGAHhW3wN6Wyr9FwhCLTa9EpZEC4Hu/68NEaykVlQhed
 ERNSOAW1MKIF+vbHzFDX7oqFHWLkMQJZsflCJIr1c0Ami6Yxj+6Qf4oNBKNLcqv1e5Vp
 PP89CJffCrZGKuKBT67Zhvt2/KsS1ri8F5pEfVQJHIl5t+pf3L4q+wzSEWz2eTSN26xq
 KNgw==
X-Gm-Message-State: AFq9FYIklDcpW+3/IowuAXobif6uJoSkIM7yznwKrP4E6Q3412MS1Q6z
 Ll2tkUshjro6nWk5Iqp/WyhADSIoIXfJ2ZYjVycbVDhwNpcXQIhd8po7Axkjc1W6saR3RE45J6e
 9I5W78s4=
X-Gm-Gg: AYBFou1wQZ5Zr+a5PkBJgtcMXVzf2BtqfTPozgv9bBj+Ljlzf8q9OMh2i50sJeI1oUp
 auI7C0k7l3jx6l2l0W2/hOvtvfEw6GwhAxJ8Rr613PMNLMEkt6Z0cLwdKYZLhecP/I+boAgrg2I
 LBrIdRNrZu+hOV241LHCGTMQJDMsAJatybJE9XzTdQ57TYhaKZtsvGXlQozSVmNEdTFmte4RFeB
 VdjyVFoIK9/GlQZLK/9TKZoRB7eA895+dyQg8GSMaibzpZanRAfGS5HTP+kHMn31e74kSXAbPn/
 /mw5pazavl7TqTcfHXBXlPDuMvuFJCM0ErYqJlxVFnRXLPXN7TNsgALOfr1LUyTDEwxvFRqMxNs
 NBvENsLQljCORCTAjE9vUPT84Pfo5YIHnwlbau31v8vp5KdtMIF1II6Gm50tvgYKISH0uvEY/IZ
 dOlW5HNMWgnG72gJEDkKRe88WicJCd1RTEhIi3sAG0FRgMQKaHfjOWTRNn7AhMnckZ4O+6pd0Uc
 +eIN6sYUf9v0oauSMADBX9RjnEXH7A9zXcKjUm3qGgc2aSpXauGPiY3ICaYprnjoX8Exy7y3/jS
 cjBwXeNLGW4mp9LNjPfL6J0xGvbwFMkDsfNkQFIAdd2cTzuY
X-Received: by 2002:a7b:cd92:0:b0:4a1:d487:2dc8 with SMTP id
 5b1f17b1804b1-4a1fdd23313mr18633665e9.18.1792570849671; 
 Wed, 21 Oct 2026 01:20:49 -0700 (PDT)
Received: from [192.168.2.121] (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb85915asm54946605e9.9.2026.10.21.01.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 01:20:49 -0700 (PDT)
Message-ID: <df0389e2-338c-4e4f-af53-9e7c68b9613a@linaro.org>
Date: Wed, 21 Oct 2026 10:20:47 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] target/i386/tcg: fix EIP truncation for wrapping
 16-bit near branches
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: paul@galbraiths.ca, pbonzini@redhat.com
References: <20260926235620.851099-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260926235620.851099-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 9/27/26 01:56, Richard Henderson wrote:
> Hi Paul, thanks for the testcase.
> 
> While your patch did fix the bug, it retained other surrounding
> buggy code that attempted to fix this but failed to do so.
> 
> 
> r~
> 
> 
> Paul Galbraith (1):
>    tests/tcg/i386: Add regression test for wrapping 16-bit near branches
> 
> Richard Henderson (2):
>    target/i386/tcg: Add DisasContext.pc_save_valid
>    target/i386/tcg: fix EIP truncation for wrapping near branches
> 
>   target/i386/tcg/translate.c                |  38 ++++----
>   tests/tcg/i386/system/meson.build          |   3 +-
>   tests/tcg/i386/system/test-branch-wrap16.S | 101 +++++++++++++++++++++
>   3 files changed, 124 insertions(+), 18 deletions(-)
>   create mode 100644 tests/tcg/i386/system/test-branch-wrap16.S
> 

Ping.


r~

