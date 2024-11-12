Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE699D41D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 09:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAmwR-0007Vw-E2; Tue, 12 Nov 2024 04:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tAmwQ-0007VY-2D
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:12:06 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1tAmwN-0007iu-W4
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 04:12:05 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e5a62031aso4210328b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 01:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1731402722; x=1732007522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vqambNX6DI5BCSxPHK5MvUw19cTWjsYwDGnVUmByfQc=;
 b=WePHklcQXGMA/YgSbHvW9GcaJPHGz0rnFvsKkmrC4QmevZD1uynvJxu2A4uRyVGwyZ
 nOsyXjfK6QeqORRBSQQ0UDEz1+yNzOQH4eanrZXAUA3r+tAZL7DB66ThoidTFZfh5Qoe
 +QYhbdaFgQT5pnt3iSE2cDrWuAcbgjixnz5PxMeuwXaoqqkxWDWeAXKtnRnsAeT6b4lu
 kVX8tQkUSMQKn/UymZzNO9cn55/1XUamLFkEKMwv9O19nx7xbYNvrePO9tgtqClGfPvF
 JA+yWdDHP7+OgF+HWC6mu6Bb6+OMhkVb7I9G30TZDDShoi410JO5PKSAJFszBCtvLesk
 4loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731402722; x=1732007522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vqambNX6DI5BCSxPHK5MvUw19cTWjsYwDGnVUmByfQc=;
 b=mO+CbiDhUhh1fszGlk5dGgKSdPrrJaF2NhH+/m77ZG8uxzjc2ivUyhY9sfXSqcBOq2
 Vq+O7WigCrCZaNU5jEkVIjXunVbmsuQ+U64AhtXJAwb7YJSdPzTRHeyWXhSWRMyepDo+
 I1nbZgj/o280Ar7h0fLyJi8F/hqVPeVH0QGy++G1PprSIQcKJHJOxgXSlNoMt2o+z/pe
 CgEIhtuLrMaJHYbdbKAlzT2RAkbR3Tt03iKdyKpT/WaNr8RJebcXn66/qoGPQ4FyqKEh
 LZsCgsyje9BljkRMKVrXhQmfqwFfHH3qcx7pkddYnIHezhYhM38HTvaCqqKDR7qBLoBx
 4Njg==
X-Gm-Message-State: AOJu0Yw92iAy/O5d8mpDeBiLwLtg8inU58/i4y5r0E+4AyQt+e2nKSiR
 hezLdP2MBEscpUK2eNkKaIw9gcs+TAqJQDsei+20rW/Xh4t/l4AhkCJnUqsYl6uyAOV1NWgoZHs
 xBHDPP4SDLAgmdJ+PsytOarfpDhL01SaPnfFxUKfn6TlrFtihBXPNLfjNmfFg6Kz2toTlvfMMMX
 FtKZePCz28vORWACaCGdRTJ9SZkFB+B04fko0=
X-Google-Smtp-Source: AGHT+IEFksbq7OEmdsvxiSLECW/2yRDE4SOaAvGbZxEAD66Tt/osQRKFBD2yaQTiIkabBTrxzKlH9g==
X-Received: by 2002:a05:6a20:4304:b0:1db:ec0f:5cf4 with SMTP id
 adf61e73a8af0-1dc22b36db4mr23981562637.39.1731402721686; 
 Tue, 12 Nov 2024 01:12:01 -0800 (PST)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a4f6c96sm13495347a91.2.2024.11.12.01.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 01:12:00 -0800 (PST)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, "Fea.Wang" <fea.wang@sifive.com>
Subject: [PATCH v3 0/5]  Introduce svukte ISA extension
Date: Tue, 12 Nov 2024 17:14:18 +0800
Message-Id: <20241112091423.2529583-1-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x434.google.com
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

The Svukte ISA extension has been approved for fast-track development.
https://lf-riscv.atlassian.net/browse/RVS-2977 
And there are Linux patches for the Svukte that are under review.
https://lore.kernel.org/kvm/20240920-dev-maxh-svukte-rebase-v1-0-7864a88a62bd@sifive.com/T/#mf70fcb22cd2987ad268c0efee9b8583197d3cb4f

Svukte provides a means to make user-mode accesses to supervisor memory
raise page faults in constant time, mitigating attacks that attempt to
discover the supervisor software's address-space layout.

Refer to the draft of svukte extension from:
https://github.com/riscv/riscv-isa-manual/pull/1564

base-commit: 27652f9ca9d831c67dd447346c6ee953669255f0

[v3]
* Fix some typos
* Refine code by separating a function into two dedicated functions.
* Follow the riscv,isa order

[v2]
* Refactor the code

[v1]
* Add svukte extension

Fea.Wang (5):
  target/riscv: Add svukte extension capability variable
  target/riscv: Support senvcfg[UKTE] bit when svukte extension is
    enabled
  target/riscv: Support hstatus[HUKTE] bit when svukte extension is
    enabled
  target/riscv: Check memory access to meet svukte rule
  target/riscv: Expose svukte ISA extension

 target/riscv/cpu.c        |  2 ++
 target/riscv/cpu_bits.h   |  2 ++
 target/riscv/cpu_cfg.h    |  1 +
 target/riscv/cpu_helper.c | 61 +++++++++++++++++++++++++++++++++++++++
 target/riscv/csr.c        |  7 +++++
 5 files changed, 73 insertions(+)

-- 
2.34.1


