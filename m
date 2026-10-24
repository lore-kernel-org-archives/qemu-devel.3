Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7C606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PyTRfgC0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKRM5-0001ct-Cc; Fri, 23 Oct 2026 22:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xKRM4-0001ci-DG
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:19:32 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xKRM2-0002fG-Kx
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 22:19:32 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b0e21048f8so13786277b3.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 19:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792808369; x=1793413169; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qgmcW6feh6+4JtunoJgV/fFVlUE+Vmkw+VyJlp7AH1I=;
 b=PyTRfgC0GVTqmIPbZVF3qip3TwdZflGzprqm2wunAgoGXcTdwUfewCt5NVpoMLOwFM
 mVCz8R1qPABp/I3FhvD1pVvHps2f51ZHFcotybv/ZSlDTHBHQDqCU7kYSxubiIZqIMeg
 mgThG2Uo9Wqe/NLBPoRiCNZuuGCAgj9cltMBNi2P8w8l/vjkK3tN+QSe+lewYVBC8tLb
 7YhHpSjPTbxuRbxZqDAnFB1fHOwgjvMLNa4oeciO4zaHfaLYrfPlDjM6tV3u6qd8NQHx
 XAgfhfh+3+zB27Yqasp6JKUdMMxQQMHtKAlR3Fd9a8b8BrPhpW9LVEetTlnj9X2Dugy6
 hXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792808369; x=1793413169;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qgmcW6feh6+4JtunoJgV/fFVlUE+Vmkw+VyJlp7AH1I=;
 b=ok7kzL1F5hy5DREohJcaOj+HbfD79nPtuDDra69WIZ8bO42A97X3hhKj8HQM6M1rSz
 fce2HTx/+8OO07u1rdgn72as7iqUlugURG5hJk/nAUhNlwxzdX0f4s+79O83JMu7DrFQ
 0H8aSELnnr/QrgXK/9Xz9d22reJeEyN8n++jwIYGuEHUe6u7BpgFbJ+L4rIo01NPvXd8
 KDBRp/Uv8wC8SJmJNUbEkow/8dYYF/fA170kR+Mge2jdA88q0SEPuHLCnWMDgfG3mDXy
 +bb/INVnFW7lLKey97eMZmgh7EYtjKJ7JgeeANkU+FYnm9lzQYb5rGuA9VW/Xn67F6dy
 L+/Q==
X-Gm-Message-State: AFq9FYKF2Elhn2PQvPHn73B+WHf41AU4G9Cbi2LCs4Qk0BP9aWFPyUSq
 cZZbpv6ITrRot/JgRUOlC/lLJUXrIBT2gedLT/puNh7/qn5OxMgXQKFS
X-Gm-Gg: AYBFou0m6kvqD25mLhgdDI1YVxETdHcqXFw6CXhdwn3WXVTz1UlSAeOWClSTHbya9AQ
 7Q8pTQIFFlXBqAqjACD1H++oVZQGfbQjI4R26L8BBWZ0vIvaVEiPGQXIeprS7o02F4RMx3oiJXU
 AZLVYrxFYZFSRttfZ462RjgzzUA9h5Ng8kAptWKN5v/DuBnPg87qxVpcgt24G1cwDis6YKmjGPq
 w9HIE4AjxZId6QmwXjqmClakBxiLUidqrcRM9nYg6axgFIBAcGO6cPd4IpUWPP5dt8dolNAFfZK
 +V++rXU/AZvx69zUYsT8NzGdoiYEQKz4WA9snDJtvVF8PJ3FB+EZLOffOMXT0YxAjNMgkN9XD6C
 iI8itUkEeB6LSQK8eoEVg/Ibwfz53g1DOQ3OHFKoUe5O3R3advYndUndznHfvQJ5EpL7zbjPp3K
 rg9jXnNftx4D9/IvGnFyrHivILuvXAxREl2VFfLEcyvLrsCJGgmpWo8aMv/tvxEXSV7l/4FUXQK
 MfEj+NydeUHA57jbVRqgVUjPFwIEeGyA4zcNWPWudWHiA71i5r847DdLzy0maRHkDF4a8sbKukW
 llCXGEfrNnA/t2eiqFCJAmFCUykjk5j0sORn
X-Received: by 2002:a05:690e:439a:b0:679:c916:46ed with SMTP id
 956f58d0204a3-67a4543777dmr655394d50.65.1792808369244; 
 Fri, 23 Oct 2026 19:19:29 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b166c5d619sm4960817b3.2.2026.10.23.19.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 19:19:28 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v3 0/3] target/alpha: FPCR exception status fixes for
 IEEE-mode code
