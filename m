Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596D2F33A88
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 15:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyAfL-0000Km-02; Thu, 05 Mar 2026 10:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyAfF-0000EW-5j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 10:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyAf7-0004o8-QI
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 10:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772724650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hMePGZTKaNPJXM+gyatCsckDJaQBV44yYmRRO91jrxc=;
 b=akC+7AfG/Fg98ps07F1q2E9WAtM4XAF11nYyIhAY6sKI03pg5mphIzRrrxEmO031YQNrEy
 uoUqNCW9JCU/Peb+hIY4SddI2V/FzLgrlX5OZ4O0XZIYPZbTwxkemdoM6XKR9uPk++Uixg
 imx9ywjTpk0sNe23wgUSR2z0h5526dA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-nOO2Lsx5MzWtRLO8oYdVig-1; Thu, 05 Mar 2026 10:30:48 -0500
X-MC-Unique: nOO2Lsx5MzWtRLO8oYdVig-1
X-Mimecast-MFC-AGG-ID: nOO2Lsx5MzWtRLO8oYdVig_1772724648
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-506a1999e44so709821491cf.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 07:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772724648; x=1773329448; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hMePGZTKaNPJXM+gyatCsckDJaQBV44yYmRRO91jrxc=;
 b=ZW4SYXv+BHTnQUbMuz3n9UicdVmw6MDAoUOIAvJwQLk32Z4/h0QzaY2/tARYw6nqXT
 mRECrx6iDTMuworuyJ3F0RACAD2pxwD5YZ/M4Ybycqzfn0/K0J11UOlu/lJbqQw1W3cn
 cknjgoGRRw2Vc8dnDcr59r8HXA60QcDCkmahqVa9v7jzHjY88jN/2Pq1yaSeGsl1nBUk
 m8iXlrmfv118/o+38lkVAymUazaoiM2d9gaiocSRHASBeV3TXxbc7iJuCmlMdp6N053d
 dDpakE8Ws7esZBbN/t9MD4xbsuRteOF3iNDZN8SfJn5ni6UFR44EfkgRWUgIfxqoFteF
 c7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772724648; x=1773329448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMePGZTKaNPJXM+gyatCsckDJaQBV44yYmRRO91jrxc=;
 b=fJoEmBtMPL9N91qjZ5/PFhkSMKqx/RRb95k7JcBBJxtQthH7mewcNxatqg98qR4/q1
 ImwIz/JolqYR0Xwhs5VxTmUldAp7fXlakVKcMGxvBXIEt2s9pmfjp6WA4TS5QCXbl9Mx
 g2PZes1mKzGuS2SLSfHIZ6StjP1mmNBhmFvg0j/oNfQS/3pZr8D9jl1upC4TOpSFYnYq
 KblRny1RgyBRIEcqJaQWVlpq0pv4GXGXe8E6X6pcuhwWxukh9v0rsJ5F1G/7U62+Z+KN
 zXLpyTewcXEu7nTCzzlIWHUPTgwWtrQkfoZx6lLT1IfSuq97o5phKsicCf3FOALk9MOM
 Culg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEFe9+9pGAOxJs4CZ2DaOCrORyGRfYi82UqYpjPsJMrp6NpHntYKy8ZAUj+04VUKJT1FTjmeBapWd+@nongnu.org
X-Gm-Message-State: AOJu0YyIRPKZvBpUwDOfcSS1A2g5xgWQGLxb+nerxAKWvz8/tiHNRWTf
 +h642KEd6+Qidez1AUI1WIgvSBIGvZrUExyZ+8MO2qm4NzEY9fTWGcxHA2tebhv3zTfakVbvq+l
 iTGrWo1vGkHfN3rribIOndFSWG3JcJlIwvPEneLLngwuDzuFyBEdqNrTM
