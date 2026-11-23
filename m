Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48739606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vbnbMzsE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVT22-0004jC-Hy; Mon, 23 Nov 2026 07:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVT1r-0004hD-MO
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 07:20:16 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVT1p-0008S8-Qa
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 07:20:15 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-67db35e7953so3188770d50.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 04:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795436412; cv=none;
 d=google.com; s=arc-20260327;
 b=JNVz/VQIMUqbskeoVUMM9hFbzTHDG8wou0rVPER7jC37d21IWHQTrbuMuwA5qFw75p
 UbIMR3ut8o8+IFqkAJe6tA+FBgTVATPfNbXnA04hfoUIZigTOCRhvSdNjl3aLZzN/Fi2
 irZIGFti7lHIdv+68FM+iZimoL6Ji+TXkNTLuZRWVcxUAuclTbflGGcc6ZaNWbNs1No2
 PL9A8tZbOpTRj+obXF30DUfzAbNM7l9/dQkD48rQHB544xxViIofrNpd9YZiAYOm7f6T
 fo2nGRsuE0uKwK9PLRZvYdBIoeFcxHB6qQV/5VR8b6W85WbGsiBtSE/isMU7NAW0I6x2
 C3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mPz4MWjNFQFPLH6jAjLZDCm2yugUXMclxPObktjn+ro=;
 fh=LKIX6mL3VIRLGHaj+MJkwKn8otVLPibjcCOi5MZqphE=;
 b=XTSnFu1aGVZIGXwVJpJ1sTab0M9jm/ugfImlhwXUAqdbETd2aI1ZtLkBRC0QmTkNAl
 lfT8tm1lZc7WKZvn0Xv0PvpM8sFS9WFyzqryrf62MS7natBnTy5rqV6ATemyQuHHz44E
 nNECHayLkRwgai12/Im/O4GxJdQkcRHduFouZ67a9YYJhbZGctit8pMsZ29fCkmp+Ypo
 9WVliCcGngThpojb/fegLWhgbz/gVWSVeTJ2w2jOndkcp+6JzwOMrK3y0IpWUR6j1lk9
 FzONEZRkLoLxA+n2WmjbxElESR6CpoNV/qjlJYYgloVGwZPPd9ZX5z88rZlX5wk68fCo
 F1kw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795436412; x=1796041212; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mPz4MWjNFQFPLH6jAjLZDCm2yugUXMclxPObktjn+ro=;
 b=vbnbMzsEE1qM+1ho6U4vyQE8PrCe/e6nSWtipVGwnJLxv+LL0uRsu0qQPvA5xhlOeF
 DcaA4Z8eOsv1jr7j8oIlzJvKFJpuxdj42trFZEPwTSZ59yqhR7fXlIuv5APvMF9zM+Ic
 IKzNzRdtUtFzTM29KxutzeJli2/o3pbwC095OqfGwaB+UWV46iqRy8SJ4nuU/CdA1yZU
 clBKrs3GJZcjh5s9Ws458d3M0r+YRzAz7lrvreMozOl6NvmoH/M1eGoJcET367dEkTZE
 gZ43RBVALc/705OP77Gf0EKH0jYiOd8lrgQljxgvsxBk/YJ82OMHV2MMn2vRqWpBwIBT
 H7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795436412; x=1796041212;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mPz4MWjNFQFPLH6jAjLZDCm2yugUXMclxPObktjn+ro=;
 b=w9PRRTJM2h/thh4eWYi2VShnptm4EOAYzpO6Ln0rXvO2/69+uTLwnM6YDI0Xr0yTq7
 3YTtvHiMpJOy56YwemQ6BiD5cOG8U9UamzpgXTtFom0MWt0yclieK7ojSlzJyejnXznr
 ykHo6H8zVSSZEAO2EXl1ohIv4Eaj9zGXtun+aeBiB5syJRbo6RkgV9xRmewsFn1/+kzK
 ygL5d992ZxEAVFSNoeKE5w6d/wKfLOC+2iJ0oRoJptDJen0Mzd1yR3RBLKOG1MF7Xxtc
 /kmsU6PcU/oCb1zFiaDsOUqGzEyBzwme4EZWafTJv1E94gKMyBDEMMmgMNaZvmnWIMM6
 /U6g==
X-Gm-Message-State: APuU4Z/JcOybfCHX3TjUsy2j5+WXLKo36rhwEVfGsXaXc164VsLGoq3g
 3TCI1FE9sK66+1exlSuOP6LxkNYPw4ITmNXAOYKCRoot9Yzfj7MP1uApKqDJJtSWICDk5+FJZvG
 wG77PZs56DbIUsjAQLO/Ob2fTSrxKdD0sY08CpgiMKQ==
X-Gm-Gg: AZFdTZeEiCTjST4XstfcZanXb6pIdbal1bxqPLsrmLYKcVqeo/DSm0XPnNzvmVkTI5h
 CUsdUd11+DgnP/2DETRn2991l6fAINSWm1dL/n4P0vU2T8ibW/pNz701WXr2/XcMTjQaojj5f35
 jcox+LsZVdZzLVWAUGxKJafV+dEwcvLFCX3hGGMAlkqmUUp6U6MVlrZbMeA4ooCkWcxcPgq9Q62
 2F2F0DGmzl7k+OVwMN13SA35mXwPApsfFWvYBQcepI311p915x7eO1WAbZtiQsDJe0DhuP9Kutv
 oe2mXWZDo9C9sWQ5gFvfQa8P1p6Ix0t0PFeBTfeBcYGKsfy2R0UnyusV8H3tEzmLXoHz9mu4Pxq
 1k6YByoaUzgTNY1A8xSjDhQsoUswfEyxXxWqaw45lDJ82DZKh8KzzGTmXJnQq7NGm+mtFYzpI+9
 Az8j50R2FBuEoC3HgQ5SMI
X-Received: by 2002:a05:690e:4088:b0:67d:c305:ca38 with SMTP id
 956f58d0204a3-67df44521a5mr3881984d50.41.1795436412349; Mon, 23 Nov 2026
 04:20:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120124923.1656220-1-peterx@redhat.com>
 <20261120124923.1656220-5-peterx@redhat.com>
In-Reply-To: <20261120124923.1656220-5-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 12:20:00 +0000
X-Gm-Features: Aa3M54rsARZIkIE89AfyUBlIbzwbpyjpgm7BYbyI06goiIBWPfFRyhancj5QvOQ
Message-ID: <CAFEAcA_KaLtY21hnfAJimgdNFRiRBOLupsbshHpvXG7URgcKrQ@mail.gmail.com>
Subject: Re: [PATCH for-12.0 4/6] arm/machine: Move all VMSTATE_VALIDATE()
 usages into post_load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 12:49, Peter Xu <peterx@redhat.com> wrote:
>
> To pave way removing VMSTATE_VALIDATE(), move all four such uses into a
> post_load hook instead.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  target/arm/machine.c | 45 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)

I think I'd put all of these validity checks into the top level
cpu_post_load hook, rather than spreading them out across the
vmstate structs (and expand out the _validate functions rather
than retaining them). That also lets you drop the comment about
there being an ordering constraint between subsections.

thanks
-- PMM

