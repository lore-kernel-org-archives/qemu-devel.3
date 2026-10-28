Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1604E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VvqDJNP8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM1Ja-0004ew-8d; Wed, 28 Oct 2026 06:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM1JW-0004ef-7e
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:55:26 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM1JU-000883-Od
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:55:26 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7f48c750afcso571007a34.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793184923; x=1793789723; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mnqQdl/ugx5prSckYGNX+2TjiKpMR4iqfYe/AOC/EcQ=;
 b=VvqDJNP8Lwdc9X2m1PgswBFJkXKTT0jRdG4XFZbXmQUxMEkEP0ZdbLUKtw6IMdTxFq
 o//cX/bqPiaFUQ9gfhBVBBl4fYCRJ0waOfOhY1njeQQn9Y09npvPPrJt/jdIEliFXal3
 zIrxq05aHK7JosnRkNCtw3Qef5rnkDIIXEw+oIa9WMjdXuUq01EWZuWCtaqfyPAkFieO
 fATXOXjStoYC7KLLqd+kCopEBbqjc1s+Nxph2VjpNpB26PaQstSgkLQ6z1A/DpR4exRH
 wElRa0freDXuZQy4LlppwbnVpbX7EKnO4BlDxMvBUC3JpsHvIf6cRlwfQPhRARSRReiG
 Ml1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793184923; x=1793789723;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mnqQdl/ugx5prSckYGNX+2TjiKpMR4iqfYe/AOC/EcQ=;
 b=CYm5I6h0VjgZDeP3dEQeB+i4NWIAP/5ZVLmgkdTkXCvQk07rJqLl6fLOqJsHJBsrli
 XNIFL4uYPd5uN91DJ7oFLu8roN0EX32LAJMmreMVBNqGVKCHC83ysOy/zj4XiEcpNhz9
 RZU7Z6N1IScW7pNRHxocaUJVH0298r505QqWzDQ2pymMAUjcIQYbN5UN3zIYdoLjD/+p
 zsd+X0zA54rzy0Qw7pzCIdcWwMi0agPMvIvPs7EmH1QtmsOUp7RF+1e9Ci4dEEIrwU2E
 XfjLsxENd1NLAjh6IZFve5wO7Erlq5CFj/9AMvuh1MnY9JU2moQxUxGIm3davhMqsQGJ
 Ylpg==
X-Gm-Message-State: AFq9FYIxSfrlxcooR/iVAbCMhiK6LYKtFHCVEsHkE3xfiScuUoVT5e4J
 xsD0qsiQxySYauIcm9vvHa4n5GgJ6BTICiJ9LbR+t/lCyIGpsRs0ZZWTQNy3Sgn4RXE=
X-Gm-Gg: AYBFou1s2cBwVN+4F1eGTtbYKU76gD5INv+u5HnfaOMAeW2N5PZIvXEn+GmEmniOQei
 rHnO8Ry7HwEAD2i4S3vkxPWiQY/As7qheU6+rvwhEeJGtV2ZjBtJZbPj8SgWHCkT3VBU5mNmTU0
 PgmVuL6DHrlUJ2e6VXpb2OBiItGie9hMyL4SV91ionP00RKLpvBbi2V3enN7Zf97k3VEwL0jL+z
 9b64D/hdRA1gunEwRkJGX0eaCeI87Fq2G80yzBAhVxzTuGUsUMu6QRQMkXhtG3C/Ee5QhOgXlUx
 i8Sm0JDZJGQVEDVj0gVD76RzQhykxYUzbmxm06VAzuIdRnS96ScXBZPIG3GB/wP9bAABZ3zydlA
 ihXOqWV0lbO6Lm1YMIvDmBfgeS8Pq7GIYfX/XPzB3aEkdVklI0ES+OkawerbOSn2S165LLJPfWh
 xFwz8lbLP1BNPVgSqPXmNKWH6e/0Rm+a3OrHqO0EFf9L01GNF1JnMw3Zi9NKWwq0R480EtHpDo8
 AodWcn0THon1anmE/Ri/nPhvbgLq5XW9lJtj9sNijqpPpBCic2BRjFmYrqgq+HxzHuKcAhWvw0i
 hEhS24/uTHCpCBBptzd55IrxODE3xc8LW2xTYy+W5L9w
X-Received: by 2002:a05:6830:7196:b0:844:4959:e840 with SMTP id
 46e09a7af769-85ac09026f7mr1772806a34.21.1793184922784; 
 Wed, 28 Oct 2026 03:55:22 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f841563sm1217144a34.12.2026.10.28.03.55.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 03:55:22 -0700 (PDT)
Message-ID: <f0b32242-7099-47e8-9c5b-9532ae3fecbe@linaro.org>
Date: Wed, 28 Oct 2026 05:55:20 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Do not chain from a TB freed by tb_gen_code's
 flush
To: Stian Halseth <stian@itx.no>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Matt Turner <mattst88@gmail.com>
References: <20261023113245.562358-1-stian@itx.no>
 <8733tws5yt.fsf@draig.linaro.org>
 <a1b9fb9e6c9c5bd6e7d3b5ebc0983662a39629b3.camel@itx.no>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <a1b9fb9e6c9c5bd6e7d3b5ebc0983662a39629b3.camel@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 12:53, Stian Halseth wrote:
> Hi Alex,
> 
> On Fri, 2026-10-23 at 18:05 +0100, Alex Bennée wrote:
>> I wonder how much:
>>
>>          /* flush must be done */
>>          if (cpu_in_serial_context(cpu)) {
>>              trace_tb_gen_code_buffer_overflow("tcg_tb_alloc");
>>              tb_flush__exclusive_or_serial();
>>              goto buffer_overflow;
>>          }
>>
>> actually saves? Because we are skipping both cleanup in cpu_loop_exit
>> (the mem helpers) and cpu_exec_longjmp_cleanup which we get to when
>> we jump out.
> 
> Not much, as far as I can measure. I timed the sparc64 reproducer with
> -tb-size 1, where the buffer flushes constantly, so the worst case for
> the longjmp, with three variants on current master:
> 
> - this patch (keep the shortcut, drop last_tb)
> - flush in place, then leave through cpu_loop_exit()
> - drop the shortcut, back to queue_tb_flush() + cpu_loop_exit()
> 
> All three fix the crash and pass test-xpage-chain and tb-link, and the
> run times are within noise of each other.
> 
> Dropping the shortcut looks like the cleaner fix though. no last_tb
> bookkeeping, and the cleanup you mention runs again. Richard, would you
> prefer that as v2, or is there a case where the in-place retry matters,
> e.g. cpu_exec_step_atomic?
I don't think in-place retry matters anywhere.  I suspect it was a case 
of premature optimization because "obviously" no other thread can 
interfere here.


r~

