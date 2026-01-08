Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8709D1D492
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdx9K-0003Mf-Ht; Thu, 08 Jan 2026 16:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx98-0003Gv-CC
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:02:19 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx96-0003kX-Rb
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:02:18 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a0d06ffa2aso27469815ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906135; x=1768510935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mHhLKjrOVxAxK2uYx2YwvKqoewjfAfIIm186/otAyoc=;
 b=LpFm7/M6/coiY7aczopY3bIphAqi3iu3kambH0NxU9kGq797FBwDQ9bdczO+xQ0Y/G
 4ArgGXZLP4rAa4WcURXfMC0HK9txyAorGfDYdeSO8Dg4OgAVENJjr5NdxueryDSiaofx
 V2pfb7defUzvm9V4keIsnptmo03P8nIvl64B9d5yzCi6/GaC9uTrvnrEiKkMszhCpoZz
 uaBFigLjKuXZ1T2OUE3oLJXPEFju/0x2kTskQkCd0DO3yd0mGphdy2Hcdl0sCAuxL/kD
 5DDE6TImjBZjtem+9IQzi+E0VACTsTI7/qhHFH7YUNcz93EPljHwkdNrvTwWJPZal5Bx
 EMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906135; x=1768510935;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mHhLKjrOVxAxK2uYx2YwvKqoewjfAfIIm186/otAyoc=;
 b=mEWjcDl24novCY1wMRzaJfykcKzB2vrJdjU4HPcLr23BdStMe+aHgFNm5uAwEVpusf
 SwwXh/nA2MrLCEB725IpdlJtM6kgEj6HcRi/AHGub5MscnE+kh+5P2p5kb2Yv9a6ta5+
 o9RGqa+sDNffru5f0d4lTYETeZmU0BgVkqhtyE8x0TAfKXTO0b/09EOEYuZGyj0suoZG
 tBvteyp9ur+qwZ5isytt1jxB+xPNPZDuDtQ5TXR+orhE3bJMdIFrvSrqEV7fhTWEywHa
 kpMlkt/45bWL+V7XOGOM3cgsi8bcrdqrv1XtGx6FV0Oj4Oh36ryeCkv73EO4Tq8d98bk
 unQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu1+vnT13Hk/trLtzyGUxcLbalLBWKv48UMAWaRtRiwZXzCzrTB02TIIyW/CKlkXEYmaLw814myZlt@nongnu.org
X-Gm-Message-State: AOJu0YyJxolo5XXyiBYmiV5uOKMpHQm2p0GPkLNaR9DS+MDejX3v/tJZ
 JcDUC/LDQ/Qs5Q4n1RUL4faPX6rt4modLn9nuipRXkzvhx2Ng85ag14YOBX/sWRBRaI=
X-Gm-Gg: AY/fxX5JHE3zR4TcGBFlBp6JV/Pj3qSdieMnHBvhMpDadE12Wh2et9oQeJWzHCT9GMQ
 XoWPlb66AVLyPaWssgzvPPk2dj4mNiJYAzEwKQ4ZD/9650eFZgi0Ja6ElqZZjjMZtgev838bDT0
 cUW4OTHAz64j47UhQVWQ6Q3Xi0hErZt+XWcqQ0hen78piymL709CaPGTtqu41WP+WBgLNEZ1dzU
 KwBxd7FHUSaAbKE6Ws+RFxNsqVXHXBaSV5Qfk3Av58/VEVy8XvXZ7o4y7a4r0ZxT5s9GqLYVME+
 DEX51CbkBGLF8IpYBj7lASYylY2MFOz5qRBbFLjos6SwdV+WjVPpzHx4L1XWI6D+2aZzZU4pz/u
 wAVVGLkKEDad/OrqYqsQuhGOJJjdZ8MNvsvHRe6q+VG03/YqU2qHAn3P5ISyC3DFmhXwdqmhkE6
 htbH1baYdkxiNXRRorCC+gh2MyVHtBPZN36k1DDhNrcmSQV6ChLBAjh5a9
X-Google-Smtp-Source: AGHT+IGvcvpRo3nDKgouMRb2efr947oJbf8WCfzo4zhY8yr4Eay3Qu7AE1UOL3gaj32Vp6qB4rr+xw==
X-Received: by 2002:a17:902:d488:b0:2a2:efa3:166d with SMTP id
 d9443c01a7336-2a3ee4b4a71mr55676555ad.51.1767906135141; 
 Thu, 08 Jan 2026 13:02:15 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c47390sm86261155ad.25.2026.01.08.13.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:02:14 -0800 (PST)
Message-ID: <3b4a58bb-f384-4cb8-8699-bcaaa2779fe4@linaro.org>
Date: Thu, 8 Jan 2026 13:02:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/50] target/i386/tcg: Drop TCG_TARGET_REG_BITS test
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-33-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-33-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/emit.c.inc | 37 +++++++++----------------------------
>   1 file changed, 9 insertions(+), 28 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

