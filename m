Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1624606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lYlUEw2l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNAWx-00013J-0H; Sat, 31 Oct 2026 10:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xNAR8-0008O8-5H
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 10:52:03 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dovankhai97@gmail.com>)
 id 1xNAR5-0006YP-Nd
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 10:52:01 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-3514b90bb89so3218819eec.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793458313; x=1794063113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L7ochma7yIOUoWS70+D40B5SHG6wByT/y6Iu6Vp3fks=;
 b=lYlUEw2looVlrrwI7L3Z+ToDmAtnkPjH74d1U8WSX/bCAIAds1hBw2iOwHSOCUauy2
 pSodhK4BrMZ1WvSO9CH2/Ru9URJZ+re9Hno6lzzWg8zdo9pEjAEsk0foUsG09+lbzFc2
 dgFFiMlJ960tgiL+spsiryuLtnTvbFw0vemxp03Hs/k7i1wUf1xne7cYtWLXV8Fq6BLW
 6aHqHkleboj4E7JznJeOnqB/enwhLG5yzt7o0C25nbDeUYwlA1Nt93b2Ut4iUxZhdLRR
 hdD5f4PbWHClz5QkdUCFnpjYb2MFfQCGRs7b50MJ4k92iVSOwDPgODeya1Dq1PlsuOEt
 MNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793458313; x=1794063113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L7ochma7yIOUoWS70+D40B5SHG6wByT/y6Iu6Vp3fks=;
 b=0asvfXHCnJFVTF221dU1ecUjXGKkajqsjcg7EzyiGdf48WCe/ZF84J26uLfFVxBqSk
 FH37D2DHTJj1IfOfdI6dsa2StwkMeG3FAOW7s/1eCRS8JHc+KiMTekZG5xU9b/T2XLzo
 lMTTBLW0ehc8THMLW44V1hLVbAeXtvgft9GOvdhDT1RGfEhlRAk5lnM5fM6M/aDlRR01
 1SLjW3jBC2WrXLzN0IeGcJE+W1aGRRiQHnRtr/D9mqX/TD+86F1D/Ow32J0bSj76fQWi
 cEnXeV/ZfH+Mbod+n0z2qenetfIpT57Nm+VLjXF3kY0ziG7a4In4XZFvuC6ybi9xFPTv
 nZRQ==
X-Gm-Message-State: AFq9FYI0ja9OTJHGZPzJ08xALWc4I+lS9vHL4pLxZmcXlBc4vLi1Qa6p
 68MkxPqFzGmdMzWvzSrlen18O+Xm1WZZ6EI3eZdb+wI3vtPS3woeuOSGl8J73brx
X-Gm-Gg: AYBFou34qV7gRuYLUxK5yGenva7EQjxoTOTsjkbROTZu6OWph/BT68Pl1F7GiquKt20
 faiJiniUO0+NMVg9s2RDgRtsdDWfJNXvNayVQo1SKGYImpUPsAVWU75sRs8/6RSflfYfkuy0LUW
 cIHm/TNlV34y+ODUQtKPqebPOG948J+3ERMw2EfhFqM1UPvTIKhFB1Fosa67mn5GgpvHpxpxb6v
 aJEpECJxJ0rLnKjSEraUTOzD0P2wcjm9ks5mMsOPm0dIIz9npx2PJ8GVqOe3Y7U78xUqX6ctukk
 ds+K+zmtKuQVWyptObbFBM8qEFVGCTBDL/hz6NShDBfuqyQByCYVabw41by7fHn3IlIBKMIDudy
 zmFIQiVMqBlX4TLwYxKME0Vs+p4UN3VIRnSCJqwbupmf23oLaEwGSEbPMzk4OQvRsAJZc/Tr3S6
 RHEeqkhpdxytFk7OzHZr3AeYSNPaLMx3O9dZnkKtgh3BQY5ZkTqr1+sBvRMWgXXBoJxjtu2HS3h
 pdQtV03Zc44kQxKnC9o6fzKH0EsX/h3Nc7JHBdTwEXMGTKVSvYEj4Q4tr2L9/ktfMKzoTwrX/Wm
 C2rEhxCqxww2d02yRYtfRsj9ESE6MOJX
