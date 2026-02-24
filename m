Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EABF4BB69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwm5-00016L-91; Tue, 24 Feb 2026 13:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwm3-000167-DS
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:04:43 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwm1-0000Ie-Bp
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:04:43 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso130488d50.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 10:04:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771956279; cv=none;
 d=google.com; s=arc-20240605;
 b=Ex5gD6fcQ03O9DVIn3IUdG/V806k9SNIhAVCNktVQLk5SAxoNjdk7uWMaDqDYiDbbA
 M5iqPC3RiwBkAU4/Veo4dyxt0i0t0SD7hAgdVqRHNEWJrJPOjHcqIRQ+DABuhNshEzqj
 eKq5QGeDO18hsUWpIAHUO3RnTHTx6vpGK4ox8zzCvk8Zj9MhqsnxMPQayq7pmB7SBaCB
 NVZ0ImwF3wURv8vKnle/aciuUeHbDVv88wj25FHEZ7J455GIs0gaJXksJERddp0unL0P
 Wj6tz9vuN3JHZH7iOJNdsllI4Se1rHgQANQQp/zfuYBcpMF8Z07kfesvTY0byXprFaPA
 NRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/eXpd57p2WVqdl06PWzZ8hcTo0aJxd3cl6aP3H4i4ec=;
 fh=pnVtUnc9y5Dp6OPTtJ1NjGvnTeA/6q5p07DvU6tQjN4=;
 b=ANDhXwDzaJpu3mekkIvJ0xz5Ax2RoHzsPHqB4zo9WSJoxTOKDk2t3bb3E9IIM6XZeN
 +7x/j9eqHDGxnUEmepdxGC+346FtnrnlDSZOLfmP2aN4htj62RgV/4pd1OIqji+jpWCP
 F4UAk44Ml1iLazyvXvxNGYn6973yUwaAOGTwDkV0Fs8uug5ro0Hw9FgS6aaTmjgBym8B
 CVcEefyUL8AP1DS61EXsZ62MnXFo3NFoJlKXfSmnGJtVdHE6AC7w0ZeghjStSCg4B6g8
 mv8mkh8ekJgebB3wZmkyhg6tYffGPIfZgxhCt284NM/itYo9aUUxyuDsQHJFgVrBZvD9
 pTEw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771956279; x=1772561079; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/eXpd57p2WVqdl06PWzZ8hcTo0aJxd3cl6aP3H4i4ec=;
 b=hI7JYqoqfKrSVRjUBbqzWlvg3QMD9/cthI2NTLDh+gZYt/U0/sBMk/3PJpUyswhZUi
 BC27McB5R4vCasZTWlhJVObmebae2pIrEnqJPNQ5zbZG45RHJZcS/5h7B1V7hT/ALGdy
 fA187RSfJ5KB81m5rUde0yzMj+73h5jdwTNYTIdeB8QVVbem0M6MDeVA7MformFUCcuZ
 1lnpy8syslTtSReJfiUCyjQMaPdcITAV7Y5rmwZOupATGY5dbdGm+7OvcT9z15HNFdGe
 BSBH82+UHlvuckqY350imdcR7LJv6890kwUCJjPPxBZOxdp6WRZ5A7uU9vlU4r2OBO/W
 oL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771956279; x=1772561079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/eXpd57p2WVqdl06PWzZ8hcTo0aJxd3cl6aP3H4i4ec=;
 b=GiyjX+gnhIY81BRxLNoxXHXaqLgv2VBk/k3Ce2+NOboBrZ+8G2du+vMS4EupV2/9KV
 I9mgPUTcls39gqQ39YEvALQifgJkOOOz5uRgy7Jv9+36fZ9AUka3wBsf/BwAW3b1xiZh
 t2T9n9BAW1Zt5JuG4NVdNnycpTiP2VKrKmD1/lYTouDUIBbQ7GANLFFoioLDTLEQy+yz
 +QfRJgs9BYqegEagvu5VyWPbn/DokBECFYSSEw+OSzDqPrJuThWsbGowZOZU3NDe1nTb
 4/gkmhePiYm7EjlW9yHPzuyimPOY+wU9iI70ShwMY3GkOeis4nST/1oVjnmuFW+BNx9q
 qPkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNtj5IR0XIzjwFFUF2afAkAQPKdznCtlk2YlkaGc65zDjcqqT/17OXXYqCIXmPLEcrgVelTWGXj4aA@nongnu.org
X-Gm-Message-State: AOJu0Yzpsu8H2OGtyju79wU+fFhiLc83ur5o+tD48ZI9gBbj8gXfv2VV
 PjuWO0gXRwUkmuvNN1skIVpIT+CT975hyHFuyRTa4/eJn3B7nuCu6rEsNzJ7vLyEneqBvNW0Qc7
 Bx3xjV9lUXCX8hLalfRexlJBRVP4iXgmQEOJvHQ79UVIgIpaFRtxJ
