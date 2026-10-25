Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA22606A31E
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mJkIDg8e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL7wd-0000EH-Pn; Sun, 25 Oct 2026 19:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicksampanis@gmail.com>)
 id 1xL7Uo-0006iv-NL
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 19:19:22 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nicksampanis@gmail.com>)
 id 1xL7Um-00029o-VP
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 19:19:22 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so1359350f8f.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 16:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792970359; x=1793575159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D5N9H5AoVwh1L/QkWzdub7/LPUX+9TP+O++8lQfedQY=;
 b=mJkIDg8e2eh5BR0CgrpkXusxBDBPa10fFPkxRCJ1FNi32pTlb+2sZax9kLfnnL/DwL
 3svrQFlsBix/gIIhwXbgmOjoqL+ObjJ2V+bxMfmVjLBlidnLUZclnMkmLlBwRvC5aNYM
 n3U2IDnN/CvjqYziHoO5Itqm/LMFGc9sbNYBD++zjrs8FvMiSsIISZU614a1vgwe0EdT
 FVBsSPADj3rKDGihhbGeIgw+sqQbg9F7/P5nwGpgbcUOyWHYPWge/waXhPfePY3nt8eb
 mlpKaGzyuSASOpPJB/Wak4ESxAZwnENTZwCvZn8oI1Ggp/KrS/HRKg9Yxlwr5kDphnNP
 PQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792970359; x=1793575159;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D5N9H5AoVwh1L/QkWzdub7/LPUX+9TP+O++8lQfedQY=;
 b=MHonjsxTf6Rny4oW4vPIxHLD3PTVMrKzTImxj9wNLRN1NNsbyyoEHT0vOEyNIh+15K
 54FxDUZ6VKmEyE23LsSpEWQzeCtqU42AvXnyP14cWeLOKzK/pVfd+fqfn/rD/Z6lpLG5
 QKfpBFUzDiIS2w7MiXeVSzDQuDcv7VUsGJJwFWz0AccBVj8yj2sccKHjXTXzg1UzlTnf
 nZvWAEGdNXnMaVklRqZMQ4kDBJUS0SrTHfNZh7j/XDwmoEm20T5Uy5Z6pSzhRRB0lmY1
 C8lD0B+niFYOBk1V0rPYSaaL2TV0xIDIpWAIA9t/TDB4N9giREA4j3LQ8Ggp6DX/aGRi
 sQRw==
X-Gm-Message-State: AFq9FYKu6GzMHX9P8AtGXuJ8ljhbEgDqcm955EN1OQeD8JCbVK/g5lry
 U9qDq7O203khbbzq03wdmGiR+8MCbpyakg3END+3pMiN3B4Pm700kRpcNcqBtlct
X-Gm-Gg: AYBFou2TpDbDSVj2JfcblqdF7LjTynnCGAd1JyuBuebXzB4mkrzFoZ2SNjEnjK+vioq
 inDiE1WC8juVPgZJfuW80yEvgxcSajIKBbCT9IkHh+Lzu+1BTLbbwlCzcHNEuGAuPnyRarManu0
 v6n9UZDJ/rKWTrF7ddMU+sBpGk+kPgsIYmBtb0p3wtTdEasve5LSNC4lrN8W/TLQYg5G+viNUVo
 aZ3D4xpzVjgdJa7F1t30cTWefuM8wCoF+BdbmF9mE+Avc7t4oY15gsOuleW9FRoIF4FBr/DduMi
 dMO/6bwMmoV3R4irGjdzK1NiC8wg1pVDdG36B1J4rVM8wnCQKvwHtHyxkbuBLDVBKkjoQQwVD8q
 it4R9WgHeQckSNsxpM6hPi50U0sfgm7vrQph22y2DVkNxYBMZUanrVQ/W7WqayMs5q+Vsf0GqMl
 kk9WPM6PNwTXO9mzbm6eCrXR3aBxLaM9rdas3eB2f8QZPxgzwN+Rldgs8je3wYU6dpnIcb7uk0O
 KgbnNFFQ0Smy2mmGZqTEmPb0D4NW/4v7kupzKvmfwixl3RJJyn9HRNGbv9Be43d4P2xBXMenXwM
 Xqu56TzGdC1ATZwwZI1AIUxDpuHi7gM=
