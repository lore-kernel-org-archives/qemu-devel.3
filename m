Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF4CD3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YFN-0003Lx-T8; Sun, 20 Oct 2024 11:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFL-0003LC-S0
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFK-0005P5-2r
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tD++BQ9h6ta2uKNlUNxRwlSqhs8vQvZoIRKWukTm62Q=;
 b=ZbUYvO2obLH4tLOfsBtnkFb9dxH7Nr9a3vTd0XsU1ouQuiw9lYZxgYfCNL1EwAdrussaU+
 jUTO6aSovQjCQMgGnHHzkdTibob/ZjMBPPKwOfWYtjmYDzuC0RiF0rt68XS8DtaMIyKacT
 1RhnOf3TCK2S594ser0vueshfYC2E0I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-QQURD0hKNIaPmkYsUoGIuA-1; Sun, 20 Oct 2024 11:53:28 -0400
X-MC-Unique: QQURD0hKNIaPmkYsUoGIuA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43151a9ea95so22247695e9.1
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439607; x=1730044407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tD++BQ9h6ta2uKNlUNxRwlSqhs8vQvZoIRKWukTm62Q=;
 b=V4WHHnz6hlscCPf+UmucXAULZ8pAAoJhbKJwNPJum3lA/60hSDe8IEm0kI9Er/ed4w
 Go9kTz+mSkdXgvCfqzdOEToj9RPwT1NwGWS5asfKivWnsC08W+pKxRI7MaiDJ+402tJk
 rayBCM9XF6YljuLXPU0snHAaBLsbnmT3qnBo1aQNQ9F/oV0f/1zSL1pPUM2tN6kit1Ae
 G0SFgrn0qiafZZQetUnglQkspxQ/dcW5a72p3DeQurah5ylpKEDqQSrm31uQrzF7xkAB
 fCaTSrUikB+bfYM+cWGQatgTGslyqqRfS4Q/LPbQtQWlqoUBOWJ3NlGE3Hz6Vcsi1D2I
 bI/A==
X-Gm-Message-State: AOJu0Ywr9Vz9cClHwn6qgFbKV/7M4pw8250qLC1KN40vVMecEYDAIi+0
 krUoyXkCCeoLIO6vfR0KezJ2h4dCg7dtYwkjehvOIG3ov4EQDPziOrVQGb2UhK23If54iO8eWhN
 4u4kfyWqN2LtQls+cbPbchE5OqP352xpApRZx08HiOf3GUocO/F7lKXKPkbOg0e0daOYNJN/ciF
 xlF6xdOFx1ETtSwwmdwUb9eyzLQD4/SNVzZRsu8rY=
X-Received: by 2002:a05:600c:4fd2:b0:431:15f1:421d with SMTP id
 5b1f17b1804b1-43158760531mr86106415e9.16.1729439606760; 
 Sun, 20 Oct 2024 08:53:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmGox0vj62zqitgOre88p3xDLd8okrdL2AqeKlrZ6EhYArjxRxCYi911G/mdA6dwOueiZzTA==
X-Received: by 2002:a05:600c:4fd2:b0:431:15f1:421d with SMTP id
 5b1f17b1804b1-43158760531mr86106225e9.16.1729439606288; 
 Sun, 20 Oct 2024 08:53:26 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5c2cb8sm27174105e9.31.2024.10.20.08.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:53:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 00/14] target/i386: miscellaneous flags improvements
Date: Sun, 20 Oct 2024 17:53:10 +0200
Message-ID: <20241020155324.35273-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This includes improved translation of checks, microoptimization of the
helpers, and improvements to the cc_op_* functions from Richard.

Unlike his original patches[1] I didn't convert cc_op_live() to a switch
statement, instead keeping the array but making sure that all of its
entries are nonzero.  The only zero entry was CC_OP_CLR, which is now
changed to spill the constant value of EFLAGS to cc_op_src.  While this
has a 0.2% cost in number of TCG ops, getting rid of the special
case for CC_OP_CLR makes it even easier to optimize computation of ZF
from CC_OP_DYNAMIC; this is quite common, for example in switch
statements that have CMP/JG/JE sequences (JE followed JL/JG/JA/JB seems
less common than the opposite, though that's not universal).

On a quick-and-dirty run of "ls -lR", the changes add ~750 spills of
0x44 to cc_op_src; but it also reduces to one half the calls to
cc_compute_all (most of them are completely eliminated), and that
is a lot more expensive.

One thing I noticed is that those spills are really huge (11 bytes).
It might help to move cc_* at the very beginning of CPUX86State, because
the number of accesses to cc_* is comparable to the number of accesses
to registers (despite cc_* being mostly written, while registers are
both read and written).

Thanks,

Paolo

[1] https://patchew.org/QEMU/20240701025115.1265117-1-richard.henderson@linaro.org/

Paolo Bonzini (10):
  target/i386: use tcg_gen_ext_tl when applicable
  target/i386: remove CC_OP_CLR
  target/i386: optimize computation of ZF from CC_OP_DYNAMIC
  target/i386: optimize TEST+Jxx sequences
  target/i386: add a few more trivial CCPrepare cases
  target/i386: add a note about gen_jcc1
  target/i386: make flag variables unsigned
  target/i386: use builtin popcnt or parity to compute PF, if available
  target/i386: use higher-precision arithmetic to compute CF
  target/i386: use + to put flags together

Richard Henderson (4):
  target/i386: Tidy cc_op_str usage
  target/i386: Rearrange CCOp
  target/i386: Introduce cc_op_size
  target/i386: Wrap cc_op_live with a validity check

 include/qemu/host-utils.h                |  16 +++
 target/i386/cpu.h                        |  33 ++++--
 target/i386/helper.h                     |   1 +
 target/i386/tcg/helper-tcg.h             |  12 +++
 target/i386/tcg/cc_helper_template.h.inc | 127 +++++++++++++++--------
 target/i386/cpu-dump.c                   |  18 ++--
 target/i386/tcg/cc_helper.c              |  25 ++++-
 target/i386/tcg/int_helper.c             |   4 +-
 target/i386/tcg/translate.c              | 103 ++++++++++++------
 target/i386/tcg/decode-new.c.inc         |   2 +-
 target/i386/tcg/emit.c.inc               |  24 ++---
 11 files changed, 249 insertions(+), 116 deletions(-)

-- 
2.46.2


