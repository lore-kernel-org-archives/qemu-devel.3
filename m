Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC43606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=joTaVzMS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMnIv-0004pI-73; Fri, 30 Oct 2026 10:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1xMmo7-0005xk-S1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:38:15 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1xMmo6-0007ZZ-6V
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:38:11 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-70059e4dab6so438873eaf.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793367488; x=1793972288; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZNFgKPdhXCo0LjG81BaftOa0QgUdfn08FZjH7NUkGys=;
 b=joTaVzMSko//FeEhRl402UB0Ypni/o6nImyZk8eARWMdmxzwfZl/mpqLRLDRuy5/cn
 UBSNzRjHevBv2GQAsYBOglbPnQ0BVx0XxXEZlREawzJPg5SrT9hQTSj48msEpCYVHXiH
 +EY7zsF4FiuJwv1tLPOwho7IEWoJqQ+JfWi345lsjhGZN4XW3mjU+DYr2XU6Jk3CZdXO
 wwsbqxSmYqFyx5ZIpE5voZgOqIrsA2aa58h4uWfndyp+1TaBpUShmFltS8SLJAscfirl
 VJ13gbSFtt+ldLg9Ku9Czxgklw99kKqAc2tQvGnl3OxMMMrQZx3sliCdzfCMhgorS3h7
 EUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367488; x=1793972288;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZNFgKPdhXCo0LjG81BaftOa0QgUdfn08FZjH7NUkGys=;
 b=S+jhmiOjNz0qEPGKkufhnLTXajqlodMPES7brG2KjOl3gbYYanSbCaoi945HHz7z6X
 LnL/N6SR7djly3T5z9yDdqpazD2LfzK0uP4xjiUPsodEgDZOdKX4jIwoIhsx5jXYA+kt
 7RQexha5nOvwVphny7X/d2LzZTRFcPRdEioVwfZoU13GdTN+uE/usZyjaAmE6aN3UZqM
 JH4QZTR6yV/hIK/V375Ndr1pbh5XYv0LZLFzv4VSgCkyzH31rGCm5mmZYhNNokyb3FOe
 ss7RfA56JC21S1tOuO8ol0JsjOhlVEqr/7UfMBA8HKV2pMCbFjGdHx4eYfMQ/DdFuAWM
 H6Yg==
X-Gm-Message-State: AFq9FYJtjOAWs0nOxbxHqBnMs74X+39Pud3O4gFQvKRuprNha4Ep9yq2
 SaAZUpO3D8A2TGQzt92wLLLDVLDCkTbcNsHT9YexIEsApSIKVd05Z0KV4eLPKg==
X-Gm-Gg: AYBFou1D3i5FJ6VqnwnYeVVWwAx7xUaCdkftKBSAJoW1JoyZMyAV8uQFgwHjh3QGj3B
 0qZpMD5FsmChjiuQdSZS2cZIbm6fuaU2lOwu3XBKVht9KYseQDfynNq0/ezZG5hZm2Gw78gAxuv
 PcxiWAjJJbUmG3L0c1tOyaFnsDWhHi675WvxOUxLPLhmNtU7nqooHlx2+JsKUFLz65pqrvWpQuZ
 6Nj9lbZiX1Byht9ZmwLNhpvSE5keJ0hooynBD3t/WKpFTpnQBdTLkhOB+k06auYFChh9PQfdotJ
 kZYlOnCv12u1IwPBPK51GGOMK/VR+Zi5+nAfdzbg3qQV6AesQgASc8H7BalevByhWvuDH9izzJs
 LBWiIxgMaell7Fk2sv0mWopvrgkLX5fOOTMI3rTF5xKFpa8JRG5jcAbOb8aaQ1cSLvcMVkurDoq
 kPHBd5H8fWGaSA7pjVS5Wkw1iLuFk8pRz0KbMe/XAmp87JY+ncVtrlVhWofv3I8Go+QrxvkPMNF
 0K9CKQL+4gD+sWQXrVWXEIlPBoZsRWpJ3m+EIUsyrcOPF9PBW1eV+YunAXtBzs8dCAlDC5GNrvx
 UOT+u/Fng5KvUrdYBjCUq+1ypdfGsEYTOLotzLzNCg==
X-Received: by 2002:a05:6820:858a:20b0:70b:960c:53d2 with SMTP id
 006d021491bc7-714f1f8156cmr1028209eaf.1.1793367488161; 
 Fri, 30 Oct 2026 06:38:08 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([120.235.190.244])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-714f30600f0sm1861421eaf.12.2026.10.30.06.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 06:38:00 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 bmeng.cn@gmail.com, philmd@oss.qualcomm.com, pbonzini@redhat.com,
 lvivier@redhat.com, farosas@suse.de, caojunze424@gmail.com,
 raoyi <rao232328@gmail.com>
Subject: [PATCH v6 0/3] hw/timer: add DesignWare APB timer
Date: Fri, 30 Oct 2026 21:37:01 +0800
Message-ID: <20261030133704.99678-1-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=rao232328@gmail.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 10:09:55 -0400
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


Add a generic DesignWare APB timer device model, and wire it up
for the K230 machine with num-timers=6 and a 50 MHz clock. Also
add qtest coverage for the timer behavior.

Changes since v5:
- Rebase onto current master
- No functional changes

Changes since v4 (address review comments from Philippe Mathieu-Daude):
- Drop Clock framework mention from the commit message
- Cover the device in MAINTAINERS (device files in patch 1/3,
  test file in patch 3/3)
- Move trace calls to function entry
- Drop the addr mask; the MMIO region stays at 0x100 (the IP
  register implementation range; the SoC aperture is board-level)
- Hard-code comp-version (0x3231312A, "211*", IP component version)
- Use the Resettable API (phases.hold) instead of legacy reset
- Add unrealize to free per-channel ptimers
- Keep register offsets and bit definitions in the C file
- Drop private/public comments in the header
- Move K230 timer macros into k230.c

Changes in v5:
- Rename DW_APB_TIMER_CONTROL_INT to DW_APB_TIMER_CONTROL_INT_MASK
- Fix the K230 timer clock frequency from 6.25 MHz to 50 MHz
- Wrap the qtest commit message at about 70 characters per line
- Register both K230 qtests directly under CONFIG_K230

Testing:
- QEMU build passed in the Debian container
- tests/qtest/k230-dwapb-timer-test: 8/8 passed

raoyi (3):
  hw/timer: add DesignWare APB timer model
  hw/riscv: add DesignWare APB timer to K230 board
  tests/qtest: add k230 dwapb timer test

 MAINTAINERS                         |   3 +
 hw/riscv/Kconfig                    |   1 +
 hw/riscv/k230.c                     |  33 ++-
 hw/timer/Kconfig                    |   4 +
 hw/timer/dw-apb-timer.c             | 376 ++++++++++++++++++++++++++++
 hw/timer/meson.build                |   1 +
 hw/timer/trace-events               |   8 +
 include/hw/riscv/k230.h             |   8 +
 include/hw/timer/dw-apb-timer.h     |  40 +++
 tests/qtest/k230-dwapb-timer-test.c | 274 ++++++++++++++++++++
 tests/qtest/meson.build             |   3 +-
 11 files changed, 747 insertions(+), 4 deletions(-)
 create mode 100644 hw/timer/dw-apb-timer.c
 create mode 100644 include/hw/timer/dw-apb-timer.h
 create mode 100644 tests/qtest/k230-dwapb-timer-test.c

-- 
2.53.0


