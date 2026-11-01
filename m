Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184B606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RIsxCnUm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNYXu-0007mR-EB; Sun, 01 Nov 2026 11:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNYXk-0007lL-Rk
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 11:36:30 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNYXj-0001Ds-2P
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 11:36:28 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3a4b3ac8fb7so1351615a91.0
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 08:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793550984; x=1794155784; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t4G7yLfaODdX+/KYQMcI8KQ15otvfgeMR9Dh1eDWK9M=;
 b=RIsxCnUmKKRLOJs947EZN9drS3NxGW1yOBfqLFIcgk1/BEfK2WrEhfbLZAaR9z4Jzs
 Q5VVTRWsRy+BG/tfghfpEa0B5zfD0N48yKuDER8JWg+41WA4yYPs0fEZELjgGQnlZT8r
 cvc1TlL+RKi5IcjeCQ9oYamfRQMKR8kZjvxyEG5IKOFqN62Fzd6qm4bW7cWKxz+eqdQ3
 9/akjF0FiLeco7pjsc1ZQ3GjcM8WvoB7f73MGAYBwDmCFg7FnaxNK5evpuvr6/LnyXUc
 DZEM8qKFi49Q1j1owrsb98UrabPpAKC4OzXfcjDzVXo0tgl9Dz0thPsIDDl5pNjUCKoo
 eIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793550984; x=1794155784;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t4G7yLfaODdX+/KYQMcI8KQ15otvfgeMR9Dh1eDWK9M=;
 b=iFwXSo7XgwfdeiPZaZwGwpAyE6WSeea0jnKbahrNxzBa9c824qshD+mnIDQoKReHlj
 gE4kEhWLXX0/AJVekomYgNR/adExV280weORKocdeoTfIgAdo6SktDfMXkMrCa37mtu1
 Xn9TlBGgiI+I6EXiVaSAbXo50nSz3fDLHh/dtAVUOYsJ7KQR2mLa0JFjpPwOE6Az26bK
 g2Kkufop5XSrgyfw7JbawinqAZcChjKBs7dne7+BT9tGUrw+Dc5ay3Acve634FkRMk4z
 OYoaAx421ajFMzycxgXn//LyYapT32IXc2/drmYiPm5IHN0YgRUcGl8FvmYkiGn486FL
 Ix7g==
X-Gm-Message-State: APuU4Z+/CX0EaRIudmhhWPsEGuSM8p8Ph6sp1DkGEO3PKR/4xJrBw26l
 Z2g/l7HiUDEKrn5elTmhrljjGnwF/sH3m+0Pns4P6/BcegW0rCO5U+heM2wFzfGTsjvK3M47j7l
 8tz8q
X-Gm-Gg: AYBFou3Td7IcuRRukNC81H7scju4fDlxBJYi4JaWOPBtofIeiiHD8uU4S+dXZavmb0F
 lL6xi2vd7ta+wtEl88ODUaZsITWXppBM7ZN9zM/MAmueYA8Vf/Kdm5vQVRY6uO24ksounVHcxoO
 J4xb89HOiW3MHk36DUMN5GjdFFy5eSqKl3YqeGm4qoQ3syC7es1TaquUkb+BUHKWLgeslpxPKTM
 OIYAT5l2qQYnOFIhtTWX31Nm6gYd7gC163EZmEcnqSCU+c5dd6ZJIMTg9A12ubhDwwBFm4dvYk1
 1o7poIisvribAIU4gO1BCklZCLH+WuyQcHJ+v34QweHXbXzJXhPEcOwQ5tiqCtoT7Q33PI7B90a
 W3iQwroBzSZAlXpqKMPR/VkB9iam+fKx4Bbcj8jvsZvAlsJoBwne0LK+M5EuWqrGrbK6mX8BzLQ
 hoUkMNIG8isK58cqfcagdp80KOOTWWKnWoRMQibEnseQDmse9kBzqvSVxGm5roLBtVxBZn0FZfq
 maWFTRqGKVXmkfED1bhlBv3sdOXyCly7QIFAhv5o8b57k3a6S+yiRSp1rOxt0wqHpB59W25SHDw
 1ZNFVPPBISj795uZ00+Kgd2oNJHbGae/e4B5LgRIiomTNWjz+SpOe9uiHuPWBQ7VrcKYckY=
X-Received: by 2002:a17:90b:2741:b0:3ab:36c4:b4ff with SMTP id
 98e67ed59e1d1-3ae8974666dmr6683851a91.24.1793550984262; 
 Sun, 01 Nov 2026 08:36:24 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e9583c1sm15890183a91.10.2026.11.01.08.36.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 08:36:23 -0800 (PST)
Message-ID: <7b373e83-bd52-4b8c-a301-4464379ae0ec@linaro.org>
Date: Sun, 1 Nov 2026 08:36:21 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/10] meson: rewrite scripts/qemu-version.sh directly in
 meson.build
To: qemu-devel@nongnu.org
References: <20261101095851.1557351-1-pbonzini@redhat.com>
 <20261101095851.1557351-11-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261101095851.1557351-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 01:58, Paolo Bonzini wrote:
> Invoking git and creating a .h file does not need a shell script.
> Embed the logic directly in meson.build.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   meson.build               | 29 ++++++++++++++++++++---------
>   include/qemu/version.h    |  8 ++++++++
>   scripts/qemu-version.h.in |  1 +
>   scripts/qemu-version.sh   | 25 -------------------------
>   4 files changed, 29 insertions(+), 34 deletions(-)
>   create mode 100644 scripts/qemu-version.h.in
>   delete mode 100755 scripts/qemu-version.sh

Breaks MocOS builds:

https://gitlab.com/qemu-project/qemu/-/jobs/17645754424#L3655

> ../ui/cocoa.m:1527:50: error: expected ';' at end of declaration
>  1527 |     NSString *version = @"QEMU emulator version " QEMU_FULL_VERSION;


r~

