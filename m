Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9811606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XcxgdDbN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWouN-0002oM-7N; Fri, 27 Nov 2026 00:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrija.panic@gmail.com>)
 id 1xWouK-0002o0-40
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 00:54:04 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrija.panic@gmail.com>)
 id 1xWouH-0007CG-PT
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 00:54:03 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3b487f44ee0so3169956a91.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 21:54:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795758840; cv=none;
 d=google.com; s=arc-20260327;
 b=GYMYOBkMJFCW2Nbr051kE6y8ql4hmPG+P01YJgPkLzcvjx4JnBIrsyn5UDJhhsXI71
 0cJZGfy6+IhXSmrhzcZza9PmdEHYUDScuP4WCkfY7xNy3HR2UIFL4cuCGvOGaf/49wuW
 GeGLFESaVuPYFOnC3V6CLy5uIBWh2EgJylmON5bPiSRex1c9ulSl3oRA2oTtjclDtCQz
 32ypNHc77P8Gd4OAZwbijoEvsVa/NFAmmGR+5SzSAxuKWyQXIt3QZt7Fwe+zBhzc3jCl
 cLwdh0UVmjXjS/qFdiUrRg/GIPaXRA65ZK7XhYhAELnHAskmkSaPKQ8Pb2sl8ZX1t2br
 4Htg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HT2gF2bRaydtwmqbauUUdA7uyg1eZlTdA/5qAeXx4L0=;
 fh=2PC3Z0NukJVIDaYxy3miBRfJTqMnhctBzZ+CdwiiAuM=;
 b=MSAhBMQclakcCu7LKFHknnL5V12aMPrk+4DQnH3hERfNPTOgvFPycuB5k4LDFX9urv
 eP5PqCgWZMOsRA7qbe9Gszxdrh1j1rzJVkyrAVmf2+Zz6JxZyeRF5OpEQUPT1aPhmyCA
 1e78tyHmD7F2y+HyG8gKLjahVcEXvy3/2KVNj6xkHYBGTtijmkn06De4g5E79UCGpqwc
 c5eMB+olyaR2HATAZGLpxzhZHASyocm8qXGx3R6oysw0HKzjrsw9wevT4pjiUYlpg0k0
 5e01iYgdFCiEdTHe5/9X02C0jYJmp3gkUut7wL4HrsmVfAWqe3ZvnyLWekxQ5eDp1Z7B
 U90w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795758840; x=1796363640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HT2gF2bRaydtwmqbauUUdA7uyg1eZlTdA/5qAeXx4L0=;
 b=XcxgdDbN5i2f+mJqkg0VB0jyLAZAVmFJlGvaZRfFV9ECeKb3uFN3Brs1r/JFhCSD1E
 A6vmSUzG3dZGCYH74fxzOF4N0z4a3J+j1m/W7EuVTTChzILf9SW9Cab/0F5RHtzaAU/W
 eiWPf87bFStF59K0g0X7meevUWio7IX39s4OldbAs1bs0vx69VACISjhs8/BNZap4JyM
 kPjYRf2Lzl8XeAcY9rRAT9JMZXwGU1lbE9fs3W59SfGE1xP7LfoRDuUhcap7bA36QP8h
 dQ8ZdWqXPOQYKDJlZcekoQmz6YSP3CWbwRy1oOOEg/CYFnhIAJO16yH/nxQLXzATeo4J
 j8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795758840; x=1796363640;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HT2gF2bRaydtwmqbauUUdA7uyg1eZlTdA/5qAeXx4L0=;
 b=cdw/2SZZQz/TtLONSGK2y8+awdVfwwBr/wYdQvpf9G2nPVP4/2K04zuHyatgbwvqYt
 EhwkZlZ/hl412xNxhg2VdhD761jdDIXQjalGBiFNDDrSY0itav3ZbCNuVnT1Zj7ELk5b
 ebSg9kZJGqMUinMyrzpERkntwMaEcHAFzexTUh8H3uIq5Dc/luuNMg5AEz6yXMHzubjX
 ZQsbmh7ABzavdVDW79KU2ACDlVwTzSJzYZFxNBx+Wr5GQbcmQZk5NtRl2gRizggv1oze
 hanjY3XQbC24xirNyLk2616eRpO4zQrLLER/sWr9bLLRqB/YYzkXJSc4z41kwOHCfIO/
 //Og==
X-Gm-Message-State: APuU4Z+ROo2EXkAlnQrHqlO5AcZTR61CB2GDGW9Wr9HyLH0Lgs366CoI
 4+zmYy81gJ4XsORVmtX7MS4ChZiKI7JY3DJFhdzi3I7/FRDCsZmC8Dolq4rSvOSVsUlBNBb3G9K
 Cfhy12HcvrGVnUOqsA+NM0/sQuHKjkiD4gXdb
X-Gm-Gg: AZFdTZdQB7nb8WrrX1RVJK5GLYSzrkCFJQrJ40mkNR/Ev1FccBXlMQ1R2PmSTTuC4C/
 zArntZfMmU4QP+a7GzBJoCJjd6Rd3fZg21iFIGNhOYvHsw2iuLbjvu7XwSQt4Li9EHbpRITGUIt
 QalI4h7ZOWCx4edQrLQcMkUikVOe6yed0ieNV5VKdv/yw9UYojJv0iwvqVqc+Hzl0pIjGt7ZDl3
 NONjEmNx0UxDJJBSgSWY5sIa3pn83Z7JfUKBVxJ+5xe/kJIo9xXiatMc0ZFjuvhYp5uBeXZSE81
 MyZSa4odtOTlf6UeCQtf/z1rKNswUHev/Jm7FdPIt20sicYR4DT97CtYuDl3jI33KMklUwUzQ24
 F5wIY7WAoso1DhPpkqYEy+vqqd0PxTMkSvptb/e8bwoS0Tovf5RSHrY1EliiV66m0ZfwJLs7asE
 DDig0kfblF1K0xoOjPtGbC/oyOxKAkiV7jAgs6DrOmQlXhtVUg3CGJPgqdJhoojjQbLMGZbN8IH
 5OL8ATK
