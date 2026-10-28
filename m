Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67594606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rTs/TbO/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM5yv-0005y0-08; Wed, 28 Oct 2026 11:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM5yt-0005xg-Mc
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 11:54:27 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM5ys-0003fi-4z
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 11:54:27 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-833e671ee9fso1159231a34.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793202864; x=1793807664; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=US9KETajjq6ON6r9PWH4gFrK7CCXSU8ClEgcALDa/UU=;
 b=rTs/TbO/dGTbgWmS0mb+G7fwCXGJRN0cybihxlmrJQ4U2pSd8k8B7NsXENmaTZilhv
 JHpsAG7vDjWrMUTrRotCyGP2AEPS7xTHd1mzPI29AJWnX6S7FhVJ/XTHTzvgllnf0WV3
 cGr4q196JqYt6ars0gz1naJJaD+w/uXuWgjY997bwg9FUPItUqiObpyQotCgzSygiBfP
 z7D4P/ytxek2J65KXd3oed9M6ERVSVX65mZvX82L+ZuFRL04S5JL+qyOGFtWlHCYe3FD
 wcWdj5Nde8Qc6q+SPaG7IrSh3qIjveZLIRokX0DvXixOzDMm4Pf9B1x4Whh4Z49LQqam
 KEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202864; x=1793807664;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=US9KETajjq6ON6r9PWH4gFrK7CCXSU8ClEgcALDa/UU=;
 b=jG04F5k6Anjxz0aS4h+LNrC6JIAKwvJOvZiQqnvQEPISJKhIS/wLwNkeCday7JDfOl
 TvUTYPsbzf6GfToLC0B/Y+gN8QdMwsBk1LnjIU36UMVkTjp2TBhUBc9dCygopuuDD3Uc
 LaJl4jf0bXWTTBDD+tMcQFBeuOi37JaxrMxwurfRTFHDY/o0j5dmb6kRCUTA3FfxS1np
 QGQn+vXrb4tP6E9Sz2pDUGHnon5K9MIp5Xo7MlZTbVMP53TnPU0ezorLZCjAxCFU2o2g
 KLbX0EqiqDuKEOc+iLMyfVIQCrCjZe4bCd/4ZMXzCgqUFojOd/k1ZzBQ51kqULGsaAQi
 uVhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqKYdZlQib2ur3XNQ2ojKu3DPKpydI8ZIKeFbj9n31+PpPest8cwwu/th0EczMRJWZ6/GpQrgk7MgQ@nongnu.org
X-Gm-Message-State: AFq9FYKIulKikdyvna3QDdyJyYnWdjRlvKWHXHvq4Ug2NCncmVRyjVsB
 ZvVhbpTOh5LUl0726/MOvf8tz7LPPeMvgoTIi5ZPlf7AahPfi3uVBsyPYKs8gio2qBU=
X-Gm-Gg: AYBFou1OGPQ+TwU5kdASfzUFVGvsWILLRXgbbAWTjIaQDkjqKC1zQiBUABQAZQicWIJ
 NBiee+bnHzdGOLRIz/vDIPviUG6ogQmi6/y3ZqgERhvv+gKrW5vGH2iIXdCwusQe8K+HihlsG0y
 6Nu/472aTTGsW+HEQbXgRYHGI/yDEsTSHae5yZ1tmjFh/nAzZrQ+nE+xs2UGMx8MHDiP6tnGcwn
 4KuIOChy4ItudOupszi/sgKhZ/gf72IsriJP/L0mknAf5ElVas0rmAV8I6kS/fiSTG8rcPXINHc
 gAbIME9yGAXFWsHq/B0NhH45cdkqj7hfq/GQaLewTfhZV8xjLJBSoYaYYIGXt5SDVxA5j119zLo
 6JMc2ZHxdd66SFOOfT+HdPdtNyAnBMhJE3nQ8wFo1qj83SJuLZYydt05/zBRrbWzL4/wCe4iarN
 aN35rBRKwyQdoOd2NzXTLImX7bFHXSbprLqVallNdQsDODVcea3WXfHynbDLSPAtyl5rb8Xr6EV
 VMhzQCAwtnEL01rYHW8Ic59H9IEjvXhNVjrlj9CuQCH1T2IxNgOcNMsWQl75JUfZigrtOPPmRZq
 NbNQ4OJM2vLFiRVtqcibVMGQvxoxpm4wj6KserPPiGtp70nQscm6Y5c9uxn+yzSN7v8cmXHxNsq
 q2d14Zuz+LRo=
X-Received: by 2002:a05:6830:310c:b0:81f:8a6d:7b52 with SMTP id
 46e09a7af769-85ac0bee8c8mr3538019a34.24.1793202864430; 
 Wed, 28 Oct 2026 08:54:24 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6?
 ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b2021857csm2114103a34.23.2026.10.28.08.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 08:54:24 -0700 (PDT)
Message-ID: <1f141228-24fb-4d9c-a592-fd4ec1a36f25@linaro.org>
Date: Wed, 28 Oct 2026 10:54:21 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/tcg: Do not flush and retry in place in
 tb_gen_code
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Matt Turner <mattst88@gmail.com>,
 qemu-stable@nongnu.org
References: <20261028120233.1664444-1-stian@itx.no>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261028120233.1664444-1-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 07:02, Stian Halseth wrote:
> When the code buffer is full in a serial context, tb_gen_code() flushes
> it and retries in place. cpu_exec_loop() then chains its last_tb, now
> freed, into the new TB. When that TB is invalidated, tb_jmp_unlink()
> follows the stale entry and qemu crashes inside its SIGSEGV handler.
> 
> Always queue the flush and leave through cpu_loop_exit(), as before
> commit ebf7a5d294a3. This also brings back the cleanup in
> cpu_loop_exit() and cpu_exec_longjmp_cleanup() that the retry skipped.
> 
> Since commit 25e5c6a320db ("accel/tcg: Allow cross-page goto_tb
> chaining in user-only builds"), user-only builds hit this easily,
> e.g. qemu-sparc64 -tb-size 1 on a program writing next to its PLT.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: ebf7a5d294a3 ("accel/tcg: Improve buffer overflow in tb_gen_code")
> Suggested-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Stian Halseth<stian@itx.no>
> ---
> v3:
> - Drop the in-place retry instead of clearing last_tb after it
>    (Alex, Richard)
> - Matt's Reviewed-by dropped, since the code changed
> 
> v2:https://lore.kernel.org/qemu-devel/20261024070347.1202239-1-stian@itx.no/
> v1:https://lore.kernel.org/qemu-devel/20261023113245.562358-1-stian@itx.no/
> 
>   accel/tcg/translate-all.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued to tcg-next.

r~

