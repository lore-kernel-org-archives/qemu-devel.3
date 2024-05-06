Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9914CC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tQI-00032F-5l; Mon, 06 May 2024 04:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQF-00031X-MU
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQD-0002Cz-HZ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d1ZJHHCfk96sxWmEp0cJzO59VFHmKVO7tq5eTiukies=;
 b=YM4hhU+u2spNzNac07EIWsOR8fg3j0qiPmRKuQdoEYxCUICzH3pU2l3APpvTPfc/pohck5
 zwOzx5Wz2fu+ZRm0EFYLc/y0Fy4DrY+46feIJRj+Az1T78FrKX4MnvLosSb1oUYY4q4X/y
 yh7KyZPi9sl9RnzmskKbKUIwTPQkoy4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-hANB3wANOCCHjxTOFjrh8g-1; Mon, 06 May 2024 04:10:02 -0400
X-MC-Unique: hANB3wANOCCHjxTOFjrh8g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-572a203c05dso1058297a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983000; x=1715587800;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d1ZJHHCfk96sxWmEp0cJzO59VFHmKVO7tq5eTiukies=;
 b=ZDeIGDPFdMD019q0pPahRBPCUqXzYtk2CddaCGui0kvzajSIMNfKCQgrY5i8/FaXaK
 UmUXUjyVIokbei9o0ZgZSFh8hm2ljL0swFPgLnCHLisHpm64cZyy9Rsgu2TziK2UL8GW
 ji7GO9tjPQa79GhxKCS+zHaLCYfwZjthXB05SZGPdlQQ/sccxaAB72fxUP6p7q9ERnn7
 mBqu7uQ5dQ/TIEeUlJUL3YUP70cr7gddRXlz4viU6L5zPNG4yxU21OhrxI9E+Vp2H0Yn
 v3BPw0oUJ7GLyMtJz1wgMoA3hi+kPH671GQ5XPVzG+Z2FqhZhBTBxWmCoTOYHTP+IT1I
 Zskg==
X-Gm-Message-State: AOJu0YyJAbvj84MSy656+J4G6fj56Wipr5HPvhIGFESV1odyXtSngUuR
 1nyMfR52z4jegLHjNwsyTO0Ebz2OGZ6kBh99DTPMPdBNgoxd24ru0q24EXoXYLH/H6Cy4pjhkNg
 DKB2VNFFtyO5dZnIsK1ev0u3MrqQ4cm9zEyMamR+CHvk+CDpepX98bhMZfvKgLP9o2Ob7kGvN6I
 It4hgFS7nms3fnYgCwEDXZiktT4xdJl1CxT+Ba
X-Received: by 2002:aa7:c152:0:b0:572:e7ac:eeaf with SMTP id
 r18-20020aa7c152000000b00572e7aceeafmr3238552edp.19.1714983000435; 
 Mon, 06 May 2024 01:10:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXwULQWdN99obBDxf165HBnXRd1LK7W2SZw2kMY0khsbNpF7m02LstuA6/7YwAoM0ZusTDJg==
X-Received: by 2002:aa7:c152:0:b0:572:e7ac:eeaf with SMTP id
 r18-20020aa7c152000000b00572e7aceeafmr3238538edp.19.1714983000043; 
 Mon, 06 May 2024 01:10:00 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a056402074400b00572b2ad900fsm4823923edy.46.2024.05.06.01.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:09:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 00/25] target/i386: convert 1-byte opcodes to new decoder
Date: Mon,  6 May 2024 10:09:32 +0200
Message-ID: <20240506080957.10005-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This series includes changes to the x86 TCG decoder that switch the
1-byte opcodes to the table-driven decoder (except for x87).  A few
easy 2-byte opcodes are also converted (BSWAP, SETcc, CMOVcc,
MOVZX/MOVSX and those that are extensions of 1-byte opcodes like PUSH/POP
FS/GS, LFS/LGS/LSS).

After optimization, the generated code is generally similar to what
is produced by the old decoder, with some differences for 32-bit
multiplications and rotate operations (RCL/RCR, and ROL/ROR less so).

This reaches a point where prefix decoding is done entirely in the new
decoder; when the opcode is loaded, if needed it will defer to
translate.c for the actual translation of the instruction.

Quite surprisingly, even without removing this duplicate code the
patch remove more lines than it adds, even though the table-driven
translator is theoretically more verbose (1 line per entry in the tables
plus all the function declarations for group decoders and emitters).
This shows how much operand decoding is spread all over the place in
translate.c.

The main change from v1 is new changes to flag computation that
avoid using s->tmp0 and s->tmp4.  Of the changes to code generation,
it's probably worth pointing out 32-bit IMUL is now different for
32-bit and 64-bit hosts, and more efficient computation of flags
in gen_shift_dynamic_flags() via cc_op_live[].

I have a few more cleanup patches that drop ~150 lines of now
redundant translate.c code, but I'll send them separately.

Paolo

v1->v2:
- replaced "target/i386: do not use s->tmp0 and s->tmp4 to compute flags"
  with patches 4..10
- fixed compilation by moving I_unsigned to patch 15 ("target/i386:
  move 60-BF opcodes to new decoder")
- changed 3-operand IMUL to use sextT0
- fixed OUTS decoding
- changed ARPL to use the umax TCG op
- use 64-bit multiply for imull on 64-bit hosts
- use sari instead of negsetcondi(LT)
- make INS code more similar to IN
- fix compilation after "target/i386: generalize gen_movl_seg_T0"
- note that 0xD0-0xD3/6 is the undocumented SAL opcode
- move opcodes_grp3 and opcodes_grp4 inside group decoding functions
- rename decode_group4 to decode_group4_5
- put together all TCG_TARGET_* definitions in emit.c.inc
- as a result of the new flag patches, ensure that gen_op_jz_ecx()
  and gen_jmp_rel() are always preceded by gen_update_cc_op()
- do not generate temporaries until after all early return cases
- compute carry of rotation operations with extract instead of
  setcond(TSTNE)
- gen_shift_dynamic_flags() uses cc_op_live[] to generate movcond
  operations
- a few alignment changes to decoding tables and removals of TABs
  

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

 target/i386/helper.h                        |   11 -
 target/i386/tcg/decode-new.h                |   23 +-
 target/i386/tcg/shift_helper_template.h.inc |  108 -
 target/i386/tcg/int_helper.c                |   34 -
 target/i386/tcg/translate.c                 | 3780 ++++---------------
 target/i386/tcg/decode-new.c.inc            |  605 ++-
 target/i386/tcg/emit.c.inc                  | 1588 +++++++-
 7 files changed, 2961 insertions(+), 3188 deletions(-)
 delete mode 100644 target/i386/tcg/shift_helper_template.h.inc

-- 
2.45.0


