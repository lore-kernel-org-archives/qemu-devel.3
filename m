Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF9EC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 04:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tns4L-0007pW-V6; Thu, 27 Feb 2025 23:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tns4I-0007pH-TZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 23:33:46 -0500
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tns4H-00005g-8b
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 23:33:46 -0500
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-51e902b58c0so1322370e0c.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 20:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740717224; x=1741322024; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+4hfEZ7oyRQwnR4N4n5f/VaD5dsfpvw9io43m+St5g=;
 b=AKrq0r3HhZpG6EoecV/S07WFBvjm1iBNHLGFpS4HXmiGf2WTTPs6exVnkjpSbjp/4J
 C9B6gzt7VNq9sa5LTgmII5rMF9mIX6H/bl5OSHAs8dT2iN9U5DW0jsoc1uZvpG11tgWo
 ntnLj7TQZgPijZ6vDVii2XMxfrIw+fqsXEwmu/TDjoqqKBgopGN/8McZmlYeAP5g3AEk
 YRJ2WJ5N/46xISlvPgrZi5QUBq6XJqxStNuwOCFvkmGyJCbKGAWFIZGi4qG4PVoI/LXO
 D6Fl/YT6WCntP2mVegPbOfQIvS5dCn3tfFVDtVrd6pKosQ4R8t9rhaI+nvpXDlfecIc7
 Jn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740717224; x=1741322024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v+4hfEZ7oyRQwnR4N4n5f/VaD5dsfpvw9io43m+St5g=;
 b=an8fw9U7V4FDQ0BPtKbl/RcHRR89VwSM+8nv+b52VjLanuAKEAzTA7facdaqssJLFq
 E31SAHLHIsFdR4xKJHfZxlIJbVI/N9UPzPBe27nhzSgqisyqxZD1Ic9Lq/aK77VMPgJD
 Fup5yiZzaiS0EPzb5Rd+LJ9ShV4ZiARedoYgYElLdoOscw0Z5jGGo++F9o2lX/bbjwwD
 kyrp0lD9y5ukdYRoGCq4DPJeUF/JSf4ogqSQhmbZIyrnPjBILxZl3UCUyfCx+gj+0Lrk
 SQ3SoQOEkgXhJFsNe99o8t2TMzjhlRxyiJG9bncXD4M8L6xk7sDJbQEh2/Gkp5eea6yt
 8PUw==
X-Gm-Message-State: AOJu0Yxl5IVVXZuvPsHa75g6sjr3kmIaQsEXEt0jeVNPYPHqSX66Ikef
 zKg5kweDpm7qSOnATTE+78P4QvUUV9xApGoiuUsUNB1kUZNqGhGbznM0D73+vmWLjUz4XOF7qnf
 Gl7pZgNbSbH5gb3/wbJft/U5hLDcYvJq0jjE=
X-Gm-Gg: ASbGncuoRSWDMQTfM3P6RRuX+lt16pDvpm+doIa43eLS4Q0u0cPyz//JJAQxD1fIVTN
 sHzFeaZbkycW7VEUOqEDQtprA78RdSQz48H6VsamzJs/CaTSFn9/sgEkoCgEg0yu4MSBp/TRTKI
 H/uoT8JhjbEfuj6dMuaWdA1vXVUzqbx9sypk1C
X-Google-Smtp-Source: AGHT+IGmApyc+bCRfGM6MMjG0oTFngw/ohX6WinmOtkVR4/moK/yszfb/SwFtG3zicIb2L6ZBpot64aiX7lSE0X9tGM=
X-Received: by 2002:a05:6122:3908:b0:51f:3eee:89e7 with SMTP id
 71dfb90a1353d-5235bd672a7mr1079432e0c.11.1740717224179; Thu, 27 Feb 2025
 20:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20250127182924.103510-1-abologna@redhat.com>
In-Reply-To: <20250127182924.103510-1-abologna@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Feb 2025 14:33:18 +1000
X-Gm-Features: AQ5f1Jo54A-8xteorpDmLD8QCmz4hcYXF8LdltgPgTh_pbUHsQBFmd67WYxQOoM
Message-ID: <CAKmqyKO29B2sJBFpqfZwTRYdkDSevCnDhBha48u8t4hczmjU1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] binfmt: Add --ignore-family option
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 David Abdurachmanov <davidlt@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Tue, Jan 28, 2025 at 4:29=E2=80=AFAM Andrea Bolognani <abologna@redhat.c=
om> wrote:
>
> Changes from [v1]:
>
>   * adopt a completely different, more general approach.
>
> [v1] https://mail.gnu.org/archive/html/qemu-devel/2024-12/msg00459.html
>
> Andrea Bolognani (3):
>   binfmt: Shuffle things around
>   binfmt: Normalize host CPU architecture
>   binfmt: Add --ignore-family option

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  scripts/qemu-binfmt-conf.sh | 78 ++++++++++++++++++++++++-------------
>  1 file changed, 50 insertions(+), 28 deletions(-)
>
> --
> 2.48.1
>

