Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08DBC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 14:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rskTz-00046c-1x; Fri, 05 Apr 2024 10:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rskTx-00041F-7t
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:23:53 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rskTv-0006BH-9h
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 10:23:52 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-56e2e09fc27so1443988a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712327029; x=1712931829; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=leLUkpbDgWbW3ocN/hoowLLoCf31KDYVEwQ9wDkrUIk=;
 b=szSbM9qDLYY++vRjBmJzby0FqlphxCOraMpYYpVgryJkF7UtFGWebBdlXlXZU+Jj5I
 h1336oYdDAZ5oV+Z7xOGjDHKv5maSZqlDHeu3HPCJy9J9zr+PLtuLSsEjVQHywxy6t+8
 9c99y6PGGfQse9UqnpYBpSe4RXSTP/6T8Z1eJEEZBvDw3ad/8/UXn56Bices+rWGwDr+
 ysTgIWSDkkYCRpw00hN2HZBYh1bK3OOX05hQHsSVOxi75OoOTWcj+5yXgtHK7k+uH0/5
 CuG7VUIckMZ/Ru9U6Z8dYrgAKIfLDpqEOzmZu8fKhciOeD0tK3gk/uK8wzbV0fp3sWsu
 8G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712327029; x=1712931829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=leLUkpbDgWbW3ocN/hoowLLoCf31KDYVEwQ9wDkrUIk=;
 b=o4GX23rcLTzWTKRoofa4kJzEE0UceDjBsUiPeeF5wh6Hvh8aPgLJ9aWTTQbXnJHl2A
 QNinwwgqQKgWI/trgO3MEDzERZ9MM0HA/ZE2qwNlO5Raq3BD6/jgLJzCJnrGTMLUmr0H
 JKNV+MoYnk/jbqlwkNmOJyT7ox/4o3OG2bAGFhRnMP9MBJy15geDc12LPp8fOA4+E2Kw
 6fNRjsHsyhu62OqqsB+LI2iJiz1DT9QhWfuLkpR7F+OrnQeSyHhK9uykfBen8u/7Xxas
 3Ls5btlyY4Ldt+lk/8pyiiyy6Uhcfyz/ql4OLrriRbEedaLXIMMY6PoEEEVUT8Fix/IV
 egBg==
X-Gm-Message-State: AOJu0Ywt9wqNzf5uKaG1EgARGdUf47Eaa60UyAZTHo93riYU/JUWrzHL
 uNNPg3B+jdhT4kO9a1XXmsm8rAuNceOKCblsKNpcD5bZNcztk2JnSz23N3uY0jk1KruUMWo7Qne
 i85UGFGg1eC2ml6ofoqkXma5W2wOh/LCLF5kR6A==
X-Google-Smtp-Source: AGHT+IFEjKtcD0Xu5/j3/f3KDFYeCFVM8P8gkUV3K2kvjtkGIN3EB0M/NZ5FVckE15NugUi+no09PUdcFSUMDpca31A=
X-Received: by 2002:a50:bb29:0:b0:56d:c85a:7893 with SMTP id
 y38-20020a50bb29000000b0056dc85a7893mr46547ede.8.1712327029265; Fri, 05 Apr
 2024 07:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <m3al6amhdkmsiy2f62w72ufth6dzn45xg5cz6xljceyibphnf4@ezmmpwk4tnhl>
In-Reply-To: <m3al6amhdkmsiy2f62w72ufth6dzn45xg5cz6xljceyibphnf4@ezmmpwk4tnhl>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2024 15:23:37 +0100
Message-ID: <CAFEAcA_nfWXKEkbqn3BKkq9Rh-hHN=xBV7XWFEBpOfbdP+SwtA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix CNTPOFF_EL2 trap to missing EL3
To: =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 4 Apr 2024 at 17:36, Pierre-Cl=C3=A9ment Tosi <ptosi@google.com> wr=
ote:
>
> EL2 accesses to CNTPOFF_EL2 should only ever trap to EL3 if EL3 is
> present, as described by the reference manual (for MRS):
>
>   /* ... */
>   elsif PSTATE.EL =3D=3D EL2 then
>       if Halted() && HaveEL(EL3) && /*...*/ then
>           UNDEFINED;
>       elsif HaveEL(EL3) && SCR_EL3.ECVEn =3D=3D '0' then
>           /* ... */
>       else
>           X[t, 64] =3D CNTPOFF_EL2;
>
> However, the existing implementation of gt_cntpoff_access() always
> returns CP_ACCESS_TRAP_EL3 for EL2 accesses with SCR_EL3.ECVEn unset. In
> pseudo-code terminology, this corresponds to assuming that HaveEL(EL3)
> is always true, which is wrong. As a result, QEMU panics in
> access_check_cp_reg() when started without EL3 and running EL2 code
> accessing the register (e.g. any recent KVM booting a guest).
>
> Therefore, add the HaveEL(EL3) check to gt_cntpoff_access().
>
> Cc: qemu-stable@nongnu.org
> Fixes: 2808d3b38a52 ("target/arm: Implement FEAT_ECV CNTPOFF_EL2 handling=
")
> Signed-off-by: Pierre-Cl=C3=A9ment Tosi <ptosi@google.com>

Oops, thanks for the fix. I'll get this in for the 9.0
release, so we won't need to backport it to stable branches
(the commit breaking this only went in in this cycle).



Applied to target-arm.next, thanks.

-- PMM

