Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9867C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2RL-0006sq-P8; Tue, 11 Jun 2024 10:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RI-0006rr-UM
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RH-0005xc-5m
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tmfXOPyxxCuD+6YbVe62/oWf5gXUYk2/0W2+4iL6AfU=;
 b=geD54iGoxUI0bpufeEdbIYzltQNjo86yXnjO3nFcReDgHg9Y2g5A0BfU/JVcOSmFjFwaZZ
 4QxOwkA8Vw6wxIzeSWSajoIHEapKn4n1DpTj24ylq9pIMBRm7+xml/tLf//k/ERBSGSa/P
 QGWTtSNnQlpGWQo78sxbXt2WCMKal7w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-eLu9mHrbPHiuw7dtIVVJSw-1; Tue, 11 Jun 2024 10:25:27 -0400
X-MC-Unique: eLu9mHrbPHiuw7dtIVVJSw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6ef729b8a7so60168766b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115925; x=1718720725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tmfXOPyxxCuD+6YbVe62/oWf5gXUYk2/0W2+4iL6AfU=;
 b=WLrNNJolTweUwoNDor+luvwS9BNm8KBclMUnX0OD+4ViwP4uF5SDdDnowqAWmxJ67B
 ENON/kSsgNwMVyY0t2tpKc6EuUW74ee5lfXPw9NbELi0js6huzUo3cvKSPix1CeEu1ik
 CGBdhO5Xcc6ttJNWcVqbGYb70/fYf7XAcCHPpencWLyRZT59Llm5GhL48Iasu4+BT5au
 nsX9WWtD0gg16PweiTvljlACALQmGba6Xsn7XUofP1eIZJngHPxI4g2lKZBLciAmnKfU
 zkKJX02p2eLV7oF9nF6HCfzvctEuQPjH70ePIYkjdvdIEywVNDuyUTUxsMBANzMaIkrT
 aoeg==
X-Gm-Message-State: AOJu0Yy1kC0wi+9YEIAKY5xUSpISJPRJNPPi/xgATGr3J/3QVcCQWBlb
 lVLbYSnFoCwcfmXhQI6oCUW6qoeDmcN9D3PQdhYDUc5FuLM+5aSnEv0VmtOJiDUf+ZFBryd988g
 qTKkKq/ZWg7YNIFliY+TN8hFawfGNjuxHzh/F2+8Yvli6YuScQuXxOcVw3+3ct2IcN/z8Bjpju0
 gzMDgFMCUntVSjQTTdekQkpQgSlmmALir2gGbZ
X-Received: by 2002:a17:907:10cf:b0:a6f:11f7:e8c5 with SMTP id
 a640c23a62f3a-a6f11f7ede0mr469758366b.12.1718115925710; 
 Tue, 11 Jun 2024 07:25:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNuFcfOViiIHMVd3vl/Spie5jORpQGhyMDcih10QMlexqN9j0ZyUccae7rQWaa/KVBBU8e6g==
X-Received: by 2002:a17:907:10cf:b0:a6f:11f7:e8c5 with SMTP id
 a640c23a62f3a-a6f11f7ede0mr469755966b.12.1718115925197; 
 Tue, 11 Jun 2024 07:25:25 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1e6795b9sm270034666b.174.2024.06.11.07.25.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/25] target/i386, SCSI changes for 2024-06-11
Date: Tue, 11 Jun 2024 16:24:58 +0200
Message-ID: <20240611142524.83762-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

for you to fetch changes up to 58ab5e809ad66a02b6fa273ba11ed35b8b2fea60:

  target/i386: SEV: do not assume machine->cgs is SEV (2024-06-11 14:29:23 +0200)

----------------------------------------------------------------
* i386: fix issue with cache topology passthrough
* scsi-disk: migrate emulated requests
* i386/sev: fix Coverity issues
* i386/tcg: more conversions to new decoder

----------------------------------------------------------------
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
      target/i386: fix bad sorting of entries in the 0F table
      target/i386: finish converting 0F AE to the new decoder
      target/i386: replace read_crN helper with read_cr8
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
 target/i386/tcg/decode-new.h         |   31 +-
 hw/core/machine.c                    |    1 +
 hw/scsi/scsi-disk.c                  |   24 +-
 target/i386/cpu.c                    |    6 +-
 target/i386/sev.c                    |   11 +-
 target/i386/tcg/seg_helper.c         |   16 +-
 target/i386/tcg/sysemu/misc_helper.c |   20 +-
 target/i386/tcg/translate.c          |  716 +--------------------
 target/i386/tcg/decode-new.c.inc     |  381 +++++++----
 target/i386/tcg/emit.c.inc           | 1162 +++++++++++++++++++++++-----------
 12 files changed, 1160 insertions(+), 1219 deletions(-)
-- 
2.45.1


