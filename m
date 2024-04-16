Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ECCC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 02:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwYXC-00012n-LX; Mon, 15 Apr 2024 22:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rwYXB-000125-2r; Mon, 15 Apr 2024 22:26:57 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rwYX9-0008RY-Fx; Mon, 15 Apr 2024 22:26:56 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6eaf9565e6bso2402495b3a.2; 
 Mon, 15 Apr 2024 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713234404; x=1713839204; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zivetNqQUIMh9KPd0WEwnV76B5YyiKzZ3E3y1dMd3Q0=;
 b=OnTWB7kfLuYdpAjjj8PLhbifdt80P0aosmgvVqy3aAcEohF0EM89LH4MWsJmQurwy/
 V2kcuxi71Q78scrUn/C1rgTp3EZBMt7zH2Sau9C7F9GLCL7SbiUlGNY08J84v10U5F16
 TPkmb072M+joWSm0qonbwEHcRi1HpILJB2FlOhgph4d26x5wyCF5Fvcz0S69wNNIsQfR
 AyjHdxSKDwcQO1rqc2rx2wFaBkIhzHLr04pA2k3ySX3TFN/QdLvGPiKMMm5ws00whkTQ
 pbbakpGL4tXJwm3mR9zI5RvOWNR83pOtzpDGIi6UCb5eT7JHy8yTS8EO5Xw3WoXBtQZ+
 Xukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713234404; x=1713839204;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zivetNqQUIMh9KPd0WEwnV76B5YyiKzZ3E3y1dMd3Q0=;
 b=qPMdBr3KlhgiZL1Ee5XvcDJP6TdUrU1CI5A9f006b/ZalXCkZA0SSlPcawU7MVbVg8
 KuLrrXeCxtEDyBmSVMz2yrVwRRWTLzoGVGW+WEAlnuTwEe9sQH7GHwjOryJyYjiF3LL6
 l7fIZUcCvGMUuexJzcLGLAP+f9Ut5d3V/2bKqikX/oyBNPAmX2OqrQuyhDMCRsdnNZmi
 UcSxpXUWNQMHQk8T6rkhA9Lmweo65I1uKD0j8pnEyz8H61CSXGeKhFMNYVDPDB2GSkdL
 5OKzkvjdNZbikAJXi7BztKCMvHbcD+qamqMzQ7PNLFpRuEUexRpxqOI9zpzdVmJglUEy
 CBMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+ZYVFlvrG8NaokMCqUhsO1BcvTMScBEfRxhhAjVz1FZZXbP6bZqr5SM1uLO4bYM0vKGk8Rnm73hOGVqdc6Hdb2jLz
X-Gm-Message-State: AOJu0YxEwve55ao6tcZgh0aOR+CIVeCaUIZW8hFA2w8dJZck2HLxDL98
 whuYqUB74E3/1pOhKizxX+3gqT+IWHJwi2IbdZejX0negxpIygrB
X-Google-Smtp-Source: AGHT+IFUypA0WiIMMpmPuxfSCCxcKd4vEBOLDhtiSf03eUBHYVhjk8wGwDk3lxMpEFo2ieIyh1SqmQ==
X-Received: by 2002:a05:6a21:78a7:b0:1a7:6918:9e96 with SMTP id
 bf39-20020a056a2178a700b001a769189e96mr12327422pzc.3.1713234403915; 
 Mon, 15 Apr 2024 19:26:43 -0700 (PDT)
Received: from localhost ([1.146.24.97]) by smtp.gmail.com with ESMTPSA id
 n4-20020a17090a5a8400b002a5d684a6a7sm8603158pji.10.2024.04.15.19.26.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 19:26:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Apr 2024 12:26:38 +1000
Message-Id: <D0L6WPE1ASIP.2KG5P0WQ86AM6@gmail.com>
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
In-Reply-To: <887fc804-54a6-8f00-1b62-afcf247ba319@eik.bme.hu>
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

On Wed Apr 10, 2024 at 9:03 PM AEST, BALATON Zoltan wrote:
> On Wed, 10 Apr 2024, Nicholas Piggin wrote:
> > On Wed Apr 10, 2024 at 9:55 AM AEST, BALATON Zoltan wrote:
> >> Real 460EX SoC apparently does not expose a bridge device and having
> >> it appear on PCI bus confuses an AmigaOS file system driver that uses
> >> this to detect which machine it is running on. Since values written
> >> here by firmware are never read, just ignore these writes and drop the
> >> bridge device.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >> This is only used by sam460ex and this fixes an issue with AmigaOS on
> >> this machine so I'd like this to be merged for 9.0 please.
> >
> > Is it a regression? Does it have a fixes: or resolves: tag?
> >
> > Unless we broke it in this cycle, I would be inclined to wait,
> > and we can ask to put it in stable.
>
> It's not something that broke in this cycle but since this does not affec=
t=20
> anything else than sam460ex I think it's OK to change this for 9.0. The=
=20
> changes to 440 tlb in this cycle made sam460ex more useful to run AmigaOS=
=20
> and this fixes the file system driver on it so it would make 9.0 really=
=20
> usable. Otherwise people would have to wait longer until August or instal=
l=20
> a stable update. Since this has low chance to break anything (tested with=
=20
> AmogaOS and Linux and MorphOS does not boot due to do_io changes anyway) =
I=20
> don't think we have to wait with this.

Hey, travelling / at a conference / on vacation for the next couple of
weeks.

It's just a bit late for hard freeze IMO, since we didn't break it
before the prior release or a bad security / crash bug. Will put it in
9.1.

Thanks,
Nick

