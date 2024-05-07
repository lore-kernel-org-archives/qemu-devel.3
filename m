Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DB6C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IU9-0004Mz-8b; Tue, 07 May 2024 06:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IU7-0004Mb-UE
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IU6-0001ur-71
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4hPgtKiEPe72ngKlc1jkSmvUqL3Zy/0zXyZjCxX3RIU=;
 b=JwPXhVHIcRCsTkFzs3egjIBPHOxLV0DlblPjhp+XIuD/wTkMqVRO90ZgWNuWrtLhghfbon
 21mg/f7U+sNEavR9kFY+WDhYE0w11MpmRldCkjWKXoQ4mVKu2TIp63+WdMDYzHJZ/UcCQ2
 YXbBHX7o6ncxvJDYFzOwzXXwDim7G4M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-0TYpX2GbON6-_nEpyaaEfg-1; Tue, 07 May 2024 06:55:43 -0400
X-MC-Unique: 0TYpX2GbON6-_nEpyaaEfg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59c942611bso143777766b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079341; x=1715684141;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4hPgtKiEPe72ngKlc1jkSmvUqL3Zy/0zXyZjCxX3RIU=;
 b=hMYobPQ80Zkx5KscHrMkqTm8Lq9aq8EepIpfDBCjgLJ32y+aoL2MWmppn6exdH5rth
 hEB0214X5PnDx2MYaIV6xlXl3YMDRRJK2H0F9KIexedr7qI1thscDXNsWboZJMqTAT7s
 HHOJ5LLMXTt4upyZPNRRYyFbVVi1qPJ2z71EKhVyJJVu9wUqjBG73GOKQqc7XML+ow8D
 2ODxGaja1i+2V0aIqc2d0JaDtItQTcMje+0UUQJ2bDAYcm+qGSaXD4aoQx8dBAtkhEzj
 v1SaIS88kRvxu3gepoYhgXAFS6rpltZgz9JcE/EybOR0YewW//uE3BCpEN8iYztHPOJd
 9w4w==
X-Gm-Message-State: AOJu0YyOSujnsLNUXzcm+4CBKPtsdJTQNsJl64v8dpmD9IAhJEqwMeT5
 XfwDBmjkOrxfn5K4/ipUzzjwoydx348sFJZ5+xfM/pRTyPQyYFJhT9uoPrplh6TafyamnSSWa+W
 czvMTxQ6hMFyc1tl0IDKZHt72bF+Z8jHptppF8U6Xwz2MjhBJtQ9odal8U61Jt4Zw4v8bz6mKQb
 RIFO+e2XUCmdqE0xNvAXJC/hmJeIvz4W9xE3KD
X-Received: by 2002:a17:906:495:b0:a59:a0c1:b222 with SMTP id
 f21-20020a170906049500b00a59a0c1b222mr5772314eja.39.1715079341428; 
 Tue, 07 May 2024 03:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0MBeaGLBCG1plbINUgK27QLkatSRlqDHANg6UGZJjVKF6ecEQze7u38F7eGIku47+rmRUwg==
X-Received: by 2002:a17:906:495:b0:a59:a0c1:b222 with SMTP id
 f21-20020a170906049500b00a59a0c1b222mr5772296eja.39.1715079340971; 
 Tue, 07 May 2024 03:55:40 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a170906408500b00a53c746b499sm6319112ejj.137.2024.05.07.03.55.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:55:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/26] target/i386 changes for 2024-05-07
Date: Tue,  7 May 2024 12:55:12 +0200
Message-ID: <20240507105538.180704-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit e116b92d01c2cd75957a9f8ad1d4932292867b81:

  Merge tag 'qemu-sparc-20240506' of https://github.com/mcayland/qemu into staging (2024-05-06 10:19:56 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to d4e6d40c36071c287199c072cd5d296091ee5968:

  target/i386: remove duplicate prefix decoding (2024-05-07 08:53:26 +0200)

----------------------------------------------------------------
* target/i386/tcg: conversion of one byte opcodes to table-based decoder

----------------------------------------------------------------
Babu Moger (1):
      target/i386: Fix CPUID encoding of Fn8000001E_ECX

Paolo Bonzini (25):
      target/i386: use TSTEQ/TSTNE to test low bits
      target/i386: use TSTEQ/TSTNE to check flags
      target/i386: remove mask from CCPrepare
      target/i386: cc_op is not dynamic in gen_jcc1
      target/i386: cleanup cc_op changes for REP/REPZ/REPNZ
      target/i386: pull cc_op update to callers of gen_jmp_rel{,_csize}
      target/i386: extend cc_* when using them to compute flags
      target/i386: do not use s->T0 and s->T1 as scratch registers for CCPrepare
      target/i386: clarify the "reg" argument of functions returning CCPrepare
      target/i386: cleanup *gen_eob*
      target/i386: reintroduce debugging mechanism
      target/i386: move 00-5F opcodes to new decoder
      target/i386: extract gen_far_call/jmp, reordering temporaries
      target/i386: allow instructions with more than one immediate
      target/i386: move 60-BF opcodes to new decoder
      target/i386: generalize gen_movl_seg_T0
      target/i386: move C0-FF opcodes to new decoder (except for x87)
      target/i386: merge and enlarge a few ranges for call to disas_insn_new
      target/i386: move remaining conditional operations to new decoder
      target/i386: move BSWAP to new decoder
      target/i386: port extensions of one-byte opcodes to new decoder
      target/i386: remove now-converted opcodes from old decoder
      target/i386: decode x87 instructions in a separate function
      target/i386: split legacy decoder into a separate function
      target/i386: remove duplicate prefix decoding

 target/i386/cpu.h                           |    6 +
 target/i386/helper.h                        |   11 -
 target/i386/tcg/decode-new.h                |   23 +-
 target/i386/tcg/shift_helper_template.h.inc |  108 -
 hw/i386/pc.c                                |    1 +
 target/i386/cpu.c                           |   18 +-
 target/i386/tcg/int_helper.c                |   34 -
 target/i386/tcg/translate.c                 | 3781 ++++++---------------------
 target/i386/tcg/decode-new.c.inc            |  608 ++++-
 target/i386/tcg/emit.c.inc                  | 1595 ++++++++++-
 10 files changed, 2989 insertions(+), 3196 deletions(-)
 delete mode 100644 target/i386/tcg/shift_helper_template.h.inc
-- 
2.45.0


