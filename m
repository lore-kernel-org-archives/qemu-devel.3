Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EF4C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEZk-0000LQ-JN; Tue, 09 Apr 2024 12:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZP-0000G4-VV
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZI-00080K-Dl
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7MXoKI1EtyYxWdzpRvocyeuLkjfE39oz0097aVben0w=;
 b=h+wmrMPrtjSh6kFZqBJJYknv2tqvkd/x9qaZTROFEK+TM/VwdMYC+A7Mn5Phwc8xxtTxa5
 RbLh0L4jLippV/4yKPVvOJi6qJ2dtHbQFQv7krZmLQu/clA1zIr0mmOziHgWDGdYi9I+WT
 tT0rL5bquZv0GDykqkN+cXeklxU1b4g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-S9SP_5GGPResI9ttnhfh3A-1; Tue, 09 Apr 2024 12:43:27 -0400
X-MC-Unique: S9SP_5GGPResI9ttnhfh3A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4162b9b1702so27022685e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681005; x=1713285805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7MXoKI1EtyYxWdzpRvocyeuLkjfE39oz0097aVben0w=;
 b=Qv3D3I0ArKr1AWwBHubvSun1xGFPvZgZXdVtvRiETYFfCsC7jkC6AoDaJLz+SDBvwC
 N866ISmWWWoCChPjTanLfT4MDtrx/pcyT0ryyFx8HNIMEGgZ2QTt0ATq3ALVo2C2hwSY
 TD4kK0hRh2JsyUCC2Iou6gvbLjPunU68hUwdXuErv5bdKMRtoO88G5JI/saQhy5srtBq
 TLfi9CLb3TcPy6HeNMu7AN3zJIdIrLEiPVx1pany4PKqGbpjZb1DjhaJpR9H6EcpJ6fa
 VuuGBC+mR2uts99nCisj2EHlfWIZMJ+Zli/LgkZ00p/HBzjfePWcbsDYMmQdRC9qSagc
 PdsA==
X-Gm-Message-State: AOJu0YybmH5g5k8LFOcyPD6oqEPePg/vz3Wvi4lpc2riv101cgCffz8P
 pz752swORiPEWHCrFbsfFg77O4qcpMopB/2wwWF/Mbynf4Gddc3NpD0N6IpW7WlzUIOQI+f3q9j
 JLhISpJu+r1QHapMHyIFtUXGTpdtYql4qb2AtYwFwClxJ6ILbZOIla8KQchhLqs54gMZXFhaJN4
 brZe/Kb2zJff3mC1IJnw4zyEgFDXP1cUBdlNSL
X-Received: by 2002:a05:600c:1c95:b0:415:6afd:9ba6 with SMTP id
 k21-20020a05600c1c9500b004156afd9ba6mr240407wms.1.1712681005649; 
 Tue, 09 Apr 2024 09:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIuglKPjJHZcRbvoAI316+8le7T1P7fX1nhOsSTpmRdVVinuCQjIWT1DfBms401SIBgOn9Cw==
X-Received: by 2002:a05:600c:1c95:b0:415:6afd:9ba6 with SMTP id
 k21-20020a05600c1c9500b004156afd9ba6mr240372wms.1.1712681005078; 
 Tue, 09 Apr 2024 09:43:25 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 t29-20020adfa2dd000000b003462fec9f5asm1660127wra.62.2024.04.09.09.43.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:43:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 00/19] target/i386: convert 1-byte opcodes to new
 decoder
Date: Tue,  9 Apr 2024 18:43:04 +0200
Message-ID: <20240409164323.776660-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
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
This shows how operand decoding is spread all over the place in
translate.c.

These have been ready for a few months; now that it seems clearer that
issue 2092 is a generic problem with vhost-user, it is time to get
this upstream.

Paolo

Based-on: <20240406223248.502699-1-richard.henderson@linaro.org>


Paolo Bonzini (19):
  target/i386: use TSTEQ/TSTNE to test low bits
  target/i386: use TSTEQ/TSTNE to check flags
  target/i386: remove mask from CCPrepare
  target/i386: do not use s->tmp0 and s->tmp4 to compute flags
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

 include/tcg/tcg.h                           |    6 +
 target/i386/helper.h                        |   11 -
 target/i386/tcg/decode-new.h                |   23 +-
 target/i386/tcg/shift_helper_template.h.inc |  108 -
 target/i386/tcg/int_helper.c                |   34 -
 target/i386/tcg/translate.c                 | 3717 ++++---------------
 target/i386/tcg/decode-new.c.inc            |  602 ++-
 target/i386/tcg/emit.c.inc                  | 1560 +++++++-
 8 files changed, 2914 insertions(+), 3147 deletions(-)
 delete mode 100644 target/i386/tcg/shift_helper_template.h.inc

-- 
2.44.0


