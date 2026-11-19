Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3223606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FsGmiAyT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU7Bg-0004l4-V2; Thu, 19 Nov 2026 13:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU7BZ-0004kb-P9
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:48:43 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU7BX-0001di-MD
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 13:48:41 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67df3b1ca06so173229d50.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 10:48:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795114118; cv=none;
 d=google.com; s=arc-20260327;
 b=gl/HkoxqBTVRIHiD8pzQrS2MtFYco7CwPk4J1QDtPcjY9i+ePyiIQyxo6FGUL6cLHO
 3W061LlwPFSPsdq/73KsMEYl9ALm32czZ9cLDQ4qUy2L0DhQWCyup1dtHdO7Rrb+lJmU
 scuCJ04JFCulv2ZcgNgmSJ6Q089Tj77ZVMrdfoj6mkEMLOrmCjI45UPu7RJuGYAQ41dJ
 5gZqrjJ5WCm0rwyCVIiJj0C3ycWIRGlRkW+uxHG+LVrELalwoPF6005UzQlq+ifCX1nt
 dB3+d2lRvKdy//g78xNepMlJcYyivYBePWmiuPXGVHtRoixaz+hl+Kq49b9YI9i0snQW
 fikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l8EsjDJKb7jyK9IvXFScP54UU9vgGt813cmc5f828Y4=;
 fh=mAn3ZvAbXP5kOBOxi1vtkatQDtQM5hZSaPBwavjBgig=;
 b=Z060bcq42iaYUk7vKiu5FDTMtPbNIKqYbWVsJV1t/ZavQNE6lMJuru8esIPRqOop/D
 kfd6P0dbaoHyrW2YSStxp+GsiUcfdWMIfeZpyunbPjxIjTHUbACJ/B/i6oAbEZHiMp5f
 cMn7HmF2og4aKO2J6EDerJ0q3IPTnQVj5uc32yGQ0/Uj6deu3CYOuaZmUBit0S2wJLWo
 vdhnqfZ6CDF25JGAVCgoT2FiJE284N8w7HB2EVQt0Rxe6H2HqbdXZZoyVggz3GR/HKN3
 EVSdUlOM5RWdvYAVnoqulVlZsszE3XErMWLrIIUQ4SP9CCM/VGvkZdxDUfedKrAOk0eB
 BNyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795114118; x=1795718918; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=l8EsjDJKb7jyK9IvXFScP54UU9vgGt813cmc5f828Y4=;
 b=FsGmiAyTCRykl9Am/QfPYyuajNFPy7mdNfFlK08nTeMQPysTSnoPnIue/nNx+F3Q5X
 aawV6nkoqbu+ni5++WXtQOKaMhD3z2ehBpIkT3sH0/7Af9jBHUBtywz08KB6X2FeMG9q
 PxyVreveWLtrAV9riA3qjsBM3LPfdke4GN2No33UnSy3d/VGYXxnAlqUSeZyKPvhSBa8
 ZHCWXe5dyxmrWLJZKgm+V8eqFbwmFIQeR86zkxjd75TpOvhWGg8q6gkG/Mtdnz/rHNew
 X0eSw7C7M4eRnPEnmtmGR7QC0Ccj4SZz7P5woKgUXtqUzL7TfOCzRDPIVWGrr4AsTqAT
 ztQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795114118; x=1795718918;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=l8EsjDJKb7jyK9IvXFScP54UU9vgGt813cmc5f828Y4=;
 b=D+WlmKbS8IHnwJr/R0eRHqHEN7IzpvQ2adsmNRHPz6Lqm998KXR3uIaHCWZZQm8Yah
 zdbagQ51muywvrkPjpcMdLFNyT1mdkrh7oN0n3mR7GKg7jwNnfhnleuJO43Ykld6El4N
 Iy8vQ2i6ng/2LBbOoU36rsGCQqvYvsSp0zhZfuwARm2xHNbhP6H7woBTDmgVSnizMcS1
 KvAXbCvpQXOr6Ah8zsABF9kFqRCPpsd01+jkbrVRrU4NRKoAYd5HJdKKHy5DBnQfF8bV
 p6IkwniReAIcsZSqbVKd/EVd6i37HXkaXmzGWDy8/scloDKn4X8w8cGnjSRAjt1MAI8Q
 dWHw==
