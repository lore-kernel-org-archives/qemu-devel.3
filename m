Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10588C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2eM-00077r-M0; Wed, 17 Jul 2024 07:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sU2e9-00063z-I4
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:16:36 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sU2e6-0004RJ-PR
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:16:33 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-810177d1760so410339241.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 04:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1721214989; x=1721819789;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FfUWHKWL6TaVEhUts6Kr5b/CvgFJnQYLsQV/A+VemvU=;
 b=F+cR9VjjIbM+pO5McmL+b/paWrLmVc223y5hrcvDY2WjjXAMC5Gp1/Fq/PTpGJIqSj
 xE5KxyEkZ+LqbxkPifcoUSOUluOta03v+uP6w9TOV6Dy8BGU+IDgphb7s3qAiglEqPTI
 ESojFgFZYKg1BKNQzxDKjg+AK3C9LGXPjGxSNieAENR+ppGacCz+wve7C3PvSP1WVMaz
 prRQ05ETmUdnd1VnKYVeegp4Dn+DmgUJ1UlHjRAOxSIfMBhM0UPWyNoV1VQVNvyxKbl4
 VBp1b77krQbzkL9lDtABgys3e0JWPgWzno0sLHhm4/h0JrO0WfHisbENjvGcN0AmYycN
 jKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721214989; x=1721819789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FfUWHKWL6TaVEhUts6Kr5b/CvgFJnQYLsQV/A+VemvU=;
 b=cr2NvSztPg03BybmXLjUP4OdLmgwoKdhlWvzjD4FrtHHG+YiKPsxjUEzRJ1CWXVLiA
 pjqUc569EoSRP1M6R03LJ4xFgdlPEz7F8ggjWo4xkk1j2ov2q0ZvLe8G9EWkz6daN+dg
 qgX0J4lh2cs+jTqupSGW/CiIFsXaRdnV1Cqvht9/cYbQWp5/gPEy1/dPukSf5EMG/piS
 GtGBASzIp3xyDD/Zam1L4wkrPoBavXQVEoA5I0IboneDZVouAVNvUe53GM8IaGijcfib
 e3li4mxP0EX2oEIVghych6R+rAyi+7YD5/O2XZX6s6kXexiFi5aZXGqSyluWbWm3T881
 prmQ==
X-Gm-Message-State: AOJu0Yyg4QiQw/0bwvAdaN+g+L/zG0m3ABdiF45QS627scE6ze2INlV2
 XHuDrZKL+p8CekaPgIsB9O9kQP0JXi5ivFs0RR3ABf4UlxZG2JOvJrdyGtq8RZAlLI0ZmI2Mk6q
 JxbPD95cRY2XvS22cxM/+xamFQ3CqG4fvYtD6
X-Google-Smtp-Source: AGHT+IFPvZWG7t+3hi9b5Gr8n6zMJbXbQNQoQdDGWH6nnjd3b0WhmyEE5BiJ9Z+07SJNe2EbGhxD0FAsbMLOoJfuX3Q=
X-Received: by 2002:a05:6102:2c8b:b0:48f:3e7d:7f74 with SMTP id
 ada2fe7eead31-4915990e50bmr1813118137.20.1721214989546; Wed, 17 Jul 2024
 04:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240715210705.32365-1-phil@philjordan.eu>
 <eca02ec3-e2f2-4994-baf5-b86908fa0418@daynix.com>
In-Reply-To: <eca02ec3-e2f2-4994-baf5-b86908fa0418@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 17 Jul 2024 13:16:18 +0200
Message-ID: <CAAibmn2h_L=i5GetsEr0jRQXs3ifY5DGwZf7vs1JDwQMkK1TSg@mail.gmail.com>
Subject: Re:
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de, 
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com, 
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org, 
 lists@philjordan.eu
Content-Type: multipart/alternative; boundary="00000000000008d16d061d6f98fc"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::932;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x932.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--00000000000008d16d061d6f98fc
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 08:07, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> Hi,
>
> Thanks for continuing his effort.
>
> Please submit a patch series that includes his patches. Please also
> merge fixes for his patches into them. This saves the effort to review
> the obsolete code and keeps git bisect working.
>
>
Sorry about that - it looks like (a) my edits to the cover letter messed
something up and (b) patch 1 got email-filtered somewhere along the way for
having the "wrong" From: address. I've submitted v2 with most patches
squashed into patch 1, whose authorship I've also changed to myself (with
Co-authored-by tag for the original code) so hopefully this time around it
shows up OK.

Thanks,
Phil

--00000000000008d16d061d6f98fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Tue, 16 Jul 2024 at 08:07, Akihiko Odaki &lt;<a href=3D"mailt=
o:akihiko.odaki@daynix.com">akihiko.odaki@daynix.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
Hi,<br>
<br>
Thanks for continuing his effort.<br>
<br>
Please submit a patch series that includes his patches. Please also <br>
merge fixes for his patches into them. This saves the effort to review <br>
the obsolete code and keeps git bisect working.<br>
<br></blockquote><div><br></div><div>Sorry about that - it looks like (a) m=
y edits to the cover letter messed something up and (b) patch 1 got email-f=
iltered somewhere along the way for having the &quot;wrong&quot; From: addr=
ess. I&#39;ve submitted v2 with most patches squashed into patch 1, whose a=
uthorship I&#39;ve also changed to myself (with Co-authored-by tag for the =
original code) so hopefully this time around it shows up OK.</div><div><br>=
</div><div>Thanks,</div><div>Phil</div><div><br></div></div></div>

--00000000000008d16d061d6f98fc--

