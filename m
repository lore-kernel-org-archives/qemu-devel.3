Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF08AD33997
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RWR-000877-Ch; Mon, 28 Oct 2024 11:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWN-00086H-QF
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWL-0000jA-BC
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f+qb/Nt30Wy0NVFSLyM5GNcFTQy4JjuWYxdZHUALuKc=;
 b=DiwjRTPSIt7yKu7R8osxqarIa25H9KS3T9x+9uVxjDnN/v0mQym2tKOAPiKojZyK9JJWy3
 apX8eCu1jfNGFK6rzPJovKIPjaVB0qvX9iNOTNaTWwSAN/MejvZV7AoWrNZ9gW5MHu94v/
 8IJVwhGv/Lo5wv1KrNQnDz0mDmSK43M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-OcyPPXwnPnCKYARXOTQ3-g-1; Mon, 28 Oct 2024 11:19:00 -0400
X-MC-Unique: OcyPPXwnPnCKYARXOTQ3-g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d52ccc50eso2146018f8f.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128739; x=1730733539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f+qb/Nt30Wy0NVFSLyM5GNcFTQy4JjuWYxdZHUALuKc=;
 b=FrZXgX40ElfaxfRibgfRL3C4A76W8zkYLKp8A6FuTUhUNjMWa+xk0lD/PQ+nrYU7dr
 DQ0ckhv4Gl7T+D4hOVuNULqf94kdYoX/IgWGOiAW4+NTkIINur4mSxfy18QH3djNfehP
 ZR4xymro88D/6qr3ZZ70DUDde6QkDEOPfIbQZtiGks9My/DTNgu5OxWrntnRGgL/l0iE
 hXX4gzF+g8FrNKtPreGywop/4Mrzk1bXkUA9PYpPic8HLngOHCDESpIs+MnhOqp0fq35
 VSGnTFSjCt4Kmb9PnYyD/BKrjAaa0hsqbsKs71LoBGCelz+ewlteKXwXYY7IDTUT6IU3
 B0tA==
X-Gm-Message-State: AOJu0Ywr4Ku8VFb8T2t1Rm2pjpLPTI2dIV3PLXOIYYJnJkrjOSet2ErB
 T2Fa2hM5Yr0J6uGSqskLstkkb5Y3aXCJUH15IsicbN8yBNh0c7jzfoAN8YCeaccI31uSiU5CpPw
 ISWz6RudJktxi/EVtxN0gik+dFJMndWxccFU5k7jP8Rzc2X2CMjMzktP+krzX1FShS2cyL22T9c
 ZIDCeMlOsiMphtrnu45DDipHKTfArl0hUchDUoIMo=
X-Received: by 2002:a5d:63cf:0:b0:37c:d57d:71cd with SMTP id
 ffacd0b85a97d-380611ff862mr6339952f8f.52.1730128738866; 
 Mon, 28 Oct 2024 08:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLEZd8Rs385xA5W4e7dbOXMCtxbv0SwiYPwtvD+ayo5duvS7V5d6oo1hEAtlg0AlPtDiRQqw==
X-Received: by 2002:a5d:63cf:0:b0:37c:d57d:71cd with SMTP id
 ffacd0b85a97d-380611ff862mr6339935f8f.52.1730128738440; 
 Mon, 28 Oct 2024 08:18:58 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058bac1cfsm9760961f8f.109.2024.10.28.08.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:18:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 00/14] target/i386: miscellaneous flags improvements
Date: Mon, 28 Oct 2024 16:18:37 +0100
Message-ID: <20241028151851.376355-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

v1->v2:
- use MAKE_64BIT_MASK in helper_cc_compute_nz
- get rid completely of parity_table

Paolo Bonzini (10):
  target/i386: use tcg_gen_ext_tl when applicable
  target/i386: remove CC_OP_CLR
  target/i386: optimize computation of ZF from CC_OP_DYNAMIC
  target/i386: optimize TEST+Jxx sequences
  target/i386: add a few more trivial CCPrepare cases
  target/i386: add a note about gen_jcc1
  target/i386: make flag variables unsigned
  target/i386: use compiler builtin to compute PF
  target/i386: use higher-precision arithmetic to compute CF
  target/i386: use + to put flags together

Richard Henderson (4):
  target/i386: Tidy cc_op_str usage
  target/i386: Rearrange CCOp
  target/i386: Introduce cc_op_size
  target/i386: Wrap cc_op_live with a validity check

 include/qemu/host-utils.h                |   9 ++
 target/i386/cpu.h                        |  33 ++++--
 target/i386/helper.h                     |   1 +
 target/i386/tcg/helper-tcg.h             |   6 +-
 target/i386/tcg/cc_helper_template.h.inc | 127 +++++++++++++++--------
 target/i386/cpu-dump.c                   |  18 ++--
 target/i386/tcg/cc_helper.c              |  51 +++------
 target/i386/tcg/int_helper.c             |   4 +-
 target/i386/tcg/translate.c              | 103 ++++++++++++------
 target/i386/tcg/decode-new.c.inc         |   2 +-
 target/i386/tcg/emit.c.inc               |  24 ++---
 11 files changed, 226 insertions(+), 152 deletions(-)

-- 
2.47.0


