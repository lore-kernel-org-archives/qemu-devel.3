Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C762C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 19:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBJlk-00089t-C4; Sun, 26 May 2024 15:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJli-00089P-Mm
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:42:58 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBJlh-0007cC-0c
 for qemu-devel@nongnu.org; Sun, 26 May 2024 15:42:58 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-657a07878easo4409689a12.0
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 12:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716752575; x=1717357375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9SNqljo3EmReP7kE8ervWQw2DryAJUAsy1lq7rpCZJ4=;
 b=UIdtRpJyhacwbP96/+MeMYLG0HkAwNLLO/wzP/qNjXm5ee+1HHRwYHo55wG/Ndm7Z7
 Yq1qxmLt7ftOoGwp3Tkf1wkgJsqHhLRIHLE1DY12EmX+5nlR05B+FGilHK/E7d9DkBj5
 MSSqzQ3lmLRKrk094C/nl2HfsJYALCkRvwm78PWZCyRKFJG06mpDP8AVzEkMsd6b+RKW
 hJ+kp6UJvjKd6tCq0Ah92W4UpRBZiDXTMMQyB0SMq8p2nWzfvdsp/u4vGlYHiPwO1kf3
 F/YZcN/i7JQwESBv/Axq6K+Erq+zAx6RNRfeDPqX1TCGAPEzfz2OS1E6oVqAetdQUgCn
 MWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716752575; x=1717357375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9SNqljo3EmReP7kE8ervWQw2DryAJUAsy1lq7rpCZJ4=;
 b=tgA9Awilf9mXSOJI6bPLmN/bYUHeOTqDDnYpcI/YYedVlFvCqQ56BlQpUQhm7kHWhz
 nkF8M26NeEfttVBqMf2TvlWFP2Jd4KQbFDIs6tJq+clRMF9tSUYS9eZWQlGzZr72KXGE
 VKpwlDblUy/SBqZFUBn4lbuE/Fu4U9erOm8TVT+yLxY130feKmjBsfvPlEHJ8SPVSLcT
 i09lBPwbvLLo81Qoq4EsksKECi7/yjKlDnRTMlPLMumEBuFoLynMgBsEhiLLOiRE4jnM
 s9Ol8X5U202iQTIBbXJ0M146REgTsDxiygMrZmvmgOK24Xcz0+xcFme5r6GIpSMEuVR7
 Xqyw==
X-Gm-Message-State: AOJu0Yw4gxpgVXK+S/E0OCUOfY1eL4ocnURqrkAZHRkHRypjGg6Gcs3z
 Abf+++JGHsxUkirx9V0++uQap6uEU5o1WUjlgz4msBn5GKBr8zXKelElbYiGi0edTlrIKP3U2HU
 v
X-Google-Smtp-Source: AGHT+IE4EYiyaowuah0egb1XtgL+kYwsqS5HSNR6OS6pPF5LVrI0xKJL9u5JMFx1SDoAESHANTGrIQ==
X-Received: by 2002:a17:902:eb85:b0:1f4:698b:7a0b with SMTP id
 d9443c01a7336-1f4698b7cbdmr62507955ad.8.1716752575283; 
 Sun, 26 May 2024 12:42:55 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f46ad93c2esm28165935ad.263.2024.05.26.12.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 12:42:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 00/37] target/sparc: Implement VIS4
Date: Sun, 26 May 2024 12:42:17 -0700
Message-Id: <20240526194254.459395-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now tested with RISU, using a Solaris M8 host as reference.
This exposed a few bugs in the existing VIS1 support as well,
so fix those before anything else.  It also exposed a few bugs
in the implementation of VIS3, so fixes squashed there as well.


r~


Richard Henderson (37):
  target/sparc: Fix ARRAY8
  target/sparc: Rewrite gen_edge
  target/sparc: Fix do_dc
  target/sparc: Fix helper_fmul8ulx16
  target/sparc: Perform DFPREG/QFPREG in decodetree
  target/sparc: Remove gen_dest_fpr_D
  target/sparc: Remove cpu_fpr[]
  target/sparc: Use gvec for VIS1 parallel add/sub
  target/sparc: Implement FMAf extension
  target/sparc: Add feature bits for VIS 3
  target/sparc: Implement ADDXC, ADDXCcc
  target/sparc: Implement CMASK instructions
  target/sparc: Implement FCHKSM16
  target/sparc: Implement FHADD, FHSUB, FNHADD, FNADD, FNMUL
  target/sparc: Implement FLCMP
  target/sparc: Implement FMEAN16
  target/sparc: Implement FPADD64, FPSUB64
  target/sparc: Implement FPADDS, FPSUBS
  target/sparc: Implement FPCMPEQ8, FPCMPNE8, FPCMPULE8, FPCMPUGT8
  target/sparc: Implement FSLL, FSRL, FSRA, FSLAS
  target/sparc: Implement LDXEFSR
  target/sparc: Implement LZCNT
  target/sparc: Implement MOVsTOw, MOVdTOx, MOVwTOs, MOVxTOd
  target/sparc: Implement PDISTN
  target/sparc: Implement UMULXHI
  target/sparc: Implement XMULX
  target/sparc: Enable VIS3 feature bit
  target/sparc: Implement IMA extension
  target/sparc: Add feature bit for VIS4
  target/sparc: Implement FALIGNDATAi
  target/sparc: Implement 8-bit FPADD, FPADDS, and FPADDUS
  target/sparc: Implement VIS4 comparisons
  target/sparc: Implement FPMIN, FPMAX
  target/sparc: Implement SUBXC, SUBXCcc
  target/sparc: Implement MWAIT
  target/sparc: Implement monitor ASIs
  target/sparc: Enable VIS4 feature bit

 target/sparc/asi.h             |   4 +
 target/sparc/helper.h          |  27 +-
 target/sparc/cpu-feature.h.inc |   4 +
 target/sparc/insns.decode      | 338 ++++++++----
 linux-user/elfload.c           |   3 +
 target/sparc/cpu.c             |  12 +
 target/sparc/fop_helper.c      | 136 +++++
 target/sparc/ldst_helper.c     |   4 +
 target/sparc/translate.c       | 938 ++++++++++++++++++++++++++-------
 target/sparc/vis_helper.c      | 392 +++++++++++---
 fpu/softfloat-specialize.c.inc |  31 ++
 11 files changed, 1558 insertions(+), 331 deletions(-)

-- 
2.34.1


