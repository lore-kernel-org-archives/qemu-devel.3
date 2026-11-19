Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69A2606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 04:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=mNm2NjS2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTtfL-0002Ro-6T; Wed, 18 Nov 2026 23:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xTtfJ-0002RG-9A; Wed, 18 Nov 2026 23:22:29 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xTtfH-0007BP-5Z; Wed, 18 Nov 2026 23:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795062142; bh=XP2MCza3qnJH+Zv1tN45/HhkNUSjun5cHhLJyJKCrGg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mNm2NjS2zFeV9fxnp4Lu5P9wVbdeN+ncCjyeajT455UDW++Rkms6jVp7C9lH7Iiss
 1HhMcS9tR16ORmbFc3P7uwpVSA3YIIpGUzDaVKdOLmwtoP0ogRtiHHk2zUx80P0ou7
 C0CZbuZHemQY5yS22Pe4bttUOAr5UGG4/LbZs9DxofHwYjSv8n97Qqc/tOQtnUyxWy
 crNiIlHFKQSwUiqTjt82ZAlBY1Iykxd3/NUj39qiwkOhiHAq4BSHy5r/WAvn1KxRyO
 J3yxyqWyYKfHQlNgKWpvRl/qYDj7bH4sc1vUBQv1yyREOD2d8sOZRgs9GCn5OZfrmx
 N56k17rjOPokA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 619931E7CBC;
 Thu, 19 Nov 2026 07:22:22 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 521FB461546;
 Thu, 19 Nov 2026 07:22:22 +0300 (MSK)
Message-ID: <960694f7-95d1-4615-9174-3f1923d6536b@tls.msk.ru>
Date: Thu, 19 Nov 2026 07:22:22 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: treat ENTER's size operand as unsigned
To: z Y <w1355457260@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 QEMU Stable <qemu-stable@nongnu.org>
References: <CABG6VKODisrETOuH5thhimg_DtJLH+1wmARKL5OsoND5Qse_TA@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CABG6VKODisrETOuH5thhimg_DtJLH+1wmARKL5OsoND5Qse_TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 13:10, z Y wrote:
> The first immediate operand of ENTER is the size of the dynamic storage
> area and is unsigned.  Decoding it as a signed immediate sign-extends
> values with bit 15 set, moving the stack pointer in the wrong direction.
> 
> Decode it with I_unsigned and add a regression test covering 32-bit and
> 64-bit guests.
> 
> Tested with a minimal x86_64-linux-user build; the new test fails before
> the change and passes after it.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4643
> Signed-off-by: Zixin Wang <w1355457260@gmail.com>
> ---
>   target/i386/tcg/decode-new.c.inc |  2 +-
>   tests/tcg/i386/meson.build       |  1 +
>   tests/tcg/i386/test-i386-enter.c | 42 ++++++++++++++++++++++++++++++++
>   tests/tcg/x86_64/meson.build     |  1 +
>   4 files changed, 45 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/i386/test-i386-enter.c

This change too looks like a good candidate for the stable qemu series.
I'm picking it up, please let me know if I shouldn't.

Thanks,

/mjt

