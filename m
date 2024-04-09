Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73256CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 08:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru798-0007xY-C5; Tue, 09 Apr 2024 04:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru793-0007w2-LA
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 04:47:57 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru790-0006eX-Sq
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 04:47:57 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e6a1edecfso2139671a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712652472; x=1713257272; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tB5jbJyKVfjMYI2SGLQR2XRltgEq4aDOxenRiNtvyuU=;
 b=k3MgvK4EU7nvxx9IeDzOtDAA6DaX2ZvIYEO5jtFpROVFxBdJYGTVlvtTkqdWQ6LNUd
 sY4V33y7m5+FcRy2Sb5HIubBTWtYEW5iHFae2FVT1AnjDB/lzGeQYa+7nYDUb/+F3bqD
 3kY4eCV+D5oNyDTS7IT4mjKVlFsf1yXqbusdOrCI/blVIq1ShIy61OZyyW4SR5xa3s9/
 LsdBtd87OW46NghdXkKBHdd/qe1hq2sLYbBFN52/B7WiEBMSGH2w9CNInU4UYuyVgZLE
 OcvhGHDL8ztONy74wP5/hW+Uh+lVuCepT60rVG35qjUzou3CY0hZx0YB58ibG/Bq8qWJ
 UDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712652472; x=1713257272;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tB5jbJyKVfjMYI2SGLQR2XRltgEq4aDOxenRiNtvyuU=;
 b=R++6XYSN7tUMoSwlAQEP+fPOHr9nm7Ooo8+MRDtH6FDRI+HlvZ2ZQ08aLZPYNUCMk5
 Ftou+j8zQCds4oNcjGSnkCtXRJ0fyGKVVDeUvlpvsM0OF4nWk8mN5YM+bTDxofbzfWiV
 NgchoRmNOWCOgajFejdkdowiZt7Qb/loczmD8xVaXbMUJyG75Q90s6srbVzIFuzKMhsv
 /iR+EmGoprkvos3iZg8T3R27CEwbYLCnqwHB0vMV4lnc5FrwTUIzeEbjt3ZwGubUfzsG
 Ic3ZaD9H+umrZulnBYIdo4JpHJl98uGCEtzO9TSKY/VF6tGomETHqih2qzyzsNil+bc4
 Lzwg==
X-Gm-Message-State: AOJu0YzRTzxpDkurH6M+/DnjDW6GCvoOlGelgMcVlstldObcha7Olppd
 gv/QOVQouypzjo+1LMnivro0yxuCMA0sN1ly77mP0PkepA3mPZqoEJ1Zy3qocK4uievLvsEK4GZ
 QHMaUSHBWjGQzpe0cSxmjXjKPYrruPsjuT7XljGRgD17iJ5Yf
X-Google-Smtp-Source: AGHT+IFKNFTTBIPwvvEXNreHADjm6N5iBdvy5DrN5W0YLROyCuMyHCOInUdxn65lmvHFkX3+WFLdpY1BBsESlR2TLS0=
X-Received: by 2002:a50:cd81:0:b0:56d:f54a:8765 with SMTP id
 p1-20020a50cd81000000b0056df54a8765mr8519384edi.23.1712652472440; Tue, 09 Apr
 2024 01:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240408152346.3937318-1-peter.maydell@linaro.org>
In-Reply-To: <20240408152346.3937318-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 09:47:41 +0100
Message-ID: <CAFEAcA_FCzKajcT7C7d2+N7JmVr6VS7VyoYFuNkwvMTVYzKG-g@mail.gmail.com>
Subject: Re: [PULL 0/2] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 8 Apr 2024 at 16:23, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Two bug fixes for 9.0...
>
> -- PMM
>
> The following changes since commit ce64e6224affb8b4e4b019f76d2950270b391af5:
>
>   Merge tag 'qemu-sparc-20240404' of https://github.com/mcayland/qemu into staging (2024-04-04 15:28:06 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240408
>
> for you to fetch changes up to 19b254e86a900dc5ee332e3ac0baf9c521301abf:
>
>   target/arm: Use correct SecuritySpace for AArch64 AT ops at EL3 (2024-04-08 15:38:53 +0100)
>
> ----------------------------------------------------------------
> target-arm:
>  * Use correct SecuritySpace for AArch64 AT ops at EL3
>  * Fix CNTPOFF_EL2 trap to missing EL3
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

