Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C879C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 05:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJnR6-00089M-2A; Wed, 19 Jun 2024 01:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1sJnQx-00086Q-0r
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 01:00:36 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osandov@osandov.com>)
 id 1sJnQu-0002DK-SW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 01:00:34 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c2c6277ef3so4975465a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 22:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718773229; x=1719378029;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wdqYdzGELW4IMh8dvRt2slYw0DUpWprPFoFZwvvOnhg=;
 b=hZIPtelAGTqnZ4AHowRQqlNN9eoa/96n03Cslnrioq9BfsiRtGD3CvWnAF0v0iC+ce
 yu6TSrdEXXrmvtZrJc+CC6OeaaY7G13s8JPspN5WaD0uuPlGCgo7sLAmkMvw3UwZ7Cy2
 CF/Ekvw9d5q7SZu2IuT9L2ZGvLM5+wCppFRLl45mHK5EARD6kH9XY7XcKI7Gfe8d+/eU
 WfPU2RWuc2l45bcoLnq2z3zddZUXk8Wqum6DL6Yb2S8nbTnvfNG4JenQo2XFY7urldto
 HHWDDPsctquksxcte+f9a6ZuN5aOtEkIEH/OcFH8jCx69O+2sxtLqhUrtkOCCNfWXqny
 1d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718773229; x=1719378029;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wdqYdzGELW4IMh8dvRt2slYw0DUpWprPFoFZwvvOnhg=;
 b=uEDG5Tqjn5ljXEZHN2RUmpB4nY2VtD515WA6W6gE6YcjcO4Eu52Tn8qv5eR5AaJle9
 usIwtWQzn9urXg6/B/5ur4DLwu2c+Aud9dUgc5+4tlBmsv8J8gpr+pwKL+kNq1k29CrL
 wLDv+RJH2XCEyKr/g8EEG2CzPasVtAt5yEIGU2wZo3KYPq5qisSApjr9ZI43YacpXp4f
 E9Km2hPp0xNz3tspvlgyvst2IIBP79NLKfs5rOwOGBkB2sAUKlmA2OQvA94daRkJHEj8
 f1v+HoN3bARnQXgiH46VQtA/g9NW9Jgwsxl5hXhPv/8H1Mx7v/L+pN6fYl4qsKForKjf
 G3eQ==
X-Gm-Message-State: AOJu0YxSmytQ4nWqdFj4SMYhHSueIAkO9X9N3G9gR6GLrADS4iJ78z3h
 NHFYBYRN8HF9TIass7OOw3mu2MbQA/+fue8Y+iR0SDdsay/ETFMUgC/oOa9MbbWQihClB7eA8Dx
 G9fg=
X-Google-Smtp-Source: AGHT+IFGKOapms3+4yZP/y65VOPCtRvSPTLwXvy7mVzgCYouExeFAtg/CMJ7sjj/S52Xdj9Wns6vQQ==
X-Received: by 2002:a17:90b:3552:b0:2c3:11fa:41f with SMTP id
 98e67ed59e1d1-2c7b5daec84mr1538586a91.45.1718773227597; 
 Tue, 18 Jun 2024 22:00:27 -0700 (PDT)
Received: from telecaster.hsd1.wa.comcast.net ([2601:602:8980:9170::2f17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fedcf36be7sm7457523a12.1.2024.06.18.22.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 22:00:26 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 linux-debuggers@vger.kernel.org
Subject: [PATCH 0/2] arch_dump: fix prstatus pid on s390x and ppc
Date: Tue, 18 Jun 2024 22:00:11 -0700
Message-ID: <cover.1718771802.git.osandov@osandov.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=osandov@osandov.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

I maintain drgn [1], a debugger for the Linux kernel. I ran into a quirk
of the NT_PRSTATUS note in kernel core dumps [2], so I looked into how
QEMU's dump-guest-memory command generates NT_PRSTATUS. I noticed that
on most architectures, the note's PID field is set to the CPU ID plus 1.
There are two exceptions: on s390x, there's an endianness bug (it's not
byte swapped if the host is little endian), and on ppc, it's not set at
all (it defaults to zero). They're both easy fixes.

Thanks,
Omar

1: https://github.com/osandov/drgn
2: https://github.com/osandov/drgn/issues/404

Omar Sandoval (2):
  target/s390x/arch_dump: use correct byte order for pid
  target/ppc/arch_dump: set prstatus pid to cpuid

 target/ppc/arch_dump.c   | 21 ++++++++++++---------
 target/s390x/arch_dump.c |  2 +-
 2 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.45.2


