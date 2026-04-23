Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BF6F589A4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFtGM-0006xy-JM; Thu, 23 Apr 2026 08:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFtGL-0006xi-IW
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:34:33 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFtGJ-00007G-U8
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:34:33 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d75312379so4863475f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776947670; x=1777552470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/vreumd6uaXfkirV4hg5sUAs7q0q0XtLTmucrxedRsQ=;
 b=zDqlgMNjMOzjM/dO6W0tDLjdwEfh03J4b29wGLSKxGDR+Q4MWabxWjjjfjiR3s+zXe
 T3YyPp2votE7j8v2efUvIlp6s59r5Uy5vt7I/Y3tRpo29WGotQxWrftbTLHtuFGExHyy
 eYwx2brn7uf7huI3xOY43V3kWVaRzMeAr2sZqIVurQXtGmYa+PK/KitTL21hIEjI6eb4
 O8qHOxJ4N540f1VgV1xRiwf2379Ulj/dS5jNBJX/xXwRHmARNEm1555yLuZiDFuaDc2z
 OCulTXfICsBx98IXsmzW/yO+Z0ngfpTk0JkSqLwIhdBJgWm/ktxawnof5O9f8JzBnqa2
 /cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776947670; x=1777552470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/vreumd6uaXfkirV4hg5sUAs7q0q0XtLTmucrxedRsQ=;
 b=Dy3CgW4wwI0esOaRH1gd9wjL3tTzmEAi541AGwGrAA0vsYgxFLG9I0uuxVC2SwagMQ
 kTYnyGH9HoN+KyUCYjXOwEkt08+NDhYDH7SL6NUmKHjr1fGv76ZktnlnxtMA/kz+PCyU
 uV4D7Cj/a+xtRF8DlJteKCPMe0/fY+mMcCHwVQX7rcfqfEvDwTAxBTp5VpgZOOFI52EX
 1nx+lp+9AKS6HPMHiJIGVCkH+RS179JeCFcqmWUxzUDWOjb3QUsyyk1+IIEF0DKzZxVj
 2GqMlkkN1yjTybhgmoQlZwCltE2JI0eTfav3Y2n7HqCF47kCM/pB40DyBCiKtMX/w8x4
 mnrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Voi1pMYsfr/QFNX9EcO+DPTk7ca0ZYZFiYVC5OrgTkgMjCH6uFeXL8gui19IQSEaBzffS/vRTJDVR@nongnu.org
X-Gm-Message-State: AOJu0Yxbas9sBe0EFnOTo1Kz3ze5E1kU58aMtYJc9yCTVwIKS2HeFQ5i
 5444Jd6z6z8Ad+hJ72G1FoffkQDqgnCLEM/jJMphGTwMFrsZ+fBiLUyIz8tolhZy16NI5+jd7IA
 boBd+d0s=
X-Gm-Gg: AeBDieuZCkgJRar/M89R5Pwh+A63+aQMcl/SK3ueCU6kmIntToV/9Le3dl7kWYaeKSw
 TY9Wb2tLodk4tfA3KT4zbtg7ogz3BR15QQfrFFiCdj3Yygh9DKf1jnDy8TnoazhFy/P27csG87F
 uNzThNY1cAhi/25OnPJprXlAdNlOyZOUMSSepRSeOuA0cp6K03fsKJu9ppp3GwgTO2TQfP972+t
 W/lNRqtYt1PyLIJTvqnlRw2Xh7L2WWYvns9UKaJjuWRQpLHBoXMo51YNa11KfAyjfr6cerOawn/
 ddUz+FT1G8tiyVtEQ2ZR4enJuoh5DFUX2uObTvAscBElPJU265WDavKawpjJsBsmb3ms/FvmpN1
 09syVlFdaSAmL7H9GAyFQRD8odmfsF5N3TRfutVufzpEF6CYt0JB05bqyvbGTU5VvxmNBT39DCV
 8Xu9YtQFKB/b/63N+a35Mup5yy1gZhHSF5BH8rY3PukrZpY3rOshAwZv+WxqmmWNxiFH0AFwWq7
 7To
X-Received: by 2002:a5d:64c9:0:b0:43d:2d34:8963 with SMTP id
 ffacd0b85a97d-43fe407ae53mr44463067f8f.17.1776947670004; 
 Thu, 23 Apr 2026 05:34:30 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412150a092sm18663068f8f.23.2026.04.23.05.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 05:34:29 -0700 (PDT)
Message-ID: <7fdb9701-0245-4872-9d5c-157f6b80b340@linaro.org>
Date: Thu, 23 Apr 2026 14:34:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] tcg: Include missing 'tcg/tcg-op-common.h' header in
 'tcg-op-mem.h'
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260423100612.27278-1-philmd@linaro.org>
 <20260423100612.27278-2-philmd@linaro.org>
 <6fc61e19-dca0-4d76-8b8e-f8a81c1515bf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6fc61e19-dca0-4d76-8b8e-f8a81c1515bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/4/26 13:41, Richard Henderson wrote:
> On 4/23/26 20:06, Philippe Mathieu-Daudé wrote:
>> "tcg-op-mem.h" uses methods declared in "tcg/tcg-op-common.h".
>> Include the latter to avoid when including the former:
>>
>>    include/tcg/tcg-op-mem.h:34:5: error: call to undeclared function 
>> 'tcg_gen_qemu_ld_i32_chk'
>>     34 |     tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, 
>> TCG_TYPE_VA);
>>        |     ^
>>
>>    $ git grep -w tcg_gen_qemu_ld_i32_chk
>>    include/tcg/tcg-op-common.h:328:void 
>> tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
>>    include/tcg/tcg-op-mem.h:35:    tcg_gen_qemu_ld_i32_chk(v, 
>> tcgv_va_temp(a), i, m, TCG_TYPE_VA);
>>    tcg/tcg-op-ldst.c:286:void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, 
>> TCGTemp *addr, TCGArg idx,
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 69cdc5babf9 ("include/tcg/tcg-op: extract memory operations to 
>> tcg-op-mem.h")
> 
> Pardon?  This isn't in master.

Hmm I meant a8af0fb24da in Peter's tree:
https://lore.kernel.org/qemu-devel/20260423100229.2941820-11-peter.maydell@linaro.org/

> 
> I recall this is one of Pierrick's patches, but we should fix it before 
> committing.

I'll mention it in the other thread then.

Thanks,

Phil.