X-Received: by 2002:adf:e282:0:b0:48e:c0:9441 with SMTP id
 ffacd0b85a97d-48e3eb93390mr6343009f8f.29.1792970358549; 
 Sun, 25 Oct 2026 16:19:18 -0700 (PDT)
Received: from DESKTOP-ECOGLG7 (ppp079166142084.access.hol.gr. [79.166.142.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdfb8esm12767886f8f.54.2026.10.25.16.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 16:19:17 -0700 (PDT)
From: NickSampanis <nicksampanis@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org,
 NickSampanis <nicksampanis@gmail.com>
Subject: [PATCH v1 0/3] target/i386/tcg: Fix 64-bit RSP truncation in far
 call/return
Date: Mon, 26 Oct 2026 01:18:00 +0200
Message-ID: <20261025231803.870-1-nicksampanis@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=nicksampanis@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Oct 2026 19:48:05 -0400
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Found the bug while debugging a kernel using qemu-tcg where a retf with
a 32-bit operand size executed at an RSP above 4 GiB in long mode, leading
to a triple fault. This led me to investigate the retf handler of
qemu-tcg, and subsequently find two additional bugs in lcall.

This series fixes three distinct cases where 64-bit stack pointers (RSP)
pointing above 4 GiB were incorrectly truncated to 16-bit or 32-bit values
during far control-flow instructions in 64-bit/long mode:

    target/i386/tcg: Fix 64-bit RSP truncation on retf in 64-bit mode
    target/i386/tcg: Fix 64-bit RSP truncation on far call in 64-bit mode
    target/i386/tcg: Fix 64-bit RSP truncation on far call through a call gate

For the first two patches, I used the HF_CS64_MASK flag of env->hflags
based on the similar check in the retf handler that sets the sp_mask to -1.
https://github.com/qemu/qemu/blob/d73149283205/target/i386/tcg/seg_helper.c#L2207

For the third patch (far call through a call gate), patch 3 checks
shift == 2 instead, since the call-gate path increments shift under
EFER.LMA, so shift == 2 for any valid 64-bit gate regardless of the
caller's mode.
https://github.com/qemu/qemu/blob/d73149283205/target/i386/tcg/seg_helper.c#L1834

Proof-of-Concept & Testing:

I wrote a proof of concept for each bug. Each PoC is a 512-byte boot
sector that sets up a basic 4-level long mode page table mapping the
first 2 MiB of memory 1:1, maps a 2 MiB page at the 4 GiB virtual address,
points RSP above 4 GiB, and executes the instruction. The PoC source
files are available on GitHub Gist:

1) 64-bit RSP truncation on retf in 64-bit mode PoC
https://gist.github.com/NickSampanis/3d67093b5b99a5e9627912e2f8f4b297

2) 64-bit RSP truncation on far call in 64-bit mode PoC
https://gist.github.com/NickSampanis/d4dea9948a34fbdedeed91d77586ff05

3) 64-bit RSP truncation on far call through a call gate PoC
https://gist.github.com/NickSampanis/7e9c6a9c994ef67a1aea2b13814be441

Note that these PoCs are not part of the patch series.

Build:
as --64 -o poc.o poc.S
objcopy -O binary -j .text poc.o poc.img

Run:
qemu-system-x86_64 -accel tcg -drive format=raw,file=poc.img -d int,cpu -debugcon stdio -display none -no-reboot

Output Before the Fix:
The truncated stack pop or push reads/writes the wrong address, loading
corrupted values into CS and RIP, which results in a #GP shown in -d int,
followed immediately by a triple fault.

Output After the Fix:
The instruction executes using the full 64-bit RSP without any #GP or triple fault.

Tested on TCG only. This series does not include an in-tree test yet, but
I can add a test to tests/tcg/x86_64/system.

NickSampanis (3):
  target/i386/tcg: Fix 64-bit RSP truncation on retf in 64-bit mode
  target/i386/tcg: Fix 64-bit RSP truncation on far call in 64-bit mode
  target/i386/tcg: Fix 64-bit RSP truncation on far call through a call gate

 target/i386/tcg/seg_helper.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--
2.51.0.windows.2

