Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D597CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqzM-0001SS-4T; Mon, 20 Oct 2025 10:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAqz2-0001No-Tp
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:35:38 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vAqyz-0002Ro-B6
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:35:36 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63e3804362cso983373d50.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760970929; x=1761575729; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nv1W4tZskrBscvRN1tlrQ4eSl+R673rIHpTlM3BXU4w=;
 b=fJWJQkrstxyJoivga6UertdmDg77FSuLIFFfLFkxf70ykNvfKO5ZT0YiA72N4qF0G1
 /YlnR62XE3OcUv1C2RGg/eBzBkwls+XjTkvPEJrnoudc9xj9l23TNe2kWWzEjtlUeYwG
 fDHLhKfvLsgLcuUqwTThEviweDpQcLPh1swGEGnoJL/ubvkUn01ks8ZrzmA9st2ik20J
 b+kRfbjdQwAQun8GdDCcxnq9e3hstF0ZBfUpJzV52ZEhdXVgsZd8qdoNhxJhqIgIQ50h
 5ILluphs749wZTLh5jCuHx8i8BNKDtKMlwj5pPV29t7oIor0rZcs+2aQbrsvC96v9v9o
 x88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760970929; x=1761575729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nv1W4tZskrBscvRN1tlrQ4eSl+R673rIHpTlM3BXU4w=;
 b=JJA+oSaykrzXvQ7NgrZqwNas6CtnxRplv3qq0U506dXHvJihflaXD2jD5alSz6Fpdg
 hQqWlvAcXA9uPSiu9fhLiVWWp2Up2p2pPSwTFoQ5/nFGUdXGQ/3KuexXdcGxCyR/0+5G
 5vSdgpeNPVbPBGPbmsK8yciaf5ATmfKh+w/cBvM+BNjobyIC1fRkrcVDcLWjlWw9np8r
 Rq8xRQC/7RNPr2zxijs7UMTGUamJOklivl+AG9LllDIj8DPNDOKuTN5FcrW9uvB5y+vB
 shenntFaZldLZsRuoRdHNJj0jEd/aNIZoR5SHIrLWg92rh3a83yEen38zbkPEHYZA+Ga
 JvGQ==
X-Gm-Message-State: AOJu0Yyl1lO7QblknAR+fIXyJGWBar2OAF/eFGXWI/rDILVyjq6Way+c
 9BTVqJ6FWGyYgkW3rjQ+hZXPfB7/3th7b9q6YhHyYwCGoCoEgwI4rII4ATBoDMJYalKcUIKgLWO
 nesJHdALilAfUuYz6HFQqlkzhmRuCTHMJiC8zcs+8tA==
X-Gm-Gg: ASbGncswO0qBrfpXIdoRP8tngT0Qy8pCqwdSEdkDsg93jGscJYPzGSpTNY0wk93ip+T
 3Cgw85qZ6F/nEnEJNwP37paGcCpdu0CTWUk1oLVXmomzlUUePyeGFvHSFrV7LGjAiXJMIS43f5f
 i66XXx3xSlTqipqS5tKeb/lejVGS1TJ1G/YPlomScqeldRzwNe9+XZ/LTch9bDqZp4u3zGl3eYS
 oonpatsC/149PwogEciApxN297poYG0JXy+l5PZXHeEctxtzAmheuM25WQuYQ==
X-Google-Smtp-Source: AGHT+IF3c/H7S6yhqU7vRkOD7+risv31vbtQO9ZWUlELg+I3omJWgeMFvYCnFLoMoewhT5BakmDZMhg9clzXzQ8qIJA=
X-Received: by 2002:a05:690c:314:b0:780:f794:6e21 with SMTP id
 00721157ae682-7836d1ece75mr218169797b3.24.1760970928822; Mon, 20 Oct 2025
 07:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-28-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:35:16 +0100
X-Gm-Features: AS18NWASteFK6MNykXNSK0RfUo9gJ4uuOBbJM_dWPxXWXaThnD9BNlIZPJ9W9vw
Message-ID: <CAFEAcA-exMfT8SUbYxjGJO2csp9h2Nbc5UzuDWZq-PhzJeZ0zQ@mail.gmail.com>
Subject: Re: [PATCH v2 27/37] target/arm: Implement TLBIP IPAS2E1IS, IPAS2LE1IS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 14 Oct 2025 at 21:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/tlb-insns.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

