Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577E7606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pv1PYX0e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTmhl-0004nu-Jm; Wed, 18 Nov 2026 15:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTmhi-0004ne-6G
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 15:56:30 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTmhf-0004YH-M2
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 15:56:29 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-ccca948203aso1068617a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795035385; x=1795640185; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XmGFjFzrImTf3tFEhRU+xGBjTALW6SZx0jAywIDBWeA=;
 b=Pv1PYX0ePhJJLHJ8IR1fhyHukZ/sbo+8jb0chlJIhlsVmbxVHkllVOrnJKmoslV/Hl
 B+842DrQxVJ5NutOSdoI0GqmeTS8fInrXWeBupw/BhbKpmYdMqvFmy9WCQcKQ8C1hN27
 dquz6eBiuyET6/kiuz74agK5e5T1P9idJbeKttZ+sr5/1kTUpCdpFbgzepUNDjJbXPgm
 ASSFyLD4EXB3uq3v8xkjGgSoNFWf0DHSbpgL7W7p/fj6fCJXNEgmAZOym+RdqxsQJDzw
 nQHE27erKQxBurVZsj1QrUBsUfU0fiE3lV9HS1tHRw0nw5AAY4ZunsUTWo7ZXabUfmJz
 55dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795035385; x=1795640185;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XmGFjFzrImTf3tFEhRU+xGBjTALW6SZx0jAywIDBWeA=;
 b=XJV5xRZwszr/8zo41nq3h80gaRLluMfRRkKv2TqKlLFX8Uacwz5QZRwJaYStHZpjce
 aUQP9Vkp5s+s81t1OXheC+b6ozbKKbbK0p9OR5RuGIOGsRrpoXxsMU4jUYO7IHhNi+Hs
 iwij+mbtlPWgZy/reAMjKXaK14PsAQ+Bl1JddXIbzz2y2NDwMFHwWsiacVg9oqhfgOY8
 5h7BkUtoFGYzMCvpWE15tarQE7rM8HE71E6iOe/RO7yy83BYyjiriCGhpJzpAy12PtQi
 19sMNQ28XN6egavqw7YHuXWdIJc3l+H7nfpo6yv1dv1wlhhYUnnHm6Unb22Ap9kJPIdc
 YRwg==
X-Forwarded-Encrypted: i=1;
 AL+hErHVpkxf/pupnD5Ok7sUVFL9v4aaJajpYYq5SU8AJw1e9yAOXJ/PYmATC5peD/kLe5Xf4PGw71O8iz8X@nongnu.org
X-Gm-Message-State: APuU4Z++7AGY5ix/kEdjApxMOGnslqAQQVm71V3K9nITExtTgdg0rL0s
 2/+yiqLWUnMs9RPA8Z4MA3WPe61LSQn+RF+5JRCMdqIEoq6mOzTWDJ0TqYuEZy8f0Rw=
X-Gm-Gg: AZFdTZdqJ2NPAnnk6ivhnTC3nEi0LzIBM2C1xT6wolpfz+H3reC9NXtOweNnyXyg9Q/
 x7bT8mvBdFICHbSp33BFWcZrFwQUpy82EHeh81EjR5AX5A3rRZ3tLoAYZbCF/v6IQ52jkwInlWo
 XdqRxiGqat7vGkzr7mC0uiNwy0XlbBUKdHAyLIVOPKYjBRfTLnfuYjewFOG+p6zS5UHxIWCJwMg
 13yK9uSlA1+CtC7tyIeDG96wBP/jJ/XAZedgA+yjlHbYmxRqnKbHvIIUQT0CookJJPPHo0DPsUu
 thUjm5jzNX5+yRHEISc6RBOWKaWqLRx8Gt/EqJa4KdGmdLsOkQ9hUfzGrB7bqA20z8j80Q8/VK1
 /xm8pHl7NCzWw7Hc7tgU6lQSyvfwNlNdOf0jz7tPAlvZiJZp04scsA49Br4RUL3J/tVBR37TVSf
 f1KL3kMN/kbRO/Dv8lAP+YbdbWyrqNTcpZhV9J4Lsuk/KIaIPgLczUrZruMOm2bludC78J3uVMo
 lM6axWyTHoJO7i5aXrp5+rNGaOJVFPtBGJHT9RAOwxnIHgTTSAv+lEqYy3eolOvJmWaLNMa2cx8
 uZ1zxNNBkSu61RqNFjXiSeO1JAJWFuCij+qJyBISmw4QWo9/SHltL19cMQF9YtP2YAa3niE=
X-Received: by 2002:a17:90b:55c7:b0:3b0:ad59:7199 with SMTP id
 98e67ed59e1d1-3b3d07c653amr3207213a91.32.1795035384789; 
 Wed, 18 Nov 2026 12:56:24 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d556fcfdsm2437351a91.0.2026.11.18.12.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 12:56:23 -0800 (PST)
Message-ID: <efb007c1-9c4a-4e51-993b-4af521cb5010@linaro.org>
Date: Wed, 18 Nov 2026 12:56:22 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] i386, Rust for 2026-11-17
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20261118171838.38195-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261118171838.38195-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 09:18, Paolo Bonzini wrote:
> The following changes since commit 6883fb508cb7a93e2e7b44c0582bfd9fc2196d4d:
> 
>    Merge tag 'for-upstream' ofhttps://repo.or.cz/qemu/kevin into staging (2026-11-17 13:09:47 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 2b5920edfaff693acad867fe4a80149ea71d037b:
> 
>    build: Add "-d keeprsp" to Ninja flags (2026-11-18 09:04:46 +0100)
> 
> v1->v2: fix author of "treat ENTER's size operand as unsigned",
>          add final patch
> 
> ----------------------------------------------------------------
> * target/i386/kvm: fix latched INIT lost in kvm_put_vcpu_events()
> * target/i386/kvm: set VM ioctl KVM_SET_TSC_KHZ to maintain TSC synchronization
> * target/i386/tcg: fix CPUID checks for TZCNT and LZCNT
> * target/i386/tcg: reject VEX encodings of PBLENDVB, BLENDVPS and BLENDVPD
> * target/i386/tcg: fix SETCC(zu) optimization
> * target/i386/tcg: fix lea address calculation for CS register
> * target/i386/tcg: Fix 64-bit RSP truncation on far transfers
> * target/i386/tcg: all scalar instructions should be LIG
> * target/i386/tcg: treat ENTER's size operand as unsigned
> * target/i386/tcg: remove unused argument of decode_ops
> * target/i386/tcg: remove unused operand sizes
> * tests/tcg: fix load/restore for test-avx and test-mmx
> * rust: fix failure with nightly libstd

Applied, thanks.

r~

