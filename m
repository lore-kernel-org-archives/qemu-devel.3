Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54240606A325
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dBYNmvGy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM46d-0004PC-OX; Wed, 28 Oct 2026 09:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xM46X-0004OI-NB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:54:15 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xM46W-0000jY-3l
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:54:13 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8a83d2706fdso8907757b3.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793195650; cv=none;
 d=google.com; s=arc-20260327;
 b=OXwQWLI9zdr9HIiIPjQGnKSkEPRp2CkjnSMw6Yfl+Q/i67eP6vmgg/4TmNhPm2guur
 zzBwMosDMM7WDZ6SFayv7Dfx8ykvYNnAwfaN317y6lBc3R3jaVzJRA4j01LksSza+Yme
 AOTF4lBbPt9DK4ja7be0HwN3lgsgVXSuDSlhaQHjMCWV9XNcnbhuLPMGE1UlDdTlUhM1
 Mhn1wZo4mwhlqNCJ54T9a1jS8u2QQ/GRTdXec9K0zzsOYfUVLDM/y/byNYbIfu786eyX
 Fxndfhj5QS3HOauQrjR1N2L0F6peY/330ixHoDxt5bfSfxxDg8r07JKionwXuRpXnrAo
 8WgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nZtHUf84Nkq5QbvcObfe1W1RTIwZk56l8DVkw+hDSRM=;
 fh=WtfYBioCERIpilaIlgQ8CdUwqaZjijWidHTN6miTi2I=;
 b=GRcbRCzsj7EXbsMXBsEBtlEQb8eyncWx9Xs/MCpAm0VnyyqWkumGEQL6v9KJ7lRobx
 Ijk8NcVKd2dLy6Y5JcvYtXnCz8BJ5JfKC57zFGqcO3/HPcIThmCs4IDf/Mb1NBH0Qq6R
 YFrwdr7NL2vLpLAwgdEcTiVtLmrur3qYvG70HH74uWJJQWkQPv13eR3F3QhbEE1fAz2F
 X7d5sGOigWi0tWUNwluTCGECfSLU38jiEm82EmO1RlLmI8tyO4CIbvPu0o2FtSNOFMiv
 WjOcDorsKSVVXyfTnRP6Yh8Kk4R18NS15k9aVU3i6l0T1PVzFuFaMCz5RVSp/zxar9tc
 F7yQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793195650; x=1793800450; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nZtHUf84Nkq5QbvcObfe1W1RTIwZk56l8DVkw+hDSRM=;
 b=dBYNmvGyqhsTK0iAU94uK2gjkOz0xZfYlg0aVJJb7nDAF5vZ4OXmcqrWS7lavilJ1G
 /UYINpcH/5Rnzd08+vjmdKnat6NPJoMh0ncto4Q1eikRl9ZQCrmXj4y80TcitSzSx/Rx
 fyZ47ecjMdLXvBtJxI6BI6kz7Npt5Qhg1yXtnxbDwQNXfpcBfdd6ONVV9wAnvIe8Tfcs
 G2OYJnIvL8OiyxRRAH5x9FPdJtzO6JC/vSTo8/p0ChgfwNSMsHLeFawuT8exWMZf9DVk
 VD4CjOL4XXZCIGNAl/pS+NVcGSrULRrj0dWMiC+0G4XWXcWLStxrmTikTFl5TNdzqEn/
 rkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793195650; x=1793800450;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nZtHUf84Nkq5QbvcObfe1W1RTIwZk56l8DVkw+hDSRM=;
 b=1Nlm8nP45SLlyGVzgdnhAkhKnC0Lb9E0WAJO77gc3glr3KKxdAoIBQOXusI0pWp+xq
 jaRxPeoj76iYylI7gTIyLksV2U4jGqo3tFuXJjZw3uDr8g48AqWU2TIYnSCJ0t+Cmxw+
 GdrSrfzfGfEk2mDxf+kQ+THl08f3kJTDfr/lLlA7zsoi9Pelh+TrpODXS3p8Nl/BfqwB
 fKKRFTL6Ct6Bo/sVvBKmZJHlS/Sg6V8ulDxLQwdlq1grSUbu5725Wd9Io4DHLbu8skce
 audVrl/xDX123DzkcZ8kzuTVgjixIwdm6NFNl/7tQ0WRiLhD+/6HnKfzTDjZhJekcLLq
 EOwQ==
