Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A50606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cs8MuzKE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNG6a-0000kz-0z; Sat, 31 Oct 2026 16:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xNG6Y-0000kf-5U
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 16:55:10 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <takano32@gmail.com>)
 id 1xNG6W-0004iO-Dg
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 16:55:09 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8a06c60065fso1178082b3a.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 13:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793480106; x=1794084906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NIHRIfhr+XMkCP7Tm65NJ4Z205ZYe4NSX6FFTCCXRoY=;
 b=Cs8MuzKEhgn92SUiv2DdG35Zqb6vFazj8hl81MwzPYqyf2oZ+gIeoYae2SxgF485JQ
 Hepwh7Z77BQN169rIr/UrsutI1UY7YbermhAj9V3Rpwx9sqy1XzIhtSfrnJpIonhaWap
 7EUdoAyH/iL8R+E980S9w/zikeR5IQ0XzvF4c8vMktmjUHGZ+MSRxZ/2FAQh9Ms389I3
 NDuzoTTzNVGcMj9yRSNsf87WwbFq4NMaDnLgWdQz37NNPMJuD1VLLG6KLyTyl5EdK1Oj
 FrenNdY3kdEfUIKL96fYPvn3cMdtm0S0+j23NNAc9oFJjo9maQeZJG8jhEkokdMlCvpI
 FKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793480106; x=1794084906;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NIHRIfhr+XMkCP7Tm65NJ4Z205ZYe4NSX6FFTCCXRoY=;
 b=KesJfpcbqAvD4QQ+IjOuBBrWh/nMo8lqhT/vLuoTxvau79bsvjcVb2Dc7OwOxJMFpS
 hvFvBMgTsmwR5MDKknovg3Ivo0O8oHu1ZybpcrGuCwyHvEKyTvuLqchss1qyxFb6xNP9
 d7mU9jkb/lOWPgoD9Oix+URbJgamq5Gx50EjxcEbgtz4jtwYNCbHC1REPSIcdBYfr864
 p/P5XqXZBaGIgD3sSkCTp67LliSNAPyFuS9L9QLEiE9K3/pZxIVwPBq+xO7ZrVSGsFv3
 4Kq8q3K1JLE78e9sTOXVN7yVHnEg3AS8RagJI9rJ2Haq/xijNCwYJ8ERm8iiy3K7ba6W
 bO/w==
X-Gm-Message-State: AFq9FYLtoZ2zzVPcQAOox0fCftTMSm8ffGhuH5aMFQNj2yveDP9QrYyr
 6ZMP/FI2p2GaSkSkCFkL7o6i/bVhAuzB/cUsAzoEs/p7exeenQIUbR3WgzqOQg==
X-Gm-Gg: AYBFou2N43mHnR7CNTSCEtcri9Zq4MLD3iQpN0v88TakeA1NglU9YlchvAGhEYeHofA
 F6snGovZfKika7zc7rqoktSw2CJizv4T93U6raWdDECVrwvy3IZImEImHVZtSv+1WQmlYUWMSEY
 FjHYy9QgBAZ/83uHym9c2Tyb/NFBVO1MbjrfK8JnMeTXvsUnRXYFYzqM5C0LRdTIM5i+d7+gCAv
 6Xy1W35XtzZC+iCfWDq2VmwMnIRyhvsphrnKzfQwqgDAliPV3aFDxNzs2ZQppGXyXG+k5O7AB7j
 YkMue0Ej/9tO1iEL2vIZazmMe5DhPKJchPVKh7ZSwh7MGpVE4mkdpgifGb522Ctgad6pfJA8Ane
 Kw10I5PLZV6pYznCcOl1V9mDnCmDENGE1o9/j1H8dIonb784ELpGj9h8v2ssoRKE6SgtXQbbc5i
 zSH82w8JUDmP8DpZHUtFBQfWuy6Pf+X3na/Ga1xdTTHdE/9nR710bHjrs3d+Cw9xhMIxeFIY+S5
 GsRxZwgyLOu0ktP07LeoZaarVpih7+h3q2FTijaBmPLTvDABnQc3X/DAVFl36qwbW/AA6WS+OVR
 ug7dxiPcVMDpO/OUFnnW
X-Received: by 2002:a17:90b:4a11:b0:3ab:188b:c5bc with SMTP id
 98e67ed59e1d1-3ae896f7fc4mr4714157a91.14.1793480106136; 
 Sat, 31 Oct 2026 13:55:06 -0700 (PDT)
Received: from a1-free ([161.33.196.121]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae87ee7765sm4772952a91.2.2026.10.31.13.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 13:55:05 -0700 (PDT)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/2] linux-user: NULL and zero-length buffer fixes
Date: Sat, 31 Oct 2026 20:54:59 +0000
Message-ID: <20261031205501.1988785-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=takano32@gmail.com; helo=mail-pf1-x42e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

two places where qemu-user answers differently from the kernel for NULL
buffer pointers.  I found them by running the same static binary natively
and under qemu-user and comparing what each call returned.

1/2: getrandom() with a zero-length request.  The kernel never looks at the
buffer, so getrandom(NULL, 0, 0) returns 0; qemu-user locks the buffer first
and fails with EFAULT even though nothing is copied.  read(), write(),
pread64() and pwrite64() already special-case the zero-length request, so do
the same here.

2/2: sysinfo() and getitimer() skip the copy-out when the guest pointer is
zero, so a NULL pointer returns success and leaves the result untouched.
The kernel reports EFAULT for a NULL address, and so should we.  The other
users of the same "if (!is_error(ret) && argN)" idiom in this file guard
results that really are optional (rt_sigaction's old action, the old signal
mask, sendfile's offset, the old rlimit, setitimer's old value), so these
two were the only ones skipping a required copy-out.

Both are covered by a new test, tests/tcg/multiarch/linux/linux-null-buffer.c,
which asserts the kernel behaviour: it fails before the series and passes
after it.  The NULL-pointer cases in the test go through syscall() rather
than the libc wrappers, because some of those wrappers copy the result
through a local object and would follow the NULL pointer themselves; on
32-bit x86 getitimer() is exactly such a case.

Covered so far, with the test built per target and run under the patched
qemu: aarch64 (64-bit LE), x86_64 (64-bit LE), i386 (32-bit LE), s390x
(64-bit BE) and ppc (32-bit BE).  On each of them the test fails against
10.2.1 and passes with the series.

Measured on aarch64 (Ubuntu 26.04, Linux 7.0.0-1013-oracle) with static
binaries:

  call                    native      qemu 10.2.1   with this series
  getrandom(NULL, 0, 0)   0           -1 EFAULT     0
  sysinfo(NULL)           -1 EFAULT   0             -1 EFAULT
  getitimer(REAL, NULL)   -1 EFAULT   0             -1 EFAULT

The ordinary calls (getrandom(buf, n, 0), sysinfo(&si), getitimer(w, &it))
and the flag checking of getrandom() are unaffected.

Reproducers: https://github.com/takano32/qemu-user-null-args

Takano

TAKANO Mitsuhiro (2):
  linux-user: allow a zero-length getrandom with a NULL buffer
  linux-user: report EFAULT for a NULL sysinfo/getitimer buffer

 linux-user/syscall.c                          | 12 +++++++--
 tests/tcg/multiarch/linux/linux-null-buffer.c | 48 +++++++++++++++++++++++++++
 tests/tcg/multiarch/meson.build               |  1 +
 3 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-null-buffer.c

-- 
2.53.0

