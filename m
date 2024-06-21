Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A5EC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKhsQ-000767-3S; Fri, 21 Jun 2024 13:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKhsG-00073x-MM
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:16:33 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKhsE-0005QX-Ds
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:16:32 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ec52fbb50aso3942951fa.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718990188; x=1719594988; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmIr3z+v4emS/mox/5MobfFLaF4h5TJ4Ath2hAFHKY0=;
 b=SWbftGZYQ550A/lJariXWIYyFQA3cJXDHdQZhR4LDOuJSzWVSnwYwWzdV3R6NobFda
 OBDVxepStSFjYf2P358u8Grn6gfD5xP4abmCXOkuZeYkKW5cs0jASqVNNDaLuP0HIKOo
 Ndaj3mqEmCcleAqLeyjsUEVyp7IOI8PQMJBAPSktbxGMvRjxeLr9Uk4o8tNtHH4sBVdY
 b/p2Vy3CnAvtDpl12dtvBq0bwBBSnsBptiqadKbhrck/Fa6Fw8JwwLsmr1jjDlWTG7UC
 qhEwsjR/uldmxmzD94ZsLWcMTRSfjtY3NbKWoqQgyyJ135PbdW69av3apaC5KxkKvvb8
 93lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718990188; x=1719594988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmIr3z+v4emS/mox/5MobfFLaF4h5TJ4Ath2hAFHKY0=;
 b=f8NabEkNYTE4UfXCGFxVy5kMaztrISJ1zymdIU0MbSgoIGOhruSJt0XaueREQK+mBr
 2Z5nleo4XAQ82nGpiKzJJimQ4LSXJS1vvoSLzaJaKX1UMdCgpkHmEdf437cP4OVk5YNM
 /A17aqvEXfzVhBLJTQykMvJKYa3qgVedNauIGL6GxY89/B/V4WATJdw7ddzTrlT/1QzO
 g1sLVCA2CMYocuMU+nb74XMVOY/UJ2duCH2KJujO0ZROr75BIM7En9OxLjcIipykAMVX
 TUn/HLoYL69mNpdHkR6Yr52inmo1QjxyYSlRMKzIVrgFmWF3+aBUJMI2aT20/jxKN0/Y
 t8cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk1rxJ63v9M0dPmZMISb/GuZecAmWIWk3wGawqjsAqioE1JmqKrUP6SKzU9p1WgdQS/91+7IW5IGNOfxIs0WkECoDo3vs=
X-Gm-Message-State: AOJu0YyLN94gBeg0rfc7hFYdQSCzkYM+8C4m+1OMJU0RquJFonTZyKvJ
 VehDsiK/66t5tRCd51JUqdPL6Ueq+EtS5eHr5klEHLLVzmiAgWzWhYd6jOcmp6rJix5062HGPWT
 u4fP6IyXP0FR/nrssnt7adxJxC/2IPWc8xUhP+w==
X-Google-Smtp-Source: AGHT+IHtyQ43bd/L6VOHpOm0Uaf8obGwpdbvUbJyky61hzCx5pISL74Qc+p+jXKI/lQrA9r+7+KP8ZbPetSKGgNizgo=
X-Received: by 2002:a2e:6a14:0:b0:2ec:2ce8:5d18 with SMTP id
 38308e7fff4ca-2ec3ce7e086mr70220991fa.5.1718990188186; Fri, 21 Jun 2024
 10:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
 <87cyomxmvc.fsf@draig.linaro.org>
 <CACBuX0SMvD6+vWGBv_m0rBnwgp8fbv6rHKUmbr-MWDLknz8LyA@mail.gmail.com>
 <87msnqvtpv.fsf@draig.linaro.org>
 <CAFEAcA8-gnh3sF6yPuPOfHg=C4H2=f-VYobKcXNUdMCWpdYNNw@mail.gmail.com>
 <CACBuX0ScjkxnRBzmrpBwekV+WG4S0jsYgE_ch+TJ_fq_Xjbvfg@mail.gmail.com>
In-Reply-To: <CACBuX0ScjkxnRBzmrpBwekV+WG4S0jsYgE_ch+TJ_fq_Xjbvfg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 18:16:16 +0100
Message-ID: <CAFEAcA-o5bKOgYyXPYs754RMKnywO8NF0hGaw4=KuFjEghLQ6Q@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
To: Cord Amfmgm <dmamfmgm@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Fri, 21 Jun 2024 at 17:24, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
>
>
> On Fri, Jun 21, 2024 at 10:21=E2=80=AFAM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
>> Thanks; I've picked up this patch for target-arm.next (as with
>> your previous one for hcd-ohci, adjusting the Author and
>> Signed-off-by lines to both read David Hubbard).
>>
>> I tweaked the commit message a little bit, so the middle part reads:
>>
>>     What this patch does is loosen the qemu ohci implementation to allow=
 a
>>     zero-length packet if td.be (Buffer End) is set to td.cbp - 1, and w=
ith a
>>     non-zero td.cbp value.
>>
>>     The spec is unclear whether this is valid or not -- it is not the
>>     clearly documented way to send a zero length TD (which is CBP=3DBE=
=3D0),
>>     but it isn't specifically forbidden. Actual hw seems to be ok with i=
t.
>
> That tweak looks great.
>
> Thank you for your patience working with me to get this patch into a good=
 shape.
>
> This was my first attempt to contribute to qemu - really appreciate it.

You're welcome -- thanks for the effort you've put in on your end
working through our code review process.

-- PMM

