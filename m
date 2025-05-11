Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25B4C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDOq-0002QL-Sn; Sun, 11 May 2025 16:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOp-0002LL-8A
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:51 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDOn-0006Jj-FF
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:35:51 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22e5df32197so37833485ad.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995748; x=1747600548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=691a3n/1n2bMm50sP+wvv3PtzYBFBQVmsNkgl8V9vPo=;
 b=CJZEO16lYJE78mBs4lMFm33+cQRf05F+rcuTuVcqstoNT7Am4qjaB5YLB6HlyIsU5U
 AQWUFKOqIM8BXbATgNpb9uuxxC5J58ms72HrFOCZDlCrJlEiieDUnhbhBwY9qFis0Duh
 vTsSfo1HqVfgy0kB3gA0ngdJDXmkdkYyRHy34TZ9qNWLnD6Lh2LBDewjwGO9O7UvJkIa
 +GVsPmNIMeKN92OupYFGwR4qWZD7RZhAYx3bp1E3PmxgdJ4ikdVGzmpOZ//ycCDGqLfJ
 5x51tH6SFbzjAefmNQQRDsqNI+eIUnnT4UMRRPd7ZqD8rU4cz/fHjVl4cUacw0gzaSwh
 C8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995748; x=1747600548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=691a3n/1n2bMm50sP+wvv3PtzYBFBQVmsNkgl8V9vPo=;
 b=LoBdiLISkvEbWaXt3wRQ/4QgD/+BUb2PtSUEAdcZMmYrqnDB2YoaGHMmmkXrb03EpC
 3+9bcnD3xPR1bjHsDg1FFsy6ZaxDRtmGqH7zQxTvFbbelvXIV0wGxki9JePhUjdPKxsf
 uaOmrYEh26Fb5XauaPX9HuQ2lsKVt7pjbP6FhCw4P7fGzd1YBlPL3TK0ph9c0uWQ0VEP
 dba33QxlMCEuyVWG8it7bwHrYDPHUZaYkK++jJE4PkvqXNU9NAaPenNrwulxKV6PRXQg
 FL0QKfLb+tZUT9C9S8AwAKk3CQYEnZte2ZcBb+xMbkeTme9UhtLB/ese9NS/J0ncP+P6
 N27Q==
X-Gm-Message-State: AOJu0Yxajqzec5FLU0LXNHRTAz3+5T5DSft2896ulJccDn4kJ0WIbjgR
 fsIHOZUjs1pmmM3U0AQFK+8lLVSsKdj7wsfzqOAolNWim2+vnDUKRDih7uP7NxSVwWfpsOBqTal
 l
X-Gm-Gg: ASbGncttVwNA+b0drBOpvs6VH6e7XXFiOcVkblh7hMirZx4Hp+yT/2BgfijDFhj0bng
 NYzEgz5j+dvBtm38ycXLqsk8xHj9Q3eEuD+XMAbTK6cvmGsFr/tNtwv9VLxPFxvtjwDVSdSJGdb
 MVgvNMubcY7/E2BrCStrm/OihQGlo19WX4GEJVJLmGmSbl9Y0gISxX8z2zrwWvObGTzwCFxJrbA
 4rHQ+yBY3eGJxSCNWvTo6mvgJzAFkiKu3l7tSOePaWe6MH584tecckCW9GnoSkxWEE4qof1RYgi
 1Wh9BQCJWoUtmzTzlqkx7jId4ARwdwHEX/EkKkNhvMiE/aIAd2OudIxnZVpV4NvQFwSWO4M6kvs
 EBTaTDY7SWw==
X-Google-Smtp-Source: AGHT+IFXgf7jOMRJyb0N1d1ghrz5AiboK8D/myQCBTf0rUtt1zAzdpyO7psV4pge+udr3S66TURxcA==
X-Received: by 2002:a17:902:ea0c:b0:22e:847b:5bbd with SMTP id
 d9443c01a7336-22fc8e9649dmr159373075ad.32.1746995747898; 
 Sun, 11 May 2025 13:35:47 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:35:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	schwab@linux-m68k.org
