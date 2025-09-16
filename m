Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B872DCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 12:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyUaU-0001AK-E2; Tue, 16 Sep 2025 08:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyUZs-000153-DC
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:14:34 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyUZh-0007Op-0m
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:14:31 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71d6051afbfso39312127b3.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 05:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758024857; x=1758629657; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LELe6qQMAHuq0j6jtIzkdLrh9Q0SC541GX9GxbkCA7U=;
 b=tIMWtRgbWtIY+pUVB8hrnT4F0xEtykahspptbfiqkLZ6oFg3GrUEzJFk5dYw+plxs8
 9AHnvsXuEGSA6qNNfWRwJ0XW3uE4qodYyWBdBvWYC4hYI8H3sIqvONhdsOnJ0WQ5MuJz
 KzlVoBRYeCbn5IA5Xzwh1kkrCb2z4DL8yg1AWm/o06MMQgpc6HfvJIdAgomOcInGvMmB
 M8xn4XDITUSlWUPfvwQlVnQrBBETGOKYASLJUYiXaeapHpZF/ZKUgRzcy9RqV+AqVZWO
 5T/ztQDnIVAJpqGAwmE7wcpkc/CHWPwa1elbEOB26wHoruVx7qFh3dQK/05TMaT0UsT9
 xaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758024857; x=1758629657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LELe6qQMAHuq0j6jtIzkdLrh9Q0SC541GX9GxbkCA7U=;
 b=HMyobUqRgGarCwa0eS7gGu5z7GeFwxpvM0ejqQiLj8wHzuAcFuZab2c7n+h6710otF
 ehxthIqO46pF2sNaSDNrQZeZk7bjLjBzSyNwvev12byDFVjBUmjlY5DBvERLljrev6Tf
 lNrs3MotdaPQHokYCSq/RR9GLmPG2Tkoliqq1ht/oD8MUlEoosIoRcb7jMCCFBBz3Rkg
 jafV6uWYlUbLSV5HmSf4b2up/X0T9/c62xD5KJMdvx1NboXLV/rXW+wwkhIBYetBYwS8
 qr4l8maciudEN6fcXrRy2j2dfUfSBKWexzHSzOCDbtYFvLgqSIIlwMJyEUTNG4IwseZ8
 D+LA==
X-Gm-Message-State: AOJu0YyrfLoQez3pPxv+YavZLvMAyfazZNxb+HP8Pwr0CV8A9hs2dATW
 C7PrccvEYEUgb9H3s0gb7WLjYGkjJewXVGWNREu2GHaLH17xI0cERyzl7txeCqwSjubZPd/ACue
 OK8A0GDWNa+sD8cCnBXVa/0PioHKwkgsnwVXNDKI8vQ==
X-Gm-Gg: ASbGncv3Lzg6wlpgTnz9eAnD3XufpIfOCePv3as/7poG1PFJQYYlYCPjiuNdaAj+rWp
 I3J8y9d0nkne4T+KRP3vHp04A7IPFBY4tbWh1Vv43t1eroVYgzkaDcFkXSevSCs4G4ufqnzawHk
 UoKF7mFos75ACiYn+UUwO83/AnO/HOVCghfYzpEnaoIL693KJV+Ic9TZow5ZvhR7alKLx5Qi6p7
 7V7/uwl
X-Google-Smtp-Source: AGHT+IEQ5K74msA7ZRCaGSOqGN46hhRbBnFPhEghBuW9KnI4k7MrHwrVjFeg4Gw5W2Sp33HhKQuhE6/XhN90Q/7oG1s=
X-Received: by 2002:a05:690c:6701:b0:727:501e:9a4d with SMTP id
 00721157ae682-7306481b292mr147146397b3.33.1758024857349; Tue, 16 Sep 2025
 05:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Sep 2025 13:14:06 +0100
X-Gm-Features: Ac12FXywPgs7fs5mUJFGqdFjRw4Ju6XI0_Q0xgNA9qX-nP8_oO_aidYSTbpOIrA
Message-ID: <CAFEAcA9Any7XcejhUsCQDkseV8J0JQYq1YMDrM_eL7uJmDwcjg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/61] target/arm: Implement FEAT_SYSREG128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 27 Aug 2025 at 02:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Requesting feedback on the implementation of 128-bit registers.
>
> Note that there ought to be no functional change with all of this,
> because 128-bit sysregs are not hereing enabled.  Despite all of the
> different FEAT_* names, it's all indivisible from FEAT_D128.
>
> I've used Int128 throughout, which seems sensible at first glance,
> but *really* complicates the definition of the registers within
> ARMCPU, especially when the low part is aliased with AArch32.
> The only saving grace is that there are so few 128-bit registers.
>
> Gettng there isn't trivial either.  I wasn't happy with the idea
> of replicating the orig_{read,write,access} set of hooks used by
> VHE, so I've rewritten that to perform the VHE redirection at
> translation time, much like how we do for NV2.
>
> In the process of rewriting VHE, re-organize registration to
> simplify memory management and reduce the number of arguments
> to the inner helper functions.
>
> At one point in development, I did not have CP_REG_AA64_128BIT_MASK,
> which was going to require cpreg_to_kvm_id to also take a
> ARMCPRegInfo pointer.  There aren't a whole lot of calls to that
> helper, but the one in hvf required reorganization to handle.
> With CP_REG_AA64_128BIT_MASK, that reorganization is not required,
> but I still think it's a good cleanup so I have kept it.
>
> Alternate implementation strategies:
>
>   (1) Disconnect the 64-bit halves of the sysregs.
>       Cons:
>         - The 128-bit-ness isn't screamingly obvious.
>       Pros:
>         - Avoid having to rearrange the ARMCPU layout, and simpler
>           integration with AArch32.
>         - Avoid Int128 most places, since we wind up doing quite a
>           lot of packing and unpacking the structure.
>         - Because Int128 *isn't* a structure for most 64-bit builds,
>           we can accidentally assign a 64-bit local to a 128-bit field.
>         - Possibly easier migration changes; I havn't thought about
>           that too much.

I haven't looked at the patchset in very close detail, but
(as we discussed at KVM Forum) my inclination is to prefer
to have explicitly separate halves rather than an Int128.
If we had a real compiler type int128_t everywhere I think
my opinion would be different, but as it is we can't write
operations on the field in an "obvious" way, and we have to
have clunky int128_* functions like this one:

+        flush_if_asid_change(env, int128_getlo(raw_read128(env, ri)),
+                             int128_getlo(value),
+                             ARMMMUIdxBit_E20_2 |
+                             ARMMMUIdxBit_E20_2_PAN |
+                             ARMMMUIdxBit_E20_0);

so there doesn't seem like a great deal of benefit to
defining an Int128 field.

Is some of the early part of this patchset useful refactoring
that we could get upstream already?

thanks
-- PMM

