Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBA6D2F002
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 11:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkhMK-00057r-GD; Tue, 27 Jan 2026 06:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkhMI-00057L-2b
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:35:46 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkhMG-00034g-N8
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 06:35:45 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-78fb6c7874cso51719057b3.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 03:35:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769513742; cv=none;
 d=google.com; s=arc-20240605;
 b=UtXDPgGtGMvkw7agIxQP+q3hKiHuSvRzCVvWZiz8mQ7n/13lKlEEE0ZSXzLApTCWOA
 Pnf71tie6wqsq0Kve7oSrz1HclyRswjuCdcC7Mqenz2f9h1G/vXMYS4Vxt3qjH/smSZX
 FBPT4xoAgiV3+RZy9KlIJzTQWV7uVSiP2RVAVE8vLV1i+jR+5Lp9VRdkvQOaDCHCbt/k
 7AKZW0BeueVaiiO/B3l2zz5dpocwu4wsCZfCLci79I0nOcxuuYzAC/MuJCiSOM62p1pG
 A02bxkOffxBVBsJ+6/CwqZE7XYl3nwq0pj8HZO6tihiG796bTu7MbR1Qqq8Nb4hN0vk+
 HBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cUweJ8DT60Gl9GcK3qFepAGSikpTeRUJX/nB/Re9BS4=;
 fh=pI/9IkRt2BYer5GttJODJzhnNHJNCNAQCGHc+VLIWZc=;
 b=ivFjVHBSoM7kX8AN+/++uwlQhW1fPNETHwBaGxTtiKpDwR4v2tJzmMrL1v6si8GYdf
 9PrJWixeeBF6hT/T8fFlHHk1+VQAgUtW+7lJr2PaUZQY9krSF125XIpvN4bK2+bEKfrr
 P+z3Cuxmm9fT4EJpPkk6aEAkVBU+XQytUFD8PfGnEyD+cGj+INooknkN84TH99U7MQJ5
 hEYO1AUiml1+6jllQs7WM4FayjtJDWGtmi4Yc1UQ1odQd6/WaYwCVBeuBSDTx/Vltpdc
 hA5Gh2TE8NNzLTSG/bcAD6p6Tge0XRnoESdHxMuK7OVqm8DHYDCHuhGxXRtNZbpwhZSI
 A5QA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769513742; x=1770118542; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUweJ8DT60Gl9GcK3qFepAGSikpTeRUJX/nB/Re9BS4=;
 b=NkP1TdEk3M5WL+L1016GP/3CTo/D/TgfTs3XNOs6FGVr8Xfddx+t9eAxPWxeIypcH5
 K6o826nGE7xTjHBEnKbZVzdVAIxB1YMHDLts2ZyY+xzsGCwwLkh54Y9f3m1U1erl+UpB
 uT5oINNYX+mBoFQmT1cKgH7odnrNZQm2A8UAF6qIlkYTAaM9mTKVGyXiQAmHTrv3GwlL
 Kkr/10HNda9t0FPjDW9AYeXE9cdsC6PA6c4EPYSooccx/qOFSWYEJIjmia41/wMeZW/L
 bTJmUFKY+unsx95wEzUfD7skm5h3z/fchr2fOQ+CEwgEuQ5h0peYzWKImwLb/C/7oU35
 haXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769513742; x=1770118542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cUweJ8DT60Gl9GcK3qFepAGSikpTeRUJX/nB/Re9BS4=;
 b=jTViwHlSdsAaWX1VwZVVqtpRBzwaG6p99jG4JPMIxXjKzG4TCko5bMsc964lplxqPp
 od9CwMzRMqv+CuPh462kSdvwcQ/ngOGyrud87eTt4Z4IO81jjMDzletvumNTZmDMINbk
 iXV90NDqPM9IhsLMhQxOjiIM+HIhU1nxAqaG2nNhcMF2UuvY8/Svt5x7xmjkn5WMPrgN
 STD0XksRbY3KPHpzXQyfLczEdmFhHJv2uUzjhaefH147DbjJRwyr19soB5JQzRFBYXOL
 S0YpP0yjjM5vwTw9M51nrHfApoYfUuOT6TH+onrl4YBfmLsqlz3QhMM7IZB121wYGX+8
 GU/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTpkh5kZ5VVvYfGORUokmeAuLI+6Yv5/e5cAK3S5yNuzo1/VB3RWaTTI0FLyYLkNqu/Cr52uabsH8h@nongnu.org
X-Gm-Message-State: AOJu0Yz7ASIhIfo0rBzmro7gse3YF0eviKpxqxKs7x3NDn7y1ohcIQ+F
 HHrqKxkck8pz4afNghXQWdAEZNidLy9XqUDph15Vz8srh0i6nsqfANBnQzDiet6V85AjbSb8NrW
 rMnwfDfu3/wSF3Atcf3uZA0hCf/9i8rtfnNUvOcdG1g==
X-Gm-Gg: AZuq6aIYW6oA1R2Ml5bakghX6WVWVTJgu+g5FaXLr9Z8GuVT1uEcSc9NeHobcZIyAVF
 IphoKuocC2S2dmbV7rP6ZELwRN9+zZuh+FLr2GQ40zvp+y7XNAAn/WzE4dY/fJ/HewLlHBiaTHS
 qv5qWoJdDN+YIYztXd/a6l+Zba5THUJnQ3uW9dTDfThKYeBwCjMSR6QktNzz5PvH1no2U1bEnry
 8UuhcvWR+sEd4GzF31NTlwm7a7y63IfBsLa4akKvNIRR4ExFh+wzHjK3oAvH9pYpJ8pvw==
X-Received: by 2002:a05:690c:498f:b0:78f:cb46:4fab with SMTP id
 00721157ae682-7947ab47071mr7993887b3.27.1769513742113; Tue, 27 Jan 2026
 03:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20260125-virt-v4-0-00d726b27224@rsg.ci.i.u-tokyo.ac.jp>
 <11A957F3-794E-40DD-8E39-4DB8589B1657@unpredictable.fr>
 <52384324-11dc-4ee6-a059-c1dd245753d0@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <52384324-11dc-4ee6-a059-c1dd245753d0@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jan 2026 11:35:30 +0000
X-Gm-Features: AZwV_QguC7yjMwxQtlH6RD6sHtTVvanvzmRQ7dG-EUzAiHl2OODAqxC9FggD2NE
Message-ID: <CAFEAcA9UgwksjgW=BYWUSA7=pTK39fx51ox=tz2YrmKsfnRfzQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] hw/arm/virt: Remove the lower bound of HighMem IO
 Regions
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>, Andrew Jones <ajones@ventanamicro.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, 25 Jan 2026 at 07:31, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/01/25 16:23, Mohamed Mediouni wrote:
> >
> >
> >> On 25. Jan 2026, at 06:46, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp=
> wrote:
> >>
> >> Remove the lower bound of the Highmem IO Regions' addresses for the
> >> latest machine version to increase the chance to fit the regions in th=
e
> >> PA space.

> > Would it be a good idea to have a new test configuration that keeps the=
 old memory map? To make sure that older machine versions don=E2=80=99t reg=
ress
>
> It is a nice suggestion. I will add one with the next version.

Just a note to say that I have no objections to this patch and Eric
has reviewed it, so I expect to apply your next revision when you
send it out.

thanks
-- PMM

