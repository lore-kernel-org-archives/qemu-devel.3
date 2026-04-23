Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E088FDEE4E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG1h4-0001VC-NM; Thu, 23 Apr 2026 17:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1h2-0001Uz-Nm
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:34:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1h1-0007ZG-12
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:34:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d6fbd0954so5629209f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776980077; x=1777584877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j10tPcxCb3ppTj+/zcDI97nKgx4NKez193JSfPT2nrc=;
 b=igBV4FMb8Rb7/8l1e/kSDrIzwtiIkybm0ZDOwAQnNO4dTSIzvL7YZNKHZCfgFr2r9l
 KyJGrUisuBUy/vuH2v2pt0HFwL3L9KLSdU30G6ZVFyWCPpNyuXJOZmkYPZcozRo9B6cp
 ie8vP4HHV9dFgYXblt/IPaoTfTZUfMAOvUSwFwo9GXUG1lSK0iqQWWRITfmqyORLhf8x
 JMJFhbyLLJ2RR28dGIrZ+YYcF1B0Gpi13zOYcfGqoMjtuzIgn491DVTVXaRi+SiKH6y/
 +qzHedYBxknVPpdwTB7DOlTbKNiwevW6EoFnzDM4bxQo5PruOp+kBPJN8zIMaEpPWPSc
 hqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776980077; x=1777584877;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j10tPcxCb3ppTj+/zcDI97nKgx4NKez193JSfPT2nrc=;
 b=tIoK10yiAzW761WuQzbi3+jDYmzkB5kRSmm+vd1TpkBHTy4+E/hD3HkHacEgfciwbH
 m2/ehBUn7WfEYqR/dO2kyeN/5v+d+SyKB6FTVKymssM5hid0InAfNUfRpmgBMFFGfjos
 lJFgg0tac5FQerdGacNTeRoZRBo1uXcnv96+zscZRtgkWN3H14QxBFBvihtreRpWqYKs
 ylTaPlwfh+0ZxWa7r/Eyi/Cp1cjZpSd4otom1WAN9h7izF2IfOQIRqbyEGTvnIPoav1S
 1CqPZqe8+LuFdwcZs9I8bMls+n9ZT9EQkPXIzNHdqiGeCNpC+u6W1AE7sRjrFsLeNwOg
 DyoA==
X-Gm-Message-State: AOJu0YzqnaVdfsZCh0dOofZ3npU8X67/GsovCyeCmnaXlIseioEJXq3B
 rXqClKBJwoRTB4PzO1Ls01r/QGj80zCk5RhQtMG+lHfIEjW93B88rjCnTfkn5VM305o=
X-Gm-Gg: AeBDievAftL/NNTvSGWZFdK8wE9L4xgPdMhDxC5l4rEuJesiPNnxD6nZYo0UaU08k98
 i6gsGD7VGylsnGddZ7rI99c0qdYvBB/3OPTht9zIcL3OW9d/TB/edg8mS2BJVHdmSd1pGJa2z3V
 /5js73o60xxudj+5nfzFqOfjAR3r+PkzvKdJ+oSa2iPuvajzizzW3VFoohlFXD6CQfBgHrzH/cP
 cyD4K6JcDU2wVnamk/K5nDT0Kk+Q7dyfkVKIdziFLy6HlX/sB7v1KYAsyXfbOzIU8f/8JFhpBFT
 JVq2vZBfFzEp85DlGYmcaWH0uc4gGW4f7Z9mmP4npjnCuGKTE2xscuIZZSKVsTfC5DQMPioHYOG
 11rkhLaH/CALRAfzz5e70oNzPZSt8EaYVbCAIFSNoJO7umqoDZKf589uJx7xTURpaUEZ1aDHWej
 ZWYV1md89M6dPA/rzBjlAXvC1fHemV9JALIIgb0Fa07accwZ9XVRsk8iw6jzRKjPQlg2x2LLLjx
 Z4N
X-Received: by 2002:adf:fc4c:0:b0:43f:e413:e5ad with SMTP id
 ffacd0b85a97d-43fe413e60bmr31594492f8f.0.1776980076856; 
 Thu, 23 Apr 2026 14:34:36 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d112sm60322797f8f.29.2026.04.23.14.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 14:34:36 -0700 (PDT)
Message-ID: <8d292c52-0f56-4dff-9bfc-d47886746f53@linaro.org>
Date: Thu, 23 Apr 2026 23:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/59] target-arm queue
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
 <1291497d-21ae-4422-82f4-08a99224252f@linaro.org>
 <CAFEAcA_vFBVBiU=27h1j+hWLX4P_qMbSUzW0rLy8yJJGKpx=rA@mail.gmail.com>
 <20260423174904.GA574634@fedora>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260423174904.GA574634@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/4/26 19:49, Stefan Hajnoczi wrote:
> On Thu, Apr 23, 2026 at 01:53:01PM +0100, Peter Maydell wrote:
>> On Thu, 23 Apr 2026 at 13:37, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>
>>> Stefan, there is a comment on #10 (a8af0fb24da) Richard'd rather
>>> to be addressed.
>>
>> I would prefer not to reroll the pullreq just for that -- it's a cleanup,
>> that's all. Compilation is not broken by that #include line being missing.
> 
> Based on Phil's response in the #10 sub-thread there is agreement to
> merge this pull request as-is.
> 
> Peter: Please send a follow-up to fix the missing #includes.

I'm waiting Alistair's RISCV PR to get merged then will post my
single-binary PR with the fix (unfortunately it is based on
RISCV patches). But no objection if Peter has another PR ready
before that :)

> 
> Thanks,
> Stefan


