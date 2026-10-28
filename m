Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49C606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fnUZbQiY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM10f-0002EZ-8C; Wed, 28 Oct 2026 06:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM10d-0002EL-Dh
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:35:55 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM10b-0006BM-Pz
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:35:55 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-845788309b4so394363a34.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793183752; x=1793788552; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eHyNVGU4u+RO+iTsnsHf7NZInnSleoZ7ip0RDxTOxbg=;
 b=fnUZbQiYQO8KsOWPFgqsDLMnGz2KCc/TElKQe+uuoy4X84gWfFLCoiM4F+mY6qZD6/
 Kf9g5LHkq4E3tHcqIqg7ZMXsNyunSzUx0Y4mandtuQErUiDFt+iy1SeOOPW7TvDCl2WR
 HWO96hUHtOQkJe66nqKgx/BvlR/kK6dYlDodlFMm1j/O5q5VZD/c5gY5hSRwNcEL9RJN
 vNlefSE7XE/nXOT//X1CHBJqbYFctUo2KtildXkuUK+X6DtU2LHCN0VEYbwOeNTi11H6
 OMHszD49VahnNDm+QWD6GoksIzYtIeh9/ar8FhizSJ0uQTxzV5o1ntdou7R1k7w7lVWL
 H5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793183752; x=1793788552;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eHyNVGU4u+RO+iTsnsHf7NZInnSleoZ7ip0RDxTOxbg=;
 b=nA9YzFDlvUVgvagpwcLQT3gG7BXweKVZUGNP0S8gWXhuOBHc8yhdsoB7aVbSuLwlJ1
 03j0+HmqvG2dunqgJzb10o0bTtUKZ4tXL330fKZrdePUNVgc+XHxuDdLOVJ2680iqXb2
 ov8txX6kqORUIg1/3qrNiYATOOWumz48AJrp4Jy6Ye/58k9Gkr6T2nv7azm7pNN83+mO
 JIHaFoV+l7LzNKAZuCXXminvmUAehXzXqj1RldwYAH/HaAfRcGBbDyVLa8zZKXuDAEtl
 8Us2/mFVTAKCcekhFskz5cQRqBI/GT9f9WG/ivkQwqJ4jJLZZt1awxoJ12CJVBX3sZIf
 OabQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxy1oRpNgEFAfED++YWHJOws8h6FsEBrs/WzIzWlCUhrWaqhWbvUIwUw3JfMdwMTLabs0Z3zJu2afrS@nongnu.org
X-Gm-Message-State: AFq9FYIaE1dAzdxoncipndT5y3yJYTbHIDOfa89wRKRhnHHm3lS4VrUd
 cRcrhXoNaoZBpocet2ijZA1Avv9Ju0N7hRDSvPQ9ySM2m1vvKfLC5PNHGSmxnzrgCJE=
X-Gm-Gg: AYBFou3fMkhQriXWP2OrbKE0lHGg/VovMphFwMMz/jjRH6OCyBU6jlHeR33nkcMygya
 198sYhRUosbrVhc+ofYJrt+nkfhDtmXkdbGRCu7/3tCWmytCvHBdE+TvGyar+gwSxom8aRG2apY
 qk1plIGklmaLUNfIov5whHla4VsQReA8/TpZpFiYZD2ICQ7Mvlb+3prDmRXYaf1DNdv6coiWM8+
 E2O4QC+Dnv/6vDLSoNvs4t58A0kdOgsX9rbUqis7qhBP8yzkSSjuURNk8IYqLq27bb0NcWruTaR
 4SbtiuFhRUSUBHnVnE4rc23pC4SrL75QBlb3tmtqZDIufdbUlt37EDtRLEELk6EauCKf4c7CcRs
 A4CKyX0NBkCw8ddrGvN9p73MhSbXqksdZyq/DwpXoIui3/+fwE7Z109EtKFx/tIANdljLjnlezI
 I56ScJWOvn/R90RNjZ/r8v/TZnEVY8Z29U+XYyYkSrc6pkTO341xipLtg97uZHfVHB866LJ3Z4R
 ZlYyNqwg3ImSTwoxsydLTSdK++Rg1PHF040EPvexoJXENpGyVZSLcMzf3X22D2hazpuemlewX+P
 ECyfAXoM7IrOzEe0BkUqnx2FHvSHtWJ/5hMhMEh6MfCxIf2kKG5xJmJ/T2LuXPcdOQ==
X-Received: by 2002:a05:6830:211a:b0:85b:895:a01b with SMTP id
 46e09a7af769-85b0895b5c2mr1085369a34.31.1793183751994; 
 Wed, 28 Oct 2026 03:35:51 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1f84121esm1279623a34.13.2026.10.28.03.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 03:35:51 -0700 (PDT)
Message-ID: <b7aee934-729b-4bc5-a95f-80ecf93eec69@linaro.org>
Date: Wed, 28 Oct 2026 05:35:49 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Use QemuSemaphore to wait for clone child
 thread
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261022163718.562442-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261022163718.562442-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 10/22/26 11:37, Peter Maydell wrote:
> In do_fork() and clone_func() we currently use a pthread_mutex_t and
> a pthread_cond_t to allow the parent thread to wait until the child
> thread has started and e.g.  set fields like info->tid, before the
> parent reads those fields and otherwise proceeds.
> 
> Coverity points out that this use of a pthread condition variable
> isn't reliable: pthread_cond_wait() may wake up spuriously, so the
> idiom for "wait on a condition" should be "loop around calling
> pthread_cond_wait() until a predicate that was updated by the caller
> of pthread_cond_broadcast() is true".
> 
> This is quite old code; rather than fixing up its use of raw pthread
> condition variables, we can use a QemuSemaphore.  This gives us the
> "thread A waits until thread B signals it" semantics we want.  (Under
> the hood it is implemented with a mutex and condition variable.)
> 
> Cc:qemu-stable@nongnu.org
> Resolves: CID 1527417
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> cc stable because in theory this could result in the parent thread
> waking up too early and weird stuff happening; however my guess is
> that in practice with one waiter and one signaller that the
> "spurious wakeup" case won't happen. At any rate this code has
> been like this for a very long time.
> 
> Disclaimer: tested with "make check" only, but that does include
> various linux-user tests that use multiple threads.
> ---
>   linux-user/syscall.c | 17 +++++------------
>   1 file changed, 5 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