X-Received: by 2002:a05:693c:2805:b0:36a:4009:58f with SMTP id
 5a478bee46e88-36a423e5474mr7640678eec.22.1793458313403; 
 Sat, 31 Oct 2026 07:51:53 -0700 (PDT)
Received: from ubuntu.lan ([2405:4802:913e:86f0:fc32:76b2:b6d6:a3f6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428c17bdsm17541006eec.6.2026.10.31.07.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 07:51:53 -0700 (PDT)
From: Khai Do <dovankhai97@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 strahinja.p.jankovic@gmail.com, Khai Do <dovankhai97@gmail.com>
Subject: [PATCH 0/5] hw/arm: Add Allwinner H618 SoC and Orange Pi Zero 2W
 machine
Date: Sat, 31 Oct 2026 21:51:42 +0700
Message-ID: <20261031145147.32683-1-dovankhai97@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=dovankhai97@gmail.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 31 Oct 2026 10:57:53 -0400
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series adds emulation support for the Allwinner H618 SoC and
the Orange Pi Zero 2W single-board computer (SBC).

The Allwinner H618 is a quad-core 64-bit ARM Cortex-A53 SoC. This series
follows the incremental skeleton design established for Allwinner SoCs:
- Patch 1: Introduces the basic H618 SoC model with 4x Cortex-A53 cores,
  GICv2, ARM Generic Timer PPIs, UART0/1, SRAM A1/A2, and stubbed unimp MMIO.
- Patch 2: Adds the Orange Pi Zero 2W machine with 1 GiB SDRAM and kernel loader.
- Patch 3: Separates the ALLWINNER_SID Kconfig symbol so other SoCs can reuse it.
- Patch 4: Extends the Allwinner SID eFuse controller to support configurable
  capacity up to 512 bytes (required by H618), preserving backward compatibility.
- Patch 5: Connects the SID controller into the H618 SoC and sets the default UID.

Verification:
- The series has been tested using Zephyr RTOS (v4.5) running on the
  orangepi-zero2w target, verifying UART0 output, multi-threading with
  ARM Generic Timer (k_msleep), HWINFO UID reading, and SID OTP (512B capacity).
- All patches pass ./scripts/checkpatch.pl with 0 errors and 0 warnings.


Khai Do (5):
  hw/arm/allwinner-h618: Add Allwinner H618 SoC emulation
  hw/arm/orangepi-zero2w: Add Orange Pi Zero 2W machine
  hw/misc/allwinner-sid: Separate ALLWINNER_SID config symbol
  hw/misc/allwinner-sid: Support configurable eFuse capacity up to 512
    bytes
  hw/arm/allwinner-h618: Connect Allwinner SID controller

 MAINTAINERS                     |   8 ++
 hw/arm/Kconfig                  |   9 ++
 hw/arm/allwinner-h618.c         | 233 ++++++++++++++++++++++++++++++++
 hw/arm/meson.build              |   1 +
 hw/arm/orangepi-zero2w.c        |  85 ++++++++++++
 hw/misc/Kconfig                 |   3 +
 hw/misc/allwinner-sid.c         |   8 +-
 hw/misc/meson.build             |   2 +-
 include/hw/arm/allwinner-h618.h |  60 ++++++++
 include/hw/misc/allwinner-sid.h |   8 ++
 10 files changed, 415 insertions(+), 2 deletions(-)
 create mode 100644 hw/arm/allwinner-h618.c
 create mode 100644 hw/arm/orangepi-zero2w.c
 create mode 100644 include/hw/arm/allwinner-h618.h

-- 
2.43.0