X-Received: by 2002:a17:90b:5109:b0:3b1:82fb:7e03 with SMTP id
 98e67ed59e1d1-3b41c9b25a2mr24401346a91.11.1795758840005; Thu, 26 Nov 2026
 21:54:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMvtBPPveK4wH+P9bhWtWk-i9S-xBP-nggvWppFkJ7P=++0D5g@mail.gmail.com>
In-Reply-To: <CAMvtBPPveK4wH+P9bhWtWk-i9S-xBP-nggvWppFkJ7P=++0D5g@mail.gmail.com>
From: Andrija Panic <andrija.panic@gmail.com>
Date: Fri, 27 Nov 2026 06:53:45 +0100
X-Gm-Features: Aa3M54o-_YHe9N6y3Rgeg6fqMvpbB-VYPPfB6nYHCGrXA5Kj2KaSUHpmgfB4HUI
Message-ID: <CAMvtBPMaJXgbq1tqa2kn2LdvamAbPY87CwK8c1VVthYupnMYBw@mail.gmail.com>
Subject: Re: qemu-ga: safer default command policy? (re: "Improve mechanism
 for configuring allowed commands", June 2024)
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com, 
 armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=andrija.panic@gmail.com; helo=mail-pj1-x1036.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

One addition I missed: the Windows agent is in the same state.

On a Windows Server 2019 VM migrated to KVM, with qemu-ga 110.2.3
installed from the virtio-win package in the AlmaLinux 9 (EL9)
repositories, the service runs as LocalSystem with no allow or block
list and there is no qemu-ga.conf. guest-info shows all 37 commands
enabled, and guest-exec runs as NT AUTHORITY\SYSTEM.

So the same RHEL-family distribution that restricts its Linux agent
ships a Windows agent with everything enabled.

Thanks,
Andrija

On Fri, Nov 27, 2026 at 6:30=E2=80=AFAM Andrija Panic <andrija.panic@gmail.=
com> wrote:
>
> Hi Daniel, Michael, Kostiantyn, all,
>
> I would like to revisit Daniel's series from June 2024:
>
>   [PATCH 00/14] Improve mechanism for configuring allowed commands
>   https://patchwork.kernel.org/project/qemu-devel/cover/20240604153242.25=
1334-1-berrange@redhat.com/
>
> As far as I can see in the archive, it stopped after the branch
> request in July 2024, there was no v2, and current master still has
> "allow everything" as the fallback policy in ga_command_is_allowed().
> Is the idea still wanted? I would be glad to help with testing.
>
> Why I am asking now: I work on Apache CloudStack and on VMware-to-KVM
> migration tooling. Until a few years ago qemu-ga was installed on
> relatively few guests. That is changing quickly. Management stacks
> now use it for IP reporting, boot readiness checks and quiesced
> snapshots, and migration guides tell users to install it. Many guests
> that never ran the agent are getting it now, usually from distro
> packages, with whatever the distro default is.
>
> Those defaults differ a lot today (read from each packaging source):
>
>   - QEMU upstream: everything allowed.
>   - Debian and Ubuntu: the unit runs plain /usr/sbin/qemu-ga and no
>     qemu-ga.conf is shipped, so everything is allowed. Debian bug
>     #1076139 (July 2024) asked for a change; it was marked wishlist,
>     with the service file taken from upstream as-is.
>   - Fedora rawhide: a block list is shipped but commented out, so
>     everything is allowed.
>   - openSUSE Factory: blocks guest-exec and guest-exec-status only;
>     guest-file-* stay enabled.
>   - RHEL 9/10 and rebuilds: an --allow-rpcs list without guest-exec*
>     and guest-file-*. That list still includes guest-set-user-password
>     and guest-ssh-add-authorized-keys, i.e. the "user auth" group the
>     --no-user-auth flag was meant to cover.
>
> So no distribution I checked blocks password and SSH-key injection,
> and only one blocks file access.
>
> I understand the usual answer: without confidential computing the
> host can read guest RAM and disks anyway. I think that undersells two
> things:
>
>   1. Cost and visibility. Reading secrets out of RAM or editing an
>      offline disk is deliberate, specialised work. guest-exec is one
>      JSON line, gives a root shell, and looks like routine management
>      traffic. Least privilege still matters when the attacker is a
>      stolen operator credential or a compromised management service
>      rather than a determined host admin.
>
>   2. Confidential guests. As Daniel's cover letter says, with SEV-SNP or
>      TDX the host is not trusted, and an agent with every command
>      enabled undoes the protection. Guest images are increasingly
>      built once and run both ways.
>
> Concretely:
>
>   - Is there interest in a v2 of the series? Was there a design
>     objection, or did it run out of review time?
>   - Would the maintainers consider changing the built-in default
>     (for example blocking the "unrestricted" and "user auth" groups
>     unless explicitly allowed), or is that seen as a distro decision?
>
> I can test a v2 on Debian, Ubuntu and RHEL-family guests against
> libvirt and Apache CloudStack, and report which management features
> keep working with each group blocked. CloudStack, for example, only
> needs guest-ping, guest-sync, guest-network-get-interfaces and the
> guest-fsfreeze-* commands for its core features.
>
> Thanks,
> Andrija Pani=C4=87

