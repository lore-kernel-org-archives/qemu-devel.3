Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C31C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQoL-0000Qw-B6; Fri, 07 Feb 2025 11:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tgQo7-0000Nt-0H
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:02:24 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tgQo4-0007Cg-Vt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:02:18 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38dcc6bfbccso403228f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 08:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738944135; x=1739548935; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ihNlawI4mCyWONJEzR+1GSzo+oI1gh6OJ485QUuU/o0=;
 b=NUdkZQVVbbVeg60avPIG0Q91kahPSlUcFjcMFvAVb3vvgVxgCxRMWnYUtAGobJ6WIh
 2s0aARCEzoiRr5UrH2+KKYrDxttiAFHRo7R9GiFC7Qm2xyb2XX9EBOvBR78Wyji/v19K
 UH47fDR69gsE1FThSwG/5xVU4UUgmR7bmvufgmtWglsiiSRQjAVdfy0j3sVC2Ppr5rgu
 gYbjXGf/EFQkCxm0xpsrF2Pt5lLwzQsW6dd9p6X+LWJcHNwnwoOrKuw5Lj9UdXcnoCLM
 EZ38+k6nNLp09l5Jb9/IdY+uUubUcHYiuhazpG4UDfjoahLZEDzOD82L2JwvAeIMmfw2
 ypXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738944135; x=1739548935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihNlawI4mCyWONJEzR+1GSzo+oI1gh6OJ485QUuU/o0=;
 b=GYbRS5IavTd+THZwKsIsZpSBbccgzDORjH2LF9YIzMyEcENzpdg9wxz87etD1bwPBW
 JQPLss0ow/r3Q7hGDh34XYnrlpiaozDLBc6FybB+K5X/HQp2aZsTnw+pJMxpsMTs8bvE
 I0Y1eLyFRaUQNor5c1xhBVqpGafDlGvFFT/Q8I+m/50+7iVZvbADV12NUSURqLYTHj8d
 rmNG91IlMQQ8f8YPab+o6HfxLRx+ZwWEjiqj7Ztk/waUpM0z7a7D9EMx3k0dPplyRldx
 vGPerAeYX3jWKQnG8DKFEUubsB43Tqw/fJFopoj4OuO1TrVYXTNtV4gLiqoTv6FZgFQd
 rNXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWq3yuLhlUvYkp9MGFbRinkgNtYeq4yKLCpUfKRoGih+TL5b8doEU09jAPtcNsTPbRMeejItSOySSy@nongnu.org
X-Gm-Message-State: AOJu0YypvJ+jjqy9tqBg+fcrP/cG2hr60C8yqJdNTNhfoVowxKxYxUpY
 e+/kcHc+Fz1zQvnOuD7XASw2bYA/n66QhxHNG6YyVSYIyGlW6fkVLEalNehkBblF+P2W+cHP5sX
 pCtQ=
X-Gm-Gg: ASbGncuEQYUrkfuPcddXBBsivDG3KwyrPJ6CDtzL486fRMORsphxJlZpXSgnB/10T0d
 d3o4u7+4ztMjoVsNSfBCqgYr4FRKw+80Z3SBYD8Doo03X/Qz13KMuiUWiEyWhgc4S3sC5YFZe2T
 A7ZFC1L+cJBi4c4Ijj13NCls8LuUHF0q5Yr5NelWzaZcuzlrPWvlTS18aXPVrCuGmPbd7iFL5Zw
 IhMPO2bs+ArV6wa2E1afPSAeUZgno21SOmXawarutMifDBPch8oT8/5JFZGNXB9JxPwK9sTln+D
 Dr5I+2paZE6gug==
X-Google-Smtp-Source: AGHT+IFX9WvhugUJsutcR8mfxc4odbBaP7XrnuVWdvintjlRw7EEsftPfsKjc8xNC5EL2MidatfM4g==
X-Received: by 2002:a5d:5984:0:b0:38b:ef22:d8c3 with SMTP id
 ffacd0b85a97d-38dc934bcd9mr2613660f8f.35.1738944134537; 
 Fri, 07 Feb 2025 08:02:14 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd36776sm4941161f8f.32.2025.02.07.08.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 08:02:14 -0800 (PST)
Date: Fri, 7 Feb 2025 16:02:38 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v3 18/26] hw/arm/boot: Mark all guest memory as RIPAS_RAM.
Message-ID: <20250207160238.GE3546768@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-20-jean-philippe@linaro.org>
 <e8075a46-8810-4be2-8ad0-b465268541b8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8075a46-8810-4be2-8ad0-b465268541b8@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 04, 2025 at 05:27:17PM +1000, Gavin Shan wrote:
> On 11/26/24 5:56 AM, Jean-Philippe Brucker wrote:
> > All Realm IPA states are by default RIPAS_EMPTY, and accessing them in
> > that state causes injection of synchronous exception. Either the loader
> > or the guest needs to set IPA state to RIPAS_RAM before accessing it.
> > Since a Linux guest needs all memory ready at boot [1], initialize it
> > here.
> > 
> > [1] https://docs.kernel.org/arch/arm64/booting.html
> >      https://lore.kernel.org/all/20241004144307.66199-12-steven.price@arm.com/
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > v2->v3: New: the Linux guest does not initialize RIPAS itself anymore,
> > and expects the loader to do it.
> > ---
> >   hw/arm/boot.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> 
> I think the changes in this patch can be combined to the following one,
> or move this after it. It logically to initialize guest's RAM covered
> by PATCH[9]. I'm not sure if there is particular reasonable why we
> don't do that.

If I understand correctly you mean I should merge patches
9 and 18, or at least bring them closer together in the series?

I'd like to keep the hw/arm and target/arm changes in separate patches,
because it's a nice way to have smaller patches and gives a clean commit
message. But I could interleave the hw/arm and target/arm changes within
the series (where it makes sense like here), it may be easier to review

For now I pushed the reworked series to branch cca/latest
https://git.codelinaro.org/linaro/dcap/qemu/-/tree/cca/latest

Thanks,
Jean

> 
> PATCH[09/26] target/arm/kvm-rme: Initialize Realm memory

