Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6447ECD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQFa-0002u7-FL; Wed, 10 Jun 2026 17:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXQFW-0002sY-VT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:11 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wXQFV-0005fL-E9
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:14:10 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c8585cd8400so2827164a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781126047; x=1781730847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MCxOlDbh55cYOPjTNWzgocd1shUMh8BOeKaBm52uNiI=;
 b=hFRef4KONlCQnUXTbwjoCCKl5OoiIuSdDJ6Gu8bL8T5IRcvi4IYcNpF/7XomdPMIDn
 SsE4MM9rPYpwZxLBT340t8pYhsHsxCodzZ8iIzl/6cpmQXZt2m7csacGu4tDLpNR6nmp
 GZW4F4mwac4JnfnWCaCnfCKE1ntj+PWu6LwtDDwboW3gG4KrGsvwQ8oHcAx199fU68UW
 dy3lx3iIRxbKxG6B2CT8WFdAx2iMpa7dYrsgSAs76WXbxAa3ZDnVwxhmen9VzZPVEeLN
 YKVd68fWVByTltxgV7/hfCLw4Ia66i/8RWtBfB72PzoFDu0Gy4L3K5upMsUfO9Hl9wNT
 eC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781126047; x=1781730847;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MCxOlDbh55cYOPjTNWzgocd1shUMh8BOeKaBm52uNiI=;
 b=eRD+WG+8kfkMFS/b/uR4JTBynymjRXl34L8TjQaDcyhrTx/nQzuJ48i79gPqHe4sG3
 jmPaiI0bV1BrbiM+2k/sDK8aETm8FHqmjjWq0pnAk+fw8n6fxPA8NQAbHeyCBhc/7fkA
 t3Cvsd4EuXZbBqYNclOIXoUJe2W6zS/sY+SaKj/XdKTgle3ZNlu/rs+gxJAvdiyAlAkf
 cI7QSLfPBx2zjzzxjtv30Q8q1T2hiLk6MyBloES6m+RcSBOX6VboW+8xhemu39K1xnJv
 yn8t5KEbS/ork/cDBEbVZqhTS2+x92awSj7TNnGQnCXl7elQzEbbg2Ll1XDZ8OwWIV/v
 SQVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6gc1b2ZX+zJe0PmAvyIww2kD0PEDLXjS9cSsEDA9L9sGnSeCKZWfKLYowMoqYULISZ+mUlX9Y0Pln@nongnu.org
X-Gm-Message-State: AOJu0Yyusz1XhTj+st3UXwldyqByFLgkEMLXgW3ua7uY0eQUK1QFZEBL
 LXAyQ903uZ5S3YSDng+vefcgeXnOelZJvS382T9F5SveQcFGhJQlwTqyPy8c5vAO3Y4=
X-Gm-Gg: Acq92OFqfCdxaYLX/PLZxbsz/OpIono8hoh+MM4OSHh5Tb1qCM7VqnMNe2BgtboBX1y
 brqbI8b6ec1C8TPdCTF8EdMfJH/pWTZdF9WMErDnCkKcaJvCge5+7mA7Im/w+Zbspq+CspdXYzR
 Ch5OyV2bI3mFaP0ACu8HzSa4bjfqbjUh4XgN88JvQgMK1erIBV0JIGXFKz2LpddgaMaB7HCTCmL
 5e33OLxDXXNb+bS+BiU43djRBTY+uzsbu1mCkexLKVEB5i0Rt3wz2QRO9gNAYMhYZVsh7lHsYg2
 bIfaP2jj+wzp4xE+GwRR/0G2vw5I/2uhZWE+Yl+bYc0OnHJqUDsn9p5Tja4qBRtiYfIhmYrYLxY
 Nb5qfUjUuX4Scc55Aqk94BUkuJ07/ZQXG0VVpTkCUhXCEbMctgCrj64YXldiv6MmpP8UgJmoyOe
 cUfJ9XH9ezSer7cvmJM6mEkcMx1dNO3WVgisPL1BhPpgSI43E=
X-Received: by 2002:a05:6a20:c793:b0:3aa:f2c7:fd87 with SMTP id
 adf61e73a8af0-3b4ccf46acfmr31355606637.31.1781126047165; 
 Wed, 10 Jun 2026 14:14:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df04a0e9sm19113459a12.13.2026.06.10.14.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 14:14:06 -0700 (PDT)
Message-ID: <7f61632a-cb7a-43c8-8d21-620049e0fd4d@linaro.org>
Date: Wed, 10 Jun 2026 14:14:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Implement /proc/cpuinfo for ppc cpus
To: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
References: <20260610180749.10883-1-deller@kernel.org>
 <4853852b-015f-4e16-aee3-7750a35b9c78@linaro.org>
 <a0d36607-035a-44f3-9750-397364a83059@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <a0d36607-035a-44f3-9750-397364a83059@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 6/10/26 12:13, Helge Deller wrote:
>>> +    if (clock_getres(CLOCK_REALTIME, &res) == -1) {
>>> +        res.tv_nsec = 1;
>>> +    }
>>> +    freq_mhz = 1000.0 / res.tv_nsec;
>>
>> Seems ok.
> 
> Yes. But it will allways print 1000.000MHz, which isn't that useful either.
> Shall I keep it nevertheless?

Well, depends on the host, I suppose.  Perhaps we can get away with omitting it, though I 
suppose it all depends on why you're implementing /proc/cpuinfo in the first place.

I'll note that unlike "clock", "timebase" *is* used by glibc, but only if we don't 
implement the __kernel_get_tbfreq vdso call.  For linux-user, cpu_ppc_load_tbl() uses 
cpu_get_host_ticks().  Ideally we'd report the host_ticks frequency for timebase, but we 
don't have a function for that.

Perhaps we should switch cpu_ppc_load_tbl() to get_clock(), and then report timebase = 
1GHz.  That would certainly make the vdso implementation simple.


r~