X-Gm-Gg: ATEYQzwyrY4Pb0SqawAhXVzdCa8JyMYS2FkqNbJwVGMVW5zN8+pZXJvKn6VRru57IlV
 cK67tc5301ouf3j+9RSzhFvXIPbt1TePTjq0VbV1gXJLzQfoHEl3DgthJ1cjsQuIjXYn5adZIyp
 fIhS/GEQ/zr5lyCK5HGMmFZsrp/JfiJZ08eLbVOz6axoyuD+MYrmB4N3ZUk8PJjhoVEBfhTC6n+
 F17zloz3YK9HMcSG/L04jsbvDL0j9p6sTGjsPbPzHH3YmQ/4OO074sjS/Viy1aizYtVZDgcrJQx
 TUtCo0Ea27dthG1jiQrkRugiO5RC69pt3XSS9eArotWvujQYlTZ93KsaJ+YWebOt4eA=
X-Received: by 2002:a53:cc86:0:b0:64a:d716:c8e7 with SMTP id
 956f58d0204a3-64ca60f5065mr676998d50.11.1771956278999; Tue, 24 Feb 2026
 10:04:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770253186.git.balaton@eik.bme.hu>
 <aZ3CQw2ad5cVc-Mm@x1.local>
 <c8a789fa-8d16-709d-eb3f-8acd6c1d08e8@eik.bme.hu>
In-Reply-To: <c8a789fa-8d16-709d-eb3f-8acd6c1d08e8@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 18:04:27 +0000
X-Gm-Features: AaiRm531SPStHvredx4zNtg0CZJR6rBnLQGDNSA1cdHmNw913t3Zcx9SEQWEFhY
Message-ID: <CAFEAcA_cCVabQvWkWXOnnEkcaZiNPzUsHQp+BCXiHPHwrdGeAA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] memory: Remove most _nomigrate variants
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 24 Feb 2026 at 17:45, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Tue, 24 Feb 2026, Peter Xu wrote:
> > On Thu, Feb 05, 2026 at 02:13:18AM +0100, BALATON Zoltan wrote:
> >> v4:
> >> - separate patch converting Sun machines from memory_region_init_ram_nomigrate
> >> - split helper to init ram into two functions: setup and error_propagate
> >> - also use memory_region_init_io in memory_region_init_ram_device_ptr
> >>
> >> v3:
> >> - rebased on master after some patches were merged
> >> - drop some more line from memory-region-housekeeping.cocci
> >> - added comment to explain what factored out helper does
> >> - some more clean ups included
> >>
> >> BALATON Zoltan (8):
> >>   hw/display/{cg3,tcx}: Do not use memory_region_init_rom_nomigrate()
> >>   memory: Remove memory_region_init_rom_nomigrate()
> >>   sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
> >>   memory: Remove memory_region_init_ram_nomigrate()
> >
> > Could you help explain why we need to remove the above two small helpers?
>
> Ideally we should remove all of the nomigrate variants as there are only
> about 3 uses left, everything else is already moved to the init_{ram,rom}
> variants that register the memory region for migration. The is probably
> one legitimate use that is served by memory_region_init_flags_nomigrate
> and other 3 uses are the xtfpga which I think is just old code and does
> not support migration so it will be converted in the second series to
> memory_region_new as the maintainers did not say anyting to that so far.
> Then there's one in hw/display/vga but that's gated behind a compatibility
> switch that's only set in 2.12 (global-vmstate=true) and earlier. This is
> not active any more but cannot yet be removed as there are eariler compat
> props still need cleaning up but the last visible machine version is 5.1
> now so this is long deprecated and not used. And there are these Sun
> machines that I've converted in the first version but Mark said he'd like
> to keep the current behaviour until it's the last user left. See:
> https://patchew.org/QEMU/cover.1769703287.git.balaton@eik.bme.hu/b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu/
>
> > Not saying that we can't remove them, but I don't yet see the point of
> > open-code those readonly=true setup either, or any problem with having the
> > smaller helpers when ram_flags=0.  Small helpers sometimes help readability.
> >
> > Some of them are going backwards againist what the cocci scripts were
> > suggesting previously, like:
> >
> > - memory_region_init_ram_nomigrate(E1, E2, E3, E4, E5);
> > + memory_region_init_rom_nomigrate(E1, E2, E3, E4, E5);
> >  ... WHEN != E1
> > - memory_region_set_readonly(E1, true);
> >
> > So you suggest open-code instead.  Why?
>
> This is temporary until the usage in vga is gone with hw_compat_2_12 then
> the Sun machines will be the last users so they can also be converted to
> init_{ram,rom} (unless Mark changes his mind and agrees changing these
> now as was in the first version).

I think we should take the migration-compat break in the Sun machines
for the sake of cleaning up those callsites now. Sun isn't quite the
last thing standing using these functions, but it almost is, and as
you say the xtfpga can go too.

-- PMM

