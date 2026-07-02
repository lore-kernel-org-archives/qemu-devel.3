Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F82C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 20:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOFw-0006dy-EJ; Thu, 02 Jul 2026 16:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFo-0006cx-R5
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:26 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOFj-0000Rf-4H
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 16:43:22 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8478a25f268so1664443b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783024996; x=1783629796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vrb/l2sdQcuppdZQK0TuXPMsbsqLE4h8y18QmgQKjaM=;
 b=jFsTZRxF/UWbkzhQ+9cA3yhHZOO2vLAzIu9JxT8eENteKmTuVM5cDXRUf8+Qww7qMS
 1pOBqU5i6g4hqSvLHvUf1wiBKxSCfnVUajq1AG3hvxDVNBF1O4p1R2wRa1pJpx63od+Y
 QoljrqGiYhcldyZkPbTBtFLHr3SKyo5quynKWSTtnki7bf7EbnMzRBFNCpahCR/vTk5w
 KnGB6ebDr6CyyeqCb9aDnEVeOAk7/EAnmuT0wcqridUNjYew9kprDiOJGCzj3ksjNbO3
 pL043ZAb9gcBWGhizsQIaK+x7l1TQ/PAKoeDAS8UhBho9UYVKRnBS/sEH8EtqoSSqskf
 sOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783024996; x=1783629796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrb/l2sdQcuppdZQK0TuXPMsbsqLE4h8y18QmgQKjaM=;
 b=rMKhkb+QK53zUxUhyHjOFzGkQQFmTHu8AqeJH7qyapibE5B7SUb6BCDGmPAA2rpj9j
 GpKt+Vx3t7Rq1cG+3Jr1cJi5RPaABs76k5q/dKIl6ijgqd1GuxMA0N90IjMeIwB0ulZ2
 wVhWzDyQ07mxiZRiDizl+9CQB21+ntM084AJp9SIkKjLQMy0E+hXaGHlPE3n13y4sET0
 xZ4QEvaDnEduCjEouxBlMAWfYNXe8RkperEC9edH8GYXeLEzI8+tgL1CU8yLdEbh6D8X
 VWYXMB6RjfaIkILoAcrrgLdXBZWTAduovafGldWCZ5Idnq9cgmNmKHGvGvhCYh8mwvBB
 q9zA==
X-Gm-Message-State: AOJu0YzjwVqbiYYSAGq59zxAjgA79Z2MxJMBNQjxME9zzH+fT64s8wPX
 pkvWgEq7YliqBgITrRmVqlfvtWVJKn20cZi8rPOWZQbzRyXobw63UqoCi3N/c5C4PsZPaMdTUhd
 Xkgr7
X-Gm-Gg: AfdE7cmGeGfJvwDHYJ8h/yb9QAVDftzTeo9ugxd/9V3kSrlIH4Vci5DB0eic8Yt+5Qv
 Xklq4SE+BhwUEreNgmHx1QNzmngHalCtguzSzqA1Je6dHbkjiO9sH6hVfsOoV6dAQsqL9teC/Nj
 z7nvTlX5JqJeFnLRqZzg1iqws0BiBu9Ci44YCptEjPuoJZuH+jINMubqlk0w3UutuBH90M+LPyr
 +O2Edq7ZYFC3U080Vll3IemHd6wl+5e6WUKz9JoV6wq/UjQ0wkwy9i4jXVFsSEaBjTZ6JbUc0fG
 trwB2a6WHrQ8UtrBpFjTURPXRvsunrQyAkQF40NqLp+4xN6RnJl5D+B0FkgpJD5XYyz3m6EQGjM
 BPOg6sYBupYei/u64/kcu5Wi65TBxMNYwJNZpiramaRRg0orssNxN+odSqbWoxxomD6FhF0srHL
 vSFKWhV+nUYA+wjmYDuYX1PIamvnLicQox59cdDNX2/38xa7OD5w==
X-Received: by 2002:a05:6a00:4091:b0:845:ec1c:71ff with SMTP id
 d2e1a72fcca58-847c51b624dmr6531599b3a.46.1783024996176; 
 Thu, 02 Jul 2026 13:43:16 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e921cd139sm1678941a12.23.2026.07.02.13.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 13:43:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 00/15] target/arm: Implement FEAT_SME_MOP4
Date: Thu,  2 Jul 2026 13:42:59 -0700
Message-ID: <20260702204314.79224-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Changes for v2:
  - Rebased on master,
  - Two typos fixed,
  - All patches reviewed.

r~

Richard Henderson (15):
  target/arm: Implement FMOP4 (non-widening) for float32
  target/arm: Implement FMOP4 (non-widening) for float16
  target/arm: Implement FMOP4 (non-widening) for float64
  target/arm: Implement BFMOP4 (non-widening)
  target/arm: Implement BFMOP4 (widening)
  target/arm: Implement FMOP4 (widening, 2-way fp16 to fp32)
  target/arm: Implement FMOP4 (widening, 4-way fp8 to fp32)
  target/arm: Implement FMOP4A (widening, 2-way, FP8 to FP16)
  target/arm: Implement SMOP4[AS] (2-way)
  target/arm: Implement SMOP4[AS] (4-way)
  target/arm: Implement SUMOP4[AS]
  target/arm: Implement UMOP4[AS] (2-way)
  target/arm: Implement UMOP4[AS] (4-way)
  target/arm: Implement USMOP4[AS]
  target/arm: Enable FEAT_SME_MOP4 for -cpu max

 target/arm/cpu-features.h        |  35 +++
 target/arm/tcg/helper-fp8-defs.h |   3 +
 target/arm/tcg/helper-sme-defs.h |  49 ++++
 target/arm/tcg/translate.h       |   5 +
 target/arm/tcg/vec_internal.h    |   8 +
 linux-user/aarch64/elfload.c     |   1 +
 target/arm/tcg/cpu64.c           |   1 +
 target/arm/tcg/fp8_helper.c      |  32 +++
 target/arm/tcg/sme_helper.c      | 390 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 130 +++++++++++
 docs/system/arm/emulation.rst    |   1 +
 target/arm/tcg/sme.decode        |  45 ++++
 12 files changed, 700 insertions(+)

-- 
2.43.0


