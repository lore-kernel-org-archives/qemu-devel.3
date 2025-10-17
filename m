Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D39CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9lCW-0004e9-0X; Fri, 17 Oct 2025 10:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCT-0004dA-Sn
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:12:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v9lCM-0005eh-Dr
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:12:56 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4270a3464bcso194768f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 07:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760710365; x=1761315165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gzW3ekQZ7Psj0DsMhnvdQfGfYGGMgoTsdSCNvzg/jEU=;
 b=lpCx423vz/ClH8LDX+PMyW+IKJ3kL1pnR5TYpSXsuXCe4Ksx+mRtJ8OWDch0NOjrLP
 3pzeEBWg390IJW3qbIqSH1nzULOF5L2UFUkcU+BPdk5b5bjXDeaLG9RstOlsDURW6gz4
 1vhR3b/hYwB38V+ehNR5YoPBGlXkXi/XxEbpJDgRJuMOHcJtbOftQLPMNAFgxX6NmzcW
 v0X6JZ/7WmeH5xL6kv7ZEfPyRYLVtSYMLuNgVoRmLi/GnRd3Ilcr+6xbQz/xzRfALGIi
 Mxf7B2ZkgKipeysq5bv5kyR8mbSNKUMe75r62vf//409H6QXrPveG5x4ZJjMBlF/IhFc
 rZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760710365; x=1761315165;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gzW3ekQZ7Psj0DsMhnvdQfGfYGGMgoTsdSCNvzg/jEU=;
 b=QvIFZZtwf/zCVvB2scK5XWhTpDL4mpA2KFC6gY6Quq0On5zeYoTaFKA06aHsgFejyh
 9frPTDULazZopk+LYIpyiZYDYkV1EA2BJqZklD0zPUf6dHustT02mVo8SQlqvh+HSNAu
 TpOc/S4ZdbZv+QMy+bEJyT8dMuY7VoC51IMCs74gDqAfkmfPG1xM0BqYxFVfhxe47jD6
 vN3qxhP+p0rK3sMC8HCvagJ+LVQ13LR1+K4B6Wxn/7mzh9JJZw8hssyP4UGkT+mEbi1z
 2dQFiYfAhIlCxnGlvlXBd1R0YYRVx2zQ03vmTAE1OcCf7NGQV/E2vmCJ3GFbCT5ew8S9
 AheQ==
X-Gm-Message-State: AOJu0YxPiGWj4WyEeBHLiiDaDNMZkW7yqSbyMIA12+cxKDrB7iXAB/+O
 p/0RF+TzOYp6ekSADs+CUZixDEpK7Kv7NlikBSebjb8gDwOJM+7Xd6JKRxqBqw==
X-Gm-Gg: ASbGncuCZWJsA7Ztz5LgGg1kXwyojbmFLOV56bt9efJsOHAe1Rf7+ub9f3Qj1a8gMYf
 g6xBvGzL99BLksBG5e2FmcnMdexNpNtB77o5Yvab+HoxHEs6a339UiG4RExegj65avsJNmTvuC3
 /Os9NRVaxmKT1gYiaEseZnpy3mYJyat1yxFuAZAZm1deHRxJuqV2tjee4Y6tl9znJwRDu+NQyhK
 tetQ9KBRlrm492McGBLOzQcV5FsVpukN24TBszP4HvUosh09+ffXXGvciBcRABeIYQKbsLl7OTZ
 OK+3IiL7mii42nDyffU4uJRyrOU/qyGrPUXcvpUpvEJSUgWaoHoLztePRHyZT/DLDZ2JQfaxpPR
 f9bu3NpJ8ITDcfIl0G/CV73h8ahUDo71t2BNnUtCXTk+YRpZ8lbh3S5SSWJhmhGnjIgobybk/92
 7XnG8ZVhtnYKDj5pgG/+zyWx5eMKmT1tY1
X-Google-Smtp-Source: AGHT+IGeuxOJBWpmVCX3U1tHBDipCkpzrypzvQWf6sOPwcugLBzMa9b7CCp6AGBV0FZ+Pn8TPlDLZw==
X-Received: by 2002:a05:6000:25c7:b0:427:854:787 with SMTP id
 ffacd0b85a97d-4270854085bmr1487022f8f.51.1760710364350; 
 Fri, 17 Oct 2025 07:12:44 -0700 (PDT)