X-Gm-Gg: ATEYQzxo5z3Sh/16lXTKuHTsgYu6zks0U0Y172qQBdslBSZXDCILQor4q1lxG4QXkMX
 z/lQkw4vvfWiJKGyjj4EUTlXsN2TkIDvha2Uv7us/aLBAc9ALH/gLj5MlSGj9DjU1MsR8w3B2y+
 NOvUTB0F5fD7U9bKvxIUlOG4I14nNranw5JoQnGJUwckKqpoXkf75AhVihXkRNVIQaGNob9CaEb
 nuZyNqVTMwJVgHGxBLsXez2BayfpVT4m//JuTIfKXASJRphUU10UGDQGYQNgeQuas1S636DtufZ
 wkuIgPF68mGHg7lEaVneJSGMNB9vjh963c8HHKBtiKwLXuyBpdRcag+MzAnDGgRtP+Z13wcT2dr
 eyq96b3egK+NENQ==
X-Received: by 2002:ac8:5a0c:0:b0:501:4b10:aa9e with SMTP id
 d75a77b69052e-508db2a632bmr80651501cf.13.1772724647460; 
 Thu, 05 Mar 2026 07:30:47 -0800 (PST)
X-Received: by 2002:ac8:5a0c:0:b0:501:4b10:aa9e with SMTP id
 d75a77b69052e-508db2a632bmr80648531cf.13.1772724645596; 
 Thu, 05 Mar 2026 07:30:45 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50744afa7d7sm181008531cf.32.2026.03.05.07.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 07:30:45 -0800 (PST)
Date: Thu, 5 Mar 2026 10:30:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 1/8] hw/display/{cg3.tcx}: Do not use
 memory_region_init_rom_nomigrate()
Message-ID: <aamhmXuvcPXPfWSJ@x1.local>
References: <cover.1772397447.git.balaton@eik.bme.hu>
 <816075b4a7fe7d4234744b7bd29c03139e4c2f38.1772397447.git.balaton@eik.bme.hu>
 <CAFEAcA9tiLag6NHMajPH=caqECRw7DT5vmtX4EraTG8Xp5re3w@mail.gmail.com>
 <97bceb8f-4cdb-461d-9553-c39b18a61063@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97bceb8f-4cdb-461d-9553-c39b18a61063@ilande.co.uk>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 05, 2026 at 11:15:59AM +0000, Mark Cave-Ayland wrote:
> On 03/03/2026 09:51, Peter Maydell wrote:
> 
> > On Sun, 1 Mar 2026 at 21:03, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > > 
> > > Use memory_region_init_rom() instead which is what other devices do.
> > > This is breaks migration but these devices are only used on sparc Sun
> > > machines which have no migration compatibility guarantee.
> > > 
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > ---
> > >   hw/display/cg3.c | 5 ++---
> > >   hw/display/tcx.c | 5 ++---
> > >   2 files changed, 4 insertions(+), 6 deletions(-)
> > 
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > 
> > I think the compat break on these machines is worth it
> > to make progress on the cleanup of these functions.
> 
> Hi Peter,

Hi, Mark,

[some pure thoughts before PeterM chimes in..]

> 
> From what I can see there is still on-going discussion on this series,
> however if the general consensus is that the removal of the last of these
> legacy functions is now imminent then I won't object if you want to merge
> this.

In this case it's not easy to reach a consensus collecting "yes"s but
"no"s, that who still prefer this ABI to be kept.

Personally, I would respect your opinion, and I queued them because from
what I read the impact seems under control, please correct me otherwise.

There's indeed the dilemma that since sparc machines are not versioned,
then it's easier to be treated as a system that may not demand the highest
level of ABI guarantees.

It's also harder to consider ABI compatibility for un-versioned machs
comparing to versioned.

It's because for other versioned machines, we have the ~6 years lifespan
nowadays for them so we can drop old things over specific period of time.
While when a machine is not versioned, it's almost impossible to mark the
time of deprecation.

We either need to choose to maintain ABI for those machines forever, or we
allow ABI break to some degree.  When a machine is not versioned, it's
harder to justify we maintain these machines' ABI even longer than
versioned machines (which we deemed to be "relatively serious" users).

So if we want to stick with that machine versioning plan, maybe we should
start version machines that we may care on ABIs.  IIUC it doesn't need to
introduce one machine type every release, however when versioned we will be
able to follow the same ~6 years obsoletion phase at least.

Thanks,

-- 
Peter Xu


