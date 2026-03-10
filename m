Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3C0FD88CC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 23:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w06Q3-00075L-R9; Tue, 10 Mar 2026 19:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w06Q2-00071c-IV
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:23:18 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w06Pz-0000Kk-T7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 19:23:18 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-8cd8576a512so43009085a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 16:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773184994; x=1773789794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FIMOljJc4SvK025UbeT1EpwbHCcwkJYv3itvplnkWcw=;
 b=GW6nqzvLk9lE/ROkDyDh0IdhJWMCb09Ekfb/1lj+DM3B7owCxWd7OOmYS6kCORqqIj
 7/tZYHAIVpVBlEkGYBBLnmrbrXvua73AuEIdQJ/HrF92SIITBhebDUx+qrp/b3c5uz/L
 FP9FcXaVzu5/tCSUu/CsPNU6fePzftvFtMepiP5ssFISiKkm+/TLQZ0JVUamh3HjNOgy
 8oCaiATOyveHz3SyXXGpz5KHGQvSQeztyfIjXrMXY9eyoRg4LYb1TIl9GB+IVEOuX3Ia
 O17lqU2NXR/eQJmavDRCEuXV9kBufgtaJz+M2GofSQjQqqRVgevoAF0iaPKngdizXTP7
 XhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773184994; x=1773789794;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FIMOljJc4SvK025UbeT1EpwbHCcwkJYv3itvplnkWcw=;
 b=vbH7YDEGSKcG0zTo2pA1bMp9Tu7++GiQf/ITj5e/q1jKEVQDkRKk9uvmToFXxBJmBQ
 Nh0hqpk9q01lrVnR2EEJ4hf8IZEnO7f6e0ZDhAz1bzugcwaXAGs+uF1eW3rdgCWbKuXl
 LL5kJtfGbXGkhlrPbhWuSGNenFrIz2tIw8+/JVntIgt5VrqwfDXsnNDgJcu+XRnEWhhU
 +5Ct4DqQgawElD/pTqfRCJFqmihZHor+ao+6bgtr/iiCNfNgd6qqc8wNeu24lLRwVPMP
 xjf/QqE7rLdIkoDGUGOr46+0D3aEByTPGweZkBYVxj6wgLT+E3B+Awplg2h417r9ywfm
 YgEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0Xg8TIGylW+IWTyp6muZFMQZGY7Sw8C7jdztf06eFZobVuUdni5ygGIP5Mf2H8bRjjFeDqIj+Pbtl@nongnu.org
X-Gm-Message-State: AOJu0YytPg9DDwJs+DdCa/p8M7Fj4OX89eb/21GoiXAS83wfWFlpTDem
 qXsS4llItD5IuJ1HhRPFaB2VJcqW+L0v5rcgVhZI9Dq9hbPxCqMz/UmDNj+Ffj4NU6c=
X-Gm-Gg: ATEYQzzmwFPkN85R58haCeEdIIS3phuOWCwitHoUqgWzsO6qaCIH3n82SJizcTfrwmw
 2dMbU3EfsVdBP91B1z7uugrcZvSaN1SJ2pOwxUEsEpj8tXHz86OSHWMRFyJWtOKIdIrwSHmRQL2
 1bsuI7ebIMtZdtN70SozWqeRJFhh8jYJDqvo0nAv16bppgjpA9BRL8EQ1v/3f/cQa8PZx0CCMsa
 wjA+imbG5jzb2+YjN/UsqYkc+pmjv15AXElMdlmopJrC+DsdA3apaZ5MXIOotjmo5y1IYa7OuMT
 aAnhYtoV9n4GJueBCx6kUSa09Jb7mDWazUrv5nQosm7k6U66nGcxpIHzO0GZL4XfugsYSxAjOBT
 UhQdCO8iFtt0X7h67oIdncsR1WILvm5MLbnbAiPo1sNEJoIDX+mY4htGXQsMAeseNcaDKFgOeq8
 pjf8PTiVl88QZ5VeYgQOPxvF2MHQWlEwLOmSmqr88zfmYs5Ff2BGqxVzoBEf5OBLP4OiW8
X-Received: by 2002:a05:620a:1aa9:b0:883:647b:6dec with SMTP id
 af79cd13be357-8cda1ec550cmr72454085a.3.1773184994363; 
 Tue, 10 Mar 2026 16:23:14 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda210da83sm23567885a.30.2026.03.10.16.23.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 16:23:13 -0700 (PDT)
Message-ID: <0c40598c-41f7-4550-97db-83e78634ba6d@linaro.org>
Date: Tue, 10 Mar 2026 16:23:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/16] tests/tcg: Temporary disable multiarch tests for
 PPC targets
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260310232045.58440-1-philmd@linaro.org>
 <20260310232045.58440-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260310232045.58440-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72e.google.com
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

On 3/10/26 4:20 PM, Philippe Mathieu-Daudé wrote:
> gdbstub is currently broken for the PPC targets [*]. We
> didn't notice because our tests require gdb-multiarch which
> isn't installed on our containers. Next patch will fix that,
> but we need to temporary disable the PPC target test to keep
> our CI green.
> 
> [*] https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Message-Id: <c957fe25-a0a2-405f-be83-d411261c21e6@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/tcg/multiarch/Makefile.target | 4 ++++
>   1 file changed, 4 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