Received: from archlinux (pd95edc07.dip0.t-ipconnect.de. [217.94.220.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710cb36e7csm51359675e9.2.2025.10.17.07.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 07:12:43 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 00/11] Cleanup patches, mostly PC-related
Date: Fri, 17 Oct 2025 16:11:06 +0200
Message-ID: <20251017141117.105944-1-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series mostly contains PC-related patches I came up with when doing=0D
"virtual retrocomputing" with my via-apollo-pro-133t branch [1]. It include=
s=0D
improved tracing and removal of cpu_get_current_apic(). The remaining patch=
=0D
resolves duplicate code in the test of DS1338 RTC which is used in e500=0D
machines.=0D
=0D
v2:=0D
* Remove some redundant APIC_COMMON(cpu->apic_state) casts=0D
* Resolve cpu_get_current_apic()=0D
=0D
Testing done:=0D
* make check=0D
* Work with recent x86_64 Linux distribution running on WHPX=0D
=0D
[1] https://github.com/shentok/qemu/tree/via-apollo-pro-133t=0D
=0D
Supersedes: 20251017113338.7953-1-shentey@gmail.com=0D
=0D
Bernhard Beschow (11):=0D
  hw/timer/i8254: Add I/O trace events=0D
  hw/audio/pcspk: Add I/O trace events=0D
  hw/rtc/mc146818rtc: Convert CMOS_DPRINTF() into trace events=0D
  hw/rtc/mc146818rtc: Use ARRAY_SIZE macro=0D
  hw/rtc/mc146818rtc: Assert correct usage of=0D
    mc146818rtc_set_cmos_data()=0D
  hw/ide/ide-internal: Move dma_buf_commit() into ide "namespace"=0D
  hw/i386/apic: Prefer APICCommonState over DeviceState=0D
  hw/i386/apic: Ensure own APIC use in apic_msr_{read,write}=0D
  hw/intc/apic: Ensure own APIC use in apic_register_{read,write}=0D
  hw/i386/x86-cpu: Remove now unused cpu_get_current_apic()=0D
  tests/qtest/ds1338-test: Reuse from_bcd()=0D
=0D
 hw/ide/ide-internal.h                |   2 +-=0D
 include/hw/i386/apic.h               |  38 +++++----=0D
 include/hw/i386/apic_internal.h      |   7 +-=0D
 target/i386/cpu.h                    |   4 +-=0D
 target/i386/kvm/kvm_i386.h           |   2 +-=0D
 target/i386/whpx/whpx-internal.h     |   2 +-=0D
 hw/audio/pcspk.c                     |  10 ++-=0D
 hw/i386/kvm/apic.c                   |   3 +-=0D
 hw/i386/vapic.c                      |   2 +-=0D
 hw/i386/x86-cpu.c                    |  10 ---=0D
 hw/ide/ahci.c                        |   8 +-=0D
 hw/ide/core.c                        |  10 +--=0D
 hw/intc/apic.c                       | 116 +++++++++------------------=0D
 hw/intc/apic_common.c                |  56 +++++--------=0D
 hw/rtc/mc146818rtc.c                 |  20 ++---=0D
 hw/timer/i8254.c                     |   6 ++=0D
 target/i386/cpu-apic.c               |  16 ++--=0D
 target/i386/cpu-dump.c               |   2 +-=0D
 target/i386/cpu.c                    |   2 +-=0D
 target/i386/hvf/hvf.c                |   4 +-=0D
 target/i386/kvm/kvm.c                |   2 +-=0D
 target/i386/tcg/system/misc_helper.c |   5 +-=0D
 target/i386/whpx/whpx-apic.c         |   3 +-=0D
 tests/qtest/ds1338-test.c            |  12 +--=0D
 hw/audio/trace-events                |   4 +=0D
 hw/rtc/trace-events                  |   4 +=0D
 hw/timer/trace-events                |   4 +=0D
 27 files changed, 146 insertions(+), 208 deletions(-)=0D
=0D
-- =0D
2.51.1.dirty=0D
=0D

