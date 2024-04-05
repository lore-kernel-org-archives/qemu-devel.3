Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C88C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 18:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rso7h-0000Cm-6Z; Fri, 05 Apr 2024 14:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rso7g-0000CV-3R
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 14:17:08 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rso7e-0007i8-1w
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 14:17:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e0411c0a52so23312145ad.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712341023; x=1712945823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RqTmXgfQHA1k4DXgzXGjZtdD4j+rxGlQUGOcJyq7yvY=;
 b=YJ5MejBLs9rud/zASTVIYQcQod72daQ6PYVV7T2Kdqn6U93hD4Q0kPi2mzrGVgfb5J
 MDrapjbE9J1PE/qy7QQ/GqZANc0eQ547+iqagKuRzd7k/5sl+hi2pNgUu/SiHPZURqRe
 hf1BpKMpTYR2yiF3S8bYOVsIbSBkFy7LfWItjvDFNJsdUr9ocdtsiArbZFtOVnC1IqhR
 kq4H5yxhKTo/zNgTos8e1+OYxF7AIpUILK+0M1xbBZXIsYW5U8qZ2HhmIRLPs728O94p
 0WbRki1O+100vIImHb0rJW9WDjxsKtnXBzuiJ2hBLaR7a/oTipK+sNEmYfMriZD8UO4W
 aLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712341023; x=1712945823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RqTmXgfQHA1k4DXgzXGjZtdD4j+rxGlQUGOcJyq7yvY=;
 b=CuuapqCE0I+jAYM23iMlpeLi8H3YzS76+eZFUNpxCELxLvomSdTMRlYp9ffwByJVTf
 KcICKXXW9mnAFmbLrC5e/13hvIdjBZwfcs7dy6H4f8QZOrXwm5fXNk8yWL4I7HbdruvG
 k6iROrAUCLWTkAGLtCkRUl319d74yMPurQPyE0iI6PmRGr0iwojeWFP+Mc1f7OVlqszF
 rFEIFFABWpNpdXjd5NA9a6HiQiEX3dWI4hQz4oTWSMyl2xcsxz4CeLo2rjBunETOhr++
 xaPlnRX2+1uNGrA4LYtxsp0HhPvIBJOvKKnWl4/oA3OSZKhqKq3TLq/kRY66fea6F+Ty
 R+hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1p1y+uJWzllCazu/LqaVBiGHB2erDkhR0e8blO2yN+1aozhOJxB+9KxVBvFo/The9nw5IevhAcW1WUqmYaJmw58RWI2M=
X-Gm-Message-State: AOJu0YyhBvg9yTcMkLCDvWsLLoQk2VzHpw7IXcA6iOEl5pAJslmXru8h
 OxFaMhy6ZZBNv+iQb06THmkap7NTvcPdBTW875ez00wVWqMzDqo1p0EgRTpIebg=
X-Google-Smtp-Source: AGHT+IHYnmQmo4L+P79ImBf/AO43V2kF1IX1ME89B7/3TUlNdMmgNUHbaH6/ABOTYnCKxABt0/sQsw==
X-Received: by 2002:a17:903:41c2:b0:1e0:89d8:ab2f with SMTP id
 u2-20020a17090341c200b001e089d8ab2fmr2832952ple.66.1712341023421; 
 Fri, 05 Apr 2024 11:17:03 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 lb4-20020a170902fa4400b001e0b3a87dbbsm1899548plb.177.2024.04.05.11.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 11:17:02 -0700 (PDT)
Message-ID: <fbaa97be-c355-4a76-af10-fa64a7b1d31d@linaro.org>
Date: Fri, 5 Apr 2024 08:16:59 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] target/arm: Use correct SecuritySpace for AArch64
 AT ops at EL3
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240405180232.3570066-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240405180232.3570066-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/5/24 08:02, Peter Maydell wrote:
> When we do an AT address translation operation, the page table walk
> is supposed to be performed in the context of the EL we're doing the
> walk for, so for instance an AT S1E2R walk is done for EL2.  In the
> pseudocode an EL is passed to AArch64.AT(), which calls
> SecurityStateAtEL() to find the security state that we should be
> doing the walk with.
> 
> In ats_write64() we get this wrong, instead using the current
> security space always.  This is fine for AT operations performed from
> EL1 and EL2, because there the current security state and the
> security state for the lower EL are the same.  But for AT operations
> performed from EL3, the current security state is always either
> Secure or Root, whereas we want to use the security state defined by
> SCR_EL3.{NS,NSE} for the walk. This affects not just guests using
> FEAT_RME but also ones where EL3 is Secure state and the EL3 code
> is trying to do an AT for a NonSecure EL2 or EL1.
> 
> Use arm_security_space_below_el3() to get the SecuritySpace to
> pass to do_ats_write() for all AT operations except the
> AT S1E3* operations.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: e1ee56ec2383 ("target/arm: Pass security space rather than flag for AT instructions")
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2250
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> I guess most people don't run guest code at EL3 that does AT ops...
> 
>   target/arm/helper.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

