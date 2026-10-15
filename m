Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA45CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 22:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHTlY-0002FD-34; Thu, 15 Oct 2026 18:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aksheynew.tanejanew@gmail.com>)
 id 1xHOqv-0007CO-CJ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:02:51 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aksheynew.tanejanew@gmail.com>)
 id 1xHOqr-0003wk-Oh
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:02:47 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so2550293a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792083764; x=1792688564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KCBVYud+BCap/39mka/WfBNSq3cIbIIjJa+VYeqqZFc=;
 b=DSDU3e2U1BsIrzbMaG/gcBxiNukUOyCCTLwgi/9qLeHidIBA8nuYGlAsFhNsTXSkxX
 FLzV6Xd4YMjkQGppMr2B3KhfyTSAaQ55sRYaZ9ECcpr1373awpAkE2J8UiRCegeCuGUW
 53vJCzr/oNEb9TwPymhsxlfKFBYwiHd+tkpCkDEW4+1jIjQyglu8tlwvQSZImYwka0lA
 aixaT2DXNQ3FfIz/061MWLjoUeX563+EjbUPSIGUb2Q8k3Dqw72B7ulWB/74T1fsv/2H
 E2gA3X1UFLNCERXJB5DdSsxbHfgSVh84qJeHomdcFNUgtfTYRnzXr0KUW2r0qzBauZlJ
 RBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792083764; x=1792688564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KCBVYud+BCap/39mka/WfBNSq3cIbIIjJa+VYeqqZFc=;
 b=rk8KdQcbnjQ1rHGcqpDYE5gItdDHG3C9RxkdWZq5RPoDzTIvp1a/SjT1++EFunAyrT
 UvO4lJ6dzrBIT7kWhlQqZnJLieNs7AWufcnqIMbeDMZHObeLtzbT71fjsyf96XOoRel4
 mBWmT26hO/H4qSF0CIM2RcRrxQQAnmzR+90uNi032ggDCk+XrQY32hBZMRiRrnTxpm3V
 6lnuCMM0wfzL/3HkNK8BfYvF0VerOGvUoSIGW7DORD8mKIHvpchhHtFG+rX9WYi0kvYm
 zFPlNk7r202v3u49NE/dWSKS5NXIU2xcTnmFJo3fW7+n7zpRZz3XzK5kjf4eqyj8AsJj
 3BmQ==
X-Gm-Message-State: AFq9FYJPefB8mlfrjSDFCImtxSEzNpQToFxO51p8pZIi32u70ivL2+Ys
 beLoRhcCZCdtuffLDyVmhixxYeuXzl52YUmB3DRsJIpQkmH2QTn4kKsT88Cjyw==
X-Gm-Gg: AYBFou23qKKIOH2RMLAephxor+vrcxU9ZsdSwgeCSOYZT2LihSfkE48Gsxh9mRSmRha
 INNY+2QkTxrule3FQm+8OnYqiPEDzekBtoiYuKWFYbdm1umBgbeydPJf3cewW36uNovVM9n+bGt
 yLM6fzyv/sulxy/c+AoM92XqV3Dwlu39BoIBX5aoHjzzublxekdIYdP4rzmJmlYEvybGJArBRZg
 ZHNfFZiavW7xBsa4kLNv4G7s09m6mG9rMsxSkg+ND93XbW8dia5kB+9KIjobGY36tvvyxDQurAC
 3wJVldYbipriSjUqnrxBR4+WTCIlfHFODSuFeDEh744Dn8GmQQcJPNLYK4BBWhlwWYyhJ3PCrWg
 JoUFKixn+Q8eQRwFVRT01prw7mCX+oTak18tlNUOM4at6WE1WIj8ESnkaBoCFNFORiLX3svQhPt
 55mpvujc2EBJnwp8v2pENLZpKcLiiE6E/tKii9utzk4KiZ8Xt0Yp+EUTO5mXt56yCFvDU7B96s9
 Q0/B5eSvfZaDEOBxnogyyhlaiUthwJsrmAif2CxHMdLpf5L9zf6CIrKs8pJGnd8FUyDMwwu38ay
 aNJWBujPC0jVv7rILlhEkg==
X-Received: by 2002:a17:90b:590d:b0:3ab:1e1c:8381 with SMTP id
 98e67ed59e1d1-3ab3aaf4709mr14116210a91.45.1792083763620; 
 Thu, 15 Oct 2026 10:02:43 -0700 (PDT)
Received: from STA-DBBJ1B4 (c-73-254-235-207.hsd1.wa.comcast.net.
 [73.254.235.207]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9474b52fsm5893712a91.9.2026.10.15.10.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 10:02:43 -0700 (PDT)
From: Akshey Taneja <aksheynew.tanejanew@gmail.com>
To: qemu-devel@nongnu.org
Cc: Akshey Taneja <aksheynew.tanejanew@gmail.com>
Subject: [PATCH 0/2] whpx: i386: fix accel init/hang on legacy Windows (build
 17763)
Date: Thu, 15 Oct 2026 10:02:14 -0700
Message-ID: <20261015170216.6895-1-aksheynew.tanejanew@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=aksheynew.tanejanew@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 15 Oct 2026 18:17:31 -0400
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

Two WHPX capability/property queries were added without a legacy-OS=0D
guard and break "-accel whpx" on Windows 10 (build 17763):=0D
=0D
 1. WHvCapabilityCodeProcessorFeaturesBanks -> WHV_E_UNKNOWN_CAPABILITY=0D
    (hr=3D0x80370300). whpx_accel_init() aborts with a misleading -ENOSPC=0D
    ("No space left on device") instead of starting.=0D
 2. WHvPartitionPropertyCodeX64MsrExitBitmap -> WHV_E_UNKNOWN_PROPERTY=0D
    (hr=3D0x80370302). Even made non-fatal, leaving x2APIC enabled with no=
=0D
    MSR exits hangs the guest black-screen right after firmware=0D
    hand-off, since x2APIC is MSR-based.=0D
=0D
Both capabilities are Server 2022 (build 20348)+ only. No shipped=0D
release checked (8.1 through 11.1.1, including git master as of=0D
2026-10-15) has a fix for both at once.=0D
=0D
Patch 1 gates the banked capability/property query on=0D
whpx_is_legacy_os(), falling back to the original single-bank=0D
WHvCapabilityCodeProcessorFeatures query -- this restores the=0D
pre-8b87283ce4 behaviour on legacy hosts, same pattern already used for=0D
the perfmon capability in 68438cb3cb.=0D
=0D
Patch 2 records whether the MSR exit bitmap property was accepted and,=0D
when it is not, applies x2apic=3Doff so the guest falls back to MMIO=0D
based xAPIC, which is still intercepted without MSR exits.=0D
=0D
Verified end-to-end on real hardware (Windows 10 Enterprise LTSC=0D
17763, Intel i7-6700, non-admin build via MSYS2 UCRT64): WHPX=0D
accelerated boot to desktop in ~65s vs. ~600s under TCG, combined with=0D
"-machine q35,pic=3Doff" (a runtime flag, not part of this series) to=0D
route around a separate PIC->APIC handover issue on this OS build.=0D
=0D
Akshey Taneja (2):=0D
  whpx: i386: do not require ProcessorFeaturesBanks on legacy Windows=0D
  whpx: i386: fall back to xAPIC when the MSR exit bitmap is unavailable=0D
=0D
 target/i386/whpx/whpx-all.c | 94 ++++++++++++++++++++++++++++---------=0D
 1 file changed, 73 insertions(+), 21 deletions(-)=0D
=0D
-- =0D
2.50.1.windows.1=0D

