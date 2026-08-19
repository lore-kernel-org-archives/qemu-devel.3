Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EB6C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwj8A-0003C3-D2; Wed, 19 Aug 2026 12:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wwj89-0003Bv-3A
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 12:27:09 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wwj87-0004F3-Cc
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 12:27:08 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5aeb8c19017so2006563e87.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 09:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787156824; cv=none;
 d=google.com; s=arc-20260327;
 b=UPfPLmBcYjkpie3E8/cMmF2/Lbe0VNn07zkh8v7gClB7o3jzK4AQ/rB7n4T2fQjasp
 AHXq/zqwPSAU3fRbAJlnIwN/V4b0StzoaKNYf2jx/wL1BxZZi+xx4/RIddhhOaBgsEzo
 5S+cllMYQs6ug0JguO0Xw7alAaO6fkSofZu93VpYww1b0l6Iaf9A8XGLdLYdOo8e3Oxh
 npb4hJ4FJty2YQS/mNOXeVmpHrEjf+UY716/4c6ZYGAsTRap0cgJxJAjBvbBSLJuWGPs
 H4nhMRALzBY4lHyqNhr6VL4EtN3TutXoNi15qIFM/8Y9vBhHNucSue090tEZ5M4vfDyg
 9geQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NR6g5XbCXhMZRfBHkrrw8dvtsqvi5svbOMHiIWfTj3Y=;
 fh=YYFlP8b5nG0xp43ekYQGYSQr9uembBeNxJ16OtaRW/0=;
 b=CWDIvmzpQklOnQmHS20LfEBryWJjgNnfGMjZvGYj6062ujU0UAastZEZSfJ4mrhmDr
 YJvN5A5s1c8K2f9C726NSzHAk00go9Szh5VGap7/hwHdzoCEzv4Devjra9PVCTy6axaG
 IFp6XXgsrt1o+HVfvK1Bd2mh7zQLdyq4lNmQnyE9FgEh95Hp6/Hw0/V6/6FN22zzgown
 YUKD4TYHRtkMez6xLpw0BAFXLMmGAbcTMsAwY2Bz1ixivDjdvMKS4YmU43fIE7Cef9TN
 Ii+aRuHSRIea19TMpIqY902nqHuHyBOIP5Ho2l4gB/zptCOhQRduW2PYxC6QylkP/W0U
 ur/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787156824; x=1787761624; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NR6g5XbCXhMZRfBHkrrw8dvtsqvi5svbOMHiIWfTj3Y=;
 b=q+luigDS+5M97pU+Vu08Ka2EOt1P68+frh0h5vgeWEIlLH4hjrxUS28IjNRf6ssjJ/
 h6tCNJJ0pIJ3z/0k0BctNw4ji1BGkKIem0lt3TaL7iOg9u4bmAmS2c0FoWr2CnKcsP3m
 5iVNhfg7Yzq2c48q16NeqXk2UUZLNk8XMYkZzw+4X0sWW3XNP7SJSDes6PnKdytBxvvY
 zlVHNo49fAWgEFWZl7Gfs3vhbgRYUGAMB37h6OGxVVYxWjfGLiszdo6/YJcXpFNQEQLI
 71FHFrsYZnvO/gvZG7IDrynuhCjhOIrtM7qjSZVR4Xnh9ApRQ5MLrkWVtSCFc+dCpY44
 qumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787156824; x=1787761624;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NR6g5XbCXhMZRfBHkrrw8dvtsqvi5svbOMHiIWfTj3Y=;
 b=lCEkl0Xr070j/f/SQu2aee+BR4Q4E6EFiu7iJ7ywXIkAL029EWiOzTIny5f/DYR6lL
 S54/y2wmJoTAe1iRNtj5gr2PW9cUAVtvnnoVf//PHzKr19AZpglGxKtFWfL6T2JIUlA4
 uI1WHhtAWnikU6huF/NqkE/2SHux5FbirL7ddDcZTV3GMGRH8suwP2BxzMMv7EtVp5JP
 ugR1Pw0Js2LI/eGTPTJC5DY37gaaTmVPbILqw7EipsYbfuTZq1nROIqYd35GzGLGGR+S
 flqcBKOz3LoSIrpWBChAaUT0TxqhxLe0HVZ15nI9JZiWPmRQ6m4z0zGcZnYIxDgbUs/M
 MKEA==
