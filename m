Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C86FC27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 08:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ7Ub-0007g0-NC; Mon, 17 Jun 2024 04:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJ7Ua-0007fa-7b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 04:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJ7UY-00046P-EC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 04:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718612006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GFINyzwIJ6GDW/gMEHHmSEluXNLZ8Afdl7RJ281J00A=;
 b=gFEjH4i0dZUkci5GNh+Tit3sBCzJDvYd2HjCH4m3Z5mpP3PDuEKKm7dDEagU4yBzkZjc+i
 eFsE9MWWaco1SBcWoKyXyRDRle1R7Szwa+iUJbZxBwpe6kRWz6VasOd7GE63RdcNJlgNbg
 qA2AdWBcjfyilye2FDa6VyXRWyh0lgw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-K_ezqkRANs-M5PpSn2vtQA-1; Mon, 17 Jun 2024 04:13:23 -0400
X-MC-Unique: K_ezqkRANs-M5PpSn2vtQA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6def6e9ef2so367565066b.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 01:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718612002; x=1719216802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GFINyzwIJ6GDW/gMEHHmSEluXNLZ8Afdl7RJ281J00A=;
 b=N5OZPT7PQd41wxy/YeG0XgXc3Hn/zcmalmD1ARVauzXlzMgbUS8G3xGbDx45FjmDtX
 aeI2nI9ecQyenxVmYEOTmnxdW0FYsnwmhSM+Xp05zV15ce3HdwFjsn/pltRyMW+vwdyF
 83I9iniG2a5Q2I6XBjnUHkgjp0e98Vp3W5ZWZJe1nH+lS8CCqs/4pjxqlOwwbkGLGZnB
 4NzhlOrZAVJwiGtD09iqUyoW0U+W3nl6afxTzoCTw7XS5cuwNOPsdtvneKp5NkANV6hk
 QYQQyCHiamSm90llxhZU/Dnbq29JZeE6HzNzYVHn25yLKPK+dth+aEdoRF/tgxp3Ditp
 udSQ==
X-Gm-Message-State: AOJu0YxqrRTTvBK9WNJGJTU6niRSwpsXUDebXY8cJ7TFr7dHQ+gkokK1
 djbML5mDz6/GreFA6R3phZD+cwdL28Vybajwgh8ZIQQtOYt3+0md6tA3FuB9dhUnfNYQIxikIXu
 PGmacFSrgfRJm+6B8jXxmHvouxg8oCUr1N7Xdu/XF5N3ot6yaoapIFfSX5vvm+FEwe5xLN06zaB
 K+Ocl29Vaw/CcXDIhMkffR2rlsidSFmeFX0jKZ
X-Received: by 2002:a17:906:f953:b0:a6f:624e:741a with SMTP id
 a640c23a62f3a-a6f624e76bdmr568598066b.3.1718612001908; 
 Mon, 17 Jun 2024 01:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfdVB2+frDRjwVQeg7aDLKywDkiY4CIokM1WzB/lspYcvm28s7+FyeGnjt6STJdo10N3lQPA==
X-Received: by 2002:a17:906:f953:b0:a6f:624e:741a with SMTP id
 a640c23a62f3a-a6f624e76bdmr568597066b.3.1718612001473; 
 Mon, 17 Jun 2024 01:13:21 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db67c4sm492147566b.60.2024.06.17.01.13.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 01:13:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/25] target/i386, SCSI changes for 2024-06-11
Date: Mon, 17 Jun 2024 10:13:18 +0200
Message-ID: <20240617081319.88956-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 80e8f0602168f451a93e71cbb1d59e93d745e62e:

  Merge tag 'bsd-user-misc-2024q2-pull-request' of gitlab.com:bsdimp/qemu into staging (2024-06-09 11:21:55 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 109238a8d97cd8e85ca614109724a0b1222b21f5:

  target/i386: SEV: do not assume machine->cgs is SEV (2024-06-17 09:47:39 +0200)

----------------------------------------------------------------
* i386: fix issue with cache topology passthrough
* scsi-disk: migrate emulated requests
* i386/sev: fix Coverity issues
* i386/tcg: more conversions to new decoder

----------------------------------------------------------------

v1->v2: fixed MOV from/to CR and DR in 64-bit modes (does not need REX.W)

Chuang Xu (1):
      i386/cpu: fixup number of addressable IDs for processor cores in the physical package

Hyman Huang (1):
      scsi-disk: Fix crash for VM configured with USB CDROM after live migration

Pankaj Gupta (3):
      i386/sev: fix unreachable code coverity issue
      i386/sev: Move SEV_COMMON null check before dereferencing
      i386/sev: Return when sev_common is null

Paolo Bonzini (20):
      target/i386: remove CPUX86State argument from generator functions
      target/i386: rewrite flags writeback for ADCX/ADOX
      target/i386: put BLS* input in T1, use generic flag writeback
      target/i386: change X86_ENTRYr to use T0
      target/i386: change X86_ENTRYwr to use T0, use it for moves
      target/i386: replace NoSeg special with NoLoadEA
      target/i386: fix processing of intercept 0 (read CR0)
      target/i386: convert MOV from/to CR and DR to new decoder
      target/i386: replace read_crN helper with read_cr8
      target/i386: fix bad sorting of entries in the 0F table
      target/i386: finish converting 0F AE to the new decoder
      target/i386: split X86_CHECK_prot into PE and VM86 checks
      target/i386: convert non-grouped, helper-based 2-byte opcodes
      target/i386: pull load/writeback out of gen_shiftd_rm_T1
      target/i386: adapt gen_shift_count for SHLD/SHRD
      target/i386: convert SHLD/SHRD to new decoder
      target/i386: convert LZCNT/TZCNT/BSF/BSR/POPCNT to new decoder
      target/i386: convert XADD to new decoder
      target/i386: convert CMPXCHG to new decoder
      target/i386: SEV: do not assume machine->cgs is SEV

 target/i386/cpu.h                    |    9 +-
 target/i386/helper.h                 |    2 +-
 target/i386/tcg/decode-new.h         |   32 +-
 hw/core/machine.c                    |    1 +
 hw/scsi/scsi-disk.c                  |   24 +-
 target/i386/cpu.c                    |    6 +-
 target/i386/sev.c                    |   11 +-
 target/i386/tcg/seg_helper.c         |   16 +-
 target/i386/tcg/sysemu/misc_helper.c |   20 +-
 target/i386/tcg/translate.c          |  716 +--------------------
 target/i386/tcg/decode-new.c.inc     |  389 ++++++++----
 target/i386/tcg/emit.c.inc           | 1166 +++++++++++++++++++++++-----------
 12 files changed, 1173 insertions(+), 1219 deletions(-)
-- 
2.45.2


