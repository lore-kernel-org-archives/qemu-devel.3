Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62697CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 15:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrg03-0000L9-CG; Tue, 02 Apr 2024 11:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrg02-0000KV-30
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 11:24:34 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrg00-0005bx-C1
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 11:24:33 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56bdf81706aso6628712a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712071470; x=1712676270; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W7usfDbTF8k8Atd/dvmfgTO/s/lXiH3RGJfcDBXIt4U=;
 b=NsXh7bMfbaHneFRi4W7w4CFyPqsFFnsGx9viBb7Ln/ViW8qZkz2g6qsnP8MtUgG+IG
 1jr6SKQSy/01oAz02/WPMuoUG07/vyu7i94ljXzcYSnCtnsuoATQaTe86xcgXeJA69aN
 jcB7KEXi4b18zD5i+vmPcvMiou8JgUxcKZ/AnR5KkkyxLNFcDbanen4mUflrjalFm4hY
 moMxNSmKb9Ia2qeWshZWa7sdJPxBqA0uX6OzcX+mfJ9IsSBwazHUcNsWXdg/OqSNA7Xy
 59rspVdz/FaLziXbrRqfdlizMfjwMMHfsCah8/8Y169LfMqEql+OKHD4tltnQXLaFGSm
 1NMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712071470; x=1712676270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W7usfDbTF8k8Atd/dvmfgTO/s/lXiH3RGJfcDBXIt4U=;
 b=X/iMl7wAN5DV8dKF2ZQSz39UEzUtW+sTEqvG/OJt/4oEqHo/EWwLQea0Qcrrut/3My
 FOCj8sEiUNXfsPPjoTlXOtQpxEobRTvLB/HmT8b0GQQBO4d2TPdm/0zTmEq44Q9CopyK
 8UlZQWjAUYDvpOZFQxMG4dwmRmCdttSBooihKxAwVF2WK5p9np2bD2vXwtQ5SBYE+itm
 O+Bi8L49zTNltmvonJQn2Gyh/5sWmxIRFMeDz/IFDUyWEQv7nGQpT8sJUDi1vMFKAPqC
 9giXCj2EFNM5bd7PMhGRcx473Nq6pdMEYhxzX+/6AL+fDZje1X4cf/GutS4GDBVrU2lT
 Gizg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVerEvyMQNbWJMMXLtUZBUoMm1tSPkv66uvuFqyLLU42p1vp4mZEo2SmxRxIDYoWZXfa6SegXf0P1nl4CPf7dll6wrFT6w=
X-Gm-Message-State: AOJu0Yz3QD468D48tdUaaCahlsSaczkWeH796AaZga1SrgChS2tyHbvH
 axkrBb5KvDKtoz2UUzFwcQvtXM7l1uoFMIeHcl+3ikc6/TdWH7oVFmMpebI6ZEvb5LRz5qiX9dG
 hZunz/gaDx+zdeQsmSrda50SMsfIMSQNMDtqyUg==
X-Google-Smtp-Source: AGHT+IH6h4xslpbOfqAPGKufamCm+fMYSjjB7/uf2mXTdHf8jfInZH8Hy6oKUyvDPPyEcj3A7ONEL3r/EaFKn3gZ0X0=
X-Received: by 2002:a50:cc82:0:b0:56a:2b6b:42cd with SMTP id
 q2-20020a50cc82000000b0056a2b6b42cdmr116642edi.3.1712071468200; Tue, 02 Apr
 2024 08:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240402093157.2931117-1-mjt@tls.msk.ru>
 <CAFEAcA8UBewAHriNkbJNO9CFKgf5bBGRHntbb_y11JdfoNTvcQ@mail.gmail.com>
 <60faa39d-52e8-46f1-8bd9-9d9661794880@tls.msk.ru>
 <465cd941-4830-4adf-be76-011702bb71b3@vivier.eu>
In-Reply-To: <465cd941-4830-4adf-be76-011702bb71b3@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 16:24:17 +0100
Message-ID: <CAFEAcA-=_gBYN8Vb1Q0khmDy+nJJ-hzTvN6UaTBtrBPP9qE43Q@mail.gmail.com>
Subject: Re: [PULL 0/4] Trivial patches for 2024-04-02
To: Laurent Vivier <laurent@vivier.eu>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 2 Apr 2024 at 15:30, Laurent Vivier <laurent@vivier.eu> wrote:
> To post PR I generally use git-publish and I have a hook that checks that.
>
> $ cat .git/hooks/pre-publish-send-email
> !/bin/bash
>
> NAME=$(git config --get user.name)
> EMAIL=$(git config --get user.email)
>
> for PATCH in $1/*.patch; do
>      if [ $(basename $PATCH) = "0000-cover-letter.patch" ]; then
>          continue
>      fi
>      if ! grep -q "^Signed-off-by: $NAME <$EMAIL>" $PATCH; then
>          echo "Error: Missing sender S-o-B in $PATCH"
>          exit 1
>      fi
>      if grep "^From: " $PATCH | grep -q "<qemu-devel@nongnu.org>" ; then
>          echo "Error: Author email address is mangled by the mailing list in $PATCH"
>          exit 1
>      fi

You should check for qemu-.*, not just qemu-devel...

thanks
-- PMM

