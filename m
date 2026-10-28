Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E4606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Uved+MGp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM57m-0001iX-3l; Wed, 28 Oct 2026 10:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM57Y-0001hT-2p
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:59:20 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM57W-0007C2-34
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:59:19 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-53fdd2fb171so10661551cf.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793199556; x=1793804356; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CGerE4t8RUO21kzwaf3o043dQESd6MmeJKx23Ahqj6w=;
 b=Uved+MGpeemEz5IgbxK1jnmEfmxGRUEanTBTZ756mS93pQPbZOADLCZx+1QhXGBrPe
 BDNsoSLGNHq/qUg3lo7Ah/7KWpMV6uCDLNnphkhwhCHjAdV4smyAOyOj8pDCS2FT6pFo
 R9YfeA1evyNuPdIS4Y8fi7QgY+UairAI5LqisnGd1v6SeqmgrjO6wV4ZPfxlJtnDyevT
 941XJQUXA6M8xfrk+zy27vhGX4wbBKbbxO0z7P2MlwzFR8qsdw8oaAInFXLDsZQ2QJ1p
 YaVawGv9OmCYNHQXkLdvOdp/O2XDQ+Fx6ZB/g6Dr6NHfHlvPY9Q2GgdEdIdbn11BUBhe
 raiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793199556; x=1793804356;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CGerE4t8RUO21kzwaf3o043dQESd6MmeJKx23Ahqj6w=;
 b=VfjJoYDE3PdUdeR9BARobEhsNU0zMhg8iJ0TK4QOqsUI8pmEft0jAi6ouKvuZINvCT
 b91oKfeTQ4g2GhwRgkpJ+vIvYUK2JdELB0qYpvvFeFyy+xMRpLUIE3BXYltPo/vX+9e8
 Mjdf7c2yMFjhKTwmsKcgmDm51Dpnt5UsnGwbWncoAWopsncgfd+rhXvj/8ZGEA5o0DvJ
 uPiM3WxqagnH2yNNinxROouCPU+MgGJhLGOTqwSUMelp2A4CAKbODna/Kw+ti/A6eeZI
 m8S/c3A3KTNnLEJ7Nq4kzC4F4tCt7Gsou52RFN2YuliGUiDJjeBx/u2TA/AF3TrYPvGw
 lLyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxa6w7oUXx97hlsHZOBzPHMsY+w08xB0kDzYhYIDC8ngjUe8BHQk05knYPm3Y1wMZ73C2pdGOseyReL@nongnu.org
X-Gm-Message-State: AFq9FYJkm19HPUSb5jX6mQBB9gO7OCrsSpzRqLDVjK3Z5dFYhjXin34G
 KHjE2DBYxiNgAJBU0PumlS6FeVJ2SOiDXd16kHFi7EecEwUsqIFEfMy6H9k+gFPm3fzsuJLeFQF
 CC+VU
X-Gm-Gg: AYBFou1t7FgB+9OlT9ACugs75QLiaBSyz0h40mif2GRmv/0F4uiNXBz7sCjv/vDvye+
 dxHYsaeB6wmMmMSATWw0BZ5FJAwHmZfmyI66wSFkTOytT+GnKvN0iy3qhGZ1pXf7wysFDjOSJcY
 QllCegualXHTIJrGOzdaUu7lQwbMxYV4nWWntz9ZT21WCxchC7+LtXyQN+9eTAWTI+cDhO25Tdp
 h6earw7yKYNgVQQPIRqjykUlG+0fHu1rqrwnMJMqTIPki04rNSpCbPLdSMiGJuDu9rV83RBXQHe
 gAKOanYgDgcmnz+fbxELbtGh5mlqowzoNwIuFz1lpttdfSrxAbWbwctaBQn/7BR6I8kA6mTsgsL
 kyG45AYdou4zfz8XeM20nSPa7Mk32Arm5IA30ZcgyfDenz00DO49yQIqOsxOqZUis3vLkalbPoj
 qstkKrMTorPOWdtH24khpUEj7HCOxU/a1yo+P4N70GKt6BmBVLX/RAbRgxkOsulOdvV6ts1yakJ
 vi7G5NCPHhdL6dkB7RbElWckVTsqwptBwnn0EVZ6JmKzL2wG8MQ57Y1kzn/cmViLc9pqxsSdyfL
 +HEstxhkkgvimJWU1n2mX4Yz/m7uf+YnwSkFhw9TyCJt2NZFZgCXOO1oiukRpbZOIlXi4QDRFqU
 SEaQqIo+JehY=
X-Received: by 2002:ac8:5d47:0:b0:535:e8c:4258 with SMTP id
 d75a77b69052e-53fcc7ca90fmr41526801cf.54.1793199555462; 
 Wed, 28 Oct 2026 07:59:15 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6?
 ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53838458772sm107523751cf.0.2026.10.28.07.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 07:59:15 -0700 (PDT)
Message-ID: <790dada1-170c-4f53-b7d6-f8befe076c8f@linaro.org>
Date: Wed, 28 Oct 2026 09:59:12 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/59] Misc HW patches for 2026-10-27
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261028083958.75340-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028083958.75340-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x835.google.com
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

On 10/28/26 03:39, Philippe Mathieu-Daudé wrote:
> v2: Do not remove deprecated 'debug-threads' option
> 
> The following changes since commit 29b1dc631d6ac6bfc39464e0be8bf4cad556a591:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2026-10-27 20:02:57 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20261027
> 
> for you to fetch changes up to 8930d9cca2f830565da6483128414f9a38e4d8d8:
> 
>    qemu/arch-defs: increase width of QEMU_ARCH_* masks enums to be 64 bits (2026-10-28 09:25:48 +0100)
> 
> Ignoring:
> 
>    ERROR: line over 90 characters
>    #39: FILE: scripts/checkpatch.pl:1892:
>    +				my $tag_space = not ($line =~ /^\s*fixes:? [0-9a-f]{5,40}/i);
> 
> and:
> 
>    tcg/sparc64/tcg-target.c.inc: In function 'tcg_out_movi_int':
>    tcg/sparc64/tcg-target.c.inc:477:24: error: argument 2 null where non-null expected [-Werror=nonnull]
>      477 |                        tcg_tbrel_diff(s, NULL));
>          |                        ^~~~~~~~~~~~~~
>    In file included from include/tcg/tcg-op-common.h:11,
>                     from ../tcg/tcg.c:41:
>    include/tcg/tcg.h:913:25: note: in a call to function 'tcg_tbrel_diff' declared 'nonnull'
>      913 | static inline ptrdiff_t tcg_tbrel_diff(TCGContext *s, const void *target)
>          |                         ^~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> ----------------------------------------------------------------
> Misc HW patches
> 
> - Don't complain about spaces before 'Fixes' tags in scripts/checkpatch.pl
> - Various fixes (SD card, i.MX, SH4 UART, CAN, PCIe, ...)
> - Widen QEMU_ARCH_* and arch_bitmask to 64-bit
> - MAINTAINERS updates

Applied, thanks.

r~

