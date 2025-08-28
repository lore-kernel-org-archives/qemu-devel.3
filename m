Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA51BCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFq-0002aA-Cp; Thu, 28 Aug 2025 13:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdqm-0002Ho-Kf
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:43:41 -0400
Received: from [2607:f8b0:4864:20::b12b] (helo=mail-yx1-xb12b.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdqh-000127-Az
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:43:39 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-5f348748d71so559853d50.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392211; x=1756997011; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=avtTksvVyQTTHS82fGTzUJwWNIg4WzQXP2rjJ6U9Pzo=;
 b=h4eCQkBeNHQi4KdC/85wNDIjr43KpPqOCFyM4phYzDiUe1xAEj6kHK63SX9/hOcK/U
 IoGEpnlQShi8Kej23DCjOAtYXEFJx+8Mx3NaVJrpozCcD+yKo57PVo9TyEFofrfSfsJW
 eAp/VdaCTeG/3PjKP2JZLeg8O7GWNlaYnqIhOe4Ktprp7cWj6vKQEnQqFehraKq0/ShW
 vEWyqhiWBPG3y+W736JDeniwDkhj1BrlBVT9TGgujsOn2dpBbFquirloyGOH1HgHOxOK
 DdkXcjDoh2udvMIf5JZXxLUMcbhqMQiNN/6LBo23hJ9IapROPabqlRS9jsFJaGt2/UT4
 TZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392211; x=1756997011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avtTksvVyQTTHS82fGTzUJwWNIg4WzQXP2rjJ6U9Pzo=;
 b=fbCMz3/Uw7bg4uPrNNiaGilCbrLMsF3UXJXfDCAVYXwI/m7kPlIHovrw1RvHs1Jg6m
 vvaRZ46yK2pZZnhQlnPcEZU5I6ThAJ8Dwfvlogn1T1tkKL6MQ2jW0EWRocdAKlCVtnVW
 9/pLY++D56qOoCHtNNRXOg1FGYayATBG/xgzf7huofeIScA5TmMS0yKXfwlslmd+r+dq
 EtVhLT1ScC6Wr45aam+aG80SetIplXxcjK1aHwinPiqe4A6XlOklJ01ObX0fLonxLkjj
 ChqmknI7mOajZgRfY90PSBwqOvwmu5dtzQ6xSBiizeHeojx146sSjJDdZhJjbA1zaP++
 3MDA==
X-Gm-Message-State: AOJu0YwyCnHdJdM1u2mj2zREw00czwlW82y00EsrEKFtgJjHaj0EfAGt
 5LSjyzFS/ygRkKacz56n+LggjC+bPYTYQtUitrp1AL7e+EzesYdQ4QRTdkdKZu5zCtF/qAOmqrF
 NbBoCDRgutag5+MXwr2oo2Ijk7I5z0QonoVAJjAagLw==
X-Gm-Gg: ASbGnctr+g50KT0MW84k7r4o0DbR4ESryahP0SIZEw5dGdZilrC6yxSXP8JrpncafcX
 VEJFb+fN/G0aMJDAGqYZspEI35FFcQNVV2mQSX3uZCaFgMaQdY8vmZX7SjX4MJmI5C5jfv1IF9p
 sHmSYtpse/+WmgnvMTzHZhZsMJsZzOOHJcvxwsNsvFbpdlEBygLGQwlcVw9cIhjnG2xgu+sBI3t
 wTaIXLl
X-Google-Smtp-Source: AGHT+IEen0aWwVdVCTzy/mfXwyEeRI6coj4b+LdTn/2mSBjPaXk9Dm9im1eQa46cekuQMxEm5VQiTnK2PJtE9MVJ2+g=
X-Received: by 2002:a05:690c:6d0d:b0:71a:17fa:bf06 with SMTP id
 00721157ae682-71fdc2e25efmr313877677b3.12.1756392210680; Thu, 28 Aug 2025
 07:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-32-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:43:18 +0100
X-Gm-Features: Ac12FXzvOxjJblWfrkOJTBPjwWnqtJe9JI88dDCrXU0pHCUTKj3SUEhNEk3BWcc
Message-ID: <CAFEAcA-oU7Nnws5sS+r1ZUCf8nvBuiwz3LC_iAnbODiUxK-x1g@mail.gmail.com>
Subject: Re: [PATCH v3 31/87] linux-user/i386: Expand target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::b12b
 (failed)
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The comment re ELF_NREG is incorrect or out-of-date.
> Make use of the fact that target_elf_gregset_t is a
> proper structure by using target_pt_regs.
>
> Drop target_elf_greg_t and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/i386/target_elf.h | 15 ++++++---------
>  linux-user/i386/elfload.c    | 36 +++++++++++++++++-------------------
>  2 files changed, 23 insertions(+), 28 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

