Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7A606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WVTw+Nnd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWBCC-0000tX-LW; Wed, 25 Nov 2026 06:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBCA-0000s9-Ju
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:29:50 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1xWBC9-0008Af-1j
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:29:50 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so3620663f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795606187; x=1796210987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PLhpJz27100xJ4lBejKqYddNXOJStc6+fMGHCxhwep8=;
 b=WVTw+NndcFnParXjUEoYgOJru19TUGGx0Kwt110zYaCXuBQVS3vrxZBaNuYukAdrtP
 sYm0szWTND/1d/i23QXYPp3rbjA9XfM/Zm3iAK21jDyw53BpfhBnaPc2u2B/ZRZSErnX
 GyZrbRWt/I/+22vPEifpQJgSc7b9Q7nQkhPvG18JHS9e+1txWVixwt9CeIuEnlKWKMhM
 Qs8+LVvPu0vHeZ3iO4qbOUxSdEpODWEzw90Ff+lJWe9+g66Are+TNJ8Zmvr59xlme7gd
 rEiBTrTz1ymOJ+QTt2gj/8YHDrLjqhUxz+rw02uxv6Qh5XmsLDwu7Z2DZq/6qZSWuszn
 /Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795606187; x=1796210987;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PLhpJz27100xJ4lBejKqYddNXOJStc6+fMGHCxhwep8=;
 b=lB3UqsXWRuoXSTcPLJSqW1+jUq1gEzr4ODisV4N+393DuP87AJpQMBgHZfqWOiUkCu
 pAzkq/NeKf5ljs0oLGO42/9OQZ88MAM2AeDmHsUNIlHgv22xglYlO3eYjX25cPuPxgRx
 h0zt4DulaayBuqAojVgIFEoRvgzS6xQUQajgRNdvLwb7lC4qHIzArCfYVykFGrrX3FrU
 DfRUebcK+3AELbj/lIvZtX5z2HnQ/X59D+lmLwlvEUe0fjwMM5TNtx2cYqKqRhOLkptn
 nZ/ms2QJXxdJfcxf7HTP9MkKtbtto8wKPQ9FgR8tuRnfTT4zqA7pRwUW6GDJ7mQH2qeN
 rfzg==
X-Forwarded-Encrypted: i=1;
 AL+hErGs7UwelGgNpXmQKn7x3vwMwaMh7eAaeHEgzdqqcoBjzkQHus1z3L+sL1uoKgxhwXY+WtjM97UIQdNB@nongnu.org
X-Gm-Message-State: APuU4Z9YbOVp4cEBfI2U7lm7I+HX+FZo9kJKZj8/bCMhxTvmXgqJpnMY
 yYWWa3Hqr9qgOUQ3BCT4I0FJ6AbSEhijWjWstouoh4bP7WznOlSjicba
X-Gm-Gg: AZFdTZcSAdMc+h8fkKZUFZGz9WDfDtCdnqcbE8rG1Obf3H7Q5ajwxz63v9LDhOjxXtL
 OQaHafChrgiPDV/+2S1gX2vUUJbaSsIu5b/6XHnBo5jz/0GvhCiGuHHId9sj4DFTx2QbLnRT6TE
 i5f3aCU1jbqZxBuvIOles+EI3w8/+P9+yZTi7byvb8lXCQxMz4B+12+RiwcOlwPhsWvPsaOEpEE
 tkIM7TuVjyNdNV83LzN+y0azb4c0ZKcljaNmXtu+MjSdWMh7/ovMOUJ84zoekgdXZGTjResdtwk
 5PRVeicjlGk9BO60SX5+P22QM5D5fZTg/K+mgB1ezhQatjMbOb9hBOwwYE9hs5u0fKX/Ue7ocAU
 8xPayo5JJ4+0N4rj6tpHrfGAdWkm7Lj5+kXL58mriGDLCj5I63ilwlwEYLYn1oNes8OwNxEteiM
 zkn4IaH39SvQqFF7em3AEyxS24kJDMYTFeyU/YkebSGz++h8wUvlSVtPETqW8fZZL2gYHOeBqmG
 lSqBH0ZQoq6aXp931GDVN2Ct35jSlmrH9qleONE5J2G8oIGrPPraq4t8abU5OwrU0toQ8cJuvzA
 RXiQ9JJRm8BZlsx87T14KxuT2lb7qzuMwg4=
X-Received: by 2002:a5d:5d0e:0:b0:48d:f831:2681 with SMTP id
 ffacd0b85a97d-4abb7d465a9mr37285629f8f.38.1795606187286; 
 Wed, 25 Nov 2026 03:29:47 -0800 (PST)
Received: from [10.45.18.224] ([15.248.2.8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110c3csm32638215f8f.36.2026.11.25.03.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 03:29:46 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <fbc930a2-7f5b-4b28-b678-e10b97fae2cd@xen.org>
Date: Wed, 25 Nov 2026 11:29:45 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 16/21] hw/9pfs/xen-9p-backend: Validate
 frontend-supplied connect parameters
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20261124232247.23169-1-dwmw2@infradead.org>
 <20261124232247.23169-17-dwmw2@infradead.org>
Content-Language: en-US
In-Reply-To: <20261124232247.23169-17-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 16:22, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The ring order is read from the guest-shared interface page into a
> signed int, so a large value became negative and bypassed the
> MAX_RING_ORDER check, leading to an undefined shift. Keep it unsigned.
> Treat any negative return from the event channel bind as failure, not
> just -1, and fail the connect if the frontend provides no 'tag' key
> rather than passing NULL into the fsdev layer.
> 
> Fixes: b37eeb020123 ("xen/9pfs: introduce Xen 9pfs backend")
> Reported-by: Hui Peng <benquike@gmail.com>
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/9pfs/xen-9p-backend.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>