Subject: [PATCH v6 00/24] target/m68k: fpu improvements
Date: Sun, 11 May 2025 13:35:22 -0700
Message-ID: <20250511203546.139788-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

v3: https://lore.kernel.org/qemu-devel/20240909172823.649837-1-richard.henderson@linaro.org/
v4: https://lore.kernel.org/qemu-devel/20250224171444.440135-1-richard.henderson@linaro.org/
v5: https://lore.kernel.org/qemu-devel/20250507211300.9735-1-richard.henderson@linaro.org/

Changes for v6:
  - Fix packed decimal exponent digit ordering (andreas)
  - Raise OPERR for out-of-bounds kfactor and exponent

Patches needing review:
  03-target-m68k-Keep-FPSR-up-to-date.patch
  05-target-m68k-Update-FPSR-for-FMOVECR.patch
  09-target-m68k-Use-OS_UNSIZED-in-LEA-PEA-JMP.patch
  10-target-m68k-Move-pre-dec-post-inc-to-gen_lea_mode.patch
  11-target-m68k-Split-gen_ea_mode-for-load-store.patch
  21-target-m68k-Implement-packed-decimal-real-loads-a.patch


r~


Richard Henderson (24):
  target/m68k: Add FPSR exception bit defines
  target/m68k: Restore fp rounding mode on vm load
  target/m68k: Keep FPSR up-to-date
  target/m68k: Update FPSR.EXC
  target/m68k: Update FPSR for FMOVECR
  target/m68k: Introduce M68K_FEATURE_FPU_PACKED_DECIMAL
  target/m68k: Merge gen_ea into SRC_EA and DEST_EA
  target/m68k: Use g_assert_not_reached in gen_lea_mode and gen_ea_mode
  target/m68k: Use OS_UNSIZED in LEA, PEA, JMP
  target/m68k: Move pre-dec/post-inc to gen_lea_mode
  target/m68k: Split gen_ea_mode for load/store
  target/m68k: Remove env argument to gen_lea_indexed
  target/m68k: Remove env argument to gen_lea_mode
  target/m68k: Remove env argument to gen_load_mode
  target/m68k: Remove env argument to gen_store_mode
  target/m68k: Remove env argument to gen_ea_mode_fp
  target/m68k: Split gen_ea_mode_fp for load/store
  target/m68k: Move gen_addr_fault into gen_{load,store}_mode_fp
  target/m68k: Merge gen_load_fp, gen_load_mode_fp
  target/m68k: Merge gen_store_fp, gen_store_mode_fp
  target/m68k: Implement packed decimal real loads and stores
  tests/tcg/m68k: Add packed decimal tests
  target/m68k: Make vmstate variables static
  target/m68k: Implement FPIAR

 target/m68k/cpu.h                |   27 +-
 target/m68k/helper.h             |    5 +-
 target/m68k/cpu.c                |   38 +-
 target/m68k/fpu_helper.c         |  336 +-
 target/m68k/gen-floatx80-pow10.c |   33 +
 target/m68k/helper.c             |   18 +-
 target/m68k/translate.c          |  790 +++--
 tests/tcg/m68k/packeddecimal-1.c |   46 +
 tests/tcg/m68k/packeddecimal-2.c |   55 +
 target/m68k/floatx80-pow10.c.inc | 4935 ++++++++++++++++++++++++++++++
 tests/tcg/m68k/Makefile.target   |    4 +-
 11 files changed, 5766 insertions(+), 521 deletions(-)
 create mode 100644 target/m68k/gen-floatx80-pow10.c
 create mode 100644 tests/tcg/m68k/packeddecimal-1.c
 create mode 100644 tests/tcg/m68k/packeddecimal-2.c
 create mode 100644 target/m68k/floatx80-pow10.c.inc

-- 
2.43.0


