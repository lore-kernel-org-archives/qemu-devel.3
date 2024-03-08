Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8BBC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribJk-0002Vw-Q7; Fri, 08 Mar 2024 09:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ribJi-0002Pl-8v
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:35:22 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ribJg-0007me-MG
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:35:21 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-564fd9eea75so2985178a12.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709908519; x=1710513319; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0K26v9fCtbfWnOD2fZO5+afLbNTKNXimfVgHPyou06w=;
 b=uy7AE2DUi/gCs8J+QS+gOEVgPEONLV/iqVI7vKQeV4+DAdMHwKoMRpRXrhmKKbVveT
 SlvblPBxsEtsjfpYF6tSwG7VSxW+XI9XJGDrARulKqr1Gaysuf4dXA/lJJeOEDLczLT0
 AmbSXfwWfsiUl1VH8xCqadOTk/IZVri5PwoAz+LERh1uL3x+JTe+tCQGAaZg4I8M3joc
 RxeNBP0q5Q/QZ8DrhSMguDkq9uVGYjzycWl17aSkk7Y43ReB7bqOc95qspyllYGrYlOb
 pi5X6bp1O3wOjpfn4bwVptqARV6BHJF+xLdi002H62U0qO3V2ThTSIzSOL5JaubtZ8fl
 HZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709908519; x=1710513319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0K26v9fCtbfWnOD2fZO5+afLbNTKNXimfVgHPyou06w=;
 b=YeFgLrdt28akHxQieOQ0Iih7DHgLWaDG0d/mnXScwMWACjZpqosubHciH+/mkfQV+J
 7COYyBiiirFRMVhM1+Wy7PNNzRscbsDzpqol8bSO2aUsO6GPLNiS74BrxBlN6b6bgQMh
 yQos4O6wCmoBfwb2YVb7xWNx7J8RERzTY/bS05QWHa0RYzTPgDVx3p94KCwTixyloX6V
 XPwiUmGzmda6UsnR9qjubuahQWynkAY+iWxlFP8huAHUuTkf7hn8pmtslphxL5TaSMe4
 6vf8hTewrDwq3ykjMJTdPr8t5jEW7jM4d8Ot/AxGHJ07n4SWM4AgXQgJH7rQ5Rh6Grqn
 OFZg==
X-Gm-Message-State: AOJu0YwYqbMsa6q3KTQ8U30M7uzIGRkfoZ4aSH8dFu/hIV/1YMp+FjAK
 cbNH6ucTKjRua2yVes0cEPZnf10L2lN+OHXPbYBe9rLAJ3Xg1fsxRfm31AjylycpZk7hfn4q2Kw
 G3UbZXny+C5+WZVRqRwCMJH51VtWpjNWGdbJ/XQ==
X-Google-Smtp-Source: AGHT+IGcWReHhQNzeY4az4Ug9fiBQHAptS2+H4XP4vqRDhuUm+F/HrOlvRVMwJjNOXPYiIOk7xAG/c8EvTeCgS9aRUY=
X-Received: by 2002:a50:f692:0:b0:564:5150:76a2 with SMTP id
 d18-20020a50f692000000b00564515076a2mr2094830edn.4.1709908518853; Fri, 08 Mar
 2024 06:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-6-alex.bennee@linaro.org>
In-Reply-To: <20240307181105.4081793-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 14:35:07 +0000
Message-ID: <CAFEAcA-ed_oEi_kkA=7pZhr+WYgmvZWuzHibmJwTtVjRFo_GyQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] docs/devel: mark out defined functions and structures
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Juan Quintela <quintela@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 7 Mar 2024 at 18:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> This allows sphinx to hyperlink the references to their kdoc
> definitions for easy navigation.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/devel/memory.rst | 48 +++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)



Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

