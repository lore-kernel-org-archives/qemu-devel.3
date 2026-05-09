Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFE3CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 15:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLk1x-0002rX-DD; Sat, 09 May 2026 11:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLk1v-0002qq-2R
 for qemu-devel@nongnu.org; Sat, 09 May 2026 11:55:51 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLk1s-00067c-HN
 for qemu-devel@nongnu.org; Sat, 09 May 2026 11:55:50 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4645dde00a7so3458358b6e.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778342147; x=1778946947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=UIe1TwzzmtnhaTKxmUPSPKa1uj6sqPU9ENCN7VBJksA=;
 b=L6aGssrlz2zfKX2atmvXqKLYimCfn7yj0t6f/EQ61gEf8InGxC79bm2McGcUIe6F66
 mvLwkHiEOUxG0jstL6rf0piURVyPNzxKE8M+AHJQk4UMtLmA/GaE+fto6Cjx0FB7FDUI
 z8le58qgTe7L9mfHbTUv0/VXecRcXwocqZKfSY/b/E9j9cnRutdccW8l3I5Hk/58iORJ
 aKDiYV7lAoRo87Ga82Bm1UJHJPYFZPnKmj4mpKn7q1LHw2U6bSTh/rSxFOdYST5bkf0s
 LBB2Ndo0qjyHCC/JhN10qBR1sHKJZ7u96JIG+NfWK1+sb69KzvIcCOX+ycGI92I09Ndf
 w69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778342147; x=1778946947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UIe1TwzzmtnhaTKxmUPSPKa1uj6sqPU9ENCN7VBJksA=;
 b=FZTu7X2bYa+Nn6+m5PvI4TvXArEHOkS9cqxykzIFpWf6z6Y7u96MCGY+udGS0Hw9+T
 kbVycmbttLZlJmcj+3w6SzNI1RVKoPWrUnseXCAqTuHT7wUd8Mdl4oysr0wWPLzkjdlU
 vYFVOtoZigb/XuhbLrL/69WgZqbcR47HSCsHjz09Xudc9CGDV7Ec2V+pwKzB3C++SVYd
 00nvEcnNLWWt8KCJodhHCnmILfrgqRyDcg4b+CFOVKeO7THVtxEORFAC2HPVxbroI9W2
 rBTYeD0Jg/P/Kevf8kzH/ukby0Mea7jiWbN/lYa1fay2JrFH1SH0r1FZ54x4jY8/sw6n
 eW9Q==
X-Gm-Message-State: AOJu0Yw+qu483Cr46G+XXFCc+N5n0K3358bRnzZrqWjUDf9zUQFO1enc
 s1K5i+EdZGfzciLBmXfZpZbHtBX9YcPOpwwsAbz/5EuqSmeBk8PAosyZYylN08yq1Vwuyd4WR0b
 BHv/K
X-Gm-Gg: Acq92OHXskkCtQFlwcDQ+9uttcQOevxSQJT2pHVkvFUcLNZUggkL0TJfQyo5oTuH56p
 f6ttuNiCHYUkAMLfGbBpLASclWAr0ph3mRE7orlsKlzj9Lj2k7pTr6orgXckFFHfvg3FHa103EB
 uuowWyvKw6M/k2AWAVDv1noWg/nOdS/bZZzpJO2bkboxw9xzoBjHxhCzsAxUR+erCRnDlb0hWdZ
 Oswpn2BX3jTClnvhEPfc8lAjl+PPWyhOo6Fa3Irk/yh/dACrWdBlJ6cSefUsoO9wP/SgxIzsJEC
 CjFp/1CRcIXOSjy9BSY7SjPjzsMB5XqrZ6aYIu68jo+q1gFdJmpP2tEeUZD0iAhAkuGdGVfeRHx
 CwhksnGUSZXx1E0Tsz04KQsrjod3EgLKYFREf7sQtDnXgzsUIDpIG0yVJN2uYoSa+UNgc+kJc/J
 gdboBO03U4op2kfZyFx+koZIc/45n4o7DQqBM4eHiUCThZy7OS6XxA3idDxvLR26R2kxw=
X-Received: by 2002:a05:6808:1442:b0:450:b249:71bb with SMTP id
 5614622812f47-48061c39bdbmr6392923b6e.19.1778342146999; 
 Sat, 09 May 2026 08:55:46 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:88d3:58e4:a68b:b30c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367a18481sm3278310a34.0.2026.05.09.08.55.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 08:55:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/28] fpu patch queue
Date: Sat,  9 May 2026 10:55:44 -0500
Message-ID: <20260509155544.848204-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

v2: Drop "Return struct from parts{64,128}_scalbn".
I have a fix, but I'll include with the next patch set.


r~


The following changes since commit ee7eb612be8f8886d48c1d0c1f1c65e495138f83:

  Merge tag 'single-binary-20260506' of https://github.com/philmd/qemu into staging (2026-05-06 10:45:02 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-fpu-20260509

for you to fetch changes up to 16495533131af2eb94019e32c72688ea5e1b2742:

  host-utils: Introduce signed saturation primitives (2026-05-09 10:50:01 -0500)

----------------------------------------------------------------
fpu: Cleanups and export FloatParts{64,128} internals,
     so far with a limited number of primitives.
host-utils: Introduce signed saturation primitives

----------------------------------------------------------------
Richard Henderson (28):
      fpu: Inline float8_e4m3_pack_raw to single caller
      fpu: Inline float8_e5m2_pack_raw into single caller
      fpu: Inline float16_pack_raw into callers
      fpu: Inline bfloat16_pack_raw into callers
      fpu: Inline float32_pack_raw into callers
      fpu: Inline float64_pack_raw into callers
      fpu: Mark unpack_raw64 QEMU_ALWAYS_INLINE
      fpu: Mark pack_raw64 QEMU_ALWAYS_INLINE
      fpu: Split FloatParts{64,128} to softfloat-parts.h
      fpu: Export FloatFmt structures
      fpu: Export unpack_canonical and round_pack_canonical routines
      fpu: Return struct from parts{64,128}_default_nan
      fpu: Return struct from parts{64,128}_silence_nan
      fpu: Return struct from parts{64,128}_return_nan
      fpu: Sink exp_bias adjustment in float64r32_pack_raw
      fpu: Return struct from parts{64,128}_pick_nan
      fpu: Return struct from parts{64,128}_div
      fpu: Return struct from parts{64,128}_round_to_int
      fpu: Export default_nan, pick_nan, return_nan routines
      fpu: Introduce parts64_round_to_fmt
      fpu: Return struct from parts{64,128}_pick_nan_muladd
      fpu: Introduce record_denormals_used
      fpu: Split scalbn from partsN(muladd_scalbn)
      fpu: Export parts{64,128}_compare
      fpu: Return struct from parts{64,128}_mul
      fpu: Return struct from parts{64,128}_addsub
      fpu: Drop QEMU_FLATTEN from muladd routines
      host-utils: Introduce signed saturation primitives

 include/fpu/softfloat-parts.h  | 217 ++++++++++++++++++
 include/qemu/host-utils.h      |  60 +++++
 accel/tcg/tcg-runtime-gvec.c   |  20 +-
 fpu/softfloat.c                | 507 ++++++++++++++++-------------------------
 fpu/softfloat-parts.c.inc      | 270 ++++++++++------------
 fpu/softfloat-specialize.c.inc |  42 ++--
 6 files changed, 630 insertions(+), 486 deletions(-)
 create mode 100644 include/fpu/softfloat-parts.h

