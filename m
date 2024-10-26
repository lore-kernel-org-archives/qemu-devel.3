Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE38D10BE5
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 07:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4b8p-00055O-CW; Sat, 26 Oct 2024 03:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bibo.mao@gmail.com>)
 id 1t4b8m-00054s-8P
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 03:23:17 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bibo.mao@gmail.com>)
 id 1t4b8k-0003Uq-GP
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 03:23:16 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4a47f8a9168so918007137.0
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729927392; x=1730532192; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGpdT0XREkpx1lJIRC5ENziUfiMnPAcql/tu6PIi7ec=;
 b=afp+gnmjR2g1TkWNmCmuMuV/if+hsw+VMGFpco9HO+3oAGp8w80RQcdFq2fuzJKDPn
 RX5zGDp8/8ZJ2ywNo6JG5u0/ZL0Kh34LrwXKk3ntv9xbyRGAWN3536LyuMHkQQLv2OJh
 ZjEQ9PVgFjRTlJ4F74lxb9VdMvXDF0+VUry6vBDYnLAfyOBNdtDg5kWEecKLtoYzPGo3
 DZ/JvbWpd8goNzhnwABNKxCSKr6jLGj7ckkm9ixtOsHRM9BgdQn+K7IoVn5wPOjuRWxu
 H8mSwterXgx+M3mqxRNhIxzRtt/yOnE0zY6SnkTXDpm0AE+uLkXsy88eTEipDH1Yf+ke
 mctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729927392; x=1730532192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGpdT0XREkpx1lJIRC5ENziUfiMnPAcql/tu6PIi7ec=;
 b=NQSAU7QTrYAcLT4+jsxhVFYt12fy9/2vk8CaoniS/92uM1M5AARxpUlxzvRakNOeFV
 I+jvNYrUO0lncLWBiVuvzqNTORjxxQeM7yVSQw7qXKmGW9Fp0Sg9hdskdjbhn3QlFKgg
 oWM5wojFJpDVs+xAWt31r8n12iB2hUBEBw586N7Nh94B2WXfUxztTQfzCy1RosLFFK1G
 y7N0Pf31M78FXcEQNS1dXbrXjX9vQYhAuNQKyNPPCMIftSCfBoEf616fQAcRBXUF3gtC
 Fdz0YcM9hoacy4i6/Qr4e75b3w4mkoNUItmWUYbIZcV6qIz5lITDA7purxoNUA0SS4Pq
 aU0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/W4O1gw5Rm/lSl2Buqw4uOPW/djEv8ZugB7iGXNHf5xdgom3KGx+kZHs1ouS2m5xEyCoh0YA5/CET@nongnu.org
X-Gm-Message-State: AOJu0YxxiZWb1d9L4fgpkb0n7zCGKXQewahuent3aJ/as/XEpJ5DLfZp
 RRczt7NBHPFlCgu3L48qpjgfYiFUuaF7fm+uL446B8rakRmz20vTRRu2B7D1QJrZMhOiVwRDVji
 Z2FwXOu/xzW4Z72QgJW2YxbHVmhyc+sup6r3/RfzZfdxkAWekr/k=
X-Google-Smtp-Source: AGHT+IGD61zN0s68Eou/PiN9zympAUW6A2mcqZOAARFOUjQfb5hE9L1Axj17CWcu6v2hdnn7UGia4M0kA4nLuxcVh9M=
X-Received: by 2002:a05:6102:4192:b0:4a7:487d:88e4 with SMTP id
 ada2fe7eead31-4a8cfb443d7mr1631262137.4.1729927392521; Sat, 26 Oct 2024
 00:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241024092626.1328049-1-gaosong@loongson.cn>
 <CAFEAcA89rs3Uk9NbqVM-Zwh7J6m10dAaYy0-D2GQOrKwAshv5A@mail.gmail.com>
In-Reply-To: <CAFEAcA89rs3Uk9NbqVM-Zwh7J6m10dAaYy0-D2GQOrKwAshv5A@mail.gmail.com>
From: bibo mao <bibo.mao@gmail.com>
Date: Sat, 26 Oct 2024 15:23:00 +0800
Message-ID: <CAPpFdZ3hpCV7NZy7u2r=NDALY=CDRTzR9OFkuCbz+gLU9ub6Kw@mail.gmail.com>
Subject: Re: [PULL 0/6] loongarch-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=bibo.mao@gmail.com; helo=mail-vs1-xe32.google.com
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

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2024=E5=B9=B410=E6=9C=882=
6=E6=97=A5=E5=91=A8=E5=85=AD 02:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 24 Oct 2024 at 10:44, Song Gao <gaosong@loongson.cn> wrote:
> >
> > The following changes since commit 6f625ce2f21d6a1243065d236298277c56f9=
72d5:
> >
> >   Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu =
into staging (2024-10-21 17:12:59 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20241024
> >
> > for you to fetch changes up to c44e0d6ba280dcc6bdf4ed555020c61d564b526c=
:
> >
> >   target/loongarch: Add steal time support on migration (2024-10-24 17:=
27:55 +0800)
> >
> > ----------------------------------------------------------------
> > pull-loongarch-20241024
> >
> > ----------------------------------------------------------------
> > Bibo Mao (6):
> >       target/loongarch: Add loongson binary translation feature
> >       target/loongarch: Implement lbt registers save/restore function
> >       target/loongarch/kvm: Implement LoongArch PMU extension
> >       linux-headers: loongarch: Add kvm_para.h and unistd_64.h
> >       linux-headers: Update to Linux v6.12-rc3
> >       target/loongarch: Add steal time support on migration
>
> Hi; this fails to build on all the aarch64 jobs
> (both normal and cross-compile):
>
> https://gitlab.com/qemu-project/qemu/-/jobs/8190899599
> https://gitlab.com/qemu-project/qemu/-/jobs/8190899331
>
> In file included from /usr/include/aarch64-linux-gnu/sys/syscall.h:24,
> from ../util/oslib-posix.c:48:
> linux-headers/asm/unistd.h:2:10: fatal error: asm/unistd_64.h: No such
> file or directory
> 2 | #include <asm/unistd_64.h>
>   |          ^~~~~~~~~~~~~~~~~

OOPS, there is missing file about unistd_64.h on ARM64 besides LoongArch64 =
also.
Will check and verify on all architectures.

Regards
Bibo Mao
>
>
> thanks
> -- PMM
>

