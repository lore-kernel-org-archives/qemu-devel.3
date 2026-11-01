Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E3606A339
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bZ59+ah2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNXh2-0007xc-F3; Sun, 01 Nov 2026 10:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNXgr-0007vj-0d
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 10:41:49 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNXgp-0005V3-7v
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 10:41:48 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso1485602a12.0
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793547706; x=1794152506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TKCr78rY7B4CmOWUVNMZs1uhh6HiJPJ5w7bth0tpdZc=;
 b=bZ59+ah2usqjDKDBABWZX3/3WsAnmlLHQMAwFPDZ60AVSLPUeqgj4HdcnG0vlF4LLe
 skNkyzwnwJREa2prLpjImWLfzBl9uhi8x4Qd4g5QHgTDMzS1U8Ye1bsqxkW/GZPwG1Y2
 O4ERE9Mrqtt5uIruKQozePOztmVAkRc2A+I3dr4p/AG1rffIym7UR2OfeIuahWLtFHnF
 FnJHfeXfaDiclzWT0njEirZfucXpfGx2mQ5fiLoO4abT++uwielz879FoCyrfwDzAZXt
 BidooOtvv7eL/GSs5ceTSE2p3321bFXwN6N/Djp/5VPvYQMBZtikFkZD+7ti5AjUlV/G
 WECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793547706; x=1794152506;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TKCr78rY7B4CmOWUVNMZs1uhh6HiJPJ5w7bth0tpdZc=;
 b=UP9hjkbLyXsm+E72Q/x0jbC3i15UHxCHXYohWwCNKNXxQd6HgJj/UiSBXuoXkYrguW
 Nbl9zlz2f12J4jW1samiblWqyB6eS33uBQ+jc7Efxp8mj3OkxhArXRMIx6d7euoUUS7u
 ANzVH94ry7vjekrG+wypTrcqhR4wPkXhtLfFgGlfghdCFpfNydVibvHnk9oY3SrVaO+s
 2oleLwb/Cgmv/rcBRaK8xRKAiLLPdrl45Ouk/5q9pyAJIxm1X/MVWJ++n3j51086mM3U
 N/Du+zz+TB3lZZEDNdiZIzjx996pVoX8ySnD2P2feWuOgWO2RaMm7A/n5blbcQ3mUBZo
 3eLQ==
X-Gm-Message-State: APuU4Z8M1jtELxcyw6PnXovIheaR6V5JpdQUFFXyPptKl8FiOSLnCoKa
 JCBPZ+AeOAzjyfr2TnzTKhN8qWz6jVKk4knyY0b+XDRSKkeAfs3Nz43Ugpm8wcfx1Tw=
X-Gm-Gg: AYBFou0h3rH6pC3+GkmF6vs7wsaz/eS3k2gvJ1R8ILoXSn4AvmrN6d3cDnxKBBVRNHo
 lyRB3cRlGrAoRDWhUWvg5YpV1leGfymk2fwmeAxA6oMaXBbYi3rBcilE/4csV4/SEIzNvtrW0ag
 Orp05k4cp9cxoF2kUUBqg9nqLWX16O/IQ/d5wQQURKpQ1lZ5DncmgeJsR0gRPo6Cu6JTa6Ejd2A
 Sdo1DbVpIGCdQrWVX8Br5dIy1ouVGdiEh+EjqwzQii2OKhps7+rIpcesUAR2KJSu1IaadYk/tYv
 9zt5/nCOW6tRAVskHC6cjtHbMFKQws3B75A3WISuDx3iYCDsmZqs5shFUdd8cVzdWukhrqMQDdT
 +VUUPT6k+xV6UN4Aj/zbuk+fEjlZ2ftelCjpiWi0ODONIB4NodcgmtSvkBfJaIv0NfIuG7bhPkb
 1dABQCsJTi61/RodtfI954KuDLucBxQdylGJIupiYNrzhUxbMFwtLQ3nsa+rQG56x8B1cXd+SIc
 dQySC2lm2Ub7vDDi23bA3TbXV38SVZFvCI66Xzs2q+rYH6AaJD/EttJsqRFE27zzGblrZUxcWxX
 eTl3wuvyTWOlxzJ+uDXNljXYF90oHpTPAAMaMqEPYsnCPy1NER+UGNDonHEZWWWl5D02dw2rfEu
 gghWRum56eB+nM/8=
X-Received: by 2002:a17:90b:2b47:b0:3ac:860e:1af9 with SMTP id
 98e67ed59e1d1-3ae897cfe6dmr4477900a91.41.1793547705428; 
 Sun, 01 Nov 2026 07:41:45 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845fb9f6sm10250147a91.17.2026.11.01.07.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 07:41:45 -0800 (PST)
Message-ID: <9463f02a-1d1a-407c-87cf-4dd8f8d00a4c@linaro.org>
Date: Sun, 1 Nov 2026 07:41:43 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/19] tcg/x86_64: Introduce TCG_REG_NONE
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Matt Turner <mattst88@gmail.com>
References: <20261030131554.41208-1-richard.henderson@linaro.org>
 <20261030131554.41208-14-richard.henderson@linaro.org>
 <CAFEAcA-Bb0PrHh4MCiWt8QZSAm-o=9ENiP-EBBVDrfU5WQCHAw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-Bb0PrHh4MCiWt8QZSAm-o=9ENiP-EBBVDrfU5WQCHAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 03:30, Peter Maydell wrote:
> On Fri, 30 Oct 2026 at 13:18, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Rather than hard-code -1, or compare < 0, use something
>> more descriptive.  This also allows more use of TCGReg.
>>
>> Reviewed-by: Matt Turner <mattst88@gmail.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>>   typedef enum {
>> +    TCG_REG_NONE = -1,
>>       TCG_REG_EAX = 0,
>>       TCG_REG_ECX,
>>       TCG_REG_EDX,
> 
> This has resulted in Coverity producing a set of new complaints
> (CID 1689946, 1689949, 1689951, 1689952, 1689953, 1689954,
> 1689955), because it now assumes that variables of type TCGReg
> can be -1, and that therefore code like:
> 
>                  TCGReg reg = order[i];
>                  if (tcg_regset_test_reg(set, reg)) {
> (from tcg_reg_alloc_pair(), but the others are similar)
> 
> might be buggy, because it hands a TCGReg to tcg_regset_test_reg(),
> which uses it as a shift count without checking for the -1
> possibility (which would be UB if it happened).
> 
> Should we just mark all these as false-positives, or is it
> worth maybe having operations that work on a TCGReg but
> don't expect TCG_REG_NONE add assertions against that ?
Ug.  I didn't want to have to add that many assertions.
Maybe I should revert the few places that require -1 to int.
Maybe I should use something other than -1.

Perhaps all false positives for now?  If I adjust anything later, it'll 
refresh itself anyway.


r~

