Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F8CCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1EC-0004Ov-B3; Thu, 07 May 2026 12:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1E5-0004LJ-14
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:25 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1E2-0006jw-A9
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:24 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso876860a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169920; x=1778774720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/pMIEjD45r+uC7NB2NGVXIyoDkV8H9qj4g58njDo1YU=;
 b=NhkDk1rHd3TJVu6ZWE4Vcos/xnHMbl9UXxQqfbo+VVIK03keIUeQWBY7SiPdyeNccf
 jzhE4BB2xJ4jo/gmnynXIGpohvhv765btJwvgu++n8m7xMc+Pbh0x/b+s8FlWPFsh1an
 eVjXzojfQADg0ec/BpjcMiPqURii1pJGd8vFFvC8mcNqPNPYZwPtK/HxswGhHg1Tgdlr
 3W76gwMIq5A/1TOhC8VYWhgzqeKNt16CEiL5LvENTjQ35TNKB2YEn5rrcnaDYxPoDfeY
 H229FYADJilXcc58y8+0871G5ZhRrEKpyLhbjLsSVbMN1tchfTSL0FBjIm4baTccnZs1
 tlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169920; x=1778774720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/pMIEjD45r+uC7NB2NGVXIyoDkV8H9qj4g58njDo1YU=;
 b=YnMuoBkMfUATgshO4JkzHOhgocSn+6nip9Uc0v3rS9QkznPgZJF4utTksVxFncXLHB
 2ui+e+toc2wQ3od3Q6p73JRfX2Y2fUfmUjWWK+y1toF/RKB9FFPw33WzMMymKlZfTwUc
 GHkTnb28vhYTSaPu2tPRhZ5l/2G3Ghimb8+BQi6uK6uCceV/dPag6StY6FEAnS+VJ595
 Z+C7Gp3iguspNLRDyehK0iUEFzIUqC2yuUEVd6aID2ONYfkt2ThcwKYGbc5bMPipf4+J
 eeKLHaVeBbUExtYih/oGCsE4FGAEpgvk7FRsz3mNZ67bRE/8jmBphh6zIEK3EcpSXIMs
 As0Q==
X-Gm-Message-State: AOJu0YzhgeV/B5ClvCqVt+9/VlxXZ5tvc+xLiwK1nUzVkB9zzxpprhQC
 fxa+Oi5O6iLkerbSLSqakaw+4RZ148yFbjAAn+FTdBUrCwUEWv4M0qvYFkq8vhiR7qeppDoE8Rh
 o2g1W
X-Gm-Gg: AeBDiesys/YTIEtejNPHw9qzQViI+rFVZVZS/bctecQ8ztSpKpFTe9o6mob3h9n7WGd
 GDKl5zEa4gwAm/Ex9FYkJfmQ8Mq49wHP8pOMXGhkovCZIiIh/pppOaBz6MZuppar6c5LAVpWMlY
 pTezuDqPhNU6pBqlIxGySaximfkXtsikwIyj0FlPRFM4xKwEpvOlxr4BzJvFSmKA1PfB04B2UAz
 tkpf4X3lFcOwD+W/XZ4Zv7GCH9S1w6kE0NbHzkvWvKeGnkU4cqbk3sZngbWGlgg78ahXzcNXZBu
 z6sFr8sG14cSk8beTsM5MroD8XVSwO/iNltpeVmlnQYobi9vDegvvquVupHdr72UoDO5bI5FfvR
 yLn24mLAVqBeKxHeYEqfYQ8lBVhxCaAfSEcFKBaklf2twTte9hKVoQI5OR/3HJ7MebJcsVSp+zG
 kZ2xAcm6k5n9w5FFt6S+n04uAVqhmb485r5d4rF1cVz6Jq+A==
X-Received: by 2002:a05:6830:82b6:b0:7d7:fd71:f2d4 with SMTP id
 46e09a7af769-7e1fcbf5999mr2038203a34.3.1778169920221; 
 Thu, 07 May 2026 09:05:20 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/29] fpu patch queue
Date: Thu,  7 May 2026 11:04:48 -0500
Message-ID: <20260507160518.444797-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

The following changes since commit ee7eb612be8f8886d48c1d0c1f1c65e495138f83:

  Merge tag 'single-binary-20260506' of https://github.com/philmd/qemu into staging (2026-05-06 10:45:02 -0400)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-fpu-20260507

for you to fetch changes up to 901650041334aa9764ee65b300601d0bfad752a2:

  host-utils: Introduce signed saturation primitives (2026-05-07 10:22:25 -0500)

----------------------------------------------------------------
fpu: Cleanups and export FloatParts{64,128} internals,
     so far with a limited number of primitives.
host-utils: Introduce signed saturation primitives

----------------------------------------------------------------
Richard Henderson (29):
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
      fpu: Return struct from parts{64,128}_scalbn
      fpu: Drop QEMU_FLATTEN from muladd routines
      host-utils: Introduce signed saturation primitives

 include/fpu/softfloat-parts.h  | 220 ++++++++++++++++++
 include/qemu/host-utils.h      |  60 +++++
 accel/tcg/tcg-runtime-gvec.c   |  20 +-
 fpu/softfloat.c                | 507 ++++++++++++++++-------------------------
 fpu/softfloat-parts.c.inc      | 282 +++++++++++------------
 fpu/softfloat-specialize.c.inc |  42 ++--
 6 files changed, 640 insertions(+), 491 deletions(-)
 create mode 100644 include/fpu/softfloat-parts.h

