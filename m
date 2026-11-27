Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED8606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pasCjtFe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWoXo-0001wu-LI; Fri, 27 Nov 2026 00:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrija.panic@gmail.com>)
 id 1xWoXn-0001wk-CU
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 00:30:47 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrija.panic@gmail.com>)
 id 1xWoXl-000116-1E
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 00:30:47 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2f11330e550so1034475ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 21:30:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795757443; cv=none;
 d=google.com; s=arc-20260327;
 b=hdaM6SL1MnvYCOL/vrwnp8ODSLuKggOOocHxFVH1uI3cviUDakVaRXnlH3MCOMf2xV
 7dJTjeHeP6GPRylAy4KWZFv+NyIAqcqhAIWA7XzHIjUeBPJqIwJ52sm5YUw1ItlHEwE/
 +pYZ8GfF06Yf+D0+0B70mIT/1ArA7NBDXnG7VuDfqbjmvvkEhLnpG2A00gltVpLCjBGO
 IE9NrmMZh2qDsng6nnG44i86Z4AmAb+VUoEVpNDdAma9FQJo1/RfriyDmXy/uyu4sxY/
 tfR3dci99TUKxHkUrGnFLlNu82UD/XKSU3wQGBYDp7ETsA4qWw8sTTpmBXL8oVs7NEf9
 EGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=IFKhPRihLYUM4Mjfzd6T/W9a+q4mYF6R7h7d7148cys=;
 fh=2PC3Z0NukJVIDaYxy3miBRfJTqMnhctBzZ+CdwiiAuM=;
 b=cx+A8E8v0TN1FiR2qksJLQ39BTSfeykLGvobVijcctexg7yCjV4XbPkEzqdTEIK6SH
 jiCCHL5cB4qu2OA3+WXxtXMoY4024uS7VYJJ/P8J4mA+VBROimsaX9defLu33owpgIA3
 MC9E3uj/WJLvbCDIdUnK3Oc70LTHYCi+FfWE5N8oGS+DUgXBbKbbbJXK7mC31ii5oenh
 JExuEXZmBFr5XgltUc4J6t+jBpvN91M+n4pk//dmOkWP6zz39eoRwIZE1z1VYZwOfbCi
 TnhWB5EmEvpP6B5o9qKHGJtqhd8rMDJ2Yn6gAK6j5QVr7a2OzyHgFPWb2kTq1prf1+qA
 15bw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795757443; x=1796362243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IFKhPRihLYUM4Mjfzd6T/W9a+q4mYF6R7h7d7148cys=;
 b=pasCjtFe1v+oTaDewxKo5G62RMhtip20zGPcEjn383z840MphWkWvJeamP9ZUvCmqh
 CEvfTogMOMiVP4uBwZ+oJYBa3bpCEoVlUsc4+tOg1KXtPF2YIxramygGis3eaJCayooG
 /MbajzlXutoxMKVxuv7Cc4Ave1tW4zwnEeicubGjI59kLAo1q3R4Gpzpx8MRFOS2kayP
 W6uQRxAvnLybjyhLfc6rGBf5rNwN1uzxGda1xPAbJkM+6xRqvpsNxzYxUVe/5kfvgpDa
 YhjyfMf3vn0n27PWs5vD9uerF8lvM6B7yqU3ey98sRxXcfD/jgGu+M5XShg3GFHt8eNp
 KkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795757443; x=1796362243;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IFKhPRihLYUM4Mjfzd6T/W9a+q4mYF6R7h7d7148cys=;
 b=tLqeaPQm34WBdfez5EDvYAPl8QGyDSn7I5hYRaFKyy0dF040uMRRNrZE5BFZGyJDJK
 ofFiLzgM/lqbFlm9qaI03pLwJm5Ydzn9n9EgbGUFv0dqfZRWgMZGTgQQReTPJkY4idBG
 mR7TH0bNwaiYe5NZXYWanzppF6v4bnexSRlO8SX04ni+WQIsRi8VPHx0djAX0f/EQQnx
 4xYrWOE5R/MFeIquL4mcIx8rbWjYVc8LHOPm9VDFnbhS8aIopBq666jANKvLQwFyvW7r
 yH7dQtR1Eu1GwpU+9mRQ4ZLH6zuMEwDq4DYE3PsU8T6P0qG0hoDreNAhAY/HWo+KbBWz
 2swg==
X-Gm-Message-State: APuU4Z/yHpSVtG52IOsoT5x0309vuTKLznWaaLf8sXn7dnanId4YUMxj
 FvrMYX59sHFclG4UuPcIdENTsuwCPcoE708IrgeHpzz+vyBnO8mRdyvA0lkSAuxaH4C7PahAesK
 M5+BsZ9p0p5+q9qfHvN96C1nzmjCHxgirH49t
