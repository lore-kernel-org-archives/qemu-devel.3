Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178FAD5D69F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 02:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Ea6-0007jJ-R5; Thu, 07 Nov 2024 21:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t9Ea1-0007ig-CG; Thu, 07 Nov 2024 21:18:35 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t9EZz-0007zX-HH; Thu, 07 Nov 2024 21:18:33 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20cf3e36a76so17720085ad.0; 
 Thu, 07 Nov 2024 18:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731032309; x=1731637109; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8cfJKZyJP6YPI9M5MDQrfybwmBfQihlukJvv1laA6Q=;
 b=BTAReAAcizR3wpnscGgQotfTyTKPtEGdQ2pQEWheK3bmjD3LEjy6wQQecs07zQxLiT
 vUjLYsD5zPOOFpM5UbZ5LThZORUnzkDCOmel8XohqMiPqYtfb4hBuHC8v/hiiv5I1oJx
 qjzDXvIoCSArISvD1SZQBuayeDLji82qPFRYyA2QBoAJia+JFmjf+mw/7Pf9l4MG2FFj
 4VzWF5UtnBuKHxTg9Ip1mV5+MfUyLaZDjBOry0KQvb87O9mhqSKOIS+0uBkyocJbc57p
 1HrsLCAuuC9aGlhggaJ3B5bNfyCwwq7IfjislqCGm2jbr1z6mTB6Qp22AbjoVLbJIZaE
 ohsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731032309; x=1731637109;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p8cfJKZyJP6YPI9M5MDQrfybwmBfQihlukJvv1laA6Q=;
 b=sCUHW/8ye1yEEZkQV0yPy2MhthBqOpCrByVLsnGDffdk40CM2VjIteETPMFjLzpkZC
 /ZP2JbQqSAuVY+CWbFDYirpdKh+Ti9J8IfiwQiXvLXEd/VlnUj7dihcS0Xj0dZHd8hV+
 B6SNOLLuAXChHuICJmoms8jikIsSBFLHGi1eiOIzhUmpVFo1I8atH2Ij/T0HwLX6QDkV
 Xl+2Uy9mM0bZ3Pp7Y69Vx8rwaCnQAxX26QZA6uyt0lCPpwEy0/JNm8Tg4fQ2ipZz01/O
 4g97+F+krwcomBTbY1wUYv/9oGWkJ9NnTDL9RQdb+WkAW7FNmboHLNvgRr780udxetSj
 af1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxwTH1C4av6uxxe1GRsuk1tntd12bKspZUD4SC0cNi3YELW+TUPyoLj+FzjVNC9WKrYa7ifM8WPA==@nongnu.org
X-Gm-Message-State: AOJu0YyPu1qykT33Q1yD8rBYmXAt5Seo6eg0XcMS2ZObN6E4Ya2z6pLY
 V3sXLh0MDpIJWgDn3C+ozsyxKLlGOr14eEMAAgUcQnU41EQzxR00Fnfqwg==
X-Google-Smtp-Source: AGHT+IG0EvQzMDfwy3BBw6DEZhOnfL71HOLQb16D4/bq8bhvXYkp+0lFd279gFcF3TgxMPlNP6Ja8w==
X-Received: by 2002:a17:90b:4c48:b0:2e1:a81f:5520 with SMTP id
 98e67ed59e1d1-2e9b166bbaamr2193879a91.1.1731032309217; 
 Thu, 07 Nov 2024 18:18:29 -0800 (PST)
Received: from localhost (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a541d06sm4390031a91.14.2024.11.07.18.18.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 18:18:28 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Nov 2024 12:18:22 +1000
Message-Id: <D5GFQLPB4Y4Y.1EQHGLP9COK6H@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Glenn Miles"
 <milesg@linux.ibm.com>
Subject: Re: [PULL 15/96] ppc/pnv: Implement POWER9 LPC PSI serirq outputs
 and auto-clear function
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Peter Maydell" <peter.maydell@linaro.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
X-Mailer: aerc 0.18.2
References: <20240725235410.451624-1-npiggin@gmail.com>
 <20240725235410.451624-16-npiggin@gmail.com>
 <49b1d57d-e0bf-4b64-b6ef-3cb4e1da5d65@kaod.org>
 <CAFEAcA869xMGhB+K1x722CL0bD0a55+oWofpsW610HSycz_Yag@mail.gmail.com>
 <CAFEAcA9pNo4Yyt42msbs4jqk6xACziUMSfeNnxPt-WWpRtn7BQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9pNo4Yyt42msbs4jqk6xACziUMSfeNnxPt-WWpRtn7BQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Fri Nov 8, 2024 at 12:18 AM AEST, Peter Maydell wrote:
> On Tue, 5 Nov 2024 at 17:35, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > On Mon, 29 Jul 2024 at 11:11, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
> > >
> > > On 7/26/24 01:52, Nicholas Piggin wrote:
> > > > The POWER8 LPC ISA device irqs all get combined and reported to the=
 line
> > > > connected the PSI LPCHC irq. POWER9 changed this so only internal L=
PC
> > > > host controller irqs use that line, and the device irqs get routed =
to
> > > > 4 new lines connected to PSI SERIRQ0-3.
> >
> > Ping! It looks like these issues are still floating around...
>
> I just noticed that they were fixed in the pullreq that just
> landed; sorry for the noise.

No problem, understandable sorry it took a while for me to merge.

Thanks,
Nick

