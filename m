Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE16D1CA19
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 03:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ATV-0002at-Ml; Mon, 04 Nov 2024 22:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1t8ATT-0002ae-UF
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:43:24 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1t8ATS-0000zu-0O
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:43:23 -0500
Received: by mail-io1-xd43.google.com with SMTP id
 ca18e2360f4ac-83abc039b25so197422539f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 19:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1730778200; x=1731383000;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eYDuXKXX17/hYaQjSmGzkWh5AA9mf4cKGn+ZKOMQRSQ=;
 b=VCpy1MmhB4HCuwrVUFKU0ukhco/Sq/2uhbnpN+6W3eF9nF55Swq3N6Rq9ZzT6p4ywJ
 OWlVF3TWR6IZQ/pO+bScUeiBpeWyPkwwthYGf99Uq/kC8OGXaUEw46s+dEQoc/qhDnIL
 sS+/JNeodnoJu06XJHD3H172oSmjCzdcqgwVAZ/wd2Ccz9JZ9PXYkUXwtBJ+NRWrJVfT
 GATDLjn6j6XmLXgUU7SShjXSLF8wE4uj2ndn0YooFIZZeXAEnVVWOFlq6PRd9chDCaqJ
 RYl0TEkGaorsRSzp988cCDypCHE9D6jFJeYN9/dxXKnEJp/fLtoiQErGsH2RiuIYpBQf
 i/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730778200; x=1731383000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eYDuXKXX17/hYaQjSmGzkWh5AA9mf4cKGn+ZKOMQRSQ=;
 b=UPtX3tS0VWmbCKmG49/RV106pKgXs0CuM89UG/ZC7XUSb4fWqyKxrmZrDIUdp32rvb
 H39oYIkrg4eF2krTjaylplHuVM/Iy0/X1oMqJQUWfOuHYo6Vuile739AL8ZxzdHCs5UK
 Lw6j/+DOfem5iUXHRsl/ZEcBoOjUtv22R2FDkCx//Inial9w1rkwL9phWTHKCeFNAGd9
 CQa6sXQisdA25dJ0m2Ep3a2Gq+YQpB2/peaD78YakJ3NiwxEbbvzAj3l9BJvtESzhNZU
 C6NI+mDjSGR4sEXhoRmuypqGd8kf0t3t1e5kx1weXHpaMwjGjSTtSEmsPzfV0SpMoAPZ
 zsaw==
X-Gm-Message-State: AOJu0YyJ5ejM+Ny+OfbAoq7tLgo1Y4zuDTfWDPq2t7t5cddEp1yNk5pb
 yk0l282Ms7xYuC+ZlAPE53KoJDLg6Ja5qrfrcfHC1syQAyYn4O9A55W5aV83q8Cp2WQjSQtHh73
 BFUce2cZZ
X-Google-Smtp-Source: AGHT+IFtJtc0IqYeVYm6maUbYp/PtH8vxi6yZN+wetJ8jhZ6vN9nqT7t+amMDNpSiTC8c04fJ9MGaA==
X-Received: by 2002:a05:6e02:1707:b0:3a4:da7a:15a2 with SMTP id
 e9e14a558f8ab-3a6b0219e07mr127702355ab.5.1730778199763; 
 Mon, 04 Nov 2024 19:43:19 -0800 (PST)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6bddcdcd8sm17162665ab.37.2024.11.04.19.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 19:43:18 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Jessica Clarke <jrtc27@jrtc27.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PULL 0/3] Bsd user 2024q4 patches
Date: Mon,  4 Nov 2024 20:40:36 -0700
Message-ID: <20241105034039.31143-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.46.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d43;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd43.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit daaf51001a13da007d7dde72e1ed3b06bc490791:

  Merge tag 'seabios-hppa-v17-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-11-04 16:01:23 +0000)

are available in the Git repository at:

  git@gitlab.com:bsdimp/qemu.git tags/bsd-user-2024q4-pull-request

for you to fetch changes up to 52a523af71448f62e8523ed002447c95170381e9:

  bsd-user: Set TaskState ts_tid for initial threads (2024-11-04 20:26:40 -0700)

----------------------------------------------------------------
bsd-user: Minor fixes

These patches have been in my queue pending too long (I have a bunch of others
that haven't been reviewd, but those will be done clsoe to the end of the
release to not get in the way of the release).

The patches align the stack properly on x86_64, implements setting the tb-size
and properly setting the ts_tid for initial threads. They have all been
reviewed.
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIzBAABCgAdFiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmcpkl0ACgkQbBzRKH2w
EQADmRAAl301TtPNsGmrjq74qHgFWPNHc4SSQlK8oIIBgM2Mco/sva5N8ZsCIo4K
G6uHRbDn3AXUzi7N72ZRKFxQMDQfthtQDskGvsg3zD96pYXkWF6dB3FwSs0Kg0QW
ow3jj7qiP8NWlbAnMq4fXdtkLGD7S1Og606BYUvk13ILHLY6kwvSWJv53Cq+lDXg
IQkHGWckG5Xvn/OY3KoLbw77APBCn/fbH6e2yAnBgS8STzEPf2I8xWEiwP6gMpc/
/BdWkEmqJn5hM//Nf+Yz0uTVMh7egwP8+NjTqYMzWCU3kV0Gtk1cTvpJX3wyzZvZ
exLOMjL4C+BClA7EJtBvsRrnvv+8ytxn7F3VCeqFR5nAZiU4L3+WfpSjVe8oYCAw
DL8LYKQA0Abwt6F8EPHwxPxO7HWAKJ4Wxrwlz66juA8gOyuRp+ueVH11ztds6yeh
rWEgwdXMBOuBcNCGgkuTOajFTRK8hmQNcf/okwODMa5Gj2ayyNmFTnD/bFPe7CbA
GzJERU+Xtz1wFg+c5LRqqrOnDqD3wDXDrcOuHRhdRWbAl0rLCdH1CLORXZ3XTuF4
m9JxmaRiCs++a5XswRrSzxb6BM6hKmKX3baGZUeVW6lKyGyyqvY+uUVKkv4U8KqP
jLPPHE4dicl0/1QbGHZY52gkLYRFXdKa/xKhc8NHXtaWSFACzmo=
=8H2C
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Ilya Leoshkevich (2):
  bsd-user/x86_64/target_arch_thread.h: Align stack
  bsd-user/main: Allow setting tb-size

Jessica Clarke (1):
  bsd-user: Set TaskState ts_tid for initial threads

 bsd-user/main.c                      | 10 ++++++++++
 bsd-user/x86_64/target_arch_thread.h |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.46.1


