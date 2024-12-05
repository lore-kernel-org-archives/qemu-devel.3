Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE340E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJC2h-0002Ub-GW; Thu, 05 Dec 2024 08:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJC2f-0002UI-G0
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:37:17 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJC2d-0007Zp-Vb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:37:17 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d34030ebb2so365431a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733405832; x=1734010632; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lFxfPPI9Wf/gTd1bdjwPKtPtN3Ehej4DTItJJ2shWLE=;
 b=xh6l5IC95hJLJdbtXFS54Gfc+NJN2TUfmPU38pjGBscgy88YhqenuXJAWjYoKb/Uvi
 Am9xFQ3cGycmB6XGscs9mN2JDEANoLqIPkdhajF+S/k+1lLaxshD+/gmaCmAltKxxl8K
 2Bn/BPZDDmsRRAkEy/LNCvvdbDkyu76mgv3skGThJ8blJWWchfpJFV3KzdtAX+SI1XdJ
 p9TY1RlIF8OgjpPtcY001vXX1v5R4MaHYs+iDCt5MFKoA3dauOZrTaPp+DvLJz5EEWyl
 VNUrp9T/jhxDjmc6gD9UK+Ulu6qIl4tPeax9yHwUcnB9VSXl4RXvNWiuOWtEH3ZvF+8M
 +ZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733405832; x=1734010632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lFxfPPI9Wf/gTd1bdjwPKtPtN3Ehej4DTItJJ2shWLE=;
 b=dxRB671cy1B0GWYLHcH1bZ+xlGLSLIULtVq5ZVmLVgg2IKEatJxlOBJIIvLlQJX5e6
 2x+zBcrlzEz1XmSCuU8loYQv5zTLbFTWw6IWq9nqEJogiR6Vj5pTPleq6vpAbgkNXf6M
 ENCXGz5qfSdSOBI3k/iakvbLL6c2RqhPuLletBeBKsKskfW+Kh69QHEMiOs17K/Wlcsx
 uIE4v7enWU49RjngEmq/hjyXv3/P6HGFqscgtyF9iUoRpz9HOjLpwdtSelhs3HT9Tiuc
 eMRqd7mriUXnJTu5cm89lqcwK2aqNI4G7vMok5Fhqnh/8ACKDUtKMs6Ay/3vuujOgW7d
 Cn8w==
X-Gm-Message-State: AOJu0YyIzq/TlHD/uE4p4aVCzcm/BYLzY5eyDEVyrcLn7rfqAZVkxUUq
 R71wXkvhvu6frmlYCWM2egHB82ut9XlfQWiN+MMJ5oIEOYJCbpoSYP1j91AZKW1WEamsWHsiUes
 FsPi6+ebNv/ynJ5NBsHTvCfXkAvXaXyOQrQZTZo56bZgzDDTa
X-Gm-Gg: ASbGncubg49MkaK8RRDQQriCzC6xXsmHtpe8F6lozGG8sYs1HMKP9wV6m2wOumHctm8
 qiwYcXOK7ZwWJYCJZTyfckd+wSP5vfdWO
X-Google-Smtp-Source: AGHT+IG9QIzROeLesFG6rddsgOgcGQnR+PozwS0aXLsl59RDS7esB3u4HpL1tq/9Oy9/zRs7kv8Yr9eAzdWP9Sktkq4=
X-Received: by 2002:aa7:df8d:0:b0:5d1:2440:9b05 with SMTP id
 4fb4d7f45d1cf-5d124409de0mr3642593a12.28.1733405831779; Thu, 05 Dec 2024
 05:37:11 -0800 (PST)
MIME-Version: 1.0
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-10-richard.henderson@linaro.org>
In-Reply-To: <20241203203949.483774-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 13:37:01 +0000
Message-ID: <CAFEAcA8eJp=OLwouY3f242jJK3dVbByZAjBeSz7AsO==Zd_7jQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] softfloat: Share code between parts_pick_nan cases
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 3 Dec 2024 at 20:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remember if there was an SNaN, and use that to simplify
> float_2nan_prop_s_{ab,ba} to only the snan component.
> Then, fall through to the corresponding
> float_2nan_prop_{ab,ba} case to handle any remaining
> nans, which must be quiet.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

