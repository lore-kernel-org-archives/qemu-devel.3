Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55265C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUhsN-0007Td-LI; Fri, 19 Jul 2024 03:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sUhsL-0007FS-NR; Fri, 19 Jul 2024 03:17:57 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sUhsJ-00042n-WF; Fri, 19 Jul 2024 03:17:57 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70b703eda27so456346b3a.3; 
 Fri, 19 Jul 2024 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721373474; x=1721978274; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7r/EKvLMaT6rTKNVXpvOL6HFBIS99BDRxCgfXt26Kiw=;
 b=TKeGyIXyQP+tUk4jOaPbJJI9joiGHE6rIHPWFOWntdw3OrfRO/xkGlvmW4iXk++W2Z
 renKL81gw2UGCk5zn0N4JNXpUe9M/D4hglmF+jAuunDcn92gT6rOAMNJk6/Q8gsXK2Ig
 uhfT2axlMeZcvRCUitdjSIPX5lypOrqM08L33ekxMHrONh11YzJNxAzS8nUHuVGTpqwm
 IaVgy/Y5WKTIuefVv6Nvm+c4Bx+zcr0fq6y4KtwXt0eXVrOggkZnQ+zriBc7TH+of1q9
 6iTZD0EVsWJHFbf9baCvUfm2rbaCrRdOcUJ0l+FspycPcVRrgwRvfslLhq9l48EylMv8
 g75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721373474; x=1721978274;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7r/EKvLMaT6rTKNVXpvOL6HFBIS99BDRxCgfXt26Kiw=;
 b=jqf2Nnu8yx5+QpS6oEFQhs+V6hMDSH9kDXCbTcrLmCsRsYwBbIeKVSeV+X5PsTWc5+
 UrdvcJGFB2YL8er9R30xb+VVwkhrWmU8td3ZrzmHtxRI9wspAZJD9Fla9leM6Bcu5e+s
 NY7epMlXBZl1upCX9DSf1MPI3rp9u8YMzFBfz/dlP7JQHqrhUFtGOVmjaSLIiPi/A3Tm
 2mMT1mjkqeuNgU3xWANe0CzCEgXJ5AiIiewrATw1XQ/YFGF5ur4iv2YMbY98tbBTemFO
 ojzMnO1rMMFJE7JAAHl29Nkjf4GjYUr0YjjD1aJQm5hvQj59eIckKLMuunm4yx6OwZ9I
 JSbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4UlHn6ofqpH2jLMbxvNfm5yBTdZ8a2X+UcH1nZtGR22XSZ1GF7qooof5nhwc0r3YuqxgAw9thoRV8y+UNMobYRSEP2wI=
X-Gm-Message-State: AOJu0YzxP6F2jz8mFgTe8UB0urrYrxRKFtqSct7qOb+jpRSPiXRR/dps
 Lzayu6Z6kKJ2DkIXId24xIlUKWw5kcoIEW/xsc3bU74Q1hc2MuSS
X-Google-Smtp-Source: AGHT+IF2sGYnrXew5XWMZokNtBxi51d9ezmaYNxOgg2aqKiltjo7BXwigxBwizBckH3/OX0IAHRWhQ==
X-Received: by 2002:a05:6a20:a106:b0:1c0:f2d9:a453 with SMTP id
 adf61e73a8af0-1c3fdc4cc8emr9118533637.8.1721373473690; 
 Fri, 19 Jul 2024 00:17:53 -0700 (PDT)
