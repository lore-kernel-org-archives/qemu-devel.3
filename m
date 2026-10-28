Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65545606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dpG+H1yL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6HY-0002Er-VV; Wed, 28 Oct 2026 12:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6HX-0002ET-Q1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:13:43 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM6HV-0005Y9-QC
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:13:43 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-67a2efec15cso1264049d50.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793204020; x=1793808820; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=to9jGXp48WhErvlKe/0E8iN3SP3odftTI6AezcJtbQo=;
 b=dpG+H1yLsIcPwHSDZoOUBKuQUc0tSzKkDsQVUAoCuBahomAM+apEfSdccB4huQ2e54
 YTDmBTyVG0I9elPmceVZF0pwsrr2xiMC/Zjnqx0ZW/I+DJ6nyK2A0a7IVVhaUbWqeZjn
 +vM6N+AszWBfnKKO2zcM8qAqRl1jzJovkbZvyEdzpBY4+YEAVpvhPhjKKW3cG44dIJFz
 /1dKiprAbqJm2WbYED9TVv67vKxhFWp4jcmKGpPh8LYC/spDDp2JaiQJq6X25VmFTTCq
 188ZYX8FS1uMJKUyBgHNA2GuaJxpp5yg5Zsf6VQrneNe8qzHiOhYKLlkXSd5vGJxbrcs
 iisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793204020; x=1793808820;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=to9jGXp48WhErvlKe/0E8iN3SP3odftTI6AezcJtbQo=;
 b=RJXPUKdSZxTohgPW66AaQXux/jLsXDFex5uojC/PUztYf76Ky6TeCrikNPx+sGF5Bi
 zj/E3WAXPi9axfDLJaWWJJxBiAGsb3TVmAGmmUmyAWJqY/cmNTvt4kf4RdIQwx2a9YbS
 IOVVciGcCNU5TsPTcL7bT4cWsYLtFcSCS4rxBKZiEpHscVhVzCpUyGb8rXfWVI2pog6y
 awLyLWHRG9KlTUAtqCC+RI0rE3aoP5hXeWW3mixF5hyj5bqI6VjK3rnwdSHae6Ro/cHV
 axyyVj8r58NklemdSR/23NXzvJmeg8oJqF6uDEKYcE95H8wC+ERW5RhYewiXEz1bM9uQ
 gB+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbE2bcK4ztxWA5KMPS4epIaJjMQl7zIP8YRG39hGpNxciOMGWq8e1ij4NhG9AXutVThSAFdoPdfpZA@nongnu.org
X-Gm-Message-State: AFq9FYL4fWTDYjTp5uQm0SdaRMItR0ZhChuXNyaH3f4cTqbfEQrpKRwN
 FH30t7nnytmabMCA04PVJJmT6GcBFtKAvEatB2uR17bAIAI4qfdGyGOnC4BBmAyb2e0=
X-Gm-Gg: AYBFou1r8GJO66Hn/e4IWi28IKAXhyfdbcQqssrw9j04dIjSTvvLmMEAWQYDHjII1F5
 lhn0SvuoiYalq3yDsrm75s3yzPHySW0AglFVEtCWRfSF0o/+Z5b/jLf/l1pCuIN3W1z/Yg3coeL
 ZpZ5ENf+Hp9q1JBiB6mnnTlLPJoavcjro4EyGke4Rkoe633unN+dp9lqSv5F5lAUaBt03pt6yB8
 eLoPuh1HhhHPCgzHKi1og9OLFlpI6Y/VrN/dOKCEB1lYX/SrauZqxx1O01xmvKM5CaHSLjT0sgR
 0xR8lTs6spB474dBGI9P1D+miVZBuBHpLVcyBv1hG4fu5KDqC71iOPphG7dkxx9vhlfx4qmxijc
 SAHFlMcsv7NpufC3AGMgmE8CYFJsXyMMxGb2+SqeaQlp2TbAm7D/5tBxNzrU1uuN4iJVTCH9NzK
 b0YuAxTKBXuVVI6kJq9kM7GDNACms3H4Y196o/tDhsqiLMHkBjaB/l4OXIlyvSDq6e1nvP6abKv
 omWTJ0dlPNdHVGrlnEvRKCxB9Jfblv+LrymYqOY6G7dDzy89sc+D+dE8utM1xvO2MjxLilJyx6B
 x0TNTzfoUaHARFMAUc1wRFLGunXjDDRoXjpalGkRKN9YtcYNFjWqPXzVrSBwmVTT1tshfTBctvp
 U46Giajcg1ok=
X-Received: by 2002:a05:690e:1094:10b0:679:b0db:fa80 with SMTP id
 956f58d0204a3-67a8d244072mr9775d50.34.1793204020038; 
 Wed, 28 Oct 2026 09:13:40 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6?
 ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67a79f35b0bsm2054675d50.2.2026.10.28.09.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 09:13:39 -0700 (PDT)
Message-ID: <4b1c5934-9143-4eec-8ba1-150ecfd528d4@linaro.org>
Date: Wed, 28 Oct 2026 11:13:37 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/14] target/mips: Convert MIPS16e LI opcodes to
 decodetree
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
 <20261026162034.32711-14-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261026162034.32711-14-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb136.google.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 11:20, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé<philmd@linaro.org>
> 
> Convert both the 16-bit RI and the extended EXT-RI forms.
> Decode the destination with xlat(); both immediates are
> zero-extended (8-bit and 16-bit).
> 
> The legacy decoder ignored EXT-RI bits [7:5]; the pattern
> requires them to be zero, as specified. Other encodings
> now raise a Reserved Instruction exception.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
> Since v3:
> - Fix EXT-RI immediate field order (%ext_uimm16)
> - Rename @ri format as @ext_ri
> ---
>   target/mips/tcg/mips16e_16.decode       |  8 ++++++++
>   target/mips/tcg/mips16e_32.decode       |  9 +++++++++
>   target/mips/tcg/mips16e_translate.c     |  7 +++++++
>   target/mips/tcg/mips16e_translate.c.inc | 11 -----------
>   4 files changed, 24 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

