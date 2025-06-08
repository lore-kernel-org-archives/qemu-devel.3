Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A877BC5B543
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 00:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uO47u-00058y-35; Sat, 07 Jun 2025 20:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uO47t-00058q-4K
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 20:43:05 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uO47r-00005B-8Y
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 20:43:04 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso2909707b3a.2
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 17:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749343381; x=1749948181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7/kuxSFW0fFozybcFEj4uNFZs1Kif3vsTBAe1Okrpfs=;
 b=ZNo7U7rtIXNoJj7WVg+uYuT2D90nX0JDDIJ6UAmBpwnMNqUQtoW3J/H5TVjPFe9GZH
 TAnYrrbRaSQPpIFLPKUf59fN+9dHTTTLYN7kvZh6HtF74842016hga35xwwaChteqDOy
 gYTmRd/f6RgLx9g0vdVQ2BU5n2wSCmrIeUBtn3OZn4DzWbCkQU5Va716PUEz8kjg2d4X
 Pf5+h8eMLoGKx7ZpwZ/73AyYTOetipV4yTb40bUJeBODMikCDlb5ZoG6EFzxKoqYwiKe
 Uo6FT2+0lzvcbDsZWnl6oNoS7b13dSGVv41A2llKFFjJJKZXXefoSuakXIEnZ2wQaKoB
 OAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749343381; x=1749948181;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7/kuxSFW0fFozybcFEj4uNFZs1Kif3vsTBAe1Okrpfs=;
 b=fXxNbgZvuex+p/VWqxKaR6SJ6CLCnFMPmZqkJZpI3A+fHByRdlyCh/2tR0bvosU+0N
 dBiXme68tetHoxDbRQo/k/pmaUA0xfyAyX/mNcHTmMSyyIDoxTAAWLqC1h6jiA6rRJoK
 AO3alVs+CpI91NZ4muMfdztWnKHeT67CuJP4/i9yLdhrE4EUKNw/1CDeljvD/1cVzTOT
 LZNzpAM60bypFSNo3JenLnq7tdt9w+bwxbD3WhGHuuBu4I5mIAkmJW/AUFbTTj2JZ7xs
 2pJG8fBH7P2L86lmWcYFgBstY2qzAI4Py+fJeWXNWulYdF/pLwLEYEIXaEftXIv9mcb6
 /Z3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg5HIKxgQbgraYygSx5wvmOtS5/jSm/Ju7dvEk6HFAh01U1UaZQKE4BPMbr/sDt1sFkG531PT99OPR@nongnu.org
X-Gm-Message-State: AOJu0YxbML+AMsY5nfmjqzGSy0X7S7PCwGalrw9Z1T0BZPu4uhCk+lph
 SxX1BzwHLMemIzErzLeCsUDbtZIvJblwXqCmIV2pW3dwoHfgOYVDpMuDkMMsiFNgX70=
X-Gm-Gg: ASbGncvwQNy7W91c/OXIll46OSVyIbZtSKP5UHFaah8ch/qblmOiWYzjfUXxpZAEMYv
 ESQ/JAokCi8WE5QIFlEMS4QFlxV2uCrzfuYKh485dXc2+rb+QMgVBsOmieXSwR8LpGH1Bu/Ux5r
 8Lz3lKjtA64wgAa8roXnFbS/8dqpsYMbLo5c7GCF+BlHkfCFHpLdRse7A6P7vbVr5X4eC9+zq6e
 8Z/0xGMlAvSw4+Qayn5uUJVKYls0ITxtg2hQB2R54+7pQw51Dl8jLnm8RkgVS/wdy5n+3x9CTbH
 4tZdk+bs2phvjbNyUu0X/B36r3iUhzQd482NdFPQ1kKhg2bRSJUV2e1DqvhwPqRIXwMNzM29UUv
 zLLiYG6TT3A==
X-Google-Smtp-Source: AGHT+IFaFSTZf3vYXux2x+e2ISsReRv3Pe1uXc/oNaCpZouH3jAfnbTVTD0x1rCYoe/oBjzfbE3lHA==
X-Received: by 2002:a05:6a20:db0c:b0:215:e818:9fe5 with SMTP id
 adf61e73a8af0-21ee2500408mr11978948637.18.1749343380831; 
 Sat, 07 Jun 2025 17:43:00 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0c23f6sm3286660b3a.119.2025.06.07.17.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 17:43:00 -0700 (PDT)
Message-ID: <878ac7c5-6729-4930-a64f-19cf0e10f7f2@linaro.org>
Date: Sat, 7 Jun 2025 17:42:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3] meson: fix Windows build
Content-Language: en-US
To: oltolm <oleg.tolmatcev@gmail.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
References: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250607094503.1307-2-oleg.tolmatcev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/7/25 2:45 AM, oltolm wrote:
> Sorry, I forgot to cc the maintainers.
> 
> The build failed when run on Windows. I replaced calls to Unix programs
> like ´cat´, ´sed´ and ´true´ with calls to ´python´. I wrapped calls to
> ´os.path.relpath´ in try-except because it can fail when the two paths
> are on different drives. I made sure to convert the Windows paths to
> Unix paths to prevent warnings in generated files.
> 
> Signed-off-by: oltolm <oleg.tolmatcev@gmail.com>
> ---
>   contrib/plugins/meson.build         |  2 +-
>   plugins/meson.build                 |  2 +-
>   scripts/tracetool/__init__.py       | 15 ++++++++++++---
>   scripts/tracetool/backend/ftrace.py |  4 +---
>   scripts/tracetool/backend/log.py    |  4 +---
>   scripts/tracetool/backend/syslog.py |  4 +---
>   tests/functional/meson.build        |  4 +---
>   tests/include/meson.build           |  2 +-
>   tests/tcg/plugins/meson.build       |  2 +-
>   trace/meson.build                   |  5 +++--
>   10 files changed, 23 insertions(+), 21 deletions(-)

Are you building using msys2, or another environment on Windows? I'm
curious to know in which configuration the build is failing.

In case you use msys2, maybe you're simply missing some packages. Our
documentation explains what to install [1].
Building out of msys2 on Windows is not recommended, as this is the only
maintained setup (tested in our CI, and maintained as an msys2 package
by msys2 maintainers) for this system.

[1] https://www.qemu.org/docs/master/devel/build-environment.html

Regards,
Pierrick

