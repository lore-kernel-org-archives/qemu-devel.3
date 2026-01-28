Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC161D3F07A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7Oy-0000iF-W0; Wed, 28 Jan 2026 10:24:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vl7Og-0000Y8-T0
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:23:59 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vl7Of-0003Tb-8u
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:23:58 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a12ebe4b74so68338325ad.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 07:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769613835; x=1770218635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=no/0EZ/1gdpdjOroJos5sWZ3pOy698ZG+yISllhXifs=;
 b=FkkHGMzwyvQS2N5pfSXCKuMPg4lX25yKtJWh16UTyFSFbDXxfuEg0ougRTDhQ7Ur/C
 +9S501V+P5TlNfFjz1q+cpiWJiUZmJy53unpM5BouAa35pwhmSIdrcXs34RZWXO8K98z
 JrYnDeLojUmPfLWuJh7/rJ3CzEiRBgvIbB1kcolYB0gdLJTDlVFw7M1PMXJv3JejqP+C
 /3SBhncta65zcTUaCgm/sc3gGu9qPEsBMwpVThcmi9AtUIDJv7NmdctzMtu584UjnnJh
 Ip01k1FlPhTfD5s46rz2vduRWV/Bw/QYEVuvqubpSD0smUKQ/z0fXXJMhc2HofnzGp03
 T5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769613835; x=1770218635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=no/0EZ/1gdpdjOroJos5sWZ3pOy698ZG+yISllhXifs=;
 b=rwVLQWzMmT2vwqvbe+yWbCixRsHlYViOLRGAKzGjAX3yu9l9wOD3eWZx9xw5mGcy2/
 0J7uCx2OS41Om+zFCVzdGsVJCgmU23TNYWcLzO3RDfbjOQgujqrWwxQoncykJI0xb9KL
 2euh9KiN4JlFaQAopgFNIeKDArUkQCDEQTC6ahskMOCi52hoXZ1uh41hcmM+wcJ7pjeJ
 nlKLYbumXKFpNuJ/Xs+JVFBFJtIagurKoVBOS5grKG8+1iajtCQNuwVl6A/wljReVdTt
 f/z/FxRlG4B3ZIvX95CdBdqow/Kj4mWcYmAJx34VRWjXTNo/dAHsvaHLmTQ1VARfk0d1
 sa0w==
X-Gm-Message-State: AOJu0YyiMuURvoQr2mWXu89S/WuZWjPx0xLq24mJvyk4gn7FLx1Xf2q1
 GlgzJArbeWQXC9pz9wkovydTdroW/heQPpY5BhS2LsJuEwCj7epE0smJTF9tcQuADRKTXyS0zSr
 HoPo2Dv3q+h+o1r4TeaBuq6MTBW9X48xGMMyM3Ici2Wq5AfMTcrJikDCFz72HC4SEylGL9kvLhH
 yPfuyh5cywXoaLu5fKwcvtRRuusrGpinwReedBXw==
X-Gm-Gg: AZuq6aJF4MRgsntQ1OhpBUQQdWfdtwZHw4Tqp3E5/IThw+rGmdNRI5A0rKgcldr5JxF
 Z2Z2PaBaGwGA2BBLPrHqmpmJpwCdzzUJSbz9F3I/43icXl9walrFjg263MHZyKL8UiPyLf5nbmu
 anVnMNn4db7e/74MpfXJ+3qaPn/zOmq02ptibp4xXnN07eWov5+p0c2DpU4UP9F5NmXEMbBVxgD
 M4Zr6lEfK0UaYCV6QI8VrjfsjgLUwkyu3doaBFqNghtVbc7h4jZA7QgcJ+uf3mgMVO/MMmGqC31
 4GgvbjPD7QQyJDbVElCK3ck2d8q2LIw0JLuU2deTGSDPCFqUYEGABNJCg376Kp2nB1Ayn/i/WQJ
 7xWHicW+IhpxBBys5c4AiquzSEo1H2BqjzYFfIIMrxqh6AV8WwbSdyMFxT8mMHm2YiPd0MxO9UY
 NF+CZt6k7knoC4+gzgdyj+eaBuZ/thsDEepIY9EoTZDtg=
X-Received: by 2002:a17:903:1250:b0:2a1:5785:4417 with SMTP id
 d9443c01a7336-2a870e1899bmr45733775ad.34.1769613835257; 
 Wed, 28 Jan 2026 07:23:55 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c1eeebsm3021304b3a.45.2026.01.28.07.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 07:23:54 -0800 (PST)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2 0/3] Fix iotlb_to_section() for different  AddressSpace
Date: Wed, 28 Jan 2026 23:23:45 +0800
Message-ID: <20260128152348.2095427-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Current 'iotlb_to_section()' API only finds the sections from CPU's
AddressSpace but not other AddressSpaces. However, If address space
translation is over IOMMUMemoryRegion, like ARM MPC device, it could
return section from other AddressSpaces, which will break
'iotlb_to_section()'.

To fix this bug, store complete MemoryRegionSection pointer in
CPUTLBEntryFull, and we can directly use section pointer in it w/o need
of 'iotlb_to_section()' API.

Besides ARM MPC device, the upcoming RISC-V wgChecker [1] and RISC-V IOPMP [2]
devices also require this bugfix.

[1] RISC-V WG:
https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
[2] RISC-V IOPMP:
https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech.com/

Changed since v1:
- Move io_prepare() argument change in a preliminary patch
- Rename 'xlat' to 'xlat_offset' and fix the comment

Jim Shu (3):
  accel/tcg: Send full CPUTLBEntryFull struct into io_prepare()
  accel/tcg: Fix iotlb_to_section() for different AddressSpace
  system/physmem: Remove the assertion of page-aligned section number

 accel/tcg/cputlb.c        | 32 +++++++++++++++-----------------
 include/accel/tcg/iommu.h | 15 ---------------
 include/exec/cputlb.h     |  4 ++--
 include/hw/core/cpu.h     | 17 +++++++++--------
 system/physmem.c          | 31 -------------------------------
 5 files changed, 26 insertions(+), 73 deletions(-)

-- 
2.43.0

