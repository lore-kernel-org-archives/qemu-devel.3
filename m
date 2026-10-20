Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A3606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=d1eKtMGf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCgy-0000ql-3f; Tue, 20 Oct 2026 12:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJCgu-0000pw-OZ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:27:56 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJCgr-0004Hn-OS
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 12:27:55 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b125371596so5674007b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 09:27:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792513671; cv=none;
 d=google.com; s=arc-20260327;
 b=X7fTlM3p913ZediyMxhxjq4xcG6N/0n0wmsKoh0cCSD33dVhjbDKyRDfTS5wnbOjbI
 3B+5VogsYi3H52pMW4uNWMZ08qW7QO/jK2xiKpxG83gNjOoq1Ng7djvEIQJo4XiSk4PN
 x3HMUAuKpFZ1gERczRAILCoUMLSauDFgfHbQKNo24EWLEKc5ktU/ZTNlYmlnlE6wBYol
 iou0clinIA4o+hijGsq2MldFlWzq+S6mtdYLqv1catG74Hxy+BAT23x6To/owvswMz5r
 H2xV+0vl0GR7v2kJyHCuQqJBIeE007ipwXRrVxoqim46WZacxMLg0B2N+2jkjPdCHMtR
 wHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=avYRdodUQ6KiGgYB+yLXS5NG80XwFq+SqjqDPGJcPQ8=;
 fh=x1iHYurIuB6TAUTzB0FHbw01mMuxYr6u9aI8CaXHoJs=;
 b=c1gujil9OOuNsFVCCNW4PO3LPFd/NnmU+0XFpKg6kgDGNIeYH/64IaAmKmykMx7NmV
 eedfFHUi0RzdijSM0BswVeSM+gl4pvxpEzD5e2im6kM4gjQqFyO9sWpXMHTo/myQAKNx
 /NqhvDnb3dJXzySWaqmha4lKyFvK8yhVC4OUYQiBeoFpsjTWkuz/4AjcsNcsGidMPwpC
 Xuu8oCCjAsfZOuZbY1p7kDaTjlOtdxYl4KNvESIw5GGTO+rBKtGuWBnU/YEhQBUkt+RN
 0HEtjt+xNrUZed4rOB6x3h25waK1UILOdHNryp8fy+wVkb0x8iMaFl4LFeNxIST2EUNc
 A4Xg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792513671; x=1793118471; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=avYRdodUQ6KiGgYB+yLXS5NG80XwFq+SqjqDPGJcPQ8=;
 b=d1eKtMGfvkRCae/SM0lVkTxmVQnHAU7jRQjZs9uQbrSUA1Jc2RrkSSZ8pW/TMFqDjI
 jVLPGlUn2cNzSFYC4O0HUPoToeQt9UmUFYW0/ejIuh5ztr5XG/u80DGkh87Xup5kLW7f
 ckXNCIgJISVSBdvgiUZXLrt3EfOPppdLVG+Mh8+6zz6coBh93BSw2sgfuldxQl7FdX6G
 r//4gz0Ynqqfrl5ibO8G9mZhQ6hiICWf6+MHbh2n90zCqKPFkmU/aZO30nPYtKVgUnVM
 COXxX6Gw79ODA8tYb37uypmuK14KNo1sTrPrqbDA0AT6BTGF6YRLbA9NIJr+59J4aOHH
 l+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792513671; x=1793118471;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=avYRdodUQ6KiGgYB+yLXS5NG80XwFq+SqjqDPGJcPQ8=;
 b=LXnRbdxlOeKf+nyIrb8xFO0K11v3NC1azRTBzt0OnXqezdWkGP9TT4uD+b6rM4c5n8
 9TxrylpCoev27t+IV5u3xo0ECCq6fbsZYuDDeQ1+dc6IwgmZBdfz0bYDaZLQi4G5qaBy
 nBp7JL/+UgzSk63ALAtyzAY+7Hd/bpLUrNMq7YNoVINCN1of+TCpY/QdZi9z3NpZj6re
 mUOZTurdiEQ9vb2+j8AbEcJjklLHkDLi9m32FhP17Vr6sPVMy9Cx24Fk9ykyRqbo61S1
 iHw2686d6jKINzqNHdvuV3GKkPDEDNPG45E9lSZFlo14rm6a/fvBzI8g5dIgvoF+5Yg4
 FcWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBpVXttOy01qOEwrSmCWOwHH528Sz0JQGGWM0P6ou9ipA18N1jqkHJurEEBGB8B4sqDYQwgqBJHd9B@nongnu.org
X-Gm-Message-State: AFq9FYIBw49TmEgDwk7egKW7JS/O3HFGwzTQQ5axhd0gtHJr1ltG2gja
 OKB9qbjXRucqLHliuYndY+/NS4bd69WEpnjmHzWHZyvD55Fo1t58j9M6V9NCtvlzyKtPnZctup7
 88ND2Z3ZMzdH3iCrsGiOmpn5HLcsKtomVYANji7Z6abp0oLTNhezACCU=
X-Gm-Gg: AYBFou1B+wa3ya+UQimYowhAvNdE779MGmu1va//CKuW6klU41ScD3enwE0PJUa+1Rd
 iB29iIxlr0r7rdnRnr6vRdNRXyGdC3ItFn6f2WVRd214iuJO8j4MT/or4U7iK6j1Y0OT2kVwvgj
 1I+BrJY0aWr1dXwfsa7HtoMnDVkpP/KObGbrLV3zBD7osCnH5OsauHwRN27htEIuXN+XFFlcViI
 0WapU6RxkdvZ6ChAD8kGa5lJVOPj+V3qPGMFj26r6OGf+1RVqvR00wXlu5XRLEjkRkH6HMvnfcu
 9EktVJiJ84xt+P81klbKleu3nKCgW7ISOCiKXjBrcw4Nvw5Z6UZ9LwcReeWUaq8zilooAd93Fhe
 yTeQP67ZB6bVe++IaWoBENA+xg2YbbmQ6PPZAcdQ=
X-Received: by 2002:a05:690c:397:b0:873:5c7b:c136 with SMTP id
 00721157ae682-8b12023edd5mr9254677b3.30.1792513670500; Tue, 20 Oct 2026
 09:27:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
 <20261019120517.1448687-24-mark.caveayland@nutanix.com>
In-Reply-To: <20261019120517.1448687-24-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2026 17:27:38 +0100
X-Gm-Features: AclHuK-LxX8V8SUjcf5mPQUtqxySvk3Fvyjs4x_5sidwHX23zHXcCnE77fpNL7s
Message-ID: <CAFEAcA8-Ke6ATD+Z=kGToBNXLonAJhBhF9KcvNK3gLPQ4R_gdA@mail.gmail.com>
Subject: Re: [PATCH v3 23/28] xen/xen-hvm.c: introduce TYPE_XEN_I8259_PIC
 device
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Mon, 19 Oct 2026 at 13:11, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This device represents the Xen PIC for an x86 machine.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/i386/xen/xen-hvm.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

