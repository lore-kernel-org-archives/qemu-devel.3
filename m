Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A98C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 16:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU7xs-0002xe-II; Sun, 28 Jan 2024 11:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rU7xq-0002sU-El
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 11:24:59 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rU7xo-0002ZX-Qk
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 11:24:58 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a3536102785so121644766b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 08:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706459095; x=1707063895; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Xwfi9S3Qw0IVHmPKpn7kNNxSX7NnQkZL0rvvY5qyl8=;
 b=nUQQDdQlbxc1jgu6iTSRt52sDxU0Z3IXvXvB9crDXP/WcZMW0i+07PkwdTBy5FbN5/
 qrnxWm5FEEy1HATqLozoeyjOonX2zIK/zuHoJ8AJq3X7MHfv1eMBgQ+bR8yTKIjgng77
 IFcmvpvnRKIwVSya7fm2ei+4Y/Xdpxw8fvWEQSzbJ4k3ONB8jUBtCQD857GK+C82IiuJ
 F0+Dpx1F9bmXZ+ZZWv68otb9bWfmLwVgRnWHdy6nTAnMiV505i12QRKyJhX2Ur5dIKbG
 7U1gDaTtPWdjIVGs/goiGB5WlZHbVUih7PvqZkuc9oWIw4I39I6sRJPbw+RqAj6ZbA1n
 i1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706459095; x=1707063895;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Xwfi9S3Qw0IVHmPKpn7kNNxSX7NnQkZL0rvvY5qyl8=;
 b=O5Sp66WN6ni9D5sqPI3iB9F9TdLzSGzuKsFmjHReFkgsdvz2cJwLwK0vaZNypho9i5
 gGw/JaNmWP21WK1N+FeNAeyKk1d25mEGzgtox7iDeC5y9pwFkNgO1JxC9Bb6T/Qvty6Q
 9ZR82h3IiW7Gqex4JjXUlBpofh51lpMWcrFj9wF3ouSCKFkq+nyKm97b818gOy6wSq1J
 TTvxU5zpzp0MzFbWlcqcBniMsZmscN+5wjU05DR5y7IoqN5uVRttjunFoTPasTgl6ziJ
 wcPwHnzYopkX5+IL2eIDzFLOBXdElVvWWgcADQqqEOPcqLC6XrizEsEbVUGkVPQbjIw4
 aY0w==
X-Gm-Message-State: AOJu0Yz52JMUcp9MAbki8ZanYhzYJMVurLbmEJNU6G75+HjnI/KmAvF4
 auX9sYRnSxtuYDgFAdcWQwdnwTemv0LFQbqEqbSujbRDFtpEtzaDJH7OnGxmgp4=
X-Google-Smtp-Source: AGHT+IHN3Oc/zi5LcVN8Okm4vQ6c8M6XkyphVvQ6FdLFU9tARPbPGJyWRxx9S0Jai6RITu2YEh732A==
X-Received: by 2002:a17:906:747:b0:a35:a87c:b842 with SMTP id
 z7-20020a170906074700b00a35a87cb842mr611779ejb.57.1706459095305; 
 Sun, 28 Jan 2024 08:24:55 -0800 (PST)
Received: from [192.168.69.100] (sev93-h02-176-184-17-196.dsl.sta.abo.bbox.fr.
 [176.184.17.196]) by smtp.gmail.com with ESMTPSA id
 sf5-20020a1709078a8500b00a3543718f5bsm1814789ejc.221.2024.01.28.08.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 08:24:54 -0800 (PST)
Message-ID: <72f81688-0416-4f09-bcb8-1d85ac373906@linaro.org>
Date: Sun, 28 Jan 2024 17:24:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/33] include/qemu: Add TCGCPUOps typedef to typedefs.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240128044213.316480-1-richard.henderson@linaro.org>
 <20240128044213.316480-27-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240128044213.316480-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28/1/24 05:42, Richard Henderson wrote:
> QEMU coding style recommends using structure typedefs.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h      | 5 +----
>   include/qemu/typedefs.h    | 1 +
>   bsd-user/signal.c          | 4 ++--
>   linux-user/signal.c        | 4 ++--
>   target/alpha/cpu.c         | 2 +-
>   target/arm/cpu.c           | 2 +-
>   target/arm/tcg/cpu32.c     | 2 +-
>   target/avr/cpu.c           | 2 +-
>   target/cris/cpu.c          | 4 ++--
>   target/hexagon/cpu.c       | 2 +-
>   target/hppa/cpu.c          | 2 +-
>   target/i386/tcg/tcg-cpu.c  | 2 +-
>   target/loongarch/cpu.c     | 2 +-
>   target/m68k/cpu.c          | 2 +-
>   target/microblaze/cpu.c    | 2 +-
>   target/mips/cpu.c          | 2 +-
>   target/nios2/cpu.c         | 2 +-
>   target/openrisc/cpu.c      | 2 +-
>   target/ppc/cpu_init.c      | 2 +-
>   target/riscv/tcg/tcg-cpu.c | 2 +-
>   target/rx/cpu.c            | 2 +-
>   target/s390x/cpu.c         | 2 +-
>   target/sh4/cpu.c           | 2 +-
>   target/sparc/cpu.c         | 2 +-
>   target/tricore/cpu.c       | 2 +-
>   target/xtensa/cpu.c        | 2 +-
>   26 files changed, 29 insertions(+), 31 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


