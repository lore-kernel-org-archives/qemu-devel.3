Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0734C48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 10:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ravix-00064L-Ay; Fri, 16 Feb 2024 05:45:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ravig-00061R-9u; Fri, 16 Feb 2024 05:45:41 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ravie-0005xg-RJ; Fri, 16 Feb 2024 05:45:26 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7d5c25267deso817191241.3; 
 Fri, 16 Feb 2024 02:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708080322; x=1708685122; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/UjKXq3MDc1YOmdyG6/ZhanAigAXsHtLp89uteudHg=;
 b=VBEsAZvXaFoE4SfavI6SqHX26XbiSEgtzvM/SExz6Ms9SyG13F4CZ6F5hCeIF1IyZc
 xT1CvcYAxsvHYOezd/GlbyPPPMq0M/OEExpKcZuO9gg7lwcsEjrkciuCfZzqDwVXTDra
 WCUFlwrgJ5pdkzixr1L7tfwI3mA73exorHHq79lNtYJDaljtqX4KyRkEiPtZ2rCl2Y2d
 mnYW/RZEKgf9oUDTEkWcRYKoRZKnlMVWmijOSq1EwPjZQJKM2Q8iu9qnD6+9my/DZ/qX
 9/QMLybbGbid1w7MkkPEPARImtmXk66k6r5ICAAaRHur7GAa/3YTeRtNeef1GtVyC5L0
 rNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708080322; x=1708685122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/UjKXq3MDc1YOmdyG6/ZhanAigAXsHtLp89uteudHg=;
 b=hzntFc7/Rao0Y1SDHCPyUARWlDvqofMN2KUse0nk3s8GmbA6IFWNFq4NMlJmEpcitC
 pTs/R1dgQanL04fv34hIZN6UcXh8To0y6mYZFwf61BP01s/El/mc+YrZFHgtUsq4XY22
 QeWF5XMtU8KmetJPs739YSTegAFS5Nv7UoVzNndU/pklqZowL9ZlkzPQZdjscQGK1TUL
 6J6cZ8QS+vG7emtJXAKLS9d0c5HazNms2HJhJqaSRVbLc0g5O8yoqZq4sioWFVpTunQM
 9YTUpviGvt5hxUI4H8HZPxeogBtf02TU9kaxj7DFp0khDYUfFyjbFG1GcqGilD1RBzUi
 tnwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHUSw+X8jaaFAWTVQyxCTxmc41w5ySG7ajKY2gXxI6S+QFzQrsM9s3r4R3zJ8IZhBo3C4uLO1uEhEJ2LJx0NmCVI/o3yI6EmpBTvskOJeSqcXhI/JMoVqwz8y9mw==
X-Gm-Message-State: AOJu0Ywq1nWbFl+6kWMoi/VSeBn2tiRuXlMd6E0NrfVXjiZGj9dN5/oo
 Ev1dzsxzM19GrviBS0hgJlNM7bFgkbJa18SCDTCWKZdLw7UIG+iBi0vFXktwpI3A1veA2rFk1/m
 OwXzr07ekJARCOPVXCZ8ZIvkrncI=
X-Google-Smtp-Source: AGHT+IHrqU8XU+pywPWEtfhMPOZk/cE0DmDpPEOBRlzyJHFLvPlsz7tMO+mNkbOJWI8YddAho5rZiaEK19IzkwXUPGs=
X-Received: by 2002:a05:6102:3a08:b0:46d:3e3e:c15d with SMTP id
 b8-20020a0561023a0800b0046d3e3ec15dmr5283235vsu.5.1708080322337; Fri, 16 Feb
 2024 02:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20240213024403.1060188-1-alistair.francis@wdc.com>
 <20240215144434.00005bf9@Huawei.com> <Zc8iLc3KWhcjChQo@cormorant.local>
In-Reply-To: <Zc8iLc3KWhcjChQo@cormorant.local>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 16 Feb 2024 20:44:27 +1000
Message-ID: <CAKmqyKMZ7bYJAL0HyenocnZELY7xqhav0tC5uXK636Q+syMvXA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Initial support for SPDM Responders
To: Klaus Jensen <its@irrelevant.dk>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, marcel.apfelbaum@gmail.com,
 mst@redhat.com, 
 hchkuo@avery-design.com.tw, kbusch@kernel.org, lukas@wunner.de, 
 wilfred.mallawa@wdc.com, cbrowy@avery-design.com, qemu-devel@nongnu.org, 
 jiewen.yao@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Feb 16, 2024 at 6:52=E2=80=AFPM Klaus Jensen <its@irrelevant.dk> wr=
ote:
>
> On Feb 15 14:44, Jonathan Cameron wrote:
> > On Tue, 13 Feb 2024 12:44:00 +1000
> > Alistair Francis <alistair23@gmail.com> wrote:
> >
> > Hi All,
> >
> > Just wanted to add that back in v2 Klaus Jensen stated:
> >
> > "I have no problem with picking this up for nvme, but I'd rather not ta=
ke
> >  the full series through my tree without reviews/acks from the pci
> >  maintainers."
> >
> > So I'd like to add my request that Michael and/or Marcell takes a look
> > when they have time.
> >
> > I've been carrying more or less the first 2 patches in my CXL staging
> > tree for a couple of years (the initial Linux Kernel support that Lukas
> > Wunner is now handling was developed against this) and I would love
> > to see this upstream. Along with PCI and CXL and NVME usecases this
> > is a major part of the Confidential Compute device assignment story
> > via PCI/TDISP and CXL equivalent.
> >
> > It's not changed in significant ways since v2 back in October last year=
.
> >
>
> Would someone be willing to sign up to maintain the spdm_socket backend?

I'm happy to and should have already edited MAINTAINERS to indicate
that. I'll fix that up in the next version

Alistair

