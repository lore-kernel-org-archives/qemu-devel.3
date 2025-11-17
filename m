Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8022BCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL39s-0002Xb-Jk; Mon, 17 Nov 2025 12:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL39U-0002P1-5V
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:36:45 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL39R-0003PZ-Fm
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:36:31 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b31c610fcso4059554f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763400988; x=1764005788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DY+d+C9qx6bWfSTFU7kH10XVOl5tPMSdURmrTpq6tao=;
 b=a3ZJ2lQ6cgMllr7cMetpGTm1OK2AqDWC+kt/UAQJRjiqg4uTpJkC75WdfmdE6z9kOk
 ynb4wVaioh+PZG+TYHvXLjQPkub/2+rB6GvyL4bm2nuuIJ0+WJUxVnvqI9r/iBr0CFGI
 fpZ0LcU5WQDJsN4kyXz8SMJ/lp908cOj6IJlri29G0ncjiMh8ty5C687iusCmf9wtGI8
 Uq7fHc8h8qyAeLSns7dH8rOOIsggn8Rq/NRhm8yRGrBUrAfA5Pt/Ql+zmLf7ZsKxhAHB
 tJ2266vxkiU9ZGfJHnJQCaU7JcVSSpvJDYHwNjZzCHRiHqBnC1o1STZGVmYpUmIb4kUe
 nTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763400988; x=1764005788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DY+d+C9qx6bWfSTFU7kH10XVOl5tPMSdURmrTpq6tao=;
 b=wR99IDMl9XqJuhW78QWj1pHPbRltJUP+uzhdlhaco0QtG0NqIi6vKTk212TdDn89t/
 nvxmjuGiUi9HHN8icLRNC3ECXEskPNcnzMSGrgZCsMYWKqTOF9nh9CJuyAqdMj6/g6Xi
 Jfqbc5Bl0Pp82AOUwsMkib6aBbZvjRrRSbyrNq4P98YRx+qmMp656308KmtBblmL//61
 lJwC2O91Jpfp7RjREIZt1FepfaKx9JJtdal/ffr9/VmiK3GCgALfOpVOWeAkmtfuTvsc
 xOTzeH8lWCzf6s/QDHSE6yE52eYfHcLmi6G3+C4vUG3eRcOshkHBV6RlcUu1bt1Ly7Lr
 zstQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzGwK5edPBLKCkQCjEA6qUOkxW2aJWnpmgywwCk1aSl7HjwZTTG5DJKLGuga0J8jj+sksTZbmLSsNP@nongnu.org
X-Gm-Message-State: AOJu0YxwQhnux5kABGvmrLKMzY34q/O7+OjP/Vb73uY9t3AoVKpGBb9u
 zcoI7SqbqPwAH7Lk3XSM9vGvouSN7xz7XYXxTie9/Q3qjfj6yMIy4rDE/6XepfUDK1o=
X-Gm-Gg: ASbGncsM5Rl/boixsNbPah9EJN2Pl6IRSA5c6Z9B2yaEeMY6tmQRib1S9op8fWJBRbH
 gBwPdOWUYT8F7vp8JpIaSPHB1uh42UCxxoGFtAKU3nIMoGr13ZDvhEShh8KVelCTYd/J39PlZx3
 zcz+waNtff0UMmFsr85a2/I/1FBvJqV8vwIXPeHEkQxy7m0c+k+1klhYalm6Gz92I8W7tzRnYER
 ETJ1APxAENo/9EYyDC8GVPA3cm1owq38WcGNJzHgqcTv57IAbzhjsRUfAelMuFaFzejTJNVNO75
 8YnEbK/TADYc/xSVmoOu8Utj47ksZTM668YHETMMPplVpQELLocU8ItvCmgv9tf1Y/RwVLwMcZR
 d06bARycJgMW3XsiLOG6/NVLZa75kuxD0Qj58mn0fbgSdFSwt/Xh3dl+DMQl+X93nuGff6mE4kJ
 Gp6ViGLHjApUo3ouc07RNKxlvvP4ATcdHd6BCQtlw+EYE=
X-Google-Smtp-Source: AGHT+IHzvHiltbSh+gRdd7UpK2tEJxYOagNBCdGQbobndfwA7mk3TsZiZLP782qcHt5F9FB04lxoYQ==
X-Received: by 2002:a05:6000:1a8d:b0:42b:3d93:9a27 with SMTP id
 ffacd0b85a97d-42b59385c46mr13314242f8f.36.1763400987775; 
 Mon, 17 Nov 2025 09:36:27 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae88sm26918085f8f.6.2025.11.17.09.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 09:36:27 -0800 (PST)
Message-ID: <cf9bbaab-177b-43ce-a993-9f5157c4b773@linaro.org>
Date: Mon, 17 Nov 2025 18:36:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] Hexagon (target/hexagon)
 s/gen_log_vreg_write/gen_vreg_write
Content-Language: en-US
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
 <20251114230013.158098-4-ltaylorsimpson@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251114230013.158098-4-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 15/11/25 00:00, Taylor Simpson wrote:
> Note there are two functions impacted
>      gen_log_vreg_write          -> gen_vreg_write
>      gen_log_vreg_write_pair     -> gen_vreg_write_pair
> These functions don't "log" anything, they just generate the write
> 
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>   target/hexagon/genptr.c      | 8 ++++----
>   target/hexagon/hex_common.py | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