X-Gm-Message-State: AOJu0YzPID3gjUNeTQSE4CL5RU4uQx6fjdgghYrv/b5gv+83h9yHueHU
 DYtF47Nov3Nsvipawk5eWbenfAkAVCmEuyw6XeVc54a/YrBhyMBacZSBpO4ddsx0UNoETELXiv3
 gJWVkUsBnejydLizysYbha80ohNo9fEg=
X-Gm-Gg: AR+sD103fTsSeOfZ80rlI3isATCiAWLYOsf7MH0n2N0Fk7sZmss1/eB7wIspH2wEVY9
 Z0YSprwzq2jTepwgb/JHscOfrPXoOmvUe709XLqo70VyatRhj0Ekdf27qXNqY2shbZG74kcIAGC
 arGvx6Stpc/nzMQF7hsTgmSOFiIjw0eZFdfcs7CrNfodKLg8/Juq7YgnshX3sbg324hwlk8jSbR
 FQxhQa7qOBhXJ+oKJeNJdNAOpH3TxQHnLeG/1iMDZ58O0nlrUCZB88uwtePQHjyBL6Spfy/GR/B
 jEgH6loh5SsC4mI1LH7hpl7WAaytfYWL31Ejqlin3c65GrmQMuUqbSQFc86cGXpRXAnTqhlah35
 0
X-Received: by 2002:a05:6512:1324:b0:5b0:1eed:f707 with SMTP id
 2adb3069b0e04-5b478be4749mr1821328e87.23.1787156824296; Wed, 19 Aug 2026
 09:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260816174631.1547811-1-aadeshveer07@gmail.com>
 <aoSaRoZoke2WjSRX@x1.local>
In-Reply-To: <aoSaRoZoke2WjSRX@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Wed, 19 Aug 2026 21:56:51 +0530
X-Gm-Features: AcwNN1U4UELScybs0KrUg9CIL29BRY8JLSFMYWomP-OCFlwPO4ejX26dkQdS3HU
Message-ID: <CA++cPvLWC4=+_BUOZD_XOTzB8pnoizZOx5VyjeWncRo=ppLHPQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] migration: fast snapshot load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com, 
 pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lf1-x131.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter,

Noted, on documenting the external discussions and including them in
future cover letters and commit messages.

REgarding the guest psize > host psize code cleanup, I'd be happy to
send a small follow-up on top of current patches reverting the checks
and simplifying the pending_bmap logic

Thank you, really excited to see the series queued for 11.2. I can't
thank you enough for your guidance, patience, and mentorship
throughout the summer.

On Tue, Aug 18, 2026 at 11:15=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> Hey, Aadeshveer,
>
> On Sun, Aug 16, 2026 at 11:16:20PM +0530, Aadeshveer Singh wrote:
> > v4 -> v5
> > - Modify pending_bmap(Patch 6) to use variable size for better
> >   efficient atomic state management
> > - Added a comment(Patch 7) explaining postcopy_mapped_ram_load_page
> >   explaining why cases where guest page is larger than host page are
> >   disabled following what remote postcopy follows
> > - Add a new check(Patch 9) in migrate_prepare to bail out if migrate
> >   was used with fast snapshot load enabled, as suggested by Peter
>
> There're something you didn't mention but we discussed it only during the
> meeting about host/guest psize problem.  For this time, I'll do it for yo=
u.
> Aadeshveer, please remember to mention such conclusions and findings in t=
he
> future when you will be working on other patches.
>
> The quick summary: Aadeshveer found postcopy doesn't support guest psize =
>
> host psize since the start, which will already fail the set capabilities =
in
> postcopy_ram_supported_by_host().  It means we can also skip supporting
> that in fast snapshot load.
>
> Personally, I still prefer removal of all such guest psize > host psize
> handlings in your current code; postcopy_place_page() isn't ready, so the
> current code won't work anyway for that setup.  With it removed, then we
> can stick pending_bmap with host psize, which can also cause less confusi=
on
> and make it easier to read.  But I think it's not a huge deal, and AFAIU
> the code works as expected.  So I think it's fine for now.
>
> If you're going to prepare a small series on top of this, please consider
> reverting those changes back to the simple version with one patch on top.
>
> Other than that, thanks for your hard work in the past few months!  Since=
 I
> believe this code still should function all well, I queued it for 11.2.
>
> --
> Peter Xu
>

