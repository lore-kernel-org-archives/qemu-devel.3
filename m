Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92885C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 19:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkUSF-0005dM-0Y; Wed, 13 Mar 2024 15:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkUS4-0005aq-3r
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:39:49 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkUS1-0003p6-68
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 15:39:47 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d220e39907so2525001fa.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710358783; x=1710963583; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePwrOhCqD6QcBntpos1ixTsxkp9ZbNWVANNVJnLwFRQ=;
 b=mqQrrVT6obgnOLTHjenvroj4xWhyRt/nKElHaNw+ygvevscY1+15MmrkxQ0YbjxbMI
 ATE65Egry5NnKntwIuhV+OriWj1JqK+Lxgdtn7S49vMw2cRh5/665P3Or+/Rdy3Kq3Hz
 M6khc9TRhdCUpxLBPZ40soGc4vjyCqNIMlB7YR2j9f2ORqhs8Ql16ZJo0mahiSA/R5I5
 lYfUagjTdkNvC7Hminkgeqk4WdvPt7OR1+zsQbrzRWqY8MNUPCd8yOrJmTILOErLo8bV
 QF7BdHkybAsSfJDiGDc7W5XBe3wiHLGDJXGd2SOBROIf25PLwonfxhP4q6jueNNQF5YX
 fZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710358783; x=1710963583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePwrOhCqD6QcBntpos1ixTsxkp9ZbNWVANNVJnLwFRQ=;
 b=rFagIbpBagmMfNQ0rYVDPK81/QLBAz0JOHavVDBAcA7ZTX9zRzqK+VcZNtb2se8ku1
 KFqGjrdu1ieaIDXzvXzJ8e8PF0pV4iup2fLTdlVz0hafRMgSvDQDZucAoILOyyiifN91
 CZMNJ04+ggUAKHaYxZ+mHKV6CYJsw08GIzGJyxmiMO3y5qUClo7na6RcKf5espYgH6DS
 32Ss6vsvqnMnQy+62QwD5blg5CBSk4V3DCMkqU4JJgQelH0JzmO7Br/OzAXiyYCg4W4d
 Wu5IcmWQGrF2ukDi+T1sPZlGtDDujHxim97eTmqj/cVRnVsQiR6XcXQQe51fEBQAPc4E
 09Mg==
X-Gm-Message-State: AOJu0YzX6f+6L0T4YhbiRuaZLDJtG/uSksIHWUB+p2qY+eqXyttZwWzv
 yVyLTy8ix98ftKCnPaJTfcj/I0VdRu2mcUe08A+H3jsE+xONP3G18voQdcrjuFCh5dvFVBMN11I
 ugqnHDKt9SCue35V6OQIrfdrTUalqAPEMDYdDTw==
X-Google-Smtp-Source: AGHT+IHWoCRupv9NNRuOudLIq7LC3JxoPndrft4/POvIAW7mvfVaYI/USK1YJ0aXmGe7mP9xdPiM+LAeh54JBCcoHvE=
X-Received: by 2002:a2e:b52d:0:b0:2d4:6a6a:22bf with SMTP id
 z13-20020a2eb52d000000b002d46a6a22bfmr2084044ljm.23.1710358783153; Wed, 13
 Mar 2024 12:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240313184954.42513-1-philmd@linaro.org>
 <20240313184954.42513-4-philmd@linaro.org>
In-Reply-To: <20240313184954.42513-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Mar 2024 19:39:31 +0000
Message-ID: <CAFEAcA9ZtyRG5G=vLXNJdA3RPKsvLGh-v8MO2tq1mC3ch5_asw@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 3/4] qtest/libqos: Un-inline size_to_prdtl()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, 
 Eric Auger <eric.auger@redhat.com>, qemu-block@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 13 Mar 2024 at 18:50, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> See previous commit and commit 9de9fa5cf2 ("Avoid using inlined
> functions with external linkage") for rationale.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/qtest/libqos/ahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
> index a2c94c6e06..135b23ffd9 100644
> --- a/tests/qtest/libqos/ahci.c
> +++ b/tests/qtest/libqos/ahci.c
> @@ -662,7 +662,7 @@ unsigned ahci_pick_cmd(AHCIQState *ahci, uint8_t port=
)
>      g_assert_not_reached();
>  }
>
> -inline unsigned size_to_prdtl(unsigned bytes, unsigned bytes_per_prd)
> +unsigned size_to_prdtl(unsigned bytes, unsigned bytes_per_prd)
>  {
>      /* Each PRD can describe up to 4MiB */
>      g_assert_cmphex(bytes_per_prd, <=3D, 4096 * 1024);

It looks like this function is only used in this file, so
we could make it static ?

-- PMM