X-Gm-Message-State: AFq9FYJBjkfuQh32UPyABDyvAd7Ae7o8J8noKZiSmcdO4H2uqylW/6oF
 OcD3ZrK0/kZMJtAwVKatsG31P1829cXKGoIp9bgEcBaZ1aTWzBQcHWWWOEw0SwQ3R2lFLiGnEYi
 G1X1LfFvYMK0CQz682kbeoHPdez8nNL60q9R9q8SmTw==
X-Gm-Gg: AYBFou0uT3RdXNz4wRMRKA7/qMWmvrukBKIe2t3BFsXaDMb5zU4gD3/+uWXFpYBykiy
 jqsCT6ct9q9G6wEn62C5OMWPBgD9I6XbGqOwDeGIP7GKGYLHSrKADqe4vLvRM5w2nfVtA08trEs
 +rM7ZQC9ve/tbdwjWdGWN3knSEVgxlyRAmgDoDFxUfQcVyppaLIT61wrm574gS9lDV5DlxvLrN7
 knPBDJZZd8OXIY0RcRuZQGZy1LwpB8IgcfVLK/xalE3iLlgxvqPlwUTP+/GCEUYeBdwMc/zQ+87
 ypJfk0fLJg3+HFnE5wumgSChu4kguhiIyKgDe5ejumECttWS1KN50+G61A1WtaFW37WT1bAhCYY
 0QzHBjvnPih3TJ7MU3qE/ify6S86hBkx7M8d2FSl7aywpt9GDAjzZt6d+PCIzMcVYeKtUTOCyLC
 8sltsHcNinqelqIlsaInOVXg==
X-Received: by 2002:a05:690c:660d:b0:8ab:415c:d733 with SMTP id
 00721157ae682-8b1b597f11emr15192567b3.7.1793195650124; Wed, 28 Oct 2026
 06:54:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260721131457.3062767-1-farosas@suse.de>
 <CAFEAcA9GDRQoqEXAt5-Mnm7jTPvpkZ6EPPvxiL7h_mFZOMuW6w@mail.gmail.com>
 <87ik2njjqn.fsf@suse.de>
 <CAFEAcA8vq-zFsou=A4H+XDZ-zsWKJK3-RzASs6aV_s9efFyQyw@mail.gmail.com>
 <877bj2j5lq.fsf@suse.de>
In-Reply-To: <877bj2j5lq.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2026 13:53:58 +0000
X-Gm-Features: AclHuK_yHM0U3XPdnM0sND1QmvgQov2Ij_X1lSIWn1pHOFqzxBgvqmjYvEaVoCo
Message-ID: <CAFEAcA81F=Pc-tVn4PyAniHF+E6_A==h6Q2biaa_76EtrH-ALw@mail.gmail.com>
Subject: Re: [PATCH v2] docs: Add security considerations for migration
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 at 13:51, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Thanks. I think we could maybe make the text clearer. Here's my
> > suggestion, that splits out the cases into a set of bullet points:
> >
> > * **migration/snapshots**. The user must deploy QEMU following the
> >   design principles described in the Architecture section to ensure
> >   that the migration stream is secure. Plain manipulation of the stream
> >   is not considered to be an attack vector. This means that:
> >   * Migration failures and snapshot load failures are part of normal
> >     operation; these are not bugs as long as the source virtual machine
> >     or savevm file are still functional
> >   * Aborts, crashes or misbehaviour of the destination QEMU due to
> >     an externally manipulated migration stream are bugs, but not
> >     security issues
> >   * A crash of the destination QEMU that can be triggered by a guest
> >     manipulating a device on the source QEMU before a migration may
> >     be a security issue, if it meets the other criteria we document
> >     for security issues
> >
> > How does that sound?
> >
>
> Looks good, thanks. I'll send a patch.

Thanks. You should check whether I have the nested-bulleted list rst
syntax correct there, I just hand-wrote it in the email client :-)

> > I think we should also:
> >
> >  * add a subsection to the "Sensitive configurations" part of this
> >    document at the bottom, that makes it clear that the user needs
> >    to be careful about the migration stream and loadvm files
> >    (to parallel the one that says "it's your job to lock down
> >    monitor access")
> >  * update the part at the to of the document that includes in
> >    its list of untrusted entities "Network protocols (e.g. NBD,
> >    live migration)" as this suggests the opposite of what the
> >    later text says. I guess just delete "live migration" ?
> >
>
> Yes, this one has been coming up frequently. The point was to keep
> developers thinking about migration stream validation. But it's
> misleading, better to remove it.
>
> > We also have 15 or so existing bugs that are labelled "confidential"
> > but which are "crafted migration stream can exploit the destination
> > QEMU". Unless you object I'll mark all those as non-confidential
> > non-security issues.
> >
>
> Ack

OK, I'll do that at some point this week.

-- PMM

