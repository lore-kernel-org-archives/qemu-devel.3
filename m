Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D834606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ihAWIFz6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8JE-0000ei-4R; Thu, 19 Nov 2026 15:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xU8JC-0000eW-D1
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:00:38 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xU8JA-0002Cp-OF
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:00:38 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3acb11973c3so280964a91.3
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 12:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795118435; x=1795723235; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YSh1wZCJ0ihE/KfatztxpZTZWNpkqHjK5ZBr9FAQ8+w=;
 b=ihAWIFz6/wHzvTQfQog9UGb4QBiVLWeI7mz/k1dQCP+CDLKxnuy2YM/7x0cMSF3l04
 PsjrVqMVTb1YS9vllNCK99mnb3dpQwG4eNuKEcMx5KZ4rF9czFO6UB4ADaRLrEmk/qEP
 /crLAkLOsPYyZWn1+2RsbrQEvjcAc+yeN0maBQmyyrhf+Ht6YbiFWtl7iQ6tcOwdOG5m
 E4NonHyYQpYvQecy+gssQFUFskRosEZmueeVNvADR0bb+NYANBomMeDbHVssfqqmZm5U
 lCaXoooWiGsYjfrO/IfEN074FXFNIpobkBBv4WI5of2qzy3WwQb6jUTr7wIRsiG4blOn
 OreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795118435; x=1795723235;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YSh1wZCJ0ihE/KfatztxpZTZWNpkqHjK5ZBr9FAQ8+w=;
 b=N0Wm+/j6IslhZTJSHu7kQPK3TpHeTSniG7X+6/ourMhG0KmOsU/eOELBMmgwDWqVe3
 Cf3eHFSj883ql1PV0BW9oB8Ammvzta9ogAFROGqJhGBD9N42qa0TTHjSWCZNKrTyzjf2
 jUMY2ivf6kE8y/MkUF8gIhFWUJ6XhOzMCbB/PNEhl21eKt99iYwsd/zQKOBoNsT8kOln
 dvi1EI0nDkxgBFAhP36AhfBFSQoIdDs92c2OmaCXuRSDxJk8kHD3HkNSlRa94B974+HV
 gOztxTHMb2Tu/7ppIiC9Pxmtp5IgXFfTTTp74Bkz9pTihsWkJB/BzmzVbdcSCG/u0jWK
 gMrQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGK5AS5bFFOep7HXKmtrpVZGlVNOoLNAYqVpM4l2Tssr0JbtSbCQf12DbEskLrEHG1RDTl3SSfbN8HL@nongnu.org
X-Gm-Message-State: APuU4Z9DGeU36C0X4nuewiLhRoAnFd0I8SEZMQh5IlM8joIi47w7NO5F
 lbhfAga9c0JgO5JKWyc8C0jKWLX/JfHbt7VW4z5x2CUiOtf+lyGIKy4tJNwkFpGAKh8=
X-Gm-Gg: AZFdTZe/atW7vaP3yy//BLCXLQtVnzEr3XSRT3kw/RGrNqKTaonIrdURUKfJVnQV+Zy
 35BJRzI50mI1REDg4Y5uhbHVT15Biz2R7xlPweCg3J5lkOItTwz9tWdPURwEw0waGZBoiCC96fr
 HOnqvdhvNz8c3SPC1qp3F23newczzzotWd8/2kQnpf5YwTz9viWE+ZKagPBm+vC7N1IZAfuPaaJ
 rX3mA57ojLG3ZcMFzxDV7aX8cgyP3G3d1JRHPhCcVcsRqjkgSD/xJFdeAM58TLRX34qsaRFDWlr
 MSRrohXjioum95f7D6Hd6ugPSRCNpgyRHKnryf31HgRAgqDZAwsZTio+ZQ0j1Ay0OkLB1kzFBHP
 SJPZPbRgRL34/Nb++VpPTSdwY8GIA2ommhV08Q7KlmHujO3p+/OA+JCr3Xc1A7LiA4pfx1eXuo8
 trzVm+pMUlsqoyo265ebje9GybQRuzS+u6B3VFjR8sqyWAqM5YdW16upS/97lP2oe4jtq+nruG+
 k3gDtu3/uaI1dB8G9uK9UJJ3oByw1oCCNm55tECOU2jILiVf8Utul8fNJGYQ2dtpKjQmogZu4Cm
 ZyotFPQe9LX0bbsS6T1z6RPGF1yExHDb0xh7nI96TVGpWrrTSQA0bxsQUgkOHA1f+4fkzhE=
X-Received: by 2002:a17:90a:ec86:b0:3b3:ab75:c940 with SMTP id
 98e67ed59e1d1-3b41c9b2ddamr337564a91.18.1795118430312; 
 Thu, 19 Nov 2026 12:00:30 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b40285cf3fsm2364174a91.4.2026.11.19.12.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 12:00:29 -0800 (PST)
Message-ID: <8d307445-55ec-43ba-8d39-f77fc98bfd48@linaro.org>
Date: Thu, 19 Nov 2026 12:00:28 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] host/include/loongarch64: Fix build with 128-bit LL/SC
 enabled
To: WANG Xuerui <i.qemu@xen0n.name>, qemu-devel@nongnu.org
Cc: WANG Xuerui <git@xen0n.name>, qemu-stable@nongnu.org
References: <20261105102924.1309687-1-i.qemu@xen0n.name>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261105102924.1309687-1-i.qemu@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 02:29, WANG Xuerui wrote:
> From: WANG Xuerui <git@xen0n.name>
> 
> LoongArch64 v1.1 has native 128-bit LL/SC capability through the
> `sc.q` instruction, and [GCC uses it since 16.1.0][1]. So for
> `-march=la64v1.1` (and equivalents such as `-march=la664` or just
> `-mscq`) configurations the following happens:
> 
> - `CONFIG_ATOMIC128` is set,
> - in `host/include/generic/host/atomic128-cas.h.inc`, `HAVE_CMPXCHG128`
>    is set to `1`,
> - in `accel/tcg/ldst_atomicity.c.inc`, code paths invoking
>    `store_atom_insert_al16` are enabled,
> - this errors out because of the explicit
>    `host/include/loongarch64/host/store-insert-al16.h.inc` override.
> 
> This doesn't affect `-march=la64v1.0` builds because the `atomic128`
> probe, when code-generated without `sc.q` support, correctly fails to
> link without libatomic.
> 
> Simply removing the override is enough to make QEMU build and run
> correctly on `sc.q`-enabled hosts. The override was introduced in 2023,
> in commit adc8467e697d ("host/include/loongarch64: Add atomic16 load
> and store"), when it was true that no existing LoongArch implementation
> could perform 128-bit LL/SC nor CAS at that time. It is no longer the
> case since LA664 with LoongArch64 v1.1.
> 
> [1]: https://github.com/gcc-mirror/gcc/blob/releases/gcc-16.1.0/gcc/config/loongarch/sync.md#L784
> 
> Cc: qemu-stable@nongnu.org
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Fixes: adc8467e697d ("host/include/loongarch64: Add atomic16 load and store")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4767
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>   .../include/loongarch64/host/store-insert-al16.h.inc | 12 ------------
>   1 file changed, 12 deletions(-)
>   delete mode 100644 host/include/loongarch64/host/store-insert-al16.h.inc

Thanks.

Depending on how quickly v1.1 becomes common, you might want to add 
cpuinfo detection for this.  But the most important thing in the short 
term is fixing the build error, so queued.


r~

