Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7140C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 20:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhFB2-00063H-1D; Mon, 04 Mar 2024 15:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhFB0-00062p-1e
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 15:44:46 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhFAw-0001ab-4L
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 15:44:45 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56454c695e6so8201211a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 12:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709585080; x=1710189880; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSxDdh76XAZtDLAMCK3bxUFm7+aMZHcVedsBmBgBj5w=;
 b=zTDXjC4BdTcNax1Vq041xsxJzLMI72NZZkx+a7UX1P/t6SpxhVmoaptSmtipLU4N5r
 grdvVBpLqyfOwP+GpwpF5ozdv65jqtSCaEe8q2kmSE6Q/MF/Ke3z64sGYhaFXI+ONtGF
 NW0y/PD+BQ+7nPp6KopZTNq0eM9JSf5bxEJvBPuTaw5ifpeEDuSnTuqPbt88wtFsreqq
 1hYU8QcTJMzdNBzpLezs6uDhwXkz5cD82O/U411J0vNj1EGgsVhELMJTMEyYlHDv6biU
 MTgv2axCwexBjzjxlTH4KW7wBOmv+PJLM/TVnHnEGq1EfqsTGg7gKWk+4Hw2oe2KrmHc
 /mOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709585080; x=1710189880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSxDdh76XAZtDLAMCK3bxUFm7+aMZHcVedsBmBgBj5w=;
 b=IJpYE0S+dkFIOa4Y2m+7CCiq/5I/47fI+t37RaBCNtqBOYdBF0pAUy0piIVEI0VV2u
 mgtqt1j2SoSsgscwi4zsDpLm2GJuEaedkj6UT+YHb6rnCWiSWJaWvoyht3b2sEbjeM4Y
 VnaG+rDo/jOA4Z5nYF3kWZjw+5riPJL1axg0z6Fz2nn3YGpCa250D8iVvsTvx4+vbTaY
 BbMagcfBxnHcgvYIy8kH9A+3rlgIiskTrZ3Dxn95MOTmffJqZH8tnxR0UnFklwTVjLjT
 sWAK/HjfbNvgMZWZ6ee/+59sKYAceTgu5pktiCAgyazvTzBOfo2XVLV7OdibmibyvlzS
 YpHg==
X-Gm-Message-State: AOJu0YzJsYre4ahmqwewzIRYe16y/Bjvbsksn/7OgKJDqtP1War81YxE
 HV4fQ2HgYRMTu4febBtoi2r3JFj+DI4o0U10UVbRhwd340yK9diALse7oKXroMRGxWO6U//RtMy
 /GOM3zlQ31WmafN/ad0M/UI4//0aVGQQctxw/HA==
X-Google-Smtp-Source: AGHT+IF8ju+cNNBPm0z3iFC6IfSX25rfHu6QFuS6+Zr2JLWw4JxlgwbYth0HwX17NL5VBa6pDx+8P+IXY8C+z9NNNdM=
X-Received: by 2002:aa7:d882:0:b0:567:e6c:c60f with SMTP id
 u2-20020aa7d882000000b005670e6cc60fmr698561edq.16.1709585080124; Mon, 04 Mar
 2024 12:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20240227142316.1827154-1-peter.maydell@linaro.org>
 <CAFEAcA9QbbOuzeo+bTRAdTCS2h6gTocbMsgj3k3DNP=H4Bh0Ag@mail.gmail.com>
 <87v861x38c.fsf@draig.linaro.org>
In-Reply-To: <87v861x38c.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 20:44:28 +0000
Message-ID: <CAFEAcA-q0SaXHf5ZpK-WLgf=O6enQVqpWKjQgO9UNCiBOjT+EQ@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg/multiarch: Give the 'memory' TCG test a larger
 timeout
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 4 Mar 2024 at 18:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Ping for review?
>
> Ahh we crossed streams because I merged:
>
>   cdb5bfc9f34 (tests/tcg: bump TCG test timeout to 120s)
>
> Do we need even more time?

Ah, I missed that -- I'll let you know if I see this failure again.

-- PMM