X-Gm-Gg: AZFdTZdt/27+qZsDnXEsWK6gu6BVtMECSqzAjUjh1JiKVi5z9yl+2G5IG5hI3rcYQ4r
 MQZlVIMVWCItg7nj8Y75yWWkHzhu+3vD2xR7Wi8IApwqgiqfWjLH9sUUmRnXocfajWkDcrHd57X
 Xswyhk+rnEsOnZ0q9ufS5tr2Q5Wzl8adsnp3n71W/jgo2Tws5lCxgKdko/G8w41zx3xVnP6oDy4
 kKv1wHInsA70REqIV4cSHlIoIbglc60EpCDD/u0QUCx1GlH1/0snoMU2R/GMzIse1zI5vi1L0WS
 ZZHqwL/1bVmVx0khN89micbYyJthxLa84PzaOl3SQBs12Kl5ecX7vwU1W7obIqmLghzreVqPqYm
 aUwaivirMDhhw5TPmguDoMxJE2xiiKi8RJuC2lbRiTtHIRfPxF+XD3XtolWORhLb7EFRukkVWi2
 7rZel++wMH9sZ5x69MDEiE5k0ZD0s3kdmbGyJ8J5nHPrYqoVOqkzs7CmME/OB/+IJVPv7WJL2+u
 9LWTBmr
X-Received: by 2002:a17:902:ea01:b0:2ef:da23:7aa1 with SMTP id
 d9443c01a7336-2f03f1c02eamr222016585ad.40.1795757442901; Thu, 26 Nov 2026
 21:30:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Andrija Panic <andrija.panic@gmail.com>
Date: Fri, 27 Nov 2026 06:30:27 +0100
X-Gm-Features: Aa3M54osxDx6-TrRIgczU8tX6y0yy9txJqCqWlgw7lvN5vP7rkJM9I3XfXxmZGE
Message-ID: <CAMvtBPPveK4wH+P9bhWtWk-i9S-xBP-nggvWppFkJ7P=++0D5g@mail.gmail.com>
Subject: qemu-ga: safer default command policy? (re: "Improve mechanism for
 configuring allowed commands", June 2024)
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com, 
 armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=andrija.panic@gmail.com; helo=mail-pl1-x629.google.com
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

Hi Daniel, Michael, Kostiantyn, all,

I would like to revisit Daniel's series from June 2024:

  [PATCH 00/14] Improve mechanism for configuring allowed commands
  https://patchwork.kernel.org/project/qemu-devel/cover/20240604153242.2513=
34-1-berrange@redhat.com/

As far as I can see in the archive, it stopped after the branch
request in July 2024, there was no v2, and current master still has
"allow everything" as the fallback policy in ga_command_is_allowed().
Is the idea still wanted? I would be glad to help with testing.

Why I am asking now: I work on Apache CloudStack and on VMware-to-KVM
migration tooling. Until a few years ago qemu-ga was installed on
relatively few guests. That is changing quickly. Management stacks
now use it for IP reporting, boot readiness checks and quiesced
snapshots, and migration guides tell users to install it. Many guests
that never ran the agent are getting it now, usually from distro
packages, with whatever the distro default is.

Those defaults differ a lot today (read from each packaging source):

  - QEMU upstream: everything allowed.
  - Debian and Ubuntu: the unit runs plain /usr/sbin/qemu-ga and no
    qemu-ga.conf is shipped, so everything is allowed. Debian bug
    #1076139 (July 2024) asked for a change; it was marked wishlist,
    with the service file taken from upstream as-is.
  - Fedora rawhide: a block list is shipped but commented out, so
    everything is allowed.
  - openSUSE Factory: blocks guest-exec and guest-exec-status only;
    guest-file-* stay enabled.
  - RHEL 9/10 and rebuilds: an --allow-rpcs list without guest-exec*
    and guest-file-*. That list still includes guest-set-user-password
    and guest-ssh-add-authorized-keys, i.e. the "user auth" group the
    --no-user-auth flag was meant to cover.

So no distribution I checked blocks password and SSH-key injection,
and only one blocks file access.

I understand the usual answer: without confidential computing the
host can read guest RAM and disks anyway. I think that undersells two
things:

  1. Cost and visibility. Reading secrets out of RAM or editing an
     offline disk is deliberate, specialised work. guest-exec is one
     JSON line, gives a root shell, and looks like routine management
     traffic. Least privilege still matters when the attacker is a
     stolen operator credential or a compromised management service
     rather than a determined host admin.

  2. Confidential guests. As Daniel's cover letter says, with SEV-SNP or
     TDX the host is not trusted, and an agent with every command
     enabled undoes the protection. Guest images are increasingly
     built once and run both ways.

Concretely:

  - Is there interest in a v2 of the series? Was there a design
    objection, or did it run out of review time?
  - Would the maintainers consider changing the built-in default
    (for example blocking the "unrestricted" and "user auth" groups
    unless explicitly allowed), or is that seen as a distro decision?

I can test a v2 on Debian, Ubuntu and RHEL-family guests against
libvirt and Apache CloudStack, and report which management features
keep working with each group blocked. CloudStack, for example, only
needs guest-ping, guest-sync, guest-network-get-interfaces and the
guest-fsfreeze-* commands for its core features.

Thanks,
Andrija Pani=C4=87

