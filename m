Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2491DD111A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 02:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOo8e-0005q0-0Y; Thu, 27 Nov 2025 21:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vOo8c-0005pf-ET
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 21:23:10 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vOo8b-0001JW-43
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 21:23:10 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-298144fb9bcso13549235ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 18:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1764296587; x=1764901387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4+TpiL6AFW1GoE/6g5xCLDuJ1UaSt7c5u6j1UmTSPrM=;
 b=RAPnNH8HQm+FGu83lmb5zAN5yQMquncYX/f4v/c85ZZ5WlOhpxhYxRUa6ALUKFdt9x
 99Pzt36CY5HEKt3dkxJP4+pYPJbqgp3qZIiqgna6KcfQr1lx4ldAvN6DK7Xl5niRXvk4
 PmjoG1GmLLVusxPrUCRVx9iWYFPic70T0hf0n7OJesGgZ0me3fhwjVi5cgkIVHYJZhVo
 BVrsGAnDFuA6VFcCOCJtcA/6PPtZzrXk4U8tTzb2xq6D+XTlZaCNXM1C0ijhfpbhVY46
 I6WHoRO6rjq3emkRiLJhhmHcJm/ZyLtYRMkikaLS1fSGG9bFQZrTCTtL3FOH90F6ShpM
 Ry0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764296587; x=1764901387;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+TpiL6AFW1GoE/6g5xCLDuJ1UaSt7c5u6j1UmTSPrM=;
 b=Kzpu70P7Ob9e/lMDmxmY2O3mbO3VUExmGTrfCUlypit3KNXKgh3SAhkRC20yPe19xq
 zYQguJxmOpIOvL6F58EhaIRX9tHGYvlOLbHjEQj8nVd9sUEK3E6G9WxWnjEDGtxyw2rz
 xsmdhoCTALVH5zfkKu5FaBBNg5zjtUNCnf4wunkWkk+iMFBb4Ll5U/egOrsW78+x0m+P
 mRDnNfp94W4+VB3dhytecVUCRJat7v3eEINoXepjivTj5jpZyz/TNK9zbDthFZmYX8+R
 wSyInDRT1iQQq3CLuOXIb9bMt06g5ZwrJL0sPUifQ8MrEWElmaiqEQKnVdnSh7sZjfsD
 qT1w==
X-Gm-Message-State: AOJu0YwLXCuZZx+bi1R2G3fup+A210GifwMQyDa8Lg/yyOaWzmbHjl2q
 TpSjw0CO15h2eiUdFclXiY+Sy/DlnB8SABV3wF8ipB+Ph3rfVDYifg8J5FO6oapcOMgyHGJCbK/
 mGVwm+zS3osO7auGHm6N+KH+JFohM1QXByZIgLxEMHfC8iXizPz4bwBn6QDo2uogFueZsaZWSeD
 mCCtVE+q522XVZ8zEt5KIbyQv9flE5dWpA+5Bh+nl9uaJ2bA==
X-Gm-Gg: ASbGncviOwcgHfDCUnvH71BQqBoajdrCGa2apyYymjWxATWOJBfu4aAeb+S7aIa02Xb
 16qZoxtKMGmxvP1ksw3a3HL0/46ifiD5/uw27W26GrTFZGSQlYkjMtE/ZcLhNo65xnA+IEFg2U9
 XWLNjfR4w4k/55WuDP2sn4rkFwb1Ff13b6jHIF6aKsSGC30FtFsAsp+dgw4G4HwgZV2lGcDjZVd
 jWgxwloKtR7qYvzMU3q6/76rFX1a98XOHeMHTceqJUoIp41jd7LX6myyL9BNihMYyDXep87zWm8
 p4Mcp2n64/RmZwBSnUXlnBcvcvN1Rt7ipRLKOigP5c3XnjvKYSmkQGPa7SnTxRgKRhEeX/oVDfc
 yg21oF3VOxwSfTwDnXrlPsK/OdD2xz7K9glEI9QM6gPlA69AZ4LKFVBjn8lpAa2Qi6EWrO7iOHM
 5h/FC66zO5Gw1Yqd29oVcEqj7Dl9oP+Nk2zTzmYA==
X-Google-Smtp-Source: AGHT+IFzAaJnOvairTkQV2bR1qUeSlC04FxcVqpkkRKlAvj2P+Q/FHQcHZ77H7jKX84Cign1Gajz8Q==
X-Received: by 2002:a17:903:2ca:b0:297:e231:f410 with SMTP id
 d9443c01a7336-29baae65be1mr126146175ad.13.1764296586873; 
 Thu, 27 Nov 2025 18:23:06 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bce4418c4sm28652845ad.24.2025.11.27.18.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 18:23:06 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 0/2] Set MISA.[C|X] based on the selected extensions
Date: Fri, 28 Nov 2025 10:22:59 +0800
Message-ID: <20251128022302.970294-1-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

MISA.C and MISA.X should be set when the following extensions are
selected:

MISA.C:
  * Zca and not F.
  * Zca, Zcf and F (but not D) is specified (RV32 only).
  * Zca, Zcf and Zcd if D is specified (RV32 only).
  * Zca, Zcd if D is specified (RV64 only)

MISA.X:
  * When there are any non-standard extensions enabled.

This patchset sets MISA.[C|X] bits based on the selected extensions.

Changelog:

  * v2: Fix the missing parentheses bug.

Frank Chang (2):
  target/riscv: Update MISA.C for Zc* extensions
  target/riscv: Update MISA.X for non-standard extensions

 target/riscv/cpu.h         |  1 +
 target/riscv/tcg/tcg-cpu.c | 47 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

--
2.43.0


