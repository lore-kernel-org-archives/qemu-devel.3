Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80125C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 18:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwnVJ-00057U-CA; Tue, 16 Apr 2024 14:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwnVF-00057B-72
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:25:57 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwnVC-00088Y-Hd
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:25:55 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e2232e30f4so35966325ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713291953; x=1713896753; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YCjOhPevdVnXeModLi+0kxOBLVTda9Mh7LViDOjEitU=;
 b=P1JlALbYKRgQeqjn4eogRzkIf9GZUl/0ocbIVxdgz0G57QlEjhFXsBzEdaIF2J/E5g
 7AXe6ZeP66Y/n4seGL4ueETLspVHl+3BCJX/MgAf7ASuhiMC1ofGeALYrCwxq8hBB+Y3
 iiv4xPK6kgK3E4VBq5K2TJiA0fmEKAjO2r7ZWy7tBvBNiXNFuU7CRHKhmZTm9Iz4HN1S
 vZlaYKAkO4flpShOJJUdI+YDvQHOPbkP+SnnJDGgJpIdFrlA4YJ4+/RrHenccNr0C7Cf
 T8hkjfSdGHgnQshrumRF20Jq26aOKP/6EaZLIjgxptl2U0z108UcHnQW7kb4diCu5YgI
 9+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713291953; x=1713896753;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YCjOhPevdVnXeModLi+0kxOBLVTda9Mh7LViDOjEitU=;
 b=LLKk6pSd6uEXxMP5MkvZ3qK9eaVPh77WsmtXy/YXnW1t4S8ZLbyYRh9TyGgumkEy5O
 jVT5sX6izioyc9mnd33rbhK16QJ8xezweB1ZV08CcjgDdEyEYzh3eIDQmzyUQvTxNKTc
 eaYmAswaPJuTG60T4CNX44JNubAekqYfwDldzKAXLXj0fFJPmouyOIKgY4ElAEseqj9l
 l9dJGzi+C2dJXMSzlXO7lYNm5TF9uiTMbkviVIo181SnR/41usdo5j6Es6eg6kUbO8Vo
 hV7dipcUTZCo5OaLPN10AkTEFmpqzUKXpvRy52oM1IKEGW3g8IHdaWoNWIW8ZUeTZEji
 ra7A==
X-Gm-Message-State: AOJu0Yw4MG1Dae5HoksqmnXxHpovL0yQHJVWeoOAzq20FK5am6p1M2vp
 XFDI++y+8Cmpp3KbGKxSE8kwM8m2nstXdm/4BzArcwTAz6iq7QRBc5Cpe/qKEFA=
X-Google-Smtp-Source: AGHT+IGgWhS5zKjSQuhU3eBLNlDPyPMCCj8Uq7fN6HUOqY+aMFiieuWE1w828jb3IbF0q3QgZtwYfw==
X-Received: by 2002:a17:902:b688:b0:1e5:5bd7:87b4 with SMTP id
 c8-20020a170902b68800b001e55bd787b4mr10677185pls.18.1713291952891; 
 Tue, 16 Apr 2024 11:25:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kw14-20020a170902f90e00b001e249903b0fsm10105615plb.256.2024.04.16.11.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 11:25:52 -0700 (PDT)
Message-ID: <00d9243d-bc6b-44c8-a53c-15ca702058de@linaro.org>
Date: Tue, 16 Apr 2024 11:25:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target/ppc: Move neg, darn, mod{sw, uw} to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-5-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240416063927.99428-5-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/15/24 23:39, Chinmay Rath wrote:
> Moving the below instructions to decodetree specification :
> 
> 	neg[o][.]       	: XO-form
> 	mod{sw, uw}, darn	: X-form
> 
> The changes were verified by validating that the tcg ops generated by those
> instructions remain the same, which were captured with the '-d in_asm,op' flag.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/helper.h                        |  4 +-
>   target/ppc/insn32.decode                   |  8 ++++
>   target/ppc/int_helper.c                    |  4 +-
>   target/ppc/translate.c                     | 56 ----------------------
>   target/ppc/translate/fixedpoint-impl.c.inc | 44 +++++++++++++++++
>   5 files changed, 56 insertions(+), 60 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