X-Gm-Message-State: APuU4Z9em6Bw+TKdg23Njj0+ClNNVX+9RdBkfH03J78OdfoVPGg7uybW
 QA3uFBgUkvPjZyvN++e8RaEtrDX2UdzcZpl4uNRuVPbz45m3srnQG3z7mwZaCBxGbgXnkieO8qD
 snemQjYCCimJKDGMsyQ1LNF1Bzl2KwEPsOFho4OPOIODTednsQrEXSsChGw==
X-Gm-Gg: AZFdTZe+AbXG5Su5MBrARonewekeUq6UhqrN5J1LfHkkb+8gPxDwMdsyYzvIACqnDWl
 7NLvyxMRU8vQnVweG9UO0yH5u7amLLuMMdM8DydnY+wcwHFZ3aG0SZhKhpJYkDkA0ZmD9JvKQQ2
 V12YnxJOjr9zPQ8wHM61rxJF4IqwGt0Sbxcqd6EwUgP/rg1muiSaoyMhVgEiJnn1sq1pkt+2MIG
 s7UAuMigZvw35ubTf/o4uz1uALP5mRo4PxMQJurCBaZJwL2xvcgwX0rXBgvdb6FQuX16BbtZgE6
 oHmJb/B+dZb5iHGB933CO20g/tFOz8xhylieY0K15149nAfJIvalBcm4Q6i5EKKRsrwcoqSbF4K
 zAHI+8rb9qPXoTYEyUTGcsoim766TgWI7RnRULuDL5kYJ0lebrbCt/hS2c3QyBUIHY0d1D598J+
 MCoUWbXp3RarcRrAnzuV9X4w==
X-Received: by 2002:a05:690e:11cd:b0:67d:aff3:d998 with SMTP id
 956f58d0204a3-67df44bb780mr161875d50.97.1795114118071; Thu, 19 Nov 2026
 10:48:38 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119140338.2918386-1-peter.maydell@linaro.org>
 <20261119140338.2918386-2-peter.maydell@linaro.org>
In-Reply-To: <20261119140338.2918386-2-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Nov 2026 18:48:26 +0000
X-Gm-Features: AclHuK9kkRju1AaH2FRVq9zPtKg8RsOACs5bbL5YgEo-4aVOD539T3SFUmL7lik
Message-ID: <CAFEAcA-J8O_4rgww=WzTV60X8VOkUy_Bx85ktMjnqsASM-ZzMQ@mail.gmail.com>
Subject: Re: [PATCH for-11.2 1/2] block/qcow2: Detect corrupt images where
 first refcount block is empty
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 14:03, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In a QCOW2 image, the header is always cluster zero, and so that
> cluster must have a non-zero refcount.  This means that an image
> where the first entry in the refcount table is zero, or where it
> points to a refblock which is empty, must be corrupt.  Detect this in
> alloc_refblock().
>
> This fixes a bug where 'qemu-img amend -o refcount_bits=...' would
> crash on a corrupted image where the entire refcount table was empty.
> The crash happened because walk_over_reftable() would return with
> new_reftable_size == 0 and new_reftable == NULL.
> qcow2_change_refcount_table() updated s->refcount_table and
> s->refcount_table_size with these bogus values, and
> update_max_refcount_table_index() would crash trying to dereference
> NULL[UINT_MAX]. We add a defensive assertion here that the
> new refcount table isn't zero-sized; this can't be reached because
> it only happens in the corruption case that we now detect.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 791c9a004efbcff ("qcow2: Add function for refcount order amendment")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3690
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>a1gxer

I forgot the reported-by credit:
Reported-by: a1gxer

thanks
-- PMM

