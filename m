Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39905C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 19:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG22D-0003y8-JK; Sat, 08 Jun 2024 15:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG22A-0003wk-F9
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 15:47:26 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG228-0000Te-Sc
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 15:47:26 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70432d3406bso147412b3a.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 12:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717876043; x=1718480843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3tgrn48vyUc3Yu2wBob7PQArrz+J0KoUoiXSXp/Z+oc=;
 b=tpgTeppjWJnMWRmd5EoTuxQOk7ynuQ06tTBBLWZOP7L26gdxEqHDZ7+quXCJeW5HDK
 E7RGuTrs67ysWmKhobBJL7SUFwXOvA91fy6/gJPil5yfzwjA5NfonvxujCHxSEVll9vA
 tiDc6rJGRbg9cIl7V84xOSfR8MHIzSIi1GMHqYUToPdfm5Bl6U22Mv2uLPthjnYqvvkc
 ardTUmfOKmcg97hkJG3LoEEY7i4xagFl95mg187WzHXHyiJQL39os8S7oTMwwVuNHDEL
 QzpoIhwu7mRV7HAcu9oXCZGEzaSitMcg5k2AArQq9MvMgS46lXjhG97WQwfRQT/oLuLP
 uxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717876043; x=1718480843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3tgrn48vyUc3Yu2wBob7PQArrz+J0KoUoiXSXp/Z+oc=;
 b=YES2D4JFtFl27fJKhhJVKQJ7j2Iu/DCMVT+sQRcGwqD0cp1LBzFo2ZPVAOqowUucWC
 FQPyvZHiOORgMMjwxkbHcm6cuOeJVJHRGCex5WzX7D51T+aTeqYbhPabRmSUQcctGC3R
 Sjys0vV+DnB1c6clL1019Pi7gMVZkxOUGzSwPdKjWzcYqHsot8oyj6IzCTwD/d1y95DT
 WssxpNvSG1xjwI/IFBwJ+914w2eL0cS/bayPtOQrOstNpaFHplfty5oQpZQ8BUza0kbs
 cMfoRTYQxasoHwac2NEuowrNh/7Affj8oWuph31jKRIvy5PHrUTtvypPhju27k5vJjq2
 Imyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsUbrVcxyC2r+N0tzPDy0AEi9ieQUmS2oFK1NeXVt9PryUUDZ2UfhtnBBpJKIV/8Q5PQ/6CoIEr8mniUtK5wdHjSh/9Hs=
X-Gm-Message-State: AOJu0Yzfe2REK6W85qWcNPqPxZY51V1yKse2+NofIdT7Cn1up3qMoX9K
 NGAgwQaJhSkAL/HaUA+Yf6n1zFyH7d4Mdx320BdH4ZZirSn1Y5AJ4l3qONdEgIjqbBlgLzXIrSK
 A
X-Google-Smtp-Source: AGHT+IG1JlWP5rkLab8m6dhHFkWuGdK5elFwVHp3/vGRbmkYVs6xpBqMV9T1OALGCpVGsmSOHkFHgw==
X-Received: by 2002:a05:6a00:1a94:b0:702:36a0:a29c with SMTP id
 d2e1a72fcca58-7040c62d0f2mr6485203b3a.3.1717876043178; 
 Sat, 08 Jun 2024 12:47:23 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-704326f9342sm329213b3a.103.2024.06.08.12.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 12:47:22 -0700 (PDT)
Message-ID: <224cfb42-b8b0-4e64-9e4f-68c8759f3841@linaro.org>
Date: Sat, 8 Jun 2024 12:47:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/25] target/i386: convert SHLD/SHRD to new decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-18-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 6/8/24 01:41, Paolo Bonzini wrote:
> Use the same flag generation code as SHL and SHR, but use
> the existing gen_shiftd_rm_T1 function to compute the result
> as well as CC_SRC.
> 
> Decoding-wise, SHLD/SHRD by immediate count as a 4 operand
> instruction because s->T0 and s->T1 actually occupy three op
> slots.  The infrastructure used by opcodes in the 0F 3A table
> works fine.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      | 83 +-------------------------------
>   target/i386/tcg/decode-new.c.inc |  6 ++-
>   target/i386/tcg/emit.c.inc       | 42 ++++++++++++++++
>   3 files changed, 48 insertions(+), 83 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

