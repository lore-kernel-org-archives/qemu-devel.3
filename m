Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68390606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m6Cmys0L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJWlW-0006yw-6H; Wed, 21 Oct 2026 09:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJWlD-0006xg-I9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:53:51 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJWlB-0007dX-O6
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 09:53:43 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ea138a3497so4648925ad.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792590819; x=1793195619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CWZ1vo+SwdlHXeVTHPjZ962eIPh08Q3C16lAAUbnpT0=;
 b=m6Cmys0LTkBDf3w1rQUdjpoDoG3v6TToQK0bmEyh2tOSkVUIoEqOK/qjoOvUVg5Gad
 C5DDz8jPebK7m6aNevpGitoTN9UUQF2Xorq729tNvX9N0/bYGLzmhqO6s5Df0iU1B/VD
 mYUXQdxCZTfX7Ms0yZmsVRvUQw405ByEl/Yjy8kl/okLbwdnuHc8/1gGnappQGf4ilKG
 yK1vsmTNjn2L0HKKEj8JhNEmvMkNTXXCKGZhL0UvgsSTgEp+5n3QZ4KWuIKg5EouHQLK
 0rB2ML5iVSOGnOGdGPqL/ALuniCNCSQVPMy9mbU3esz95GZX+SsmermQGR+UNeSPqeVE
 KbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792590819; x=1793195619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CWZ1vo+SwdlHXeVTHPjZ962eIPh08Q3C16lAAUbnpT0=;
 b=ixcJos1pXEzEKaXT4JBBWs3OXFnP1wNG9DKjYpgSHDbJS752sLsBPv/x8+39B6HAHG
 1Ew2KFyi/H+2UKkr/4M+ePSpx12cDWm+w3bHzjU0IZeqaVTyyO2Gv7W+lTBvFm8WoDpS
 wrSEv2gsMZ7gKmHCrD8iaNs6sNoJL0aA3JZM6ZPwwbQdiy/RQQDtQ3Wz8rEbmAQ83dmE
 psDaSr/2dHRlHEdYCIa1mAdV5WXY4/4Doa9L2JmTuBHf7k4Rng0vdblxl978NVG1tPUL
 f6aUVXa35/R3uEC2yiEww92gKrRCwQlpxu/oJTpmB8+pCbKezmHyaT8JmCcjPNlArkEB
 y64g==
X-Gm-Message-State: AFq9FYI/Y5rTayU9oVk1f5u1PQUcbVghbbUI7755B2bM9UeVEBENelU/
 pRbaiu2zRGNNjz2b5yWlqK3VVweUIYkBvKKdaZmicX/2nTy66Kv3K5NZieAd1JuCVfqxIQVa
X-Gm-Gg: AYBFou1axjKJLmMZ1ssbu9noua2+N8Z60dNw4236lhQXqLllztnEMSA+9W1XV/qiUJc
 sQL3LgbbK9Aj9QJcbE6KB5o4Hf7sO5EMlnEOtcXB/uGyX/asrjPP8ZxnHxD9+lUfTq9qQFj239F
 w8NurPgo2ff2R4C1u5bUxT2IcqSKUNAUva+eBurLcEnqA3ZsHP/MFnFi727jYqE6R/KdO3RWJk6
 vgLSqRyu2nhksDVmgb6+5iGM8KmGiw+AVbrDNcPoptK1puZ0gUWR1grNgFXMKt1yb2fYvShAxnk
 cV0Ie4W7ylVWljF5WmCvEy2+LIV5LK7TrGc9Og8cNRARoqBPFrG9MyisBUQdkL6rRaHPzBEsYag
 H/ci3VNIB3qRGcLhuUuDAFcVW81Vg9YiqN2hocKlmrUwvgvTV5VISWRwPTD9salcFpM0cm8q/jp
 osX0/0wp4m7aa8ZjWVwLkicAI6zogEKWGHm6jnoIPjIeydEoss06lHejxU9oY3/6ZuzMHTXFLUU
 GxfBfdUG5wBY3XB24rijQ7wS4is1d2sHUXzbW5TWJx8k/NYcyat+bPlG7BhTM4NKcmLD72/aipw
 QP0J3Z0=
X-Received: by 2002:a17:903:2f89:b0:2e5:54c6:e5c9 with SMTP id
 d9443c01a7336-2ea437b4bf8mr17173345ad.2.1792590818840; 
 Wed, 21 Oct 2026 06:53:38 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b49caa7sm11865135ad.69.2026.10.21.06.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 06:53:38 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pillow <waysorrypub@gmail.com>
Subject: [PATCH v3 0/3] hw/loongarch/virt: Fix UART ACPI description and
 update DSDT blobs
Date: Wed, 21 Oct 2026 21:53:19 +0800
Message-ID: <20261021135322.473781-1-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=waysorrypub@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The LoongArch virt UART ACPI description currently carries a _DSD clock
property with a typo ("clock-frenquency"), a reversed key/value order,
and a declared 100 MHz that does not match the QEMU model. The _DSD
contains nothing but this clock property, so the whole object is
dropped.

The Linux PNP serial driver uses uartclk = 1843200 Hz by default and
the QEMU UART uses baudbase = 115200, i.e. uartclk / 16 = baudbase,
so the Linux default clock already matches the model. QEMU's x86 ISA
serial ACPI description also provides no clock property, which is
consistent with this change.

Two further cleanups are folded into the same patch: _CCA is dropped
because the emulated UART does not support DMA, and _STA = 0x0f is
added to indicate the device is present, enabled, should be shown and
functioning properly.

Patch 1 allows the LoongArch DSDT.* diffs in bios-tables-test, patch 2
makes the ACPI change, and patch 3 refreshes the expected DSDT blobs.

Testing: ran bios-tables-test with the updated blobs; no unexpected
diffs remain.

pillow (3):
  bios-tables-test-allowed-diff.h: Allow LoongArch DSDT.*
  hw/loongarch/virt: Drop UART _DSD/_CCA and add _STA
  tests/data/acpi/loongarch64: Update expected DSDT.*

 hw/loongarch/virt-acpi-build.c                |  12 +-----------
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4379 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5600 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4385 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4681 bytes
 5 files changed, 1 insertion(+), 11 deletions(-)


base-commit: 8967b2fe1b2aaae3c29e207d85fab901d580a2dc
-- 
2.56.0


