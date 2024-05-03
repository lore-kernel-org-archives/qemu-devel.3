Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10171C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uT0-0002Cs-JN; Fri, 03 May 2024 11:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uSy-0002Cf-Pi
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:04:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uSw-00058O-Rf
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:04:52 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34b66f0500aso6633243f8f.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714748689; x=1715353489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4znFqPb24xIIlqcGlsXDlal1fVvpqbNDMMwADFH47Y4=;
 b=GEqQOu6dJtcHFjc5SBsv1P4IhDNcR331jwTP0pMsD9fQ2QMZRgqDHUyj+M6UyXPEgP
 BjVghGkKgKte/TJfYBVoXQX42Wgj1wXSiczvKYNVG35ky8HhgeJT+Vr6pBIRyJEU51jY
 WaahUSnzbDOkzvf56J2EYy5ESKgwLAaYkLalKPTmN2K3Wo21utbI3LrsR+0aAgs0ccan
 /LVYKS//GVpD/14xqps9mszPpf+zTd6CeAt3l54K7e1v/w6/1Cw0ZmD7JpRi63CWUrBv
 BuIR7skNhpB9u9V5cMrKGJT4n3OQa2RqX8V57L7XjyOS3IYjRtlNOVjQi7z5oI2NMoeW
 zSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714748689; x=1715353489;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4znFqPb24xIIlqcGlsXDlal1fVvpqbNDMMwADFH47Y4=;
 b=lpBb1CFvDGEtvoJWDh6+hk8hru1WhocvcMywe8GLDn1DlqqGr2/NMan1GzjD3FIVG8
 Fhpv8DAgEDDlKt3YorQbFb0tQx+2UCTqZNWwAVZhOSeutQc2+nkGUI0hi0W5rbm4iIiX
 KsOPLBL6xG56tQkYewcxKRAHTbi/HRSyLOmmg5sBf/ywNstZpABtq5SNbXCuMHEzToqN
 k1qXNX5VScLTSLPR2LKFYbPdgdZptMcr8HiahkSPMCpxZV20vKpfVPy+HqOR5ycc6w2b
 b8SdEr/nWGtto9cjF7EnpYzzOsi77heE7amfyu4G8MBUZSsEk3rVVpq1izuaNMucazaE
 iq1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNzSfkMo2fFlDkd4AiJcmnEB47EkMwNf+twq8Nr5SXUWdpougvnGaejxn5v6iOYgqXa+D2Hh3SS//f/SDypQuLYQ/PruM=
X-Gm-Message-State: AOJu0YyO8Hcpg3hQuRlUexURv8K9yd19eWxp0B31Noqe3mtXJaw2GHTj
 ZJVUkCqi8vZXDc+etJUhprYH0SZ7+zPos03uZCSb9fYaRIeih5SOI2rqx+jPYIw=
X-Google-Smtp-Source: AGHT+IHMFSACgLG8OEFgRhG8Oe7cQ/MysjmrLP1qeBCdOeOBM5oOZQOmTFrGkK+s93rKEKMaKubiRg==
X-Received: by 2002:adf:a486:0:b0:34a:5663:40e with SMTP id
 g6-20020adfa486000000b0034a5663040emr2317676wrb.9.1714748689049; 
 Fri, 03 May 2024 08:04:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 dd3-20020a0560001e8300b0034c9f060a14sm3948234wrb.11.2024.05.03.08.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 08:04:48 -0700 (PDT)
Message-ID: <3524e1a3-42b5-40dd-b7f7-5749d7adb030@linaro.org>
Date: Fri, 3 May 2024 17:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] tcg/i386: Optimize setcond of TST{EQ,NE} with
 0xffffffff
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424170908.759043-1-richard.henderson@linaro.org>
 <20240424170908.759043-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424170908.759043-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 24/4/24 19:09, Richard Henderson wrote:
> This may be treated as a 32-bit EQ/NE comparison against 0,
> which is in turn treated as a LTU/GEU comparison against 1.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


