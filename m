Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36E6C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 02:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwujb-0002j8-Cx; Tue, 16 Apr 2024 22:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rwujZ-0002iu-TV; Tue, 16 Apr 2024 22:09:13 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rwujY-0002t5-9u; Tue, 16 Apr 2024 22:09:13 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e4c4fb6af3so2648635ad.0; 
 Tue, 16 Apr 2024 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713319750; x=1713924550; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tW0F8yVnPEfd4Z5ofuot2760kNLGK+RDe9+v58xLv8Q=;
 b=h0O0EwKCdhXjTEF8Oli+yN/IDfb4iUUnzHHqSXpKrObVPxOKPqPA9wWJO+v2WAHHVs
 LrkYcmjFajLvE6SnXPpmnMN23LVqMUi1eFPOqtlmAlW3oB90kKqiTAfPlz5DYPn5exni
 ktma3Tcr2VMsdv1Y5DnH+J1T7OAePBBihwaUA0ADaQdX8h4HrF2c6WXs6OfDxktH/2kO
 djk5jVYqPIPOX5ZdWtW4ssx7GpwXTdXlBkBLyMQ5hRhKPD4f4OD9PTvHYB4lPw/jA6Zh
 ik63hxlX3Qlpu1XMXviNODReCwLt+K/j09a1beoWOGzfGNXq3NPFQYhPS/UEqJKaSLzE
 Abjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713319750; x=1713924550;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tW0F8yVnPEfd4Z5ofuot2760kNLGK+RDe9+v58xLv8Q=;
 b=tYqCliIH6fQUqm5D0W90UBm6q0RYvU/l7nL947aO3suhWWxdQVr+E4+IC6vyoGN/x6
 irsAtxQB8+FVWT1BVWxMl4QSCw1OGMS775B6gB8bqNbvXfRAheMEgXxtbl6G9pir8hDg
 Ug2jpLaanWgWolNvQVdJ7ob8vqz6VnEu01SDHlEgMrGJ/5QkB+FBswEoOL3zK3ujF/Kj
 P+ajK/Yq4cKXIAfnhduqO1/0/ab4TR40en4UG3AtQbS4KUFLEluYPCmpIBnsXl9aiOUT
 Ur/oBp9pJviBouG2rcZVQcxXtB2k9alcEv+41uEwEDda+SKJmX2wCnBNqcP6SVPiqH6S
 XosA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLf54UW8H6DkIXJNFKCjbJaeAe0JJLH9XkOHzzaDzcCR+zH7g1m1+8Mc1Nc6WiSSkpy7kYnlfR0BBD6AMrmd5d5x4w
X-Gm-Message-State: AOJu0Yz1csuT1j/c9QN5Iw6Sa0m/fQH/WYKl9agYb7/yOhHfBaqUr3BN
 QAPzFbqd4G/bHR9BTJdjSyIOKmwnpoPBuagb01O5KA1bR+Nhh7LQ
X-Google-Smtp-Source: AGHT+IH5P0YWB3u5h5sVLG9Io8HbPq+w+ItWTrVHH+VxV8UEcWlCrUR+swwq3k/ljL7ZuhA8cwap9w==
X-Received: by 2002:a17:903:190:b0:1e2:36d1:33fd with SMTP id
 z16-20020a170903019000b001e236d133fdmr7029594plg.27.1713319750343; 
 Tue, 16 Apr 2024 19:09:10 -0700 (PDT)
Received: from localhost (gla2734477.lnk.telstra.net. [110.145.172.154])
 by smtp.gmail.com with ESMTPSA id
 w23-20020a1709026f1700b001e5c6c399d7sm5217944plk.180.2024.04.16.19.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 19:09:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Apr 2024 12:09:05 +1000
Message-Id: <D0M15TBEVI61.39GZJJCEYK1L5@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Peter Maydell"
 <peter.maydell@linaro.org>, <philmd@linaro.org>
Subject: Re: [PATCH for-9.0] ppc440_pcix: Do not expose a bridge device on
 PCI bus
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.17.0
References: <20240409235543.0E0C34E601C@zero.eik.bme.hu>
 <D0G5YFXXNK98.3NO5536V5LC8N@gmail.com>
 <887fc804-54a6-8f00-1b62-afcf247ba319@eik.bme.hu>
 <D0L6WPE1ASIP.2KG5P0WQ86AM6@gmail.com>
 <adb592cb-f58d-1eff-56a7-70fa11339fb7@eik.bme.hu>
In-Reply-To: <adb592cb-f58d-1eff-56a7-70fa11339fb7@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Apr 16, 2024 at 7:43 PM AEST, BALATON Zoltan wrote:
> On Tue, 16 Apr 2024, Nicholas Piggin wrote:
> > On Wed Apr 10, 2024 at 9:03 PM AEST, BALATON Zoltan wrote:
> >> On Wed, 10 Apr 2024, Nicholas Piggin wrote:
> >>> On Wed Apr 10, 2024 at 9:55 AM AEST, BALATON Zoltan wrote:
> >>>> Real 460EX SoC apparently does not expose a bridge device and having
> >>>> it appear on PCI bus confuses an AmigaOS file system driver that use=
s
> >>>> this to detect which machine it is running on. Since values written
> >>>> here by firmware are never read, just ignore these writes and drop t=
he
> >>>> bridge device.
> >>>>
> >>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>>> ---
> >>>> This is only used by sam460ex and this fixes an issue with AmigaOS o=
n
> >>>> this machine so I'd like this to be merged for 9.0 please.
> >>>
> >>> Is it a regression? Does it have a fixes: or resolves: tag?
> >>>
> >>> Unless we broke it in this cycle, I would be inclined to wait,
> >>> and we can ask to put it in stable.
> >>
> >> It's not something that broke in this cycle but since this does not af=
fect
> >> anything else than sam460ex I think it's OK to change this for 9.0. Th=
e
> >> changes to 440 tlb in this cycle made sam460ex more useful to run Amig=
aOS
> >> and this fixes the file system driver on it so it would make 9.0 reall=
y
> >> usable. Otherwise people would have to wait longer until August or ins=
tall
> >> a stable update. Since this has low chance to break anything (tested w=
ith
> >> AmogaOS and Linux and MorphOS does not boot due to do_io changes anywa=
y) I
> >> don't think we have to wait with this.
> >
> > Hey, travelling / at a conference / on vacation for the next couple of
> > weeks.
> >
> > It's just a bit late for hard freeze IMO, since we didn't break it
> > before the prior release or a bad security / crash bug. Will put it in
> > 9.1.
>
> Philippe already queued this (and another) patch. This fixes AmigaOS on=
=20
> sam460ex which became usable with the tlbwe changes in this cycle but it'=
s=20
> not really usable without a file system driver that this patch fixes.=20
> Please allow this in 9.0 so users who want to try it don't have to wait a=
=20
> few months more. Sorry for sending it this late but it was reported late=
=20
> and took time to debug it.

No worries, I don't have a problem with the patch so if Philippe
thinks it's okay then I'm fine with that.

Thanks,
Nick

