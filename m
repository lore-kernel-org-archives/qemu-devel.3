Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920ADC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFjv-0002NN-HI; Thu, 03 Jul 2025 04:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFjs-0002LU-RW; Thu, 03 Jul 2025 04:56:16 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFjr-0007uV-0p; Thu, 03 Jul 2025 04:56:16 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-74b54cead6cso1010563b3a.1; 
 Thu, 03 Jul 2025 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751532972; x=1752137772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hI8YTPlHg5sHRP8fUs3QQqArJTc693eCxmf7qAyWKk4=;
 b=LisymRWfmv1vrLPN8L0ue5ISqKEtxICL6Cm5vXLwNl9O3M1p0jU5svcBtOjaWsgs7a
 c9UwpJgZOJRxkQxCQKIuFaSPvhoaMvmXHbrteuPw7XFjnHrwuF6pElWlIyJhAYXS3+IZ
 DugNLz3DfTSCafLDqkZfs9RfBl5FvAGZj/birGqd5SfTw63vrSOXn8lJ9IepiZp+MKK1
 YtKHALGS8IvklyPuJHR3JPQ1/PGi1FP6jkRDvVfxvOg5XnyCdqNepTXY2kPCXmb4JG4A
 hGjboEQczlK2R6HOZloZCHndeDMu/Csj1gnc+ahFCaC7GAEDGd0mLgMVUtf7MsSQVuUh
 tsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751532972; x=1752137772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hI8YTPlHg5sHRP8fUs3QQqArJTc693eCxmf7qAyWKk4=;
 b=k8iSp7k8RcrqNZRkFzcwnUjpJCx3jDuwrttpUaHWopfjLjF1a2h/zQPTgZtspi04pb
 +gPD0xqQWrHlkhprUjC+EJsCoN5j1OmFAjqhL5EySsoWX0nE+P/92O77+O0PWkPYkEYJ
 Woy28bxrgte1Iv9EWOj6eAiny5hG4FAxmbI68YfBDbWlIA/Wkh3fdmIvNgXhx6Ai9DKN
 KBuEhL/IByqSR25r52ckkWIBOZYxp3arGK2CtLqVJ+OyxowdUyNX+ZakmzCXSpYKiqbC
 VlK5DsifeJ7VJ2o+5nrQnmD3hxd5gbcMffIuUNkLCxgTn1FvR5Cuv2FBouDq6xpdf/oK
 rYEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX92WDCFLeLPHR7Vrv+AlaxJw0ZvJ+A1mX2/jpwtRfNP5Xv8lc70JWci2sitKtN88OcTChwW8+Tzw==@nongnu.org
X-Gm-Message-State: AOJu0Yyk4bwDE9Ev+WlnIGQ7Qj1+DuSvHVHSVdKAnnITvubECOK4pUsS
 kU1fVY5lHsez6O783ZmLXAlaYqApkYjLb7dXCjjhU0Ogkncy8kY+myKmuFnNT5rhNvg=
X-Gm-Gg: ASbGnct3BefRMqlzrn+I5ZoYytjRy0oWTyuqMjKGG16SjxZT7u5okV8qMAA1TkpRCwA
 2QZ+TfRsMI/h7C39XfTXQufCKuWfDxa0e23G2Hv0C4htcFCiRoLJgEXi8WiXuOEdsmTT/fLfNHu
 ANARtmCJxjCz8R9W87/FJ3uNnuQvsB4uWg9HJWcnPUvwp16r7JGHxu9G7SKsOJjqa724Kme75z9
 BQXgXS7/RwWYW93S3LtUDOaD2dpiejFdojIT7s8vzttOwiquUoyjEZfI9LK0biAIGG3qJNcsVBV
 mDb2AihKNKpKtw4MqDbO2HvE7W53LBdRbnFbN7z0CGG4Ei0MNmZ4owNRREFixjWLQheslzeBRii
 K5EiA2hvum4PYG9Q20nmspFZe8mCymkS4/icXaY8WJ5k=
X-Google-Smtp-Source: AGHT+IFyhxNq1rX+PuLJpY7UHISbsTWiuI24+2iGy1E85PqRs9HpAxRBdRvq3X3hB4mW5XggMP/Pvw==
X-Received: by 2002:a05:6a00:1a92:b0:749:156e:f2ff with SMTP id
 d2e1a72fcca58-74cb6886590mr3227162b3a.7.1751532972387; 
 Thu, 03 Jul 2025 01:56:12 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74af541ca0asm16568117b3a.57.2025.07.03.01.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 01:56:11 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v4 00/11] target/arm: Fix M-profile helper loads/stores
 alignment checks
Date: Thu,  3 Jul 2025 18:25:53 +0930
Message-ID: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pf1-x436.google.com
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

Historically, M-profile helper functions in m_helper.c and mve_helper.c
used the unaligned cpu_*_data_ra() routines to perform guest memory
accesses. This meant we had no way to enforce alignment constraints
when executing helper-based loads/stores. With the addition of the
cpu_*_mmu() APIs, we can now combine the current MMU state with MO_ALIGN
flags to build a MemOpIdx that enforces alignment at the helper level.

This patch series:
- Replaces all calls to cpu_ld*_data_ra(), cpu_st*_data_ra()
  in the M-profile helpers (m_helper.c) and the MVE helpers
  (mve_helper.c) with their cpu_*_mmu() equivalents.
- Leaves SME and SVE helper code untouched, as those extensions
  support unaligned accesses by design.

With this change, all M-profile and MVE helper-based loads and stores
will now correctly honor their alignment requirements.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>

William Kosasih (11):
  target/arm: Bring VLSTM/VLLDM helper store/load closer to the ARM
    pseudocode
  target/arm: Fix BLXNS helper store alignment checks
  target/arm: Fix function_return helper load alignment checks
  target/arm: Fix VLDR helper load alignment checks
  target/arm: Fix VSTR helper store alignment checks
  target/arm: Fix VLDR_SG helper load alignment checks
  target/arm: Fix VSTR_SG helper store alignment checks
  target/arm: Fix VLD4 helper load alignment checks
  target/arm: Fix VLD2 helper load alignment checks
  target/arm: Fix VST4 helper store alignment checks
  target/arm: Fix VST2 helper store alignment checks

 target/arm/tcg/m_helper.c   |  33 +++++---
 target/arm/tcg/mve_helper.c | 162 ++++++++++++++++++++++--------------
 2 files changed, 122 insertions(+), 73 deletions(-)

-- 
2.48.1