Received: from localhost ([1.146.64.219]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d5db43sm7250755ad.280.2024.07.19.00.17.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 00:17:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jul 2024 17:17:47 +1000
Message-Id: <D2TBYTSA9D80.3IKZGVWEHC1M6@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>
Subject: Re: [PATCH v3 0/9] XIVE changes for Cache Watch, VSTs, STT and info
 pic
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Mike Kowal" <kowal@linux.ibm.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Michael Kowal" <kowal@linux.vnet.ibm.com>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.0
References: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
 <4b72c7b9-a812-43c6-b735-43eac8709fc6@kaod.org>
 <4d5b20b4-7c78-40d4-9844-fa013e0eb8ec@linux.ibm.com>
In-Reply-To: <4d5b20b4-7c78-40d4-9844-fa013e0eb8ec@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

On Fri Jul 19, 2024 at 2:38 AM AEST, Mike Kowal wrote:
>
> On 7/16/2024 3:18 PM, C=C3=A9dric Le Goater wrote:
> > Hello Mike,
> >
> > On 7/16/24 21:56, Michael Kowal wrote:
> >> These changes provide enhanced support of the External Interrupt=20
> >> Virtualization
> >> Engine.=C2=A0 The changes are focused on the following areas:
> >> =C2=A0 - Cache Watch, Cache Flush and Sync Injection
> >> =C2=A0 - Virtual Structure Tables
> >> =C2=A0 - Set Translation Table
> >> =C2=A0 - 'info pic' command data that is dumped
> >>
> >> Frederic Barrat (7):
> >> =C2=A0=C2=A0 pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync Inject=
ion support
> >> =C2=A0=C2=A0 pnv/xive2: Add NVG and NVC to cache watch facility
> >> =C2=A0=C2=A0 pnv/xive2: Configure Virtualization Structure Tables thro=
ugh the PC
> >> =C2=A0=C2=A0 pnv/xive2: Enable VST NVG and NVC index compression
> >> =C2=A0=C2=A0 pnv/xive2: Set Translation Table for the NVC port space
> >> =C2=A0=C2=A0 pnv/xive2: Fail VST entry address computation if table ha=
s no VSD
> >> =C2=A0=C2=A0 pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c
> >>
> >> Michael Kowal (1):
> >> =C2=A0=C2=A0 pnv/xive2: Structure/define alignment changes
> >>
> >> Nicholas Piggin (1):
> >> =C2=A0=C2=A0 pnv/xive: Support cache flush and queue sync inject with=
=20
> >> notifications
> >>
> >> =C2=A0 hw/intc/pnv_xive2_regs.h=C2=A0=C2=A0=C2=A0 | 108 +++++++
> >> =C2=A0 include/hw/ppc/pnv_chip.h=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> >> =C2=A0 include/hw/ppc/xive2_regs.h |=C2=A0=C2=A0 9 +
> >> =C2=A0 hw/intc/pnv_xive2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 566 ++++++++++++++++++++++++++++++------
> >> =C2=A0 hw/intc/xive.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +-
> >> =C2=A0 hw/intc/xive2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 33 ++-
> >> =C2=A0 6 files changed, 633 insertions(+), 96 deletions(-)
> >>
> >> --=20
> >> 2.43.0
> >>
> >
> > Hello Mike,
> >
> > When you respin a series, it is useful to update the individual
> > patches with the given R-b tags. To keep track of them, you can use
> > the b4 command :
> > =C2=A0 =C2=A0 $ b4 am 20240715183332.27287-1-kowal@linux.vnet.ibm.com
> > =C2=A0 Grabbing thread from=20
> > lore.kernel.org/all/20240715183332.27287-1-kowal@linux.vnet.ibm.com/t.m=
box.gz
> > =C2=A0 Analyzing 23 messages in the thread
> > =C2=A0 Looking for additional code-review trailers on lore.kernel.org
> > =C2=A0 Checking attestation on all messages, may take a moment...
> > =C2=A0 ---
> > =C2=A0=C2=A0=C2=A0 =E2=9C=93 [PATCH v2 1/9] pnv/xive2: XIVE2 Cache Watc=
h, Cache Flush and=20
> > Sync Injection support
> > =C2=A0=C2=A0=C2=A0 =E2=9C=93 [PATCH v2 2/9] pnv/xive2: Structure/define=
 alignment changes
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + Reviewed-by: C=C3=A9dric Le Goater <cl=
g@redhat.com>
> > =C2=A0=C2=A0=C2=A0 =E2=9C=93 [PATCH v2 3/9] pnv/xive: Support cache flu=
sh and queue sync=20
> > inject with notifications
> > =C2=A0=C2=A0=C2=A0 =E2=9C=93 [PATCH v2 4/9] pnv/xive2: Add NVG and NVC =
to cache watch facility
> > =C2=A0=C2=A0=C2=A0 =E2=9C=93 [PATCH v2 5/9] pnv/xive2: Configure Virtua=
lization Structure=20
> > Tables through the PC
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + Reviewed-by: C=C3=A9dric Le Goater <cl=
g@redhat.com>
> > =C2=A0=C2=A0=C2=A0 =E2=9C=93 [PATCH v2 6/9] pnv/xive2: Enable VST NVG a=
nd NVC index compression
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + Reviewed-by: C=C3=A9dric Le Goater <cl=
g@redhat.com>
> > =C2=A0=C2=A0=C2=A0 =E2=9C=93 [PATCH v2 7/9] pnv/xive2: Set Translation =
Table for the NVC port=20
> > space
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + Reviewed-by: C=C3=A9dric Le Goater <cl=
g@redhat.com>
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + Reviewed-by: C=C3=A9dric Le Goater <cl=
g@kaod.org>
> > =C2=A0=C2=A0=C2=A0 =E2=9C=93 [PATCH v2 8/9] pnv/xive2: Fail VST entry a=
ddress computation if=20
> > table has no VSD
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + Reviewed-by: C=C3=A9dric Le Goater <cl=
g@redhat.com>
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 + Reviewed-by: C=C3=A9dric Le Goater <cl=
g@kaod.org>
> > =C2=A0=C2=A0=C2=A0 =E2=9C=93 [PATCH v2 9/9] pnv/xive2: Move xive2_nvp_p=
ic_print_info() to=20
> > xive2.c
> > =C2=A0=C2=A0=C2=A0 ---
> > =C2=A0=C2=A0=C2=A0 =E2=9C=93 Signed: DKIM/ibm.com (From: kowal@linux.vn=
et.ibm.com)
> >
> Thank you for the suggestion Cedric.=C2=A0 I can get `b4 am` to run but t=
he=20
> attestation (signature checking?) fails.=C2=A0 In the future I will post =
the=20
> following, along with revision comments in the cover letter.=C2=A0 Follow=
ing=20

Hey Mike,

It's enough just that those 'Reviewed-by' lines are added to your
individual commit changelogs before you re-send. No need to send
the b4 output.

Thanks,
Nick