Date: Fri, 23 Oct 2026 22:19:26 -0400
Message-Id: <20261023-alpha-fpcr-status-s-v3-0-7d11facb8a50@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQ6DIBCG4asY1p0GRsXYVe/RdAEjKIl/AUvaG
 O9edOWi6fL9knlmZcF4ZwK7ZSvzJrrgpjFFfskYdWpsDbgmNUOOUnCBoPq5U2Bn8hAWtbwCBCh
 1SQVWHMkSS5ezN9a9D/XxTN25sEz+czyJYl//e1EAB02VsUo2peT1vR2U6680DWz3Ip4N+dvAZ
 BSVqLUhjjrXZ2Pbti8kWQ2A+gAAAA==
X-Change-ID: 20261012-alpha-fpcr-status-s-5b5c42702cfc
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3379; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=aylVaXRTrMbBfE1356jKJacc9zjM4qRcVPqD4PD/pEo=;
 b=kA0DAAoWrOspdAyaTpcByyZiAGrcFa6gWZtIz9kuTZ+EH4JOT584sLzIgBbasvGYmQM/PW3SC
 ojxBAAWCgCZFiEEXq8hBJqGuKVMyxv6rOspdAyaTpcFAmrcFa4bFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9wZW5wZ3AuZmlmdGhob3J
 zZW1hbi5uZXQ1RUFGMjEwNDlBODZCOEE1NENDQjFCRkFBQ0VCMjk3NDBDOUE0RTk3AAoJEKzrKX
 QMmk6XguQA/11r6BARjSdM5/fSb1nY2U9xJfKihn9Nmql12mRsbklqAQDmkMltpKz6un3112Thv
 hYLOc0THiH0CsBVeBG78wP4Ag==
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1134.google.com
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fixes for the exception status that qemu-alpha reports to code built
with gcc -mieee. I found the last two running glibc's math tests under
linux-user, and the first by comparing against an AlphaServer ES47
(EV7). All three are checked against the ES47 running Linux v7.3 and a
v7.4 merge window kernel.

Patch 1 reports an overflowing CVTTQ/SV as invalid, as the kernel's
software completion does. qemu-alpha reported no FE_* exception
for it.

Patch 2 fixes 471d4930470a, which was meant to record masked exceptions
in the FPCR but had no effect for insns with software completion.
Without it FE_INEXACT is never set for -mieee code.

Patch 3 makes underflow match the hardware for a result that rounds up
to the smallest normal number. Alpha raises no underflow there and
softfloat does.

Tested with linux-user only; system mode is untested.

glibc's math tests (make check subdirs=math) from current glibc
master, built with GCC 17 and run under linux-user:

            PASS  FAIL  XFAIL
  master    1399   110      1
  series    1509     0      1

Nearly all of the failures on master are 'Exception "Inexact" not
set'. The XFAIL is test-float32x-float64-div. On master it fails for
missing inexact; with the series it fails only the four
div_{upward,downward}_double cases that glibc expects to fail on
Alpha.

Patches 1 and 2 update the Alpha float_convd and float_convs
reference files, which were generated from QEMU and encode both bugs.
With the series they match the output of the same binaries on the
ES47. The tcg-alpha-linux-user suite passes with the series.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v3:
- New patch 1: report invalid for an overflowing CVTTQ/SV in
  linux-user, found by comparing against hardware.
- Patches 1 and 2: update tests/tcg/alpha/float_conv{d,s}.ref, which
  encoded the bugs. They now match an ES47.
- Patch 3: update the commit message for Linux commit b74843b38da8,
  which makes math-emu determine tininess after rounding.
- Rerun glibc's math tests against current glibc master.
- Rebase on master.
- Link to v2: https://lore.kernel.org/qemu-devel/20261016-alpha-fpcr-status-s-v2-0-4719bec02b3b@gmail.com

Changes in v2:
- Patch 2: fold the underflow check into soft_to_fpcr_exc, which now
  takes whether the delivered result is normal, instead of adding
  soft_to_fpcr_exc_tiny.
- Patch 2: check float_flag_input_denormal_used for CONFIG_USER_ONLY
  only.
- Link to v1: https://lore.kernel.org/qemu-devel/20261012-alpha-fpcr-status-s-v1-0-bc7efa6d5609@gmail.com

To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

---
Matt Turner (3):
      target/alpha: Report invalid for an overflowing CVTTQ/SV in linux-user
      target/alpha: Record masked exceptions in FPCR for /S insns
      target/alpha: Determine tininess from the delivered result

 target/alpha/fpu_helper.c       |  80 ++--
 tests/tcg/alpha/float_convd.ref | 792 ++++++++++++++++++++--------------------
 tests/tcg/alpha/float_convs.ref | 512 +++++++++++++-------------
 tests/tcg/alpha/test-cvttq.c    |   6 +-
 4 files changed, 714 insertions(+), 676 deletions(-)
---
base-commit: b6c4b7e86dec12d07f5cac65265b986d38ee9002
change-id: 20261012-alpha-fpcr-status-s-5b5c42702cfc

Best regards,
--  
Matt Turner <mattst88@gmail.com>


