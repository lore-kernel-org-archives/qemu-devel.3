Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C96C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgku-0004Io-TL; Fri, 21 Mar 2025 14:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvgkq-00046U-NB
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:06:00 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvgko-0003wg-Ts
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:06:00 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so3953376a91.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580357; x=1743185157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fcsRCqIlZYhLkJXmi9uJeXTy/LuuCnSzcHfkPDugb3c=;
 b=BviO5JjZAnrMWf6UqTUean5VFsfMtHCzYeHE4S/T3TRDkcp67g30YB62Pm39hRQf+L
 R+pK8DJGwqI+t9HnLF5Y0dZuJN7eGghWcPp8McQv/kjwCzsXn2/qjgg5JoaHzfAwWcMC
 mMXE+tnq7mKSnMWz5eBapi347+ENzqSJHsFnJ1lekyDm75L2Pn99bI/WR/BNGS1ulpr5
 sa//86jw3elT1rvHCEcRL4ydRSH31dkHImruZvTwmm+sLQXAI42FWkym/z1GYokRedWm
 IPqokPpBltvbr1vYHmsTTmOP3vWTIYG9hOP5vTbZcIZx1yHiagqCb/VdzyD+oai1FpRQ
 vW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580357; x=1743185157;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fcsRCqIlZYhLkJXmi9uJeXTy/LuuCnSzcHfkPDugb3c=;
 b=D5IXwMnlVDn7BcReD/1uv7+39B9sUKvQ6sJDBVTMouB2jYePDgxYELCVcaZJqdoTqL
 RrmMXPBVVTjfG5+8lQpflyYOPyE+ukw3s3gYfP/E+I2/gQ5TqrLtoGNs/Ur+irpPBgxN
 /RsqVy6LYyEWmuaD7aoS23OEtVNwOHlArGyTMymkl6RzSrrp07+OGCgyV782+M0Md5Qo
 Pxhk6Xqn+4QiaU1H2VuJbBxuXYGfNRsVDy9TuctrfwW6/qfxzs1+jtuNc6elyAMNLPIR
 azM7srtV46vlnV80WjexTZRGDA1AhMQvcYt88kUG779M8DRV9q/zjivj85Hva2JgXJRa
 7zcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQYFB1HC7GvCqeSmuMDcd4XC3mNYcyXI/nhyKFTY2Uz54gELWAR7HocGYaK4CnbOKlQZuW8IHX1Q6L@nongnu.org
X-Gm-Message-State: AOJu0YzcYTP1FWLFYXAo4FlXNWeAwoId0k7vvSydJBlrk886PTwK0TM4
 uLg20q27dl06EQ2WbGqjzXeDtykerkx3+Un9qAXCHWCqZ9ubgmOb5jh/CYlM4oE=
X-Gm-Gg: ASbGnct2tfkeyBmq/VQmv743C34ZqLpxxxNgfvUdZMzhX3FRcIPrB/h14tauUtdye2k
 WCdz6mmaKOfebTIChVYRlNbRLlLSLmXSEuFoMxPHT5smM9EvLiGgGng9i1XVSQmAt+UgJZks7I0
 N+rTnQPsx53mSrNRaRc6BVHDFmyiyJ4UT8ZXXk+rcs/v0ZPnZ7fk7vLYZlLsdAJn5bMJVLb4gfV
 mX2r2ESSPApjCVG7vi2G4mAdYi2jHtS7dskMOVu5ajZUeE1qa6HgWIytArjc8wrDcMZAH+mvrSf
 T4sby2N2hxBZy/USrso779Owqf6tqJhs4nJnSxz3Ql60BwUYk0cOVzKP07mQCF6nrIQdJSe4VYQ
 ALGJjiTszobXjOC2nVpg=
X-Google-Smtp-Source: AGHT+IEh0K4m79qZvi51zXutwZPPSNgntSySIgettNINaF9oH0PHmuS8xS7yjizBrcB/q8q2pSoCug==
X-Received: by 2002:a05:6a20:43a2:b0:1f5:77ed:40b9 with SMTP id
 adf61e73a8af0-1fe433195b5mr8209998637.40.1742580356943; 
 Fri, 21 Mar 2025 11:05:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fd57d6sm2375807b3a.58.2025.03.21.11.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 11:05:56 -0700 (PDT)
Message-ID: <2e667bb0-7357-4caf-ab60-4e57aabdceeb@linaro.org>
Date: Fri, 21 Mar 2025 11:05:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/30] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-18-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-18-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> We introduce later a mechanism to skip cpu definitions inclusion, so we
> can detect it here, and call the correct runtime function instead.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/target_page.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/exec/target_page.h b/include/exec/target_page.h
> index 8e89e5cbe6f..aeddb25c743 100644
> --- a/include/exec/target_page.h
> +++ b/include/exec/target_page.h
> @@ -40,6 +40,9 @@ extern const TargetPageBits target_page;
>   #  define TARGET_PAGE_MASK   ((TARGET_PAGE_TYPE)target_page.mask)
>   # endif
>   # define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
> +# ifndef TARGET_PAGE_BITS_MIN
> +#  define TARGET_PAGE_BITS_MIN qemu_target_page_bits_min()
> +# endif
>   #else
>   # define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
>   # define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)

Mmm, ok I guess.  Yesterday I would have suggested merging this with page-vary.h, but 
today I'm actively working on making TARGET_PAGE_BITS_MIN a global constant.


r~

