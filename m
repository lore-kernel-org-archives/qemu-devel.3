Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FC9C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ot6-0007tt-QZ; Fri, 25 Apr 2025 15:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Ot1-0007r1-HK
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:39:00 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Osy-00071R-OC
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:38:58 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227914acd20so33027535ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745609935; x=1746214735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sF0fyh4B+mzwl2vbs/7zrn57WSn216jjQzb8AO7pyME=;
 b=aGejVVhasvP1l9+3tNO4b5q8TiZ9RLyksknuqybn4HUbAChHRB1efs3LO4ECYKZhuN
 fKxpkzXLnIiltCb9r6ZIvQR8PrJXXYnbPasQyMCdiQYP1WbI/ahnaI2RESpSm/OFKtxM
 /ISzuaIDuvewIFljyblioj3VBV4FHZcGuh48PObMGbmiXICSSafdsoQ9k3pPEfP4FksF
 zjxvcgHwwD2hgOBP32ngquyfHb+5au+1o5O/aOMkMjOgzI88pa1FLDy6Cszql9c+OXKL
 xp5lb8AmZqsCA+5AJt/KATRllhht4gYDjoKvP5PBDqUvRzsMQhuTRdRcfZmzYB2TsvzZ
 XPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745609935; x=1746214735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sF0fyh4B+mzwl2vbs/7zrn57WSn216jjQzb8AO7pyME=;
 b=fidChohbl6YSK7KWwvga7j3cAR4rpQP3i6Jq0Sn5+QDV2UVGpaib7QpGgSKqcZJbZG
 XBbPeP0E3wafnUJb2aqWxteoLGK84PU80CE7KttqMrygFfOT5q1cTIMf6S4IVf+ZJMs2
 d8QMOzEMfR2I66o13MkfVHfTNoRqBjTQmwaBh+FC+7PSeRDC8XCeo/AfGv3LZ3sFd808
 uB/0PCDis/OBNdOqMABzzgEnctYZKX7al+EJS6SCgJ8ZPkZ0VqxBi7WeuTY72SE7jQms
 J3OKxL+m12wnJBcVrNCpbSLiEAgTp9epRO/1JKhrbE5TWHN9M8yUgZGyUKcol/nNfKmt
 fvpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkaX3sk3rtca0t1fuUOIetCsi4IDlO+gMlLcZ+YTwUbh43vi8pazMurZ3uu6sF1uqeL+BKatXoTFfu@nongnu.org
X-Gm-Message-State: AOJu0Yw+26l9MhjvrV8Qm8AoO8mCkgPu+LyIeuZJcnu2Sao9LAgfor0Q
 rfGr36vGLmnna3Vqt2xtkiboC3a4q6kg6wVBkoVGVmLw3ghqtQECixlFwimjpTIeL6yyGVYMR9A
 5YGOTvw==
X-Gm-Gg: ASbGnctObbtYNaAC34PIDM19UsoGG73OL1t8MLd4Rd0cOA729lXcLVytB6Lnuv2Fe6+
 1VYRFR0bh0KAZIhb0JB40D9a6YDgA91D+numLhm95s4xgQ+dMSHagMnqt4x2fdpB7XM2rSlrwvq
 GDzS32Oxcaqd1PLD8/i+a8kAiay7oKASoLBQno+cPmbCHxTx25AyIWtDCJ78ftXK42+yysf2fW5
 vTCHX+MfUlG12qAQXRCyw83wfiupweRqgYkDSAZZWEqT7LNsoJdhYLI+I85D61WPnmxITwHgHo2
 00dLPx1knueiwKAQGCOI/Ymk5q5asj/i61VRCr9mKugnHOgeoPG/lw==
X-Google-Smtp-Source: AGHT+IFMzWkTK2o7pfaf8KnEg8h2qKC6n2ZBjNJrIgf+xoA3AwrDhG3V1jTk0GYmpkoMC3gAc3mxZA==
X-Received: by 2002:a17:903:2444:b0:21f:2e:4e4e with SMTP id
 d9443c01a7336-22dbf8d763emr46981665ad.5.1745609934831; 
 Fri, 25 Apr 2025 12:38:54 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e772bsm36638345ad.132.2025.04.25.12.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:38:54 -0700 (PDT)
Message-ID: <bdb78a7f-5c63-4de1-a648-509b6379097d@linaro.org>
Date: Fri, 25 Apr 2025 12:38:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] accel/tcg: Add CPUState arg to
 tb_invalidate_phys_range
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-6-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h   |  3 ++-
>   accel/tcg/tb-maint.c      | 10 ++++++----
>   accel/tcg/translate-all.c |  2 +-
>   accel/tcg/user-exec.c     |  4 ++--
>   system/physmem.c          |  2 +-
>   target/arm/helper.c       |  2 +-
>   6 files changed, 13 insertions(+), 10 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


